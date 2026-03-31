<?php
declare(strict_types=1);

namespace App\Http\Controllers;

use Psr\Http\Message\ServerRequestInterface;

final class CatalogController
{
    public function __construct(private \SkeletonCatalogService $catalog) {}

    public function show(ServerRequestInterface $request): array
    {
        $query = $request->getQueryParams();
        return [
            "status" => 200,
            "content_type" => "application/json; charset=utf-8",
            "body" => json_encode(
                [
                    "ok" => true,
                    "item" => $this->catalog->describe((string) $request->getAttribute("slug")),
                    "mw" => (string) $request->getAttribute("skeleton_layer", ""),
                    "trace" => (string) ($query["trace_id"] ?? ""),
                ],
                JSON_UNESCAPED_UNICODE,
            ),
        ];
    }
}
