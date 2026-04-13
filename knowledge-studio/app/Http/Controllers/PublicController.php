<?php
declare(strict_types=1);

namespace App\Http\Controllers;

use App\Presenters\AssistantAnswerPresenter;
use App\Presenters\PublicBrandPresenter;
use App\Services\AssistantAnswerService;
use App\Services\PublicWorkspaceService;
use App\Support\DemoCatalog;
use App\Support\FrontendAsset;
use App\Support\LocaleCatalog;
use App\Support\LocalizedUrlBuilder;

final class PublicController extends \VSlim\Controller
{
    public function __construct(
        \VSlim\App $app,
        private DemoCatalog $catalog,
        private PublicWorkspaceService $public,
        private AssistantAnswerService $answers,
        private AssistantAnswerPresenter $answerPresenter,
        private PublicBrandPresenter $brandPresenter,
        private LocaleCatalog $locales,
        private LocalizedUrlBuilder $urls,
    )
    {
        parent::__construct($app);
    }

    public function landing(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        $viewer = $request->getAttribute('studio.viewer');
        $workspace = $this->public->resolveWorkspace(
            $request->getAttribute('studio.workspace'),
            $this->tenantFromPath($request),
            is_array($viewer) ? $viewer : null,
        );
        $data = $this->public->landingData(is_array($workspace) ? $workspace : null);
        $workspace = is_array($data['workspace'] ?? null) ? $data['workspace'] : $workspace;
        $metrics = is_array($data['metrics'] ?? null) ? $data['metrics'] : [];
        $release = is_array($data['release'] ?? null) ? $data['release'] : [];
        $profile = is_array($data['profile'] ?? null) ? $data['profile'] : [];
        $locale = $this->locales->resolve((string) $request->getAttribute('studio.locale', 'zh-CN'));
        $copy = $this->locales->brand($locale);
        $selectedPlan = $this->queryValue($request, 'plan');
        $brandSession = $this->app()->session($request);
        $brandUrl = $this->urls->brand(
            is_array($workspace) ? (string) ($workspace['slug'] ?? '') : $this->tenantFromPath($request),
            $locale,
        );
        $shared = $this->locales->shared($locale, $brandUrl);
        $snapshot = $this->public->snapshot(is_array($workspace) ? $workspace : null);
        $brandSurface = $this->brandPresenter->present($snapshot, $copy, $locale);

        return $this->render_with_layout('brand.html', 'layout.html', [
            'title' => is_array($workspace) ? (string) ($workspace['brand_name'] ?? '') : 'Brand',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'tagline' => is_array($workspace) ? (string) ($workspace['tagline'] ?? '') : '',
            'assistant_name' => (string) ($profile['name'] ?? ''),
            'assistant_visibility' => (string) ($profile['visibility'] ?? ''),
            'release_version' => (string) ($release['version'] ?? ''),
            'release_status' => (string) ($release['status'] ?? ''),
            'release_notes' => (string) ($release['notes'] ?? ''),
            'documents_total' => (string) ($metrics['documents'] ?? '0'),
            'entries_total' => (string) ($metrics['entries'] ?? '0'),
            'subscriber_count' => (string) ($data['subscription_count'] ?? '0'),
            'assistant_url' => (string) ($brandSurface['assistant_url'] ?? '#'),
            'subscribe_notice' => $brandSession->pullFlash('brand.subscribe.notice', ''),
            'subscribe_error' => $brandSession->pullFlash('brand.subscribe.error', ''),
            'subscribe_action' => is_array($workspace)
                ? $this->urls->brandSubscribe((string) ($workspace['slug'] ?? ''), $locale)
                : '#',
            'selected_plan' => $selectedPlan !== '' ? $selectedPlan : 'team',
            'selected_plan_starter' => ($selectedPlan === 'starter' ? 'selected' : ''),
            'selected_plan_team' => ($selectedPlan === '' || $selectedPlan === 'team' ? 'selected' : ''),
            'selected_plan_enterprise' => ($selectedPlan === 'enterprise' ? 'selected' : ''),
            'page_section' => $copy['page_section'],
            'nav_label' => is_array($workspace) ? (string) ($workspace['brand_name'] ?? '') : 'brand',
            'footer_note' => $copy['footer_note'],
            'sidebar_copy' => $copy['sidebar_copy'],
            'eyebrow' => $copy['eyebrow'],
            'tenant_label' => $copy['tenant_label'],
            'assistant_label' => $copy['assistant_label'],
            'release_label' => $copy['release_label'],
            'release_notes_title' => $copy['release_notes_title'],
            'documents_label' => $copy['documents_label'],
            'entries_label' => $copy['entries_label'],
            'subscribers_label' => $copy['subscribers_label'],
            'story_title' => $copy['story_title'],
            'story_body' => $copy['story_body'],
            'journey_title' => $copy['journey_title'],
            'journey_body' => $copy['journey_body'],
            'journey_one_title' => $copy['journey_one_title'],
            'journey_one_body' => $copy['journey_one_body'],
            'journey_two_title' => $copy['journey_two_title'],
            'journey_two_body' => $copy['journey_two_body'],
            'journey_three_title' => $copy['journey_three_title'],
            'journey_three_body' => $copy['journey_three_body'],
            'subscription_title' => $copy['subscription_title'],
            'subscription_body' => $copy['subscription_body'],
            'conversion_title' => $copy['conversion_title'],
            'conversion_body' => $copy['conversion_body'],
            'conversion_one_title' => $copy['conversion_one_title'],
            'conversion_one_body' => $copy['conversion_one_body'],
            'conversion_two_title' => $copy['conversion_two_title'],
            'conversion_two_body' => $copy['conversion_two_body'],
            'conversion_three_title' => $copy['conversion_three_title'],
            'conversion_three_body' => $copy['conversion_three_body'],
            'assistant_cta' => $copy['assistant_cta'],
            'offers_title' => (string) ($brandSurface['offers_title'] ?? ''),
            'offers_intro' => (string) ($brandSurface['offers_intro'] ?? ''),
            'proof_title' => (string) ($brandSurface['proof_title'] ?? ''),
            'proof_body' => (string) ($brandSurface['proof_body'] ?? ''),
            'preview_documents_title' => (string) ($brandSurface['preview_documents_title'] ?? ''),
            'preview_entries_title' => (string) ($brandSurface['preview_entries_title'] ?? ''),
            'public_preview' => $brandSurface['public_preview'] ?? ['documents' => [], 'entries' => []],
            'subscribe_title' => $copy['subscribe_title'],
            'subscribe_intro' => $copy['subscribe_intro'],
            'subscribe_email_label' => $copy['subscribe_email_label'],
            'subscribe_plan_label' => $copy['subscribe_plan_label'],
            'subscribe_submit_label' => $copy['subscribe_submit_label'],
            'frontend_style_url' => FrontendAsset::url('knowledge-studio.css'),
            'frontend_module_url' => FrontendAsset::url('knowledge-studio.js'),
            'lit_subscribe_empty_label' => $copy['lit_subscribe_empty_label'],
            'lit_subscribe_active_label' => $copy['lit_subscribe_active_label'],
            'lit_subscribe_helper_prefix' => $copy['lit_subscribe_helper_prefix'],
            'offers' => $brandSurface['offers'] ?? [],
            ...$shared,
        ]);
    }

