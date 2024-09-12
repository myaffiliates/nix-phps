{
  buildPecl,
  lib,
  php,
  fetchurl,
}:

buildPecl {
  version = "5.3.7";
  pname = "redis";

  src = fetchurl {
    url = "http://pecl.php.net/get/redis-5.3.7.tgz";
    hash = "sha256-b958166ccda4f40bd17c6998f9e2239021ae644467c=";
  };

  internalDeps = [ php.extensions.session ];

  meta = {
    description = "PHP extension for interfacing with Redis";
    license = lib.licenses.php301;
    platforms = lib.platforms.unix;
    homepage = "https://github.com/phpredis/phpredis/";
    maintainers = lib.teams.php.members;
  };
}