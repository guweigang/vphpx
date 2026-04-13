<?php
declare(strict_types=1);

use App\Support\LocaleCatalog;
use App\Support\LocalePreferenceResolver;

it('prefers explicit lang from parsed query params', function (): void {
    $resolver = new LocalePreferenceResolver(new LocaleCatalog());

    $locale = $resolver->resolve(['lang' => 'en'], '', 'zh-CN,zh;q=0.9');

    expect($locale)->toBe('en');
});

it('falls back to raw query parsing when query params are empty', function (): void {
    $resolver = new LocalePreferenceResolver(new LocaleCatalog());

    $locale = $resolver->resolve([], 'q=%E5%8F%91%E5%B8%83&lang=en', 'zh-CN,zh;q=0.9');

    expect($locale)->toBe('en');
});

it('falls back to accept-language when lang is absent', function (): void {
    $resolver = new LocalePreferenceResolver(new LocaleCatalog());

    $locale = $resolver->resolve([], 'q=%E5%8F%91%E5%B8%83', 'en-US,en;q=0.9');

    expect($locale)->toBe('en');
});

it('defaults to chinese when neither query nor header provides a locale', function (): void {
    $resolver = new LocalePreferenceResolver(new LocaleCatalog());

    $locale = $resolver->resolve([], '', '');

    expect($locale)->toBe('zh-CN');
});
