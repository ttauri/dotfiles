{ pkgs, ... }:

{
  home.username = "Mikhail.Kuznetsov";
  home.homeDirectory = "/Users/Mikhail.Kuznetsov";

  home.sessionPath = [
    "/Users/Mikhail.Kuznetsov/.lmstudio/bin"
  ];

  programs.git = {
    enable = true;
    settings.user.name = "Mikhail Kuznetsov";
    settings.user.email = "mikhail.kuznetsov@acronis.com";
  };
}
