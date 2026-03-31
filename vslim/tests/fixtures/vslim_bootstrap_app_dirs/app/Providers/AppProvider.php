<?php
declare(strict_types=1);

namespace App\Providers;

final class AppProvider extends \VSlim\Support\ServiceProvider
{
    public function register(): void
    {
        $this->app()->container()->set("app.provider", "provider-loaded");
        $this->app()->container()->set("page.message", "bound-service");
    }
}
