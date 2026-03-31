<?php
declare(strict_types=1);

namespace App\Providers;

final class AppServiceProvider extends \VSlim\Support\ServiceProvider
{
    public function register(): void
    {
        $container = $this->app()->container();
        $container->set(\SkeletonCatalogService::class, new \SkeletonCatalogService());
        $container->set("skeleton.banner", "providers-ready");
    }
}
