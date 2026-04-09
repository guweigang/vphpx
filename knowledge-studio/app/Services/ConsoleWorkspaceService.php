<?php
declare(strict_types=1);

namespace App\Services;

use App\Repositories\KnowledgeRepository;
use App\Repositories\OpsRepository;
use App\Repositories\WorkspaceRepository;

final class ConsoleWorkspaceService
{
    public function __construct(
        private WorkspaceRepository $workspaces,
        private KnowledgeRepository $knowledge,
        private OpsRepository $ops,
    ) {
    }

    /**
     * @param array<string, mixed>|null $viewer
     * @return array{workspace:?array, memberships:array<int, array<string, string>>}
     */
    public function resolveContext(?array $viewer, mixed $workspaceAttribute): array
    {
        $workspace = is_array($workspaceAttribute) ? $workspaceAttribute : null;
        if ($workspace === null && is_array($viewer)) {
            $workspace = $this->workspaces->defaultForUser((string) ($viewer['id'] ?? ''));
        }

        $memberships = is_array($viewer)
            ? $this->workspaces->membershipsForUser((string) ($viewer['id'] ?? ''))
            : [];

        return [
            'workspace' => $workspace,
            'memberships' => $memberships,
        ];
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array<string, mixed>
     */
    public function dashboard(?array $workspace): array
    {
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        $metrics = $this->knowledge->metricsForWorkspace($workspaceId);
        $documents = $this->knowledge->documentsForWorkspace($workspaceId);
        $entries = $this->knowledge->entriesForWorkspace($workspaceId);
        $jobs = $this->ops->jobsForWorkspace($workspaceId);
        $failedJobs = 0;
        foreach ($jobs as $job) {
            if (($job['status'] ?? '') === 'failed') {
                $failedJobs++;
            }
        }
        $metrics['jobs'] = count($jobs);
        $metrics['failed_jobs'] = $failedJobs;

        return [
            'metrics' => $metrics,
            'documents' => array_slice($documents, 0, 2),
            'entries' => array_slice($entries, 0, 2),
            'jobs' => array_slice($jobs, 0, 2),
        ];
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array<int, array<string, mixed>>
     */
    public function documents(?array $workspace): array
    {
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        return $this->knowledge->documentsForWorkspace($workspaceId);
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array<int, array<string, mixed>>
     */
    public function entries(?array $workspace): array
    {
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        return $this->knowledge->entriesForWorkspace($workspaceId);
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array{jobs:array<int, array<string, mixed>>, logs:array<int, array<string, mixed>>}
     */
    public function ops(?array $workspace): array
    {
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        return [
            'jobs' => $this->ops->jobsForWorkspace($workspaceId),
            'logs' => $this->ops->auditLogsForWorkspace($workspaceId),
        ];
    }
}
