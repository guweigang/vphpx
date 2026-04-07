<?php
declare(strict_types=1);

namespace App\Providers;

final class AppServiceProvider extends \VSlim\Support\ServiceProvider
{
    public function register(): void
    {
        $container = $this->app()->container();
        $container->set("template.message", "provider-ready");

        // 推荐在这里注册 auth user provider / gate resolver，而不是散落在路由文件里。
        // 例如：
        //
        // $this->app()->setAuthUserProvider(new class {
        //     public function findById(string $id): array
        //     {
        //         return ['id' => $id, 'role' => 'admin'];
        //     }
        // });
        //
        // $this->app()->setAuthGateResolver(
        //     fn (string $ability, $user, $request): bool
        //         => $ability === 'admin' && is_array($user) && ($user['role'] ?? '') === 'admin'
        // );
    }
}
