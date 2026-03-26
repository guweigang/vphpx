<?php

declare(strict_types=1);

use VPhp\VHttpd\PhpWorker\StreamApp;

return [
    'stream' => (new StreamApp())
        ->onOpen(static function (array $frame): array {
            return [
                'handled' => true,
                'stream_type' => 'sse',
                'content_type' => 'text/event-stream',
                'headers' => [
                    'cache-control' => 'no-cache',
                ],
                'state' => [
                    'cursor' => '0',
                    'limit' => '2',
                ],
                'chunks' => [
                    ['event' => 'tick', 'data' => '0'],
                ],
                'done' => false,
            ];
        })
        ->onNext(static function (array $frame): array {
            $state = is_array($frame['state'] ?? null) ? $frame['state'] : [];
            $cursor = (int) ($state['cursor'] ?? '0');
            $limit = (int) ($state['limit'] ?? '2');
            $cursor++;
            if ($cursor >= $limit) {
                return [
                    'handled' => true,
                    'state' => [
                        'cursor' => (string) $cursor,
                        'limit' => (string) $limit,
                    ],
                    'chunks' => [
                        ['event' => 'done', 'data' => 'complete'],
                    ],
                    'done' => true,
                ];
            }
            return [
                'handled' => true,
                'state' => [
                    'cursor' => (string) $cursor,
                    'limit' => (string) $limit,
                ],
                'chunks' => [
                    ['event' => 'tick', 'data' => (string) $cursor],
                ],
                'done' => false,
            ];
        })
        ->onClose(static function (array $frame): array {
            return [
                'handled' => true,
                'done' => true,
            ];
        }),
];
