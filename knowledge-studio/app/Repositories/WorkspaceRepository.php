<?php
declare(strict_types=1);

namespace App\Repositories;

use App\Support\DemoCatalog;
use VSlim\Database\Manager;

final class WorkspaceRepository
{
    public function __construct(
        private DemoCatalog $catalog,
        private Manager $db,
        private string $source = 'demo',
    )
    {
    }

    /**
     * @return array<string, mixed>|null
     */
    public function defaultForUser(string $userId): ?array
    {
        if ($this->shouldUseDatabase()) {
            $membership = $this->firstRow(
                $this->db
                    ->table('workspace_members')
                    ->where('user_id', $userId)
                    ->limit(1)
                    ->get()
            );
            if (is_array($membership)) {
                $workspace = $this->firstRow(
                    $this->db
                        ->table('workspaces')
                        ->where('id', (string) ($membership['workspace_id'] ?? ''))
                        ->limit(1)
                        ->get()
                );
                if (is_array($workspace)) {
                    return $workspace;
                }
            }
        }

        return $this->catalog->defaultWorkspaceForUser($userId);
    }

    /**
     * @return array<string, mixed>|null
     */
    public function findBySlug(string $slug): ?array
    {
        if ($this->shouldUseDatabase()) {
            $workspace = $this->firstRow(
                $this->db
                    ->table('workspaces')
                    ->where('slug', $slug)
                    ->limit(1)
                    ->get()
            );
            if (is_array($workspace)) {
                return $workspace;
            }
        }

        return $this->catalog->findWorkspaceBySlug($slug);
    }

    /**
     * @return array<int, array<string, string>>
     */
    public function membershipsForUser(string $userId): array
    {
        if ($this->shouldUseDatabase()) {
            $rows = $this->rows(
                $this->db
                    ->table('workspace_members')
                    ->where('user_id', $userId)
                    ->get()
            );
            if ($rows !== []) {
                $mapped = [];
                foreach ($rows as $row) {
                    $workspace = $this->firstRow(
                        $this->db
                            ->table('workspaces')
                            ->where('id', (string) ($row['workspace_id'] ?? ''))
                            ->limit(1)
                            ->get()
                    );
                    $mapped[] = [
                        'workspace_id' => (string) ($row['workspace_id'] ?? ''),
                        'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
                        'role' => (string) ($row['role'] ?? ''),
                    ];
                }
                return $mapped;
            }
        }

        return $this->catalog->membershipsForUser($userId);
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
     * @return array<string, mixed>|null
     */
    private function firstRow(mixed $result): ?array
    {
        $rows = $this->rows($result);
        return $rows[0] ?? null;
    }
}
