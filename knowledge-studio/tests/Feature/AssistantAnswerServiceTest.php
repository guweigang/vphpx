<?php
declare(strict_types=1);

use App\Repositories\KnowledgeRepository;
use App\Services\AssistantAnswerService;

it('builds an answer preview from the provided corpus', function (): void {
    $repo = new ReflectionClass(KnowledgeRepository::class);
    $service = new AssistantAnswerService($repo->newInstanceWithoutConstructor());

    $workspace = [
        'id' => 'ws-acme',
        'brand_name' => 'Acme Research',
    ];

    $documents = [
        [
            'id' => 'doc-1',
            'title' => '发布准入清单',
            'source_type' => 'markdown',
            'status' => 'published',
            'chunks' => '5',
        ],
        [
            'id' => 'doc-2',
            'title' => '草稿记录',
            'source_type' => 'upload',
            'status' => 'draft',
            'chunks' => '1',
        ],
    ];

    $entries = [
        [
            'id' => 'entry-1',
            'title' => '发布流程 FAQ',
            'kind' => 'faq',
            'status' => 'published',
            'owner' => 'editor@acme.test',
            'body' => '发布前需要完成审核、确认品牌口径一致，并记录审批结论。',
        ],
        [
            'id' => 'entry-2',
            'title' => '未发布条目',
            'kind' => 'topic',
            'status' => 'draft',
            'owner' => 'editor@acme.test',
            'body' => '这是一条不应优先进入公开答案的草稿。',
        ],
    ];

    $preview = $service->previewFromCorpus($workspace, '发布 品牌', $documents, $entries);

    expect($preview['question'] ?? '')->toBe('发布 品牌');
    expect((string) ($preview['answer'] ?? ''))->toContain('Acme Research');
    expect($preview['citations'] ?? [])->not->toBeEmpty();
    expect((string) ($preview['citations'][0]['status'] ?? ''))->toBe('published');
    expect((string) ($preview['citations'][0]['matched_terms'] ?? ''))->toContain('发布');
    expect((string) ($preview['diagnostics']['documents_seen'] ?? ''))->toBe('1');
    expect((string) ($preview['diagnostics']['entries_seen'] ?? ''))->toBe('1');
    expect((string) ($preview['diagnostics']['published_filter_used'] ?? ''))->toBe('1');
    expect((string) ($preview['diagnostics']['fallback_used'] ?? ''))->toBe('0');
});

it('marks fallback when only document matches are available', function (): void {
    $repo = new ReflectionClass(KnowledgeRepository::class);
    $service = new AssistantAnswerService($repo->newInstanceWithoutConstructor());

    $workspace = [
        'id' => 'ws-acme',
        'brand_name' => 'Acme Research',
    ];

    $preview = $service->previewFromCorpus($workspace, '发布', [
        [
            'id' => 'doc-1',
            'title' => '发布准入清单',
            'summary' => '发布前要核对审批节奏与品牌口径。',
            'body' => '发布材料已经整理完毕，适合直接进入公开助手。',
            'language' => 'zh-CN',
            'source_type' => 'markdown',
            'status' => 'published',
            'chunks' => '5',
        ],
    ], []);

    expect((string) ($preview['diagnostics']['documents_seen'] ?? ''))->toBe('1');
    expect((string) ($preview['diagnostics']['entries_seen'] ?? ''))->toBe('0');
    expect((string) ($preview['diagnostics']['fallback_used'] ?? ''))->toBe('0');
    expect((string) ($preview['answer'] ?? ''))->toContain('Acme Research');
});
