<?php
declare(strict_types=1);

namespace App\Domain\Knowledge;

final class KnowledgeEntry
{
    public function __construct(
        public readonly string $id,
        public readonly string $workspaceId,
        public readonly string $kind,
        public readonly string $title,
        public readonly string $coverageFocus,
        public readonly string $body,
        public readonly string $status,
        public readonly string $owner,
        public readonly string $createdAt,
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
            (string) ($row['kind'] ?? 'faq'),
            (string) ($row['title'] ?? ''),
            (string) ($row['coverage_focus'] ?? $row['title'] ?? ''),
            (string) ($row['body'] ?? ''),
            (string) ($row['status'] ?? 'draft'),
            (string) ($row['owner'] ?? ''),
            (string) ($row['created_at'] ?? ''),
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
            'kind' => $this->kind,
            'title' => $this->title,
            'coverage_focus' => $this->coverageFocus,
            'body' => $this->body,
            'status' => $this->status,
            'owner' => $this->owner,
            'created_at' => $this->createdAt,
        ];
    }
}
