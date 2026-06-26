{ config, pkgs, zen-browser, ... }:

{
  home.username = "axel";
  home.homeDirectory = "/home/axel";
  home.stateVersion = "26.05";

  # ── Git ──────────────────────────────────────────────────────────────────────

  programs.git.enable = true;

  # ── Shell ────────────────────────────────────────────────────────────────────

  programs.zsh = {
    enable = true;
    initContent = ''
      # Carica la tua configurazione portatile
      if [ -f ~/.zshrc.portable ]; then
        source ~/.zshrc.portable
      fi
    '';
  };

  programs.bash = {
    enable = true;

    # Avvia Sway automaticamente quando fai login sul TTY1
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
        exec sway
      fi
    '';

    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/Projects/Dotfiles/nixos-dotfiles#ZeNix";
      nrb = "sudo nixos-rebuild boot --flake ~/Projects/Dotfiles/nixos-dotfiles#ZeNix";
      ngc = "sudo nix-collect-garbage -d";

      l = "ls";
      ll = "ls -l";
      la = "ls -la";
    };
  };

  # -- Fzf ----------------------------------------------------------------------

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # ── Variabili d'ambiente Wayland ─────────────────────────────────────────────

  home.sessionVariables = {
    NIXOS_OZONE_WL  = "1";           # abilita Wayland nativo per app Electron (es. VSCode)
    MOZ_ENABLE_WAYLAND = "1";        # forza Firefox/Zen su Wayland invece di XWayland
    QT_QPA_PLATFORM = "wayland";     # forza le app Qt su Wayland
    SDL_VIDEODRIVER = "wayland";     # forza SDL su Wayland (videogiochi ecc.)
    _JAVA_AWT_WM_NONREPARENTING = "1"; # fix per app Java (es. IntelliJ) in WM non-reparenting
    EDITOR = "hx";                   # imposta helix come editor di default
    SHELL = "${pkgs.zsh}/bin/zsh";   # imposta zsh come shell di default per la sessione
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = 20;             # applicazione corretta cursore
  };

  # ── Tema e Aspetto ──────────────────────────────────────────────────────────

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };

  home.pointerCursor = {
    gtk.enable = true;
    sway.enable = true;

    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 20;
  };

  # -- Software per utente -----------------------------------------------------

  home.packages = with pkgs; [
    # Uso generale del sistema
    zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    kitty
    helix
    swaybg
    swaylock
    swayidle
    swayimg
    waybar
    bemenu
    grim
    slurp
    wl-clipboard
    unzip
    wallust
    fastfetch
    btop
    pcmanfm
    gnupg
    pass
    pinentry-curses
    openssl
    obsidian
    lazygit
    spotify
    fzf
    nil # per nix
    typst
    pandoc
  ];
}
