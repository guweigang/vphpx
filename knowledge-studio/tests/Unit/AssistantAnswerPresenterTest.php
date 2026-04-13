<?php
declare(strict_types=1);

use App\Presenters\AssistantAnswerPresenter;

it('formats citations and diagnostics for the assistant page', function (): void {
    $presenter = new AssistantAnswerPresenter();
    $copy = [
        'kind_faq' => 'FAQ',
        'kind_topic' => '主题',
        'kind_document' => '文档',
    ];
    $preview = [
        'question' => '发布 品牌',
        'answer' => '演示答案',
        'diagnostics' => [
            'documents_seen' => '2',
            'entries_seen' => '1',
            'documents_ranked' => '1',
            'entries_ranked' => '1',
            'published_filter_used' => '1',
            'fallback_used' => '0',
        ],
        'citations' => [
            [
                'title' => '发布流程 FAQ',
                'kind' => 'faq',
                'status' => 'published',
                'excerpt' => '发布前需要完成审核。',
                'score' => '9',
                'matched_terms' => '发布, 品牌',
                'source_detail' => 'editor@acme.test',
            ],
        ],
    ];

    $presented = $presenter->present($preview, $copy);

    expect($presented['question'] ?? '')->toBe('发布 品牌');
    expect($presented['answer'] ?? '')->toBe('演示答案');
    expect($presented['citations'][0]['kind'] ?? '')->toBe('FAQ');
    expect($presented['diagnostics']['citation_count'] ?? '')->toBe('1');
    expect($presented['diagnostics']['top_score'] ?? '')->toBe('9');
    expect($presented['diagnostics']['documents_seen'] ?? '')->toBe('2');
    expect($presented['diagnostics']['entries_seen'] ?? '')->toBe('1');
    expect($presented['diagnostics']['published_filter_used'] ?? '')->toBe('1');
});

it('returns zeroed diagnostics when there are no citations', function (): void {
    $presenter = new AssistantAnswerPresenter();

    $presented = $presenter->present([
        'question' => '空问题',
        'answer' => '',
        'citations' => [],
    ], [
        'kind_faq' => 'FAQ',
        'kind_topic' => '主题',
        'kind_document' => '文档',
    ]);

    expect($presented['diagnostics']['citation_count'] ?? '')->toBe('0');
    expect($presented['diagnostics']['top_score'] ?? '')->toBe('0');
});
