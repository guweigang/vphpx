<?php
declare(strict_types=1);

require __DIR__ . '/../bootstrap/http.php';

function ks_fail(string $message): never
{
    fwrite(STDERR, $message . PHP_EOL);
    exit(1);
}

function ks_assert(bool $condition, string $message): void
{
    if (!$condition) {
        ks_fail($message);
    }
}

function ks_form_request(string $method, string $path, array $data = [], string $cookie = ''): VSlim\Vhttpd\Request
{
    $body = http_build_query($data);
    $request = new VSlim\Vhttpd\Request($method, $path, $body);
    $request->set_headers([
        'content-type' => 'application/x-www-form-urlencoded',
    ]);
    if ($cookie !== '') {
        $request->set_cookies([
            'knowledge_studio_session' => $cookie,
        ]);
    }
    return $request;
}

function ks_extract_session_cookie(VSlim\Vhttpd\Response $response): string
{
    $header = $response->cookie_header();
    $pair = explode(';', $header, 2)[0] ?? '';
    $parts = explode('=', $pair, 2);
    return $parts[1] ?? '';
}

$app = build_knowledge_studio_app();
$source = (string) $app->container()->get('studio.storage.source');
ks_assert($source === 'db', 'studio.storage.source must be db for this smoke test');

$login = ks_form_request('POST', '/login', [
    'email' => 'owner@acme.test',
    'password' => 'demo123',
]);
$loginResponse = $app->dispatch_request($login);
ks_assert($loginResponse->status === 302, 'login must redirect');
$cookie = ks_extract_session_cookie($loginResponse);
ks_assert($cookie !== '', 'login must return session cookie');

$suffix = date('YmdHis') . '-' . substr(md5((string) microtime(true)), 0, 6);
$documentTitle = 'Smoke Doc ' . $suffix;
$entryTitle = 'Smoke FAQ ' . $suffix;
$jobName = 'Smoke Job ' . $suffix;

$documentRequest = ks_form_request('POST', '/console/knowledge/documents', [
    'title' => $documentTitle,
    'source_type' => 'upload',
], $cookie);
$documentResponse = $app->dispatch_request($documentRequest);
ks_assert($documentResponse->status === 302, 'document write must redirect');

$entryRequest = ks_form_request('POST', '/console/knowledge/faqs', [
    'kind' => 'faq',
    'title' => $entryTitle,
    'body' => 'Smoke body ' . $suffix,
], $cookie);
$entryResponse = $app->dispatch_request($entryRequest);
ks_assert($entryResponse->status === 302, 'entry write must redirect');

$jobRequest = ks_form_request('POST', '/console/ops/jobs', [
    'name' => $jobName,
], $cookie);
$jobResponse = $app->dispatch_request($jobRequest);
ks_assert($jobResponse->status === 302, 'job write must redirect');

$documentsPage = ks_form_request('GET', '/console/knowledge/documents', [], $cookie);
$documentsResponse = $app->dispatch_request($documentsPage);
ks_assert($documentsResponse->status === 200, 'documents page must render');
ks_assert(str_contains($documentsResponse->body, $documentTitle), 'documents page must include new document');

$entriesPage = ks_form_request('GET', '/console/knowledge/faqs', [], $cookie);
$entriesResponse = $app->dispatch_request($entriesPage);
ks_assert($entriesResponse->status === 200, 'entries page must render');
ks_assert(str_contains($entriesResponse->body, $entryTitle), 'entries page must include new entry');

$opsPage = ks_form_request('GET', '/console/ops', [], $cookie);
$opsResponse = $app->dispatch_request($opsPage);
ks_assert($opsResponse->status === 200, 'ops page must render');
ks_assert(str_contains($opsResponse->body, $jobName), 'ops page must include new job');

echo 'ok|', $documentTitle, '|', $entryTitle, '|', $jobName, PHP_EOL;
