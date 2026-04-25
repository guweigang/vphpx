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

function ks_form_request(string $method, string $path, array $data = [], string $cookie = ''): VSlim\VHttpd\Request
{
    $body = http_build_query($data);
    $request = new VSlim\VHttpd\Request($method, $path, $body);
    $request->setHeaders([
        'content-type' => 'application/x-www-form-urlencoded',
    ]);
    if ($cookie !== '') {
        $request->setCookies([
            'knowledge_studio_session' => $cookie,
        ]);
    }
    return $request;
}

function ks_extract_session_cookie(VSlim\VHttpd\Response $response): string
{
    $header = $response->cookieHeader();
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
$loginResponse = $app->dispatchRequest($login);
ks_assert($loginResponse->status === 302, 'login must redirect');
$cookie = ks_extract_session_cookie($loginResponse);
ks_assert($cookie !== '', 'login must return session cookie');

$suffix = date('YmdHis') . '-' . substr(md5((string) microtime(true)), 0, 6);
$documentTitle = 'Smoke Doc ' . $suffix;
$entryTitle = 'Smoke FAQ ' . $suffix;
$jobName = 'Smoke Job ' . $suffix;

$documentRequest = ks_form_request('POST', '/console/knowledge/documents', [
    'title' => $documentTitle,
    'body' => 'Smoke document body ' . $suffix,
    'source_type' => 'upload',
], $cookie);
$documentResponse = $app->dispatchRequest($documentRequest);
ks_assert($documentResponse->status === 302, 'document write must redirect');

$entryRequest = ks_form_request('POST', '/console/knowledge/faqs', [
    'kind' => 'faq',
    'title' => $entryTitle,
    'body' => 'Smoke body ' . $suffix,
], $cookie);
$entryResponse = $app->dispatchRequest($entryRequest);
ks_assert($entryResponse->status === 302, 'entry write must redirect');

$jobRequest = ks_form_request('POST', '/console/ops/jobs', [
    'name' => $jobName,
], $cookie);
$jobResponse = $app->dispatchRequest($jobRequest);
ks_assert($jobResponse->status === 302, 'job write must redirect');

$documentsPage = ks_form_request('GET', '/console/knowledge/documents', [], $cookie);
$documentsResponse = $app->dispatchRequest($documentsPage);
ks_assert($documentsResponse->status === 200, 'documents page must render');
ks_assert(str_contains($documentsResponse->body, $documentTitle), 'documents page must include new document');

$entriesPage = ks_form_request('GET', '/console/knowledge/faqs', [], $cookie);
$entriesResponse = $app->dispatchRequest($entriesPage);
ks_assert($entriesResponse->status === 200, 'entries page must render');
ks_assert(str_contains($entriesResponse->body, $entryTitle), 'entries page must include new entry');

$opsPage = ks_form_request('GET', '/console/ops', [], $cookie);
$opsResponse = $app->dispatchRequest($opsPage);
ks_assert($opsResponse->status === 200, 'ops page must render');
ks_assert(str_contains($opsResponse->body, $jobName), 'ops page must include new job');

$subscribersPage = ks_form_request('GET', '/console/subscribers', [], $cookie);
$subscribersResponse = $app->dispatchRequest($subscribersPage);
ks_assert($subscribersResponse->status === 200, 'subscribers page must render');
ks_assert(str_contains($subscribersResponse->body, 'subscriber-acme-1') || str_contains($subscribersResponse->body, 'ops-buyer@finco.test'), 'subscribers page must include seeded lead');

$statusNote = 'Qualified in smoke ' . $suffix;
$statusRequest = ks_form_request('POST', '/console/subscribers/subscriber-acme-1/status', [
    'status' => 'qualified',
    'stage' => 'won',
    'closed_reason' => 'Expanded to annual team plan after scope review',
    'note' => $statusNote,
    'assignee_user_id' => 'editor-1',
    'next_followup_at' => '2026-04-20T09:30',
    'redirect' => 'detail',
], $cookie);
$statusResponse = $app->dispatchRequest($statusRequest);
ks_assert($statusResponse->status === 302, 'subscriber status update must redirect');

$detailPage = ks_form_request('GET', '/console/subscribers/subscriber-acme-1', [], $cookie);
$detailResponse = $app->dispatchRequest($detailPage);
ks_assert($detailResponse->status === 200, 'subscriber detail page must render');
ks_assert(str_contains($detailResponse->body, $statusNote), 'subscriber detail page must include status followup note');
ks_assert(str_contains($detailResponse->body, 'won'), 'subscriber detail page must include updated opportunity stage');
ks_assert(str_contains($detailResponse->body, 'Expanded to annual team plan after scope review'), 'subscriber detail page must include closing reason');
ks_assert(str_contains($detailResponse->body, 'Noah Lin'), 'subscriber detail page must include assigned lead owner');
ks_assert(str_contains($detailResponse->body, '2026-04-20 09:30:00'), 'subscriber detail page must include next followup schedule');

$provisionRequest = ks_form_request('POST', '/console/subscribers/subscriber-acme-1/provisioning', [], $cookie);
$provisionResponse = $app->dispatchRequest($provisionRequest);
ks_assert($provisionResponse->status === 302, 'subscriber provisioning queue must redirect');

$detailWithChecklist = ks_form_request('GET', '/console/subscribers/subscriber-acme-1', [], $cookie);
$detailWithChecklistResponse = $app->dispatchRequest($detailWithChecklist);
ks_assert($detailWithChecklistResponse->status === 200, 'subscriber detail page must render after provisioning queue');
ks_assert(str_contains($detailWithChecklistResponse->body, 'Create workspace shell and plan settings'), 'subscriber detail page must include provisioning checklist');

$appDb = $app->container()->get('db');
$provisioningItems = $appDb->table('subscriber_provisioning_items')->where('workspace_id', 'ws-acme')->where('subscriber_id', 'subscriber-acme-1')->get();
$firstProvisioningItemId = '';
$inviteOwnerItemId = '';
$seedKnowledgeItemId = '';
foreach ($provisioningItems as $row) {
    $itemKey = (string) ($row['item_key'] ?? '');
    if ($firstProvisioningItemId === '') {
        $firstProvisioningItemId = (string) ($row['id'] ?? '');
    }
    if ($itemKey === 'invite_owner') {
        $inviteOwnerItemId = (string) ($row['id'] ?? '');
    }
    if ($itemKey === 'seed_knowledge') {
        $seedKnowledgeItemId = (string) ($row['id'] ?? '');
    }
    if ($firstProvisioningItemId !== '' && $inviteOwnerItemId !== '' && $seedKnowledgeItemId !== '') {
        break;
    }
}
ks_assert($firstProvisioningItemId !== '', 'provisioning checklist item must exist in database');
ks_assert($inviteOwnerItemId !== '', 'invite owner provisioning checklist item must exist in database');
ks_assert($seedKnowledgeItemId !== '', 'seed knowledge provisioning checklist item must exist in database');

$completeProvisioningRequest = ks_form_request('POST', '/console/subscribers/subscriber-acme-1/provisioning/' . $firstProvisioningItemId . '/complete', [], $cookie);
$completeProvisioningResponse = $app->dispatchRequest($completeProvisioningRequest);
ks_assert($completeProvisioningResponse->status === 302, 'provisioning checklist completion must redirect');

$completeInviteOwnerRequest = ks_form_request('POST', '/console/subscribers/subscriber-acme-1/provisioning/' . $inviteOwnerItemId . '/complete', [], $cookie);
$completeInviteOwnerResponse = $app->dispatchRequest($completeInviteOwnerRequest);
ks_assert($completeInviteOwnerResponse->status === 302, 'invite owner provisioning completion must redirect');

$completeSeedKnowledgeRequest = ks_form_request('POST', '/console/subscribers/subscriber-acme-1/provisioning/' . $seedKnowledgeItemId . '/complete', [], $cookie);
$completeSeedKnowledgeResponse = $app->dispatchRequest($completeSeedKnowledgeRequest);
ks_assert($completeSeedKnowledgeResponse->status === 302, 'seed knowledge provisioning completion must redirect');

$opsPageAfterProvision = ks_form_request('GET', '/console/ops', [], $cookie);
$opsResponseAfterProvision = $app->dispatchRequest($opsPageAfterProvision);
ks_assert($opsResponseAfterProvision->status === 200, 'ops page must render after provisioning queue');
ks_assert(str_contains($opsResponseAfterProvision->body, 'Provision workspace for ops-buyer@finco.test [lead:subscriber-acme-1]'), 'ops page must include provisioning job');
ks_assert(str_contains($opsResponseAfterProvision->body, 'Create workspace shell and plan settings'), 'ops page must include provisioning checklist rows');

$membersPage = ks_form_request('GET', '/console/members', [], $cookie);
$membersResponse = $app->dispatchRequest($membersPage);
ks_assert($membersResponse->status === 200, 'members page must render after provisioning completion');
ks_assert(str_contains($membersResponse->body, 'ops-buyer@finco.test'), 'members page must include invited customer owner');

$documentsPageAfterProvision = ks_form_request('GET', '/console/knowledge/documents', [], $cookie);
$documentsResponseAfterProvision = $app->dispatchRequest($documentsPageAfterProvision);
ks_assert($documentsResponseAfterProvision->status === 200, 'documents page must render after starter content provisioning');
ks_assert(str_contains($documentsResponseAfterProvision->body, 'Starter Launch Plan for ops-buyer@finco.test'), 'documents page must include starter onboarding document');

$entriesPageAfterProvision = ks_form_request('GET', '/console/knowledge/faqs', [], $cookie);
$entriesResponseAfterProvision = $app->dispatchRequest($entriesPageAfterProvision);
ks_assert($entriesResponseAfterProvision->status === 200, 'entries page must render after starter content provisioning');
ks_assert(str_contains($entriesResponseAfterProvision->body, 'Starter FAQ for ops-buyer@finco.test'), 'entries page must include starter onboarding faq');

$releasesPageAfterProvision = ks_form_request('GET', '/console/releases', [], $cookie);
$releasesResponseAfterProvision = $app->dispatchRequest($releasesPageAfterProvision);
ks_assert($releasesResponseAfterProvision->status === 200, 'releases page must render after starter content provisioning');
ks_assert(str_contains($releasesResponseAfterProvision->body, 'onboarding-subscriber-acme-1'), 'releases page must include onboarding release scaffold');

echo 'ok|', $documentTitle, '|', $entryTitle, '|', $jobName, PHP_EOL;
