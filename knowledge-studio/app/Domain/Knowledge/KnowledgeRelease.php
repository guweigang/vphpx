<?php
declare(strict_types=1);

namespace App\Domain\Knowledge;

final class KnowledgeRelease
{
    public function __construct(
        public readonly string $id,
        public readonly string $workspaceId,
        public readonly string $version,
        public readonly string $status,
        public readonly string $notes,
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
            (string) ($row['version'] ?? ''),
            (string) ($row['status'] ?? 'draft'),
            (string) ($row['notes'] ?? ''),
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
            'version' => $this->version,
            'status' => $this->status,
            'notes' => $this->notes,
            'created_at' => $this->createdAt,
        ];
    }
}
