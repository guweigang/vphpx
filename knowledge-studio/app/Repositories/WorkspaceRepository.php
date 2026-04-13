<?php
declare(strict_types=1);

namespace App\Repositories;

use App\Support\DemoCatalog;
use VSlim\Database\Manager;

final class WorkspaceRepository
{
    private const DEMO_PASSWORD = 'demo123';

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
                $workspace = $this->findWorkspaceById((string) ($membership['workspace_id'] ?? ''));
                if ($workspace !== null) {
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
            $workspace = $this->hydrateWorkspace($this->firstRow(
                $this->db
                    ->table('workspaces')
                    ->where('slug', $slug)
                    ->limit(1)
                    ->get()
            ));
            if (is_array($workspace)) {
                return $workspace;
            }
        }

        return $this->catalog->findWorkspaceBySlug($slug);
    }

    /**
     * @return array<string, mixed>|null
     */
    public function findUserById(string $userId): ?array
    {
        if ($this->shouldUseDatabase()) {
            $user = $this->firstRow(
                $this->db
                    ->table('users')
                    ->where('id', trim($userId))
                    ->limit(1)
                    ->get()
            );
            if (is_array($user)) {
                return $user;
            }
        }

        return $this->catalog->findUserById($userId);
    }

    /**
     * @return array<string, mixed>|null
     */
    public function findUserByEmail(string $email): ?array
    {
        if ($this->shouldUseDatabase()) {
            $user = $this->firstRow(
                $this->db
                    ->table('users')
                    ->where('email', strtolower(trim($email)))
                    ->limit(1)
                    ->get()
            );
            if (is_array($user)) {
                return $user;
            }
        }

        return $this->catalog->findUserByEmail($email);
    }

    /**
     * @return array<string, mixed>|null
     */
    public function authenticate(string $email, string $password): ?array
    {
        if (trim($password) !== self::DEMO_PASSWORD) {
            return null;
        }

        $user = $this->findUserByEmail($email);
        return is_array($user) ? $user : null;
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
                    $workspace = $this->findWorkspaceById((string) ($row['workspace_id'] ?? ''));
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

    /**
     * @return array<int, array<string, string>>
     */
    public function membersForWorkspace(string $workspaceId): array
    {
        $workspaceId = trim($workspaceId);
        if ($workspaceId === '') {
            return [];
        }

        if ($this->shouldUseDatabase()) {
            $rows = $this->rows(
                $this->db
                    ->table('workspace_members')
                    ->where('workspace_id', $workspaceId)
                    ->get()
            );
            $members = [];
            foreach ($rows as $row) {
                $user = $this->findUserById((string) ($row['user_id'] ?? ''));
                $members[] = [
                    'id' => (string) ($row['id'] ?? ''),
                    'user_id' => (string) ($row['user_id'] ?? ''),
                    'name' => is_array($user) ? (string) ($user['name'] ?? '') : '',
                    'email' => is_array($user) ? (string) ($user['email'] ?? '') : '',
                    'role' => (string) ($row['role'] ?? ''),
                    'created_at' => (string) ($row['created_at'] ?? ''),
                ];
            }

            return $members;
        }

        $members = [];
        foreach ($this->catalog->users() as $user) {
            if ((string) ($user['workspace_id'] ?? '') !== $workspaceId) {
                continue;
            }
            $members[] = [
                'id' => 'member-' . (string) ($user['id'] ?? ''),
                'user_id' => (string) ($user['id'] ?? ''),
                'name' => (string) ($user['name'] ?? ''),
                'email' => (string) ($user['email'] ?? ''),
                'role' => (string) ($user['role'] ?? ''),
                'created_at' => '2026-04-08 00:00:00',
            ];
        }

        return $members;
    }

    /**
     * @return array<string, string>|null
     */
    public function inviteMember(string $workspaceId, string $name, string $email, string $role): ?array
    {
        if (!$this->shouldUseDatabase()) {
            return null;
        }

        $workspaceId = trim($workspaceId);
        $name = trim($name);
        $email = strtolower(trim($email));
        $role = trim($role);
        if ($workspaceId === '' || $name === '' || $email === '' || $role === '') {
            return null;
        }

        $user = $this->findUserByEmail($email);
        if ($user === null) {
            $userId = $this->makeId('user', $workspaceId . ':' . $email);
            $user = [
                'id' => $userId,
                'name' => $name,
                'email' => $email,
                'role' => $role,
                'created_at' => date('Y-m-d H:i:s'),
            ];
            $this->db->table('users')->insert($user)->run();
        }

        $userId = (string) ($user['id'] ?? '');
        if ($userId === '') {
            return null;
        }

        $existing = $this->firstRow(
            $this->db
                ->table('workspace_members')
                ->where('workspace_id', $workspaceId)
                ->where('user_id', $userId)
                ->limit(1)
                ->get()
        );
        if ($existing === null) {
            $member = [
                'id' => $this->makeId('member', $workspaceId . ':' . $userId),
                'workspace_id' => $workspaceId,
                'user_id' => $userId,
                'role' => $role,
                'created_at' => date('Y-m-d H:i:s'),
            ];
            $this->db->table('workspace_members')->insert($member)->run();
            $existing = $member;
        }

        return [
            'id' => (string) ($existing['id'] ?? ''),
            'user_id' => $userId,
            'name' => (string) ($user['name'] ?? $name),
            'email' => (string) ($user['email'] ?? $email),
            'role' => (string) ($existing['role'] ?? $role),
            'created_at' => (string) ($existing['created_at'] ?? date('Y-m-d H:i:s')),
        ];
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
     * @return array<string, mixed>|null
     */
    private function findWorkspaceById(string $workspaceId): ?array
    {
        if (!$this->shouldUseDatabase()) {
            return null;
        }

        return $this->hydrateWorkspace($this->firstRow(
            $this->db
                ->table('workspaces')
                ->where('id', trim($workspaceId))
                ->limit(1)
                ->get()
        ));
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array<string, mixed>|null
     */
    private function hydrateWorkspace(?array $workspace): ?array
    {
        if (!is_array($workspace)) {
            return null;
        }

        $workspace['members'] = (string) count($this->rows(
            $this->db
                ->table('workspace_members')
                ->where('workspace_id', (string) ($workspace['id'] ?? ''))
                ->get()
        ));

        return $workspace;
    }

    private function makeId(string $prefix, string $seed): string
    {
        return $prefix . '-' . substr(sha1($seed), 0, 16);
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
