<?php
declare(strict_types=1);

return [
    'stream' => static function (array $frame): array {
        $next = ($frame['event'] ?? '') === 'next';
        if (($frame['event'] ?? '') === 'close') {
            return ['handled' => true, 'done' => true];
        }

        $limit = (int) ($frame['state']['limit'] ?? 2);
        $cursor = $next ? (int) ($frame['state']['cursor'] ?? 0) + 1 : 0;
        $done = $cursor >= $limit;
        return [
            'handled' => true,
            'done' => $done,
            'headers' => ['cache-control' => 'no-cache'],
            'state' => ['cursor' => (string) $cursor, 'limit' => (string) $limit],
            'chunks' => [$done ? ['event' => 'done', 'data' => 'complete'] : ['event' => 'tick', 'data' => (string) $cursor]],
        ];
    },
];
