<?php
declare(strict_types=1);

use App\Services\ConsoleWorkspaceService;

it('prioritizes first publish before other follow-up work', function (): void {
    $service = (new ReflectionClass(ConsoleWorkspaceService::class))->newInstanceWithoutConstructor();
    $method = new ReflectionMethod(ConsoleWorkspaceService::class, 'priorityQueue');

    $items = $method->invoke(
        $service,
        [
            'published_documents' => 0,
            'assistant_status' => 'draft',
        ],
        [
            'count' => 2,
        ],
        [
            ['title' => 'SOC2 evidence pack', 'created_at' => '2026-04-11 12:00:00'],
        ],
    );

    expect($items)->toBeArray();
    expect($items[0]['priority'] ?? '')->toBe('P0');
    expect($items[0]['title'] ?? '')->toContain('Publish the first document set');
    expect($items[0]['target'] ?? '')->toBe('/console/knowledge/documents');
});

it('surfaces knowledge gaps and subscription demand as actionable priorities', function (): void {
    $service = (new ReflectionClass(ConsoleWorkspaceService::class))->newInstanceWithoutConstructor();
    $method = new ReflectionMethod(ConsoleWorkspaceService::class, 'priorityQueue');

    $items = $method->invoke(
        $service,
        [
            'published_documents' => 3,
            'assistant_status' => 'published',
        ],
        [
            'count' => 3,
        ],
        [
            ['title' => 'Enterprise SSO policy', 'created_at' => '2026-04-11 12:30:00'],
        ],
    );

    expect($items)->toHaveCount(2);
    expect($items[0]['title'] ?? '')->toContain('Fill knowledge gaps');
    expect($items[1]['title'] ?? '')->toContain('Follow up on active subscription demand');
});
