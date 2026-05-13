{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.yazi.settings = {
    opener = {
      edit = [
        {
          run = "\${EDITOR:-vi} %s";
          desc = "$EDITOR";
          block = true;
          for = "unix";
        }
        {
          run = "code %s";
          desc = "code";
          orphan = true;
          for = "windows";
        }
        {
          run = "code -w %s";
          desc = "code (block)";
          block = true;
          for = "windows";
        }
      ];

      play = [
        {
          run = "xdg-open %s1";
          desc = "Play";
          for = "linux";
          orphan = true;
        }
        {
          run = "open %s";
          desc = "Play";
          for = "macos";
        }
        {
          run = "start \"\" %s1";
          desc = "Play";
          for = "windows";
          orphan = true;
        }
        {
          run = "termux-open %s1";
          desc = "Play";
          for = "android";
        }
        {
          run = "mediainfo %s1; echo \"Press enter to exit\"; read _";
          desc = "Show media info";
          block = true;
          for = "unix";
        }
      ];

      open = [
        {
          run = "xdg-open %s1";
          desc = "Open";
          for = "linux";
        }
        {
          run = "open %s";
          desc = "Open";
          for = "macos";
        }
        {
          run = "start \"\" %s1";
          desc = "Open";
          for = "windows";
          orphan = true;
        }
        {
          run = "termux-open %s1";
          desc = "Open";
          for = "android";
        }
      ];

      reveal = [
        {
          run = "xdg-open %d1";
          desc = "Reveal";
          for = "linux";
        }
        {
          run = "open -R %s1";
          desc = "Reveal";
          for = "macos";
        }
        {
          run = "explorer /select,%s1";
          desc = "Reveal";
          for = "windows";
          orphan = true;
        }
        {
          run = "termux-open %d1";
          desc = "Reveal";
          for = "android";
        }
        {
          run = "clear; exiftool %s1; echo \"Press enter to exit\"; read _";
          desc = "Show EXIF";
          block = true;
          for = "unix";
        }
      ];

      extract = [
        {
          run = "ya pub extract --list %s";
          desc = "Extract here";
        }
      ];

      download = [
        {
          run = "ya emit download --open %S";
          desc = "Download and open";
        }
        {
          run = "ya emit download %S";
          desc = "Download";
        }
      ];
    };

    open.rules = [
      {
        url = "*/";
        use = ["open" "reveal"];
      }
      {
        mime = "text/*";
        use = ["edit" "open" "reveal"];
      }
      {
        mime = "image/*";
        use = ["open" "reveal"];
      }
      {
        mime = "{audio,video}/*";
        use = ["play" "reveal"];
      }
      {
        mime = "application/{json,ndjson,javascript,wine-extension-ini,mbox}";
        use = ["edit" "open" "reveal"];
      }
      {
        mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}";
        use = ["extract" "reveal"];
      }
      {
        mime = "inode/empty";
        use = ["edit" "reveal"];
      }
      {
        mime = "vfs/{absent,stale}";
        use = "download";
      }
      {
        url = "*";
        use = ["open" "reveal"];
      }
    ];
  };
}
