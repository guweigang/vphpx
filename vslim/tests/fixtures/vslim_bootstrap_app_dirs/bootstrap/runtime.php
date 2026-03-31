<?php
declare(strict_types=1);

require_once dirname(__DIR__) . "/support.php";

return function (VSlim\App $app): void {
    $app->set_base_path("/app-dir");
    $app->middleware(new AppDirTraceMiddleware());
};
