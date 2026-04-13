<?php
declare(strict_types=1);

use App\Support\LocaleCatalog;
use App\Support\LocalePreferenceResolver;
use App\Support\LocalizedUrlBuilder;

it('keeps locale selection, copy selection, and localized links aligned for english flows', function (): void {
    $catalog = new LocaleCatalog();
    $resolver = new LocalePreferenceResolver($catalog);
    $urls = new LocalizedUrlBuilder($catalog);

    $locale = $resolver->resolve(
        ['lang' => 'en'],
        'q=launch+cadence&lang=en',
        'zh-CN,zh;q=0.9'
    );

    $copy = $catalog->assistant($locale);
    $shared = $catalog->shared($locale, $urls->assistant('acme-research', $locale, 'launch cadence'));
    $assistantUrl = $urls->assistant('acme-research', $locale, 'launch cadence');

    expect($locale)->toBe('en');
    expect($copy['ask_title'])->toBe('Ask the Assistant');
    expect($assistantUrl)->toContain('/brand/acme-research/assistant?q=launch+cadence');
    expect($assistantUrl)->toContain('lang=en');
    expect($shared['lang_toggle_url'])->toBe('/brand/acme-research/assistant?q=launch+cadence');
});

it('falls back to chinese locale and strips redundant lang from canonical urls', function (): void {
    $catalog = new LocaleCatalog();
    $resolver = new LocalePreferenceResolver($catalog);
    $urls = new LocalizedUrlBuilder($catalog);

    $locale = $resolver->resolve(
        [],
        'q=%E5%8F%91%E5%B8%83',
        ''
    );

    $copy = $catalog->brand($locale);
    $assistantUrl = $urls->assistant('acme-research', $locale, '发布 节奏');
    $brandUrl = $urls->brand('acme-research', $locale);

    expect($locale)->toBe('zh-CN');
    expect($copy['assistant_cta'])->toBe('进入知识助手');
    expect($assistantUrl)->toContain('/brand/acme-research/assistant?q=');
    expect($assistantUrl)->not->toContain('lang=');
    expect($brandUrl)->toBe('/brand/acme-research');
});
