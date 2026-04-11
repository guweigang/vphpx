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
            $rows = $this->normalizeDocuments(
                $this->rows(
                $this->db
                    ->table('knowledge_documents')
                    ->where('workspace_id', $workspaceId)
                    ->orderBy('id', 'asc')
                    ->get()
                )
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
            $rows = $this->normalizeEntries(
                $this->rows(
                    $this->db
                        ->table('knowledge_entries')
                        ->where('workspace_id', $workspaceId)
                        ->orderBy('id', 'asc')
                        ->get()
                )
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

    public function writesEnabled(): bool
    {
        return $this->shouldUseDatabase();
    }

    public function createDocument(string $workspaceId, string $title, string $sourceType): array
    {
        $now = $this->timestamp();
        $row = [
            'id' => $this->nextId('doc'),
            'workspace_id' => $workspaceId,
            'title' => $title,
            'source_type' => $sourceType,
            'status' => 'draft',
            'chunks' => 0,
            'updated_at' => $now,
            'created_at' => $now,
        ];

        $this->db->table('knowledge_documents')->insert($row)->run();

        return $row;
    }

    public function createEntry(string $workspaceId, string $kind, string $title, string $body, string $owner): array
    {
        $row = [
            'id' => $this->nextId('entry'),
            'workspace_id' => $workspaceId,
            'kind' => $kind,
            'title' => $title,
            'body' => $body,
            'status' => 'draft',
            'owner' => $owner,
            'created_at' => $this->timestamp(),
        ];

        $this->db->table('knowledge_entries')->insert($row)->run();

        return $row;
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
    private function normalizeDocuments(array $rows): array
    {
        return array_map(static function (array $row): array {
            $row['chunks'] = (string) ($row['chunks'] ?? '0');
            $row['updated_at'] = (string) ($row['updated_at'] ?? $row['created_at'] ?? '');
            $row['status'] = (string) ($row['status'] ?? 'draft');
            $row['source_type'] = (string) ($row['source_type'] ?? 'upload');
            return $row;
        }, $rows);
    }

    /**
     * @param array<int, array<string, mixed>> $rows
     * @return array<int, array<string, mixed>>
     */
    private function normalizeEntries(array $rows): array
    {
        return array_map(static function (array $row): array {
            $row['status'] = (string) ($row['status'] ?? 'draft');
            $row['owner'] = (string) ($row['owner'] ?? '');
            $row['body'] = (string) ($row['body'] ?? '');
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
}
