<?php
declare(strict_types=1);

namespace App\Repositories;

use App\Support\DemoCatalog;
use VSlim\Database\Manager;

final class OpsRepository
{
    private ?bool $databaseAvailable = null;

    public function __construct(
        private DemoCatalog $catalog,
        private Manager $db,
        private string $source = 'demo',
    )
    {
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    public function jobsForWorkspace(string $workspaceId): array
    {
        if ($this->shouldUseDatabase()) {
            $rows = $this->rows(
                $this->db
                    ->table('jobs')
                    ->where('workspace_id', $workspaceId)
                    ->orderBy('id', 'asc')
                    ->get()
            );
            if ($rows !== []) {
                return $this->mergeQueueRuntimeStatuses($workspaceId, $rows);
            }
        }

        return $this->catalog->jobsForWorkspace($workspaceId);
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    public function auditLogsForWorkspace(string $workspaceId): array
    {
        if ($this->shouldUseDatabase()) {
            $rows = $this->normalizeAuditRows($this->rows(
                $this->db
                    ->table('audit_logs')
                    ->where('workspace_id', $workspaceId)
                    ->orderBy('id', 'desc')
                    ->get()
            ));
            if ($rows !== []) {
                return $rows;
            }
        }

        return $this->normalizeAuditRows($this->catalog->auditLogsForWorkspace($workspaceId));
    }

    public function writesEnabled(): bool
    {
        return $this->shouldUseDatabase();
    }

    public function queueJob(string $workspaceId, string $name, string $status = 'queued'): array
    {
        $row = [
            'id' => $this->nextId('job'),
            'workspace_id' => $workspaceId,
            'name' => $name,
            'status' => $status,
            'queued_at' => $this->timestamp(),
        ];

        $this->db->table('jobs')->insert($row)->run();

        return $row;
    }

    /**
     * @return array<string, mixed>|null
     */
    public function provisioningJobForSubscriber(string $workspaceId, string $subscriberId): ?array
    {
        $workspaceId = trim($workspaceId);
        $subscriberId = trim($subscriberId);
        if ($workspaceId === '' || $subscriberId === '' || !$this->shouldUseDatabase()) {
            return null;
        }

        $rows = $this->rows(
            $this->db
                ->table('jobs')
                ->where('workspace_id', $workspaceId)
                ->get()
        );
        foreach ($rows as $row) {
            $name = trim((string) ($row['name'] ?? ''));
            if (!str_contains($name, '[lead:' . $subscriberId . ']')) {
                continue;
            }
            if (!str_contains($name, 'Provision workspace')) {
                continue;
            }
            return $row;
        }

        return null;
    }

    /**
     * @return array<int, array<string, string>>
     */
    public function provisioningItemsForSubscriber(string $workspaceId, string $subscriberId): array
    {
        $workspaceId = trim($workspaceId);
        $subscriberId = trim($subscriberId);
        if ($workspaceId === '' || $subscriberId === '' || !$this->shouldUseDatabase()) {
            return [];
        }

        $rows = $this->rows(
            $this->db
                ->table('subscriber_provisioning_items')
                ->where('workspace_id', $workspaceId)
                ->where('subscriber_id', $subscriberId)
                ->orderBy('created_at', 'asc')
                ->get()
        );

        return array_map(static function (array $row): array {
            return [
                'id' => (string) ($row['id'] ?? ''),
                'item_key' => (string) ($row['item_key'] ?? ''),
                'label' => (string) ($row['label'] ?? ''),
                'status' => (string) ($row['status'] ?? ''),
                'created_at' => (string) ($row['created_at'] ?? ''),
                'completed_at' => (string) ($row['completed_at'] ?? ''),
            ];
        }, $rows);
    }

    /**
     * @return array<int, array<string, string>>
     */
    public function provisioningItemsForWorkspace(string $workspaceId): array
    {
        $workspaceId = trim($workspaceId);
        if ($workspaceId === '' || !$this->shouldUseDatabase()) {
            return [];
        }

        $rows = $this->rows(
            $this->db
                ->table('subscriber_provisioning_items')
                ->where('workspace_id', $workspaceId)
                ->get()
        );

        return array_map(static function (array $row): array {
            return [
                'id' => (string) ($row['id'] ?? ''),
                'subscriber_id' => (string) ($row['subscriber_id'] ?? ''),
                'label' => (string) ($row['label'] ?? ''),
                'status' => (string) ($row['status'] ?? ''),
                'completed_at' => (string) ($row['completed_at'] ?? ''),
                'created_at' => (string) ($row['created_at'] ?? ''),
            ];
        }, $rows);
    }

    /**
     * @param array<int, array{key:string,label:string}> $items
     */
    public function ensureProvisioningItems(string $workspaceId, string $subscriberId, array $items): array
    {
        $workspaceId = trim($workspaceId);
        $subscriberId = trim($subscriberId);
        if ($workspaceId === '' || $subscriberId === '' || !$this->shouldUseDatabase()) {
            return [];
        }

        $existing = $this->provisioningItemsForSubscriber($workspaceId, $subscriberId);
        if ($existing !== []) {
            return $existing;
        }

        $createdAt = $this->timestamp();
        foreach ($items as $item) {
            $this->db->table('subscriber_provisioning_items')->insert([
                'id' => $this->nextId('prov'),
                'workspace_id' => $workspaceId,
                'subscriber_id' => $subscriberId,
                'item_key' => (string) ($item['key'] ?? ''),
                'label' => (string) ($item['label'] ?? ''),
                'status' => 'pending',
                'created_at' => $createdAt,
            ])->run();
        }

        return $this->provisioningItemsForSubscriber($workspaceId, $subscriberId);
    }

    /**
     * @return array{ok:bool,message:string,item?:array<string,string>}
     */
    public function completeProvisioningItem(string $workspaceId, string $subscriberId, string $itemId): array
    {
        $workspaceId = trim($workspaceId);
        $subscriberId = trim($subscriberId);
        $itemId = trim($itemId);
        if ($workspaceId === '' || $subscriberId === '' || $itemId === '' || !$this->shouldUseDatabase()) {
            return [
                'ok' => false,
                'message' => 'Provisioning checklist requires database storage mode.',
            ];
        }

        $item = $this->firstRow(
            $this->db
                ->table('subscriber_provisioning_items')
                ->where('workspace_id', $workspaceId)
                ->where('subscriber_id', $subscriberId)
                ->where('id', $itemId)
                ->limit(1)
                ->get()
        );
        if (!is_array($item)) {
            return [
                'ok' => false,
                'message' => 'Unable to find the selected provisioning step.',
            ];
        }

        if ((string) ($item['status'] ?? '') !== 'done') {
            $completedAt = $this->timestamp();
            $this->db
                ->table('subscriber_provisioning_items')
                ->where('workspace_id', $workspaceId)
                ->where('subscriber_id', $subscriberId)
                ->where('id', $itemId)
                ->update([
                    'status' => 'done',
                    'completed_at' => $completedAt,
                ])
                ->run();
            $item['status'] = 'done';
            $item['completed_at'] = $completedAt;
        }

        return [
            'ok' => true,
            'message' => 'Provisioning step completed.',
            'item' => [
                'id' => (string) ($item['id'] ?? ''),
                'item_key' => (string) ($item['item_key'] ?? ''),
                'label' => (string) ($item['label'] ?? ''),
                'status' => (string) ($item['status'] ?? ''),
                'completed_at' => (string) ($item['completed_at'] ?? ''),
            ],
        ];
    }

    public function updateJobStatus(string $jobId, string $status): void
    {
        if (trim($jobId) === '') {
            return;
        }

        $this->db
            ->table('jobs')
            ->where('id', $jobId)
            ->update([
                'status' => $status,
            ])
            ->run();
    }

    /**
     * @return array<string, mixed>|null
     */
    public function retryableJobForWorkspace(string $workspaceId, string $jobId): ?array
    {
        $workspaceId = trim($workspaceId);
        $jobId = trim($jobId);
        if ($workspaceId === '' || $jobId === '' || !$this->shouldUseDatabase()) {
            return null;
        }

        $job = $this->rows(
            $this->db
                ->table('jobs')
                ->where('workspace_id', $workspaceId)
                ->where('id', $jobId)
                ->limit(1)
                ->get()
        )[0] ?? null;
        if (!is_array($job)) {
            return null;
        }

        $runtimeRows = $this->rows($this->db->queryParams(
            'SELECT id, queue, status, job_class, payload_json, max_attempts, available_at, updated_at, completed_at, failed_at, last_error
             FROM vslim_jobs
             WHERE payload_json LIKE ?
             ORDER BY id ASC',
            ['%"ops_job_id":"' . $jobId . '"%']
        ));
        if ($runtimeRows === []) {
            return null;
        }

        $runtime = null;
        foreach ($runtimeRows as $candidate) {
            $payload = json_decode((string) ($candidate['payload_json'] ?? '{}'), true);
            if (!is_array($payload)) {
                continue;
            }
            if (trim((string) ($payload['workspace_id'] ?? '')) !== $workspaceId) {
                continue;
            }
            if (trim((string) ($payload['ops_job_id'] ?? '')) !== $jobId) {
                continue;
            }
            $runtime = $candidate;
        }

        if (!is_array($runtime) || (string) ($runtime['status'] ?? '') !== 'failed') {
            return null;
        }

        $payload = json_decode((string) ($runtime['payload_json'] ?? '{}'), true);
        if (!is_array($payload)) {
            return null;
        }

        return [
            'job_id' => $jobId,
            'workspace_id' => $workspaceId,
            'name' => (string) ($job['name'] ?? ''),
            'queue' => (string) ($runtime['queue'] ?? ''),
            'job_class' => (string) ($runtime['job_class'] ?? ''),
            'payload' => $payload,
            'max_attempts' => (int) ($runtime['max_attempts'] ?? 3),
            'last_error' => (string) ($runtime['last_error'] ?? ''),
        ];
    }

    public function recordAudit(string $workspaceId, string $actor, string $action, string $target): array
    {
        $row = [
            'id' => $this->nextId('audit'),
            'workspace_id' => $workspaceId,
            'actor' => $actor,
            'action' => $action,
            'target' => $target,
            'created_at' => $this->timestamp(),
        ];

        $this->db->table('audit_logs')->insert($row)->run();

        return $row;
    }

    /**
     * @return array{count:int,recent:array<int, array<string, string>>,plans:array<int, array<string, string>>}
     */
    public function subscriptionInsights(string $workspaceId): array
    {
        if ($workspaceId === '') {
            return [
                'count' => 0,
                'recent' => [],
                'plans' => [],
            ];
        }

        if ($this->shouldUseDatabase()) {
            $subscriptions = $this->rows(
                $this->db
                    ->table('subscriptions')
                    ->where('workspace_id', $workspaceId)
                    ->where('status', 'active')
                    ->get()
            );
            $subscribers = $this->rows(
                $this->db
                    ->table('subscriber_accounts')
                    ->where('workspace_id', $workspaceId)
                    ->get()
            );

            $emails = [];
            foreach ($subscribers as $row) {
                $emails[(string) ($row['id'] ?? '')] = (string) ($row['email'] ?? '');
            }

            $planCounts = [];
            $recent = [];
            foreach ($subscriptions as $row) {
                $plan = (string) ($row['plan'] ?? '');
                $planCounts[$plan] = (int) ($planCounts[$plan] ?? 0) + 1;
                $recent[] = [
                    'email' => $emails[(string) ($row['subscriber_id'] ?? '')] ?? '',
                    'plan' => $plan,
                    'created_at' => (string) ($row['created_at'] ?? ''),
                ];
            }

            usort($recent, static fn (array $left, array $right): int => strcmp((string) ($right['created_at'] ?? ''), (string) ($left['created_at'] ?? '')));

            $plans = [];
            foreach ($planCounts as $plan => $count) {
                $plans[] = [
                    'plan' => (string) $plan,
                    'count' => (string) $count,
                ];
            }

            usort($plans, static fn (array $left, array $right): int => ((int) ($right['count'] ?? 0)) <=> ((int) ($left['count'] ?? 0)));

            return [
                'count' => count($subscriptions),
                'recent' => array_slice($recent, 0, 5),
                'plans' => $plans,
            ];
        }

        return [
            'count' => 0,
            'recent' => [],
            'plans' => [],
        ];
    }

    /**
     * @return array<int, array<string, string>>
     */
    public function subscriberLeadsForWorkspace(string $workspaceId): array
    {
        if ($workspaceId === '' || !$this->shouldUseDatabase()) {
            return [];
        }

        $subscribers = $this->rows(
            $this->db
                ->table('subscriber_accounts')
                ->where('workspace_id', $workspaceId)
                ->get()
        );
        $subscriptions = $this->rows(
            $this->db
                ->table('subscriptions')
                ->where('workspace_id', $workspaceId)
                ->get()
        );

        $subscriptionsBySubscriber = [];
        foreach ($subscriptions as $row) {
            $subscriberId = (string) ($row['subscriber_id'] ?? '');
            if ($subscriberId === '') {
                continue;
            }
            $subscriptionsBySubscriber[$subscriberId][] = $row;
        }

        $leads = [];
        foreach ($subscribers as $row) {
            $subscriberId = (string) ($row['id'] ?? '');
            $subscriberSubs = $subscriptionsBySubscriber[$subscriberId] ?? [];
            $plans = [];
            $latestAt = (string) ($row['created_at'] ?? '');
            $activeCount = 0;
            foreach ($subscriberSubs as $subscription) {
                $plan = trim((string) ($subscription['plan'] ?? ''));
                $status = trim((string) ($subscription['status'] ?? ''));
                if ($plan !== '' && !in_array($plan, $plans, true)) {
                    $plans[] = $plan;
                }
                if ($status === 'active') {
                    $activeCount++;
                }
                $createdAt = (string) ($subscription['created_at'] ?? '');
                if ($createdAt !== '' && strcmp($createdAt, $latestAt) > 0) {
                    $latestAt = $createdAt;
                }
            }

            $leads[] = [
                'id' => $subscriberId,
                'email' => (string) ($row['email'] ?? ''),
                'contact_name' => (string) ($row['contact_name'] ?? ''),
                'company_name' => (string) ($row['company_name'] ?? ''),
                'source_label' => (string) ($row['source_label'] ?? ''),
                'notes' => (string) ($row['notes'] ?? ''),
                'status' => (string) ($row['status'] ?? ''),
                'stage' => (string) ($row['stage'] ?? 'new'),
                'closed_reason' => (string) ($row['closed_reason'] ?? ''),
                'assignee_user_id' => (string) ($row['assignee_user_id'] ?? ''),
                'next_followup_at' => (string) ($row['next_followup_at'] ?? ''),
                'plans' => implode(', ', $plans),
                'subscription_count' => (string) count($subscriberSubs),
                'active_subscription_count' => (string) $activeCount,
                'created_at' => (string) ($row['created_at'] ?? ''),
                'latest_activity_at' => $latestAt,
            ];
        }

        usort($leads, static fn (array $left, array $right): int => strcmp(
            (string) ($right['latest_activity_at'] ?? ''),
            (string) ($left['latest_activity_at'] ?? ''),
        ));

        return $leads;
    }

    /**
     * @return array{ok:bool,message:string,subscriber?:array<string, string>}
     */
    public function updateSubscriberStatus(
        string $workspaceId,
        string $subscriberId,
        string $status,
        ?string $stage = null,
        ?string $closedReason = null,
        ?string $assigneeUserId = null,
        ?string $nextFollowupAt = null,
        bool $updateStage = false,
        bool $updateClosedReason = false,
        bool $updateAssignee = false,
        bool $updateNextFollowupAt = false,
    ): array
    {
        if (!$this->shouldUseDatabase()) {
            return [
                'ok' => false,
                'message' => 'Lead updates require database storage mode.',
            ];
        }

        $workspaceId = trim($workspaceId);
        $subscriberId = trim($subscriberId);
        $status = trim($status);
        if ($workspaceId === '' || $subscriberId === '' || $status === '') {
            return [
                'ok' => false,
                'message' => 'Lead selection and status are required.',
            ];
        }

        if (!in_array($status, ['active', 'contacted', 'qualified', 'inactive'], true)) {
            return [
                'ok' => false,
                'message' => 'Unsupported lead status.',
            ];
        }
        if ($updateStage && $stage !== null && !in_array(trim($stage), ['new', 'discovery', 'proposal', 'won', 'lost'], true)) {
            return [
                'ok' => false,
                'message' => 'Unsupported lead stage.',
            ];
        }

        $subscriber = $this->firstRow(
            $this->db
                ->table('subscriber_accounts')
                ->where('workspace_id', $workspaceId)
                ->where('id', $subscriberId)
                ->limit(1)
                ->get()
        );
        if (!is_array($subscriber)) {
            return [
                'ok' => false,
                'message' => 'Unable to find the selected lead.',
            ];
        }

        $updates = [
            'status' => $status,
        ];
        if ($updateAssignee) {
            $updates['assignee_user_id'] = $assigneeUserId !== null && trim($assigneeUserId) !== ''
                ? trim($assigneeUserId)
                : null;
        }
        if ($updateStage) {
            $updates['stage'] = $stage !== null && trim($stage) !== '' ? trim($stage) : 'new';
        }
        if ($updateClosedReason) {
            $updates['closed_reason'] = $closedReason !== null && trim($closedReason) !== ''
                ? trim($closedReason)
                : null;
        }
        if ($updateNextFollowupAt) {
            $updates['next_followup_at'] = $nextFollowupAt !== null && trim($nextFollowupAt) !== ''
                ? trim($nextFollowupAt)
                : null;
        }

        $this->db
            ->table('subscriber_accounts')
            ->where('workspace_id', $workspaceId)
            ->where('id', $subscriberId)
            ->update($updates)
            ->run();

        return [
            'ok' => true,
            'message' => 'Lead status updated.',
            'subscriber' => [
                'id' => (string) ($subscriber['id'] ?? ''),
                'email' => (string) ($subscriber['email'] ?? ''),
                'status' => $status,
                'stage' => $updates['stage'] ?? (string) ($subscriber['stage'] ?? 'new'),
                'closed_reason' => $updates['closed_reason'] ?? (string) ($subscriber['closed_reason'] ?? ''),
                'assignee_user_id' => $updates['assignee_user_id'] ?? (string) ($subscriber['assignee_user_id'] ?? ''),
                'next_followup_at' => $updates['next_followup_at'] ?? (string) ($subscriber['next_followup_at'] ?? ''),
            ],
        ];
    }

    /**
     * @return array<string, string>|null
     */
    public function subscriberLeadDetail(string $workspaceId, string $subscriberId): ?array
    {
        if ($workspaceId === '' || $subscriberId === '' || !$this->shouldUseDatabase()) {
            return null;
        }

        foreach ($this->subscriberLeadsForWorkspace($workspaceId) as $lead) {
            if (trim((string) ($lead['id'] ?? '')) === trim($subscriberId)) {
                return $lead;
            }
        }

        return null;
    }

    /**
     * @return array<int, array<string, string>>
     */
    public function subscriberFollowups(string $workspaceId, string $subscriberId): array
    {
        if ($workspaceId === '' || $subscriberId === '' || !$this->shouldUseDatabase()) {
            return [];
        }

        $rows = $this->rows(
            $this->db
                ->table('subscriber_followups')
                ->where('workspace_id', $workspaceId)
                ->where('subscriber_id', $subscriberId)
                ->orderBy('created_at', 'desc')
                ->get()
        );

        return array_map(static function (array $row): array {
            return [
                'id' => (string) ($row['id'] ?? ''),
                'actor' => (string) ($row['actor'] ?? ''),
                'body' => (string) ($row['body'] ?? ''),
                'created_at' => (string) ($row['created_at'] ?? ''),
            ];
        }, $rows);
    }

    /**
     * @return array{ok:bool,message:string}
     */
    public function addSubscriberFollowup(string $workspaceId, string $subscriberId, string $actor, string $body): array
    {
        if ($workspaceId === '' || $subscriberId === '' || !$this->shouldUseDatabase()) {
            return [
                'ok' => false,
                'message' => 'Lead followups require database storage mode.',
            ];
        }

        $body = trim($body);
        if ($body === '') {
            return [
                'ok' => false,
                'message' => 'Followup note is required.',
            ];
        }

        $this->db->table('subscriber_followups')->insert([
            'id' => $this->nextId('followup'),
            'workspace_id' => $workspaceId,
            'subscriber_id' => $subscriberId,
            'actor' => trim($actor) !== '' ? trim($actor) : 'system',
            'body' => $body,
            'created_at' => $this->timestamp(),
        ])->run();

        return [
            'ok' => true,
            'message' => 'Followup note added.',
        ];
    }

    /**
     * @return array<int, array<string, string>>
     */
    public function recentAssistantQuestions(string $workspaceId): array
    {
        if ($workspaceId === '' || !$this->shouldUseDatabase()) {
            return [];
        }

        $sessions = $this->rows(
            $this->db
                ->table('chat_sessions')
                ->where('workspace_id', $workspaceId)
                ->get()
        );

        usort($sessions, static fn (array $left, array $right): int => strcmp((string) ($right['created_at'] ?? ''), (string) ($left['created_at'] ?? '')));

        return array_map(function (array $row): array {
            return [
                'title' => (string) ($row['title'] ?? ''),
                'created_at' => (string) ($row['created_at'] ?? ''),
            ];
        }, array_slice($sessions, 0, 5));
    }

    /**
     * @return array<int, array<string, string>>
     */
    public function knowledgeGapInsights(string $workspaceId): array
    {
        if ($workspaceId === '' || !$this->shouldUseDatabase()) {
            return [];
        }

        $sessions = $this->rows(
            $this->db
                ->table('chat_sessions')
                ->where('workspace_id', $workspaceId)
                ->get()
        );
        $messages = $this->rows($this->db->table('chat_messages')->get());

        $assistantBySession = [];
        foreach ($messages as $message) {
            if ((string) ($message['role'] ?? '') !== 'assistant') {
                continue;
            }
            $assistantBySession[(string) ($message['session_id'] ?? '')] = (string) ($message['body'] ?? '');
        }

        $gaps = [];
        foreach ($sessions as $session) {
            $sessionId = (string) ($session['id'] ?? '');
            $assistantBody = $assistantBySession[$sessionId] ?? '';
            if (!str_starts_with($assistantBody, '[gap]')) {
                continue;
            }
            $gaps[] = [
                'title' => (string) ($session['title'] ?? ''),
                'created_at' => (string) ($session['created_at'] ?? ''),
                'signal' => 'needs_knowledge',
            ];
        }

        usort($gaps, static fn (array $left, array $right): int => strcmp((string) ($right['created_at'] ?? ''), (string) ($left['created_at'] ?? '')));

        return array_slice($gaps, 0, 5);
    }

    private function shouldUseDatabase(): bool
    {
        if ($this->source !== 'db') {
            return false;
        }

        if ($this->databaseAvailable !== null) {
            return $this->databaseAvailable;
        }

        try {
            return $this->databaseAvailable = $this->db->connect();
        } catch (\Throwable) {
            return $this->databaseAvailable = false;
        }
    }

    /**
     * @param array<int, array<string, mixed>> $rows
     * @return array<int, array<string, mixed>>
     */
    private function mergeQueueRuntimeStatuses(string $workspaceId, array $rows): array
    {
        if ($workspaceId === '' || $rows === []) {
            return $rows;
        }

        $runtimeRows = $this->rows($this->db->queryParams(
            'SELECT queue, status, job_class, payload_json, available_at, updated_at, completed_at, failed_at, last_error FROM vslim_jobs WHERE payload_json LIKE ? ORDER BY id ASC',
            ['%"workspace_id":"' . $workspaceId . '"%']
        ));
        if ($runtimeRows === []) {
            return $rows;
        }

        $indexed = [];
        foreach ($rows as $row) {
            $indexed[(string) ($row['id'] ?? '')] = $row;
        }

        foreach ($runtimeRows as $runtime) {
            $payload = json_decode((string) ($runtime['payload_json'] ?? '{}'), true);
            if (!is_array($payload)) {
                continue;
            }
            $opsJobId = trim((string) ($payload['ops_job_id'] ?? ''));
            if ($opsJobId === '' || !isset($indexed[$opsJobId])) {
                continue;
            }

            $indexed[$opsJobId]['status'] = (string) ($runtime['status'] ?? ($indexed[$opsJobId]['status'] ?? 'queued'));
            $indexed[$opsJobId]['queue'] = (string) ($runtime['queue'] ?? '');
            $indexed[$opsJobId]['job_class'] = (string) ($runtime['job_class'] ?? '');
            $indexed[$opsJobId]['last_error'] = (string) ($runtime['last_error'] ?? '');
            $indexed[$opsJobId]['runtime_at'] = (string) (
                $runtime['completed_at']
                ?? $runtime['failed_at']
                ?? $runtime['updated_at']
                ?? $runtime['available_at']
                ?? ''
            );
        }

        return array_values($indexed);
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    private function rows(mixed $result): array
    {
        return is_array($result) ? array_values(array_filter($result, 'is_array')) : [];
    }

    /**
     * @return array<string, mixed>|null
     */
    private function firstRow(mixed $result): ?array
    {
        $rows = $this->rows($result);
        return $rows[0] ?? null;
    }

    /**
     * @param array<int, array<string, mixed>> $rows
     * @return array<int, array<string, mixed>>
     */
    private function normalizeAuditRows(array $rows): array
    {
        return array_map(function (array $row): array {
            $action = (string) ($row['action'] ?? '');
            $row['action_label'] = match ($action) {
                'knowledge.document.created' => 'Document created',
                'knowledge.document.updated' => 'Document updated',
                'knowledge.document.published' => 'Document published',
                'knowledge.entry.created' => 'Entry created',
                'knowledge.entry.updated' => 'Entry updated',
                'knowledge.entry.published' => 'Entry published',
                'workspace.member.invited' => 'Collaborator invited',
                'workspace.member.role_updated' => 'Collaborator role updated',
                'workspace.member.removed' => 'Collaborator removed',
                'workspace.subscriber.status_updated' => 'Lead status updated',
                'workspace.subscriber.followup_added' => 'Lead followup added',
                'workspace.subscriber.provisioning_queued' => 'Lead provisioning queued',
                'workspace.subscriber.provisioning_completed' => 'Lead provisioning step completed',
                'workspace.context.switched' => 'Workspace switched',
                'account.password.changed' => 'Password updated',
                'ops.job.queued' => 'Ops job queued',
                'ops.job.retried' => 'Ops job retried',
                'publish_release' => 'Release published',
                default => $action !== '' ? $action : 'unknown',
            };
            $row['target_preview'] = $this->snippet((string) ($row['target'] ?? ''), 120);

            return $row;
        }, $rows);
    }

    private function nextId(string $prefix): string
    {
        return $prefix . '-' . date('YmdHis') . '-' . substr(md5(uniqid($prefix, true)), 0, 8);
    }

    private function timestamp(): string
    {
        return date('Y-m-d H:i:s');
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
