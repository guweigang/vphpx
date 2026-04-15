<?php
declare(strict_types=1);

namespace App\Support;

final class DocumentChunkEstimator
{
    public static function estimate(string $content): int
    {
        $content = trim($content);
        if ($content === '') {
            return 0;
        }

        $length = mb_strlen($content, 'UTF-8');
        return max(1, (int) ceil($length / 280));
    }
}
