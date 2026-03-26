--TEST--
test_result: V Result (!) → PHP Exception bridging
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php

// === 1. Instance method: !bool (success + error) ===
echo "=== check (!bool) ===\n";
$v = new Validator(false);
var_dump($v->check("hello"));   // true
var_dump($v->check("ab"));      // false (non-strict, len < 3)

try {
    $v->check("");
} catch (Exception $e) {
    echo "Caught: " . $e->getMessage() . "\n";
}

$strict = new Validator(true);
try {
    $strict->check("ab");
} catch (Exception $e) {
    echo "Caught: " . $e->getMessage() . "\n";
}

// === 2. Instance method: !string (success + error) ===
echo "\n=== sanitize (!string) ===\n";
var_dump($v->sanitize("  Hello World  "));

try {
    $v->sanitize("");
} catch (Exception $e) {
    echo "Caught: " . $e->getMessage() . "\n";
}

// === 3. Instance method: !void (success + error) ===
echo "\n=== assert_valid (!void) ===\n";
var_dump($v->assert_valid("good input"));
echo "assert_valid passed\n";

try {
    $v->assert_valid("");
} catch (Exception $e) {
    echo "Caught: " . $e->getMessage() . "\n";
}

try {
    $strict->assert_valid("bad data");
} catch (Exception $e) {
    echo "Caught: " . $e->getMessage() . "\n";
}

// === 4. Global function: !void (success + error) ===
echo "\n=== v_record_success (!void) ===\n";
$trace = tempnam(sys_get_temp_dir(), 'vphp_result_');
var_dump(v_record_success($trace, "done"));
echo "trace=" . file_get_contents($trace) . "\n";

try {
    v_record_success($trace, "");
} catch (Exception $e) {
    echo "Caught: " . $e->getMessage() . "\n";
}
echo "trace=" . file_get_contents($trace) . "\n";
unlink($trace);

// === 5. Static method: !int (success + error) ===
echo "\n=== parse_int (!int) ===\n";
var_dump(Validator::parse_int("42"));
var_dump(Validator::parse_int("0"));

try {
    Validator::parse_int("");
} catch (Exception $e) {
    echo "Caught: " . $e->getMessage() . "\n";
}

try {
    Validator::parse_int("abc");
} catch (Exception $e) {
    echo "Caught: " . $e->getMessage() . "\n";
}

// === 6. Global function: !int (success + error) ===
echo "\n=== v_safe_divide (!int) ===\n";
var_dump(v_safe_divide(10, 3));

try {
    v_safe_divide(1, 0);
} catch (Exception $e) {
    echo "Caught: " . $e->getMessage() . "\n";
}

// === 7. Global function: !string (success + error) ===
echo "\n=== v_capitalize (!string) ===\n";
var_dump(v_capitalize("hello"));

try {
    v_capitalize("");
} catch (Exception $e) {
    echo "Caught: " . $e->getMessage() . "\n";
}

echo "\nAll result tests done.\n";
--EXPECT--
=== check (!bool) ===
bool(true)
bool(false)
Caught: input must not be empty
Caught: input too short in strict mode

=== sanitize (!string) ===
string(11) "hello world"
Caught: cannot sanitize empty string

=== assert_valid (!void) ===
NULL
assert_valid passed
Caught: assertion failed: empty input
Caught: assertion failed: contains forbidden word

=== v_record_success (!void) ===
NULL
trace=ok:done
Caught: label must not be empty
trace=ok:done

=== parse_int (!int) ===
int(42)
int(0)
Caught: cannot parse empty string
Caught: invalid integer: 'abc'

=== v_safe_divide (!int) ===
int(3)
Caught: division by zero

=== v_capitalize (!string) ===
string(5) "Hello"
Caught: cannot capitalize empty string

All result tests done.
