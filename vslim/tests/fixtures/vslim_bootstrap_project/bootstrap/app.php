<?php
declare(strict_types=1);

return [
    "base_path" => "/project",
    "routes" => function (VSlim\App $app): void {
        $app->getNamed("fixture.project", "/project", fn () => "project-fixture");
    },
    "boot" => true,
];
