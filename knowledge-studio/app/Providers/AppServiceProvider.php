<?php
declare(strict_types=1);

namespace App\Providers;

require_once __DIR__ . '/../Support/DemoCatalog.php';
require_once __DIR__ . '/../Repositories/WorkspaceRepository.php';
require_once __DIR__ . '/../Repositories/KnowledgeRepository.php';
require_once __DIR__ . '/../Repositories/OpsRepository.php';
require_once __DIR__ . '/../Services/ConsoleWorkspaceService.php';

use App\Repositories\KnowledgeRepository;
use App\Repositories\OpsRepository;
use App\Repositories\WorkspaceRepository;
use App\Services\ConsoleWorkspaceService;
use App\Support\DemoCatalog;

final class AppServiceProvider extends \VSlim\Support\ServiceProvider
{
    public function register(): void
    {
        $container = $this->app()->container();
        $catalog = new DemoCatalog();
        $source = trim((string) $this->app()->config()->get_string('studio.storage.source', 'demo'));
        $db = $this->app()->database();
        $workspaceRepository = new WorkspaceRepository($catalog, $db, $source);
        $knowledgeRepository = new KnowledgeRepository($catalog, $db, $source);
        $opsRepository = new OpsRepository($catalog, $db, $source);
        $consoleService = new ConsoleWorkspaceService(
            $workspaceRepository,
            $knowledgeRepository,
            $opsRepository,
        );

        $container->set('studio.catalog', $catalog);
        $container->set('studio.storage.source', $source);
        $container->set(WorkspaceRepository::class, $workspaceRepository);
        $container->set(KnowledgeRepository::class, $knowledgeRepository);
        $container->set(OpsRepository::class, $opsRepository);
        $container->set(ConsoleWorkspaceService::class, $consoleService);
        $container->set('studio.phase', 'foundation');

        $this->app()->setAuthUserProvider(new class($catalog) {
            public function __construct(private DemoCatalog $catalog)
            {
            }

            public function findById(string $id): ?array
            {
                return $this->catalog->findUserById($id);
            }
        });

        $this->app()->setAuthGateResolver(
            static function (string $ability, $user): bool {
                if (!is_array($user)) {
                    return false;
                }

                $role = (string) ($user['role'] ?? '');
                if ($ability === 'tenant.manage') {
                    return $role === 'tenant_owner';
                }

                if ($ability === 'knowledge.edit') {
                    return in_array($role, ['tenant_owner', 'knowledge_editor'], true);
                }

                return false;
            }
        );
    }
}
