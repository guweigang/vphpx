<?php
declare(strict_types=1);

return [
    "base_path" => "/project",
    "routes" => function (VSlim\App $app): void {
        $app->get_named("fixture.project", "/project", fn () => "project-fixture");
    },
    "boot" => true,
];
