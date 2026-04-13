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
    public function landingData(?array $workspace): array
    {
        $snapshot = $this->snapshot($workspace);

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
    public function assistantData(?array $workspace): array
    {
        $snapshot = $this->snapshot($workspace);
        $workspace = $snapshot->workspace;
        $workspaceId = $snapshot->workspaceId();
        $documents = $this->knowledge->releasedDocumentsForWorkspace($workspaceId);
        $entries = $this->knowledge->releasedEntriesForWorkspace($workspaceId);

        return [
            'workspace' => $workspace,
            'metrics' => $snapshot->metrics,
            'release' => $snapshot->release,
            'profile' => $snapshot->profile,
            'documents' => array_slice($documents, 0, 3),
            'entries' => array_slice($entries, 0, 3),
            'subscription_count' => $snapshot->subscriptionCount,
            'offers' => $snapshot->offers,
        ];
    }

    public function releasedDocumentDetail(?array $workspace, string $documentId): ?array
    {
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        if ($workspaceId === '' || trim($documentId) === '') {
            return null;
        }

        foreach ($this->knowledge->releasedDocumentsForWorkspace($workspaceId) as $row) {
            if ((string) ($row['id'] ?? '') === trim($documentId)) {
                return $row;
            }
        }

        return null;
    }

    public function releasedEntryDetail(?array $workspace, string $entryId): ?array
    {
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        if ($workspaceId === '' || trim($entryId) === '') {
            return null;
        }

        foreach ($this->knowledge->releasedEntriesForWorkspace($workspaceId) as $row) {
            if ((string) ($row['id'] ?? '') === trim($entryId)) {
                return $row;
            }
        }

        return null;
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array{ok:bool,message:string}
     */
    public function registerSubscriptionInterest(?array $workspace, string $email, string $plan): array
    {
        $workspaceId = is_array($workspace) ? trim((string) ($workspace['id'] ?? '')) : '';
        $email = strtolower(trim($email));
        $plan = trim($plan);
        if ($workspaceId === '' || $email === '' || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
            return [
                'ok' => false,
                'message' => 'Please provide a valid subscriber email.',
            ];
        }
        if (!in_array($plan, ['starter', 'team', 'enterprise'], true)) {
            return [
                'ok' => false,
                'message' => 'Please choose a valid plan.',
            ];
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

        if (!is_array($subscriber)) {
            $subscriber = [
                'id' => $this->makeId('subscriber', $workspaceId . ':' . $email),
                'workspace_id' => $workspaceId,
                'email' => $email,
                'status' => 'active',
                'created_at' => date('Y-m-d H:i:s'),
            ];
            $this->db->table('subscriber_accounts')->insert($subscriber)->run();
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
            $this->db->table('subscriptions')->insert([
                'id' => $this->makeId('subscription', $workspaceId . ':' . $subscriberId . ':' . $plan),
                'workspace_id' => $workspaceId,
                'subscriber_id' => $subscriberId,
                'plan' => $plan,
                'status' => 'active',
                'created_at' => date('Y-m-d H:i:s'),
            ])->run();
        }

        return [
            'ok' => true,
            'message' => 'Subscription access requested successfully.',
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

    public function snapshot(?array $workspace): WorkspacePublicSnapshot
    {
        $workspace = $this->mergeWorkspaceDecorators($workspace);
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        $metrics = $this->knowledge->metricsForWorkspace($workspaceId);
        $release = $this->latestRelease($workspaceId);
        $profile = $this->assistantProfile($workspaceId, $workspace);
        $subscriptionCount = $this->activeSubscriptionCount($workspaceId);
        $releasedDocuments = $this->knowledge->releasedDocumentsForWorkspace($workspaceId);
        $releasedEntries = $this->knowledge->releasedEntriesForWorkspace($workspaceId);

        return new WorkspacePublicSnapshot(
            $workspace,
            $metrics,
            $release,
            $profile,
            $subscriptionCount,
            $this->publicPreview($releasedDocuments, $releasedEntries),
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
        if ($this->source === 'db' && $this->canQueryDatabase() && $workspaceId !== '') {
            $rows = $this->db
                ->table('knowledge_releases')
                ->where('workspace_id', $workspaceId)
                ->orderBy('created_at', 'desc')
                ->limit(1)
                ->get();
            if (is_array($rows) && is_array($rows[0] ?? null)) {
                return [
                    'version' => (string) ($rows[0]['version'] ?? ''),
                    'status' => (string) ($rows[0]['status'] ?? ''),
                    'notes' => (string) ($rows[0]['notes'] ?? ''),
                    'created_at' => (string) ($rows[0]['created_at'] ?? ''),
                ];
            }
        }

        $metrics = $this->knowledge->metricsForWorkspace($workspaceId);
        return [
            'version' => 'v0.1',
            'status' => (string) ($metrics['assistant_status'] ?? 'draft'),
            'notes' => '',
            'created_at' => '',
        ];
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
    private function publicPreview(array $documents, array $entries): array
    {
        return [
            'documents' => array_map(function (array $row): array {
                return [
                    'id' => (string) ($row['id'] ?? ''),
                    'title' => (string) ($row['title'] ?? ''),
                    'summary' => $this->snippet((string) ($row['summary'] ?? $row['title'] ?? ''), 140),
                    'meta' => trim((string) ($row['source_type'] ?? '') . ' / ' . (string) ($row['language'] ?? 'zh-CN')),
                ];
            }, array_slice($documents, 0, 3)),
            'entries' => array_map(function (array $row): array {
                return [
                    'id' => (string) ($row['id'] ?? ''),
                    'title' => (string) ($row['title'] ?? ''),
                    'summary' => $this->snippet((string) ($row['body'] ?? $row['title'] ?? ''), 140),
                    'meta' => trim((string) ($row['kind'] ?? 'faq') . ' / ' . (string) ($row['owner'] ?? '')),
                ];
            }, array_slice($entries, 0, 3)),
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
