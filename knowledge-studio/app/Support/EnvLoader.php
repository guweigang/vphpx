<?php
declare(strict_types=1);

namespace App\Support;

final class EnvLoader
{
    public static function bootstrap(string $root): void
    {
        self::loadFile(rtrim($root, DIRECTORY_SEPARATOR) . '/.env');
    }

    private static function loadFile(string $path): void
    {
        if (!is_file($path)) {
            return;
        }

        $lines = file($path, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
        if (!is_array($lines)) {
            return;
        }

        foreach ($lines as $line) {
            $trimmed = trim($line);
            if ($trimmed === '' || str_starts_with($trimmed, '#')) {
                continue;
            }

            if (str_starts_with($trimmed, 'export ')) {
                $trimmed = trim(substr($trimmed, 7));
            }

            $parts = explode('=', $trimmed, 2);
            if (count($parts) !== 2) {
                continue;
            }

            $name = trim((string) $parts[0]);
            $value = self::normalizeValue((string) $parts[1]);
            if ($name === '') {
                continue;
            }

            if (getenv($name) !== false) {
                continue;
            }

            putenv($name . '=' . $value);
            $_ENV[$name] = $value;
            $_SERVER[$name] = $value;
        }
    }

    private static function normalizeValue(string $value): string
    {
        $trimmed = trim($value);
        if ($trimmed === '') {
            return '';
        }

        $first = $trimmed[0];
        $last = $trimmed[strlen($trimmed) - 1];
        if (($first === '"' && $last === '"') || ($first === "'" && $last === "'")) {
            return substr($trimmed, 1, -1);
        }

        return $trimmed;
    }
}
