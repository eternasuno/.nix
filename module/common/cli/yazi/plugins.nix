{
  pkgs,
  vars,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.yazi = {
    plugins = {
      full-border = pkgs.yaziPlugins.full-border;
      git = pkgs.yaziPlugins.git;
      lazygit = pkgs.yaziPlugins.lazygit;
      smart-enter = pkgs.yaziPlugins.smart-enter;
    };

    initLua = ''
      require("full-border"):setup()
      require("git"):setup()
      require("smart-enter"):setup({
        open_multi = true,
      })
    '';

    settings.plugin = {
      fetchers = [
        {
          id = "mime-dir";
          url = "*/";
          run = "mime.dir";
          prio = "high";
          group = "mime";
        }
        {
          id = "mime-local";
          url = "local://*";
          run = "mime.local";
          prio = "high";
          group = "mime";
        }
        {
          id = "mime-remote";
          url = "remote://*";
          run = "mime.remote";
          prio = "high";
          group = "mime";
        }
      ];

      spotters = [
        {
          mime = "multi/*";
          run = "multi";
        }
        {
          url = "*/";
          run = "folder";
        }
        {
          mime = "text/*";
          run = "code";
        }
        {
          mime = "application/{mbox,javascript,wine-extension-ini}";
          run = "code";
        }
        {
          mime = "image/{avif,hei?,jxl}";
          run = "magick";
        }
        {
          mime = "image/svg+xml";
          run = "svg";
        }
        {
          mime = "image/*";
          run = "image";
        }
        {
          mime = "video/*";
          run = "video";
        }
        {
          mime = "vfs/*";
          run = "vfs";
        }
        {
          mime = "null/*";
          run = "null";
        }
        {
          url = "*";
          run = "file";
        }
      ];

      preloaders = [
        {
          mime = "image/{avif,hei?,jxl}";
          run = "magick";
        }
        {
          mime = "image/svg+xml";
          run = "svg";
        }
        {
          mime = "image/*";
          run = "image";
        }
        {
          mime = "video/*";
          run = "video";
        }
        {
          mime = "application/pdf";
          run = "pdf";
        }
        {
          mime = "font/*";
          run = "font";
        }
        {
          mime = "application/ms-opentype";
          run = "font";
        }
      ];

      previewers = [
        {
          url = "*/";
          run = "folder";
        }
        {
          mime = "text/*";
          run = "code";
        }
        {
          mime = "application/{mbox,javascript,wine-extension-ini}";
          run = "code";
        }
        {
          mime = "application/{json,ndjson}";
          run = "json";
        }
        {
          mime = "image/{avif,hei?,jxl}";
          run = "magick";
        }
        {
          mime = "image/svg+xml";
          run = "svg";
        }
        {
          mime = "image/*";
          run = "image";
        }
        {
          mime = "video/*";
          run = "video";
        }
        {
          mime = "application/pdf";
          run = "pdf";
        }
        {
          mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}";
          run = "archive";
        }
        {
          mime = "application/{debian*-package,redhat-package-manager,rpm,android.package-archive}";
          run = "archive";
        }
        {
          url = "*.{AppImage,appimage}";
          run = "archive";
        }
        {
          mime = "application/{iso9660-image,qemu-disk,ms-wim,apple-diskimage}";
          run = "archive";
        }
        {
          mime = "application/virtualbox-{vhd,vhdx}";
          run = "archive";
        }
        {
          url = "*.{img,fat,ext,ext2,ext3,ext4,squashfs,ntfs,hfs,hfsx}";
          run = "archive";
        }
        {
          mime = "font/*";
          run = "font";
        }
        {
          mime = "application/ms-opentype";
          run = "font";
        }
        {
          mime = "inode/empty";
          run = "empty";
        }
        {
          mime = "vfs/*";
          run = "vfs";
        }
        {
          mime = "null/*";
          run = "null";
        }
        {
          url = "*";
          run = "file";
        }
      ];

      prepend_fetchers = [
        {
          id = "git";
          url = "*";
          run = "git";
        }
        {
          id = "git";
          url = "*/";
          run = "git";
        }
      ];
    };
  };
}
