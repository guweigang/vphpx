<?php
declare(strict_types=1);

namespace App\Support;

final class FrontendAsset
{
    public static function url(string $asset): string
    {
        $publicPath = dirname(__DIR__, 2) . '/public/assets/' . ltrim($asset, '/');
        $version = @filemtime($publicPath);
        if (!is_int($version) || $version <= 0) {
            return '/assets/' . ltrim($asset, '/');
        }

        return '/assets/' . ltrim($asset, '/') . '?v=' . $version;
    }
}
