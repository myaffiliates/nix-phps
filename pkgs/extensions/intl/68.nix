{
  stdenv,
  pkgs,
  prev
}:

let
  version = "68.2";

  hashes = {
    "x86_64-linux" = {
      system = "amd64";
      hash = {          
        "8.1" = "sha256-93eLAfBGVg0XdtiFxuZfFwWPoTHtXyAgM3tLzDrhGDM=";
        "8.2" = "sha256-";
        "8.3" = "sha256-";
        "8.4" = "sha256-";
      };
    };
 };

  makeSource = { system, phpMajor }:
    pkgs.fetchurl { 
      url = "https://github.com/shivammathur/icu-intl/releases/download/intl/php${phpMajor}-intl-${version}.so";
      hash = hashes.${system}.hash.${phpMajor} or (throw "php.extensions.intl unsupported on PHP ${phpMajor} on ${system}");
    };
in
prev.extensions.intl.overrideAttrs (attrs: {
  inherit version;

  src = makeSource {
    system = stdenv.hostPlatform.system;
    phpMajor = pkgs.lib.versions.majorMinor prev.php.version;
  };
})