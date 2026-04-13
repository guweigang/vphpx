<?php
declare(strict_types=1);

namespace App\Domain\PublicCatalog;

final class WorkspacePublicSnapshot
{
    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed> $metrics
     * @param array<string, mixed> $release
     * @param array<string, mixed> $profile
     * @param array<string, mixed> $publicPreview
     * @param array<int, SubscriptionOffer> $offers
     */
    public function __construct(
        public readonly ?array $workspace,
        public readonly array $metrics,
        public readonly array $release,
        public readonly array $profile,
        public readonly int $subscriptionCount,
        public readonly array $publicPreview,
        public readonly array $offers,
    ) {
    }

    public function workspaceId(): string
    {
        return is_array($this->workspace) ? (string) ($this->workspace['id'] ?? '') : '';
    }

    public function workspaceSlug(): string
    {
        return is_array($this->workspace) ? (string) ($this->workspace['slug'] ?? '') : '';
    }

    public function workspacePlan(): string
    {
        return is_array($this->workspace) ? trim((string) ($this->workspace['plan'] ?? 'team')) : 'team';
    }

    public function brandName(): string
    {
        return is_array($this->workspace)
            ? (string) ($this->workspace['brand_name'] ?? $this->workspace['name'] ?? '')
            : '';
    }
}
