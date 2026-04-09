<?php
declare(strict_types=1);

namespace App\Repositories;

use App\Support\DemoCatalog;
use VSlim\Database\Manager;

final class KnowledgeRepository
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
    public function documentsForWorkspace(string $workspaceId): array
    {
        if ($this->shouldUseDatabase()) {
            $rows = $this->rows(
                $this->db
                    ->table('knowledge_documents')
                    ->where('workspace_id', $workspaceId)
                    ->orderBy('id', 'asc')
                    ->get()
            );
            if ($rows !== []) {
                return $rows;
            }
        }

        return $this->catalog->documentsForWorkspace($workspaceId);
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    public function entriesForWorkspace(string $workspaceId): array
    {
        if ($this->shouldUseDatabase()) {
            $rows = $this->rows(
                $this->db
                    ->table('knowledge_entries')
                    ->where('workspace_id', $workspaceId)
                    ->orderBy('id', 'asc')
                    ->get()
            );
            if ($rows !== []) {
                return $rows;
            }
        }

        return $this->catalog->entriesForWorkspace($workspaceId);
    }

    /**
     * @return array<string, string|int>
     */
    public function metricsForWorkspace(string $workspaceId): array
    {
        if ($this->shouldUseDatabase()) {
            $documents = $this->documentsForWorkspace($workspaceId);
            $entries = $this->entriesForWorkspace($workspaceId);
            $published = 0;
            foreach ($documents as $document) {
                if (($document['status'] ?? '') === 'published') {
                    $published++;
                }
            }

            return [
                'documents' => count($documents),
                'entries' => count($entries),
                'jobs' => 0,
                'published_documents' => $published,
                'failed_jobs' => 0,
                'assistant_status' => $published > 0 ? 'published' : 'draft',
            ];
        }

        return $this->catalog->metricsForWorkspace($workspaceId);
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
}
