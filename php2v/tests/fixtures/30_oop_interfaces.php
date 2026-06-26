<?php

interface Logger {
    public function log($msg);
}

class FileLogger implements Logger {
    public function log($msg) {
        echo "LOG: " . $msg . "\n";
    }
}

$fl = new FileLogger();
if ($fl instanceof Logger) {
    echo "fl is Logger\n";
} else {
    echo "fl is not Logger\n";
}

$fl->log("hello");
