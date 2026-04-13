<?php
declare(strict_types=1);

namespace App\Http\Controllers;

use App\Services\ConsoleWorkspaceService;
use App\Support\DemoCatalog;
use App\Support\FrontendAsset;
use App\Support\LocaleCatalog;
use App\Support\MarkdownPreview;
use App\Support\LocalizedUrlBuilder;

final class ConsoleController extends \VSlim\Controller
{
    private function debug(string $message): void
    {
        if (getenv('KS_DEBUG') === false || getenv('KS_DEBUG') === '') {
            return;
        }
        file_put_contents('php://stderr', "[ks-debug] {$message}\n");
    }

    public function __construct(
        \VSlim\App $app,
        private DemoCatalog $catalog,
        private ConsoleWorkspaceService $console,
        private LocaleCatalog $locales,
        private LocalizedUrlBuilder $urls,
    )
    {
        parent::__construct($app);
    }

    public function index(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        $this->debug('index.enter');
        if (!$this->app()->authCheck($request)) {
            $this->debug('index.redirect-login');
            return $this->redirect($this->urls->login($this->locale($request)), 302);
        }

        [$viewer, $workspace, $memberships] = $this->consoleContext($request);
        $this->debug('index.context-ready');
        $dashboard = $this->console->dashboard($workspace);
        $this->debug('index.dashboard-ready');
        $members = $this->console->members($workspace);
        $metrics = $dashboard['metrics'];
        $documents = $dashboard['documents'];
        $entries = $dashboard['entries'];
        $jobs = $dashboard['jobs'];
        $subscriptions = is_array($dashboard['subscriptions'] ?? null) ? $dashboard['subscriptions'] : ['count' => 0, 'recent' => [], 'plans' => []];
        $questions = is_array($dashboard['questions'] ?? null) ? $dashboard['questions'] : [];
        $gaps = is_array($dashboard['gaps'] ?? null) ? $dashboard['gaps'] : [];
        $priorities = is_array($dashboard['priorities'] ?? null) ? $dashboard['priorities'] : [];
        $locale = $this->locale($request);
        $copy = $this->locales->consoleIndex($locale);
        $shared = $this->shared($locale, '/console', is_array($workspace) ? $workspace : null);
        $workspaceSlug = is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '';
        $priorities = array_map(function (array $item) use ($locale): array {
            return [
                ...$item,
                'target_url' => $this->urls->path((string) ($item['target'] ?? '/console'), $locale),
            ];
        }, $priorities);
        $gaps = array_map(function (array $item) use ($locale): array {
            $question = trim((string) ($item['title'] ?? ''));
            $entryTitle = $question !== '' ? $question : 'New FAQ from assistant gap';
            $entryBody = $question !== ''
                ? "## User question\n\n{$question}\n\n## Working answer\n\n- Add the canonical answer here.\n- Clarify scope, exceptions, and policy notes.\n"
                : "## User question\n\n- Capture the missing question here.\n\n## Working answer\n\n- Add the canonical answer here.\n";
            $documentTitle = $question !== '' ? 'Source note: ' . $question : 'Source note for assistant gap';
            $documentSummary = $question !== ''
                ? 'Capture the source material needed to answer: ' . $question
                : 'Capture the source material needed to close this assistant gap.';
            $documentBody = $question !== ''
                ? "# Missing source material\n\nQuestion to cover:\n\n{$question}\n\n## Evidence to collect\n\n- Policy or handbook excerpt\n- Procedure details\n- Owner or approver\n"
                : "# Missing source material\n\n## Evidence to collect\n\n- Policy or handbook excerpt\n- Procedure details\n- Owner or approver\n";

            return [
                ...$item,
                'entry_url' => $this->urls->consoleFaqsWithQuery($locale, [
                    'prefill_kind' => 'faq',
                    'prefill_title' => $entryTitle,
                    'prefill_coverage_focus' => $question !== '' ? $question : $entryTitle,
                    'prefill_body' => $entryBody,
                ]),
                'document_url' => $this->urls->consoleDocumentsWithQuery($locale, [
                    'prefill_title' => $documentTitle,
                    'prefill_coverage_focus' => $question !== '' ? $question : $documentTitle,
                    'prefill_summary' => $documentSummary,
                    'prefill_body' => $documentBody,
                    'prefill_source_type' => 'markdown',
                    'prefill_language' => 'zh-CN',
                ]),
            ];
        }, $gaps);
        $questions = array_map(function (array $item) use ($locale, $workspaceSlug): array {
            $question = trim((string) ($item['title'] ?? ''));
            return [
                ...$item,
                'assistant_url' => $workspaceSlug !== ''
                    ? $this->urls->assistantWithQuery($workspaceSlug, $locale, ['q' => $question])
                    : $this->urls->console($locale),
            ];
        }, $questions);
        $subscriptionRecent = array_map(function (array $item) use ($locale, $workspaceSlug): array {
            $plan = trim((string) ($item['plan'] ?? ''));
            return [
                ...$item,
                'brand_url' => $workspaceSlug !== ''
                    ? $this->urls->brandWithQuery($workspaceSlug, $locale, ['plan' => $plan])
                    : $this->urls->console($locale),
            ];
        }, is_array($subscriptions['recent'] ?? null) ? $subscriptions['recent'] : []);

        $this->debug('index.render');
        return $this->render_with_layout('console.html', 'layout.html', [
            'title' => $copy['title'],
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'viewer_role' => is_array($viewer) ? (string) ($viewer['role'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'workspace_brand' => is_array($workspace) ? (string) ($workspace['brand_name'] ?? '') : '',
            'workspace_plan' => is_array($workspace) ? (string) ($workspace['plan'] ?? '') : '',
            'workspace_members' => (string) count($members),
            'sidebar_line_plan' => $copy['sidebar_line_plan'],
            'sidebar_line_collaborators' => $copy['sidebar_line_collaborators'],
            'member_count' => count($members),
            'memberships' => $memberships,
            'documents_total' => (string) ($metrics['documents'] ?? '0'),
            'entries_total' => (string) ($metrics['entries'] ?? '0'),
            'jobs_total' => (string) ($metrics['jobs'] ?? '0'),
            'subscriptions_total' => (string) ($subscriptions['count'] ?? '0'),
            'published_documents' => (string) ($metrics['published_documents'] ?? '0'),
            'assistant_status' => (string) ($metrics['assistant_status'] ?? 'draft'),
            'documents_url' => $this->urls->consoleDocuments($locale),
            'faqs_url' => $this->urls->consoleFaqs($locale),
            'members_url' => $this->urls->consoleMembers($locale),
            'ops_url' => $this->urls->consoleOps($locale),
            'releases_url' => $this->urls->consoleReleases($locale),
            'documents' => array_slice($documents, 0, 2),
            'entries' => array_slice($entries, 0, 2),
            'jobs' => array_slice($jobs, 0, 2),
            'subscription_recent' => $subscriptionRecent,
            'subscription_plans' => is_array($subscriptions['plans'] ?? null) ? $subscriptions['plans'] : [],
            'recent_questions' => $questions,
            'knowledge_gaps' => $gaps,
            'priority_queue' => $priorities,
            'members' => array_slice($members, 0, 4),
            'public_url' => is_array($workspace)
                ? $this->urls->brand((string) ($workspace['slug'] ?? ''), $locale)
                : '',
            'public_assistant_url' => is_array($workspace)
                ? $this->urls->assistant((string) ($workspace['slug'] ?? ''), $locale)
                : '',
            'public_plans_url' => is_array($workspace)
                ? $this->urls->brand((string) ($workspace['slug'] ?? ''), $locale) . '#plans'
                : '',
            'page_section' => $copy['page_section'],
            'nav_label' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : 'console',
            'footer_note' => $copy['footer_note'],
            'eyebrow' => $copy['eyebrow'],
            'intro' => $copy['intro'],
            'brand_label' => $copy['brand_label'],
            'plan_label' => $copy['plan_label'],
            'assistant_label' => $copy['assistant_label'],
            'published_label' => $copy['published_label'],
            'documents_cta' => $copy['documents_cta'],
            'entries_cta' => $copy['entries_cta'],
            'members_cta' => $copy['members_cta'],
            'ops_cta' => $copy['ops_cta'],
            'releases_cta' => $copy['releases_cta'],
            'brand_cta' => $copy['brand_cta'],
            'documents_metric' => $copy['documents_metric'],
            'entries_metric' => $copy['entries_metric'],
            'jobs_metric' => $copy['jobs_metric'],
            'subscriptions_metric' => $copy['subscriptions_metric'],
            'today_title' => $copy['today_title'],
            'today_body' => $copy['today_body'],
            'supply_title' => $copy['supply_title'],
            'supply_body' => $copy['supply_body'],
            'publish_center_title' => $copy['publish_center_title'],
            'publish_center_body' => $copy['publish_center_body'],
            'feedback_title' => $copy['feedback_title'],
            'feedback_body' => $copy['feedback_body'],
            'settings_title' => $copy['settings_title'],
            'settings_body' => $copy['settings_body'],
            'priority_queue_title' => $copy['priority_queue_title'],
            'brief_title' => $copy['brief_title'],
            'brief_body' => $copy['brief_body'],
            'brief_one_title' => $copy['brief_one_title'],
            'brief_one_body' => $copy['brief_one_body'],
            'brief_two_title' => $copy['brief_two_title'],
            'brief_two_body' => $copy['brief_two_body'],
            'brief_three_title' => $copy['brief_three_title'],
            'brief_three_body' => $copy['brief_three_body'],
            'next_title' => $copy['next_title'],
            'next_one_title' => $copy['next_one_title'],
            'next_one_body' => $copy['next_one_body'],
            'next_two_title' => $copy['next_two_title'],
            'next_two_body' => $copy['next_two_body'],
            'next_three_title' => $copy['next_three_title'],
            'next_three_body' => $copy['next_three_body'],
            'recent_documents_title' => $copy['recent_documents_title'],
            'recent_entries_title' => $copy['recent_entries_title'],
            'recent_jobs_title' => $copy['recent_jobs_title'],
            'recent_subscriptions_title' => $copy['recent_subscriptions_title'],
            'subscription_mix_title' => $copy['subscription_mix_title'],
            'recent_questions_title' => $copy['recent_questions_title'],
            'knowledge_gaps_title' => $copy['knowledge_gaps_title'],
            'members_title' => $copy['members_title'],
            'members_count_label' => $copy['members_count_label'],
            'operating_model_title' => $copy['operating_model_title'],
            'operating_model_body' => $copy['operating_model_body'],
            'subscribers_title' => $copy['subscribers_title'],
            'subscribers_body' => $copy['subscribers_body'],
            'performance_title' => $copy['performance_title'],
            'performance_body' => $copy['performance_body'],
            'creation_title' => $copy['creation_title'],
            'creation_body' => $copy['creation_body'],
            'collaboration_title' => $copy['collaboration_title'],
            'collaboration_body' => $copy['collaboration_body'],
            'brand_growth_title' => $copy['brand_growth_title'],
            'brand_growth_body' => $copy['brand_growth_body'],
            'brand_story_title' => $copy['brand_story_title'],
            'brand_story_body' => $copy['brand_story_body'],
            'distribution_title' => $copy['distribution_title'],
            'distribution_body' => $copy['distribution_body'],
            'assistant_preview_cta' => $copy['assistant_preview_cta'],
            'share_brand_cta' => $copy['share_brand_cta'],
            'view_plans_cta' => $copy['view_plans_cta'],
            'signal_metric_label' => $copy['signal_metric_label'],
            'published_metric_label' => $copy['published_metric_label'],
            'logout_label' => $copy['logout_label'],
            'logout_action' => $this->urls->logout($locale),
            ...$shared,
        ]);
    }

    public function members(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect($this->urls->login($this->locale($request)), 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $members = $this->console->members($workspace);
        $locale = $this->locale($request);
        $copy = $this->locales->consoleMembers($locale);
        $shared = $this->shared($locale, '/console/members', is_array($workspace) ? $workspace : null);
        $canManageMembers = $this->console->canManageMembers(is_array($viewer) ? $viewer : null);

        return $this->render_with_layout('console_members.html', 'layout.html', [
            'title' => $copy['title'],
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'viewer_role' => is_array($viewer) ? (string) ($viewer['role'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'members' => $members,
            'write_error' => $this->flash($request, 'console.members.error'),
            'write_notice' => $this->flash($request, 'console.members.notice'),
            'member_action' => $this->urls->consoleMembers($locale),
            'can_manage_members' => $canManageMembers ? '1' : '',
            'page_section' => $copy['page_section'],
            'nav_label' => $copy['nav_label'],
            'footer_note' => $copy['footer_note'],
            'sidebar_line' => $copy['sidebar_line'],
            'eyebrow' => $copy['eyebrow'],
            'intro' => $copy['intro'],
            'create_title' => $copy['create_title'],
            'name_label' => $copy['name_label'],
            'email_label' => $copy['email_label'],
            'role_label' => $copy['role_label'],
            'submit_label' => $copy['submit_label'],
            'context_title' => $copy['context_title'],
            'viewer_label' => $copy['viewer_label'],
            'role_hint_label' => $copy['role_hint_label'],
            'owner_only_hint' => $copy['owner_only_hint'],
            'table_title' => $copy['table_title'],
            'col_name' => $copy['col_name'],
            'col_email' => $copy['col_email'],
            'col_role' => $copy['col_role'],
            'col_created' => $copy['col_created'],
            'password_hint' => $copy['password_hint'],
            ...$shared,
        ]);
    }

    public function documents(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        $this->debug('documents.enter');
        if (!$this->app()->authCheck($request)) {
            $this->debug('documents.redirect-login');
            return $this->redirect($this->urls->login($this->locale($request)), 302);
        }

        $this->debug('documents.auth-ok');
        [$viewer, $workspace] = $this->consoleContext($request);
        $this->debug('documents.context-ready');
        $documents = $this->console->documents($workspace);
        $this->debug('documents.data-ready count=' . count($documents));
        $locale = $this->locale($request);
        $copy = $this->locales->consoleDocuments($locale);
        $shared = $this->shared($locale, '/console/knowledge/documents', is_array($workspace) ? $workspace : null);
        $canManageContent = $this->console->canManageContent(is_array($viewer) ? $viewer : null);
        $prefill = [
            'title' => $this->queryValue($request, 'prefill_title'),
            'coverage_focus' => $this->queryValue($request, 'prefill_coverage_focus'),
            'summary' => $this->queryValue($request, 'prefill_summary'),
            'body' => $this->queryValue($request, 'prefill_body'),
            'language' => $this->queryValue($request, 'prefill_language') ?: 'zh-CN',
            'source_type' => $this->queryValue($request, 'prefill_source_type') ?: 'markdown',
            'language_zh_selected' => ($this->queryValue($request, 'prefill_language') ?: 'zh-CN') === 'zh-CN' ? 'selected' : '',
            'language_en_selected' => ($this->queryValue($request, 'prefill_language') ?: 'zh-CN') === 'en' ? 'selected' : '',
            'source_markdown_selected' => ($this->queryValue($request, 'prefill_source_type') ?: 'markdown') === 'markdown' ? 'selected' : '',
            'source_pdf_selected' => ($this->queryValue($request, 'prefill_source_type') ?: 'markdown') === 'pdf' ? 'selected' : '',
            'source_upload_selected' => ($this->queryValue($request, 'prefill_source_type') ?: 'markdown') === 'upload' ? 'selected' : '',
            'source_notion_selected' => ($this->queryValue($request, 'prefill_source_type') ?: 'markdown') === 'notion' ? 'selected' : '',
        ];
        $documents = array_map(fn (array $item): array => [
            ...$item,
            'edit_url' => $this->urls->consoleDocumentEditor((string) ($item['id'] ?? ''), $locale),
        ], $documents);

        if (getenv('KS_PLAIN_DOCUMENTS_RESPONSE') !== false && getenv('KS_PLAIN_DOCUMENTS_RESPONSE') !== '') {
            $this->debug('documents.plain-response');
            return new \VSlim\Vhttpd\Response(
                200,
                'documents|' . count($documents) . '|' . (is_array($viewer) ? (string) ($viewer['id'] ?? '') : ''),
                'text/plain; charset=utf-8'
            );
        }

        if (getenv('KS_RENDERED_STRING_DOCUMENTS_RESPONSE') !== false && getenv('KS_RENDERED_STRING_DOCUMENTS_RESPONSE') !== '') {
            $this->debug('documents.rendered-string-response');
            $html = $this->view()->render_with_layout('console_documents.html', 'layout.html', [
                'title' => 'Knowledge Documents',
                'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
                'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
                'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
                'documents' => $documents,
                'page_section' => 'Knowledge Documents',
                'nav_label' => 'documents',
                'footer_note' => 'Document ingest will move from demo arrays to database-backed records next',
            ]);
            $this->debug('documents.rendered-string-len=' . strlen($html) . ' md5=' . md5($html) . ' head=' . substr($html, 0, 160) . ' tail=' . substr($html, -160));
            return new \VSlim\Vhttpd\Response(200, $html, 'text/html; charset=utf-8');
        }

        if (getenv('KS_RENDERED_TEMPLATE_ONLY_DOCUMENTS_RESPONSE') !== false && getenv('KS_RENDERED_TEMPLATE_ONLY_DOCUMENTS_RESPONSE') !== '') {
            $this->debug('documents.rendered-template-only-response');
            $html = $this->view()->render('console_documents.html', [
                'title' => 'Knowledge Documents',
                'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
                'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
                'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
                'documents' => $documents,
                'page_section' => 'Knowledge Documents',
                'nav_label' => 'documents',
                'footer_note' => 'Document ingest will move from demo arrays to database-backed records next',
            ]);
            $this->debug('documents.rendered-template-only-len=' . strlen($html) . ' md5=' . md5($html));
            return new \VSlim\Vhttpd\Response(200, $html, 'text/html; charset=utf-8');
        }

        if (getenv('KS_RAW_STRING_DOCUMENTS_RESPONSE') !== false && getenv('KS_RAW_STRING_DOCUMENTS_RESPONSE') !== '') {
            $this->debug('documents.raw-string-response');
            return $this->view()->render_with_layout('console_documents.html', 'layout.html', [
                'title' => 'Knowledge Documents',
                'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
                'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
                'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
                'documents' => $documents,
                'write_error' => $this->flash($request, 'console.documents.error'),
                'write_notice' => $this->flash($request, 'console.documents.notice'),
                'page_section' => 'Knowledge Documents',
                'nav_label' => 'documents',
                'footer_note' => 'Document ingest will move from demo arrays to database-backed records next',
            ]);
        }

        $this->debug('documents.render');
        return $this->render_with_layout('console_documents.html', 'layout.html', [
            'title' => $copy['title'],
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'viewer_role' => is_array($viewer) ? (string) ($viewer['role'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'documents' => $documents,
            'document_edit_label' => $copy['document_edit_label'],
            'write_error' => $this->flash($request, 'console.documents.error'),
            'write_notice' => $this->flash($request, 'console.documents.notice'),
            'document_action' => $this->urls->consoleDocuments($locale),
            'can_manage_content' => $canManageContent ? '1' : '',
            'page_section' => $copy['page_section'],
            'nav_label' => $copy['nav_label'],
            'footer_note' => $copy['footer_note'],
            'sidebar_line' => $copy['sidebar_line'],
            'eyebrow' => $copy['eyebrow'],
            'intro' => $copy['intro'],
            'create_title' => $copy['create_title'],
            'title_label' => $copy['title_label'],
            'coverage_focus_label' => $copy['coverage_focus_label'],
            'summary_label' => $copy['summary_label'],
            'body_label' => $copy['body_label'],
            'language_label' => $copy['language_label'],
            'source_label' => $copy['source_label'],
            'submit_label' => $copy['submit_label'],
            'context_title' => $copy['context_title'],
            'viewer_label' => $copy['viewer_label'],
            'role_hint_label' => $copy['role_hint_label'],
            'content_editor_hint' => $copy['content_editor_hint'],
            'table_title' => $copy['table_title'],
            'col_title' => $copy['col_title'],
            'col_summary' => $copy['col_summary'],
            'col_source' => $copy['col_source'],
            'col_status' => $copy['col_status'],
            'col_chunks' => $copy['col_chunks'],
            'col_updated' => $copy['col_updated'],
            'editor_title' => $copy['editor_title'],
            'editor_intro' => $copy['editor_intro'],
            'workflow_title' => $copy['workflow_title'],
            'workflow_body' => $copy['workflow_body'],
            'workflow_one_title' => $copy['workflow_one_title'],
            'workflow_one_body' => $copy['workflow_one_body'],
            'workflow_two_title' => $copy['workflow_two_title'],
            'workflow_two_body' => $copy['workflow_two_body'],
            'workflow_three_title' => $copy['workflow_three_title'],
            'workflow_three_body' => $copy['workflow_three_body'],
            'composer_title' => $copy['composer_title'],
            'inventory_title' => $copy['inventory_title'],
            'inventory_body' => $copy['inventory_body'],
            'prefill' => $prefill,
            'frontend_style_url' => FrontendAsset::url('knowledge-studio.css'),
            'frontend_module_url' => FrontendAsset::url('knowledge-studio.js'),
            'lit_editor_empty_label' => $copy['lit_editor_empty_label'],
            'lit_editor_active_label' => $copy['lit_editor_active_label'],
            'lit_editor_helper_prefix' => $copy['lit_editor_helper_prefix'],
            ...$shared,
        ]);
    }

    public function editDocument(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect($this->urls->login($this->locale($request)), 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $locale = $this->locale($request);
        $copy = $this->locales->consoleDocuments($locale);
        $canManageContent = $this->console->canManageContent(is_array($viewer) ? $viewer : null);
        $document = $this->console->documentEditor(is_array($workspace) ? $workspace : null, $this->pathParam($request, 'document'));
        if ($document === null) {
            return $this->redirect($this->urls->consoleDocuments($locale), 302);
        }

        return $this->render_with_layout('console_document_editor.html', 'layout.html', [
            'title' => $copy['editor_title'],
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'viewer_role' => is_array($viewer) ? (string) ($viewer['role'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'document' => $document->toArray(),
            'document_summary_preview_html' => MarkdownPreview::render($document->summary),
            'document_body_preview_html' => MarkdownPreview::render($document->body),
            'save_action' => $this->urls->consoleDocumentEditor($document->id, $locale),
            'publish_action' => $this->urls->consoleDocumentEditor($document->id, $locale) . '/publish',
            'back_url' => $this->urls->consoleDocuments($locale),
            'can_manage_content' => $canManageContent ? '1' : '',
            'page_section' => $copy['page_section'],
            'nav_label' => $copy['nav_label'],
            'footer_note' => $copy['footer_note'],
            'sidebar_line' => $copy['sidebar_line'],
            'eyebrow' => $copy['eyebrow'],
            'editor_title' => $copy['editor_title'],
            'editor_intro' => $copy['editor_intro'],
            'title_label' => $copy['title_label'],
            'coverage_focus_label' => $copy['coverage_focus_label'],
            'summary_label' => $copy['summary_label'],
            'body_label' => $copy['body_label'],
            'language_label' => $copy['language_label'],
            'source_label' => $copy['source_label'],
            'status_label' => $copy['col_status'],
            'chunks_label' => $copy['col_chunks'],
            'role_hint_label' => $copy['role_hint_label'],
            'content_editor_hint' => $copy['content_editor_hint'],
            'save_label' => $copy['save_label'],
            'publish_label' => $copy['publish_label'],
            'back_label' => $copy['back_label'],
            'frontend_style_url' => FrontendAsset::url('knowledge-studio.css'),
            'frontend_module_url' => FrontendAsset::url('knowledge-studio.js'),
            'lit_editor_empty_label' => $copy['lit_editor_empty_label'],
            'lit_editor_active_label' => $copy['lit_editor_active_label'],
            'lit_editor_helper_prefix' => $copy['lit_editor_helper_prefix'],
        ]);
    }

    public function faqs(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect($this->urls->login($this->locale($request)), 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $entries = $this->console->entries($workspace);
        $locale = $this->locale($request);
        $copy = $this->locales->consoleFaqs($locale);
        $shared = $this->shared($locale, '/console/knowledge/faqs', is_array($workspace) ? $workspace : null);
        $canManageContent = $this->console->canManageContent(is_array($viewer) ? $viewer : null);
        $prefill = [
            'kind' => $this->queryValue($request, 'prefill_kind') ?: 'faq',
            'title' => $this->queryValue($request, 'prefill_title'),
            'coverage_focus' => $this->queryValue($request, 'prefill_coverage_focus'),
            'body' => $this->queryValue($request, 'prefill_body'),
            'kind_faq_selected' => ($this->queryValue($request, 'prefill_kind') ?: 'faq') === 'faq' ? 'selected' : '',
            'kind_topic_selected' => ($this->queryValue($request, 'prefill_kind') ?: 'faq') === 'topic' ? 'selected' : '',
        ];
        $entries = array_map(fn (array $item): array => [
            ...$item,
            'edit_url' => $this->urls->consoleEntryEditor((string) ($item['id'] ?? ''), $locale),
        ], $entries);

        return $this->render_with_layout('console_faqs.html', 'layout.html', [
            'title' => $copy['title'],
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'viewer_role' => is_array($viewer) ? (string) ($viewer['role'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'entries' => $entries,
            'entry_edit_label' => $copy['entry_edit_label'],
            'write_error' => $this->flash($request, 'console.entries.error'),
            'write_notice' => $this->flash($request, 'console.entries.notice'),
            'entry_action' => $this->urls->consoleFaqs($locale),
            'can_manage_content' => $canManageContent ? '1' : '',
            'page_section' => $copy['page_section'],
            'nav_label' => $copy['nav_label'],
            'footer_note' => $copy['footer_note'],
            'sidebar_line' => $copy['sidebar_line'],
            'eyebrow' => $copy['eyebrow'],
            'intro' => $copy['intro'],
            'create_title' => $copy['create_title'],
            'kind_label' => $copy['kind_label'],
            'title_label' => $copy['title_label'],
            'coverage_focus_label' => $copy['coverage_focus_label'],
            'body_label' => $copy['body_label'],
            'submit_label' => $copy['submit_label'],
            'context_title' => $copy['context_title'],
            'viewer_label' => $copy['viewer_label'],
            'role_hint_label' => $copy['role_hint_label'],
            'content_editor_hint' => $copy['content_editor_hint'],
            'table_title' => $copy['table_title'],
            'col_title' => $copy['col_title'],
            'col_kind' => $copy['col_kind'],
            'col_status' => $copy['col_status'],
            'col_owner' => $copy['col_owner'],
            'editor_title' => $copy['editor_title'],
            'editor_intro' => $copy['editor_intro'],
            'workflow_title' => $copy['workflow_title'],
            'workflow_body' => $copy['workflow_body'],
            'workflow_one_title' => $copy['workflow_one_title'],
            'workflow_one_body' => $copy['workflow_one_body'],
            'workflow_two_title' => $copy['workflow_two_title'],
            'workflow_two_body' => $copy['workflow_two_body'],
            'workflow_three_title' => $copy['workflow_three_title'],
            'workflow_three_body' => $copy['workflow_three_body'],
            'composer_title' => $copy['composer_title'],
            'inventory_title' => $copy['inventory_title'],
            'inventory_body' => $copy['inventory_body'],
            'prefill' => $prefill,
            'frontend_style_url' => FrontendAsset::url('knowledge-studio.css'),
            'frontend_module_url' => FrontendAsset::url('knowledge-studio.js'),
            'lit_entry_empty_label' => $copy['lit_entry_empty_label'],
            'lit_entry_active_label' => $copy['lit_entry_active_label'],
            'lit_entry_helper_prefix' => $copy['lit_entry_helper_prefix'],
            ...$shared,
        ]);
    }

    public function editEntry(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect($this->urls->login($this->locale($request)), 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $locale = $this->locale($request);
        $copy = $this->locales->consoleFaqs($locale);
        $canManageContent = $this->console->canManageContent(is_array($viewer) ? $viewer : null);
        $entry = $this->console->entryEditor(is_array($workspace) ? $workspace : null, $this->pathParam($request, 'entry'));
        if ($entry === null) {
            return $this->redirect($this->urls->consoleFaqs($locale), 302);
        }

        return $this->render_with_layout('console_entry_editor.html', 'layout.html', [
            'title' => $copy['editor_title'],
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'viewer_role' => is_array($viewer) ? (string) ($viewer['role'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'entry' => $entry->toArray(),
            'entry_body_preview_html' => MarkdownPreview::render($entry->body),
            'save_action' => $this->urls->consoleEntryEditor($entry->id, $locale),
            'publish_action' => $this->urls->consoleEntryEditor($entry->id, $locale) . '/publish',
            'back_url' => $this->urls->consoleFaqs($locale),
            'can_manage_content' => $canManageContent ? '1' : '',
            'page_section' => $copy['page_section'],
            'nav_label' => $copy['nav_label'],
            'footer_note' => $copy['footer_note'],
            'sidebar_line' => $copy['sidebar_line'],
            'eyebrow' => $copy['eyebrow'],
            'editor_title' => $copy['editor_title'],
            'editor_intro' => $copy['editor_intro'],
            'kind_label' => $copy['kind_label'],
            'title_label' => $copy['title_label'],
            'coverage_focus_label' => $copy['coverage_focus_label'],
            'body_label' => $copy['body_label'],
            'status_label' => $copy['col_status'],
            'owner_label' => $copy['col_owner'],
            'role_hint_label' => $copy['role_hint_label'],
            'content_editor_hint' => $copy['content_editor_hint'],
            'save_label' => $copy['save_label'],
            'publish_label' => $copy['publish_label'],
            'back_label' => $copy['back_label'],
            'frontend_style_url' => FrontendAsset::url('knowledge-studio.css'),
            'frontend_module_url' => FrontendAsset::url('knowledge-studio.js'),
            'lit_entry_empty_label' => $copy['lit_entry_empty_label'],
            'lit_entry_active_label' => $copy['lit_entry_active_label'],
            'lit_entry_helper_prefix' => $copy['lit_entry_helper_prefix'],
        ]);
    }

    public function ops(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect($this->urls->login($this->locale($request)), 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $ops = $this->console->ops($workspace);
        $jobs = $ops['jobs'];
        $logs = $ops['logs'];
        $locale = $this->locale($request);
        $copy = $this->locales->consoleOps($locale);
        $shared = $this->shared($locale, '/console/ops', is_array($workspace) ? $workspace : null);
        $canManageOps = $this->console->canManageOps(is_array($viewer) ? $viewer : null);

        return $this->render_with_layout('console_ops.html', 'layout.html', [
            'title' => $copy['title'],
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'viewer_role' => is_array($viewer) ? (string) ($viewer['role'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'jobs' => $jobs,
            'logs' => $logs,
            'write_error' => $this->flash($request, 'console.ops.error'),
            'write_notice' => $this->flash($request, 'console.ops.notice'),
            'job_action' => $this->urls->consoleJobs($locale),
            'can_manage_ops' => $canManageOps ? '1' : '',
            'page_section' => $copy['page_section'],
            'nav_label' => $copy['nav_label'],
            'footer_note' => $copy['footer_note'],
            'sidebar_line' => $copy['sidebar_line'],
            'eyebrow' => $copy['eyebrow'],
            'intro' => $copy['intro'],
            'create_title' => $copy['create_title'],
            'name_label' => $copy['name_label'],
            'submit_label' => $copy['submit_label'],
            'context_title' => $copy['context_title'],
            'viewer_label' => $copy['viewer_label'],
            'role_hint_label' => $copy['role_hint_label'],
            'owner_only_hint' => $copy['owner_only_hint'],
            'jobs_title' => $copy['jobs_title'],
            'audit_title' => $copy['audit_title'],
            'col_name' => $copy['col_name'],
            'col_status' => $copy['col_status'],
            'col_queued' => $copy['col_queued'],
            'col_when' => $copy['col_when'],
            'col_actor' => $copy['col_actor'],
            'col_action' => $copy['col_action'],
            'col_target' => $copy['col_target'],
            ...$shared,
        ]);
    }

    public function releases(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect($this->urls->login($this->locale($request)), 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $releases = $this->console->releases($workspace);
        $snapshot = $this->console->releaseSnapshot($workspace);
        $locale = $this->locale($request);
        $copy = $this->locales->consoleReleases($locale);
        $shared = $this->shared($locale, '/console/releases', is_array($workspace) ? $workspace : null);
        $canManageReleases = $this->console->canManageReleases(is_array($viewer) ? $viewer : null);
        $workspaceSlug = is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '';
        $summaryLabels = [
            'draft_documents' => $copy['change_summary_draft_documents'],
            'draft_entries' => $copy['change_summary_draft_entries'],
            'current_public' => $copy['change_summary_current_public'],
        ];
        $snapshot['change_summary'] = array_map(static function (array $item) use ($summaryLabels): array {
            $label = (string) ($item['label'] ?? '');
            $item['display_label'] = $summaryLabels[$label] ?? $label;
            return $item;
        }, is_array($snapshot['change_summary'] ?? null) ? $snapshot['change_summary'] : []);
        $compare = is_array($snapshot['version_compare'] ?? null) ? $snapshot['version_compare'] : ['current' => [], 'next' => []];
        $compare['current']['title'] = $copy['version_compare_current'];
        $compare['next']['title'] = $copy['version_compare_next'];
        $compare['current']['notes'] = trim((string) ($compare['current']['notes'] ?? '')) !== ''
            ? (string) $compare['current']['notes']
            : $copy['version_compare_empty_notes'];
        $compare['next']['notes'] = $copy['version_compare_next_notes'];
        $snapshot['version_compare'] = $compare;
        $releases = array_map(function (array $item) use ($locale, $workspaceSlug): array {
            $version = trim((string) ($item['version'] ?? ''));
            return [
                ...$item,
                'brand_url' => $workspaceSlug !== ''
                    ? $this->urls->brandWithQuery($workspaceSlug, $locale, ['release' => $version])
                    : $this->urls->console($locale),
                'assistant_url' => $workspaceSlug !== ''
                    ? $this->urls->assistantWithQuery($workspaceSlug, $locale, ['release' => $version])
                    : $this->urls->console($locale),
            ];
        }, $releases);

        return $this->render_with_layout('console_releases.html', 'layout.html', [
            'title' => $copy['title'],
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'viewer_role' => is_array($viewer) ? (string) ($viewer['role'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'releases' => $releases,
            'snapshot' => $snapshot,
            'write_error' => $this->flash($request, 'console.releases.error'),
            'write_notice' => $this->flash($request, 'console.releases.notice'),
            'release_action' => $this->urls->consoleReleases($locale),
            'can_manage_releases' => $canManageReleases ? '1' : '',
            'page_section' => $copy['page_section'],
            'nav_label' => $copy['nav_label'],
            'footer_note' => $copy['footer_note'],
            'sidebar_line' => $copy['sidebar_line'],
            'eyebrow' => $copy['eyebrow'],
            'intro' => $copy['intro'],
            'create_title' => $copy['create_title'],
            'version_label' => $copy['version_label'],
            'notes_label' => $copy['notes_label'],
            'submit_label' => $copy['submit_label'],
            'context_title' => $copy['context_title'],
            'viewer_label' => $copy['viewer_label'],
            'role_hint_label' => $copy['role_hint_label'],
            'owner_only_hint' => $copy['owner_only_hint'],
            'snapshot_title' => $copy['snapshot_title'],
            'published_documents_label' => $copy['published_documents_label'],
            'published_entries_label' => $copy['published_entries_label'],
            'draft_documents_label' => $copy['draft_documents_label'],
            'draft_entries_label' => $copy['draft_entries_label'],
            'latest_release_label' => $copy['latest_release_label'],
            'ready_label' => $copy['ready_label'],
            'release_checks_title' => $copy['release_checks_title'],
            'readiness_summary_title' => $copy['readiness_summary_title'],
            'gap_signals_title' => $copy['gap_signals_title'],
            'gap_signals_body' => $copy['gap_signals_body'],
            'public_preview_title' => $copy['public_preview_title'],
            'public_preview_body' => $copy['public_preview_body'],
            'change_summary_title' => $copy['change_summary_title'],
            'change_summary_body' => $copy['change_summary_body'],
            'change_summary_draft_documents' => $copy['change_summary_draft_documents'],
            'change_summary_draft_entries' => $copy['change_summary_draft_entries'],
            'change_summary_current_public' => $copy['change_summary_current_public'],
            'version_compare_title' => $copy['version_compare_title'],
            'version_compare_body' => $copy['version_compare_body'],
            'current_public_title' => $copy['current_public_title'],
            'draft_preview_documents_title' => $copy['draft_preview_documents_title'],
            'draft_preview_entries_title' => $copy['draft_preview_entries_title'],
            'preview_documents_title' => $copy['preview_documents_title'],
            'preview_entries_title' => $copy['preview_entries_title'],
            'brand_page_cta' => $copy['brand_page_cta'],
            'assistant_page_cta' => $copy['assistant_page_cta'],
            'brand_page_url' => is_array($workspace)
                ? $this->urls->brand((string) ($workspace['slug'] ?? ''), $locale)
                : $this->urls->console($locale),
            'assistant_page_url' => is_array($workspace)
                ? $this->urls->assistant((string) ($workspace['slug'] ?? ''), $locale)
                : $this->urls->console($locale),
            'workflow_title' => $copy['workflow_title'],
            'workflow_body' => $copy['workflow_body'],
            'workflow_one_title' => $copy['workflow_one_title'],
            'workflow_one_body' => $copy['workflow_one_body'],
            'workflow_two_title' => $copy['workflow_two_title'],
            'workflow_two_body' => $copy['workflow_two_body'],
            'workflow_three_title' => $copy['workflow_three_title'],
            'workflow_three_body' => $copy['workflow_three_body'],
            'composer_title' => $copy['composer_title'],
            'checks_panel_title' => $copy['checks_panel_title'],
            'candidates_panel_title' => $copy['candidates_panel_title'],
            'history_title' => $copy['history_title'],
            'candidate_documents_title' => $copy['candidate_documents_title'],
            'candidate_entries_title' => $copy['candidate_entries_title'],
            'selection_hint' => $copy['selection_hint'],
            'table_title' => $copy['table_title'],
            'col_version' => $copy['col_version'],
            'col_status' => $copy['col_status'],
            'col_notes' => $copy['col_notes'],
            'col_documents' => $copy['col_documents'],
            'col_entries' => $copy['col_entries'],
            'col_created' => $copy['col_created'],
            'col_actions' => $copy['col_actions'],
            'history_brand_cta' => $copy['history_brand_cta'],
            'history_assistant_cta' => $copy['history_assistant_cta'],
            ...$shared,
        ]);
    }

    public function storeDocument(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $result = $this->console->createDocument(
            is_array($workspace) ? $workspace : null,
            is_array($viewer) ? $viewer : null,
            $this->requestData($request),
        );

        return $this->flashRedirect(
            $request,
            $this->urls->consoleDocuments($this->locale($request)),
            $result['ok'] ? 'console.documents.notice' : 'console.documents.error',
            $result['message'],
        );
    }

    public function storeEntry(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $result = $this->console->createEntry(
            is_array($workspace) ? $workspace : null,
            is_array($viewer) ? $viewer : null,
            $this->requestData($request),
        );

        return $this->flashRedirect(
            $request,
            $this->urls->consoleFaqs($this->locale($request)),
            $result['ok'] ? 'console.entries.notice' : 'console.entries.error',
            $result['message'],
        );
    }

    public function storeMember(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $result = $this->console->inviteMember(
            is_array($workspace) ? $workspace : null,
            is_array($viewer) ? $viewer : null,
            $this->requestData($request),
        );

        return $this->flashRedirect(
            $request,
            $this->urls->consoleMembers($this->locale($request)),
            $result['ok'] ? 'console.members.notice' : 'console.members.error',
            $result['message'],
        );
    }

    public function updateDocument(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $documentId = $this->pathParam($request, 'document');
        $result = $this->console->updateDocument(
            is_array($workspace) ? $workspace : null,
            is_array($viewer) ? $viewer : null,
            $documentId,
            $this->requestData($request),
        );

        return $this->flashRedirect(
            $request,
            $this->urls->consoleDocumentEditor($documentId, $this->locale($request)),
            $result['ok'] ? 'console.documents.notice' : 'console.documents.error',
            $result['message'],
        );
    }

    public function publishDocument(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        $documentId = $this->pathParam($request, 'document');
        return $this->flashRedirect(
            $request,
            $this->urls->consoleDocumentEditor($documentId, $this->locale($request)),
            'console.documents.error',
            'Direct publishing is disabled. Save the draft here, then publish from the release center.',
        );
    }

    public function updateEntry(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $entryId = $this->pathParam($request, 'entry');
        $result = $this->console->updateEntry(
            is_array($workspace) ? $workspace : null,
            is_array($viewer) ? $viewer : null,
            $entryId,
            $this->requestData($request),
        );

        return $this->flashRedirect(
            $request,
            $this->urls->consoleEntryEditor($entryId, $this->locale($request)),
            $result['ok'] ? 'console.entries.notice' : 'console.entries.error',
            $result['message'],
        );
    }

    public function publishEntry(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        $entryId = $this->pathParam($request, 'entry');
        return $this->flashRedirect(
            $request,
            $this->urls->consoleEntryEditor($entryId, $this->locale($request)),
            'console.entries.error',
            'Direct publishing is disabled. Save the draft here, then publish from the release center.',
        );
    }

    public function storeJob(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $result = $this->console->queueJob(
            is_array($workspace) ? $workspace : null,
            is_array($viewer) ? $viewer : null,
            $this->requestData($request),
        );

        return $this->flashRedirect(
            $request,
            $this->urls->consoleOps($this->locale($request)),
            $result['ok'] ? 'console.ops.notice' : 'console.ops.error',
            $result['message'],
        );
    }

    public function storeRelease(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $result = $this->console->createRelease(
            is_array($workspace) ? $workspace : null,
            is_array($viewer) ? $viewer : null,
            $this->requestData($request),
        );

        return $this->flashRedirect(
            $request,
            $this->urls->consoleReleases($this->locale($request)),
            $result['ok'] ? 'console.releases.notice' : 'console.releases.error',
            $result['message'],
        );
    }

    /**
     * @return array{0:mixed,1:mixed,2:array<int, array<string, string>>}
     */
    private function consoleContext(\VSlim\Psr7\ServerRequest $request): array
    {
        $viewer = $this->app()->authUser($request);
        $resolved = $this->console->resolveContext(
            is_array($viewer) ? $viewer : null,
            $request->getAttribute('studio.workspace'),
        );
        $workspace = $resolved['workspace'];
        $memberships = $resolved['memberships'];

        return [$viewer, $workspace, $memberships];
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

    private function flash(\VSlim\Psr7\ServerRequest $request, string $key): string
    {
        return $this->app()->session($request)->pullFlash($key, '');
    }

    private function pathParam(\VSlim\Psr7\ServerRequest $request, string $key): string
    {
        $value = $request->getAttribute($key);
        if (is_scalar($value)) {
            return trim((string) $value);
        }

        return '';
    }

    private function queryValue(\VSlim\Psr7\ServerRequest $request, string $key): string
    {
        $params = $request->getQueryParams();
        if (is_array($params) && array_key_exists($key, $params)) {
            return trim((string) ($params[$key] ?? ''));
        }

        return '';
    }

    /**
     * @return array<string, string>
     */
    private function shared(string $locale, string $path, ?array $workspace = null): array
    {
        $shared = $this->locales->shared($locale, $path);
        $slug = is_array($workspace) ? trim((string) ($workspace['slug'] ?? '')) : '';
        $publicUrl = $slug !== '' ? $this->urls->brand($slug, $locale) : $this->urls->console($locale);
        $assistantPreviewUrl = $slug !== '' ? $this->urls->assistant($slug, $locale) : $this->urls->console($locale);

        $active = 'workbench';
        if (str_starts_with($path, '/console/knowledge/')) {
            $active = 'content';
        } elseif (str_starts_with($path, '/console/releases')) {
            $active = 'publish';
        } elseif (str_starts_with($path, '/console/members') || str_starts_with($path, '/console/ops')) {
            $active = 'settings';
        }

        return [
            ...$shared,
            'top_nav' => [
                [
                    'label' => $shared['nav_workbench_label'],
                    'url' => $this->urls->console($locale),
                    'class' => $active === 'workbench' ? 'active' : '',
                ],
                [
                    'label' => $shared['nav_content_label'],
                    'url' => $this->urls->consoleDocuments($locale),
                    'class' => $active === 'content' ? 'active' : '',
                ],
                [
                    'label' => $shared['nav_publish_label'],
                    'url' => $this->urls->consoleReleases($locale),
                    'class' => $active === 'publish' ? 'active' : '',
                ],
                [
                    'label' => $shared['nav_public_label'],
                    'url' => $publicUrl,
                    'class' => $active === 'public' ? 'active' : '',
                ],
                [
                    'label' => $shared['nav_settings_label'],
                    'url' => $this->urls->consoleMembers($locale),
                    'class' => $active === 'settings' ? 'active' : '',
                ],
            ],
            'section_nav' => $this->sectionNav($shared, $locale, $active, $path, $publicUrl, $assistantPreviewUrl),
        ];
    }

    /**
     * @param array<string, string> $shared
     * @return array<int, array<string, string>>
     */
    private function sectionNav(
        array $shared,
        string $locale,
        string $active,
        string $path,
        string $publicUrl,
        string $assistantPreviewUrl,
    ): array
    {
        if ($active === 'content') {
            return [
                [
                    'label' => $shared['subnav_documents_label'],
                    'url' => $this->urls->consoleDocuments($locale),
                    'class' => str_starts_with($path, '/console/knowledge/documents') ? 'active' : '',
                ],
                [
                    'label' => $shared['subnav_entries_label'],
                    'url' => $this->urls->consoleFaqs($locale),
                    'class' => str_starts_with($path, '/console/knowledge/faqs') ? 'active' : '',
                ],
            ];
        }

        if ($active === 'publish') {
            return [
                [
                    'label' => $shared['subnav_releases_label'],
                    'url' => $this->urls->consoleReleases($locale),
                    'class' => str_starts_with($path, '/console/releases') ? 'active' : '',
                ],
                [
                    'label' => $shared['subnav_public_preview_label'],
                    'url' => $publicUrl,
                    'class' => '',
                ],
                [
                    'label' => $shared['subnav_assistant_preview_label'],
                    'url' => $assistantPreviewUrl,
                    'class' => '',
                ],
            ];
        }

        if ($active === 'settings') {
            return [
                [
                    'label' => $shared['subnav_members_label'],
                    'url' => $this->urls->consoleMembers($locale),
                    'class' => str_starts_with($path, '/console/members') ? 'active' : '',
                ],
                [
                    'label' => $shared['subnav_ops_label'],
                    'url' => $this->urls->consoleOps($locale),
                    'class' => str_starts_with($path, '/console/ops') ? 'active' : '',
                ],
            ];
        }

        return [
            [
                'label' => $shared['subnav_overview_label'],
                'url' => $this->urls->console($locale),
                'class' => 'active',
            ],
        ];
    }

    private function locale(\VSlim\Psr7\ServerRequest $request): string
    {
        return $this->locales->resolve((string) $request->getAttribute('studio.locale', 'zh-CN'));
    }

    private function flashRedirect(\VSlim\Psr7\ServerRequest $request, string $location, string $key, string $message): \VSlim\Vhttpd\Response
    {
        $session = $this->app()->session($request);
        if ($message !== '') {
            $session->flash($key, $message);
        }
        $response = new \VSlim\Vhttpd\Response(302, '', 'text/plain; charset=utf-8');
        $response->redirect_with_status($location, 302);
        $session->commit($response);
        return $response;
    }
}
