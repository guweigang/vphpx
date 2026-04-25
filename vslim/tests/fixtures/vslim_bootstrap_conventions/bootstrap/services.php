<?php
declare(strict_types=1);

require_once dirname(__DIR__) . "/support.php";

$logger = (new VSlim\Log\Logger())->setChannel("convention.app");
$clock = new ConventionClock(new DateTimeImmutable("2024-01-01T00:00:00+00:00"));

return [
    "logger" => $logger,
    "clock" => $clock,
];
