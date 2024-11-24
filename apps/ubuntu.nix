{ pkgs, ... }:
{
  home.sessionVariables = {
    GTK_THEME = "Adwaita-dark";
    XCURSOR_THEME = "DMZ-Black";
    QA_QPA_PLATFORMTHEME = "gtk2";
    CLUTTER_BACKEND = "wayland";
  };
  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        end_of_line = "lf";
        insert_final_newline = true;
      };
      "*.{js,py}" = {
        charset = "utf-8";
      };
      "*.py" = {
        indent_style = "space";
        indent_size = 4;
      };
    };
  };
  gtk = {
    enable = true;
    font.name = "Fira Code Nerdfont";
    font.package = pkgs.fira-code-nerdfont;
    font.size = 12;
  };
  qt = {
    enable = true;
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  xdg = {
    enable = true;
  };
  programs.autorandr.enable = true;
  # programs.ssh.enable = true;

}
