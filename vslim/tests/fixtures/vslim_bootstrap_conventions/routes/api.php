<?php
declare(strict_types=1);

return function (VSlim\App $app): void {
    $app->get_named("convention.ping", "/ping", fn () => "pong");
};
