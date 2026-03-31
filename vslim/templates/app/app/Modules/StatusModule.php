<?php
declare(strict_types=1);

namespace App\Modules;

final class StatusModule extends \VSlim\Support\Module
{
    public function register(): void
    {
        $this->app()->container()->set('template.module', 'module-ready');
    }

    public function routes(): void
    {
        $this->app()->get('/module/ping', function (): string {
            return implode('|', [
                'module',
                (string) $this->app()->container()->get('template.module'),
                (string) $this->app()->container()->get('template.module.booted'),
            ]);
        });
    }

    public function boot(): void
    {
        $this->app()->container()->set('template.module.booted', 'yes');
    }
}
