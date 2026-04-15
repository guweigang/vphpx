<?php
declare(strict_types=1);

namespace App\Support;

use VSlim\Database\Config;
use VSlim\Database\Manager;

final class StudioDatabase
{
    private static ?Manager $manager = null;

    public static function manager(): Manager
    {
        if (self::$manager instanceof Manager) {
            return self::$manager;
        }

        $driver = trim((string) (getenv('VSLIM_DB_DRIVER') ?: 'mysql'));
        $host = trim((string) (getenv('VSLIM_DB_HOST') ?: '127.0.0.1'));
        $port = (int) (getenv('VSLIM_DB_PORT') ?: 3306);
        $username = trim((string) (getenv('VSLIM_DB_USER') ?: 'root'));
        $password = (string) (getenv('VSLIM_DB_PASSWORD') ?: '');
        $database = trim((string) (getenv('VSLIM_DB_NAME') ?: ''));

        $config = (new Config())
            ->set_driver($driver)
            ->set_host($host)
            ->set_port($port)
            ->set_username($username)
            ->set_password($password)
            ->setDatabase($database);

        self::$manager = (new Manager())->setConfig($config);
        return self::$manager;
    }
}
