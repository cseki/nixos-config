{ config, pkgs, ... }:
let
  username = "cseh";
  homeDirectory = "/home/${username}";

  commonPkgs = with pkgs; [
    arandr     # GUI for xrandr
    #dmenu      # application launcher
    tree
    gnumake
    google-cloud-sdk
  ];

  gitPkgs = with pkgs; [
    diff-so-fancy
  ];

in


{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    inherit username homeDirectory;
    stateVersion = "22.05";

    packages = commonPkgs ++ gitPkgs;
  };

  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bat.enable = true;

 
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "fzf"];
    };
    initExtra = ''
      [[ ! -f ./.p10k.zsh ]] || source ./.p10k.zsh
    '';
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };
}
