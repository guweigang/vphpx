<?php
declare(strict_types=1);

if (extension_loaded('tokenizer')) {
    return;
}

$directory = ini_get('extension_dir');
if ($directory === false || $directory === '') {
    return;
}

$windows = PHP_OS_FAMILY === 'Windows';
$absolute = str_starts_with($directory, '/')
    || ($windows && (str_starts_with($directory, '\\') || substr($directory, 1, 1) === ':'));
if (!$absolute) {
    $directory = dirname(PHP_BINARY) . DIRECTORY_SEPARATOR . $directory;
}

$library = $windows ? 'php_tokenizer.dll' : 'tokenizer.' . PHP_SHLIB_SUFFIX;
$path = realpath($directory . DIRECTORY_SEPARATOR . $library);
if ($path !== false && is_file($path)) {
    echo $path;
}
