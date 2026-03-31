<?php
declare(strict_types=1);

namespace App\Modules;

final class BlogModule extends \VSlim\Support\Module
{
    public function register(): void
    {
        $this->app()->container()->set("app.module", "module-registered");
    }

    public function routes(): void
    {
        $this->app()->get("/module/ping", fn () => "module|" . $this->app()->container()->get("app.module"));
    }

    public function boot(): void
    {
        $this->app()->container()->set("app.module.booted", "yes");
    }
}
