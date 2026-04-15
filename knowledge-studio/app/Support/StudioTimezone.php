<?php
declare(strict_types=1);

namespace App\Support;

final class StudioTimezone
{
    public static function bootstrap(): void
    {
        $timezone = trim((string) (getenv('APP_TIMEZONE') ?: getenv('TZ') ?: 'Asia/Shanghai'));
        if ($timezone === '') {
            $timezone = 'Asia/Shanghai';
        }

        if (date_default_timezone_get() !== $timezone) {
            date_default_timezone_set($timezone);
        }
    }
}