    public function subscribe(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        $viewer = $request->getAttribute('studio.viewer');
        $workspace = $this->public->resolveWorkspace(
            $request->getAttribute('studio.workspace'),
            $this->tenantFromPath($request),
            is_array($viewer) ? $viewer : null,
        );
        $locale = $this->locales->resolve((string) $request->getAttribute('studio.locale', 'zh-CN'));
        $payload = $this->requestData($request);
        $result = $this->public->registerSubscriptionInterest(
            is_array($workspace) ? $workspace : null,
            trim((string) ($payload['email'] ?? '')),
            trim((string) ($payload['plan'] ?? 'team')),
        );

        return $this->flashRedirect(
            $request,
            is_array($workspace)
                ? $this->urls->brandWithQuery((string) ($workspace['slug'] ?? ''), $locale, [
                    'plan' => trim((string) ($payload['plan'] ?? 'team')),
                ])
                : $this->urls->home($locale),
            $result['ok'] ? 'brand.subscribe.notice' : 'brand.subscribe.error',
            $result['message'],
        );
    }

    public function assistant(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        $viewer = $request->getAttribute('studio.viewer');
        $workspace = $this->public->resolveWorkspace(
            $request->getAttribute('studio.workspace'),
            $this->tenantFromPath($request),
            is_array($viewer) ? $viewer : null,
        );
        $data = $this->public->assistantData(is_array($workspace) ? $workspace : null);
        $workspace = is_array($data['workspace'] ?? null) ? $data['workspace'] : $workspace;
        $metrics = is_array($data['metrics'] ?? null) ? $data['metrics'] : [];
        $release = is_array($data['release'] ?? null) ? $data['release'] : [];
        $profile = is_array($data['profile'] ?? null) ? $data['profile'] : [];
        $question = $this->queryValue($request, 'q');
        $preview = $this->answers->preview(is_array($workspace) ? $workspace : null, $question);
        $selectedPlan = $this->queryValue($request, 'plan');
        $locale = $this->locales->resolve((string) $request->getAttribute('studio.locale', 'zh-CN'));
        $copy = $this->locales->assistant($locale);
        $shared = $this->locales->shared(
            $locale,
            is_array($workspace)
                ? $this->urls->assistantWithQuery((string) ($workspace['slug'] ?? ''), $locale, array_filter([
                    'q' => $question,
                    'plan' => $selectedPlan,
                ]))
                : $this->urls->assistantWithQuery($this->tenantFromPath($request), $locale, array_filter([
                    'q' => $question,
                    'plan' => $selectedPlan,
                ])),
        );
        $presented = $this->answerPresenter->present($preview, $copy);
        if ($question !== '') {
            $this->public->recordAssistantQuestion(
                is_array($workspace) ? $workspace : null,
                $question,
                (string) ($presented['answer'] ?? ''),
                is_array($presented['diagnostics'] ?? null) ? $presented['diagnostics'] : []
            );
        }

        return $this->render_with_layout('assistant.html', 'layout.html', [
            'title' => is_array($workspace) ? (string) ($workspace['brand_name'] ?? '') : 'Assistant',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'tagline' => is_array($workspace) ? (string) ($workspace['tagline'] ?? '') : '',
            'assistant_name' => (string) ($profile['name'] ?? ''),
            'assistant_visibility' => (string) ($profile['visibility'] ?? ''),
            'release_version' => (string) ($release['version'] ?? ''),
            'release_status' => (string) ($release['status'] ?? ''),
            'release_notes' => (string) ($release['notes'] ?? ''),
            'documents_total' => (string) ($metrics['documents'] ?? '0'),
            'entries_total' => (string) ($metrics['entries'] ?? '0'),
            'documents' => $this->withPublicLinks(is_array($workspace) ? $workspace : null, $data['documents'] ?? [], $locale, 'document'),
            'entries' => $this->withPublicLinks(is_array($workspace) ? $workspace : null, $data['entries'] ?? [], $locale, 'entry'),
            'subscriber_count' => (string) ($data['subscription_count'] ?? '0'),
            'question' => (string) ($presented['question'] ?? ''),
            'answer' => (string) ($presented['answer'] ?? ''),
            'citations' => $presented['citations'] ?? [],
            'diagnostics' => $presented['diagnostics'] ?? [],
            'empty_tip' => (string) ($presented['answer'] ?? '') === ''
                ? $copy['empty_tip']
                : '',
            'page_section' => $copy['page_section'],
            'nav_label' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : 'assistant',
            'footer_note' => $copy['footer_note'],
            'sidebar_copy' => $copy['sidebar_copy'],
            'eyebrow' => $copy['eyebrow'],
            'release_label' => $copy['release_label'],
            'release_notes_title' => $copy['release_notes_title'],
            'subscribers_label' => $copy['subscribers_label'],
            'ask_title' => $copy['ask_title'],
            'question_label' => $copy['question_label'],
            'question_placeholder' => $copy['question_placeholder'],
            'submit_label' => $copy['submit_label'],
            'back_brand_label' => $copy['back_brand_label'],
            'brand_url' => is_array($workspace)
                ? $this->urls->brand((string) ($workspace['slug'] ?? ''), $locale)
                : '#',
            'assistant_form_action' => is_array($workspace)
                ? $this->urls->assistant((string) ($workspace['slug'] ?? ''), $locale)
                : '#',
            'frontend_style_url' => FrontendAsset::url('knowledge-studio.css'),
            'frontend_module_url' => FrontendAsset::url('knowledge-studio.js'),
            'selected_plan' => $selectedPlan,
            'selected_plan_label' => $selectedPlan !== '' ? (string) ($copy['plan_' . $selectedPlan] ?? strtoupper($selectedPlan)) : '',
            'selected_plan_title' => $copy['selected_plan_title'],
            'selected_plan_body' => $copy['selected_plan_body'],
            'lit_empty_label' => $copy['lit_empty_label'],
            'lit_active_label' => $copy['lit_active_label'],
            'lit_helper_prefix' => $copy['lit_helper_prefix'],
            'posture_title' => $copy['posture_title'],
            'posture_body' => $copy['posture_body'],
            'journey_title' => $copy['journey_title'],
            'journey_body' => $copy['journey_body'],
            'journey_one_title' => $copy['journey_one_title'],
            'journey_one_body' => $copy['journey_one_body'],
            'journey_two_title' => $copy['journey_two_title'],
            'journey_two_body' => $copy['journey_two_body'],
            'journey_three_title' => $copy['journey_three_title'],
            'journey_three_body' => $copy['journey_three_body'],
            'slug_label' => $copy['slug_label'],
            'snapshot_label' => $copy['snapshot_label'],
            'discipline_label' => $copy['discipline_label'],
            'discipline_body' => $copy['discipline_body'],
            'answer_title' => $copy['answer_title'],
            'answer_hint' => $copy['answer_hint'],
            'validation_title' => $copy['validation_title'],
            'validation_body' => $copy['validation_body'],
            'validation_one_title' => $copy['validation_one_title'],
            'validation_one_body' => $copy['validation_one_body'],
            'validation_two_title' => $copy['validation_two_title'],
            'validation_two_body' => $copy['validation_two_body'],
            'validation_three_title' => $copy['validation_three_title'],
            'validation_three_body' => $copy['validation_three_body'],
            'question_prefix' => $copy['question_prefix'],
            'citations_title' => $copy['citations_title'],
            'diagnostics_title' => $copy['diagnostics_title'],
            'citation_count_label' => $copy['citation_count_label'],
            'top_score_label' => $copy['top_score_label'],
            'documents_seen_label' => $copy['documents_seen_label'],
            'entries_seen_label' => $copy['entries_seen_label'],
            'documents_ranked_label' => $copy['documents_ranked_label'],
            'entries_ranked_label' => $copy['entries_ranked_label'],
            'published_filter_used_label' => $copy['published_filter_used_label'],
            'fallback_used_label' => $copy['fallback_used_label'],
            'score_label' => $copy['score_label'],
            'status_label' => $copy['status_label'],
            'coverage_focus_label' => $copy['coverage_focus_label'],
            'matched_terms_label' => $copy['matched_terms_label'],
            'source_detail_label' => $copy['source_detail_label'],
            'documents_title' => $copy['documents_title'],
            'entries_title' => $copy['entries_title'],
            ...$shared,
        ]);
    }

