# nix-config — WSL

Detta repo innehåller en enkel startkonfiguration för att använda Home Manager i WSL via flakes.

Snabbguide (inifrån WSL):

1. Installera Nix om du inte redan gjort det (rekommenderas med multi-user/daemon):

   sh <(curl -L https://nixos.org/nix/install) --daemon

2. Aktivera flakes experimentellt (lägg till i /etc/nix/nix.conf eller ~/.config/nix/nix.conf):

   experimental-features = nix-command flakes

3. Byt till repo-mappen och applicera home-manager konfigurationen:

   nix build .#homeConfigurations.wsl.activationPackage
   ./result/activate

4. Anpassa hosts/wsl.nix (särskilt home.username och home.homeDirectory) för att passa din användare.

Tips för WSL:
- Om du använder GUI-applikationer, se till att DISPLAY är satt (t.ex. via `export DISPLAY=$(grep -m1 nameserver /etc/resolv.conf | awk '{print $2}'):0`).
- För systemd-stöd kan du använda wsl-systemd eller en nyare WSL-kärna med systemd.
