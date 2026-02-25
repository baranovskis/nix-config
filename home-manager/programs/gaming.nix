{...}: {
  programs.mangohud = {
    enable = true;
    enableSessionWide = false;
    settings = {
      fps_limit = 0;
      gpu_stats = true;
      gpu_temp = true;
      gpu_power = true;
      cpu_stats = true;
      cpu_temp = true;
      ram = true;
      vram = true;
      fps = true;
      frametime = true;
      frame_timing = true;
      vulkan_driver = true;
      wine = true;
      gamemode = true;
      font_size = 20;
      position = "top-left";
      background_alpha = "0.3";
      round_corners = 8;
      toggle_hud = "Shift_R+F12";
      no_display = true;
    };
  };
}
