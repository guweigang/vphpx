<?php
declare(strict_types=1);

require_once dirname(__DIR__) . '/bootstrap/http.php';

if (!extension_loaded('vslim')) {
    fwrite(STDERR, "vslim extension is not loaded\n");
    exit(1);
}

if (
    realpath((string) ($_SERVER['SCRIPT_FILENAME'] ?? '')) === __FILE__ &&
    PHP_SAPI === 'cli' &&
    !isset($_SERVER['REQUEST_METHOD'])
) {
    echo "Usage:\n";
    echo "  VHTTPD_APP=$(pwd)/public/worker.php php -d extension=./vslim.so /path/to/php-worker --socket /tmp/vslim-template.sock\n";
    exit(0);
}

return template_app_handler();
