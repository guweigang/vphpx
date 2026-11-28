--TEST--
TOML extension INI entries retain values, access modes and legacy declarations
--SKIPIF--
<?php if (!extension_loaded('vphptest')) print 'skip'; ?>
--FILE--
<?php
$all = ini_get_all('vphptest');
echo 'legacy=', ini_get('vphptest.max_threads'), "\n";
echo 'system=', ini_get('vphptest.system_limit'), ':', $all['vphptest.system_limit']['access'], "\n";
echo 'escaped=', bin2hex(ini_get('vphptest.escaped')), ':', $all['vphptest.escaped']['access'], "\n";
var_dump(ini_set('vphptest.system_limit', '99'));
echo 'user-before=', ini_set('vphptest.escaped', 'changed'), "\n";
echo 'user-after=', ini_get('vphptest.escaped'), "\n";
?>
--EXPECT--
legacy=4
system=12:4
escaped=71756f74653a20223b20736c6173683a205c3b206e65776c696e653a0ae99baa:1
bool(false)
user-before=quote: "; slash: \; newline:
雪
user-after=changed
