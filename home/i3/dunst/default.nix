{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "DejaVu Sans 11";
        markup = "full";
        format = "<b>%s</b>\\n%b";
        sort = "yes";
        indicate_hidden = "yes";
        alignment = "left";
        bounce_freq = 0;
        show_age_threshold = 60;
        word_wrap = "yes";
        ignore_newline = "no";
        geometry = "300x5-30+20";
        transparency = 15;
        idle_threshold = 120;
        monitor = 0;
        follow = "mouse";
        sticky_history = "yes";
        line_height = 0;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        separator_color = "frame";
        startup_notification = false;
        frame_width = 3;
        frame_color = "#aaaaaa";
      };

      urgency_low = {
        background = "#222222";
        foreground = "#888888";
        timeout = 10;
      };

      urgency_normal = {
        background = "#285577";
        foreground = "#ffffff";
        timeout = 10;
      };

      urgency_critical = {
        background = "#900000";
        foreground = "#ffffff";
        frame_color = "#ff0000";
        timeout = 0;
      };
    };
  };
}
