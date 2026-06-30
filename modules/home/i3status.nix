{
  self,
  config,
  host,
  ...
}:

let
  mappingsPath = self + "/hosts/${host}/mappings.nix";
in
{
  programs.i3status-rust = {
    enable = true;

    bars = {
      default = {
        blocks = [
          {
            block = "music";
            format = " $icon {$combo.str(max_w:25,rot_interval:0.5) $play |}";

            interface_name_exclude = [
              ".*kdeconnect"
              "mpd"
            ];
          }
          {
            block = "sound";
            format = " $icon {$volume [$output_name]|[$output_name]} ";

            mappings = if builtins.pathExists mappingsPath then import mappingsPath else { };
          }
          {
            block = "net";
            format = " $icon {$ip [$ssid]|Wired connection} via $device ";
          }
          {
            block = "net";
            format = " IN $speed_down.eng(prefix:K) OUT $speed_up.eng(prefix:K) ";
          }
          {
            block = "memory";
            format = " $icon $mem_used.eng(p:Gi)/$mem_total.eng(p:Gi) ($mem_used_percents.eng(w:2)) ";
            format_alt = " $icon_swap $swap_used.eng(p:Gi)/$swap_total.eng(p:Gi) ($swap_used_percents.eng(w:2)) ";
          }
          {
            block = "cpu";
          }
          {
            block = "time";
            format = " $timestamp.datetime(f:'%Y-%m-%d %H:%M:%S') ";
            interval = 1;
          }
        ];

        settings = {
          theme = {
            theme = "plain";

            overrides = with config.colorScheme.palette; {
              idle_bg = "#${base00}";
              idle_fg = "#${base05}";
              info_bg = "#${base09}";
              info_fg = "#${base00}";
              good_bg = "#${base01}";
              good_fg = "#${base05}";
              warning_bg = "#${base0A}";
              warning_fg = "#${base00}";
              critical_bg = "#${base08}";
              critical_fg = "#${base00}";
              separator_bg = "#${base00}";
              separator_fg = "#${base05}";
            };
          };
        };
      };
    };
  };
}
