<?php
declare(strict_types=1);

namespace App\Support;

final class DemoCatalog
{
    private const PASSWORD = 'demo123';

    /**
     * @return array<string, mixed>|null
     */
    public function findUserById(string $id): ?array
    {
        foreach ($this->users() as $user) {
            if (($user['id'] ?? '') === $id) {
                return $user;
            }
        }

        return null;
    }

    /**
     * @return array<string, mixed>|null
     */
    public function findUserByEmail(string $email): ?array
    {
        $normalized = strtolower(trim($email));
        foreach ($this->users() as $user) {
            if (strtolower((string) ($user['email'] ?? '')) === $normalized) {
                return $user;
            }
        }

        return null;
    }

    public function authenticate(string $email, string $password): ?array
    {
        $user = $this->findUserByEmail($email);
        if ($user === null) {
            return null;
        }

        if (trim($password) !== self::PASSWORD) {
            return null;
        }

        return $user;
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    public function users(): array
    {
        return [
            [
                'id' => 'owner-1',
                'name' => 'Mira Chen',
                'email' => 'owner@acme.test',
                'role' => 'tenant_owner',
                'workspace_id' => 'ws-acme',
                'workspace_slug' => 'acme-research',
            ],
            [
                'id' => 'editor-1',
                'name' => 'Noah Lin',
                'email' => 'editor@acme.test',
                'role' => 'knowledge_editor',
                'workspace_id' => 'ws-acme',
                'workspace_slug' => 'acme-research',
            ],
            [
                'id' => 'owner-2',
                'name' => 'Iris Zhou',
                'email' => 'owner@nova.test',
                'role' => 'tenant_owner',
                'workspace_id' => 'ws-nova',
                'workspace_slug' => 'nova-advisory',
            ],
        ];
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    public function workspaces(): array
    {
        return [
            [
                'id' => 'ws-acme',
                'slug' => 'acme-research',
                'name' => 'Acme Research',
                'brand_name' => 'Acme Operations Brief',
                'tagline' => 'Knowledge operations for fintech support, reimbursement, and settlement teams.',
                'theme' => 'graphite',
                'plan' => 'team',
                'members' => 2,
            ],
            [
                'id' => 'ws-nova',
                'slug' => 'nova-advisory',
                'name' => 'Nova Advisory',
                'brand_name' => 'Nova Desk',
                'tagline' => 'Knowledge products for consulting and policy teams.',
                'theme' => 'navy',
                'plan' => 'team',
                'members' => 1,
            ],
        ];
    }

    /**
     * @return array<string, mixed>|null
     */
    public function findWorkspaceBySlug(string $slug): ?array
    {
        $normalized = trim($slug);
        foreach ($this->workspaces() as $workspace) {
            if (($workspace['slug'] ?? '') === $normalized) {
                return $workspace;
            }
        }

        return null;
    }

    /**
     * @return array<string, mixed>|null
     */
    public function defaultWorkspaceForUser(string $userId): ?array
    {
        $user = $this->findUserById($userId);
        if ($user === null) {
            return null;
        }

        return $this->findWorkspaceBySlug((string) ($user['workspace_slug'] ?? ''));
    }

    /**
     * @return array<int, array<string, string>>
     */
    public function membershipsForUser(string $userId): array
    {
        $user = $this->findUserById($userId);
        if ($user === null) {
            return [];
        }

        return [[
            'workspace_id' => (string) ($user['workspace_id'] ?? ''),
            'workspace_slug' => (string) ($user['workspace_slug'] ?? ''),
            'workspace_name' => (string) (($this->findWorkspaceBySlug((string) ($user['workspace_slug'] ?? ''))['name'] ?? '')),
            'role' => (string) ($user['role'] ?? 'subscriber'),
        ]];
    }

    public function passwordHint(): string
    {
        return self::PASSWORD;
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    public function documentsForWorkspace(string $workspaceId): array
    {
        return array_values(array_filter($this->documents(), static function (array $document) use ($workspaceId): bool {
            return (string) ($document['workspace_id'] ?? '') === $workspaceId;
        }));
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    public function entriesForWorkspace(string $workspaceId): array
    {
        return array_values(array_filter($this->entries(), static function (array $entry) use ($workspaceId): bool {
            return (string) ($entry['workspace_id'] ?? '') === $workspaceId;
        }));
    }

    /**
     * @return array<string, mixed>|null
     */
    public function findDocumentById(string $workspaceId, string $documentId): ?array
    {
        foreach ($this->documentsForWorkspace($workspaceId) as $document) {
            if ((string) ($document['id'] ?? '') === $documentId) {
                return $document;
            }
        }

        return null;
    }

    /**
     * @return array<string, mixed>|null
     */
    public function findEntryById(string $workspaceId, string $entryId): ?array
    {
        foreach ($this->entriesForWorkspace($workspaceId) as $entry) {
            if ((string) ($entry['id'] ?? '') === $entryId) {
                return $entry;
            }
        }

        return null;
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    public function jobsForWorkspace(string $workspaceId): array
    {
        return array_values(array_filter($this->jobs(), static function (array $job) use ($workspaceId): bool {
            return (string) ($job['workspace_id'] ?? '') === $workspaceId;
        }));
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    public function auditLogsForWorkspace(string $workspaceId): array
    {
        return array_values(array_filter($this->auditLogs(), static function (array $log) use ($workspaceId): bool {
            return (string) ($log['workspace_id'] ?? '') === $workspaceId;
        }));
    }

    /**
     * @return array<string, string|int>
     */
    public function metricsForWorkspace(string $workspaceId): array
    {
        $documents = $this->documentsForWorkspace($workspaceId);
        $entries = $this->entriesForWorkspace($workspaceId);
        $jobs = $this->jobsForWorkspace($workspaceId);
        $published = 0;
        foreach ($documents as $document) {
            if (($document['status'] ?? '') === 'published') {
                $published++;
            }
        }
        $failedJobs = 0;
        foreach ($jobs as $job) {
            if (($job['status'] ?? '') === 'failed') {
                $failedJobs++;
            }
        }

        return [
            'documents' => count($documents),
            'entries' => count($entries),
            'jobs' => count($jobs),
            'published_documents' => $published,
            'failed_jobs' => $failedJobs,
            'assistant_status' => $published > 0 ? 'published' : 'draft',
        ];
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    public function releasesForWorkspace(string $workspaceId): array
    {
        $status = ($this->metricsForWorkspace($workspaceId)['assistant_status'] ?? 'draft') === 'published'
            ? 'published'
            : 'draft';

        return [[
            'id' => 'release-' . $workspaceId,
            'workspace_id' => $workspaceId,
            'version' => $workspaceId === 'ws-acme' ? '2026.Q2' : '2026.Q2',
            'status' => (string) $status,
            'notes' => $workspaceId === 'ws-acme'
                ? '2026.Q2 release focused on reimbursement operations, settlement exceptions, and support-to-finance handoff.'
                : 'First public advisory release focused on policy references, research summaries, and reusable consulting answers.',
            'created_at' => '2026-04-08 00:00:00',
        ]];
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    private function documents(): array
    {
        return [
            [
                'id' => 'doc-acme-1',
                'workspace_id' => 'ws-acme',
                'title' => 'Reimbursement Operations Handbook',
                'coverage_focus' => 'Eligibility checks, approval routing, and payout communication',
                'summary' => 'Core operating guidance for eligibility checks, approval sequencing, exception handling, and customer communication in reimbursement workflows.',
                'body' => 'Reimbursement requests should move through intake validation, policy checks, and finance confirmation before payout. Teams should capture exception codes, reviewer decisions, and customer-visible timelines in one shared operating workflow so published guidance stays consistent.',
                'language' => 'en',
                'source_type' => 'markdown',
                'status' => 'published',
                'chunks' => 21,
                'updated_at' => '2026-04-08 14:00',
            ],
            [
                'id' => 'doc-acme-2',
                'workspace_id' => 'ws-acme',
                'title' => 'Settlement Exception Playbook',
                'coverage_focus' => 'Exception ownership, escalation windows, and settlement milestones',
                'summary' => 'Escalation guidance for payout exceptions, dispute ownership, and settlement communication across support and finance teams.',
                'body' => 'When a settlement exception enters escalation, the team should capture transaction context, assign an owner, reconcile settlement milestones, and publish the final resolution path back into the shared knowledge base so agents and operators reference the same answer.',
                'language' => 'en',
                'source_type' => 'pdf',
                'status' => 'published',
                'chunks' => 14,
                'updated_at' => '2026-04-08 15:10',
            ],
            [
                'id' => 'doc-acme-3',
                'workspace_id' => 'ws-acme',
                'title' => 'Support-to-Finance Handoff Guide',
                'coverage_focus' => 'Cross-team handoff checkpoints for payout and support cases',
                'summary' => 'A release-ready guide that defines who owns customer updates, payout approval, and escalation checkpoints once a case crosses team boundaries.',
                'body' => 'Operational handoff should define the support owner, finance approver, escalation window, and promised customer update cadence. Publishing these checkpoints as one shared guide reduces inconsistent answers during high-volume payout events.',
                'language' => 'en',
                'source_type' => 'notion',
                'status' => 'published',
                'chunks' => 11,
                'updated_at' => '2026-04-09 10:30',
            ],
            [
                'id' => 'doc-nova-1',
                'workspace_id' => 'ws-nova',
                'title' => 'Policy Research Starter Kit',
                'coverage_focus' => 'Evidence capture, memo intake, and citation-ready research output',
                'summary' => 'A starter guide for policy research teams to normalize memo intake, evidence capture, and recommendation writing.',
                'body' => 'Policy researchers should retain the issuing body, decision date, regulatory scope, and recommendation summary for every memo so downstream answers stay auditable and easy to cite.',
                'language' => 'en',
                'source_type' => 'notion',
                'status' => 'published',
                'chunks' => 12,
                'updated_at' => '2026-04-08 11:30',
            ],
        ];
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    private function entries(): array
    {
        return [
            [
                'id' => 'entry-acme-1',
                'workspace_id' => 'ws-acme',
                'kind' => 'faq',
                'title' => 'How do reimbursement requests reach final approval?',
                'coverage_focus' => 'Final approval path for reimbursement cases',
                'body' => 'Reimbursement approvals move from intake review to policy validation, then require finance confirmation before final release to the customer-facing channel.',
                'status' => 'published',
                'owner' => 'Mira Chen',
                'created_at' => '2026-04-08 14:00',
            ],
            [
                'id' => 'entry-acme-2',
                'workspace_id' => 'ws-acme',
                'kind' => 'topic',
                'title' => 'Settlement exception triage',
                'coverage_focus' => 'Triage flow for payout and settlement exceptions',
                'body' => 'Capture the exception context, map it to the settlement timeline, assign the responsible owner, and document the decision before publishing a guidance update.',
                'status' => 'published',
                'owner' => 'Noah Lin',
                'created_at' => '2026-04-08 15:10',
            ],
            [
                'id' => 'entry-acme-3',
                'workspace_id' => 'ws-acme',
                'kind' => 'faq',
                'title' => 'When should support escalate a payout case to finance?',
                'coverage_focus' => 'Escalation triggers from support into finance',
                'body' => 'Escalate once the payout is blocked by policy review, settlement mismatch, or manual approval thresholds. The case should include the exception reason, promised customer update, and current owner before it moves to finance.',
                'status' => 'published',
                'owner' => 'Mira Chen',
                'created_at' => '2026-04-09 10:35',
            ],
            [
                'id' => 'entry-nova-1',
                'workspace_id' => 'ws-nova',
                'kind' => 'faq',
                'title' => 'How to cite policy memos',
                'coverage_focus' => 'Citation rules for policy memo answers',
                'body' => 'Policy memos should include the issuing organization, memo date, decision context, and the recommendation summary used in the final answer.',
                'status' => 'published',
                'owner' => 'Iris Zhou',
                'created_at' => '2026-04-08 11:30',
            ],
        ];
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    private function jobs(): array
    {
        return [
            [
                'id' => 'job-acme-1',
                'workspace_id' => 'ws-acme',
                'name' => 'Index Reimbursement Operations Handbook',
                'status' => 'completed',
                'queued_at' => '2026-04-08 13:40',
            ],
            [
                'id' => 'job-acme-2',
                'workspace_id' => 'ws-acme',
                'name' => 'Parse Settlement Exception Playbook',
                'status' => 'completed',
                'queued_at' => '2026-04-08 15:02',
            ],
            [
                'id' => 'job-acme-3',
                'workspace_id' => 'ws-acme',
                'name' => 'Sync public validation cache',
                'status' => 'completed',
                'queued_at' => '2026-04-08 15:16',
            ],
            [
                'id' => 'job-nova-1',
                'workspace_id' => 'ws-nova',
                'name' => 'Rebuild topic release',
                'status' => 'completed',
                'queued_at' => '2026-04-08 10:40',
            ],
        ];
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    private function auditLogs(): array
    {
        return [
            [
                'id' => 'audit-acme-1',
                'workspace_id' => 'ws-acme',
                'actor' => 'Mira Chen',
                'action' => 'publish_release',
                'target' => 'Acme Operations Brief 2026.Q2',
                'created_at' => '2026-04-08 14:10',
            ],
            [
                'id' => 'audit-acme-2',
                'workspace_id' => 'ws-acme',
                'actor' => 'Noah Lin',
                'action' => 'update_entry',
                'target' => 'Settlement exception triage',
                'created_at' => '2026-04-08 15:12',
            ],
            [
                'id' => 'audit-acme-3',
                'workspace_id' => 'ws-acme',
                'actor' => 'Mira Chen',
                'action' => 'update_document',
                'target' => 'Support-to-Finance Handoff Guide',
                'created_at' => '2026-04-09 10:40',
            ],
            [
                'id' => 'audit-nova-1',
                'workspace_id' => 'ws-nova',
                'actor' => 'Iris Zhou',
                'action' => 'invite_member',
                'target' => 'reviewer@nova.test',
                'created_at' => '2026-04-08 09:20',
            ],
        ];
    }
}