    public function document(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        $viewer = $request->getAttribute('studio.viewer');
        $workspace = $this->public->resolveWorkspace(
            $request->getAttribute('studio.workspace'),
            $this->tenantFromPath($request),
            is_array($viewer) ? $viewer : null,
        );
        $locale = $this->locales->resolve((string) $request->getAttribute('studio.locale', 'zh-CN'));
        $documentId = $this->pathParam($request, 'document');
        $document = $this->public->releasedDocumentDetail(is_array($workspace) ? $workspace : null, $documentId);
        if (!is_array($document)) {
            return $this->redirect(
                is_array($workspace)
                    ? $this->urls->brand((string) ($workspace['slug'] ?? ''), $locale)
                    : $this->urls->home($locale),
                302,
            );
        }

        return $this->renderPublicDetail($workspace, $locale, [
            'title' => (string) ($document['title'] ?? ''),
            'meta' => trim((string) ($document['source_type'] ?? '') . ' / ' . (string) ($document['language'] ?? 'zh-CN')),
            'coverage_focus' => (string) ($document['coverage_focus'] ?? ''),
            'summary' => (string) ($document['summary'] ?? ''),
            'body' => (string) ($document['body'] ?? ''),
            'back_url' => is_array($workspace) ? $this->urls->brand((string) ($workspace['slug'] ?? ''), $locale) : '#',
        ]);
    }

