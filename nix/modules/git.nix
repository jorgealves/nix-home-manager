{ ... }:

{

  programs.git-cliff = {
    enable = true;
  };
  programs.lazygit.enable = true;
  programs.git = {
    enable = true;
    lfs = {
      enable = true;
    };
    userEmail = "jorgeandrealves@gmail.com";
    userName = "Jorge Alves";
    signing.key = "~/.ssh/id_signing";
    diff-highlight.enable = true;
    aliases = {
      logg = "log --oneline --graph --decorate";
      gst = "status";
    };
    signing.signByDefault = true;
    includes = [
      {
        path = "~/.gitconfig_dvt";
        condition = "gitdir:~/projects/devoteam/**";
      }
      {
        path = "~/.gitconfig_wrt";
        condition = "gitdir:~/projects/worten/**";
      }
    ];
    extraConfig = {
      core = {
        editor = "nvim";
        excludesFile = "~/.gitignore_global";
      };
      safe = {
        directory = "~/projects";
      };
      init = {
        defaultBranch = "main";
      };
      help = {
        autocorrect = "prompt";
      };
      gpg = {
        format = "ssh";
      };
      blame = {
        coloring = "highlightRecent";
      };
      grep = {
        lineNumber = true;
      };
      commit = {
        gpgSigning = true;
      };

    };
  };
}
