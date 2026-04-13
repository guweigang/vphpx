<?php
declare(strict_types=1);

namespace App\Repositories;

use App\Domain\Knowledge\KnowledgeDocument;
use App\Domain\Knowledge\KnowledgeEntry;
use App\Domain\Knowledge\KnowledgeRelease;
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

    /**
     * @return array<int, array<string, mixed>>
     */
    public function releasesForWorkspace(string $workspaceId): array
    {
        if ($this->shouldUseDatabase()) {
            $rows = $this->rows(
                $this->db
                    ->table('knowledge_releases')
                    ->where('workspace_id', $workspaceId)
                    ->orderBy('created_at', 'desc')
                    ->get()
            );
            if ($rows !== []) {
                return $rows;
            }
        }

        return $this->catalog->releasesForWorkspace($workspaceId);
    }

    /**
     * @return array<string, array{documents:int,entries:int}>
     */
    public function releaseItemCounts(string $workspaceId): array
    {
        if (!$this->shouldUseDatabase()) {
            $counts = [];
            foreach ($this->releasesForWorkspace($workspaceId) as $row) {
                $releaseId = (string) ($row['id'] ?? '');
                if ($releaseId === '') {
                    continue;
                }
                $counts[$releaseId] = [
                    'documents' => count($this->releasedDocumentsForWorkspace($workspaceId)),
                    'entries' => count($this->releasedEntriesForWorkspace($workspaceId)),
                ];
            }
            return $counts;
        }

        try {
            $items = $this->rows(
                $this->db
                    ->table('knowledge_release_items')
                    ->where('workspace_id', $workspaceId)
                    ->get()
            );
        } catch (\Throwable) {
            return [];
        }

        $counts = [];
        foreach ($items as $item) {
            $releaseId = (string) ($item['release_id'] ?? '');
            $itemType = (string) ($item['item_type'] ?? '');
            if ($releaseId === '') {
                continue;
            }
            if (!isset($counts[$releaseId])) {
                $counts[$releaseId] = ['documents' => 0, 'entries' => 0];
            }
            if ($itemType === 'document') {
                $counts[$releaseId]['documents']++;
            } elseif ($itemType === 'entry') {
                $counts[$releaseId]['entries']++;
            }
        }

        return $counts;
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    public function releasedDocumentsForWorkspace(string $workspaceId): array
    {
        $release = $this->latestRelease($workspaceId);
        if ($release === null) {
            return $this->documentsForWorkspace($workspaceId);
        }

        return $this->filterReleaseItems(
            $workspaceId,
            $release->id,
            'document',
            $this->documentsForWorkspace($workspaceId),
        );
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    public function releasedEntriesForWorkspace(string $workspaceId): array
    {
        $release = $this->latestRelease($workspaceId);
        if ($release === null) {
            return $this->entriesForWorkspace($workspaceId);
        }

        return $this->filterReleaseItems(
            $workspaceId,
            $release->id,
            'entry',
            $this->entriesForWorkspace($workspaceId),
        );
    }

    public function createDocument(
        string $workspaceId,
        string $title,
        string $coverageFocus,
        string $summary,
        string $body,
        string $language,
        string $sourceType,
    ): array
    {
        $now = $this->timestamp();
        $body = trim($body);
        $summary = trim($summary) !== '' ? trim($summary) : $title;
        $row = [
            'id' => $this->nextId('doc'),
            'workspace_id' => $workspaceId,
            'title' => $title,
            'coverage_focus' => trim($coverageFocus) !== '' ? trim($coverageFocus) : $title,
            'summary' => $summary,
            'body' => $body !== '' ? $body : $summary,
            'language' => $language !== '' ? $language : 'zh-CN',
            'source_type' => $sourceType,
            'status' => 'draft',
            'chunks' => $this->estimateChunks($body !== '' ? $body : $summary),
            'updated_at' => $now,
            'created_at' => $now,
        ];

        $this->db->table('knowledge_documents')->insert($row)->run();

        return $row;
    }

    public function createEntry(string $workspaceId, string $kind, string $title, string $coverageFocus, string $body, string $owner): array
    {
        $row = [
            'id' => $this->nextId('entry'),
            'workspace_id' => $workspaceId,
            'kind' => $kind,
            'title' => $title,
            'coverage_focus' => trim($coverageFocus) !== '' ? trim($coverageFocus) : $title,
            'body' => $body,
            'status' => 'draft',
            'owner' => $owner,
            'created_at' => $this->timestamp(),
        ];

        $this->db->table('knowledge_entries')->insert($row)->run();

        return $row;
    }

    /**
     * @param array<int, string> $documentIds
     * @param array<int, string> $entryIds
     */
    public function createRelease(
        string $workspaceId,
        string $version,
        string $status = 'published',
        string $notes = '',
        array $documentIds = [],
        array $entryIds = [],
    ): KnowledgeRelease
    {
        $row = [
            'id' => $this->nextId('release'),
            'workspace_id' => $workspaceId,
            'version' => $version,
            'status' => $status,
            'notes' => $notes,
            'created_at' => $this->timestamp(),
        ];

        if ($this->shouldUseDatabase()) {
            $this->db->table('knowledge_releases')->insert($row)->run();
            $this->snapshotReleaseItems($workspaceId, (string) $row['id'], $documentIds, $entryIds);
        }

        return KnowledgeRelease::fromArray($row);
    }

    public function findDocument(string $workspaceId, string $documentId): ?KnowledgeDocument
    {
        foreach ($this->documentsForWorkspace($workspaceId) as $row) {
            if ((string) ($row['id'] ?? '') === $documentId) {
                return KnowledgeDocument::fromArray($row);
            }
        }

        return null;
    }

    public function findEntry(string $workspaceId, string $entryId): ?KnowledgeEntry
    {
        foreach ($this->entriesForWorkspace($workspaceId) as $row) {
            if ((string) ($row['id'] ?? '') === $entryId) {
                return KnowledgeEntry::fromArray($row);
            }
        }

        return null;
    }

    public function latestRelease(string $workspaceId): ?KnowledgeRelease
    {
        $rows = $this->releasesForWorkspace($workspaceId);
        if (!is_array($rows[0] ?? null)) {
            return null;
        }

        return KnowledgeRelease::fromArray($rows[0]);
    }

    /**
     * @param array<int, array<string, mixed>> $rows
     * @return array<int, array<string, mixed>>
     */
    private function filterReleaseItems(string $workspaceId, string $releaseId, string $itemType, array $rows): array
    {
        if (!$this->shouldUseDatabase()) {
            return $this->publishedRows($rows);
        }

        try {
            $items = $this->rows(
                $this->db
                    ->table('knowledge_release_items')
                    ->where('workspace_id', $workspaceId)
                    ->where('release_id', $releaseId)
                    ->where('item_type', $itemType)
                    ->get()
            );
        } catch (\Throwable) {
            return $this->publishedRows($rows);
        }
        if ($items === []) {
            return $this->publishedRows($rows);
        }

        $allowed = [];
        foreach ($items as $item) {
            $allowed[] = (string) ($item['item_id'] ?? '');
        }

        return array_values(array_filter($rows, static function (array $row) use ($allowed): bool {
            return in_array((string) ($row['id'] ?? ''), $allowed, true);
        }));
    }

    /**
     * @param array<int, array<string, mixed>> $rows
     * @return array<int, array<string, mixed>>
     */
    private function publishedRows(array $rows): array
    {
        return array_values(array_filter($rows, static function (array $row): bool {
            return (string) ($row['status'] ?? '') === 'published';
        }));
    }

    /**
     * @param array<int, string> $documentIds
     * @param array<int, string> $entryIds
     */
    private function snapshotReleaseItems(string $workspaceId, string $releaseId, array $documentIds = [], array $entryIds = []): void
    {
        $now = $this->timestamp();
        $allowedDocumentIds = array_values(array_filter(array_map('strval', $documentIds), static fn (string $id): bool => trim($id) !== ''));
        $allowedEntryIds = array_values(array_filter(array_map('strval', $entryIds), static fn (string $id): bool => trim($id) !== ''));
        foreach ($this->documentsForWorkspace($workspaceId) as $document) {
            if ((string) ($document['status'] ?? '') !== 'published') {
                continue;
            }
            if ($allowedDocumentIds !== [] && !in_array((string) ($document['id'] ?? ''), $allowedDocumentIds, true)) {
                continue;
            }
            $this->db->table('knowledge_release_items')->insert([
                'id' => $this->nextId('rel-item'),
                'release_id' => $releaseId,
                'workspace_id' => $workspaceId,
                'item_type' => 'document',
                'item_id' => (string) ($document['id'] ?? ''),
                'created_at' => $now,
            ])->run();
        }

        foreach ($this->entriesForWorkspace($workspaceId) as $entry) {
            if ((string) ($entry['status'] ?? '') !== 'published') {
                continue;
            }
            if ($allowedEntryIds !== [] && !in_array((string) ($entry['id'] ?? ''), $allowedEntryIds, true)) {
                continue;
            }
            $this->db->table('knowledge_release_items')->insert([
                'id' => $this->nextId('rel-item'),
                'release_id' => $releaseId,
                'workspace_id' => $workspaceId,
                'item_type' => 'entry',
                'item_id' => (string) ($entry['id'] ?? ''),
                'created_at' => $now,
            ])->run();
        }
    }

    public function updateDocument(
        string $workspaceId,
        string $documentId,
        string $title,
        string $coverageFocus,
        string $summary,
        string $body,
        string $language,
        string $sourceType,
    ): ?KnowledgeDocument
    {
        if (!$this->shouldUseDatabase()) {
            $document = $this->findDocument($workspaceId, $documentId);
            if ($document === null) {
                return null;
            }

            return new KnowledgeDocument(
                $document->id,
                $document->workspaceId,
                $title,
                $coverageFocus !== '' ? $coverageFocus : $title,
                $summary !== '' ? $summary : $title,
                $body !== '' ? $body : ($summary !== '' ? $summary : $title),
                $language !== '' ? $language : $document->language,
                $sourceType,
                $document->status,
                (string) $this->estimateChunks($body !== '' ? $body : ($summary !== '' ? $summary : $title)),
                $this->timestamp(),
            );
        }

        $summary = trim($summary) !== '' ? trim($summary) : $title;
        $body = trim($body) !== '' ? trim($body) : $summary;
        $this->db
            ->table('knowledge_documents')
            ->where('workspace_id', $workspaceId)
            ->where('id', $documentId)
            ->update([
                'title' => $title,
                'coverage_focus' => trim($coverageFocus) !== '' ? trim($coverageFocus) : $title,
                'summary' => $summary,
                'body' => $body,
                'language' => $language !== '' ? $language : 'zh-CN',
                'source_type' => $sourceType,
                'chunks' => $this->estimateChunks($body),
                'updated_at' => $this->timestamp(),
            ])
            ->run();

        return $this->findDocument($workspaceId, $documentId);
    }

    public function publishDocument(string $workspaceId, string $documentId): ?KnowledgeDocument
    {
        if (!$this->shouldUseDatabase()) {
            $document = $this->findDocument($workspaceId, $documentId);
            if ($document === null) {
                return null;
            }

            return new KnowledgeDocument(
                $document->id,
                $document->workspaceId,
                $document->title,
                $document->coverageFocus,
                $document->summary,
                $document->body,
                $document->language,
                $document->sourceType,
                'published',
                $document->chunks,
                $this->timestamp(),
            );
        }

        $this->db
            ->table('knowledge_documents')
            ->where('workspace_id', $workspaceId)
            ->where('id', $documentId)
            ->update([
                'status' => 'published',
                'updated_at' => $this->timestamp(),
            ])
            ->run();

        return $this->findDocument($workspaceId, $documentId);
    }

    public function updateEntry(string $workspaceId, string $entryId, string $kind, string $title, string $coverageFocus, string $body, string $owner): ?KnowledgeEntry
    {
        if (!$this->shouldUseDatabase()) {
            $entry = $this->findEntry($workspaceId, $entryId);
            if ($entry === null) {
                return null;
            }

            return new KnowledgeEntry(
                $entry->id,
                $entry->workspaceId,
                $kind,
                $title,
                $coverageFocus !== '' ? $coverageFocus : $title,
                $body,
                $entry->status,
                $owner !== '' ? $owner : $entry->owner,
                $entry->createdAt,
            );
        }

        $this->db
            ->table('knowledge_entries')
            ->where('workspace_id', $workspaceId)
            ->where('id', $entryId)
            ->update([
                'kind' => $kind,
                'title' => $title,
                'coverage_focus' => trim($coverageFocus) !== '' ? trim($coverageFocus) : $title,
                'body' => $body,
                'owner' => $owner,
            ])
            ->run();

        return $this->findEntry($workspaceId, $entryId);
    }

    public function publishEntry(string $workspaceId, string $entryId): ?KnowledgeEntry
    {
        if (!$this->shouldUseDatabase()) {
            $entry = $this->findEntry($workspaceId, $entryId);
            if ($entry === null) {
                return null;
            }

            return new KnowledgeEntry(
                $entry->id,
                $entry->workspaceId,
                $entry->kind,
                $entry->title,
                $entry->coverageFocus,
                $entry->body,
                'published',
                $entry->owner,
                $entry->createdAt,
            );
        }

        $this->db
            ->table('knowledge_entries')
            ->where('workspace_id', $workspaceId)
            ->where('id', $entryId)
            ->update([
                'status' => 'published',
            ])
            ->run();

        return $this->findEntry($workspaceId, $entryId);
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
            $row['coverage_focus'] = (string) ($row['coverage_focus'] ?? $row['title'] ?? '');
            $row['summary'] = (string) ($row['summary'] ?? $row['title'] ?? '');
            $row['body'] = (string) ($row['body'] ?? $row['summary'] ?? $row['title'] ?? '');
            $row['language'] = (string) ($row['language'] ?? 'zh-CN');
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
            $row['coverage_focus'] = (string) ($row['coverage_focus'] ?? $row['title'] ?? '');
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

    private function estimateChunks(string $body): int
    {
        $body = trim($body);
        if ($body === '') {
            return 0;
        }

        $length = mb_strlen($body, 'UTF-8');
        return max(1, (int) ceil($length / 280));
    }
}
