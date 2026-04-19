{ ... }:

{
  programs.beets = {
    enable = true;

    settings = {
      color = true;
      per_disc_numbering = true;
      directory = "~/Music/Library";
      library = "~/Music/library.db";
      plugins = "musicbrainz mbsync fetchart inline info replaygain";

      item_fields = {
        album_artist = "f\"{albumartist}\" if albumartist else \"Unknown Artist\"";
        disc_and_track = "f\"{disc}-{track:02d}\" if disc else f\"{track:02d}\"";

        formatted_date = ''
          if year and month and day:
            return f"{year:04d}-{month:02d}-{day:02d}"
          elif year:
            return year
          else:
            return "Unknown Year"
        '';
      };

      replaygain = {
        backend = "gstreamer";
        overwrite = true;
      };

      import = {
        copy = true;
        move = false;
        write = true;
        autotag = true;
      };

      paths = {
        default = "$album_artist/($formatted_date) $album/$disc_and_track. $title";
        singleton = "$album_artist/($formatted_date) $album/$disc_and_track. $title";
        comp = "$album_artist/($formatted_date) $album/$disc_and_track. $title";
      };
    };
  };
}
