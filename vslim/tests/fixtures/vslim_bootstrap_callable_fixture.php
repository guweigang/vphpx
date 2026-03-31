<?php

return function (VSlim\App $app): array {
    return [
        'routes' => [
            function (VSlim\App $app): void {
                $app->get('/callable', fn () => 'callable-fixture');
            },
        ],
    ];
};
