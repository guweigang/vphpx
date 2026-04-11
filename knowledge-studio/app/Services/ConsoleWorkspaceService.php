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

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed>|null $viewer
     * @param array<string, mixed> $input
     * @return array{ok:bool,message:string}
     */
    public function createDocument(?array $workspace, ?array $viewer, array $input): array
    {
        if (!$this->knowledge->writesEnabled() || !$this->ops->writesEnabled()) {
            return [
                'ok' => false,
                'message' => 'Database write path is disabled. Set STUDIO_DATA_SOURCE=db and run migrations first.',
            ];
        }

        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        $title = trim((string) ($input['title'] ?? ''));
        $sourceType = trim((string) ($input['source_type'] ?? ''));
        if ($workspaceId === '' || $title === '' || $sourceType === '') {
            return [
                'ok' => false,
                'message' => 'Document title and source type are required.',
            ];
        }

        $document = $this->knowledge->createDocument($workspaceId, $title, $sourceType);
        $this->ops->queueJob($workspaceId, 'Index ' . $title, 'queued');
        $this->ops->recordAudit(
            $workspaceId,
            $this->viewerLabel($viewer),
            'knowledge.document.created',
            (string) ($document['title'] ?? $title),
        );

        return [
            'ok' => true,
            'message' => 'Document queued for indexing.',
        ];
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed>|null $viewer
     * @param array<string, mixed> $input
     * @return array{ok:bool,message:string}
     */
    public function createEntry(?array $workspace, ?array $viewer, array $input): array
    {
        if (!$this->knowledge->writesEnabled() || !$this->ops->writesEnabled()) {
            return [
                'ok' => false,
                'message' => 'Database write path is disabled. Set STUDIO_DATA_SOURCE=db and run migrations first.',
            ];
        }

        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        $kind = trim((string) ($input['kind'] ?? 'faq'));
        $title = trim((string) ($input['title'] ?? ''));
        $body = trim((string) ($input['body'] ?? ''));
        if ($workspaceId === '' || $title === '' || $body === '') {
            return [
                'ok' => false,
                'message' => 'Entry title and body are required.',
            ];
        }

        $entry = $this->knowledge->createEntry($workspaceId, $kind, $title, $body, $this->viewerLabel($viewer));
        $this->ops->recordAudit(
            $workspaceId,
            $this->viewerLabel($viewer),
            'knowledge.entry.created',
            (string) ($entry['title'] ?? $title),
        );

        return [
            'ok' => true,
            'message' => 'Knowledge entry saved as draft.',
        ];
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed>|null $viewer
     * @param array<string, mixed> $input
     * @return array{ok:bool,message:string}
     */
    public function queueJob(?array $workspace, ?array $viewer, array $input): array
    {
        if (!$this->ops->writesEnabled()) {
            return [
                'ok' => false,
                'message' => 'Database write path is disabled. Set STUDIO_DATA_SOURCE=db and run migrations first.',
            ];
        }

        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        $name = trim((string) ($input['name'] ?? ''));
        if ($workspaceId === '' || $name === '') {
            return [
                'ok' => false,
                'message' => 'Job name is required.',
            ];
        }

        $job = $this->ops->queueJob($workspaceId, $name, 'queued');
        $this->ops->recordAudit(
            $workspaceId,
            $this->viewerLabel($viewer),
            'ops.job.queued',
            (string) ($job['name'] ?? $name),
        );

        return [
            'ok' => true,
            'message' => 'Job queued for worker execution.',
        ];
    }

    /**
     * @param array<string, mixed>|null $viewer
     */
    private function viewerLabel(?array $viewer): string
    {
        if (!is_array($viewer)) {
            return 'system';
        }

        $name = trim((string) ($viewer['name'] ?? ''));
        if ($name !== '') {
            return $name;
        }

        return trim((string) ($viewer['id'] ?? 'system')) ?: 'system';
    }
}
