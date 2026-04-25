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
        $releaseVersion = $this->queryValue($request, 'release');
        $data = $this->public->landingData(is_array($workspace) ? $workspace : null, $releaseVersion);
        $workspace = is_array($data['workspace'] ?? null) ? $data['workspace'] : $workspace;
        $metrics = is_array($data['metrics'] ?? null) ? $data['metrics'] : [];
        $release = is_array($data['release'] ?? null) ? $data['release'] : [];
        $profile = is_array($data['profile'] ?? null) ? $data['profile'] : [];
        $locale = $this->locales->resolve((string) $request->getAttribute('studio.locale', 'zh-CN'));
        $displayReleaseVersion = $this->displayReleaseVersion($releaseVersion !== '' ? $releaseVersion : (string) ($release['version'] ?? ''), $locale);
        $copy = $this->locales->brand($locale);
        $brandSession = $this->app()->session($request);
        $oldContactName = (string) $brandSession->pullFlash('brand.subscribe.old.contact_name', '');
        $oldCompanyName = (string) $brandSession->pullFlash('brand.subscribe.old.company_name', '');
        $oldEmail = (string) $brandSession->pullFlash('brand.subscribe.old.email', '');
        $oldPlan = (string) $brandSession->pullFlash('brand.subscribe.old.plan', '');
        $oldNotes = (string) $brandSession->pullFlash('brand.subscribe.old.notes', '');
        $selectedPlan = $oldPlan !== '' ? $oldPlan : $this->queryValue($request, 'plan');
        $brandUrl = $this->urls->brand(
            is_array($workspace) ? (string) ($workspace['slug'] ?? '') : $this->tenantFromPath($request),
            $locale,
        );
        $shared = $this->locales->shared($locale, $brandUrl);
        $snapshot = $this->public->snapshot(is_array($workspace) ? $workspace : null);
        $brandSurface = $this->brandPresenter->present($snapshot, $copy, $locale, $releaseVersion);
        $brandSurface['public_preview'] = $this->localizePublicPreview(
            is_array($workspace) ? $workspace : null,
            $locale,
            is_array($brandSurface['public_preview'] ?? null) ? $brandSurface['public_preview'] : ['documents' => [], 'entries' => []],
        );
        $publicName = $this->publicSurfaceName(is_array($workspace) ? $workspace : null, $profile, $locale);
        $publicTagline = $this->publicSurfaceTagline(is_array($workspace) ? $workspace : null, $locale);

        return $this->renderWithLayout('brand.html', 'layout.html', [
            'title' => $publicName !== '' ? $publicName : 'Brand',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'tagline' => $publicTagline,
            'assistant_name' => $publicName,
            'assistant_visibility' => $this->publicVisibilityLabel((string) ($profile['visibility'] ?? ''), $locale),
            'surface_status_badge' => $this->publicSurfaceStatusBadge($publicName, (string) ($profile['visibility'] ?? ''), $locale),
            'release_version' => $displayReleaseVersion,
            'release_status' => (string) ($release['status'] ?? ''),
            'release_notes' => $this->publicReleaseNotesLabel((string) ($release['notes'] ?? ''), $locale),
            'release_mode_notice' => $releaseVersion !== ''
                ? ($locale === 'en'
                    ? 'Viewing historical release ' . $displayReleaseVersion . '.'
                    : '当前正在查看历史版本 ' . $displayReleaseVersion . '。')
                : '',
            'release_mode_reset_url' => is_array($workspace)
                ? $this->urls->brand((string) ($workspace['slug'] ?? ''), $locale)
                : '#',
            'release_mode_reset_label' => $locale === 'en' ? 'Back to current public version' : '回到当前公开版本',
            'documents_total' => (string) ($metrics['documents'] ?? '0'),
            'entries_total' => (string) ($metrics['entries'] ?? '0'),
            'subscriber_count' => (string) ($data['subscription_count'] ?? '0'),
            'assistant_url' => (string) ($brandSurface['assistant_url'] ?? '#'),
            'subscribe_notice' => $brandSession->pullFlash('brand.subscribe.notice', ''),
            'subscribe_error' => $brandSession->pullFlash('brand.subscribe.error', ''),
            'subscribe_action' => is_array($workspace)
                ? $this->urls->brandSubscribe((string) ($workspace['slug'] ?? ''), $locale)
                : '#',
            'subscribe_contact_name_value' => $oldContactName,
            'subscribe_company_name_value' => $oldCompanyName,
            'subscribe_email_value' => $oldEmail,
            'subscribe_notes_value' => $oldNotes,
            'selected_plan' => $selectedPlan !== '' ? $selectedPlan : 'team',
            'selected_plan_starter' => ($selectedPlan === 'starter' ? 'selected' : ''),
            'selected_plan_team' => ($selectedPlan === '' || $selectedPlan === 'team' ? 'selected' : ''),
            'selected_plan_enterprise' => ($selectedPlan === 'enterprise' ? 'selected' : ''),
            'page_section' => $copy['page_section'],
            'nav_label' => $publicName !== '' ? $publicName : 'brand',
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
            'fit_title' => $copy['fit_title'],
            'fit_body' => $copy['fit_body'],
            'fit_one' => $copy['fit_one'],
            'fit_two' => $copy['fit_two'],
            'fit_three' => $copy['fit_three'],
            'value_title' => $copy['value_title'],
            'value_body' => $copy['value_body'],
            'value_one' => $copy['value_one'],
            'value_two' => $copy['value_two'],
            'value_three' => $copy['value_three'],
            'handoff_title' => $copy['handoff_title'],
            'handoff_body' => $copy['handoff_body'],
            'handoff_one' => $copy['handoff_one'],
            'handoff_two' => $copy['handoff_two'],
            'handoff_three' => $copy['handoff_three'],
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
            'subscribe_contact_name_label' => $copy['subscribe_contact_name_label'],
            'subscribe_company_name_label' => $copy['subscribe_company_name_label'],
            'subscribe_email_label' => $copy['subscribe_email_label'],
            'subscribe_plan_label' => $copy['subscribe_plan_label'],
            'subscribe_notes_label' => $copy['subscribe_notes_label'],
            'subscribe_contact_name_placeholder' => $copy['subscribe_contact_name_placeholder'],
            'subscribe_company_name_placeholder' => $copy['subscribe_company_name_placeholder'],
            'subscribe_email_placeholder' => $copy['subscribe_email_placeholder'],
            'subscribe_notes_placeholder' => $copy['subscribe_notes_placeholder'],
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
            $payload,
        );
        $redirectParams = [
            'plan' => trim((string) ($payload['plan'] ?? 'team')),
        ];

        if (($result['ok'] ?? false) !== true) {
            $session = $this->app()->session($request);
            $session->flash('brand.subscribe.old.contact_name', trim((string) ($payload['contact_name'] ?? '')));
            $session->flash('brand.subscribe.old.company_name', trim((string) ($payload['company_name'] ?? '')));
            $session->flash('brand.subscribe.old.email', trim((string) ($payload['email'] ?? '')));
            $session->flash('brand.subscribe.old.plan', trim((string) ($payload['plan'] ?? 'team')));
            $session->flash('brand.subscribe.old.notes', trim((string) ($payload['notes'] ?? '')));
        }

        return $this->flashRedirect(
            $request,
            is_array($workspace)
                ? $this->urls->brandWithQuery((string) ($workspace['slug'] ?? ''), $locale, $redirectParams)
                : $this->urls->home($locale),
            $result['ok'] ? 'brand.subscribe.notice' : 'brand.subscribe.error',
            $result['message'],
        );
    }

    public function validation(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        $viewer = $request->getAttribute('studio.viewer');
        $workspace = $this->public->resolveWorkspace(
            $request->getAttribute('studio.workspace'),
            $this->tenantFromPath($request),
            is_array($viewer) ? $viewer : null,
        );
        $releaseVersion = $this->queryValue($request, 'release');
        $data = $this->public->validationData(is_array($workspace) ? $workspace : null, $releaseVersion);
        $workspace = is_array($data['workspace'] ?? null) ? $data['workspace'] : $workspace;
        $metrics = is_array($data['metrics'] ?? null) ? $data['metrics'] : [];
        $release = is_array($data['release'] ?? null) ? $data['release'] : [];
        $profile = is_array($data['profile'] ?? null) ? $data['profile'] : [];
        $question = $this->queryValue($request, 'q');
        $preview = $releaseVersion !== ''
            ? $this->answers->previewFromCorpus(
                is_array($workspace) ? $workspace : null,
                $question,
                is_array($data['documents'] ?? null) ? $data['documents'] : [],
                is_array($data['entries'] ?? null) ? $data['entries'] : [],
            )
            : $this->answers->preview(is_array($workspace) ? $workspace : null, $question);
        $selectedPlan = $this->queryValue($request, 'plan');
        $locale = $this->locales->resolve((string) $request->getAttribute('studio.locale', 'zh-CN'));
        $displayReleaseVersion = $this->displayReleaseVersion($releaseVersion !== '' ? $releaseVersion : (string) ($release['version'] ?? ''), $locale);
        $copy = $this->locales->validation($locale);
        $shared = $this->locales->shared(
            $locale,
            is_array($workspace)
                ? $this->urls->validationWithQuery((string) ($workspace['slug'] ?? ''), $locale, array_filter([
                    'q' => $question,
                    'plan' => $selectedPlan,
                    'release' => $releaseVersion,
                ]))
                : $this->urls->validationWithQuery($this->tenantFromPath($request), $locale, array_filter([
                    'q' => $question,
                    'plan' => $selectedPlan,
                    'release' => $releaseVersion,
                ])),
        );
        $presented = $this->answerPresenter->present($preview, $copy);
        $publicName = $this->publicSurfaceName(is_array($workspace) ? $workspace : null, $profile, $locale);
        $publicTagline = $this->publicSurfaceTagline(is_array($workspace) ? $workspace : null, $locale);
        $documents = $this->localizePublicRows(
            is_array($workspace) ? $workspace : null,
            $locale,
            'document',
            $this->withPublicLinks(is_array($workspace) ? $workspace : null, $data['documents'] ?? [], $locale, 'document'),
        );
        $entries = $this->localizePublicRows(
            is_array($workspace) ? $workspace : null,
            $locale,
            'entry',
            $this->withPublicLinks(is_array($workspace) ? $workspace : null, $data['entries'] ?? [], $locale, 'entry'),
        );
        $citations = $this->localizeCitationRows(
            is_array($workspace) ? $workspace : null,
            $locale,
            $this->withCitationLinks(is_array($workspace) ? $workspace : null, $presented['citations'] ?? [], $locale, $releaseVersion),
        );
        $snapshotValue = str_replace(
            ['{documents}', '{entries}'],
            [(string) ($metrics['documents'] ?? '0'), (string) ($metrics['entries'] ?? '0')],
            (string) ($copy['snapshot_value_template'] ?? ''),
        );
        if ($question !== '') {
            $this->public->recordAssistantQuestion(
                is_array($workspace) ? $workspace : null,
                $question,
                (string) ($presented['answer'] ?? ''),
                is_array($presented['diagnostics'] ?? null) ? $presented['diagnostics'] : []
            );
        }

        return $this->renderWithLayout('validation.html', 'layout.html', [
            'title' => $publicName !== '' ? $publicName : 'Validation',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'tagline' => $publicTagline,
            'assistant_name' => $publicName,
            'assistant_visibility' => $this->publicVisibilityLabel((string) ($profile['visibility'] ?? ''), $locale),
            'surface_status_badge' => $this->publicSurfaceStatusBadge($publicName, (string) ($profile['visibility'] ?? ''), $locale),
            'release_version' => $displayReleaseVersion,
            'release_status' => (string) ($release['status'] ?? ''),
            'release_notes' => $this->publicReleaseNotesLabel((string) ($release['notes'] ?? ''), $locale),
            'release_mode_notice' => $releaseVersion !== ''
                ? ($locale === 'en'
                    ? 'Validating historical release ' . $displayReleaseVersion . '.'
                    : '当前正在验证历史版本 ' . $displayReleaseVersion . '。')
                : '',
            'release_mode_reset_url' => is_array($workspace)
                ? $this->urls->validation((string) ($workspace['slug'] ?? ''), $locale)
                : '#',
            'release_mode_reset_label' => $locale === 'en' ? 'Switch to current validation surface' : '切回当前验证入口',
            'documents_total' => (string) ($metrics['documents'] ?? '0'),
            'entries_total' => (string) ($metrics['entries'] ?? '0'),
            'documents' => $documents,
            'entries' => $entries,
            'subscriber_count' => (string) ($data['subscription_count'] ?? '0'),
            'question' => (string) ($presented['question'] ?? ''),
            'answer' => (string) ($presented['answer'] ?? ''),
            'citations' => $citations,
            'diagnostics' => $presented['diagnostics'] ?? [],
            'empty_tip' => (string) ($presented['answer'] ?? '') === ''
                ? $copy['empty_tip']
                : '',
            'page_section' => $copy['page_section'],
            'nav_label' => $publicName !== '' ? $publicName : 'validation',
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
                ? $this->urls->brandWithQuery((string) ($workspace['slug'] ?? ''), $locale, array_filter([
                    'release' => $releaseVersion,
                ]))
                : '#',
            'selected_plan_brand_url' => is_array($workspace)
                ? $this->urls->brandWithQuery((string) ($workspace['slug'] ?? ''), $locale, array_filter([
                    'plan' => $selectedPlan,
                    'release' => $releaseVersion,
                ])) . '#subscribe-intake'
                : '#',
            'assistant_form_action' => is_array($workspace)
                ? $this->urls->validationWithQuery((string) ($workspace['slug'] ?? ''), $locale, array_filter([
                    'plan' => $selectedPlan,
                    'release' => $releaseVersion,
                ]))
                : '#',
            'frontend_style_url' => FrontendAsset::url('knowledge-studio.css'),
            'frontend_module_url' => FrontendAsset::url('knowledge-studio.js'),
            'selected_plan' => $selectedPlan,
            'selected_plan_label' => $selectedPlan !== '' ? (string) ($copy['plan_' . $selectedPlan] ?? strtoupper($selectedPlan)) : '',
            'selected_plan_title' => $copy['selected_plan_title'],
            'selected_plan_body' => $copy['selected_plan_body'],
            'selected_plan_cta' => $copy['selected_plan_cta'],
            'next_step_title' => $copy['next_step_title'],
            'next_step_body' => $copy['next_step_body'],
            'next_step_one_title' => $copy['next_step_one_title'],
            'next_step_one_body' => $copy['next_step_one_body'],
            'next_step_two_title' => $copy['next_step_two_title'],
            'next_step_two_body' => $copy['next_step_two_body'],
            'next_step_three_title' => $copy['next_step_three_title'],
            'next_step_three_body' => $copy['next_step_three_body'],
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
            'snapshot_value' => $snapshotValue,
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
            'citation_detail_cta' => $copy['citation_detail_cta'],
            'documents_title' => $copy['documents_title'],
            'entries_title' => $copy['entries_title'],
            ...$shared,
        ]);
    }

    public function assistant(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        $locale = $this->locales->resolve((string) $request->getAttribute('studio.locale', 'zh-CN'));
        $tenant = $this->tenantFromPath($request);
        $query = [];
        foreach (['q', 'plan', 'release'] as $key) {
            $value = $this->queryValue($request, $key);
            if ($value !== '') {
                $query[$key] = $value;
            }
        }

        return $this->redirect($this->urls->validationWithQuery($tenant, $locale, $query));
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
        $releaseVersion = $this->queryValue($request, 'release');
        $document = $this->public->releasedDocumentDetail(is_array($workspace) ? $workspace : null, $documentId, $releaseVersion);
        if (!is_array($document)) {
            return $this->redirect(
                is_array($workspace)
                    ? $this->urls->brand((string) ($workspace['slug'] ?? ''), $locale)
                    : $this->urls->home($locale),
                302,
            );
        }

        return $this->renderPublicDetail($workspace, $locale, [
            'item_type' => 'document',
            'id' => (string) ($document['id'] ?? ''),
            'title' => (string) ($document['title'] ?? ''),
            'meta' => trim((string) ($document['source_type'] ?? '') . ' / ' . (string) ($document['language'] ?? 'zh-CN')),
            'coverage_focus' => (string) ($document['coverage_focus'] ?? ''),
            'summary' => (string) ($document['summary'] ?? ''),
            'body' => (string) ($document['body'] ?? ''),
            'back_url' => is_array($workspace)
                ? $this->urls->brandWithQuery((string) ($workspace['slug'] ?? ''), $locale, array_filter([
                    'release' => $releaseVersion,
                ]))
                : '#',
            'release_version' => $releaseVersion,
            'release_display_version' => $this->displayReleaseVersion($releaseVersion, $locale),
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
        $releaseVersion = $this->queryValue($request, 'release');
        $entry = $this->public->releasedEntryDetail(is_array($workspace) ? $workspace : null, $entryId, $releaseVersion);
        if (!is_array($entry)) {
            return $this->redirect(
                is_array($workspace)
                    ? $this->urls->brand((string) ($workspace['slug'] ?? ''), $locale)
                    : $this->urls->home($locale),
                302,
            );
        }

        return $this->renderPublicDetail($workspace, $locale, [
            'item_type' => 'entry',
            'id' => (string) ($entry['id'] ?? ''),
            'title' => (string) ($entry['title'] ?? ''),
            'meta' => trim((string) ($entry['kind'] ?? 'faq') . ' / ' . (string) ($entry['owner'] ?? '')),
            'coverage_focus' => (string) ($entry['coverage_focus'] ?? ''),
            'summary' => (string) ($entry['body'] ?? ''),
            'body' => (string) ($entry['body'] ?? ''),
            'back_url' => is_array($workspace)
                ? $this->urls->brandWithQuery((string) ($workspace['slug'] ?? ''), $locale, array_filter([
                    'release' => $releaseVersion,
                ]))
                : '#',
            'release_version' => $releaseVersion,
            'release_display_version' => $this->displayReleaseVersion($releaseVersion, $locale),
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
            $releaseVersion = trim((string) ($row['release_version'] ?? ''));
            $row['detail_url'] = $type === 'document'
                ? $this->urls->brandDocument($slug, (string) ($row['id'] ?? ''), $locale)
                : $this->urls->brandEntry($slug, (string) ($row['id'] ?? ''), $locale);
            if ($releaseVersion !== '') {
                $separator = str_contains($row['detail_url'], '?') ? '&' : '?';
                $row['detail_url'] .= $separator . http_build_query(['release' => $releaseVersion]);
            }
            return $row;
        }, $rows);
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<int, array<string, mixed>> $rows
     * @return array<int, array<string, mixed>>
     */
    private function withCitationLinks(?array $workspace, array $rows, string $locale, string $fallbackReleaseVersion = ''): array
    {
        $slug = is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '';

        return array_map(function (array $row) use ($slug, $locale, $fallbackReleaseVersion): array {
            $sourceKind = (string) ($row['source_kind'] ?? '');
            $id = (string) ($row['id'] ?? '');
            if ($slug === '' || $id === '') {
                $row['detail_url'] = '';
                return $row;
            }

            $row['detail_url'] = $sourceKind === 'document'
                ? $this->urls->brandDocument($slug, $id, $locale)
                : $this->urls->brandEntry($slug, $id, $locale);
            $releaseVersion = trim((string) ($row['release_version'] ?? $fallbackReleaseVersion));
            if ($releaseVersion !== '') {
                $separator = str_contains($row['detail_url'], '?') ? '&' : '?';
                $row['detail_url'] .= $separator . http_build_query(['release' => $releaseVersion]);
            }

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
        $detail = $this->localizedPublicRow($workspace, $locale, (string) ($detail['item_type'] ?? ''), $detail);
        $coverageFocus = trim((string) ($detail['coverage_focus'] ?? ''));
        $coverageLabel = $locale === 'en' ? 'Coverage Question' : '覆盖问题';
        $eyebrow = $locale === 'en' ? 'Public Knowledge' : '公开知识';
        $publicTagline = $this->publicSurfaceTagline($workspace, $locale);
        $publicName = $this->publicSurfaceName($workspace, [], $locale);

        return $this->renderWithLayout('public_detail.html', 'layout.html', [
            'title' => $detail['title'] ?? 'Knowledge Detail',
            'page_section' => $publicName !== '' ? $publicName : 'Knowledge Detail',
            'nav_label' => $publicName !== '' ? $publicName : 'detail',
            'footer_note' => '',
            'sidebar_copy' => $publicTagline,
            'eyebrow' => $eyebrow,
            'detail_title' => $detail['title'] ?? '',
            'detail_meta' => $detail['meta'] ?? '',
            'detail_coverage_focus' => $coverageFocus,
            'coverage_focus_label' => $coverageLabel,
            'detail_summary' => $detail['summary'] ?? '',
            'detail_body' => $detail['body'] ?? '',
            'back_url' => $detail['back_url'] ?? '#',
            'back_label' => $locale === 'en' ? 'Back to Brand' : '返回品牌页',
            'validation_url' => is_array($workspace)
                ? $this->urls->validationWithQuery((string) ($workspace['slug'] ?? ''), $locale, array_filter([
                    'release' => trim((string) ($detail['release_version'] ?? '')),
                ]))
                : '',
            'validation_label' => $locale === 'en' ? 'Back to Validation' : '回到验证页',
            'release_mode_notice' => trim((string) ($detail['release_version'] ?? '')) !== ''
                ? ($locale === 'en'
                    ? 'Source detail from historical release ' . trim((string) ($detail['release_display_version'] ?? '')) . '.'
                    : '当前来源详情来自历史版本 ' . trim((string) ($detail['release_display_version'] ?? '')) . '。')
                : '',
            'release_mode_reset_url' => is_array($workspace)
                ? $this->urls->brand((string) ($workspace['slug'] ?? ''), $locale)
                : '#',
            'release_mode_reset_label' => $locale === 'en' ? 'Back to current public version' : '回到当前公开版本',
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

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed> $profile
     */
    private function publicSurfaceName(?array $workspace, array $profile, string $locale = 'zh-CN'): string
    {
        $slug = is_array($workspace) ? trim((string) ($workspace['slug'] ?? '')) : '';
        $catalogWorkspace = $slug !== '' ? $this->catalog->findWorkspaceBySlug($slug) : null;
        $catalogBrandName = is_array($catalogWorkspace) ? trim((string) ($catalogWorkspace['brand_name'] ?? '')) : '';
        $catalogBrandName = $this->localizedPublicSurfaceName($slug, $locale, $catalogBrandName);
        if ($catalogBrandName !== '') {
            return $catalogBrandName;
        }

        $workspaceBrandName = is_array($workspace) ? trim((string) ($workspace['brand_name'] ?? '')) : '';
        $workspaceBrandName = $this->localizedPublicSurfaceName($slug, $locale, $workspaceBrandName);
        if ($workspaceBrandName !== '') {
            return $workspaceBrandName;
        }

        return $this->localizedPublicSurfaceName($slug, $locale, trim((string) ($profile['name'] ?? '')));
    }

    private function localizedPublicSurfaceName(string $slug, string $locale, string $fallback): string
    {
        if (!in_array($locale, ['zh', 'zh-CN', 'zh-Hans'], true)) {
            return $fallback;
        }

        return match ($slug) {
            'acme-research' => 'Acme 运营简报',
            'nova-advisory' => 'Nova 知识台',
            default => $fallback,
        };
    }

    /**
     * @param array<string, mixed>|null $workspace
     */
    private function publicSurfaceTagline(?array $workspace, string $locale): string
    {
        $slug = is_array($workspace) ? trim((string) ($workspace['slug'] ?? '')) : '';
        $workspaceTagline = is_array($workspace) ? trim((string) ($workspace['tagline'] ?? '')) : '';
        if ($locale === 'en') {
            return $workspaceTagline;
        }

        return match ($slug) {
            'acme-research' => '面向金融支持、报销运营与结算异常处理团队的知识运营服务。',
            'nova-advisory' => '面向咨询与政策研究团队的知识产品与发布服务。',
            default => $workspaceTagline,
        };
    }

    private function publicVisibilityLabel(string $visibility, string $locale): string
    {
        $visibility = strtolower(trim($visibility));
        if ($locale !== 'en') {
            return match ($visibility) {
                'public' => '公开',
                'private' => '私有',
                default => $visibility,
            };
        }

        return $visibility;
    }

    private function publicReleaseNotesLabel(string $notes, string $locale): string
    {
        $notes = trim($notes);
        if ($locale === 'en' || $notes === '') {
            return $notes;
        }

        return match ($notes) {
            '2026.Q2 release focused on reimbursement operations, settlement exceptions, and support-to-finance handoff.'
                => '2026.Q2 版本，聚焦报销运营、结算异常处理与支持到财务的交接流程。',
            'Public knowledge release covering 3 docs / 3 entries.'
                => '当前公开知识版本覆盖 3 份文档与 3 条知识条目。',
            default => $notes,
        };
    }

    private function publicSurfaceStatusBadge(string $name, string $visibility, string $locale): string
    {
        $name = trim($name);
        $visibility = strtolower(trim($visibility));

        if ($locale === 'en') {
            return $visibility === 'public'
                ? ($name !== '' ? $name . ' public knowledge service live' : 'Public knowledge service live')
                : ($name !== '' ? $name . ' validation surface' : 'Validation surface');
        }

        return $visibility === 'public'
            ? ($name !== '' ? $name . ' 公开知识服务已启用' : '公开知识服务已启用')
            : ($name !== '' ? $name . ' 知识验证入口' : '知识验证入口');
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed> $preview
     * @return array<string, mixed>
     */
    private function localizePublicPreview(?array $workspace, string $locale, array $preview): array
    {
        $preview['documents'] = $this->localizePublicRows(
            $workspace,
            $locale,
            'document',
            is_array($preview['documents'] ?? null) ? $preview['documents'] : [],
        );
        $preview['entries'] = $this->localizePublicRows(
            $workspace,
            $locale,
            'entry',
            is_array($preview['entries'] ?? null) ? $preview['entries'] : [],
        );

        return $preview;
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<int, array<string, mixed>> $rows
     * @return array<int, array<string, mixed>>
     */
    private function localizePublicRows(?array $workspace, string $locale, string $type, array $rows): array
    {
        return array_map(
            fn (array $row): array => $this->localizedPublicRow($workspace, $locale, $type, $row),
            $rows,
        );
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<int, array<string, mixed>> $rows
     * @return array<int, array<string, mixed>>
     */
    private function localizeCitationRows(?array $workspace, string $locale, array $rows): array
    {
        return array_map(function (array $row) use ($workspace, $locale): array {
            $localized = $this->localizedPublicRow(
                $workspace,
                $locale,
                (string) ($row['source_kind'] ?? ''),
                $row,
            );
            if (array_key_exists('summary', $localized)) {
                $localized['excerpt'] = (string) ($localized['summary'] ?? $localized['excerpt'] ?? '');
            }

            return $localized;
        }, $rows);
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<string, mixed> $row
     * @return array<string, mixed>
     */
    private function localizedPublicRow(?array $workspace, string $locale, string $type, array $row): array
    {
        $row = $this->localizePublicMeta($locale, $type, $row);
        if (!in_array($locale, ['zh', 'zh-CN', 'zh-Hans'], true)) {
            return $row;
        }

        $slug = is_array($workspace) ? trim((string) ($workspace['slug'] ?? '')) : '';
        $id = trim((string) ($row['id'] ?? ''));
        if ($slug !== 'acme-research' || $id === '') {
            return $row;
        }

        $copy = match ($type . ':' . $id) {
            'document:doc-acme-1' => [
                'title' => '报销运营手册',
                'coverage_focus' => '资格校验、审批流转与打款沟通',
                'summary' => '说明报销请求在打款前如何完成筛查、审批与客户沟通。',
                'body' => '报销请求应先完成资料校验与规则检查，再进入审批链路，最后由财务确认是否进入打款。团队需要把异常码、审批结论和对客户承诺的更新时间统一记录到同一条运营流程里，这样公开知识面、支持回复和内部交接才不会出现版本漂移。',
            ],
            'document:doc-acme-2' => [
                'title' => '结算异常处置手册',
                'coverage_focus' => '异常归属、升级窗口与结算里程碑',
                'summary' => '说明打款异常进入升级后，谁负责接手、如何判断里程碑以及如何同步客户。',
                'body' => '一旦结算异常进入升级，团队要先补齐交易上下文、指定当前 owner，并把案例映射到结算时间线。随后需要明确下一次对客户的更新时间、财务需要确认的节点，以及最终应回写到知识库的处理结论，确保支持与财务引用的是同一套口径。',
            ],
            'document:doc-acme-3' => [
                'title' => '支持到财务交接指南',
                'coverage_focus' => '打款与支持案例的跨团队交接检查点',
                'summary' => '定义案例跨团队后谁继续对客、谁负责审批，以及哪些检查点必须交接清楚。',
                'body' => '当打款案例从支持转入财务时，需要同时交接支持 owner、财务审批人、升级窗口和下一次客户更新时间。把这些检查点沉淀成一份共享指南后，团队在高峰期也能维持稳定的答复节奏，不会因为交接断层导致公开口径失真。',
            ],
            'entry:entry-acme-1' => [
                'title' => '报销请求如何进入最终审批？',
                'coverage_focus' => '报销案例的最终审批路径',
                'summary' => '说明从受理、规则校验到财务确认的完整审批链。',
                'body' => '报销审批通常先经过受理审核，再进入规则与政策校验，最后由财务确认是否进入最终发放。只要案例仍处于规则复核或额度校验阶段，就不应向客户承诺已经进入最终付款。',
            ],
            'entry:entry-acme-2' => [
                'title' => '结算异常如何做分诊？',
                'coverage_focus' => '打款与结算异常的分诊流程',
                'summary' => '说明异常出现后要先补哪些信息、如何指定 owner，以及何时发布新的指导口径。',
                'body' => '处理结算异常时，先补齐异常上下文并映射到结算时间线，再指定责任 owner，最后把处理决策记录下来。只有当决定已经明确、且支持与财务都确认了下一步动作，才应该把新的指导口径发布出去。',
            ],
            'entry:entry-acme-3' => [
                'title' => '什么情况下支持团队需要把打款案例升级到财务？',
                'coverage_focus' => '从支持升级到财务的触发条件',
                'summary' => '列出需要进入财务处理的关键触发条件，以及升级时必须随案带上的信息。',
                'body' => '当案例涉及政策复核、结算不匹配或超过人工审批阈值时，支持团队应立即升级到财务。升级时必须附带异常原因、对客户承诺的更新时间，以及当前 owner 信息，避免财务接手后还要重新补全上下文。',
            ],
            default => [],
        };

        if ($copy === []) {
            return $row;
        }

        foreach ($copy as $key => $value) {
            $row[$key] = $value;
        }

        if (array_key_exists('summary', $copy)) {
            $row['excerpt'] = (string) $copy['summary'];
        }

        return $row;
    }

    /**
     * @param array<string, mixed> $row
     * @return array<string, mixed>
     */
    private function localizePublicMeta(string $locale, string $type, array $row): array
    {
        $copy = $this->locales->validation($locale);

        if ($type === 'document') {
            $sourceType = strtolower(trim((string) ($row['source_type'] ?? '')));
            $sourceKey = 'source_' . $sourceType;
            $row['source_type_label'] = (string) ($copy[$sourceKey] ?? $copy['source_unknown'] ?? $sourceType);
        }

        $kind = strtolower(trim((string) ($row['kind'] ?? '')));
        if ($kind !== '') {
            $kindKey = 'kind_' . $kind;
            $row['kind_label'] = (string) ($copy[$kindKey] ?? $kind);
        }

        $status = strtolower(trim((string) ($row['status'] ?? '')));
        if ($status !== '') {
            $statusKey = 'status_' . $status;
            $row['status_label'] = (string) ($copy[$statusKey] ?? $status);
        }

        $sourceDetail = trim((string) ($row['source_detail'] ?? ''));
        if ($sourceDetail !== '') {
            $row['source_detail_text'] = $sourceDetail;
        }

        return $row;
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
        $response->redirectWithStatus($location, 302);
        $session->commit($response);

        return $response;
    }

    private function displayReleaseVersion(string $version, string $locale = 'zh-CN'): string
    {
        $version = trim($version);
        if ($version === '') {
            return '';
        }

        return match (true) {
            $version === 'v0.1' => '2026.Q2',
            str_starts_with($version, 'onboarding-') => in_array($locale, ['zh', 'zh-CN', 'zh-Hans'], true)
                ? '客户开通草稿'
                : 'Customer Onboarding Draft',
            default => $version,
        };
    }
}
