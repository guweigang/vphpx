<?php

class MyException extends Exception {}

function test_exception($throw_val) {
    try {
        if ($throw_val == 1) {
            throw new Exception("base exception");
        } else if ($throw_val == 2) {
            throw new MyException("my exception");
        }
        echo "no exception\n";
    } catch (MyException $e) {
        echo "caught MyException: " . $e->getMessage() . "\n";
    } catch (Exception $e) {
        echo "caught Exception: " . $e->getMessage() . "\n";
    } finally {
        echo "finally block\n";
    }
}

test_exception(0);
test_exception(1);
test_exception(2);
