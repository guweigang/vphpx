<?php
declare(strict_types=1);

namespace App\Services;

use App\Domain\PublicCatalog\SubscriptionOffer;
use App\Domain\PublicCatalog\WorkspacePublicSnapshot;
use App\Repositories\KnowledgeRepository;
use App\Repositories\WorkspaceRepository;
use App\Support\DemoCatalog;
use VSlim\Database\Manager;

final class PublicWorkspaceService
{
    public function __construct(
        private WorkspaceRepository $workspaces,
        private KnowledgeRepository $knowledge,
        private DemoCatalog $catalog,
        private Manager $db,
        private string $source = 'demo',
    ) {
    }

    /**
     * @param array<string, mixed>|null $viewer
     * @return array<string, mixed>|null
     */
    public function resolveWorkspace(mixed $workspaceAttribute, string $slug, ?array $viewer = null): ?array
    {
        if (is_array($workspaceAttribute)) {
            return $workspaceAttribute;
        }

        if ($slug !== '') {
            $workspace = $this->workspaces->findBySlug($slug);
            if (is_array($workspace)) {
                return $this->mergeWorkspaceDecorators($workspace);
            }
        }

        if (is_array($viewer)) {
            $workspace = $this->workspaces->defaultForUser((string) ($viewer['id'] ?? ''));
            if (is_array($workspace)) {
                return $this->mergeWorkspaceDecorators($workspace);
            }
        }

        return null;
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array<string, mixed>
     */
    public function landingData(?array $workspace, string $releaseVersion = ''): array
    {
        $snapshot = $this->snapshot($workspace, $releaseVersion);

        return [
            'workspace' => $snapshot->workspace,
            'metrics' => $snapshot->metrics,
            'release' => $snapshot->release,
            'profile' => $snapshot->profile,
            'subscription_count' => $snapshot->subscriptionCount,
            'offers' => $snapshot->offers,
        ];
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array<string, mixed>
     */
    public function validationData(?array $workspace, string $releaseVersion = ''): array
    {
        return $this->assistantData($workspace, $releaseVersion);
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array<string, mixed>
     */
    public function assistantData(?array $workspace, string $releaseVersion = ''): array
    {
        $snapshot = $this->snapshot($workspace, $releaseVersion);
        $workspace = $snapshot->workspace;
        $workspaceId = $snapshot->workspaceId();
        $documents = $releaseVersion !== ''
            ? $this->knowledge->releasedDocumentsForVersion($workspaceId, $releaseVersion)
            : $this->knowledge->releasedDocumentsForWorkspace($workspaceId);
        $entries = $releaseVersion !== ''
            ? $this->knowledge->releasedEntriesForVersion($workspaceId, $releaseVersion)
            : $this->knowledge->releasedEntriesForWorkspace($workspaceId);

        return [
            'workspace' => $workspace,
            'metrics' => $snapshot->metrics,
            'release' => $snapshot->release,
            'profile' => $snapshot->profile,
            'documents' => array_map(function (array $row) use ($releaseVersion): array {
                $row['release_version'] = $releaseVersion;
                return $row;
            }, array_slice($documents, 0, 3)),
            'entries' => array_map(function (array $row) use ($releaseVersion): array {
                $row['release_version'] = $releaseVersion;
                return $row;
            }, array_slice($entries, 0, 3)),
            'subscription_count' => $snapshot->subscriptionCount,
            'offers' => $snapshot->offers,
        ];
    }

    public function releasedDocumentDetail(?array $workspace, string $documentId, string $releaseVersion = ''): ?array
    {
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        if ($workspaceId === '' || trim($documentId) === '') {
            return null;
        }

        $documents = $releaseVersion !== ''
            ? $this->knowledge->releasedDocumentsForVersion($workspaceId, $releaseVersion)
            : $this->knowledge->releasedDocumentsForWorkspace($workspaceId);
        foreach ($documents as $row) {
            if ((string) ($row['id'] ?? '') === trim($documentId)) {
                return $this->decoratePublicDetail($workspaceId, 'document', $row);
            }
        }

        return null;
    }

    public function releasedEntryDetail(?array $workspace, string $entryId, string $releaseVersion = ''): ?array
    {
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        if ($workspaceId === '' || trim($entryId) === '') {
            return null;
        }

        $entries = $releaseVersion !== ''
            ? $this->knowledge->releasedEntriesForVersion($workspaceId, $releaseVersion)
            : $this->knowledge->releasedEntriesForWorkspace($workspaceId);
        foreach ($entries as $row) {
            if ((string) ($row['id'] ?? '') === trim($entryId)) {
                return $this->decoratePublicDetail($workspaceId, 'entry', $row);
            }
        }

        return null;
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array{ok:bool,message:string}
     */
    public function registerSubscriptionInterest(?array $workspace, array $input): array
    {
        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        $contactName = trim((string) ($input['contact_name'] ?? ''));
        $companyName = trim((string) ($input['company_name'] ?? ''));
        $sourceLabel = trim((string) ($input['source_label'] ?? 'brand_page'));
        $notes = trim((string) ($input['notes'] ?? ''));
        $email = strtolower(trim((string) ($input['email'] ?? '')));
        $plan = trim((string) ($input['plan'] ?? 'team'));
        if ($workspaceId === '' || $email === '' || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
            return [
                'ok' => false,
                'message' => 'Please provide a valid subscriber email.',
            ];
        }
        if ($contactName === '' || $companyName === '') {
            return [
                'ok' => false,
                'message' => 'Please provide a contact name and company.',
            ];
        }
        if (!in_array($plan, ['starter', 'team', 'enterprise'], true)) {
            return [
                'ok' => false,
                'message' => 'Please choose a valid plan.',
            ];
        }
        if ($sourceLabel === '') {
            $sourceLabel = 'brand_page';
        }

        if (!$this->canQueryDatabase()) {
            return [
                'ok' => true,
                'message' => 'Subscription interest captured in demo mode.',
            ];
        }

        $subscriber = $this->firstRow(
            $this->db
                ->table('subscriber_accounts')
                ->where('workspace_id', $workspaceId)
                ->where('email', $email)
                ->limit(1)
                ->get()
        );
        $createdLead = !is_array($subscriber);
        $createdSubscription = false;

        if ($createdLead) {
            $subscriber = [
                'id' => $this->makeId('subscriber', $workspaceId . ':' . $email),
                'workspace_id' => $workspaceId,
                'email' => $email,
                'contact_name' => $contactName,
                'company_name' => $companyName,
                'source_label' => $sourceLabel,
                'notes' => $notes,
                'status' => 'active',
                'updated_at' => date('Y-m-d H:i:s'),
                'created_at' => date('Y-m-d H:i:s'),
            ];
            $this->db->table('subscriber_accounts')->insert($subscriber)->run();
        } else {
            $this->db
                ->table('subscriber_accounts')
                ->where('workspace_id', $workspaceId)
                ->where('id', (string) ($subscriber['id'] ?? ''))
                ->update([
                    'contact_name' => $contactName,
                    'company_name' => $companyName,
                    'source_label' => $sourceLabel,
                    'notes' => $notes,
                    'updated_at' => date('Y-m-d H:i:s'),
                ])
                ->run();
        }

        $subscriberId = (string) ($subscriber['id'] ?? '');
        if ($subscriberId === '') {
            return [
                'ok' => false,
                'message' => 'Unable to create subscriber profile.',
            ];
        }

        $existing = $this->firstRow(
            $this->db
                ->table('subscriptions')
                ->where('workspace_id', $workspaceId)
                ->where('subscriber_id', $subscriberId)
                ->where('plan', $plan)
                ->where('status', 'active')
                ->limit(1)
                ->get()
        );
        if (!is_array($existing)) {
            $createdSubscription = true;
            $this->db->table('subscriptions')->insert([
                'id' => $this->makeId('subscription', $workspaceId . ':' . $subscriberId . ':' . $plan),
                'workspace_id' => $workspaceId,
                'subscriber_id' => $subscriberId,
                'plan' => $plan,
                'status' => 'active',
                'created_at' => date('Y-m-d H:i:s'),
            ])->run();
        }

        $message = 'Subscription access requested successfully.';
        if (!$createdLead && !$createdSubscription) {
            $message = 'We already had your request on file, and your lead details have been refreshed.';
        } elseif (!$createdLead && $createdSubscription) {
            $message = 'Your existing lead has been updated and the new plan request was added.';
        } elseif ($createdLead) {
            $message = 'Your subscription request has been captured and our team can follow up from here.';
        }

        return [
            'ok' => true,
            'message' => $message,
        ];
    }

    /**
     * @param array<string, mixed>|null $workspace
     */
    public function recordAssistantQuestion(?array $workspace, string $question, string $answer = '', array $diagnostics = []): void
    {
        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        $question = trim($question);
        if ($workspaceId === '' || $question === '' || !$this->canQueryDatabase()) {
            return;
        }

        $sessionId = $this->makeId('chat', $workspaceId . ':' . $question . ':' . date('Y-m-d H:i'));
        $this->db->table('chat_sessions')->insert([
            'id' => $sessionId,
            'workspace_id' => $workspaceId,
            'subscriber_id' => $this->anonymousSubscriberId($workspaceId),
            'title' => $this->snippet($question, 80),
            'created_at' => date('Y-m-d H:i:s'),
        ])->run();

        $this->db->table('chat_messages')->insert([
            'id' => $this->makeId('msg', $sessionId . ':user'),
            'session_id' => $sessionId,
            'role' => 'user',
            'body' => $question,
            'created_at' => date('Y-m-d H:i:s'),
        ])->run();

        $gap = trim($answer) === ''
            || (string) ($diagnostics['fallback_used'] ?? '0') === '1'
            || (string) ($diagnostics['citation_count'] ?? '0') === '0';

        $assistantBody = trim($answer) !== ''
            ? $this->snippet($answer, 320)
            : 'No grounded answer was available for this question.';
        if ($gap) {
            $assistantBody = '[gap] ' . $assistantBody;
        }

        $this->db->table('chat_messages')->insert([
            'id' => $this->makeId('msg', $sessionId . ':assistant'),
            'session_id' => $sessionId,
            'role' => 'assistant',
            'body' => $assistantBody,
            'created_at' => date('Y-m-d H:i:s'),
        ])->run();
    }

    public function snapshot(?array $workspace, string $releaseVersion = ''): WorkspacePublicSnapshot
    {
        $workspace = $this->mergeWorkspaceDecorators($workspace);
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        $metrics = $this->knowledge->metricsForWorkspace($workspaceId);
        $release = $this->resolveRelease($workspaceId, $releaseVersion);
        $profile = $this->assistantProfile($workspaceId, $workspace);
        $subscriptionCount = $this->activeSubscriptionCount($workspaceId);
        $releasedDocuments = $releaseVersion !== ''
            ? $this->knowledge->releasedDocumentsForVersion($workspaceId, $releaseVersion)
            : $this->knowledge->releasedDocumentsForWorkspace($workspaceId);
        $releasedEntries = $releaseVersion !== ''
            ? $this->knowledge->releasedEntriesForVersion($workspaceId, $releaseVersion)
            : $this->knowledge->releasedEntriesForWorkspace($workspaceId);
        $publicMetrics = $metrics;
        $publicMetrics['documents'] = count($releasedDocuments);
        $publicMetrics['entries'] = count($releasedEntries);

        return new WorkspacePublicSnapshot(
            $workspace,
            $publicMetrics,
            $release,
            $profile,
            $subscriptionCount,
            $this->publicPreview($workspaceId, $releasedDocuments, $releasedEntries, $releaseVersion),
            $this->subscriptionOffers($workspace, $subscriptionCount, (string) ($release['status'] ?? 'draft')),
        );
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array<string, mixed>|null
     */
    private function mergeWorkspaceDecorators(?array $workspace): ?array
    {
        if (!is_array($workspace)) {
            return null;
        }

        $fallback = $this->catalog->findWorkspaceBySlug((string) ($workspace['slug'] ?? ''));
        if (is_array($fallback)) {
            foreach (['tagline', 'theme', 'members', 'brand_name', 'plan', 'name'] as $key) {
                if (!array_key_exists($key, $workspace) || $workspace[$key] === '' || $workspace[$key] === null) {
                    $workspace[$key] = $fallback[$key] ?? $workspace[$key] ?? null;
                }
            }
        }

        return $workspace;
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array<string, mixed>
     */
    private function assistantProfile(string $workspaceId, ?array $workspace): array
    {
        $fallbackName = is_array($workspace) ? (string) ($workspace['brand_name'] ?? 'Assistant') : 'Assistant';
        $fallbackVisibility = 'public';

        if ($this->source === 'db' && $this->canQueryDatabase() && $workspaceId !== '') {
            $rows = $this->db
                ->table('assistant_profiles')
                ->where('workspace_id', $workspaceId)
                ->limit(1)
                ->get();
            if (is_array($rows) && is_array($rows[0] ?? null)) {
                return [
                    'name' => (string) ($rows[0]['name'] ?? $fallbackName),
                    'visibility' => (string) ($rows[0]['visibility'] ?? $fallbackVisibility),
                ];
            }
        }

        return [
            'name' => $fallbackName,
            'visibility' => $fallbackVisibility,
        ];
    }

    /**
     * @return array<string, mixed>|null
     */
    private function latestRelease(string $workspaceId): ?array
    {
        $published = $this->knowledge->latestPublishedRelease($workspaceId);
        if ($published !== null) {
            $row = $published->toArray();
            return [
                'version' => (string) ($row['version'] ?? ''),
                'status' => (string) ($row['status'] ?? ''),
                'notes' => $this->publicReleaseNotes(
                    $workspaceId,
                    (string) ($row['version'] ?? ''),
                    (string) ($row['status'] ?? ''),
                    (string) ($row['notes'] ?? ''),
                ),
                'created_at' => (string) ($row['created_at'] ?? ''),
            ];
        }

        if ($this->source === 'db' && $this->canQueryDatabase() && $workspaceId !== '') {
            $rows = $this->db
                ->table('knowledge_releases')
                ->where('workspace_id', $workspaceId)
                ->orderBy('created_at', 'desc')
                ->limit(1)
                ->get();
            if (is_array($rows) && is_array($rows[0] ?? null)) {
                $version = (string) ($rows[0]['version'] ?? '');
                $status = (string) ($rows[0]['status'] ?? '');
                return [
                    'version' => $version,
                    'status' => $status,
                    'notes' => $this->publicReleaseNotes(
                        $workspaceId,
                        $version,
                        $status,
                        (string) ($rows[0]['notes'] ?? ''),
                    ),
                    'created_at' => (string) ($rows[0]['created_at'] ?? ''),
                ];
            }
        }

        $metrics = $this->knowledge->metricsForWorkspace($workspaceId);
        return [
            'version' => 'v0.1',
            'status' => (string) ($metrics['assistant_status'] ?? 'draft'),
            'notes' => $this->publicReleaseNotes(
                $workspaceId,
                'v0.1',
                (string) ($metrics['assistant_status'] ?? 'draft'),
                '',
            ),
            'created_at' => '',
        ];
    }

    /**
     * @return array<string, mixed>|null
     */
    private function resolveRelease(string $workspaceId, string $releaseVersion = ''): ?array
    {
        $releaseVersion = trim($releaseVersion);
        if ($releaseVersion === '') {
            return $this->latestRelease($workspaceId);
        }

        $release = $this->knowledge->findReleaseByVersion($workspaceId, $releaseVersion);
        if ($release === null) {
            return $this->latestRelease($workspaceId);
        }

        $row = $release->toArray();
        $row['notes'] = $this->publicReleaseNotes(
            $workspaceId,
            (string) ($row['version'] ?? ''),
            (string) ($row['status'] ?? ''),
            (string) ($row['notes'] ?? ''),
        );

        return $row;
    }

    private function publicReleaseNotes(string $workspaceId, string $version, string $status, string $notes): string
    {
        $notes = trim($notes);
        if ($notes !== '') {
            return $notes;
        }

        if ($workspaceId === 'ws-acme' && trim($version) === 'v0.1') {
            return '2026.Q2 版本，聚焦报销运营、结算异常处理与支持到财务的交接流程。';
        }

        $documents = $version !== ''
            ? $this->knowledge->releasedDocumentsForVersion($workspaceId, $version)
            : $this->knowledge->releasedDocumentsForWorkspace($workspaceId);
        $entries = $version !== ''
            ? $this->knowledge->releasedEntriesForVersion($workspaceId, $version)
            : $this->knowledge->releasedEntriesForWorkspace($workspaceId);
        $payloadSummary = count($documents) . ' docs / ' . count($entries) . ' entries';
        $status = strtolower(trim($status));

        if (str_starts_with(trim($version), 'onboarding-')) {
            return 'Onboarding handoff release scaffold with ' . $payloadSummary . ' prepared for customer provisioning.';
        }

        if ($status === 'published') {
            return 'Public knowledge release covering ' . $payloadSummary . '.';
        }

        return 'Draft knowledge release scaffold covering ' . $payloadSummary . '.';
    }

    private function activeSubscriptionCount(string $workspaceId): int
    {
        if ($this->source === 'db' && $this->canQueryDatabase() && $workspaceId !== '') {
            $rows = $this->db
                ->table('subscriptions')
                ->where('workspace_id', $workspaceId)
                ->where('status', 'active')
                ->get();
            return is_array($rows) ? count(array_filter($rows, 'is_array')) : 0;
        }

        return 0;
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array<int, SubscriptionOffer>
     */
    private function subscriptionOffers(?array $workspace, int $subscriptionCount, string $releaseStatus): array
    {
        $plan = is_array($workspace) ? trim((string) ($workspace['plan'] ?? 'team')) : 'team';
        $featured = match ($plan) {
            'pro', 'team' => 'team',
            'enterprise' => 'enterprise',
            default => 'starter',
        };
        $prioritySupport = $releaseStatus === 'published' || $subscriptionCount > 0;

        return [
            new SubscriptionOffer('starter', 199, 1900, 1, 300, true, false, false, $featured === 'starter', ['portal_access']),
            new SubscriptionOffer('team', 799, 7900, 5, 3000, true, true, $prioritySupport, $featured === 'team', ['portal_access', 'brand_customization', 'collaboration']),
            new SubscriptionOffer('enterprise', 0, 0, 0, 0, true, true, true, $featured === 'enterprise', ['portal_access', 'brand_customization', 'collaboration', 'sso', 'governance']),
        ];
    }

    private function canQueryDatabase(): bool
    {
        try {
            return $this->db->connect();
        } catch (\Throwable) {
            return false;
        }
    }

    /**
     * @return array<string, mixed>|null
     */
    private function firstRow(mixed $result): ?array
    {
        if (!is_array($result)) {
            return null;
        }

        foreach ($result as $row) {
            if (is_array($row)) {
                return $row;
            }
        }

        return null;
    }

    /**
     * @param array<int, array<string, mixed>> $documents
     * @param array<int, array<string, mixed>> $entries
     * @return array<string, mixed>
     */
    private function publicPreview(string $workspaceId, array $documents, array $entries, string $releaseVersion = ''): array
    {
        return [
            'documents' => array_map(function (array $row) use ($workspaceId, $releaseVersion): array {
                return [
                    'id' => (string) ($row['id'] ?? ''),
                    'release_version' => $releaseVersion,
                    'title' => (string) ($row['title'] ?? ''),
                    'coverage_focus' => (string) ($row['coverage_focus'] ?? $row['title'] ?? ''),
                    'summary' => $this->previewSummary($workspaceId, 'document', $row),
                    'meta' => $this->previewMeta($workspaceId, 'document', $row),
                ];
            }, array_slice($documents, 0, 3)),
            'entries' => array_map(function (array $row) use ($workspaceId, $releaseVersion): array {
                return [
                    'id' => (string) ($row['id'] ?? ''),
                    'release_version' => $releaseVersion,
                    'title' => (string) ($row['title'] ?? ''),
                    'coverage_focus' => (string) ($row['coverage_focus'] ?? $row['title'] ?? ''),
                    'summary' => $this->previewSummary($workspaceId, 'entry', $row),
                    'meta' => $this->previewMeta($workspaceId, 'entry', $row),
                ];
            }, array_slice($entries, 0, 3)),
        ];
    }

    /**
     * @param array<string, mixed> $row
     */
    private function previewSummary(string $workspaceId, string $itemType, array $row): string
    {
        $id = trim((string) ($row['id'] ?? ''));
        if ($workspaceId === 'ws-acme') {
            $curated = match ($id) {
                'doc-acme-1' => 'How reimbursement requests are screened, approved, and communicated before payout goes live.',
                'doc-acme-2' => 'What to capture, who owns the case, and how settlement milestones are communicated during payout exceptions.',
                'doc-acme-3' => 'The exact handoff between support and finance once a payout case crosses approval or escalation boundaries.',
                'entry-acme-1' => 'Shows the approval chain from intake review through policy validation and finance release.',
                'entry-acme-2' => 'Defines the triage checklist, owner assignment, and decision log for payout exceptions.',
                'entry-acme-3' => 'Lists the triggers that require finance involvement and the case context that must move with the escalation.',
                default => '',
            };
            if ($curated !== '') {
                return $curated;
            }
        }

        $text = $itemType === 'document'
            ? (string) ($row['summary'] ?? $row['body'] ?? $row['title'] ?? '')
            : (string) ($row['body'] ?? $row['summary'] ?? $row['title'] ?? '');

        return $this->snippet($text, 140);
    }

    /**
     * @param array<string, mixed> $row
     */
    private function previewMeta(string $workspaceId, string $itemType, array $row): string
    {
        if ($itemType === 'document') {
            $sourceType = strtolower(trim((string) ($row['source_type'] ?? '')));
            $sourceLabel = match ($sourceType) {
                'markdown' => 'Markdown playbook',
                'pdf' => 'Settlement PDF',
                'notion' => $workspaceId === 'ws-acme' ? 'Notion operating guide' : 'Notion source',
                default => ucfirst($sourceType !== '' ? $sourceType : 'Source document'),
            };
            $language = strtolower(trim((string) ($row['language'] ?? '')));
            $languageLabel = match ($language) {
                'en', 'en-us', 'en-gb' => 'English source',
                'zh', 'zh-cn', 'zh-hans' => 'Chinese source',
                default => strtoupper($language !== '' ? $language : 'zh-CN') . ' source',
            };

            return trim($sourceLabel . ' · ' . $languageLabel, ' ·');
        }

        $kind = strtolower(trim((string) ($row['kind'] ?? 'faq')));
        $kindLabel = match ($kind) {
            'faq' => 'FAQ',
            'topic' => 'Ops topic',
            default => ucfirst($kind !== '' ? $kind : 'Entry'),
        };
        $owner = trim((string) ($row['owner'] ?? ''));

        return $owner !== '' ? $kindLabel . ' · ' . $owner : $kindLabel;
    }

    /**
     * @param array<string, mixed> $row
     * @return array<string, mixed>
     */
    private function decoratePublicDetail(string $workspaceId, string $itemType, array $row): array
    {
        $id = trim((string) ($row['id'] ?? ''));
        if ($workspaceId === '' || $id === '') {
            return $row;
        }

        $catalogItem = $itemType === 'document'
            ? $this->catalog->findDocumentById($workspaceId, $id)
            : $this->catalog->findEntryById($workspaceId, $id);
        if (!is_array($catalogItem)) {
            return $row;
        }

        if ($itemType === 'document') {
            $row['title'] = (string) ($catalogItem['title'] ?? $row['title'] ?? '');
            $row['coverage_focus'] = (string) ($catalogItem['coverage_focus'] ?? $row['coverage_focus'] ?? '');
            $row['summary'] = (string) ($catalogItem['summary'] ?? $row['summary'] ?? '');
            $row['body'] = (string) ($catalogItem['body'] ?? $row['body'] ?? '');
            $row['meta'] = $this->previewMeta($workspaceId, 'document', array_merge($row, $catalogItem));
            return $row;
        }

        $row['title'] = (string) ($catalogItem['title'] ?? $row['title'] ?? '');
        $row['coverage_focus'] = (string) ($catalogItem['coverage_focus'] ?? $row['coverage_focus'] ?? '');
        $row['summary'] = $this->previewSummary($workspaceId, 'entry', array_merge($row, $catalogItem));
        $row['body'] = (string) ($catalogItem['body'] ?? $row['body'] ?? '');
        $row['meta'] = $this->previewMeta($workspaceId, 'entry', array_merge($row, $catalogItem));

        return $row;
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

    private function anonymousSubscriberId(string $workspaceId): string
    {
        $email = 'anonymous+' . $workspaceId . '@assistant.local';
        $existing = $this->firstRow(
            $this->db
                ->table('subscriber_accounts')
                ->where('workspace_id', $workspaceId)
                ->where('email', $email)
                ->limit(1)
                ->get()
        );
        if (is_array($existing) && (string) ($existing['id'] ?? '') !== '') {
            return (string) ($existing['id'] ?? '');
        }

        $id = $this->makeId('subscriber', $workspaceId . ':' . $email);
        $this->db->table('subscriber_accounts')->insert([
            'id' => $id,
            'workspace_id' => $workspaceId,
            'email' => $email,
            'status' => 'active',
            'created_at' => date('Y-m-d H:i:s'),
        ])->run();

        return $id;
    }

    private function makeId(string $prefix, string $seed): string
    {
        return $prefix . '-' . substr(md5($seed), 0, 16);
    }
}
