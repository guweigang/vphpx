<?php

return [
    'routes' => function (VSlim\App $app): void {
        $app->get_named('fixture.spec', '/spec', fn () => 'spec-fixture');
    },
    'not_found' => fn () => new VSlim\Vhttpd\Response(404, 'spec-missing', 'text/plain; charset=utf-8'),
    'base_path' => '/fixture',
];
