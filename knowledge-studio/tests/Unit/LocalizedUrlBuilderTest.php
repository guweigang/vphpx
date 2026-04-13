<?php
declare(strict_types=1);

use App\Support\LocaleCatalog;
use App\Support\LocalizedUrlBuilder;

it('builds localized workspace urls', function (): void {
    $urls = new LocalizedUrlBuilder(new LocaleCatalog());

    expect($urls->home('zh-CN'))->toBe('/');
    expect($urls->login('en'))->toBe('/login?lang=en');
    expect($urls->consoleDocuments('en'))->toBe('/console/knowledge/documents?lang=en');
    expect($urls->brand('acme-research', 'zh-CN'))->toBe('/brand/acme-research');
});

it('builds assistant urls and preserves query language rules', function (): void {
    $urls = new LocalizedUrlBuilder(new LocaleCatalog());

    expect($urls->assistant('acme-research', 'zh-CN'))->toBe('/brand/acme-research/assistant');
    expect($urls->assistant('acme-research', 'en'))->toBe('/brand/acme-research/assistant?lang=en');
    expect($urls->assistant('acme-research', 'en', '发布 节奏'))->toContain('/brand/acme-research/assistant?q=');
    expect($urls->assistant('acme-research', 'en', '发布 节奏'))->toContain('lang=en');
});

it('builds subscription-facing brand urls', function (): void {
    $urls = new LocalizedUrlBuilder(new LocaleCatalog());

    expect($urls->brandSubscribe('acme-research', 'zh-CN'))->toBe('/brand/acme-research/subscribe');
    expect($urls->brandSubscribe('acme-research', 'en'))->toBe('/brand/acme-research/subscribe?lang=en');
    expect($urls->brandWithQuery('acme-research', 'zh-CN', ['plan' => 'team']))->toBe('/brand/acme-research?plan=team');
    expect($urls->brandWithQuery('acme-research', 'en', ['plan' => 'enterprise']))->toBe('/brand/acme-research?plan=enterprise&lang=en');
});
