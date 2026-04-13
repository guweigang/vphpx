<?php
declare(strict_types=1);

use App\Support\LocaleCatalog;

it('defaults to chinese locale when no preference is provided', function (): void {
    $catalog = new LocaleCatalog();

    expect($catalog->resolve(null))->toBe('zh-CN');
    expect($catalog->resolve('', ''))->toBe('zh-CN');
});

it('resolves english locale from explicit preference or accept-language header', function (): void {
    $catalog = new LocaleCatalog();

    expect($catalog->resolve('en'))->toBe('en');
    expect($catalog->resolve('', 'en-US,en;q=0.9'))->toBe('en');
    expect($catalog->normalize('en-GB'))->toBe('en');
});

it('only appends lang query when non-default locale is requested', function (): void {
    $catalog = new LocaleCatalog();

    expect($catalog->withLang('/brand/acme-research', 'zh-CN'))->toBe('/brand/acme-research');
    expect($catalog->withLang('/brand/acme-research', 'en'))->toBe('/brand/acme-research?lang=en');
    expect($catalog->withLang('/brand/acme-research?q=发布', 'en'))->toBe('/brand/acme-research?q=%E5%8F%91%E5%B8%83&lang=en');
    expect($catalog->withLang('/brand/acme-research?q=发布&lang=en', 'zh-CN'))->toBe('/brand/acme-research?q=%E5%8F%91%E5%B8%83');
    expect($catalog->withLang('/brand/acme-research?q=发布&lang=zh-CN', 'en'))->toBe('/brand/acme-research?q=%E5%8F%91%E5%B8%83&lang=en');
});

it('builds shared locale toggle metadata', function (): void {
    $catalog = new LocaleCatalog();

    $zh = $catalog->shared('zh-CN', '/brand/acme-research');
    $en = $catalog->shared('en', '/brand/acme-research?lang=en');

    expect($zh['locale_html'])->toBe('zh-CN');
    expect($zh['lang_toggle_url'])->toBe('/brand/acme-research?lang=en');
    expect($en['locale_html'])->toBe('en');
    expect($en['lang_toggle_url'])->toBe('/brand/acme-research');
});
