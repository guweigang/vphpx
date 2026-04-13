<?php
declare(strict_types=1);

namespace App\Support;

final class LocalizedUrlBuilder
{
    public function __construct(private LocaleCatalog $locales)
    {
    }

    public function path(string $path, string $locale): string
    {
        return $this->locales->withLang($path, $locale);
    }

    public function home(string $locale): string
    {
        return $this->path('/', $locale);
    }

    public function login(string $locale): string
    {
        return $this->path('/login', $locale);
    }

    public function console(string $locale): string
    {
        return $this->path('/console', $locale);
    }

    public function consoleDocuments(string $locale): string
    {
        return $this->path('/console/knowledge/documents', $locale);
    }

    /**
     * @param array<string, string> $params
     */
    public function consoleDocumentsWithQuery(string $locale, array $params = []): string
    {
        $path = '/console/knowledge/documents';
        $query = http_build_query(array_filter($params, static fn (string $value): bool => trim($value) !== ''));
        if ($query !== '') {
            $path .= '?' . $query;
        }

        return $this->path($path, $locale);
    }

    public function consoleFaqs(string $locale): string
    {
        return $this->path('/console/knowledge/faqs', $locale);
    }

    /**
     * @param array<string, string> $params
     */
    public function consoleFaqsWithQuery(string $locale, array $params = []): string
    {
        $path = '/console/knowledge/faqs';
        $query = http_build_query(array_filter($params, static fn (string $value): bool => trim($value) !== ''));
        if ($query !== '') {
            $path .= '?' . $query;
        }

        return $this->path($path, $locale);
    }

    public function consoleDocumentEditor(string $documentId, string $locale): string
    {
        return $this->path('/console/knowledge/documents/' . trim($documentId), $locale);
    }

    public function consoleEntryEditor(string $entryId, string $locale): string
    {
        return $this->path('/console/knowledge/faqs/' . trim($entryId), $locale);
    }

    public function consoleOps(string $locale): string
    {
        return $this->path('/console/ops', $locale);
    }

    public function consoleReleases(string $locale): string
    {
        return $this->path('/console/releases', $locale);
    }

    public function consoleMembers(string $locale): string
    {
        return $this->path('/console/members', $locale);
    }

    public function consoleJobs(string $locale): string
    {
        return $this->path('/console/ops/jobs', $locale);
    }

    public function logout(string $locale): string
    {
        return $this->path('/logout', $locale);
    }

    public function brand(string $slug, string $locale): string
    {
        return $this->path('/brand/' . trim($slug), $locale);
    }

    /**
     * @param array<string, string> $params
     */
    public function brandWithQuery(string $slug, string $locale, array $params = []): string
    {
        $path = '/brand/' . trim($slug);
        $query = http_build_query(array_filter($params, static fn (string $value): bool => trim($value) !== ''));
        if ($query !== '') {
            $path .= '?' . $query;
        }

        return $this->path($path, $locale);
    }

    public function brandSubscribe(string $slug, string $locale): string
    {
        return $this->path('/brand/' . trim($slug) . '/subscribe', $locale);
    }

    public function brandDocument(string $slug, string $documentId, string $locale): string
    {
        return $this->path('/brand/' . trim($slug) . '/documents/' . trim($documentId), $locale);
    }

    public function brandEntry(string $slug, string $entryId, string $locale): string
    {
        return $this->path('/brand/' . trim($slug) . '/entries/' . trim($entryId), $locale);
    }

    public function assistant(string $slug, string $locale, string $question = ''): string
    {
        $params = [];
        if ($question !== '') {
            $params['q'] = $question;
        }

        return $this->assistantWithQuery($slug, $locale, $params);
    }

    /**
     * @param array<string, string> $params
     */
    public function assistantWithQuery(string $slug, string $locale, array $params = []): string
    {
        $path = '/brand/' . trim($slug) . '/assistant';
        $query = http_build_query(array_filter($params, static fn (string $value): bool => trim($value) !== ''));
        if ($query !== '') {
            $path .= '?' . $query;
        }

        return $this->path($path, $locale);
    }
}
