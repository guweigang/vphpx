<?php
declare(strict_types=1);

namespace App\Domain\Knowledge;

final class KnowledgeDocument
{
    public function __construct(
        public readonly string $id,
        public readonly string $workspaceId,
        public readonly string $title,
        public readonly string $coverageFocus,
        public readonly string $summary,
        public readonly string $body,
        public readonly string $language,
        public readonly string $sourceType,
        public readonly string $status,
        public readonly string $chunks,
        public readonly string $updatedAt,
    ) {
    }

    /**
     * @param array<string, mixed> $row
     */
    public static function fromArray(array $row): self
    {
        return new self(
            (string) ($row['id'] ?? ''),
            (string) ($row['workspace_id'] ?? ''),
            (string) ($row['title'] ?? ''),
            (string) ($row['coverage_focus'] ?? $row['title'] ?? ''),
            (string) ($row['summary'] ?? $row['title'] ?? ''),
            (string) ($row['body'] ?? $row['summary'] ?? $row['title'] ?? ''),
            (string) ($row['language'] ?? 'zh-CN'),
            (string) ($row['source_type'] ?? 'upload'),
            (string) ($row['status'] ?? 'draft'),
            (string) ($row['chunks'] ?? '0'),
            (string) ($row['updated_at'] ?? ''),
        );
    }

    /**
     * @return array<string, string>
     */
    public function toArray(): array
    {
        return [
            'id' => $this->id,
            'workspace_id' => $this->workspaceId,
            'title' => $this->title,
            'coverage_focus' => $this->coverageFocus,
            'summary' => $this->summary,
            'body' => $this->body,
            'language' => $this->language,
            'source_type' => $this->sourceType,
            'status' => $this->status,
            'chunks' => $this->chunks,
            'updated_at' => $this->updatedAt,
        ];
    }
}
