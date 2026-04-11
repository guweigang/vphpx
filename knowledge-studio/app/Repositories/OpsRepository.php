<?php
declare(strict_types=1);

namespace App\Repositories;

use App\Support\DemoCatalog;
use VSlim\Database\Manager;

final class OpsRepository
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
    public function jobsForWorkspace(string $workspaceId): array
    {
        if ($this->shouldUseDatabase()) {
            $rows = $this->rows(
                $this->db
                    ->table('jobs')
                    ->where('workspace_id', $workspaceId)
                    ->orderBy('id', 'asc')
                    ->get()
            );
            if ($rows !== []) {
                return $rows;
            }
        }

        return $this->catalog->jobsForWorkspace($workspaceId);
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    public function auditLogsForWorkspace(string $workspaceId): array
    {
        if ($this->shouldUseDatabase()) {
            $rows = $this->rows(
                $this->db
                    ->table('audit_logs')
                    ->where('workspace_id', $workspaceId)
                    ->orderBy('id', 'asc')
                    ->get()
            );
            if ($rows !== []) {
                return $rows;
            }
        }

        return $this->catalog->auditLogsForWorkspace($workspaceId);
    }

    public function writesEnabled(): bool
    {
        return $this->shouldUseDatabase();
    }

    public function queueJob(string $workspaceId, string $name, string $status = 'queued'): array
    {
        $row = [
            'id' => $this->nextId('job'),
            'workspace_id' => $workspaceId,
            'name' => $name,
            'status' => $status,
            'queued_at' => $this->timestamp(),
        ];

        $this->db->table('jobs')->insert($row)->run();

        return $row;
    }

    public function recordAudit(string $workspaceId, string $actor, string $action, string $target): array
    {
        $row = [
            'id' => $this->nextId('audit'),
            'workspace_id' => $workspaceId,
            'actor' => $actor,
            'action' => $action,
            'target' => $target,
            'created_at' => $this->timestamp(),
        ];

        $this->db->table('audit_logs')->insert($row)->run();

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

    private function nextId(string $prefix): string
    {
        return $prefix . '-' . date('YmdHis') . '-' . substr(md5(uniqid($prefix, true)), 0, 8);
    }

    private function timestamp(): string
    {
        return date('Y-m-d H:i:s');
    }
}
