<?php
declare(strict_types=1);

require_once dirname(__DIR__, 2) . '/app/Support/DemoCatalog.php';

return new class extends VSlim\Database\Seeder {
    public function run(): bool
    {
        $catalog = new App\Support\DemoCatalog();
        $db = $this->db();

        foreach ($catalog->users() as $user) {
            $db->table('users')->insert([
                'id' => (string) ($user['id'] ?? ''),
                'name' => (string) ($user['name'] ?? ''),
                'email' => (string) ($user['email'] ?? ''),
                'role' => (string) ($user['role'] ?? ''),
                'created_at' => '2026-04-08 00:00:00',
            ])->run();
        }

        foreach ($catalog->workspaces() as $workspace) {
            $db->table('workspaces')->insert([
                'id' => (string) ($workspace['id'] ?? ''),
                'slug' => (string) ($workspace['slug'] ?? ''),
                'name' => (string) ($workspace['name'] ?? ''),
                'brand_name' => (string) ($workspace['brand_name'] ?? ''),
                'plan' => (string) ($workspace['plan'] ?? ''),
                'created_at' => '2026-04-08 00:00:00',
            ])->run();
        }

        foreach ($catalog->users() as $user) {
            $db->table('workspace_members')->insert([
                'id' => 'member-' . (string) ($user['id'] ?? ''),
                'workspace_id' => (string) ($user['workspace_id'] ?? ''),
                'user_id' => (string) ($user['id'] ?? ''),
                'role' => (string) ($user['role'] ?? ''),
                'created_at' => '2026-04-08 00:00:00',
            ])->run();
        }

        foreach ($catalog->documentsForWorkspace('ws-acme') as $document) {
            $db->table('knowledge_documents')->insert([
                'id' => (string) ($document['id'] ?? ''),
                'workspace_id' => 'ws-acme',
                'title' => (string) ($document['title'] ?? ''),
                'source_type' => (string) ($document['source_type'] ?? ''),
                'status' => (string) ($document['status'] ?? ''),
                'created_at' => '2026-04-08 00:00:00',
            ])->run();
        }
        foreach ($catalog->documentsForWorkspace('ws-nova') as $document) {
            $db->table('knowledge_documents')->insert([
                'id' => (string) ($document['id'] ?? ''),
                'workspace_id' => 'ws-nova',
                'title' => (string) ($document['title'] ?? ''),
                'source_type' => (string) ($document['source_type'] ?? ''),
                'status' => (string) ($document['status'] ?? ''),
                'created_at' => '2026-04-08 00:00:00',
            ])->run();
        }

        foreach ($catalog->entriesForWorkspace('ws-acme') as $entry) {
            $db->table('knowledge_entries')->insert([
                'id' => (string) ($entry['id'] ?? ''),
                'workspace_id' => 'ws-acme',
                'kind' => (string) ($entry['kind'] ?? ''),
                'title' => (string) ($entry['title'] ?? ''),
                'body' => (string) ($entry['title'] ?? ''),
                'created_at' => '2026-04-08 00:00:00',
            ])->run();
        }
        foreach ($catalog->entriesForWorkspace('ws-nova') as $entry) {
            $db->table('knowledge_entries')->insert([
                'id' => (string) ($entry['id'] ?? ''),
                'workspace_id' => 'ws-nova',
                'kind' => (string) ($entry['kind'] ?? ''),
                'title' => (string) ($entry['title'] ?? ''),
                'body' => (string) ($entry['title'] ?? ''),
                'created_at' => '2026-04-08 00:00:00',
            ])->run();
        }

        foreach (['ws-acme', 'ws-nova'] as $workspaceId) {
            $db->table('knowledge_releases')->insert([
                'id' => 'release-' . $workspaceId,
                'workspace_id' => $workspaceId,
                'version' => 'v0.1',
                'status' => 'published',
                'created_at' => '2026-04-08 00:00:00',
            ])->run();
            $db->table('assistant_profiles')->insert([
                'id' => 'assistant-' . $workspaceId,
                'workspace_id' => $workspaceId,
                'name' => $workspaceId === 'ws-acme' ? 'Acme Advisor' : 'Nova Desk',
                'visibility' => 'public',
                'created_at' => '2026-04-08 00:00:00',
            ])->run();
        }

        foreach ($catalog->jobsForWorkspace('ws-acme') as $job) {
            $db->table('jobs')->insert([
                'id' => (string) ($job['id'] ?? ''),
                'workspace_id' => 'ws-acme',
                'name' => (string) ($job['name'] ?? ''),
                'status' => (string) ($job['status'] ?? ''),
                'queued_at' => (string) ($job['queued_at'] ?? '2026-04-08 00:00:00'),
            ])->run();
        }
        foreach ($catalog->jobsForWorkspace('ws-nova') as $job) {
            $db->table('jobs')->insert([
                'id' => (string) ($job['id'] ?? ''),
                'workspace_id' => 'ws-nova',
                'name' => (string) ($job['name'] ?? ''),
                'status' => (string) ($job['status'] ?? ''),
                'queued_at' => (string) ($job['queued_at'] ?? '2026-04-08 00:00:00'),
            ])->run();
        }

        foreach ($catalog->auditLogsForWorkspace('ws-acme') as $log) {
            $db->table('audit_logs')->insert([
                'id' => (string) ($log['id'] ?? ''),
                'workspace_id' => 'ws-acme',
                'actor' => (string) ($log['actor'] ?? ''),
                'action' => (string) ($log['action'] ?? ''),
                'target' => (string) ($log['target'] ?? ''),
                'created_at' => (string) ($log['created_at'] ?? '2026-04-08 00:00:00'),
            ])->run();
        }
        foreach ($catalog->auditLogsForWorkspace('ws-nova') as $log) {
            $db->table('audit_logs')->insert([
                'id' => (string) ($log['id'] ?? ''),
                'workspace_id' => 'ws-nova',
                'actor' => (string) ($log['actor'] ?? ''),
                'action' => (string) ($log['action'] ?? ''),
                'target' => (string) ($log['target'] ?? ''),
                'created_at' => (string) ($log['created_at'] ?? '2026-04-08 00:00:00'),
            ])->run();
        }

        return true;
    }
};
