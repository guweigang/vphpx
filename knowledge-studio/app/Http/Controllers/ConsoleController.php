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

    public function index(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
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
        $urgentJobs = is_array($dashboard['urgent_jobs'] ?? null) ? $dashboard['urgent_jobs'] : [];
        $subscriptions = is_array($dashboard['subscriptions'] ?? null) ? $dashboard['subscriptions'] : ['count' => 0, 'recent' => [], 'plans' => []];
        $questions = is_array($dashboard['questions'] ?? null) ? $dashboard['questions'] : [];
        $gaps = is_array($dashboard['gaps'] ?? null) ? $dashboard['gaps'] : [];
        $priorities = is_array($dashboard['priorities'] ?? null) ? $dashboard['priorities'] : [];
        $locale = $this->locale($request);
        $copy = $this->locales->consoleIndex($locale);
        $shared = $this->shared($locale, '/console', is_array($workspace) ? $workspace : null, $memberships);
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
                    ? $this->urls->validationWithQuery($workspaceSlug, $locale, ['q' => $question])
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
        $urgentJobs = array_map(function (array $item) use ($locale): array {
            $status = strtolower(trim((string) ($item['status'] ?? 'queued')));
            return [
                ...$item,
                'status' => $status,
                'status_badge_class' => $this->jobStatusBadgeClass($status),
                'ops_url' => $this->urls->consoleOps($locale),
                'can_retry' => $status === 'failed' ? '1' : '',
                'retry_url' => $this->urls->consoleJobRetry((string) ($item['id'] ?? ''), $locale),
            ];
        }, $urgentJobs);

        $this->debug('index.render');
        return $this->renderWithLayout('console.html', 'layout.html', [
            'title' => $copy['title'],
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'viewer_role' => is_array($viewer) ? (string) ($viewer['role'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'workspace_brand' => is_array($workspace) ? (string) ($workspace['brand_name'] ?? '') : '',
            'workspace_plan' => is_array($workspace) ? (string) ($workspace['plan'] ?? '') : '',
            'workspace_members' => (string) count($members),
            'workspace_notice' => $this->flash($request, 'console.workspace.notice'),
            'workspace_error' => $this->flash($request, 'console.workspace.error'),
            'sidebar_line_plan' => $copy['sidebar_line_plan'],
            'sidebar_line_collaborators' => $copy['sidebar_line_collaborators'],
            'member_count' => count($members),
            'memberships' => $memberships,
            'documents_total' => (string) ($metrics['documents'] ?? '0'),
            'entries_total' => (string) ($metrics['entries'] ?? '0'),
            'jobs_total' => (string) ($metrics['jobs'] ?? '0'),
            'failed_jobs_total' => (string) ($metrics['failed_jobs'] ?? '0'),
            'active_jobs_total' => (string) ($metrics['active_jobs'] ?? '0'),
            'draft_documents_total' => (string) ($metrics['draft_documents'] ?? '0'),
            'draft_entries_total' => (string) ($metrics['draft_entries'] ?? '0'),
            'published_entries_total' => (string) ($metrics['published_entries'] ?? '0'),
            'knowledge_gaps_total' => (string) ($metrics['knowledge_gaps'] ?? '0'),
            'recent_questions_total' => (string) ($metrics['recent_questions'] ?? '0'),
            'subscriptions_total' => (string) ($subscriptions['count'] ?? '0'),
            'published_documents' => (string) ($metrics['published_documents'] ?? '0'),
            'assistant_status' => (string) ($metrics['assistant_status'] ?? 'draft'),
            'documents_url' => $this->urls->consoleDocuments($locale),
            'faqs_url' => $this->urls->consoleFaqs($locale),
            'members_url' => $this->urls->consoleMembers($locale),
            'ops_url' => $this->urls->consoleOps($locale),
            'releases_url' => $this->urls->consoleReleases($locale),
            'documents' => array_map(function (array $item) use ($locale): array {
                return [
                    ...$item,
                    'edit_url' => $this->urls->consoleDocumentEditor((string) ($item['id'] ?? ''), $locale),
                ];
            }, array_slice($documents, 0, 2)),
            'entries' => array_map(function (array $item) use ($locale): array {
                return [
                    ...$item,
                    'edit_url' => $this->urls->consoleEntryEditor((string) ($item['id'] ?? ''), $locale),
                ];
            }, array_slice($entries, 0, 2)),
            'jobs' => array_slice($jobs, 0, 2),
            'urgent_jobs' => $urgentJobs,
            'quick_subscription_recent' => array_slice($subscriptionRecent, 0, 2),
            'quick_questions' => array_slice($questions, 0, 2),
            'quick_gaps' => array_slice($gaps, 0, 2),
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
                ? $this->urls->validation((string) ($workspace['slug'] ?? ''), $locale)
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
            'recent_document_cta' => $copy['recent_document_cta'],
            'recent_entry_cta' => $copy['recent_entry_cta'],
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

    public function members(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect($this->urls->login($this->locale($request)), 302);
        }

        [$viewer, $workspace, $memberships] = $this->consoleContext($request);
        $members = $this->console->members($workspace);
        $locale = $this->locale($request);
        $copy = $this->locales->consoleMembers($locale);
        $shared = $this->shared($locale, '/console/members', is_array($workspace) ? $workspace : null, $memberships);
        $canManageMembers = $this->console->canManageMembers(is_array($viewer) ? $viewer : null);
        $viewerUserId = is_array($viewer) ? trim((string) ($viewer['id'] ?? '')) : '';
        $members = array_map(function (array $member) use ($locale, $canManageMembers, $viewerUserId): array {
            $memberId = trim((string) ($member['id'] ?? ''));
            $role = trim((string) ($member['role'] ?? ''));
            $userId = trim((string) ($member['user_id'] ?? ''));
            $isSelf = $viewerUserId !== '' && $viewerUserId === $userId;
            return [
                ...$member,
                'role_owner_selected' => $role === 'tenant_owner' ? 'selected' : '',
                'role_editor_selected' => $role === 'knowledge_editor' ? 'selected' : '',
                'role_reviewer_selected' => $role === 'reviewer' ? 'selected' : '',
                'role_action' => $this->urls->consoleMemberRole($memberId, $locale),
                'remove_action' => $this->urls->consoleMemberRemove($memberId, $locale),
                'can_manage' => $canManageMembers ? '1' : '',
                'is_self' => $isSelf ? '1' : '',
                'show_actions' => $canManageMembers && !$isSelf ? '1' : '',
            ];
        }, $members);

        return $this->renderWithLayout('console_members.html', 'layout.html', [
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
            'col_actions' => $copy['col_actions'],
            'password_hint' => $copy['password_hint'],
            'role_update_submit' => $copy['role_update_submit'],
            'remove_submit' => $copy['remove_submit'],
            'self_protected_hint' => $copy['self_protected_hint'],
            ...$shared,
        ]);
    }

    public function account(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect($this->urls->login($this->locale($request)), 302);
        }

        [$viewer, $workspace, $memberships] = $this->consoleContext($request);
        $locale = $this->locale($request);
        $copy = $this->locales->consoleAccount($locale);
        $shared = $this->shared($locale, '/console/account', is_array($workspace) ? $workspace : null, $memberships);
        $requiresPasswordReset = $this->console->requiresPasswordReset(is_array($viewer) ? $viewer : null);

        return $this->renderWithLayout('console_account.html', 'layout.html', [
            'title' => $copy['title'],
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'viewer_email' => is_array($viewer) ? (string) ($viewer['email'] ?? '') : '',
            'viewer_role' => is_array($viewer) ? (string) ($viewer['role'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'write_error' => $this->flash($request, 'console.account.error'),
            'write_notice' => $this->flash($request, 'console.account.notice'),
            'account_action' => $this->urls->consoleAccountPassword($locale),
            'requires_password_reset' => $requiresPasswordReset ? '1' : '',
            'page_section' => $copy['page_section'],
            'nav_label' => $copy['nav_label'],
            'footer_note' => $copy['footer_note'],
            'sidebar_line' => $copy['sidebar_line'],
            'eyebrow' => $copy['eyebrow'],
            'intro' => $copy['intro'],
            'form_title' => $copy['form_title'],
            'current_password_label' => $copy['current_password_label'],
            'new_password_label' => $copy['new_password_label'],
            'confirm_password_label' => $copy['confirm_password_label'],
            'submit_label' => $copy['submit_label'],
            'context_title' => $copy['context_title'],
            'email_label' => $copy['email_label'],
            'role_label' => $copy['role_label'],
            'workspace_label' => $copy['workspace_label'],
            'security_title' => $copy['security_title'],
            'security_copy' => $copy['security_copy'],
            'reset_required_notice' => $copy['reset_required_notice'],
            'reset_complete_notice' => $copy['reset_complete_notice'],
            ...$shared,
        ]);
    }

    public function subscribers(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect($this->urls->login($this->locale($request)), 302);
        }

        [$viewer, $workspace, $memberships] = $this->consoleContext($request);
        $locale = $this->locale($request);
        $copy = $this->locales->consoleSubscribers($locale);
        $shared = $this->shared($locale, '/console/subscribers', is_array($workspace) ? $workspace : null, $memberships);
        $canManageOps = $this->console->canManageOps(is_array($viewer) ? $viewer : null);
        $statusFilter = $this->queryValue($request, 'status');
        $planFilter = $this->queryValue($request, 'plan');
        $pendingSubscriberId = $this->queryValue($request, 'subscriber');
        $pendingStatus = $this->queryValue($request, 'status_value');
        $pendingNote = $this->queryValue($request, 'status_note');
        $subscriberRows = $this->console->subscribers($workspace);
        $subscriberRows = array_values(array_filter($subscriberRows, static function (array $row) use ($statusFilter, $planFilter): bool {
            if ($statusFilter !== '' && trim((string) ($row['status'] ?? '')) !== $statusFilter) {
                return false;
            }

            if ($planFilter !== '') {
                $plans = array_map('trim', explode(',', (string) ($row['plans'] ?? '')));
                if (!in_array($planFilter, $plans, true)) {
                    return false;
                }
            }

            return true;
        }));
        usort($subscriberRows, fn (array $left, array $right): int => $this->compareSubscriberLeads($left, $right));
        $subscribers = array_map(function (array $row) use (
            $locale,
            $canManageOps,
            $copy,
            $pendingSubscriberId,
            $pendingStatus,
            $pendingNote,
        ): array {
            $subscriberId = trim((string) ($row['id'] ?? ''));
            $status = trim((string) ($row['status'] ?? 'active'));
            $priority = $this->subscriberPriorityMeta($row, $copy);
            return [
                ...$row,
                'status_active_selected' => $status === 'active' ? 'selected' : '',
                'status_contacted_selected' => $status === 'contacted' ? 'selected' : '',
                'status_qualified_selected' => $status === 'qualified' ? 'selected' : '',
                'status_inactive_selected' => $status === 'inactive' ? 'selected' : '',
                'status_active_current' => $pendingSubscriberId === $subscriberId && $pendingStatus !== ''
                    ? ($pendingStatus === 'active' ? 'selected' : '')
                    : ($status === 'active' ? 'selected' : ''),
                'status_contacted_current' => $pendingSubscriberId === $subscriberId && $pendingStatus !== ''
                    ? ($pendingStatus === 'contacted' ? 'selected' : '')
                    : ($status === 'contacted' ? 'selected' : ''),
                'status_qualified_current' => $pendingSubscriberId === $subscriberId && $pendingStatus !== ''
                    ? ($pendingStatus === 'qualified' ? 'selected' : '')
                    : ($status === 'qualified' ? 'selected' : ''),
                'status_inactive_current' => $pendingSubscriberId === $subscriberId && $pendingStatus !== ''
                    ? ($pendingStatus === 'inactive' ? 'selected' : '')
                    : ($status === 'inactive' ? 'selected' : ''),
                'status_note_value' => $pendingSubscriberId === $subscriberId ? $pendingNote : '',
                'priority_label' => $priority['label'],
                'priority_badge_class' => $priority['class'],
                'stage_label' => (string) ($row['stage'] ?? 'new'),
                'assignee_label' => trim((string) ($row['assignee_name'] ?? '')) !== ''
                    ? trim((string) ($row['assignee_name'] ?? ''))
                    : (string) ($copy['unassigned_value'] ?? 'Unassigned'),
                'next_followup_label' => trim((string) ($row['next_followup_at'] ?? '')) !== ''
                    ? trim((string) ($row['next_followup_at'] ?? ''))
                    : (string) ($copy['no_followup_value'] ?? 'Not scheduled'),
                'detail_url' => $this->urls->consoleSubscriberDetail($subscriberId, $locale),
                'status_action' => $this->urls->consoleSubscriberStatus($subscriberId, $locale),
                'can_manage' => $canManageOps ? '1' : '',
            ];
        }, $subscriberRows);

        return $this->renderWithLayout('console_subscribers.html', 'layout.html', [
            'title' => $copy['title'],
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'viewer_role' => is_array($viewer) ? (string) ($viewer['role'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'subscribers' => $subscribers,
            'has_subscribers' => $subscribers !== [] ? '1' : '',
            'show_no_subscribers' => $subscribers === [] ? '1' : '',
            'write_error' => $this->flash($request, 'console.subscribers.error'),
            'write_notice' => $this->flash($request, 'console.subscribers.notice'),
            'page_section' => $copy['page_section'],
            'nav_label' => $copy['nav_label'],
            'footer_note' => $copy['footer_note'],
            'sidebar_line' => $copy['sidebar_line'],
            'eyebrow' => $copy['eyebrow'],
            'intro' => $copy['intro'],
            'context_title' => $copy['context_title'],
            'viewer_label' => $copy['viewer_label'],
            'role_hint_label' => $copy['role_hint_label'],
            'owner_only_hint' => $copy['owner_only_hint'],
            'filters_title' => $copy['filters_title'],
            'filter_status_label' => $copy['filter_status_label'],
            'filter_plan_label' => $copy['filter_plan_label'],
            'filter_any_status' => $copy['filter_any_status'],
            'filter_any_plan' => $copy['filter_any_plan'],
            'filter_apply_submit' => $copy['filter_apply_submit'],
            'filter_action' => $this->urls->consoleSubscribers($locale),
            'filter_status_active_selected' => $statusFilter === 'active' ? 'selected' : '',
            'filter_status_contacted_selected' => $statusFilter === 'contacted' ? 'selected' : '',
            'filter_status_qualified_selected' => $statusFilter === 'qualified' ? 'selected' : '',
            'filter_status_inactive_selected' => $statusFilter === 'inactive' ? 'selected' : '',
            'filter_plan_starter_selected' => $planFilter === 'starter' ? 'selected' : '',
            'filter_plan_team_selected' => $planFilter === 'team' ? 'selected' : '',
            'filter_plan_enterprise_selected' => $planFilter === 'enterprise' ? 'selected' : '',
            'table_title' => $copy['table_title'],
            'empty_title' => $copy['empty_title'],
            'empty_body' => $copy['empty_body'],
            'detail_cta' => $copy['detail_cta'],
            'col_priority' => $copy['col_priority'],
            'col_email' => $copy['col_email'],
            'col_contact' => $copy['col_contact'],
            'col_company' => $copy['col_company'],
            'col_plans' => $copy['col_plans'],
            'col_source' => $copy['col_source'],
            'col_notes' => $copy['col_notes'],
            'col_status' => $copy['col_status'],
            'col_stage' => $copy['col_stage'],
            'col_owner' => $copy['col_owner'],
            'col_followup' => $copy['col_followup'],
            'col_subscriptions' => $copy['col_subscriptions'],
            'col_created' => $copy['col_created'],
            'col_latest' => $copy['col_latest'],
            'col_actions' => $copy['col_actions'],
            'status_note_label' => $copy['status_note_label'],
            'status_note_placeholder' => $copy['status_note_placeholder'],
            'status_update_submit' => $copy['status_update_submit'],
            ...$shared,
        ]);
    }

    public function subscriberDetail(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect($this->urls->login($this->locale($request)), 302);
        }

        [$viewer, $workspace, $memberships] = $this->consoleContext($request);
        $subscriberId = $this->pathParam($request, 'subscriber');
        $locale = $this->locale($request);
        $copy = $this->locales->consoleSubscriberDetail($locale);
        $shared = $this->shared($locale, '/console/subscribers', is_array($workspace) ? $workspace : null, $memberships);
        $lead = $this->console->subscriberDetail($workspace, $subscriberId);
        if (!is_array($lead)) {
            return $this->redirect($this->urls->consoleSubscribers($locale), 302);
        }

        $followups = $this->localizeSubscriberFollowups(
            is_array($workspace) ? $workspace : null,
            $locale,
            $this->console->subscriberFollowups($workspace, $subscriberId),
        );
        $provisioningItems = $this->localizeProvisioningItems(
            is_array($workspace) ? $workspace : null,
            $locale,
            $this->console->subscriberProvisioningItems($workspace, $subscriberId),
        );
        $members = $this->console->members($workspace);
        $assigneeUserId = (string) ($lead['assignee_user_id'] ?? '');
        $memberOptions = array_map(static function (array $member) use ($assigneeUserId): array {
            $userId = trim((string) ($member['user_id'] ?? ''));
            $label = trim((string) ($member['name'] ?? '')) !== ''
                ? trim((string) ($member['name'] ?? ''))
                : trim((string) ($member['email'] ?? ''));
            return [
                'value' => $userId,
                'label' => $label,
                'selected' => $userId !== '' && $userId === $assigneeUserId ? 'selected' : '',
            ];
        }, $members);

        return $this->renderWithLayout('console_subscriber_detail.html', 'layout.html', [
            'title' => $copy['title'],
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'viewer_role' => is_array($viewer) ? (string) ($viewer['role'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'lead_email' => (string) ($lead['email'] ?? ''),
            'lead_contact_name' => (string) ($lead['contact_name'] ?? ''),
            'lead_company_name' => (string) ($lead['company_name'] ?? ''),
            'lead_plans' => (string) ($lead['plans'] ?? ''),
            'lead_status' => (string) ($lead['status'] ?? ''),
            'lead_stage' => (string) ($lead['stage'] ?? 'new'),
            'lead_closed_reason' => (string) ($lead['closed_reason'] ?? ''),
            'lead_source_label' => (string) ($lead['source_label'] ?? ''),
            'lead_notes' => (string) ($lead['notes'] ?? ''),
            'lead_assignee_name' => trim((string) ($lead['assignee_name'] ?? '')) !== ''
                ? trim((string) ($lead['assignee_name'] ?? ''))
                : (string) ($copy['unassigned_value'] ?? ''),
            'lead_next_followup_at' => trim((string) ($lead['next_followup_at'] ?? '')) !== ''
                ? trim((string) ($lead['next_followup_at'] ?? ''))
                : (string) ($copy['no_followup_value'] ?? ''),
            'lead_next_followup_input' => (string) ($lead['next_followup_input'] ?? ''),
            'lead_latest_activity_at' => (string) ($lead['latest_activity_at'] ?? ''),
            'followups' => $followups,
            'provisioning_items' => array_map(function (array $item) use ($subscriberId, $locale): array {
                return [
                    ...$item,
                    'status_badge_class' => ((string) ($item['status'] ?? '')) === 'done' ? 'ks-badge success' : 'ks-badge warn',
                    'complete_action' => $this->urls->consoleSubscriberProvisioningComplete($subscriberId, (string) ($item['id'] ?? ''), $locale),
                    'can_complete' => ((string) ($item['status'] ?? '')) !== 'done' ? '1' : '',
                ];
            }, $provisioningItems),
            'has_provisioning_items' => $provisioningItems !== [] ? '1' : '',
            'show_no_provisioning_items' => $provisioningItems === [] ? '1' : '',
            'has_followups' => $followups !== [] ? '1' : '',
            'show_no_followups' => $followups === [] ? '1' : '',
            'member_options' => $memberOptions,
            'has_member_options' => $memberOptions !== [] ? '1' : '',
            'write_error' => $this->flash($request, 'console.subscriber_detail.error'),
            'write_notice' => $this->flash($request, 'console.subscriber_detail.notice'),
            'followup_action' => $this->urls->consoleSubscriberFollowups($subscriberId, $locale),
            'status_action' => $this->urls->consoleSubscriberStatus($subscriberId, $locale),
            'provisioning_action' => $this->urls->consoleSubscriberProvisioning($subscriberId, $locale),
            'back_url' => $this->urls->consoleSubscribers($locale),
            'can_manage_ops' => $this->console->canManageOps(is_array($viewer) ? $viewer : null) ? '1' : '',
            'show_provisioning_cta' => ((string) ($lead['stage'] ?? '')) === 'won' ? '1' : '',
            'status_active_selected' => ((string) ($lead['status'] ?? '')) === 'active' ? 'selected' : '',
            'status_contacted_selected' => ((string) ($lead['status'] ?? '')) === 'contacted' ? 'selected' : '',
            'status_qualified_selected' => ((string) ($lead['status'] ?? '')) === 'qualified' ? 'selected' : '',
            'status_inactive_selected' => ((string) ($lead['status'] ?? '')) === 'inactive' ? 'selected' : '',
            'stage_new_selected' => ((string) ($lead['stage'] ?? 'new')) === 'new' ? 'selected' : '',
            'stage_discovery_selected' => ((string) ($lead['stage'] ?? '')) === 'discovery' ? 'selected' : '',
            'stage_proposal_selected' => ((string) ($lead['stage'] ?? '')) === 'proposal' ? 'selected' : '',
            'stage_won_selected' => ((string) ($lead['stage'] ?? '')) === 'won' ? 'selected' : '',
            'stage_lost_selected' => ((string) ($lead['stage'] ?? '')) === 'lost' ? 'selected' : '',
            'page_section' => $copy['page_section'],
            'nav_label' => $copy['nav_label'],
            'footer_note' => $copy['footer_note'],
            'sidebar_line' => $copy['sidebar_line'],
            'eyebrow' => $copy['eyebrow'],
            'intro' => $copy['intro'],
            'context_title' => $copy['context_title'],
            'viewer_label' => $copy['viewer_label'],
            'role_hint_label' => $copy['role_hint_label'],
            'owner_only_hint' => $copy['owner_only_hint'],
            'back_label' => $copy['back_label'],
            'profile_title' => $copy['profile_title'],
            'status_form_title' => $copy['status_form_title'],
            'status_note_label' => $copy['status_note_label'],
            'status_note_placeholder' => $copy['status_note_placeholder'],
            'status_submit_label' => $copy['status_submit_label'],
            'stage_label' => $copy['stage_label'],
            'closed_reason_label' => $copy['closed_reason_label'],
            'closed_reason_placeholder' => $copy['closed_reason_placeholder'],
            'provisioning_title' => $copy['provisioning_title'],
            'provisioning_body' => $copy['provisioning_body'],
            'provisioning_submit_label' => $copy['provisioning_submit_label'],
            'checklist_title' => $copy['checklist_title'],
            'checklist_empty_title' => $copy['checklist_empty_title'],
            'checklist_empty_body' => $copy['checklist_empty_body'],
            'checklist_complete_label' => $copy['checklist_complete_label'],
            'followups_title' => $copy['followups_title'],
            'followup_empty_title' => $copy['followup_empty_title'],
            'followup_empty_body' => $copy['followup_empty_body'],
            'followup_form_title' => $copy['followup_form_title'],
            'followup_body_label' => $copy['followup_body_label'],
            'followup_submit_label' => $copy['followup_submit_label'],
            'email_label' => $copy['email_label'],
            'contact_label' => $copy['contact_label'],
            'company_label' => $copy['company_label'],
            'plan_label' => $copy['plan_label'],
            'status_label' => $copy['status_label'],
            'assignee_label' => $copy['assignee_label'],
            'next_followup_label' => $copy['next_followup_label'],
            'source_label' => $copy['source_label'],
            'notes_label' => $copy['notes_label'],
            'latest_label' => $copy['latest_label'],
            'owner_select_label' => $copy['owner_select_label'],
            'owner_empty_label' => $copy['owner_empty_label'],
            ...$shared,
        ]);
    }

    public function documents(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        $this->debug('documents.enter');
        if (!$this->app()->authCheck($request)) {
            $this->debug('documents.redirect-login');
            return $this->redirect($this->urls->login($this->locale($request)), 302);
        }

        $this->debug('documents.auth-ok');
        [$viewer, $workspace, $memberships] = $this->consoleContext($request);
        $this->debug('documents.context-ready');
        $documents = $this->console->documents($workspace);
        $this->debug('documents.data-ready count=' . count($documents));
        $locale = $this->locale($request);
        $copy = $this->locales->consoleDocuments($locale);
        $shared = $this->shared($locale, '/console/knowledge/documents', is_array($workspace) ? $workspace : null, $memberships);
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
        $draftDocuments = array_values(array_filter($documents, static fn (array $item): bool => (string) ($item['status'] ?? '') !== 'published'));
        $publishedDocuments = array_values(array_filter($documents, static fn (array $item): bool => (string) ($item['status'] ?? '') === 'published'));
        $documents = array_map(fn (array $item): array => [
            ...$item,
            'edit_url' => $this->urls->consoleDocumentEditor((string) ($item['id'] ?? ''), $locale),
            'status_badge_class' => $this->contentStatusBadgeClass((string) ($item['status'] ?? 'draft')),
        ], $documents);
        $documents = $this->localizeConsoleDocuments(is_array($workspace) ? $workspace : null, $locale, $documents);

        if (getenv('KS_PLAIN_DOCUMENTS_RESPONSE') !== false && getenv('KS_PLAIN_DOCUMENTS_RESPONSE') !== '') {
            $this->debug('documents.plain-response');
            return $this->text(
                'documents|' . count($documents) . '|' . (is_array($viewer) ? (string) ($viewer['id'] ?? '') : ''),
                200
            );
        }

        if (getenv('KS_RENDERED_STRING_DOCUMENTS_RESPONSE') !== false && getenv('KS_RENDERED_STRING_DOCUMENTS_RESPONSE') !== '') {
            $this->debug('documents.rendered-string-response');
            $html = $this->view()->renderWithLayout('console_documents.html', 'layout.html', [
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
            return $this->renderWithLayout('console_documents.html', 'layout.html', [
                'title' => 'Knowledge Documents',
                'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
                'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
                'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
                'documents' => $documents,
                'page_section' => 'Knowledge Documents',
                'nav_label' => 'documents',
                'footer_note' => 'Document ingest will move from demo arrays to database-backed records next',
            ]);
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
            return $this->view()->renderResponse('console_documents.html', [
                'title' => 'Knowledge Documents',
                'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
                'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
                'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
                'documents' => $documents,
                'page_section' => 'Knowledge Documents',
                'nav_label' => 'documents',
                'footer_note' => 'Document ingest will move from demo arrays to database-backed records next',
            ]);
        }

        if (getenv('KS_RAW_STRING_DOCUMENTS_RESPONSE') !== false && getenv('KS_RAW_STRING_DOCUMENTS_RESPONSE') !== '') {
            $this->debug('documents.raw-string-response');
            return $this->view()->renderWithLayout('console_documents.html', 'layout.html', [
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
        return $this->renderWithLayout('console_documents.html', 'layout.html', [
            'title' => $copy['title'],
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'viewer_role' => is_array($viewer) ? (string) ($viewer['role'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'documents' => $documents,
            'documents_total' => (string) count($documents),
            'draft_documents_total' => (string) count($draftDocuments),
            'published_documents_total' => (string) count($publishedDocuments),
            'has_documents' => $documents !== [] ? '1' : '',
            'show_no_documents' => $documents === [] ? '1' : '',
            'document_edit_label' => $copy['document_edit_label'],
            'write_error' => $this->flash($request, 'console.documents.error'),
            'write_notice' => $this->flash($request, 'console.documents.notice'),
            'document_action' => $this->urls->consoleDocuments($locale),
            'releases_url' => $this->urls->consoleReleases($locale),
            'public_url' => is_array($workspace)
                ? $this->urls->brand((string) ($workspace['slug'] ?? ''), $locale)
                : $this->urls->console($locale),
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

    public function editDocument(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect($this->urls->login($this->locale($request)), 302);
        }

        [$viewer, $workspace, $memberships] = $this->consoleContext($request);
        $locale = $this->locale($request);
        $copy = $this->locales->consoleDocuments($locale);
        $canManageContent = $this->console->canManageContent(is_array($viewer) ? $viewer : null);
        $document = $this->console->documentEditor(is_array($workspace) ? $workspace : null, $this->pathParam($request, 'document'));
        if ($document === null) {
            return $this->redirect($this->urls->consoleDocuments($locale), 302);
        }

        return $this->renderWithLayout('console_document_editor.html', 'layout.html', [
            'title' => $copy['editor_title'],
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'viewer_role' => is_array($viewer) ? (string) ($viewer['role'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'document' => $document->toArray(),
            'document_status_badge_class' => $this->contentStatusBadgeClass($document->status),
            'document_summary_preview_html' => MarkdownPreview::render($document->summary),
            'document_body_preview_html' => MarkdownPreview::render($document->body),
            'save_action' => $this->urls->consoleDocumentEditor($document->id, $locale),
            'back_url' => $this->urls->consoleDocuments($locale),
            'releases_url' => $this->urls->consoleReleases($locale),
            'public_url' => is_array($workspace)
                ? $this->urls->brand((string) ($workspace['slug'] ?? ''), $locale)
                : $this->urls->console($locale),
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
            'back_label' => $copy['back_label'],
            'frontend_style_url' => FrontendAsset::url('knowledge-studio.css'),
            'frontend_module_url' => FrontendAsset::url('knowledge-studio.js'),
            'lit_editor_empty_label' => $copy['lit_editor_empty_label'],
            'lit_editor_active_label' => $copy['lit_editor_active_label'],
            'lit_editor_helper_prefix' => $copy['lit_editor_helper_prefix'],
        ]);
    }

    public function faqs(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect($this->urls->login($this->locale($request)), 302);
        }

        [$viewer, $workspace, $memberships] = $this->consoleContext($request);
        $entries = $this->console->entries($workspace);
        $locale = $this->locale($request);
        $copy = $this->locales->consoleFaqs($locale);
        $shared = $this->shared($locale, '/console/knowledge/faqs', is_array($workspace) ? $workspace : null, $memberships);
        $canManageContent = $this->console->canManageContent(is_array($viewer) ? $viewer : null);
        $prefill = [
            'kind' => $this->queryValue($request, 'prefill_kind') ?: 'faq',
            'title' => $this->queryValue($request, 'prefill_title'),
            'coverage_focus' => $this->queryValue($request, 'prefill_coverage_focus'),
            'body' => $this->queryValue($request, 'prefill_body'),
            'kind_faq_selected' => ($this->queryValue($request, 'prefill_kind') ?: 'faq') === 'faq' ? 'selected' : '',
            'kind_topic_selected' => ($this->queryValue($request, 'prefill_kind') ?: 'faq') === 'topic' ? 'selected' : '',
        ];
        $draftEntries = array_values(array_filter($entries, static fn (array $item): bool => (string) ($item['status'] ?? '') !== 'published'));
        $publishedEntries = array_values(array_filter($entries, static fn (array $item): bool => (string) ($item['status'] ?? '') === 'published'));
        $entries = array_map(fn (array $item): array => [
            ...$item,
            'edit_url' => $this->urls->consoleEntryEditor((string) ($item['id'] ?? ''), $locale),
            'status_badge_class' => $this->contentStatusBadgeClass((string) ($item['status'] ?? 'draft')),
        ], $entries);
        $entries = $this->localizeConsoleEntries(is_array($workspace) ? $workspace : null, $locale, $entries);

        return $this->renderWithLayout('console_faqs.html', 'layout.html', [
            'title' => $copy['title'],
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'viewer_role' => is_array($viewer) ? (string) ($viewer['role'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'entries' => $entries,
            'entries_total' => (string) count($entries),
            'draft_entries_total' => (string) count($draftEntries),
            'published_entries_total' => (string) count($publishedEntries),
            'has_entries' => $entries !== [] ? '1' : '',
            'show_no_entries' => $entries === [] ? '1' : '',
            'entry_edit_label' => $copy['entry_edit_label'],
            'write_error' => $this->flash($request, 'console.entries.error'),
            'write_notice' => $this->flash($request, 'console.entries.notice'),
            'entry_action' => $this->urls->consoleFaqs($locale),
            'releases_url' => $this->urls->consoleReleases($locale),
            'public_url' => is_array($workspace)
                ? $this->urls->brand((string) ($workspace['slug'] ?? ''), $locale)
                : $this->urls->console($locale),
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

    public function editEntry(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect($this->urls->login($this->locale($request)), 302);
        }

        [$viewer, $workspace, $memberships] = $this->consoleContext($request);
        $locale = $this->locale($request);
        $copy = $this->locales->consoleFaqs($locale);
        $canManageContent = $this->console->canManageContent(is_array($viewer) ? $viewer : null);
        $entry = $this->console->entryEditor(is_array($workspace) ? $workspace : null, $this->pathParam($request, 'entry'));
        if ($entry === null) {
            return $this->redirect($this->urls->consoleFaqs($locale), 302);
        }

        return $this->renderWithLayout('console_entry_editor.html', 'layout.html', [
            'title' => $copy['editor_title'],
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'viewer_role' => is_array($viewer) ? (string) ($viewer['role'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'entry' => $entry->toArray(),
            'entry_status_badge_class' => $this->contentStatusBadgeClass($entry->status),
            'entry_body_preview_html' => MarkdownPreview::render($entry->body),
            'save_action' => $this->urls->consoleEntryEditor($entry->id, $locale),
            'back_url' => $this->urls->consoleFaqs($locale),
            'releases_url' => $this->urls->consoleReleases($locale),
            'public_url' => is_array($workspace)
                ? $this->urls->brand((string) ($workspace['slug'] ?? ''), $locale)
                : $this->urls->console($locale),
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
            'back_label' => $copy['back_label'],
            'frontend_style_url' => FrontendAsset::url('knowledge-studio.css'),
            'frontend_module_url' => FrontendAsset::url('knowledge-studio.js'),
            'lit_entry_empty_label' => $copy['lit_entry_empty_label'],
            'lit_entry_active_label' => $copy['lit_entry_active_label'],
            'lit_entry_helper_prefix' => $copy['lit_entry_helper_prefix'],
        ]);
    }

    public function ops(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect($this->urls->login($this->locale($request)), 302);
        }

        [$viewer, $workspace, $memberships] = $this->consoleContext($request);
        $ops = $this->console->ops($workspace);
        $locale = $this->locale($request);
        $jobs = array_map(function (array $item) use ($locale): array {
            $status = strtolower(trim((string) ($item['status'] ?? 'queued')));
            $item['status'] = $status;
            $item['status_badge_class'] = $this->jobStatusBadgeClass($status);
            $item['queue_badge_class'] = $this->jobQueueBadgeClass($status);
            $item['can_retry'] = ($status === 'failed') ? '1' : '';
            $item['retry_url'] = $this->urls->consoleJobRetry((string) ($item['id'] ?? ''), $locale);
            return $item;
        }, $ops['jobs']);
        $jobs = $this->localizeOpsJobs(is_array($workspace) ? $workspace : null, $locale, $jobs);
        usort($jobs, fn (array $left, array $right): int => $this->compareOpsJobs($left, $right));
        $logs = $this->localizeOpsLogs(
            is_array($workspace) ? $workspace : null,
            $locale,
            is_array($ops['logs'] ?? null) ? $ops['logs'] : [],
        );
        $provisioning = array_map(function (array $item): array {
            return [
                ...$item,
                'status_badge_class' => ((string) ($item['status'] ?? '')) === 'done' ? 'ks-badge success' : 'ks-badge warn',
                'lead_label' => trim((string) ($item['lead_company_name'] ?? '')) !== ''
                    ? trim((string) ($item['lead_company_name'] ?? ''))
                    : trim((string) ($item['lead_email'] ?? '')),
                'display_at' => trim((string) ($item['completed_at'] ?? '')) !== ''
                    ? trim((string) ($item['completed_at'] ?? ''))
                    : trim((string) ($item['created_at'] ?? '')),
            ];
        }, is_array($ops['provisioning'] ?? null) ? $ops['provisioning'] : []);
        $provisioning = $this->localizeProvisioningItems(is_array($workspace) ? $workspace : null, $locale, $provisioning);
        $copy = $this->locales->consoleOps($locale);
        $shared = $this->shared($locale, '/console/ops', is_array($workspace) ? $workspace : null, $memberships);
        $canManageOps = $this->console->canManageOps(is_array($viewer) ? $viewer : null);

        return $this->renderWithLayout('console_ops.html', 'layout.html', [
            'title' => $copy['title'],
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'viewer_role' => is_array($viewer) ? (string) ($viewer['role'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'jobs' => $jobs,
            'logs' => $logs,
            'provisioning' => $provisioning,
            'has_jobs' => $jobs !== [] ? '1' : '',
            'show_no_jobs' => $jobs === [] ? '1' : '',
            'has_logs' => $logs !== [] ? '1' : '',
            'show_no_logs' => $logs === [] ? '1' : '',
            'has_provisioning' => $provisioning !== [] ? '1' : '',
            'show_no_provisioning' => $provisioning === [] ? '1' : '',
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
            'provisioning_panel_title' => $copy['provisioning_panel_title'],
            'audit_title' => $copy['audit_title'],
            'col_name' => $copy['col_name'],
            'col_status' => $copy['col_status'],
            'col_queued' => $copy['col_queued'],
            'col_runtime' => $copy['col_runtime'],
            'col_lead' => $copy['col_lead'],
            'retry_label' => $copy['retry_label'],
            'col_when' => $copy['col_when'],
            'col_actor' => $copy['col_actor'],
            'col_action' => $copy['col_action'],
            'col_target' => $copy['col_target'],
            ...$shared,
        ]);
    }

    private function compareOpsJobs(array $left, array $right): int
    {
        $priority = fn (string $status): int => match ($status) {
            'failed' => 0,
            'running', 'reserved', 'pending', 'queued' => 1,
            'completed' => 2,
            default => 3,
        };
        $leftStatus = strtolower(trim((string) ($left['status'] ?? 'queued')));
        $rightStatus = strtolower(trim((string) ($right['status'] ?? 'queued')));
        $leftPriority = $priority($leftStatus);
        $rightPriority = $priority($rightStatus);

        if ($leftPriority !== $rightPriority) {
            return $leftPriority <=> $rightPriority;
        }

        $leftTime = $this->jobSortTimestamp($left);
        $rightTime = $this->jobSortTimestamp($right);
        if ($leftTime !== $rightTime) {
            return $rightTime <=> $leftTime;
        }

        return strcmp((string) ($right['id'] ?? ''), (string) ($left['id'] ?? ''));
    }

    private function jobSortTimestamp(array $item): int
    {
        $candidates = [
            (string) ($item['runtime_at'] ?? ''),
            (string) ($item['queued_at'] ?? ''),
            (string) ($item['updated_at'] ?? ''),
            (string) ($item['created_at'] ?? ''),
        ];

        foreach ($candidates as $candidate) {
            $candidate = trim($candidate);
            if ($candidate === '') {
                continue;
            }
            $timestamp = strtotime($candidate);
            if ($timestamp !== false) {
                return $timestamp;
            }
        }

        return 0;
    }

    private function compareSubscriberLeads(array $left, array $right): int
    {
        $leftPriority = $this->subscriberPriorityScore($left);
        $rightPriority = $this->subscriberPriorityScore($right);
        if ($leftPriority !== $rightPriority) {
            return $rightPriority <=> $leftPriority;
        }

        $leftTime = strtotime((string) ($left['latest_activity_at'] ?? '')) ?: 0;
        $rightTime = strtotime((string) ($right['latest_activity_at'] ?? '')) ?: 0;
        if ($leftTime !== $rightTime) {
            return $rightTime <=> $leftTime;
        }

        return strcmp((string) ($right['email'] ?? ''), (string) ($left['email'] ?? ''));
    }

    private function subscriberPriorityScore(array $row): int
    {
        $score = 0;
        $status = trim((string) ($row['status'] ?? ''));
        $stage = trim((string) ($row['stage'] ?? 'new'));
        $plans = array_map('trim', explode(',', (string) ($row['plans'] ?? '')));
        $activeSubscriptions = (int) ($row['active_subscription_count'] ?? 0);
        $latestActivity = strtotime((string) ($row['latest_activity_at'] ?? '')) ?: 0;
        $nextFollowup = strtotime((string) ($row['next_followup_at'] ?? '')) ?: 0;
        $assignee = trim((string) ($row['assignee_user_id'] ?? ''));

        $score += match ($status) {
            'qualified' => 60,
            'contacted' => 40,
            'active' => 25,
            'inactive' => 0,
            default => 10,
        };
        $score += match ($stage) {
            'proposal' => 26,
            'discovery' => 16,
            'won' => -5,
            'lost' => -12,
            default => 8,
        };

        if (in_array('enterprise', $plans, true)) {
            $score += 30;
        } elseif (in_array('team', $plans, true)) {
            $score += 18;
        } elseif (in_array('starter', $plans, true)) {
            $score += 8;
        }

        $score += min($activeSubscriptions * 5, 15);

        if ($latestActivity > 0) {
            $ageHours = (int) floor((time() - $latestActivity) / 3600);
            if ($ageHours <= 24) {
                $score += 15;
            } elseif ($ageHours <= 72) {
                $score += 8;
            } elseif ($ageHours <= 168) {
                $score += 3;
            }
        }

        if ($assignee === '') {
            $score += 14;
        } else {
            $score += 4;
        }

        if ($nextFollowup > 0) {
            if ($nextFollowup <= time()) {
                $score += 22;
            } else {
                $hoursUntilFollowup = (int) floor(($nextFollowup - time()) / 3600);
                if ($hoursUntilFollowup <= 24) {
                    $score += 10;
                } elseif ($hoursUntilFollowup <= 72) {
                    $score += 5;
                }
            }
        } else {
            $score += 12;
        }

        return $score;
    }

    /**
     * @param array<string, string> $copy
     * @return array{label:string,class:string}
     */
    private function subscriberPriorityMeta(array $row, array $copy): array
    {
        $score = $this->subscriberPriorityScore($row);
        if ($score >= 70) {
            return [
                'label' => (string) ($copy['priority_hot'] ?? 'Hot'),
                'class' => 'ks-badge danger',
            ];
        }
        if ($score >= 35) {
            return [
                'label' => (string) ($copy['priority_warm'] ?? 'Warm'),
                'class' => 'ks-badge warn',
            ];
        }

        return [
            'label' => (string) ($copy['priority_watch'] ?? 'Watch'),
            'class' => 'ks-badge',
        ];
    }

    private function jobStatusBadgeClass(string $status): string
    {
        return match ($status) {
            'failed' => 'ks-badge ks-badge-danger',
            'running', 'reserved' => 'ks-badge ks-badge-info',
            'pending', 'queued' => 'ks-badge ks-badge-warning',
            'completed' => 'ks-badge ks-badge-success',
            default => 'ks-badge',
        };
    }

    private function jobQueueBadgeClass(string $status): string
    {
        return match ($status) {
            'failed' => 'ks-badge ks-badge-soft-danger',
            'running', 'reserved' => 'ks-badge ks-badge-soft-info',
            default => 'ks-badge ks-badge-soft',
        };
    }

    private function contentStatusBadgeClass(string $status): string
    {
        return match (strtolower(trim($status))) {
            'published', 'completed' => 'ks-badge ks-badge-success',
            'draft', 'queued', 'pending' => 'ks-badge ks-badge-warning',
            'failed' => 'ks-badge ks-badge-danger',
            default => 'ks-badge ks-badge-soft',
        };
    }

    private function releaseCheckBadgeClass(string $status): string
    {
        return match (strtolower(trim($status))) {
            'pass', 'ok', 'ready' => 'ks-badge ks-badge-success',
            'warn', 'warning', 'pending' => 'ks-badge ks-badge-warning',
            'fail', 'failed', 'error' => 'ks-badge ks-badge-danger',
            default => 'ks-badge ks-badge-soft',
        };
    }

    public function releases(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect($this->urls->login($this->locale($request)), 302);
        }

        [$viewer, $workspace, $memberships] = $this->consoleContext($request);
        $releases = $this->console->releases($workspace);
        $snapshot = $this->console->releaseSnapshot($workspace);
        $locale = $this->locale($request);
        $copy = $this->locales->consoleReleases($locale);
        $shared = $this->shared($locale, '/console/releases', is_array($workspace) ? $workspace : null, $memberships);
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
        $compare['current']['version'] = $this->displayReleaseVersion((string) ($compare['current']['version'] ?? 'v0.0'), $locale);
        $compare['next']['version'] = $this->displayReleaseVersion((string) ($compare['next']['version'] ?? 'next'), $locale);
        $compare['current']['notes'] = trim((string) ($compare['current']['notes'] ?? '')) !== ''
            ? $this->localizeConsoleReleaseNotes(is_array($workspace) ? $workspace : null, $locale, (string) $compare['current']['notes'])
            : $copy['version_compare_empty_notes'];
        $compare['next']['notes'] = $this->localizeConsoleReleaseNotes(is_array($workspace) ? $workspace : null, $locale, (string) $copy['version_compare_next_notes']);
        $snapshot['version_compare'] = $compare;
        $snapshot['document_candidates'] = array_map(function (array $item) use ($locale): array {
            return [
                ...$item,
                'edit_url' => $this->urls->consoleDocumentEditor((string) ($item['id'] ?? ''), $locale),
                'status_badge_class' => $this->contentStatusBadgeClass((string) ($item['status'] ?? 'draft')),
            ];
        }, is_array($snapshot['document_candidates'] ?? null) ? $snapshot['document_candidates'] : []);
        $snapshot['document_candidates'] = $this->localizeConsoleDocuments(
            is_array($workspace) ? $workspace : null,
            $locale,
            is_array($snapshot['document_candidates'] ?? null) ? $snapshot['document_candidates'] : [],
        );
        $snapshot['entry_candidates'] = array_map(function (array $item) use ($locale): array {
            return [
                ...$item,
                'edit_url' => $this->urls->consoleEntryEditor((string) ($item['id'] ?? ''), $locale),
                'status_badge_class' => $this->contentStatusBadgeClass((string) ($item['status'] ?? 'draft')),
            ];
        }, is_array($snapshot['entry_candidates'] ?? null) ? $snapshot['entry_candidates'] : []);
        $snapshot['entry_candidates'] = $this->localizeConsoleEntries(
            is_array($workspace) ? $workspace : null,
            $locale,
            is_array($snapshot['entry_candidates'] ?? null) ? $snapshot['entry_candidates'] : [],
        );
        $snapshot['draft_preview']['documents'] = array_map(function (array $item) use ($locale): array {
            return [
                ...$item,
                'list_url' => $this->urls->consoleDocuments($locale),
                'detail_url' => $this->urls->consoleDocumentEditor((string) ($item['id'] ?? ''), $locale),
            ];
        }, is_array($snapshot['draft_preview']['documents'] ?? null) ? $snapshot['draft_preview']['documents'] : []);
        $snapshot['draft_preview']['documents'] = $this->localizeConsoleDocuments(
            is_array($workspace) ? $workspace : null,
            $locale,
            is_array($snapshot['draft_preview']['documents'] ?? null) ? $snapshot['draft_preview']['documents'] : [],
        );
        $snapshot['draft_preview']['entries'] = array_map(function (array $item) use ($locale): array {
            return [
                ...$item,
                'list_url' => $this->urls->consoleFaqs($locale),
                'detail_url' => $this->urls->consoleEntryEditor((string) ($item['id'] ?? ''), $locale),
            ];
        }, is_array($snapshot['draft_preview']['entries'] ?? null) ? $snapshot['draft_preview']['entries'] : []);
        $snapshot['draft_preview']['entries'] = $this->localizeConsoleEntries(
            is_array($workspace) ? $workspace : null,
            $locale,
            is_array($snapshot['draft_preview']['entries'] ?? null) ? $snapshot['draft_preview']['entries'] : [],
        );
        $snapshot['public_preview']['documents'] = array_map(function (array $item) use ($locale, $workspaceSlug): array {
            return [
                ...$item,
                'detail_url' => $workspaceSlug !== ''
                    ? $this->urls->brandDocument($workspaceSlug, (string) ($item['id'] ?? ''), $locale)
                    : $this->urls->console($locale),
            ];
        }, is_array($snapshot['public_preview']['documents'] ?? null) ? $snapshot['public_preview']['documents'] : []);
        $snapshot['public_preview']['documents'] = $this->localizeConsoleDocuments(
            is_array($workspace) ? $workspace : null,
            $locale,
            is_array($snapshot['public_preview']['documents'] ?? null) ? $snapshot['public_preview']['documents'] : [],
        );
        $snapshot['public_preview']['entries'] = array_map(function (array $item) use ($locale, $workspaceSlug): array {
            return [
                ...$item,
                'detail_url' => $workspaceSlug !== ''
                    ? $this->urls->brandEntry($workspaceSlug, (string) ($item['id'] ?? ''), $locale)
                    : $this->urls->console($locale),
            ];
        }, is_array($snapshot['public_preview']['entries'] ?? null) ? $snapshot['public_preview']['entries'] : []);
        $snapshot['public_preview']['entries'] = $this->localizeConsoleEntries(
            is_array($workspace) ? $workspace : null,
            $locale,
            is_array($snapshot['public_preview']['entries'] ?? null) ? $snapshot['public_preview']['entries'] : [],
        );
        $snapshot['release_checks'] = array_map(function (array $item): array {
            return [
                ...$item,
                'status_badge_class' => $this->releaseCheckBadgeClass((string) ($item['status'] ?? 'pending')),
            ];
        }, is_array($snapshot['release_checks'] ?? null) ? $snapshot['release_checks'] : []);
        $snapshot['gap_signals'] = array_map(function (array $item) use ($locale, $workspaceSlug): array {
            $question = trim((string) ($item['title'] ?? ''));
            return [
                ...$item,
                'reason_value' => $question !== '' ? $question : trim((string) ($item['signal'] ?? '')),
                'assistant_url' => $workspaceSlug !== ''
                    ? $this->urls->validationWithQuery($workspaceSlug, $locale, ['q' => $question])
                    : $this->urls->console($locale),
                'entry_url' => $this->urls->consoleFaqsWithQuery($locale, [
                    'prefill_kind' => 'faq',
                    'prefill_title' => $question !== '' ? $question : 'New FAQ from release gap',
                    'prefill_coverage_focus' => $question !== '' ? $question : 'Release gap follow-up',
                    'prefill_body' => $question !== ''
                        ? "## User question\n\n{$question}\n\n## Working answer\n\n- Add the canonical answer here.\n"
                        : "## User question\n\n- Capture the missing question here.\n\n## Working answer\n\n- Add the canonical answer here.\n",
                ]),
            ];
        }, is_array($snapshot['gap_signals'] ?? null) ? $snapshot['gap_signals'] : []);
        $releases = array_map(function (array $item) use ($locale, $workspaceSlug, $copy, $workspace): array {
            $version = trim((string) ($item['version'] ?? ''));
            $status = strtolower(trim((string) ($item['status'] ?? 'draft')));
            return [
                ...$item,
                'display_version' => $this->displayReleaseVersion($version, $locale),
                'notes' => $this->localizeConsoleReleaseNotes(is_array($workspace) ? $workspace : null, $locale, (string) ($item['notes'] ?? '')),
                'status' => $status,
                'status_badge_class' => $this->contentStatusBadgeClass($status),
                'brand_url' => $workspaceSlug !== ''
                    ? $this->urls->brandWithQuery($workspaceSlug, $locale, ['release' => $version])
                    : $this->urls->console($locale),
                'assistant_url' => $workspaceSlug !== ''
                    ? $this->urls->validationWithQuery($workspaceSlug, $locale, ['release' => $version])
                    : $this->urls->console($locale),
                'brand_cta' => $copy['history_brand_cta'],
                'assistant_cta' => $copy['history_assistant_cta'],
            ];
        }, $releases);

        return $this->renderWithLayout('console_releases.html', 'layout.html', [
            'title' => $copy['title'],
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'viewer_role' => is_array($viewer) ? (string) ($viewer['role'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'releases' => $releases,
            'snapshot' => $snapshot,
            'has_releases' => $releases !== [] ? '1' : '',
            'show_no_releases' => $releases === [] ? '1' : '',
            'has_document_candidates' => ((is_array($snapshot['document_candidates'] ?? null) ? $snapshot['document_candidates'] : []) !== []) ? '1' : '',
            'show_no_document_candidates' => ((is_array($snapshot['document_candidates'] ?? null) ? $snapshot['document_candidates'] : []) === []) ? '1' : '',
            'has_entry_candidates' => ((is_array($snapshot['entry_candidates'] ?? null) ? $snapshot['entry_candidates'] : []) !== []) ? '1' : '',
            'show_no_entry_candidates' => ((is_array($snapshot['entry_candidates'] ?? null) ? $snapshot['entry_candidates'] : []) === []) ? '1' : '',
            'has_gap_signals' => ((is_array($snapshot['gap_signals'] ?? null) ? $snapshot['gap_signals'] : []) !== []) ? '1' : '',
            'show_no_gap_signals' => ((is_array($snapshot['gap_signals'] ?? null) ? $snapshot['gap_signals'] : []) === []) ? '1' : '',
            'snapshot_ready' => (string) ($snapshot['ready'] ?? ''),
            'snapshot_published_documents' => (string) ($snapshot['published_documents'] ?? '0'),
            'snapshot_published_entries' => (string) ($snapshot['published_entries'] ?? '0'),
            'snapshot_draft_documents' => (string) ($snapshot['draft_documents'] ?? '0'),
            'snapshot_draft_entries' => (string) ($snapshot['draft_entries'] ?? '0'),
            'snapshot_latest_release_version' => $this->displayReleaseVersion((string) (($snapshot['latest_release']['version'] ?? 'v0.0')), $locale),
            'snapshot_latest_release_status' => (string) (($snapshot['latest_release']['status'] ?? 'draft')),
            'snapshot_latest_release_status_badge_class' => $this->contentStatusBadgeClass((string) (($snapshot['latest_release']['status'] ?? 'draft'))),
            'snapshot_readiness_summary' => (string) ($snapshot['readiness_summary'] ?? ''),
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
            'release_reason_title' => $copy['release_reason_title'],
            'release_reason_body' => $copy['release_reason_body'],
            'release_reason_hint' => $copy['release_reason_hint'],
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
            'draft_preview_detail_cta' => $copy['draft_preview_detail_cta'],
            'current_public_detail_cta' => $copy['current_public_detail_cta'],
            'brand_page_cta' => $copy['brand_page_cta'],
            'assistant_page_cta' => $copy['assistant_page_cta'],
            'brand_page_url' => is_array($workspace)
                ? $this->urls->brand((string) ($workspace['slug'] ?? ''), $locale)
                : $this->urls->console($locale),
            'assistant_page_url' => is_array($workspace)
                ? $this->urls->validation((string) ($workspace['slug'] ?? ''), $locale)
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
            'recommended_badge' => $copy['recommended_badge'],
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

    private function displayReleaseVersion(string $version, string $locale = 'zh-CN'): string
    {
        $version = trim($version);
        if ($version === '') {
            return '';
        }

        return match (true) {
            $version === 'v0.1' => '2026.Q2',
            $version === 'next' => in_array($locale, ['zh', 'zh-CN', 'zh-Hans'], true) ? '下一发布版本' : 'Next Release',
            str_starts_with($version, 'onboarding-') => in_array($locale, ['zh', 'zh-CN', 'zh-Hans'], true)
                ? '客户开通草稿'
                : 'Customer Onboarding Draft',
            default => $version,
        };
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<int, array<string, mixed>> $documents
     * @return array<int, array<string, mixed>>
     */
    private function localizeConsoleDocuments(?array $workspace, string $locale, array $documents): array
    {
        if (!in_array($locale, ['zh', 'zh-CN', 'zh-Hans'], true) || !$this->isAcmeWorkspace($workspace)) {
            return $documents;
        }

        return array_map(function (array $item): array {
            $item['title'] = $this->localizeGeneratedTitle((string) ($item['title'] ?? ''));
            $item['coverage_focus'] = $this->localizeGeneratedFocus((string) ($item['coverage_focus'] ?? ''));
            $item['summary'] = $this->localizeGeneratedSummary((string) ($item['summary'] ?? ''));
            if (array_key_exists('preview_summary', $item)) {
                $item['preview_summary'] = $this->localizeGeneratedSummary((string) ($item['preview_summary'] ?? ''));
            }

            return $item;
        }, $documents);
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<int, array<string, mixed>> $entries
     * @return array<int, array<string, mixed>>
     */
    private function localizeConsoleEntries(?array $workspace, string $locale, array $entries): array
    {
        if (!in_array($locale, ['zh', 'zh-CN', 'zh-Hans'], true) || !$this->isAcmeWorkspace($workspace)) {
            return $entries;
        }

        return array_map(function (array $item): array {
            $item['title'] = $this->localizeGeneratedTitle((string) ($item['title'] ?? ''));
            $item['coverage_focus'] = $this->localizeGeneratedFocus((string) ($item['coverage_focus'] ?? ''));
            if (array_key_exists('preview_summary', $item)) {
                $item['preview_summary'] = $this->localizeGeneratedSummary((string) ($item['preview_summary'] ?? ''));
            }

            return $item;
        }, $entries);
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<int, array<string, mixed>> $followups
     * @return array<int, array<string, mixed>>
     */
    private function localizeSubscriberFollowups(?array $workspace, string $locale, array $followups): array
    {
        if (!in_array($locale, ['zh', 'zh-CN', 'zh-Hans'], true) || !$this->isAcmeWorkspace($workspace)) {
            return $followups;
        }

        return array_map(function (array $item): array {
            $item['body'] = $this->localizeConsoleReleaseNotes($workspace, $locale, (string) ($item['body'] ?? ''));
            return $item;
        }, $followups);
    }

    /**
     * @param array<string, mixed>|null $workspace
     */
    private function localizeConsoleReleaseNotes(?array $workspace, string $locale, string $notes): string
    {
        $notes = trim($notes);
        if ($notes === '' || !in_array($locale, ['zh', 'zh-CN', 'zh-Hans'], true) || !$this->isAcmeWorkspace($workspace)) {
            return $notes;
        }

        if (preg_match('/^Enterprise onboarding release scaffold for (.+), including security review, owner onboarding, and initial executive-facing launch assets\.$/', $notes, $matches) === 1) {
            return '为 ' . trim((string) ($matches[1] ?? '该客户')) . ' 准备的企业版开通发布草稿，覆盖安全审查、owner 开通与首批面向管理层的启动资产。';
        }
        if (preg_match('/^Team onboarding release scaffold for (.+), focused on workspace setup, editor onboarding, and initial shared release content\.$/', $notes, $matches) === 1) {
            return '为 ' . trim((string) ($matches[1] ?? '该客户')) . ' 准备的团队版开通发布草稿，聚焦 workspace 设置、编辑协作开通与首批共享发布内容。';
        }
        if (preg_match('/^Starter onboarding release scaffold for (.+)$/', $notes, $matches) === 1) {
            return '为 ' . trim((string) ($matches[1] ?? '该客户')) . ' 准备的 Starter 开通发布草稿。';
        }

        return match ($notes) {
            'Public knowledge release covering 3 docs / 3 entries.' => '当前公开知识版本覆盖 3 份文档与 3 条知识条目。',
            default => $notes,
        };
    }

    private function localizeGeneratedTitle(string $title): string
    {
        $title = trim($title);
        if ($title === '') {
            return '';
        }

        if (preg_match('/^Enterprise Launch Plan for (.+)$/', $title, $matches) === 1) {
            return trim((string) ($matches[1] ?? '该客户')) . ' 企业版开通方案';
        }
        if (preg_match('/^Enterprise FAQ for (.+)$/', $title, $matches) === 1) {
            return trim((string) ($matches[1] ?? '该客户')) . ' 企业版 FAQ';
        }
        if (preg_match('/^Team Launch Plan for (.+)$/', $title, $matches) === 1) {
            return trim((string) ($matches[1] ?? '该客户')) . ' 团队版开通方案';
        }
        if (preg_match('/^Team FAQ for (.+)$/', $title, $matches) === 1) {
            return trim((string) ($matches[1] ?? '该客户')) . ' 团队版 FAQ';
        }
        if (preg_match('/^Starter Launch Plan for (.+)$/', $title, $matches) === 1) {
            return trim((string) ($matches[1] ?? '该客户')) . ' Starter 开通方案';
        }
        if (preg_match('/^Starter FAQ for (.+)$/', $title, $matches) === 1) {
            return trim((string) ($matches[1] ?? '该客户')) . ' Starter FAQ';
        }

        return match ($title) {
            'Settlement exception triage' => '结算异常分诊',
            'Support-to-Finance Handoff Guide' => '支持到财务交接指南',
            default => $title,
        };
    }

    private function localizeGeneratedFocus(string $focus): string
    {
        return match (trim($focus)) {
            'Enterprise onboarding rollout' => '企业版开通推进',
            'Enterprise onboarding FAQ' => '企业版开通 FAQ',
            'Team onboarding rollout' => '团队版开通推进',
            'Team onboarding FAQ' => '团队版开通 FAQ',
            'Customer onboarding rollout' => '客户开通推进',
            'Customer onboarding FAQ' => '客户开通 FAQ',
            default => trim($focus),
        };
    }

    private function localizeGeneratedSummary(string $summary): string
    {
        $summary = trim($summary);

        return match ($summary) {
            'Coordinate enterprise launch owners, security review, SSO milestones, and customer success checkpoints.' => '协调企业版启动 owner、安全审查、SSO 里程碑与客户成功检查点。',
            'Align workspace setup, editor onboarding, and first shared knowledge release for the team plan.' => '对齐团队版 workspace 设置、编辑协作开通与首批共享知识发布。',
            'Prepare the starter launch plan for workspace setup, owner handoff, and the first lightweight knowledge release.' => '准备 Starter 方案的 workspace 设置、owner 交接与第一版轻量知识发布。',
            default => $summary,
        };
    }

    /**
     * @param array<string, mixed>|null $workspace
     */
    private function isAcmeWorkspace(?array $workspace): bool
    {
        return is_array($workspace) && trim((string) ($workspace['slug'] ?? '')) === 'acme-research';
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<int, array<string, mixed>> $logs
     * @return array<int, array<string, mixed>>
     */
    private function localizeOpsLogs(?array $workspace, string $locale, array $logs): array
    {
        if (!in_array($locale, ['zh', 'zh-CN', 'zh-Hans'], true)) {
            return $logs;
        }

        $slug = is_array($workspace) ? trim((string) ($workspace['slug'] ?? '')) : '';
        if ($slug !== 'acme-research') {
            return $logs;
        }

        return array_map(function (array $item): array {
            $target = trim((string) ($item['target_preview'] ?? ''));
            if ($target === '') {
                return $item;
            }

            $item['target_preview'] = match ($target) {
                'Acme Operations Brief 2026.Q2' => 'Acme 运营简报 2026.Q2',
                'Settlement exception triage' => '结算异常分诊',
                'Support-to-Finance Handoff Guide' => '支持到财务交接指南',
                default => $target,
            };

            return $item;
        }, $logs);
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<int, array<string, mixed>> $jobs
     * @return array<int, array<string, mixed>>
     */
    private function localizeOpsJobs(?array $workspace, string $locale, array $jobs): array
    {
        if (!in_array($locale, ['zh', 'zh-CN', 'zh-Hans'], true)) {
            return $jobs;
        }

        $slug = is_array($workspace) ? trim((string) ($workspace['slug'] ?? '')) : '';
        if ($slug !== 'acme-research') {
            return $jobs;
        }

        return array_map(function (array $item): array {
            $name = trim((string) ($item['name'] ?? ''));
            if ($name === '') {
                return $item;
            }

            $item['name'] = match ($name) {
                'Index Reimbursement Operations Handbook' => '索引报销运营手册',
                'Parse Settlement Exception Playbook' => '解析结算异常处置手册',
                'Sync public validation cache' => '同步公开验证缓存',
                default => $name,
            };

            return $item;
        }, $jobs);
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<int, array<string, mixed>> $items
     * @return array<int, array<string, mixed>>
     */
    private function localizeProvisioningItems(?array $workspace, string $locale, array $items): array
    {
        if (!in_array($locale, ['zh', 'zh-CN', 'zh-Hans'], true)) {
            return $items;
        }

        $slug = is_array($workspace) ? trim((string) ($workspace['slug'] ?? '')) : '';
        if ($slug !== 'acme-research') {
            return $items;
        }

        return array_map(function (array $item): array {
            $label = trim((string) ($item['label'] ?? ''));
            if ($label === '') {
                return $item;
            }

            $item['label'] = match ($label) {
                'Create workspace shell and plan settings' => '创建 workspace 壳与方案设置',
                'Invite first customer owner and rotate access' => '邀请首位客户 owner 并轮换访问凭据',
                'Prepare initial brand page, release, and starter knowledge set' => '准备初始品牌页、发布版本与 starter 知识集',
                default => $label,
            };

            return $item;
        }, $items);
    }

    public function storeDocument(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
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

    public function storeEntry(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
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

    public function storeMember(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
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

    public function updateMemberRole(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $memberId = $this->pathParam($request, 'member');
        $result = $this->console->updateMemberRole(
            is_array($workspace) ? $workspace : null,
            is_array($viewer) ? $viewer : null,
            $memberId,
            $this->requestData($request),
        );

        return $this->flashRedirect(
            $request,
            $this->urls->consoleMembers($this->locale($request)),
            $result['ok'] ? 'console.members.notice' : 'console.members.error',
            $result['message'],
        );
    }

    public function removeMember(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $memberId = $this->pathParam($request, 'member');
        $result = $this->console->removeMember(
            is_array($workspace) ? $workspace : null,
            is_array($viewer) ? $viewer : null,
            $memberId,
        );

        return $this->flashRedirect(
            $request,
            $this->urls->consoleMembers($this->locale($request)),
            $result['ok'] ? 'console.members.notice' : 'console.members.error',
            $result['message'],
        );
    }

    public function switchWorkspace(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        [$viewer, $workspace, $memberships] = $this->consoleContext($request);
        $locale = $this->locale($request);
        $targetSlug = trim((string) ($this->requestData($request)['workspace_slug'] ?? ''));
        $session = $this->app()->session($request);

        $allowed = false;
        foreach ($memberships as $membership) {
            if (trim((string) ($membership['workspace_slug'] ?? '')) === $targetSlug) {
                $allowed = true;
                break;
            }
        }

        if (!$allowed || $targetSlug === '') {
            $session->flash('console.workspace.error', 'Unable to switch workspace for this account.');
        } else {
            $session->set('studio.workspace_slug', $targetSlug);
            $this->console->recordWorkspaceSwitch(
                is_array($viewer) ? $viewer : null,
                $memberships,
                $targetSlug,
            );
            $session->flash('console.workspace.notice', 'Workspace switched.');
        }

        $response = $this->redirect($this->urls->console($locale), 302);
        $session->commit($response);
        return $response;
    }

    public function updatePassword(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $result = $this->console->changePassword(
            is_array($workspace) ? $workspace : null,
            is_array($viewer) ? $viewer : null,
            $this->requestData($request),
        );
        $locale = $this->locale($request);

        return $this->flashRedirect(
            $request,
            $this->urls->consoleAccount($locale),
            $result['ok'] ? 'console.account.notice' : 'console.account.error',
            $result['ok']
                ? $this->locales->consoleAccount($locale)['reset_complete_notice']
                : $result['message'],
        );
    }

    public function updateSubscriberStatus(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $subscriberId = $this->pathParam($request, 'subscriber');
        $result = $this->console->updateSubscriberStatus(
            is_array($workspace) ? $workspace : null,
            is_array($viewer) ? $viewer : null,
            $subscriberId,
            $this->requestData($request),
        );

        $locale = $this->locale($request);
        $redirect = trim((string) ($this->requestData($request)['redirect'] ?? ''));
        $target = $redirect === 'detail'
            ? $this->urls->consoleSubscriberDetail($subscriberId, $locale)
            : $this->urls->consoleSubscribers($locale);

        if (($result['ok'] ?? false) !== true && $redirect !== 'detail') {
            $query = http_build_query([
                'subscriber' => $subscriberId,
                'status_value' => trim((string) ($this->requestData($request)['status'] ?? '')),
                'status_note' => trim((string) ($this->requestData($request)['note'] ?? '')),
            ]);
            if ($query !== '') {
                $target .= (str_contains($target, '?') ? '&' : '?') . $query;
            }
        }

        return $this->flashRedirect(
            $request,
            $target,
            $result['ok'] ? 'console.subscribers.notice' : 'console.subscribers.error',
            $result['message'],
        );
    }

    public function queueSubscriberProvisioning(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $subscriberId = $this->pathParam($request, 'subscriber');
        $result = $this->console->queueSubscriberProvisioning(
            is_array($workspace) ? $workspace : null,
            is_array($viewer) ? $viewer : null,
            $subscriberId,
        );

        return $this->flashRedirect(
            $request,
            $this->urls->consoleSubscriberDetail($subscriberId, $this->locale($request)),
            $result['ok'] ? 'console.subscriber_detail.notice' : 'console.subscriber_detail.error',
            $result['message'],
        );
    }

    public function completeSubscriberProvisioningItem(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $subscriberId = $this->pathParam($request, 'subscriber');
        $itemId = $this->pathParam($request, 'item');
        $result = $this->console->completeSubscriberProvisioningItem(
            is_array($workspace) ? $workspace : null,
            is_array($viewer) ? $viewer : null,
            $subscriberId,
            $itemId,
        );

        return $this->flashRedirect(
            $request,
            $this->urls->consoleSubscriberDetail($subscriberId, $this->locale($request)),
            $result['ok'] ? 'console.subscriber_detail.notice' : 'console.subscriber_detail.error',
            $result['message'],
        );
    }

    public function storeSubscriberFollowup(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $subscriberId = $this->pathParam($request, 'subscriber');
        $result = $this->console->addSubscriberFollowup(
            is_array($workspace) ? $workspace : null,
            is_array($viewer) ? $viewer : null,
            $subscriberId,
            $this->requestData($request),
        );

        return $this->flashRedirect(
            $request,
            $this->urls->consoleSubscriberDetail($subscriberId, $this->locale($request)),
            $result['ok'] ? 'console.subscriber_detail.notice' : 'console.subscriber_detail.error',
            $result['message'],
        );
    }

    public function updateDocument(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
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

    public function publishDocument(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        // Legacy compat entry: old links may still post here, but release center is the only real publish gate.
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        $locale = $this->locale($request);
        return $this->flashRedirect(
            $request,
            $this->urls->consoleReleases($locale),
            'console.releases.notice',
            $locale === 'en'
                ? 'Direct publishing has moved to the release center. Review the draft there and publish as part of a release.'
                : '直接发布已统一收口到发布中心。请在发布中心确认这份草稿，并作为 release 的一部分上线。',
        );
    }

    public function updateEntry(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
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

    public function publishEntry(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        // Legacy compat entry: old links may still post here, but release center is the only real publish gate.
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        $locale = $this->locale($request);
        return $this->flashRedirect(
            $request,
            $this->urls->consoleReleases($locale),
            'console.releases.notice',
            $locale === 'en'
                ? 'Direct publishing has moved to the release center. Review the draft there and publish as part of a release.'
                : '直接发布已统一收口到发布中心。请在发布中心确认这份草稿，并作为 release 的一部分上线。',
        );
    }

    public function storeJob(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
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

    public function retryJob(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $jobId = $this->pathParam($request, 'job');
        $result = $this->console->retryJob(
            is_array($workspace) ? $workspace : null,
            is_array($viewer) ? $viewer : null,
            $jobId,
        );

        return $this->flashRedirect(
            $request,
            $this->urls->consoleOps($this->locale($request)),
            $result['ok'] ? 'console.ops.notice' : 'console.ops.error',
            $result['message'],
        );
    }

    public function storeRelease(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
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
        $viewer = is_array($resolved['viewer'] ?? null) ? $resolved['viewer'] : $viewer;
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
    private function shared(string $locale, string $path, ?array $workspace = null, array $memberships = []): array
    {
        $shared = $this->locales->shared($locale, $path);
        $slug = is_array($workspace) ? trim((string) ($workspace['slug'] ?? '')) : '';
        $publicUrl = $slug !== '' ? $this->urls->brand($slug, $locale) : $this->urls->console($locale);
        $assistantPreviewUrl = $slug !== '' ? $this->urls->validation($slug, $locale) : $this->urls->console($locale);

        $active = 'workbench';
        if (str_starts_with($path, '/console/knowledge/')) {
            $active = 'content';
        } elseif (str_starts_with($path, '/console/releases')) {
            $active = 'publish';
        } elseif (
            str_starts_with($path, '/console/members')
            || str_starts_with($path, '/console/subscribers')
            || str_starts_with($path, '/console/account')
            || str_starts_with($path, '/console/ops')
        ) {
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
            'workspace_switch_action' => $this->urls->consoleWorkspaceSwitch($locale),
            'workspace_switch_label' => $shared['workspace_switch_label'],
            'workspace_switch_submit' => $shared['workspace_switch_submit'],
            'workspace_switch_options' => $this->workspaceSwitchOptions($memberships, $slug),
            'workspace_switch_notice' => '',
        ];
    }

    /**
     * @param array<int, array<string, string>> $memberships
     * @return array<int, array<string, string>>
     */
    private function workspaceSwitchOptions(array $memberships, string $currentSlug): array
    {
        if (count($memberships) < 2) {
            return [];
        }

        return array_values(array_map(static function (array $membership) use ($currentSlug): array {
            $slug = trim((string) ($membership['workspace_slug'] ?? ''));
            $name = trim((string) ($membership['workspace_name'] ?? $slug));
            $role = trim((string) ($membership['role'] ?? ''));
            return [
                'value' => $slug,
                'label' => trim($name . ($role !== '' ? ' / ' . $role : '')),
                'selected_attr' => $slug === $currentSlug ? 'selected' : '',
            ];
        }, $memberships));
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
                    'label' => $shared['subnav_subscribers_label'],
                    'url' => $this->urls->consoleSubscribers($locale),
                    'class' => str_starts_with($path, '/console/subscribers') ? 'active' : '',
                ],
                [
                    'label' => $shared['subnav_account_label'],
                    'url' => $this->urls->consoleAccount($locale),
                    'class' => str_starts_with($path, '/console/account') ? 'active' : '',
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

    private function flashRedirect(\VSlim\Psr7\ServerRequest $request, string $location, string $key, string $message): \Psr\Http\Message\ResponseInterface
    {
        $session = $this->app()->session($request);
        if ($message !== '') {
            $session->flash($key, $message);
        }
        $response = $this->redirect($location, 302);
        $session->commit($response);
        return $response;
    }
}
