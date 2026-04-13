<?php
declare(strict_types=1);

use App\Support\LocaleCatalog;

it('keeps public-facing chinese copy product-oriented instead of sample-oriented', function (): void {
    $catalog = new LocaleCatalog();

    $home = $catalog->home('zh-CN');
    $login = $catalog->login('zh-CN');
    $brand = $catalog->brand('zh-CN');
    $assistant = $catalog->assistant('zh-CN');

    expect($home['tagline'])->not->toContain('示例');
    expect($home['footer_note'])->not->toContain('演示站');
    expect($login['card_demo_title'])->toBe('预置账号');
    expect($login['invalid_credentials'])->not->toContain('演示账号');
    expect($brand['footer_note'])->not->toContain('演示数据');
    expect($assistant['answer_hint'])->not->toContain('mock');
    expect($brand['subscribe_title'])->toBe('申请订阅接入');
    expect($brand['subscribe_submit_label'])->toBe('提交订阅申请');
});

it('keeps public-facing english copy product-oriented instead of sample-oriented', function (): void {
    $catalog = new LocaleCatalog();

    $home = $catalog->home('en');
    $login = $catalog->login('en');
    $brand = $catalog->brand('en');
    $assistant = $catalog->assistant('en');

    expect($home['tagline'])->not->toContain('sample');
    expect($home['sidebar_copy'])->not->toContain('sample');
    expect($login['card_demo_title'])->toBe('Seeded Identities');
    expect($login['invalid_credentials'])->not->toContain('demo credentials');
    expect($brand['footer_note'])->not->toContain('demo fallback');
    expect($assistant['answer_hint'])->not->toContain('mocked');
    expect($brand['subscribe_title'])->toBe('Request Subscription Access');
    expect($brand['subscribe_submit_label'])->toBe('Request Access');
    expect($catalog->consoleIndex('en')['priority_queue_title'])->toBe('Priority Queue');
});
