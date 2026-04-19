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

    public function consoleSubscribers(string $locale): string
    {
        return $this->path('/console/subscribers', $locale);
    }

    public function consoleSubscriberDetail(string $subscriberId, string $locale): string
    {
        return $this->path('/console/subscribers/' . trim($subscriberId), $locale);
    }

    public function consoleSubscriberStatus(string $subscriberId, string $locale): string
    {
        return $this->path('/console/subscribers/' . trim($subscriberId) . '/status', $locale);
    }

    public function consoleSubscriberFollowups(string $subscriberId, string $locale): string
    {
        return $this->path('/console/subscribers/' . trim($subscriberId) . '/followups', $locale);
    }

    public function consoleSubscriberProvisioning(string $subscriberId, string $locale): string
    {
        return $this->path('/console/subscribers/' . trim($subscriberId) . '/provisioning', $locale);
    }

    public function consoleSubscriberProvisioningComplete(string $subscriberId, string $itemId, string $locale): string
    {
        return $this->path('/console/subscribers/' . trim($subscriberId) . '/provisioning/' . trim($itemId) . '/complete', $locale);
    }

    public function consoleMemberRole(string $memberId, string $locale): string
    {
        return $this->path('/console/members/' . trim($memberId) . '/role', $locale);
    }

    public function consoleMemberRemove(string $memberId, string $locale): string
    {
        return $this->path('/console/members/' . trim($memberId) . '/remove', $locale);
    }

    public function consoleAccount(string $locale): string
    {
        return $this->path('/console/account', $locale);
    }

    public function consoleAccountPassword(string $locale): string
    {
        return $this->path('/console/account/password', $locale);
    }

    public function consoleWorkspaceSwitch(string $locale): string
    {
        return $this->path('/console/workspace', $locale);
    }

    public function consoleJobs(string $locale): string
    {
        return $this->path('/console/ops/jobs', $locale);
    }

    public function consoleJobRetry(string $jobId, string $locale): string
    {
        return $this->path('/console/ops/jobs/' . trim($jobId) . '/retry', $locale);
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

    public function validation(string $slug, string $locale, string $question = ''): string
    {
        $params = [];
        if ($question !== '') {
            $params['q'] = $question;
        }

        return $this->validationWithQuery($slug, $locale, $params);
    }

    /**
     * @param array<string, string> $params
     */
    public function validationWithQuery(string $slug, string $locale, array $params = []): string
    {
        $path = '/brand/' . trim($slug) . '/validation';
        $query = http_build_query(array_filter($params, static fn (string $value): bool => trim($value) !== ''));
        if ($query !== '') {
            $path .= '?' . $query;
        }

        return $this->path($path, $locale);
    }

    public function assistant(string $slug, string $locale, string $question = ''): string
    {
        return $this->validation($slug, $locale, $question);
    }

    /**
     * @param array<string, string> $params
     */
    public function assistantWithQuery(string $slug, string $locale, array $params = []): string
    {
        return $this->validationWithQuery($slug, $locale, $params);
    }
}
