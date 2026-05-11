{ pkgs, lib, ... }:

{
  home.stateVersion = "24.11";

  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.packages = with pkgs; [
    ripgrep
    fzf
    jq
    htop
    wget
    curl
    neovim
    eza
    lazygit
    zoxide
    opencode
    tmux
    go
    nodejs
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    history = {
      size = 50000;
      save = 50000;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };

    shellAliases = {
      vim = "nvim";
      lg = "lazygit";
      ls = "eza";
      ll = "eza -la";
      dps = "docker ps";
      dti = "docker exec -ti";
      g = "git";
      gst = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gd = "git diff";
      gco = "git checkout";
      gl = "git log --oneline -20";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    initContent = lib.mkMerge [
      (lib.mkBefore ''
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '')
      ''
        bindkey -e
        zstyle ':completion:*' menu select
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

        bindkey -r '^T'
        bindkey -s '^T' 'cd $(find ~/code -mindepth 1 -maxdepth 3 -type d | fzf)\n'

        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      ''
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".p10k.zsh".source = ./configs/p10k.zsh;
  home.file.".tmux.conf".source = ./configs/tmux.conf;
  home.file.".config/ghostty/config".source = ./configs/ghostty-config;

  home.activation.installFonts = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p "$HOME/Library/Fonts"
    run cp -f ${./fonts/LigaPragmataProMonoNerdFontPropo-Regular.ttf} "$HOME/Library/Fonts/LigaPragmataProMonoNerdFontPropo-Regular.ttf"
    run chmod 644 "$HOME/Library/Fonts/LigaPragmataProMonoNerdFontPropo-Regular.ttf"
  '';

  programs.home-manager.enable = true;
}
