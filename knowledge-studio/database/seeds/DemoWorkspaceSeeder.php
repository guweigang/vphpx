<?php
declare(strict_types=1);

require_once dirname(__DIR__, 2) . '/app/Support/DemoCatalog.php';

return new class extends VSlim\Database\Seeder {
    public function run(): bool
    {
        $catalog = new App\Support\DemoCatalog();
        $db = $this->db();

        foreach ($catalog->users() as $user) {
            $this->insertIfMissing('users', (string) ($user['id'] ?? ''), [
                'id' => (string) ($user['id'] ?? ''),
                'name' => (string) ($user['name'] ?? ''),
                'email' => (string) ($user['email'] ?? ''),
                'role' => (string) ($user['role'] ?? ''),
                'created_at' => '2026-04-08 00:00:00',
            ]);
        }

        foreach ($catalog->workspaces() as $workspace) {
            $this->insertIfMissing('workspaces', (string) ($workspace['id'] ?? ''), [
                'id' => (string) ($workspace['id'] ?? ''),
                'slug' => (string) ($workspace['slug'] ?? ''),
                'name' => (string) ($workspace['name'] ?? ''),
                'brand_name' => (string) ($workspace['brand_name'] ?? ''),
                'plan' => (string) ($workspace['plan'] ?? ''),
                'created_at' => '2026-04-08 00:00:00',
            ]);
        }

        foreach ($catalog->users() as $user) {
            $this->insertIfMissing('workspace_members', 'member-' . (string) ($user['id'] ?? ''), [
                'id' => 'member-' . (string) ($user['id'] ?? ''),
                'workspace_id' => (string) ($user['workspace_id'] ?? ''),
                'user_id' => (string) ($user['id'] ?? ''),
                'role' => (string) ($user['role'] ?? ''),
                'created_at' => '2026-04-08 00:00:00',
            ]);
        }

        foreach ($catalog->documentsForWorkspace('ws-acme') as $document) {
            $this->insertIfMissing('knowledge_documents', (string) ($document['id'] ?? ''), [
                'id' => (string) ($document['id'] ?? ''),
                'workspace_id' => 'ws-acme',
                'title' => (string) ($document['title'] ?? ''),
                'summary' => (string) ($document['summary'] ?? $document['title'] ?? ''),
                'body' => (string) ($document['body'] ?? $document['summary'] ?? $document['title'] ?? ''),
                'language' => (string) ($document['language'] ?? 'zh-CN'),
                'source_type' => (string) ($document['source_type'] ?? ''),
                'status' => (string) ($document['status'] ?? ''),
                'chunks' => (int) ($document['chunks'] ?? 0),
                'updated_at' => (string) ($document['updated_at'] ?? '2026-04-08 00:00:00'),
                'created_at' => '2026-04-08 00:00:00',
            ]);
        }
        foreach ($catalog->documentsForWorkspace('ws-nova') as $document) {
            $this->insertIfMissing('knowledge_documents', (string) ($document['id'] ?? ''), [
                'id' => (string) ($document['id'] ?? ''),
                'workspace_id' => 'ws-nova',
                'title' => (string) ($document['title'] ?? ''),
                'summary' => (string) ($document['summary'] ?? $document['title'] ?? ''),
                'body' => (string) ($document['body'] ?? $document['summary'] ?? $document['title'] ?? ''),
                'language' => (string) ($document['language'] ?? 'zh-CN'),
                'source_type' => (string) ($document['source_type'] ?? ''),
                'status' => (string) ($document['status'] ?? ''),
                'chunks' => (int) ($document['chunks'] ?? 0),
                'updated_at' => (string) ($document['updated_at'] ?? '2026-04-08 00:00:00'),
                'created_at' => '2026-04-08 00:00:00',
            ]);
        }

        foreach ($catalog->entriesForWorkspace('ws-acme') as $entry) {
            $this->insertIfMissing('knowledge_entries', (string) ($entry['id'] ?? ''), [
                'id' => (string) ($entry['id'] ?? ''),
                'workspace_id' => 'ws-acme',
                'kind' => (string) ($entry['kind'] ?? ''),
                'title' => (string) ($entry['title'] ?? ''),
                'body' => (string) ($entry['body'] ?? $entry['title'] ?? ''),
                'status' => (string) ($entry['status'] ?? 'draft'),
                'owner' => (string) ($entry['owner'] ?? ''),
                'created_at' => '2026-04-08 00:00:00',
            ]);
        }
        foreach ($catalog->entriesForWorkspace('ws-nova') as $entry) {
            $this->insertIfMissing('knowledge_entries', (string) ($entry['id'] ?? ''), [
                'id' => (string) ($entry['id'] ?? ''),
                'workspace_id' => 'ws-nova',
                'kind' => (string) ($entry['kind'] ?? ''),
                'title' => (string) ($entry['title'] ?? ''),
                'body' => (string) ($entry['body'] ?? $entry['title'] ?? ''),
                'status' => (string) ($entry['status'] ?? 'draft'),
                'owner' => (string) ($entry['owner'] ?? ''),
                'created_at' => '2026-04-08 00:00:00',
            ]);
        }

        foreach (['ws-acme', 'ws-nova'] as $workspaceId) {
            $this->insertIfMissing('knowledge_releases', 'release-' . $workspaceId, [
                'id' => 'release-' . $workspaceId,
                'workspace_id' => $workspaceId,
                'version' => 'v0.1',
                'status' => 'published',
                'notes' => $workspaceId === 'ws-acme'
                    ? '首个公开版本，聚焦退款准入与高频结算问题。'
                    : '首个公开版本，聚焦政策研究引用与摘要规范。',
                'created_at' => '2026-04-08 00:00:00',
            ]);
            $this->insertIfMissing('assistant_profiles', 'assistant-' . $workspaceId, [
                'id' => 'assistant-' . $workspaceId,
                'workspace_id' => $workspaceId,
                'name' => $workspaceId === 'ws-acme' ? 'Acme Advisor' : 'Nova Desk',
                'visibility' => 'public',
                'created_at' => '2026-04-08 00:00:00',
            ]);
        }

        $this->insertIfMissing('subscriber_accounts', 'subscriber-acme-1', [
            'id' => 'subscriber-acme-1',
            'workspace_id' => 'ws-acme',
            'email' => 'ops-buyer@finco.test',
            'status' => 'active',
            'created_at' => '2026-04-08 09:00:00',
        ]);
        $this->insertIfMissing('subscriber_accounts', 'subscriber-acme-2', [
            'id' => 'subscriber-acme-2',
            'workspace_id' => 'ws-acme',
            'email' => 'research-lead@acmeclient.test',
            'status' => 'active',
            'created_at' => '2026-04-09 11:20:00',
        ]);
        $this->insertIfMissing('subscriptions', 'subscription-acme-1', [
            'id' => 'subscription-acme-1',
            'workspace_id' => 'ws-acme',
            'subscriber_id' => 'subscriber-acme-1',
            'plan' => 'starter',
            'status' => 'active',
            'created_at' => '2026-04-08 09:05:00',
        ]);
        $this->insertIfMissing('subscriptions', 'subscription-acme-2', [
            'id' => 'subscription-acme-2',
            'workspace_id' => 'ws-acme',
            'subscriber_id' => 'subscriber-acme-2',
            'plan' => 'team',
            'status' => 'active',
            'created_at' => '2026-04-09 11:25:00',
        ]);

        foreach ($catalog->releasesForWorkspace('ws-acme') as $release) {
            $releaseId = (string) ($release['id'] ?? '');
            foreach ($catalog->documentsForWorkspace('ws-acme') as $document) {
                if ((string) ($document['status'] ?? '') !== 'published') {
                    continue;
                }
                $this->insertIfMissing('knowledge_release_items', 'rel-item-' . $releaseId . '-' . (string) ($document['id'] ?? ''), [
                    'id' => 'rel-item-' . $releaseId . '-' . (string) ($document['id'] ?? ''),
                    'release_id' => $releaseId,
                    'workspace_id' => 'ws-acme',
                    'item_type' => 'document',
                    'item_id' => (string) ($document['id'] ?? ''),
                    'created_at' => '2026-04-08 00:00:00',
                ]);
            }
            foreach ($catalog->entriesForWorkspace('ws-acme') as $entry) {
                if ((string) ($entry['status'] ?? '') !== 'published') {
                    continue;
                }
                $this->insertIfMissing('knowledge_release_items', 'rel-item-' . $releaseId . '-' . (string) ($entry['id'] ?? ''), [
                    'id' => 'rel-item-' . $releaseId . '-' . (string) ($entry['id'] ?? ''),
                    'release_id' => $releaseId,
                    'workspace_id' => 'ws-acme',
                    'item_type' => 'entry',
                    'item_id' => (string) ($entry['id'] ?? ''),
                    'created_at' => '2026-04-08 00:00:00',
                ]);
            }
        }
        foreach ($catalog->releasesForWorkspace('ws-nova') as $release) {
            $releaseId = (string) ($release['id'] ?? '');
            foreach ($catalog->documentsForWorkspace('ws-nova') as $document) {
                if ((string) ($document['status'] ?? '') !== 'published') {
                    continue;
                }
                $this->insertIfMissing('knowledge_release_items', 'rel-item-' . $releaseId . '-' . (string) ($document['id'] ?? ''), [
                    'id' => 'rel-item-' . $releaseId . '-' . (string) ($document['id'] ?? ''),
                    'release_id' => $releaseId,
                    'workspace_id' => 'ws-nova',
                    'item_type' => 'document',
                    'item_id' => (string) ($document['id'] ?? ''),
                    'created_at' => '2026-04-08 00:00:00',
                ]);
            }
            foreach ($catalog->entriesForWorkspace('ws-nova') as $entry) {
                if ((string) ($entry['status'] ?? '') !== 'published') {
                    continue;
                }
                $this->insertIfMissing('knowledge_release_items', 'rel-item-' . $releaseId . '-' . (string) ($entry['id'] ?? ''), [
                    'id' => 'rel-item-' . $releaseId . '-' . (string) ($entry['id'] ?? ''),
                    'release_id' => $releaseId,
                    'workspace_id' => 'ws-nova',
                    'item_type' => 'entry',
                    'item_id' => (string) ($entry['id'] ?? ''),
                    'created_at' => '2026-04-08 00:00:00',
                ]);
            }
        }

        foreach ($catalog->jobsForWorkspace('ws-acme') as $job) {
            $this->insertIfMissing('jobs', (string) ($job['id'] ?? ''), [
                'id' => (string) ($job['id'] ?? ''),
                'workspace_id' => 'ws-acme',
                'name' => (string) ($job['name'] ?? ''),
                'status' => (string) ($job['status'] ?? ''),
                'queued_at' => (string) ($job['queued_at'] ?? '2026-04-08 00:00:00'),
            ]);
        }
        foreach ($catalog->jobsForWorkspace('ws-nova') as $job) {
            $this->insertIfMissing('jobs', (string) ($job['id'] ?? ''), [
                'id' => (string) ($job['id'] ?? ''),
                'workspace_id' => 'ws-nova',
                'name' => (string) ($job['name'] ?? ''),
                'status' => (string) ($job['status'] ?? ''),
                'queued_at' => (string) ($job['queued_at'] ?? '2026-04-08 00:00:00'),
            ]);
        }

        foreach ($catalog->auditLogsForWorkspace('ws-acme') as $log) {
            $this->insertIfMissing('audit_logs', (string) ($log['id'] ?? ''), [
                'id' => (string) ($log['id'] ?? ''),
                'workspace_id' => 'ws-acme',
                'actor' => (string) ($log['actor'] ?? ''),
                'action' => (string) ($log['action'] ?? ''),
                'target' => (string) ($log['target'] ?? ''),
                'created_at' => (string) ($log['created_at'] ?? '2026-04-08 00:00:00'),
            ]);
        }
        foreach ($catalog->auditLogsForWorkspace('ws-nova') as $log) {
            $this->insertIfMissing('audit_logs', (string) ($log['id'] ?? ''), [
                'id' => (string) ($log['id'] ?? ''),
                'workspace_id' => 'ws-nova',
                'actor' => (string) ($log['actor'] ?? ''),
                'action' => (string) ($log['action'] ?? ''),
                'target' => (string) ($log['target'] ?? ''),
                'created_at' => (string) ($log['created_at'] ?? '2026-04-08 00:00:00'),
            ]);
        }

        return true;
    }

    private function insertIfMissing(string $table, string $id, array $values): void
    {
        if ($id === '') {
            return;
        }

        $existing = $this->db()->table($table)->where('id', $id)->limit(1)->get();
        if (is_array($existing) && $existing !== []) {
            return;
        }

        $this->db()->table($table)->insert($values)->run();
    }
};
