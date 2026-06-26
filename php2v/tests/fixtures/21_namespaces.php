<?php
namespace App\Utils;

class Helper {
    public function log($msg) {
        echo "[Log] " . $msg . "\n";
    }
    public static function info($msg) {
        echo "[Info] " . $msg . "\n";
    }
}

namespace App\Core;

use App\Utils\Helper;
use App\Utils\Helper as AliasHelper;

class Application {
    public function run() {
        $helper = new Helper();
        $helper->log("App run");

        self::init();

        AliasHelper::info("Done");
    }

    public static function init() {
        echo "Init core\n";
    }
}

$app = new Application();
$app->run();
