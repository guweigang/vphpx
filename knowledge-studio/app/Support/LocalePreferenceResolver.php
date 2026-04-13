<?php
declare(strict_types=1);

namespace App\Support;

final class LocalePreferenceResolver
{
    public function __construct(private LocaleCatalog $locales)
    {
    }

    /**
     * @param array<string, mixed> $queryParams
     */
    public function resolve(array $queryParams, string $rawQuery, string $acceptLanguage): string
    {
        $preferred = array_key_exists('lang', $queryParams)
            ? (string) ($queryParams['lang'] ?? '')
            : '';

        if ($preferred === '') {
            parse_str($rawQuery, $fallback);
            $preferred = is_array($fallback) ? (string) ($fallback['lang'] ?? '') : '';
        }

        return $this->locales->resolve($preferred, $acceptLanguage);
    }
}
