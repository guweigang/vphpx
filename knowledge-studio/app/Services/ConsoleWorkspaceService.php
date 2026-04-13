<?php
declare(strict_types=1);

namespace App\Services;

use App\Domain\Knowledge\KnowledgeDocument;
use App\Domain\Knowledge\KnowledgeEntry;
use App\Domain\Knowledge\KnowledgeRelease;
use App\Repositories\KnowledgeRepository;
use App\Repositories\OpsRepository;
use App\Repositories\WorkspaceRepository;

final class ConsoleWorkspaceService
{
    private const OWNER_ROLE = 'tenant_owner';

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
        $subscriptions = $this->ops->subscriptionInsights($workspaceId);
        $questions = $this->ops->recentAssistantQuestions($workspaceId);
        $gaps = $this->ops->knowledgeGapInsights($workspaceId);
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

        return array_map(static function (array $row) use ($counts): array {
            $releaseId = (string) ($row['id'] ?? '');
            $row['documents_count'] = (string) (($counts[$releaseId]['documents'] ?? 0));
            $row['entries_count'] = (string) (($counts[$releaseId]['entries'] ?? 0));
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
        $latest = $this->knowledge->latestRelease($workspaceId);
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
                    'notes' => trim((string) ($latest?->notes ?? '')),
                    'documents' => (string) count($publishedDocuments),
                    'entries' => (string) count($publishedEntries),
                ],
                'next' => [
                    'version' => 'next',
                    'notes' => '',
                    'documents' => (string) count($draftDocuments),
                    'entries' => (string) count($draftEntries),
                ],
            ],
            'document_candidates' => array_map(function (array $row): array {
                $row['checked_attr'] = 'checked';
                $row['preview_summary'] = $this->snippet((string) ($row['summary'] ?? $row['title'] ?? ''), 120);
                $row['coverage_focus'] = (string) ($row['coverage_focus'] ?? $row['title'] ?? '');
                return $row;
            }, array_slice($draftDocuments, 0, 6)),
            'entry_candidates' => array_map(function (array $row): array {
                $row['checked_attr'] = 'checked';
                $row['preview_summary'] = $this->snippet((string) ($row['body'] ?? $row['title'] ?? ''), 120);
                $row['coverage_focus'] = (string) ($row['coverage_focus'] ?? $row['title'] ?? '');
                return $row;
            }, array_slice($draftEntries, 0, 6)),
            'public_preview' => [
                'documents' => array_map(function (array $row): array {
                    return [
                        'title' => (string) ($row['title'] ?? ''),
                        'summary' => $this->snippet((string) ($row['summary'] ?? $row['title'] ?? ''), 140),
                        'coverage_focus' => (string) ($row['coverage_focus'] ?? $row['title'] ?? ''),
                        'meta' => trim((string) ($row['source_type'] ?? '') . ' / ' . (string) ($row['language'] ?? 'zh-CN')),
                    ];
                }, array_slice($publishedDocuments, 0, 3)),
                'entries' => array_map(function (array $row): array {
                    return [
                        'title' => (string) ($row['title'] ?? ''),
                        'summary' => $this->snippet((string) ($row['body'] ?? $row['title'] ?? ''), 140),
                        'coverage_focus' => (string) ($row['coverage_focus'] ?? $row['title'] ?? ''),
                        'meta' => trim((string) ($row['kind'] ?? 'faq') . ' / ' . (string) ($row['owner'] ?? '')),
                    ];
                }, array_slice($publishedEntries, 0, 3)),
            ],
            'draft_preview' => [
                'documents' => array_map(function (array $row): array {
                    return [
                        'title' => (string) ($row['title'] ?? ''),
                        'summary' => $this->snippet((string) ($row['summary'] ?? $row['title'] ?? ''), 140),
                        'coverage_focus' => (string) ($row['coverage_focus'] ?? $row['title'] ?? ''),
                        'meta' => trim((string) ($row['source_type'] ?? '') . ' / ' . (string) ($row['language'] ?? 'zh-CN')),
                    ];
                }, array_slice($draftDocuments, 0, 3)),
                'entries' => array_map(function (array $row): array {
                    return [
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

        $this->ops->recordAudit(
            $workspaceId,
            $this->viewerLabel($viewer),
            'workspace.member.invited',
            (string) ($member['email'] ?? $email),
        );

        return [
            'ok' => true,
            'message' => 'Collaborator invited to the workspace.',
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

    /**
     * @param array<string, mixed>|null $viewer
     */
    private function roleOf(?array $viewer): string
    {
        return is_array($viewer) ? trim((string) ($viewer['role'] ?? '')) : '';
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
