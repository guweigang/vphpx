<?php
declare(strict_types=1);

namespace App\Domain\PublicCatalog;

final class SubscriptionOffer
{
    /**
     * @param array<int, string> $capabilities
     */
    public function __construct(
        public readonly string $code,
        public readonly int $monthlyPrice,
        public readonly int $annualPrice,
        public readonly int $seatLimit,
        public readonly int $monthlyQuestions,
        public readonly bool $includesCitations,
        public readonly bool $includesExports,
        public readonly bool $includesPrioritySupport,
        public readonly bool $featured,
        public readonly array $capabilities,
    ) {
    }
}
