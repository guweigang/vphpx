--TEST--
test_option: V Option (?) → PHP null bridging
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php

// === 1. Instance method: ?string (found + not found) ===
echo "=== find (?string) ===\n";
$f = new Finder(3, "apple", "banana", "cherry");
var_dump($f->find("ban"));     // "banana"
var_dump($f->find("xyz"));     // NULL

// === 2. Instance method: ?int (found + not found) ===
echo "\n=== index_of (?int) ===\n";
var_dump($f->index_of("cherry"));  // 2
var_dump($f->index_of("grape"));   // NULL

// === 3. Instance method: ?bool (has value + none) ===
echo "\n=== has_match (?bool) ===\n";
var_dump($f->has_match("app"));    // true
var_dump($f->has_match("xyz"));    // false

$empty = new Finder(0);
var_dump($empty->has_match("any"));  // NULL (empty items → none)

// === 4. Static method: ?int (success + none) ===
echo "\n=== try_parse_int (?int) ===\n";
var_dump(Finder::try_parse_int("42"));   // 42
var_dump(Finder::try_parse_int("0"));    // 0
var_dump(Finder::try_parse_int(""));     // NULL
var_dump(Finder::try_parse_int("abc"));  // NULL

// === 5. Global function: ?string (success + none) ===
echo "\n=== v_find_after (?string) ===\n";
var_dump(v_find_after("hello world", "hello "));  // "world"
var_dump(v_find_after("hello world", "xyz"));      // NULL

// === 6. Global function: ?int (success + none) ===
echo "\n=== v_try_divide (?int) ===\n";
var_dump(v_try_divide(10, 3));   // 3
var_dump(v_try_divide(10, 0));   // NULL

// === 7. Global function: ?void (success + none) ===
echo "\n=== v_record_match (?void) ===\n";
$trace = tempnam(sys_get_temp_dir(), 'vphp_option_');
file_put_contents($trace, 'seed');
var_dump(v_record_match($trace, "alpha-beta", "beta"));  // NULL, but side effect recorded
echo "trace=" . file_get_contents($trace) . "\n";
var_dump(v_record_match($trace, "alpha-beta", "zzz"));   // NULL, no side effect
echo "trace=" . file_get_contents($trace) . "\n";
unlink($trace);

echo "\nAll option tests done.\n";
--EXPECT--
=== find (?string) ===
string(6) "banana"
NULL

=== index_of (?int) ===
int(2)
NULL

=== has_match (?bool) ===
bool(true)
bool(false)
NULL

=== try_parse_int (?int) ===
int(42)
int(0)
NULL
NULL

=== v_find_after (?string) ===
string(5) "world"
NULL

=== v_try_divide (?int) ===
int(3)
NULL

=== v_record_match (?void) ===
NULL
trace=beta
NULL
trace=beta

All option tests done.
