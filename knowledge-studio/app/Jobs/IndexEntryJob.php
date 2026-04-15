<?php
declare(strict_types=1);

namespace App\Jobs;

use App\Support\StudioDatabase;

final class IndexEntryJob
{
    public function handle(array $payload): void
    {
        $workspaceId = trim((string) ($payload['workspace_id'] ?? ''));
        $entryId = trim((string) ($payload['entry_id'] ?? ''));
        $opsJobId = trim((string) ($payload['ops_job_id'] ?? ''));

        if ($workspaceId === '' || $entryId === '') {
            throw new \RuntimeException('entry index job payload is missing workspace_id or entry_id');
        }

        $db = StudioDatabase::manager();
        if ($opsJobId !== '') {
            $this->updateOpsJobStatus($db, $opsJobId, 'running');
        }

        try {
            $rows = $db
                ->table('knowledge_entries')
                ->where('workspace_id', $workspaceId)
                ->where('id', $entryId)
                ->get();

            $entry = is_array($rows[0] ?? null) ? $rows[0] : null;
            if (!is_array($entry)) {
                throw new \RuntimeException('knowledge entry not found for indexing');
            }

            $body = trim((string) ($entry['body'] ?? ''));
            if ($body === '') {
                throw new \RuntimeException('knowledge entry body is empty');
            }

            if ($opsJobId !== '') {
                $this->updateOpsJobStatus($db, $opsJobId, 'completed');
            }
        } catch (\Throwable $e) {
            if ($opsJobId !== '') {
                $this->updateOpsJobStatus($db, $opsJobId, 'failed');
            }
            throw $e;
        }
    }

    private function updateOpsJobStatus(\VSlim\Database\Manager $db, string $jobId, string $status): void
    {
        $db
            ->table('jobs')
            ->where('id', $jobId)
            ->update([
                'status' => $status,
            ])
            ->run();
    }
}
