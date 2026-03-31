<?php
declare(strict_types=1);

require_once __DIR__ . '/../app/Commands/AboutCommand.php';

return [
    "commands" => [
        "template:about" => \App\Commands\AboutCommand::class,
    ],
];
