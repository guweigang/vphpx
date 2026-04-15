<?php
declare(strict_types=1);

namespace App\Providers;

use App\Repositories\KnowledgeRepository;
use App\Repositories\OpsRepository;
use App\Repositories\WorkspaceRepository;
use App\Services\ConsoleWorkspaceService;
use App\Services\AssistantAnswerService;
use App\Services\PublicWorkspaceService;
use App\Presenters\AssistantAnswerPresenter;
use App\Presenters\PublicBrandPresenter;
use App\Support\DemoCatalog;
use App\Support\LocaleCatalog;
use App\Support\LocalePreferenceResolver;
use App\Support\LocalizedUrlBuilder;
use VSlim\Job\Dispatcher;

final class AppServiceProvider extends \VSlim\Support\ServiceProvider
{
    public function register(): void
    {
        $container = $this->app()->container();
        $catalog = new DemoCatalog();
        $locales = new LocaleCatalog();
        $localeResolver = new LocalePreferenceResolver($locales);
        $urls = new LocalizedUrlBuilder($locales);
        $source = trim((string) $this->app()->config()->get_string('studio.storage.source', 'demo'));
        $db = $this->app()->database();
        $workspaceRepository = new WorkspaceRepository($catalog, $db, $source);
        $knowledgeRepository = new KnowledgeRepository($catalog, $db, $source);
        $opsRepository = new OpsRepository($catalog, $db, $source);
        $jobDispatcher = $this->app()->jobDispatcher();
        $consoleService = new ConsoleWorkspaceService(
            $workspaceRepository,
            $knowledgeRepository,
            $opsRepository,
            $jobDispatcher,
        );
        $answerService = new AssistantAnswerService($knowledgeRepository);
        $answerPresenter = new AssistantAnswerPresenter();
        $brandPresenter = new PublicBrandPresenter($urls);
        $publicService = new PublicWorkspaceService(
            $workspaceRepository,
            $knowledgeRepository,
            $catalog,
            $db,
            $source,
        );

        $container->set('studio.catalog', $catalog);
        $container->set(LocaleCatalog::class, $locales);
        $container->set(LocalePreferenceResolver::class, $localeResolver);
        $container->set(LocalizedUrlBuilder::class, $urls);
        $container->set('studio.storage.source', $source);
        $container->set(WorkspaceRepository::class, $workspaceRepository);
        $container->set(KnowledgeRepository::class, $knowledgeRepository);
        $container->set(OpsRepository::class, $opsRepository);
        $container->set(Dispatcher::class, $jobDispatcher);
        $container->set(ConsoleWorkspaceService::class, $consoleService);
        $container->set(AssistantAnswerService::class, $answerService);
        $container->set(AssistantAnswerPresenter::class, $answerPresenter);
        $container->set(PublicBrandPresenter::class, $brandPresenter);
        $container->set(PublicWorkspaceService::class, $publicService);
        $container->set('studio.phase', 'foundation');

        $this->app()->setAuthUserProvider(new class($workspaceRepository) {
            public function __construct(private WorkspaceRepository $workspaces)
            {
            }

            public function findById(string $id): ?array
            {
                return $this->workspaces->findUserById($id);
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
