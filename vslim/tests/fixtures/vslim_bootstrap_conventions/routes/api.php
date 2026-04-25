<?php
declare(strict_types=1);

return function (VSlim\App $app): void {
    $app->getNamed("convention.ping", "/ping", fn () => "pong");
};
