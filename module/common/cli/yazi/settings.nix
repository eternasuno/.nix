{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.yazi.settings = {
    manager = {
      ratio = [1 4 3];
      sort_by = "alphabetical";
      sort_sensitive = false;
      sort_reverse = false;
      sort_dir_first = true;
      sort_translit = false;
      sort_fallback = "alphabetical";
      linemode = "none";
      show_hidden = false;
      show_symlink = true;
      scrolloff = 5;
      mouse_events = ["click" "scroll" "drag"];
    };

    preview = {
      wrap = "no";
      tab_size = 2;
      max_width = 600;
      max_height = 900;
      cache_dir = "";
      image_delay = 30;
      image_filter = "triangle";
      image_quality = 75;
      ueberzug_scale = 1;
      ueberzug_offset = [0 0 0 0];
    };

    tasks = {
      file_workers = 3;
      plugin_workers = 5;
      fetch_workers = 5;
      preload_workers = 2;
      process_workers = 5;
      bizarre_retry = 3;
      image_alloc = 536870912;
      image_bound = [10000 10000];
      suppress_preload = false;
    };

    input = {
      cursor_blink = false;
      cd_title = "Change directory:";
      cd_origin = "top-center";
      cd_offset = [0 2 50 3];
      create_title = ["Create:" "Create (dir):"];
      create_origin = "top-center";
      create_offset = [0 2 50 3];
      rename_title = "Rename:";
      rename_origin = "hovered";
      rename_offset = [0 1 50 3];
      filter_title = "Filter:";
      filter_origin = "top-center";
      filter_offset = [0 2 50 3];
      find_title = ["Find next:" "Find previous:"];
      find_origin = "top-center";
      find_offset = [0 2 50 3];
      search_title = "Search via {n}:";
      search_origin = "top-center";
      search_offset = [0 2 50 3];
      shell_title = ["Shell:" "Shell (block):"];
      shell_origin = "top-center";
      shell_offset = [0 2 50 3];
    };

    confirm = {
      trash_title = "Trash {n} selected file{s}?";
      trash_origin = "center";
      trash_offset = [0 0 70 20];
      delete_title = "Permanently delete {n} selected file{s}?";
      delete_origin = "center";
      delete_offset = [0 0 70 20];
      overwrite_title = "Overwrite file?";
      overwrite_body = "Will overwrite the following file:";
      overwrite_origin = "center";
      overwrite_offset = [0 0 50 15];
      quit_title = "Quit?";
      quit_body = "There are unfinished tasks, quit anyway?\n(Open task manager with default key 'w')";
      quit_origin = "center";
      quit_offset = [0 0 50 15];
    };

    pick = {
      open_title = "Open with:";
      open_origin = "hovered";
      open_offset = [0 1 50 7];
    };

    which = {
      sort_by = "none";
      sort_sensitive = false;
      sort_reverse = false;
      sort_translit = false;
    };
  };
}
