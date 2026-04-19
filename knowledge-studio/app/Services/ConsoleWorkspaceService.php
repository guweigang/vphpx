<?php
declare(strict_types=1);

namespace App\Services;

use App\Jobs\IndexDocumentJob;
use App\Jobs\IndexEntryJob;
use App\Domain\Knowledge\KnowledgeDocument;
use App\Domain\Knowledge\KnowledgeEntry;
use App\Domain\Knowledge\KnowledgeRelease;
use App\Repositories\KnowledgeRepository;
use App\Repositories\OpsRepository;
use App\Repositories\WorkspaceRepository;
use VSlim\Job\Dispatcher;

final class ConsoleWorkspaceService
{
    private const OWNER_ROLE = 'tenant_owner';

    public function __construct(
        private WorkspaceRepository $workspaces,
        private KnowledgeRepository $knowledge,
        private OpsRepository $ops,
        private Dispatcher $jobs,
    ) {
    }

    /**
     * @param array<string, mixed>|null $viewer
     * @return array{workspace:?array, memberships:array<int, array<string, string>>, viewer:?array}
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
        $viewer = $this->viewerForWorkspace($viewer, $workspace, $memberships);

        return [
            'workspace' => $workspace,
            'memberships' => $memberships,
            'viewer' => $viewer,
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
        $subscriptions = $this->ops->subscriptionInsights($workspaceId);
        $questions = $this->ops->recentAssistantQuestions($workspaceId);
        $gaps = $this->ops->knowledgeGapInsights($workspaceId);
        $failedJobs = 0;
        $activeJobs = 0;
        foreach ($jobs as $job) {
            $status = (string) ($job['status'] ?? '');
            if ($status === 'failed') {
                $failedJobs++;
            }
            if (in_array($status, ['queued', 'pending', 'running', 'reserved'], true)) {
                $activeJobs++;
            }
        }
        $draftDocuments = array_values(array_filter($documents, static fn (array $row): bool => (string) ($row['status'] ?? '') !== 'published'));
        $draftEntries = array_values(array_filter($entries, static fn (array $row): bool => (string) ($row['status'] ?? '') !== 'published'));
        $publishedEntries = array_values(array_filter($entries, static fn (array $row): bool => (string) ($row['status'] ?? '') === 'published'));
        usort($jobs, fn (array $left, array $right): int => $this->compareDashboardJobs($left, $right));
        $metrics['jobs'] = count($jobs);
        $metrics['failed_jobs'] = $failedJobs;
        $metrics['active_jobs'] = $activeJobs;
        $metrics['draft_documents'] = count($draftDocuments);
        $metrics['draft_entries'] = count($draftEntries);
        $metrics['published_entries'] = count($publishedEntries);
        $metrics['knowledge_gaps'] = count($gaps);
        $metrics['recent_questions'] = count($questions);

        return [
            'metrics' => $metrics,
            'documents' => array_slice($documents, 0, 2),
            'entries' => array_slice($entries, 0, 2),
            'jobs' => array_slice($jobs, 0, 2),
            'urgent_jobs' => array_slice($jobs, 0, 4),
            'subscriptions' => $subscriptions,
            'questions' => $questions,
            'gaps' => $gaps,
            'priorities' => $this->priorityQueue($metrics, $subscriptions, $gaps),
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

    public function documentEditor(?array $workspace, string $documentId): ?KnowledgeDocument
    {
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        if ($workspaceId === '' || trim($documentId) === '') {
            return null;
        }

        return $this->knowledge->findDocument($workspaceId, trim($documentId));
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
     * @return array<int, array<string, string>>
     */
    public function members(?array $workspace): array
    {
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        return $this->workspaces->membersForWorkspace($workspaceId);
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array<int, array<string, string>>
     */
    public function subscribers(?array $workspace): array
    {
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        return $this->decorateSubscribers($workspaceId, $this->ops->subscriberLeadsForWorkspace($workspaceId));
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array<string, string>|null
     */
    public function subscriberDetail(?array $workspace, string $subscriberId): ?array
    {
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        $lead = $this->ops->subscriberLeadDetail($workspaceId, trim($subscriberId));
        if (!is_array($lead)) {
            return null;
        }

        $items = $this->decorateSubscribers($workspaceId, [$lead]);
        return is_array($items[0] ?? null) ? $items[0] : null;
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array<int, array<string, string>>
     */
    public function subscriberFollowups(?array $workspace, string $subscriberId): array
    {
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        return $this->ops->subscriberFollowups($workspaceId, trim($subscriberId));
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array<int, array<string, string>>
     */
    public function subscriberProvisioningItems(?array $workspace, string $subscriberId): array
    {
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        return $this->ops->provisioningItemsForSubscriber($workspaceId, trim($subscriberId));
    }

    /**
     * @param array<string, mixed>|null $viewer
     */
    public function canManageMembers(?array $viewer): bool
    {
        return $this->roleOf($viewer) === self::OWNER_ROLE;
    }

    /**
     * @param array<string, mixed>|null $viewer
     */
    public function canManageOps(?array $viewer): bool
    {
        return $this->roleOf($viewer) === self::OWNER_ROLE;
    }

    /**
     * @param array<string, mixed>|null $viewer
     */
    public function canManageReleases(?array $viewer): bool
    {
        return $this->roleOf($viewer) === self::OWNER_ROLE;
    }

    /**
     * @param array<string, mixed>|null $viewer
     */
    public function canManageContent(?array $viewer): bool
    {
        $role = $this->roleOf($viewer);
        return $role === self::OWNER_ROLE || $role === 'knowledge_editor';
    }

    public function entryEditor(?array $workspace, string $entryId): ?KnowledgeEntry
    {
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        if ($workspaceId === '' || trim($entryId) === '') {
            return null;
        }

        return $this->knowledge->findEntry($workspaceId, trim($entryId));
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
            'provisioning' => $this->decorateWorkspaceProvisioning($workspaceId, $this->ops->provisioningItemsForWorkspace($workspaceId)),
        ];
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array<int, array<string, mixed>>
     */
    public function releases(?array $workspace): array
    {
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        $rows = $this->knowledge->releasesForWorkspace($workspaceId);
        $counts = $this->knowledge->releaseItemCounts($workspaceId);

        return array_map(function (array $row) use ($counts): array {
            $releaseId = (string) ($row['id'] ?? '');
            $documentsCount = (int) ($counts[$releaseId]['documents'] ?? 0);
            $entriesCount = (int) ($counts[$releaseId]['entries'] ?? 0);
            $row['documents_count'] = (string) $documentsCount;
            $row['entries_count'] = (string) $entriesCount;
            $row['notes'] = trim((string) ($row['notes'] ?? '')) !== ''
                ? trim((string) ($row['notes'] ?? ''))
                : $this->releaseNotesFallback(
                    (string) ($row['version'] ?? ''),
                    (string) ($row['status'] ?? ''),
                    $documentsCount,
                    $entriesCount,
                );
            return $row;
        }, $rows);
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array<string, mixed>
     */
    public function releaseSnapshot(?array $workspace): array
    {
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        $documents = $this->knowledge->documentsForWorkspace($workspaceId);
        $entries = $this->knowledge->entriesForWorkspace($workspaceId);
        $latest = $this->knowledge->latestPublishedRelease($workspaceId) ?? $this->knowledge->latestRelease($workspaceId);
        $publicDocuments = $this->knowledge->releasedDocumentsForWorkspace($workspaceId);
        $publicEntries = $this->knowledge->releasedEntriesForWorkspace($workspaceId);
        $gaps = $this->ops->knowledgeGapInsights($workspaceId);

        $publishedDocuments = array_values(array_filter($documents, static function (array $row): bool {
            return (string) ($row['status'] ?? '') === 'published';
        }));
        $publishedEntries = array_values(array_filter($entries, static function (array $row): bool {
            return (string) ($row['status'] ?? '') === 'published';
        }));
        $draftDocuments = array_values(array_filter($documents, static function (array $row): bool {
            return (string) ($row['status'] ?? '') !== 'published';
        }));
        $draftEntries = array_values(array_filter($entries, static function (array $row): bool {
            return (string) ($row['status'] ?? '') !== 'published';
        }));

        return [
            'published_documents' => count($publishedDocuments),
            'published_entries' => count($publishedEntries),
            'draft_documents' => count($draftDocuments),
            'draft_entries' => count($draftEntries),
            'latest_release' => $latest?->toArray() ?? [],
            'version_compare' => [
                'current' => [
                    'version' => (string) ($latest?->version ?? 'v0.0'),
                    'notes' => trim((string) ($latest?->notes ?? '')) !== ''
                        ? trim((string) ($latest?->notes ?? ''))
                        : $this->releaseNotesFallback(
                            (string) ($latest?->version ?? 'v0.0'),
                            (string) ($latest?->status ?? 'draft'),
                            count($publicDocuments),
                            count($publicEntries),
                        ),
                    'documents' => (string) count($publicDocuments),
                    'entries' => (string) count($publicEntries),
                ],
                'next' => [
                    'version' => 'next',
                    'notes' => '',
                    'documents' => (string) count($draftDocuments),
                    'entries' => (string) count($draftEntries),
                ],
            ],
            'document_candidates' => $this->releaseCandidates($draftDocuments, 'summary', 2),
            'entry_candidates' => $this->releaseCandidates($draftEntries, 'body', 2),
            'public_preview' => [
                'documents' => array_map(function (array $row): array {
                    return [
                        'id' => (string) ($row['id'] ?? ''),
                        'title' => (string) ($row['title'] ?? ''),
                        'summary' => $this->snippet((string) ($row['summary'] ?? $row['title'] ?? ''), 140),
                        'coverage_focus' => (string) ($row['coverage_focus'] ?? $row['title'] ?? ''),
                        'meta' => trim((string) ($row['source_type'] ?? '') . ' / ' . (string) ($row['language'] ?? 'zh-CN')),
                    ];
                }, array_slice($publicDocuments, 0, 3)),
                'entries' => array_map(function (array $row): array {
                    return [
                        'id' => (string) ($row['id'] ?? ''),
                        'title' => (string) ($row['title'] ?? ''),
                        'summary' => $this->snippet((string) ($row['body'] ?? $row['title'] ?? ''), 140),
                        'coverage_focus' => (string) ($row['coverage_focus'] ?? $row['title'] ?? ''),
                        'meta' => trim((string) ($row['kind'] ?? 'faq') . ' / ' . (string) ($row['owner'] ?? '')),
                    ];
                }, array_slice($publicEntries, 0, 3)),
            ],
            'draft_preview' => [
                'documents' => array_map(function (array $row): array {
                    return [
                        'id' => (string) ($row['id'] ?? ''),
                        'title' => (string) ($row['title'] ?? ''),
                        'summary' => $this->snippet((string) ($row['summary'] ?? $row['title'] ?? ''), 140),
                        'coverage_focus' => (string) ($row['coverage_focus'] ?? $row['title'] ?? ''),
                        'meta' => trim((string) ($row['source_type'] ?? '') . ' / ' . (string) ($row['language'] ?? 'zh-CN')),
                    ];
                }, array_slice($draftDocuments, 0, 3)),
                'entries' => array_map(function (array $row): array {
                    return [
                        'id' => (string) ($row['id'] ?? ''),
                        'title' => (string) ($row['title'] ?? ''),
                        'summary' => $this->snippet((string) ($row['body'] ?? $row['title'] ?? ''), 140),
                        'coverage_focus' => (string) ($row['coverage_focus'] ?? $row['title'] ?? ''),
                        'meta' => trim((string) ($row['kind'] ?? 'faq') . ' / ' . (string) ($row['owner'] ?? '')),
                    ];
                }, array_slice($draftEntries, 0, 3)),
            ],
            'change_summary' => [
                [
                    'label' => 'draft_documents',
                    'value' => (string) count($draftDocuments),
                ],
                [
                    'label' => 'draft_entries',
                    'value' => (string) count($draftEntries),
                ],
                [
                    'label' => 'current_public',
                    'value' => (string) (count($publishedDocuments) + count($publishedEntries)),
                ],
            ],
            'release_checks' => $this->releaseChecks($publishedDocuments, $publishedEntries, $draftDocuments, $draftEntries),
            'readiness_summary' => $this->releaseReadinessSummary($publishedDocuments, $publishedEntries, $draftDocuments, $draftEntries),
            'gap_signals' => array_map(function (array $row): array {
                return [
                    'title' => (string) ($row['title'] ?? ''),
                    'signal' => (string) ($row['signal'] ?? ''),
                    'created_at' => (string) ($row['created_at'] ?? ''),
                ];
            }, array_slice($gaps, 0, 4)),
            'ready' => ($publishedDocuments !== [] || $publishedEntries !== []) ? '1' : '0',
        ];
    }

    private function releaseNotesFallback(string $version, string $status, int $documentsCount, int $entriesCount): string
    {
        $version = trim($version);
        $status = strtolower(trim($status));
        $payloadSummary = $documentsCount . ' docs / ' . $entriesCount . ' entries';

        if (str_starts_with($version, 'onboarding-')) {
            return 'Onboarding handoff release scaffold with ' . $payloadSummary . ' prepared for customer provisioning.';
        }

        if ($status === 'published') {
            return 'Public knowledge release covering ' . $payloadSummary . '.';
        }

        return 'Draft release scaffold covering ' . $payloadSummary . ' pending final review.';
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed>|null $viewer
     * @param array<string, mixed> $input
     * @return array{ok:bool,message:string}
     */
    public function createDocument(?array $workspace, ?array $viewer, array $input): array
    {
        if (!$this->canManageContent($viewer)) {
            return [
                'ok' => false,
                'message' => 'Only tenant owners and knowledge editors can edit documents.',
            ];
        }

        if (!$this->knowledge->writesEnabled() || !$this->ops->writesEnabled()) {
            return [
                'ok' => false,
                'message' => 'Database write path is disabled. Set STUDIO_DATA_SOURCE=db and run migrations first.',
            ];
        }

        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        $title = trim((string) ($input['title'] ?? ''));
        $coverageFocus = trim((string) ($input['coverage_focus'] ?? ''));
        $summary = trim((string) ($input['summary'] ?? ''));
        $body = trim((string) ($input['body'] ?? ''));
        $language = trim((string) ($input['language'] ?? 'zh-CN'));
        $sourceType = trim((string) ($input['source_type'] ?? ''));
        if ($workspaceId === '' || $title === '' || $sourceType === '' || $body === '') {
            return [
                'ok' => false,
                'message' => 'Document title, body, and source type are required.',
            ];
        }

        $document = $this->knowledge->createDocument($workspaceId, $title, $coverageFocus, $summary, $body, $language, $sourceType);
        if (!$this->enqueueDocumentIndex($workspaceId, (string) ($document['id'] ?? ''), $title)) {
            return [
                'ok' => false,
                'message' => 'Document was created, but the indexing job could not be queued.',
            ];
        }
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
        if (!$this->canManageContent($viewer)) {
            return [
                'ok' => false,
                'message' => 'Only tenant owners and knowledge editors can edit knowledge entries.',
            ];
        }

        if (!$this->knowledge->writesEnabled() || !$this->ops->writesEnabled()) {
            return [
                'ok' => false,
                'message' => 'Database write path is disabled. Set STUDIO_DATA_SOURCE=db and run migrations first.',
            ];
        }

        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        $kind = trim((string) ($input['kind'] ?? 'faq'));
        $title = trim((string) ($input['title'] ?? ''));
        $coverageFocus = trim((string) ($input['coverage_focus'] ?? ''));
        $body = trim((string) ($input['body'] ?? ''));
        if ($workspaceId === '' || $title === '' || $body === '') {
            return [
                'ok' => false,
                'message' => 'Entry title and body are required.',
            ];
        }

        $entry = $this->knowledge->createEntry($workspaceId, $kind, $title, $coverageFocus, $body, $this->viewerLabel($viewer));
        if (!$this->enqueueEntryIndex($workspaceId, (string) ($entry['id'] ?? ''), $title)) {
            return [
                'ok' => false,
                'message' => 'Knowledge entry was created, but the indexing job could not be queued.',
            ];
        }
        $this->ops->recordAudit(
            $workspaceId,
            $this->viewerLabel($viewer),
            'knowledge.entry.created',
            (string) ($entry['title'] ?? $title),
        );

        return [
            'ok' => true,
            'message' => 'Knowledge entry saved and queued for indexing.',
        ];
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed>|null $viewer
     * @param array<string, mixed> $input
     * @return array{ok:bool,message:string}
     */
    public function updateDocument(?array $workspace, ?array $viewer, string $documentId, array $input): array
    {
        if (!$this->canManageContent($viewer)) {
            return ['ok' => false, 'message' => 'Only tenant owners and knowledge editors can edit documents.'];
        }

        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        $title = trim((string) ($input['title'] ?? ''));
        $coverageFocus = trim((string) ($input['coverage_focus'] ?? ''));
        $summary = trim((string) ($input['summary'] ?? ''));
        $body = trim((string) ($input['body'] ?? ''));
        $language = trim((string) ($input['language'] ?? 'zh-CN'));
        $sourceType = trim((string) ($input['source_type'] ?? ''));
        if ($workspaceId === '' || trim($documentId) === '' || $title === '' || $sourceType === '' || $body === '') {
            return ['ok' => false, 'message' => 'Document title, body, and source type are required.'];
        }

        $document = $this->knowledge->updateDocument($workspaceId, trim($documentId), $title, $coverageFocus, $summary, $body, $language, $sourceType);
        if ($document === null) {
            return ['ok' => false, 'message' => 'Document not found.'];
        }

        if ($this->ops->writesEnabled()) {
            $this->ops->recordAudit($workspaceId, $this->viewerLabel($viewer), 'knowledge.document.updated', $document->title);
        }

        if ($this->knowledge->writesEnabled() && $this->ops->writesEnabled()) {
            if (!$this->enqueueDocumentIndex($workspaceId, $document->id, $document->title)) {
                return ['ok' => false, 'message' => 'Document was updated, but the reindex job could not be queued.'];
            }

            return ['ok' => true, 'message' => 'Document updated and requeued for indexing.'];
        }

        return ['ok' => true, 'message' => 'Document updated for the next release cycle.'];
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed>|null $viewer
     * @return array{ok:bool,message:string}
     */
    public function publishDocument(?array $workspace, ?array $viewer, string $documentId): array
    {
        return ['ok' => false, 'message' => 'Direct document publishing is disabled. Save the draft here, then publish from the release center.'];
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed>|null $viewer
     * @param array<string, mixed> $input
     * @return array{ok:bool,message:string}
     */
    public function updateEntry(?array $workspace, ?array $viewer, string $entryId, array $input): array
    {
        if (!$this->canManageContent($viewer)) {
            return ['ok' => false, 'message' => 'Only tenant owners and knowledge editors can edit knowledge entries.'];
        }

        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        $kind = trim((string) ($input['kind'] ?? 'faq'));
        $title = trim((string) ($input['title'] ?? ''));
        $coverageFocus = trim((string) ($input['coverage_focus'] ?? ''));
        $body = trim((string) ($input['body'] ?? ''));
        if ($workspaceId === '' || trim($entryId) === '' || $title === '' || $body === '') {
            return ['ok' => false, 'message' => 'Entry title and body are required.'];
        }

        $entry = $this->knowledge->updateEntry($workspaceId, trim($entryId), $kind, $title, $coverageFocus, $body, $this->viewerLabel($viewer));
        if ($entry === null) {
            return ['ok' => false, 'message' => 'Knowledge entry not found.'];
        }

        if ($this->ops->writesEnabled()) {
            $this->ops->recordAudit($workspaceId, $this->viewerLabel($viewer), 'knowledge.entry.updated', $entry->title);
        }

        if ($this->knowledge->writesEnabled() && $this->ops->writesEnabled()) {
            if (!$this->enqueueEntryIndex($workspaceId, $entry->id, $entry->title)) {
                return ['ok' => false, 'message' => 'Knowledge entry was updated, but the reindex job could not be queued.'];
            }

            return ['ok' => true, 'message' => 'Knowledge entry updated and requeued for indexing.'];
        }

        return ['ok' => true, 'message' => 'Knowledge entry updated in the editorial workspace.'];
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed>|null $viewer
     * @return array{ok:bool,message:string}
     */
    public function publishEntry(?array $workspace, ?array $viewer, string $entryId): array
    {
        return ['ok' => false, 'message' => 'Direct entry publishing is disabled. Save the draft here, then publish from the release center.'];
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed>|null $viewer
     * @param array<string, mixed> $input
     * @return array{ok:bool,message:string}
     */
    public function queueJob(?array $workspace, ?array $viewer, array $input): array
    {
        if (!$this->canManageOps($viewer)) {
            return [
                'ok' => false,
                'message' => 'Only tenant owners can queue ops jobs.',
            ];
        }

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
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed>|null $viewer
     * @return array{ok:bool,message:string}
     */
    public function retryJob(?array $workspace, ?array $viewer, string $jobId): array
    {
        if (!$this->canManageOps($viewer)) {
            return [
                'ok' => false,
                'message' => 'Only tenant owners can retry failed ops jobs.',
            ];
        }

        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        if ($workspaceId === '' || trim($jobId) === '') {
            return [
                'ok' => false,
                'message' => 'Retry target is required.',
            ];
        }

        $job = $this->ops->retryableJobForWorkspace($workspaceId, $jobId);
        if (!is_array($job)) {
            return [
                'ok' => false,
                'message' => 'Only failed async jobs can be retried from this workspace.',
            ];
        }

        $queue = trim((string) ($job['queue'] ?? ''));
        $jobClass = trim((string) ($job['job_class'] ?? ''));
        $payload = is_array($job['payload'] ?? null) ? $job['payload'] : [];
        if ($queue === '' || $jobClass === '' || $payload === []) {
            return [
                'ok' => false,
                'message' => 'Retry metadata is incomplete for this job.',
            ];
        }

        $this->ops->updateJobStatus($jobId, 'queued');

        try {
            $this->jobs->dispatch(
                $jobClass,
                $payload,
                $queue,
                0,
                max(1, (int) ($job['max_attempts'] ?? 3)),
            );
        } catch (\Throwable) {
            $this->ops->updateJobStatus($jobId, 'failed');

            return [
                'ok' => false,
                'message' => 'Retry dispatch failed for this job.',
            ];
        }

        $this->ops->recordAudit(
            $workspaceId,
            $this->viewerLabel($viewer),
            'ops.job.retried',
            (string) ($job['name'] ?? $jobId),
        );

        return [
            'ok' => true,
            'message' => 'Failed job requeued successfully.',
        ];
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed>|null $viewer
     * @param array<string, mixed> $input
     * @return array{ok:bool,message:string,release:?KnowledgeRelease}
     */
    public function createRelease(?array $workspace, ?array $viewer, array $input): array
    {
        if (!$this->canManageReleases($viewer)) {
            return ['ok' => false, 'message' => 'Only tenant owners can publish releases.', 'release' => null];
        }

        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        $version = trim((string) ($input['version'] ?? ''));
        $notes = trim((string) ($input['notes'] ?? ''));
        $releaseReasons = $this->stringList($input['release_reasons'] ?? []);
        if ($releaseReasons !== []) {
            $reasonPrefix = "Release focus:\n- " . implode("\n- ", $releaseReasons);
            $notes = $notes !== '' ? $reasonPrefix . "\n\n" . $notes : $reasonPrefix;
        }
        if ($workspaceId === '' || $version === '') {
            return ['ok' => false, 'message' => 'Release version is required.', 'release' => null];
        }

        $documentIds = $this->idList($input['document_ids'] ?? []);
        $entryIds = $this->idList($input['entry_ids'] ?? []);
        if ($notes === '') {
            return ['ok' => false, 'message' => 'Release notes are required before publishing.', 'release' => null];
        }
        if ($documentIds === [] && $entryIds === []) {
            return ['ok' => false, 'message' => 'Select at least one draft document or entry for this release.', 'release' => null];
        }

        foreach ($documentIds as $documentId) {
            $this->knowledge->publishDocument($workspaceId, $documentId);
        }

        foreach ($entryIds as $entryId) {
            $this->knowledge->publishEntry($workspaceId, $entryId);
        }

        $release = $this->knowledge->createRelease($workspaceId, $version, 'published', $notes, $documentIds, $entryIds);
        if ($this->ops->writesEnabled()) {
            $this->ops->recordAudit(
                $workspaceId,
                $this->viewerLabel($viewer),
                'publish_release',
                $release->version
                . ' | docs=' . count($documentIds)
                . ' | entries=' . count($entryIds)
                . ' | notes=' . $this->snippet($release->notes, 80),
            );
        }

        return [
            'ok' => true,
            'message' => 'Release published to the public assistant surface.',
            'release' => $release,
        ];
    }

    /**
     * @param mixed $value
     * @return array<int, string>
     */
    private function stringList(mixed $value): array
    {
        $items = is_array($value) ? $value : [$value];
        $items = array_map(static fn (mixed $item): string => trim((string) $item), $items);
        return array_values(array_filter($items, static fn (string $item): bool => $item !== ''));
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed>|null $viewer
     * @param array<string, mixed> $input
     * @return array{ok:bool,message:string}
     */
    public function inviteMember(?array $workspace, ?array $viewer, array $input): array
    {
        if (!$this->canManageMembers($viewer)) {
            return [
                'ok' => false,
                'message' => 'Only tenant owners can invite collaborators.',
            ];
        }

        if (!$this->ops->writesEnabled()) {
            return [
                'ok' => false,
                'message' => 'Database write path is disabled. Set STUDIO_DATA_SOURCE=db and run migrations first.',
            ];
        }

        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        $name = trim((string) ($input['name'] ?? ''));
        $email = trim((string) ($input['email'] ?? ''));
        $role = trim((string) ($input['role'] ?? 'knowledge_editor'));
        if ($workspaceId === '' || $name === '' || $email === '' || $role === '') {
            return [
                'ok' => false,
                'message' => 'Member name, email, and role are required.',
            ];
        }

        $member = $this->workspaces->inviteMember($workspaceId, $name, $email, $role);
        if ($member === null) {
            return [
                'ok' => false,
                'message' => 'Unable to create collaborator record for this workspace.',
            ];
        }

        $temporaryPassword = trim((string) ($member['temporary_password'] ?? ''));

        $this->ops->recordAudit(
            $workspaceId,
            $this->viewerLabel($viewer),
            'workspace.member.invited',
            trim((string) ($member['email'] ?? $email))
            . ' | role=' . trim((string) ($member['role'] ?? $role))
            . ($temporaryPassword !== '' ? ' | temporary-password-issued' : ' | existing-account'),
        );

        return [
            'ok' => true,
            'message' => $temporaryPassword !== ''
                ? 'Collaborator invited. Temporary password: ' . $temporaryPassword
                : 'Collaborator invited to the workspace.',
        ];
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed>|null $viewer
     * @param array<string, mixed> $input
     * @return array{ok:bool,message:string}
     */
    public function updateMemberRole(?array $workspace, ?array $viewer, string $memberId, array $input): array
    {
        if (!$this->canManageMembers($viewer)) {
            return [
                'ok' => false,
                'message' => 'Only tenant owners can change collaborator roles.',
            ];
        }

        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        if ($workspaceId === '') {
            return [
                'ok' => false,
                'message' => 'Workspace context is required.',
            ];
        }

        $result = $this->workspaces->updateMemberRole(
            $workspaceId,
            $memberId,
            trim((string) ($input['role'] ?? '')),
            trim((string) ($viewer['id'] ?? '')),
        );
        if (($result['ok'] ?? false) !== true) {
            return ['ok' => false, 'message' => (string) ($result['message'] ?? 'Unable to update collaborator role.')];
        }

        $member = is_array($result['member'] ?? null) ? $result['member'] : [];
        $this->ops->recordAudit(
            $workspaceId,
            $this->viewerLabel($viewer),
            'workspace.member.role_updated',
            trim((string) ($member['email'] ?? ''))
            . ' | role=' . trim((string) ($member['role'] ?? '')),
        );

        return [
            'ok' => true,
            'message' => 'Collaborator role updated.',
        ];
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed>|null $viewer
     * @return array{ok:bool,message:string}
     */
    public function removeMember(?array $workspace, ?array $viewer, string $memberId): array
    {
        if (!$this->canManageMembers($viewer)) {
            return [
                'ok' => false,
                'message' => 'Only tenant owners can remove collaborators.',
            ];
        }

        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        if ($workspaceId === '') {
            return [
                'ok' => false,
                'message' => 'Workspace context is required.',
            ];
        }

        $result = $this->workspaces->removeMember(
            $workspaceId,
            $memberId,
            trim((string) ($viewer['id'] ?? '')),
        );
        if (($result['ok'] ?? false) !== true) {
            return ['ok' => false, 'message' => (string) ($result['message'] ?? 'Unable to remove collaborator.')];
        }

        $member = is_array($result['member'] ?? null) ? $result['member'] : [];
        $this->ops->recordAudit(
            $workspaceId,
            $this->viewerLabel($viewer),
            'workspace.member.removed',
            trim((string) ($member['email'] ?? ''))
            . ' | role=' . trim((string) ($member['role'] ?? '')),
        );

        return [
            'ok' => true,
            'message' => 'Collaborator removed from the workspace.',
        ];
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed>|null $viewer
     * @param array<string, mixed> $input
     * @return array{ok:bool,message:string}
     */
    public function updateSubscriberStatus(?array $workspace, ?array $viewer, string $subscriberId, array $input): array
    {
        if (!$this->canManageOps($viewer)) {
            return [
                'ok' => false,
                'message' => 'Only tenant owners can update lead status.',
            ];
        }

        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        if ($workspaceId === '') {
            return [
                'ok' => false,
                'message' => 'Workspace context is required.',
            ];
        }

        $note = trim((string) ($input['note'] ?? ''));
        if ($note === '') {
            return [
                'ok' => false,
                'message' => 'A followup note is required when updating lead status.',
            ];
        }

        $members = $this->workspaces->membersForWorkspace($workspaceId);
        $memberIds = array_column($members, 'user_id');
        $assigneeUserId = trim((string) ($input['assignee_user_id'] ?? ''));
        $updateAssignee = array_key_exists('assignee_user_id', $input);
        if ($updateAssignee && $assigneeUserId !== '' && !in_array($assigneeUserId, $memberIds, true)) {
            return [
                'ok' => false,
                'message' => 'The selected lead owner must be a member of this workspace.',
            ];
        }

        $stage = trim((string) ($input['stage'] ?? ''));
        $updateStage = array_key_exists('stage', $input);
        $closedReason = trim((string) ($input['closed_reason'] ?? ''));
        $updateClosedReason = array_key_exists('closed_reason', $input);
        if ($updateStage && $stage === '') {
            return [
                'ok' => false,
                'message' => 'Lead stage is required.',
            ];
        }
        if (($stage === 'lost' || $stage === 'won') && $closedReason === '') {
            return [
                'ok' => false,
                'message' => 'A closing reason is required for won or lost opportunities.',
            ];
        }
        if ($stage !== 'lost' && $stage !== 'won') {
            $closedReason = '';
        }

        $nextFollowupAt = trim((string) ($input['next_followup_at'] ?? ''));
        $updateNextFollowupAt = array_key_exists('next_followup_at', $input);
        $normalizedNextFollowupAt = null;
        if ($updateNextFollowupAt) {
            if ($nextFollowupAt !== '') {
                $timestamp = strtotime($nextFollowupAt);
                if ($timestamp === false) {
                    return [
                        'ok' => false,
                        'message' => 'Next followup time must be a valid date and time.',
                    ];
                }
                $normalizedNextFollowupAt = date('Y-m-d H:i:00', $timestamp);
            } else {
                $normalizedNextFollowupAt = '';
            }
        }

        $result = $this->ops->updateSubscriberStatus(
            $workspaceId,
            $subscriberId,
            trim((string) ($input['status'] ?? '')),
            $updateStage ? $stage : null,
            $updateClosedReason || $updateStage ? $closedReason : null,
            $updateAssignee ? $assigneeUserId : null,
            $updateNextFollowupAt ? $normalizedNextFollowupAt : null,
            $updateStage,
            $updateClosedReason || $updateStage,
            $updateAssignee,
            $updateNextFollowupAt,
        );
        if (($result['ok'] ?? false) !== true) {
            return [
                'ok' => false,
                'message' => (string) ($result['message'] ?? 'Unable to update lead status.'),
            ];
        }

        $subscriber = is_array($result['subscriber'] ?? null) ? $result['subscriber'] : [];
        $status = trim((string) ($subscriber['status'] ?? ''));
        $parts = ['Status changed to ' . $status . ': ' . $note];
        if ($updateStage) {
            $parts[] = 'Stage: ' . trim((string) ($subscriber['stage'] ?? $stage));
        }
        if (($updateClosedReason || $updateStage) && $closedReason !== '') {
            $parts[] = 'Close reason: ' . $closedReason;
        }
        if ($updateAssignee) {
            $assigneeLabel = 'unassigned';
            if ($assigneeUserId !== '') {
                foreach ($members as $member) {
                    if (trim((string) ($member['user_id'] ?? '')) === $assigneeUserId) {
                        $assigneeLabel = trim((string) ($member['name'] ?? '')) !== ''
                            ? trim((string) ($member['name'] ?? ''))
                            : trim((string) ($member['email'] ?? ''));
                        break;
                    }
                }
            }
            $parts[] = 'Owner: ' . $assigneeLabel;
        }
        if ($updateNextFollowupAt) {
            $parts[] = 'Next followup: ' . ($normalizedNextFollowupAt !== '' && $normalizedNextFollowupAt !== null ? $normalizedNextFollowupAt : 'not scheduled');
        }
        $noteResult = $this->ops->addSubscriberFollowup(
            $workspaceId,
            trim((string) ($subscriber['id'] ?? $subscriberId)),
            $this->viewerLabel($viewer),
            implode(' | ', $parts),
        );
        if (($noteResult['ok'] ?? false) !== true) {
            return [
                'ok' => false,
                'message' => (string) ($noteResult['message'] ?? 'Lead status changed, but the followup note could not be saved.'),
            ];
        }

        $this->ops->recordAudit(
            $workspaceId,
            $this->viewerLabel($viewer),
            'workspace.subscriber.status_updated',
            trim((string) ($subscriber['email'] ?? ''))
            . ' | status=' . $status,
        );

        return [
            'ok' => true,
            'message' => 'Lead ownership, status, and followup schedule were updated.',
        ];
    }

    /**
     * @param array<int, array<string, string>> $rows
     * @return array<int, array<string, string>>
     */
    private function decorateSubscribers(string $workspaceId, array $rows): array
    {
        if ($workspaceId === '' || $rows === []) {
            return $rows;
        }

        $members = $this->workspaces->membersForWorkspace($workspaceId);
        $memberNames = [];
        foreach ($members as $member) {
            $userId = trim((string) ($member['user_id'] ?? ''));
            if ($userId === '') {
                continue;
            }
            $memberNames[$userId] = trim((string) ($member['name'] ?? '')) !== ''
                ? trim((string) ($member['name'] ?? ''))
                : trim((string) ($member['email'] ?? ''));
        }

        return array_map(static function (array $row) use ($memberNames): array {
            $assigneeUserId = trim((string) ($row['assignee_user_id'] ?? ''));
            $nextFollowupAt = trim((string) ($row['next_followup_at'] ?? ''));
            return [
                ...$row,
                'assignee_name' => $assigneeUserId !== '' ? (string) ($memberNames[$assigneeUserId] ?? $assigneeUserId) : '',
                'stage' => trim((string) ($row['stage'] ?? 'new')) !== '' ? trim((string) ($row['stage'] ?? 'new')) : 'new',
                'closed_reason' => trim((string) ($row['closed_reason'] ?? '')),
                'next_followup_at' => $nextFollowupAt,
                'next_followup_input' => $nextFollowupAt !== ''
                    ? str_replace(' ', 'T', substr($nextFollowupAt, 0, 16))
                    : '',
            ];
        }, $rows);
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed>|null $viewer
     * @param array<string, mixed> $input
     * @return array{ok:bool,message:string}
     */
    public function addSubscriberFollowup(?array $workspace, ?array $viewer, string $subscriberId, array $input): array
    {
        if (!$this->canManageOps($viewer)) {
            return [
                'ok' => false,
                'message' => 'Only tenant owners can add lead followups.',
            ];
        }

        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        if ($workspaceId === '') {
            return [
                'ok' => false,
                'message' => 'Workspace context is required.',
            ];
        }

        $subscriber = $this->ops->subscriberLeadDetail($workspaceId, $subscriberId);
        if (!is_array($subscriber)) {
            return [
                'ok' => false,
                'message' => 'Unable to find the selected lead.',
            ];
        }

        $result = $this->ops->addSubscriberFollowup(
            $workspaceId,
            $subscriberId,
            $this->viewerLabel($viewer),
            trim((string) ($input['body'] ?? '')),
        );
        if (($result['ok'] ?? false) !== true) {
            return [
                'ok' => false,
                'message' => (string) ($result['message'] ?? 'Unable to add lead followup.'),
            ];
        }

        $this->ops->recordAudit(
            $workspaceId,
            $this->viewerLabel($viewer),
            'workspace.subscriber.followup_added',
            trim((string) ($subscriber['email'] ?? '')),
        );

        return [
            'ok' => true,
            'message' => 'Lead followup added.',
        ];
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed>|null $viewer
     * @return array{ok:bool,message:string}
     */
    public function queueSubscriberProvisioning(?array $workspace, ?array $viewer, string $subscriberId): array
    {
        if (!$this->canManageOps($viewer)) {
            return [
                'ok' => false,
                'message' => 'Only tenant owners can queue provisioning work.',
            ];
        }

        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        if ($workspaceId === '') {
            return [
                'ok' => false,
                'message' => 'Workspace context is required.',
            ];
        }

        $subscriber = $this->subscriberDetail($workspace, $subscriberId);
        if (!is_array($subscriber)) {
            return [
                'ok' => false,
                'message' => 'Unable to find the selected lead.',
            ];
        }

        if (trim((string) ($subscriber['stage'] ?? '')) !== 'won') {
            return [
                'ok' => false,
                'message' => 'Only won opportunities can be handed off to onboarding.',
            ];
        }

        $existing = $this->ops->provisioningJobForSubscriber($workspaceId, trim((string) ($subscriber['id'] ?? '')));
        $subscriberId = trim((string) ($subscriber['id'] ?? ''));
        $defaultItems = [
            ['key' => 'workspace_shell', 'label' => 'Create workspace shell and plan settings'],
            ['key' => 'invite_owner', 'label' => 'Invite first customer owner and rotate access'],
            ['key' => 'seed_knowledge', 'label' => 'Prepare initial brand page, release, and starter knowledge set'],
        ];
        if (is_array($existing)) {
            $items = $this->ops->ensureProvisioningItems($workspaceId, $subscriberId, $defaultItems);
            return [
                'ok' => true,
                'message' => $items !== []
                    ? 'Provisioning handoff was already queued. Checklist has been restored.'
                    : 'Provisioning is already queued for this customer handoff.',
            ];
        }

        $label = trim((string) ($subscriber['email'] ?? ''));
        if ($label === '') {
            $label = trim((string) ($subscriber['company_name'] ?? ''));
        }
        $jobName = 'Provision workspace for ' . $label . ' [lead:' . $subscriberId . ']';
        $this->ops->queueJob($workspaceId, $jobName);
        $this->ops->ensureProvisioningItems($workspaceId, $subscriberId, $defaultItems);
        $this->ops->addSubscriberFollowup(
            $workspaceId,
            $subscriberId,
            $this->viewerLabel($viewer),
            'Provisioning queued: ' . $jobName,
        );
        $this->ops->recordAudit(
            $workspaceId,
            $this->viewerLabel($viewer),
            'workspace.subscriber.provisioning_queued',
            trim((string) ($subscriber['email'] ?? '')) . ' | ' . $jobName,
        );

        return [
            'ok' => true,
            'message' => 'Provisioning handoff queued in ops.',
        ];
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed>|null $viewer
     * @return array{ok:bool,message:string}
     */
    public function completeSubscriberProvisioningItem(?array $workspace, ?array $viewer, string $subscriberId, string $itemId): array
    {
        if (!$this->canManageOps($viewer)) {
            return [
                'ok' => false,
                'message' => 'Only tenant owners can complete provisioning work.',
            ];
        }

        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        if ($workspaceId === '') {
            return [
                'ok' => false,
                'message' => 'Workspace context is required.',
            ];
        }

        $subscriber = $this->subscriberDetail($workspace, $subscriberId);
        if (!is_array($subscriber)) {
            return [
                'ok' => false,
                'message' => 'Unable to find the selected lead.',
            ];
        }

        $result = $this->ops->completeProvisioningItem($workspaceId, $subscriberId, $itemId);
        if (($result['ok'] ?? false) !== true) {
            return [
                'ok' => false,
                'message' => (string) ($result['message'] ?? 'Unable to complete provisioning step.'),
            ];
        }

        $item = is_array($result['item'] ?? null) ? $result['item'] : [];
        $label = trim((string) ($item['label'] ?? ''));
        $this->materializeProvisioningItem($workspaceId, $subscriber, $item);
        $this->ops->addSubscriberFollowup(
            $workspaceId,
            trim((string) ($subscriber['id'] ?? '')),
            $this->viewerLabel($viewer),
            'Provisioning step completed: ' . $label,
        );
        $this->ops->recordAudit(
            $workspaceId,
            $this->viewerLabel($viewer),
            'workspace.subscriber.provisioning_completed',
            trim((string) ($subscriber['email'] ?? '')) . ' | ' . $label,
        );

        return [
            'ok' => true,
            'message' => 'Provisioning checklist step completed.',
        ];
    }

    /**
     * @param array<string, string> $subscriber
     * @param array<string, string> $item
     */
    private function materializeProvisioningItem(string $workspaceId, array $subscriber, array $item): void
    {
        $itemKey = trim((string) ($item['item_key'] ?? ''));
        if ($workspaceId === '' || $itemKey === '') {
            return;
        }

        if ($itemKey === 'invite_owner') {
            $this->materializeProvisioningOwnerInvite($workspaceId, $subscriber);
            return;
        }

        if ($itemKey === 'seed_knowledge') {
            $this->materializeProvisioningStarterContent($workspaceId, $subscriber);
        }
    }

    /**
     * @param array<string, string> $subscriber
     */
    private function materializeProvisioningOwnerInvite(string $workspaceId, array $subscriber): void
    {
        $email = strtolower(trim((string) ($subscriber['email'] ?? '')));
        if ($workspaceId === '' || $email === '') {
            return;
        }

        foreach ($this->workspaces->membersForWorkspace($workspaceId) as $member) {
            if (strtolower(trim((string) ($member['email'] ?? ''))) === $email) {
                return;
            }
        }

        $name = trim((string) ($subscriber['contact_name'] ?? ''));
        if ($name === '') {
            $name = trim((string) ($subscriber['company_name'] ?? ''));
        }
        if ($name === '') {
            $name = 'Customer Owner';
        }

        $this->workspaces->inviteMember($workspaceId, $name, $email, self::OWNER_ROLE);
    }

    /**
     * @param array<string, string> $subscriber
     */
    private function materializeProvisioningStarterContent(string $workspaceId, array $subscriber): void
    {
        $company = trim((string) ($subscriber['company_name'] ?? ''));
        $email = trim((string) ($subscriber['email'] ?? ''));
        $label = $company !== '' ? $company : ($email !== '' ? $email : 'Customer');
        $plans = array_values(array_filter(array_map('trim', explode(',', (string) ($subscriber['plans'] ?? ''))), static fn (string $plan): bool => $plan !== ''));
        $primaryPlan = $plans[0] ?? 'starter';
        $blueprint = $this->starterBlueprint($primaryPlan, $label);
        $documentTitle = $blueprint['document_title'];
        $entryTitle = $blueprint['entry_title'];
        $releaseVersion = 'onboarding-' . trim((string) ($subscriber['id'] ?? ''));

        $documentExists = false;
        foreach ($this->knowledge->documentsForWorkspace($workspaceId) as $document) {
            if (trim((string) ($document['title'] ?? '')) === $documentTitle) {
                $documentExists = true;
                break;
            }
        }
        if (!$documentExists) {
            $document = $this->knowledge->createDocument(
                $workspaceId,
                $documentTitle,
                $blueprint['document_focus'],
                $blueprint['document_summary'],
                $blueprint['document_body'],
                'en',
                'markdown',
            );
            $this->enqueueDocumentIndex($workspaceId, (string) ($document['id'] ?? ''), $documentTitle);
        }

        $entryExists = false;
        foreach ($this->knowledge->entriesForWorkspace($workspaceId) as $entry) {
            if (trim((string) ($entry['title'] ?? '')) === $entryTitle) {
                $entryExists = true;
                break;
            }
        }
        if (!$entryExists) {
            $entry = $this->knowledge->createEntry(
                $workspaceId,
                'faq',
                $entryTitle,
                $blueprint['entry_focus'],
                $blueprint['entry_body'],
                'system',
            );
            $this->enqueueEntryIndex($workspaceId, (string) ($entry['id'] ?? ''), $entryTitle);
        }

        foreach ($this->knowledge->releasesForWorkspace($workspaceId) as $release) {
            if (trim((string) ($release['version'] ?? '')) === $releaseVersion) {
                return;
            }
        }

        $this->knowledge->createRelease(
            $workspaceId,
            $releaseVersion,
            'draft',
            $blueprint['release_notes'],
            [],
            [],
        );
    }

    /**
     * @return array{
     *   document_title:string,
     *   document_focus:string,
     *   document_summary:string,
     *   document_body:string,
     *   entry_title:string,
     *   entry_focus:string,
     *   entry_body:string,
     *   release_notes:string
     * }
     */
    private function starterBlueprint(string $plan, string $label): array
    {
        return match (trim($plan)) {
            'enterprise' => [
                'document_title' => 'Enterprise Launch Plan for ' . $label,
                'document_focus' => 'Enterprise onboarding rollout',
                'document_summary' => 'Coordinate enterprise launch owners, security review, SSO milestones, and customer success checkpoints.',
                'document_body' => 'Capture procurement dependencies, security review tasks, workspace provisioning owners, SSO onboarding steps, and executive launch checkpoints for this enterprise customer.',
                'entry_title' => 'Enterprise FAQ for ' . $label,
                'entry_focus' => 'Enterprise onboarding FAQ',
                'entry_body' => 'Track security review questions, procurement blockers, rollout dependencies, and owner handoff notes for this enterprise customer.',
                'release_notes' => 'Enterprise onboarding release scaffold for ' . $label . ', including security review, owner onboarding, and initial executive-facing launch assets.',
            ],
            'team' => [
                'document_title' => 'Team Launch Plan for ' . $label,
                'document_focus' => 'Team onboarding rollout',
                'document_summary' => 'Align workspace setup, editor onboarding, and first shared knowledge release for the team plan.',
                'document_body' => 'Capture workspace setup, editor invitation sequence, initial release goals, and team enablement checkpoints for this customer handoff.',
                'entry_title' => 'Team FAQ for ' . $label,
                'entry_focus' => 'Team onboarding FAQ',
                'entry_body' => 'Track kickoff questions, role assignment notes, launch blockers, and first release concerns for the team rollout.',
                'release_notes' => 'Team onboarding release scaffold for ' . $label . ', focused on workspace setup, editor onboarding, and initial shared release content.',
            ],
            default => [
                'document_title' => 'Starter Launch Plan for ' . $label,
                'document_focus' => 'Customer onboarding rollout',
                'document_summary' => 'Prepare the starter launch plan for workspace setup, owner handoff, and the first lightweight knowledge release.',
                'document_body' => 'Capture launch owners, workspace setup milestones, and first release goals for this starter customer handoff.',
                'entry_title' => 'Starter FAQ for ' . $label,
                'entry_focus' => 'Customer onboarding FAQ',
                'entry_body' => 'Track kickoff questions, owner handoff notes, and launch blockers for this customer.',
                'release_notes' => 'Starter onboarding release scaffold for ' . $label,
            ],
        };
    }

    /**
     * @param array<int, array<string, string>> $rows
     * @return array<int, array<string, string>>
     */
    private function decorateWorkspaceProvisioning(string $workspaceId, array $rows): array
    {
        if ($workspaceId === '' || $rows === []) {
            return $rows;
        }

        $leads = $this->decorateSubscribers($workspaceId, $this->ops->subscriberLeadsForWorkspace($workspaceId));
        $leadMap = [];
        foreach ($leads as $lead) {
            $leadMap[trim((string) ($lead['id'] ?? ''))] = $lead;
        }

        return array_map(static function (array $row) use ($leadMap): array {
            $lead = $leadMap[trim((string) ($row['subscriber_id'] ?? ''))] ?? [];
            return [
                ...$row,
                'lead_email' => (string) ($lead['email'] ?? ''),
                'lead_company_name' => (string) ($lead['company_name'] ?? ''),
            ];
        }, $rows);
    }

    /**
     * @param array<string, mixed>|null $viewer
     */
    public function requiresPasswordReset(?array $viewer): bool
    {
        return $this->workspaces->requiresPasswordReset($viewer);
    }

    /**
     * @param array<string, mixed>|null $viewer
     * @param array<string, mixed> $input
     * @return array{ok:bool,message:string}
     */
    public function changePassword(?array $workspace, ?array $viewer, array $input): array
    {
        if (!is_array($viewer)) {
            return [
                'ok' => false,
                'message' => 'You must be signed in to update the password.',
            ];
        }

        $currentPassword = trim((string) ($input['current_password'] ?? ''));
        $newPassword = trim((string) ($input['new_password'] ?? ''));
        $confirmPassword = trim((string) ($input['confirm_password'] ?? ''));

        if ($currentPassword === '' || $newPassword === '' || $confirmPassword === '') {
            return [
                'ok' => false,
                'message' => 'Current password, new password, and confirmation are required.',
            ];
        }

        if ($newPassword !== $confirmPassword) {
            return [
                'ok' => false,
                'message' => 'New password confirmation does not match.',
            ];
        }

        if (strlen($newPassword) < 8) {
            return [
                'ok' => false,
                'message' => 'New password must be at least 8 characters long.',
            ];
        }

        $result = $this->workspaces->changePassword((string) ($viewer['id'] ?? ''), $currentPassword, $newPassword);
        if (($result['ok'] ?? false) === true) {
            $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
            if ($workspaceId !== '' && $this->ops->writesEnabled()) {
                $this->ops->recordAudit(
                    $workspaceId,
                    $this->viewerLabel($viewer),
                    'account.password.changed',
                    trim((string) ($viewer['email'] ?? $viewer['id'] ?? 'account')),
                );
            }
        }

        return $result;
    }

    /**
     * @param array<string, mixed>|null $viewer
     * @param array<int, array<string, string>> $memberships
     */
    public function recordWorkspaceSwitch(?array $viewer, array $memberships, string $targetSlug): void
    {
        if (!$this->ops->writesEnabled() || !is_array($viewer) || trim($targetSlug) === '') {
            return;
        }

        foreach ($memberships as $membership) {
            if (trim((string) ($membership['workspace_slug'] ?? '')) !== trim($targetSlug)) {
                continue;
            }

            $workspace = $this->workspaces->findBySlug($targetSlug);
            $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
            if ($workspaceId === '') {
                return;
            }

            $name = trim((string) ($membership['workspace_name'] ?? $targetSlug));
            $role = trim((string) ($membership['role'] ?? ''));
            $this->ops->recordAudit(
                $workspaceId,
                $this->viewerLabel($viewer),
                'workspace.context.switched',
                $name . ' / ' . $targetSlug . ($role !== '' ? ' | role=' . $role : ''),
            );
            return;
        }
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

    /**
     * @param array<string, mixed>|null $viewer
     */
    private function roleOf(?array $viewer): string
    {
        return is_array($viewer) ? trim((string) ($viewer['role'] ?? '')) : '';
    }

    /**
     * @param array<string, mixed>|null $viewer
     * @param array<string, mixed>|null $workspace
     * @param array<int, array<string, string>> $memberships
     * @return array<string, mixed>|null
     */
    private function viewerForWorkspace(?array $viewer, ?array $workspace, array $memberships): ?array
    {
        if (!is_array($viewer)) {
            return null;
        }

        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        if ($workspaceId === '') {
            return $viewer;
        }

        foreach ($memberships as $membership) {
            if (trim((string) ($membership['workspace_id'] ?? '')) !== $workspaceId) {
                continue;
            }

            $viewer['role'] = trim((string) ($membership['role'] ?? ($viewer['role'] ?? '')));
            return $viewer;
        }

        $viewer['role'] = '';
        return $viewer;
    }

    /**
     * @return array<int, string>
     */
    private function idList(mixed $value): array
    {
        if (!is_array($value)) {
            return [];
        }

        $items = [];
        foreach ($value as $item) {
            $item = trim((string) $item);
            if ($item === '' || in_array($item, $items, true)) {
                continue;
            }
            $items[] = $item;
        }

        return $items;
    }

    private function enqueueDocumentIndex(string $workspaceId, string $documentId, string $title): bool
    {
        $opsJob = $this->ops->queueJob($workspaceId, 'Index ' . $title, 'queued');

        try {
            $this->jobs->dispatch(IndexDocumentJob::class, [
                'workspace_id' => $workspaceId,
                'document_id' => $documentId,
                'ops_job_id' => (string) ($opsJob['id'] ?? ''),
            ], 'knowledge-index', 0, 3);
        } catch (\Throwable) {
            $this->ops->updateJobStatus((string) ($opsJob['id'] ?? ''), 'failed');
            return false;
        }

        return true;
    }

    private function enqueueEntryIndex(string $workspaceId, string $entryId, string $title): bool
    {
        $opsJob = $this->ops->queueJob($workspaceId, 'Index entry ' . $title, 'queued');

        try {
            $this->jobs->dispatch(IndexEntryJob::class, [
                'workspace_id' => $workspaceId,
                'entry_id' => $entryId,
                'ops_job_id' => (string) ($opsJob['id'] ?? ''),
            ], 'knowledge-entry', 0, 3);
        } catch (\Throwable) {
            $this->ops->updateJobStatus((string) ($opsJob['id'] ?? ''), 'failed');
            return false;
        }

        return true;
    }

    /**
     * @param array<int, array<string, mixed>> $publishedDocuments
     * @param array<int, array<string, mixed>> $publishedEntries
     * @param array<int, array<string, mixed>> $draftDocuments
     * @param array<int, array<string, mixed>> $draftEntries
     */
    private function releaseReadinessSummary(
        array $publishedDocuments,
        array $publishedEntries,
        array $draftDocuments,
        array $draftEntries,
    ): string {
        if ($publishedDocuments === [] && $publishedEntries === []) {
            return 'No published knowledge is ready for a public assistant release yet.';
        }

        $parts = [];
        $parts[] = count($publishedDocuments) . ' published documents';
        $parts[] = count($publishedEntries) . ' published entries';
        if ($draftDocuments !== [] || $draftEntries !== []) {
            $parts[] = count($draftDocuments) . ' draft documents';
            $parts[] = count($draftEntries) . ' draft entries';
        }

        return implode(', ', $parts) . ' currently shape the next public release.';
    }

    /**
     * @param array<string, mixed> $metrics
     * @param array<string, mixed> $subscriptions
     * @param array<int, array<string, string>> $gaps
     * @return array<int, array<string, string>>
     */
    private function priorityQueue(array $metrics, array $subscriptions, array $gaps): array
    {
        $items = [];

        if ((int) ($metrics['failed_jobs'] ?? 0) > 0) {
            $items[] = [
                'priority' => 'P0',
                'title' => 'Recover failed indexing and delivery jobs',
                'body' => (string) ($metrics['failed_jobs'] ?? 0) . ' failed jobs need retry or diagnosis before the next publish cycle.',
                'target' => '/console/ops',
                'cta' => 'Open Ops',
            ];
        }

        if ($gaps !== []) {
            $items[] = [
                'priority' => 'P1',
                'title' => 'Fill knowledge gaps from recent assistant misses',
                'body' => count($gaps) . ' recent questions need better grounded coverage before the next release.',
                'target' => '/console/knowledge/faqs',
                'cta' => 'Update FAQ and Topics',
            ];
        }

        if ((int) ($subscriptions['count'] ?? 0) > 0) {
            $items[] = [
                'priority' => 'P1',
                'title' => 'Follow up on active subscription demand',
                'body' => (string) ($subscriptions['count'] ?? 0) . ' active subscription leads are waiting for packaged knowledge access.',
                'target' => '/console/releases',
                'cta' => 'Prepare Release',
            ];
        }

        if ((int) ($metrics['published_documents'] ?? 0) === 0) {
            $items[] = [
                'priority' => 'P0',
                'title' => 'Publish the first document set',
                'body' => 'The public assistant still lacks published document coverage.',
                'target' => '/console/knowledge/documents',
                'cta' => 'Open Documents',
            ];
        }

        if ((string) ($metrics['assistant_status'] ?? 'draft') !== 'published') {
            $items[] = [
                'priority' => 'P1',
                'title' => 'Move reviewed content into a public release',
                'body' => 'The assistant is still in draft status and needs a release cycle.',
                'target' => '/console/releases',
                'cta' => 'Open Releases',
            ];
        }

        if ($items === []) {
            $items[] = [
                'priority' => 'P2',
                'title' => 'Expand the corpus with higher-signal material',
                'body' => 'Current supply is stable. The next gain comes from richer documents and more reusable answers.',
                'target' => '/console/knowledge/documents',
                'cta' => 'Expand Corpus',
            ];
        }

        usort($items, static function (array $left, array $right): int {
            return strcmp((string) ($left['priority'] ?? 'P9'), (string) ($right['priority'] ?? 'P9'));
        });

        return array_slice($items, 0, 4);
    }

    private function compareDashboardJobs(array $left, array $right): int
    {
        $priority = fn (string $status): int => match ($status) {
            'failed' => 0,
            'running', 'reserved', 'pending', 'queued' => 1,
            'completed' => 2,
            default => 3,
        };
        $leftStatus = strtolower(trim((string) ($left['status'] ?? 'queued')));
        $rightStatus = strtolower(trim((string) ($right['status'] ?? 'queued')));
        $leftPriority = $priority($leftStatus);
        $rightPriority = $priority($rightStatus);

        if ($leftPriority !== $rightPriority) {
            return $leftPriority <=> $rightPriority;
        }

        $leftTime = $this->dashboardJobTimestamp($left);
        $rightTime = $this->dashboardJobTimestamp($right);
        if ($leftTime !== $rightTime) {
            return $rightTime <=> $leftTime;
        }

        return strcmp((string) ($right['id'] ?? ''), (string) ($left['id'] ?? ''));
    }

    private function dashboardJobTimestamp(array $item): int
    {
        $candidates = [
            (string) ($item['runtime_at'] ?? ''),
            (string) ($item['queued_at'] ?? ''),
            (string) ($item['updated_at'] ?? ''),
            (string) ($item['created_at'] ?? ''),
        ];

        foreach ($candidates as $candidate) {
            $candidate = trim($candidate);
            if ($candidate === '') {
                continue;
            }
            $timestamp = strtotime($candidate);
            if ($timestamp !== false) {
                return $timestamp;
            }
        }

        return 0;
    }

    /**
     * @param array<int, array<string, mixed>> $rows
     * @return array<int, array<string, mixed>>
     */
    private function releaseCandidates(array $rows, string $previewField, int $recommendedLimit = 2): array
    {
        usort($rows, fn (array $left, array $right): int => $this->releaseCandidateTimestamp($right) <=> $this->releaseCandidateTimestamp($left));
        $rows = array_slice($rows, 0, 6);

        return array_map(function (array $row, int $index) use ($previewField, $recommendedLimit): array {
            $recommended = $index < $recommendedLimit;
            $row['checked_attr'] = $recommended ? 'checked' : '';
            $row['selection_badge'] = $recommended ? 'recommended' : '';
            $row['preview_summary'] = $this->snippet((string) ($row[$previewField] ?? $row['title'] ?? ''), 120);
            $row['coverage_focus'] = (string) ($row['coverage_focus'] ?? $row['title'] ?? '');
            return $row;
        }, $rows, array_keys($rows));
    }

    private function releaseCandidateTimestamp(array $item): int
    {
        $candidates = [
            (string) ($item['updated_at'] ?? ''),
            (string) ($item['created_at'] ?? ''),
        ];

        foreach ($candidates as $candidate) {
            $candidate = trim($candidate);
            if ($candidate === '') {
                continue;
            }
            $timestamp = strtotime($candidate);
            if ($timestamp !== false) {
                return $timestamp;
            }
        }

        return 0;
    }

    /**
     * @param array<int, array<string, mixed>> $publishedDocuments
     * @param array<int, array<string, mixed>> $publishedEntries
     * @param array<int, array<string, mixed>> $draftDocuments
     * @param array<int, array<string, mixed>> $draftEntries
     * @return array<int, array<string, string>>
     */
    private function releaseChecks(
        array $publishedDocuments,
        array $publishedEntries,
        array $draftDocuments,
        array $draftEntries,
    ): array {
        $documentsHaveSummaries = true;
        foreach ($publishedDocuments as $document) {
            if (trim((string) ($document['summary'] ?? '')) === '' || trim((string) ($document['body'] ?? '')) === '') {
                $documentsHaveSummaries = false;
                break;
            }
        }

        $entriesHaveBodies = true;
        foreach ($publishedEntries as $entry) {
            if (trim((string) ($entry['body'] ?? '')) === '') {
                $entriesHaveBodies = false;
                break;
            }
        }

        return [
            [
                'label' => 'Published documents ready',
                'status' => $publishedDocuments !== [] ? 'pass' : 'warn',
                'detail' => $publishedDocuments !== []
                    ? count($publishedDocuments) . ' published documents available for release.'
                    : 'No published documents yet.',
            ],
            [
                'label' => 'Published entries ready',
                'status' => $publishedEntries !== [] ? 'pass' : 'warn',
                'detail' => $publishedEntries !== []
                    ? count($publishedEntries) . ' published entries available for release.'
                    : 'No published entries yet.',
            ],
            [
                'label' => 'Public content has summaries',
                'status' => $documentsHaveSummaries && $entriesHaveBodies ? 'pass' : 'warn',
                'detail' => $documentsHaveSummaries && $entriesHaveBodies
                    ? 'Published documents and entries include public-facing summaries or bodies.'
                    : 'Some published content is still missing summary or body details.',
            ],
            [
                'label' => 'Draft backlog visibility',
                'status' => ($draftDocuments !== [] || $draftEntries !== []) ? 'warn' : 'pass',
                'detail' => ($draftDocuments !== [] || $draftEntries !== [])
                    ? count($draftDocuments) . ' draft documents and ' . count($draftEntries) . ' draft entries remain outside this release.'
                    : 'No draft backlog remains outside this release.',
            ],
        ];
    }

    private function snippet(string $text, int $limit): string
    {
        $text = trim(preg_replace('/\s+/u', ' ', $text) ?? '');
        if ($text === '') {
            return '';
        }
        if (mb_strlen($text, 'UTF-8') <= $limit) {
            return $text;
        }

        return rtrim(mb_substr($text, 0, $limit, 'UTF-8')) . '...';
    }
}