    public function entry(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        $viewer = $request->getAttribute('studio.viewer');
        $workspace = $this->public->resolveWorkspace(
            $request->getAttribute('studio.workspace'),
            $this->tenantFromPath($request),
            is_array($viewer) ? $viewer : null,
        );
        $locale = $this->locales->resolve((string) $request->getAttribute('studio.locale', 'zh-CN'));
        $entryId = $this->pathParam($request, 'entry');
        $entry = $this->public->releasedEntryDetail(is_array($workspace) ? $workspace : null, $entryId);
        if (!is_array($entry)) {
            return $this->redirect(
                is_array($workspace)
                    ? $this->urls->brand((string) ($workspace['slug'] ?? ''), $locale)
                    : $this->urls->home($locale),
                302,
            );
        }

        return $this->renderPublicDetail($workspace, $locale, [
            'title' => (string) ($entry['title'] ?? ''),
            'meta' => trim((string) ($entry['kind'] ?? 'faq') . ' / ' . (string) ($entry['owner'] ?? '')),
            'coverage_focus' => (string) ($entry['coverage_focus'] ?? ''),
            'summary' => (string) ($entry['body'] ?? ''),
            'body' => (string) ($entry['body'] ?? ''),
            'back_url' => is_array($workspace) ? $this->urls->brand((string) ($workspace['slug'] ?? ''), $locale) : '#',
        ]);
    }

