{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.programs.nautilus;

  bookmarkType = lib.types.submodule {
    options = {
      path = lib.mkOption {
        type = lib.types.str;
        description = "Absolute path for the bookmark";
        example = "/home/user/Documents";
      };

      name = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        description = "Display name for the bookmark. If null, uses the directory basename.";
        default = null;
        example = "📁 Documents";
      };
    };
  };

  mkBookmarkLine =
    bookmark:
    let
      basename = builtins.baseNameOf bookmark.path;
      displayName = if bookmark.name != null then bookmark.name else basename;
    in
    if displayName == basename then
      "file://${bookmark.path}"
    else
      "file://${bookmark.path} ${displayName}";

  bookmarksContent = lib.concatMapStringsSep "\n" mkBookmarkLine cfg.bookmarks;

  mkIconSetCommand =
    path: iconName:
    let
      gio = "${pkgs.glib}/bin/gio";
    in
    ''[[ -d ${path} ]] && ${gio} set ${path} metadata::custom-icon-name "${iconName}" || true'';

  iconCommands = lib.concatStringsSep "\n" (lib.mapAttrsToList mkIconSetCommand cfg.folderIcons);
in
{
  options.programs.nautilus = {
    enable = lib.mkEnableOption "Nautilus file manager configuration";

    bookmarks = lib.mkOption {
      type = lib.types.listOf bookmarkType;
      default = [ ];
      description = "List of GTK bookmarks to show in the Nautilus sidebar";
    };

    folderIcons = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description = ''
        Mapping of folder paths to custom icon names.
        Icons are set via GIO metadata, using theme-aware icon names.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."gtk-3.0/bookmarks" = lib.mkIf (cfg.bookmarks != [ ]) {
      text = bookmarksContent;
    };

    home.activation.setNautilusFolderIcons = lib.mkIf (cfg.folderIcons != { }) (
      lib.hm.dag.entryAfter [ "writeBoundary" ] iconCommands
    );
  };
}
