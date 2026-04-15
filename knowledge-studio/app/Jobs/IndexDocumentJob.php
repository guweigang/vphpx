<?php
declare(strict_types=1);

namespace App\Jobs;

use App\Support\DocumentChunkEstimator;
use App\Support\StudioDatabase;

final class IndexDocumentJob
{
    public function handle(array $payload): void
    {
        $workspaceId = trim((string) ($payload['workspace_id'] ?? ''));
        $documentId = trim((string) ($payload['document_id'] ?? ''));
        $opsJobId = trim((string) ($payload['ops_job_id'] ?? ''));

        if ($workspaceId === '' || $documentId === '') {
            throw new \RuntimeException('index job payload is missing workspace_id or document_id');
        }

        $db = StudioDatabase::manager();
        if ($opsJobId !== '') {
            $this->updateOpsJobStatus($db, $opsJobId, 'running');
        }

        try {
            $rows = $db
                ->table('knowledge_documents')
                ->where('workspace_id', $workspaceId)
                ->where('id', $documentId)
                ->get();

            $document = is_array($rows[0] ?? null) ? $rows[0] : null;
            if (!is_array($document)) {
                throw new \RuntimeException('document not found for indexing');
            }

            $body = trim((string) ($document['body'] ?? ''));
            $summary = trim((string) ($document['summary'] ?? ''));
            $title = trim((string) ($document['title'] ?? ''));
            $content = $body !== '' ? $body : ($summary !== '' ? $summary : $title);
            $chunks = DocumentChunkEstimator::estimate($content);

            $db
                ->table('knowledge_documents')
                ->where('workspace_id', $workspaceId)
                ->where('id', $documentId)
                ->update([
                    'chunks' => $chunks,
                    'updated_at' => $this->timestamp(),
                ])
                ->run();

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
    private function timestamp(): string
    {
        return date('Y-m-d H:i:s');
    }
}
