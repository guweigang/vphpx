<?php
declare(strict_types=1);

require_once dirname(__DIR__) . "/demo/psr_stubs.php";

if (!class_exists("SkeletonCatalogService", false)) {
    final class SkeletonCatalogService
    {
        public function describe(string $slug): array
        {
            return [
                "slug" => $slug,
                "title" => strtoupper($slug),
                "source" => "catalog-service",
            ];
        }
    }
}