    private function tenantFromPath(\VSlim\Psr7\ServerRequest $request): string
    {
        $parts = explode('/', trim($request->getUri()->getPath(), '/'));
        if (($parts[0] ?? '') !== 'brand') {
            return '';
        }

        return trim((string) ($parts[1] ?? ''));
    }

    private function queryValue(\VSlim\Psr7\ServerRequest $request, string $key): string
    {
        $params = $request->getQueryParams();
        if (is_array($params) && array_key_exists($key, $params)) {
            return trim((string) ($params[$key] ?? ''));
        }

        parse_str((string) $request->getUri()->getQuery(), $fallback);
        return is_array($fallback) ? trim((string) ($fallback[$key] ?? '')) : '';
    }

    private function pathParam(\VSlim\Psr7\ServerRequest $request, string $key): string
    {
        $value = $request->getAttribute($key);
        return is_scalar($value) ? trim((string) $value) : '';
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<int, array<string, mixed>> $rows
     * @return array<int, array<string, mixed>>
     */
    private function withPublicLinks(?array $workspace, array $rows, string $locale, string $type): array
    {
        $slug = is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '';

        return array_map(function (array $row) use ($slug, $locale, $type): array {
            $row['detail_url'] = $type === 'document'
                ? $this->urls->brandDocument($slug, (string) ($row['id'] ?? ''), $locale)
                : $this->urls->brandEntry($slug, (string) ($row['id'] ?? ''), $locale);
            return $row;
        }, $rows);
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, string> $detail
     */
    private function renderPublicDetail(?array $workspace, string $locale, array $detail): \VSlim\Vhttpd\Response
    {
        $shared = $this->locales->shared($locale, is_array($workspace) ? $this->urls->brand((string) ($workspace['slug'] ?? ''), $locale) : '/');
        $coverageFocus = trim((string) ($detail['coverage_focus'] ?? ''));
        $coverageLabel = $locale === 'en' ? 'Coverage Question' : '覆盖问题';

        return $this->render_with_layout('public_detail.html', 'layout.html', [
            'title' => $detail['title'] ?? 'Knowledge Detail',
            'page_section' => is_array($workspace) ? (string) ($workspace['brand_name'] ?? '') : 'Knowledge Detail',
            'nav_label' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : 'detail',
            'footer_note' => '',
            'sidebar_copy' => is_array($workspace) ? (string) ($workspace['tagline'] ?? '') : '',
            'eyebrow' => 'Public Knowledge',
            'detail_title' => $detail['title'] ?? '',
            'detail_meta' => $detail['meta'] ?? '',
            'detail_coverage_focus' => $coverageFocus,
            'coverage_focus_label' => $coverageLabel,
            'detail_summary' => $detail['summary'] ?? '',
            'detail_body' => $detail['body'] ?? '',
            'back_url' => $detail['back_url'] ?? '#',
            'back_label' => $locale === 'en' ? 'Back to Brand' : '返回品牌页',
            ...$shared,
        ]);
    }

    /**
     * @return array<string, mixed>
     */
    private function requestData(\VSlim\Psr7\ServerRequest $request): array
    {
        $parsed = $request->getParsedBody();
        if (is_array($parsed)) {
            return $parsed;
        }

        $raw = trim((string) $request->getBody());
        if ($raw === '') {
            return [];
        }

        parse_str($raw, $fallback);
        return is_array($fallback) ? $fallback : [];
    }

    private function flashRedirect(
        \VSlim\Psr7\ServerRequest $request,
        string $location,
        string $key,
        string $message,
    ): \VSlim\Vhttpd\Response {
        $session = $this->app()->session($request);
        $session->flash($key, $message);
        $response = new \VSlim\Vhttpd\Response(302, '', 'text/plain; charset=utf-8');
        $response->redirect_with_status($location, 302);
        $session->commit($response);

        return $response;
    }
}
