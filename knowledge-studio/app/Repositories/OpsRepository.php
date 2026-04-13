<?php
declare(strict_types=1);

namespace App\Repositories;

use App\Support\DemoCatalog;
use VSlim\Database\Manager;

final class OpsRepository
{
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
                return $rows;
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
                    ->orderBy('id', 'asc')
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

        try {
            return $this->db->connect();
        } catch (\Throwable) {
            return false;
        }
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    private function rows(mixed $result): array
    {
        return is_array($result) ? array_values(array_filter($result, 'is_array')) : [];
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
                'ops.job.queued' => 'Ops job queued',
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
