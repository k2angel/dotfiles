# https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/networking/atticd.nix

{ self, pkgs, ... }:

let
  atticadmShim = pkgs.writeShellScript "atticadm" ''
    if [ -n "$ATTICADM_PWD" ]; then
      cd "$ATTICADM_PWD"
      if [ "$?" != "0" ]; then
        >&2 echo "Warning: Failed to change directory to $ATTICADM_PWD"
      fi
    fi

    exec ${pkgs.attic-server}/bin/atticadm \
      -f /etc/atticd/server.toml \
      "$@"
  '';

  atticadmWrapper = pkgs.writeShellScriptBin "atticd-atticadm" ''
    exec systemd-run \
      --quiet \
      --pipe \
      --pty \
      --same-dir \
      --wait \
      --collect \
      --service-type=exec \
      --property=EnvironmentFile=/etc/atticd/environment \
      --property=DynamicUser=yes \
      --property=User=atticd \
      --property=Environment=ATTICADM_PWD=$(pwd) \
      --working-directory / \
      -- \
      ${atticadmShim} "$@"
  '';
in
{
  imports = [ (self + /modules/features/attic-watch-store.nix) ];

  home.packages = [
    pkgs.attic-server
    pkgs.attic-client
    atticadmWrapper
  ];
}
