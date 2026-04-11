<?php
declare(strict_types=1);

namespace App\Http\Controllers;

use App\Services\ConsoleWorkspaceService;
use App\Support\DemoCatalog;

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
    )
    {
        parent::__construct($app);
    }

    public function index(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        $this->debug('index.enter');
        if (!$this->app()->authCheck($request)) {
            $this->debug('index.redirect-login');
            return $this->redirect('/login', 302);
        }

        [$viewer, $workspace, $memberships] = $this->consoleContext($request);
        $this->debug('index.context-ready');
        $dashboard = $this->console->dashboard($workspace);
        $this->debug('index.dashboard-ready');
        $metrics = $dashboard['metrics'];
        $documents = $dashboard['documents'];
        $entries = $dashboard['entries'];
        $jobs = $dashboard['jobs'];

        $this->debug('index.render');
        return $this->render_with_layout('console.html', 'layout.html', [
            'title' => 'Knowledge Studio Console',
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'viewer_role' => is_array($viewer) ? (string) ($viewer['role'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'workspace_brand' => is_array($workspace) ? (string) ($workspace['brand_name'] ?? '') : '',
            'workspace_plan' => is_array($workspace) ? (string) ($workspace['plan'] ?? '') : '',
            'workspace_members' => is_array($workspace) ? (string) ($workspace['members'] ?? '') : '0',
            'member_count' => count($memberships),
            'memberships' => $memberships,
            'documents_total' => (string) ($metrics['documents'] ?? '0'),
            'entries_total' => (string) ($metrics['entries'] ?? '0'),
            'jobs_total' => (string) ($metrics['jobs'] ?? '0'),
            'published_documents' => (string) ($metrics['published_documents'] ?? '0'),
            'assistant_status' => (string) ($metrics['assistant_status'] ?? 'draft'),
            'documents_url' => '/console/knowledge/documents',
            'faqs_url' => '/console/knowledge/faqs',
            'ops_url' => '/console/ops',
            'documents' => array_slice($documents, 0, 2),
            'entries' => array_slice($entries, 0, 2),
            'jobs' => array_slice($jobs, 0, 2),
            'public_url' => is_array($workspace)
                ? '/brand/' . (string) ($workspace['slug'] ?? '')
                : '',
            'page_section' => 'Workspace Console',
            'nav_label' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : 'console',
            'footer_note' => 'Next milestone wires real documents, entries, jobs, and audit logs',
        ]);
    }

    public function documents(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        $this->debug('documents.enter');
        if (!$this->app()->authCheck($request)) {
            $this->debug('documents.redirect-login');
            return $this->redirect('/login', 302);
        }

        $this->debug('documents.auth-ok');
        [$viewer, $workspace] = $this->consoleContext($request);
        $this->debug('documents.context-ready');
        $documents = $this->console->documents($workspace);
        $this->debug('documents.data-ready count=' . count($documents));

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

    public function faqs(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $entries = $this->console->entries($workspace);

        return $this->render_with_layout('console_faqs.html', 'layout.html', [
            'title' => 'Knowledge Entries',
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'entries' => $entries,
            'write_error' => $this->flash($request, 'console.entries.error'),
            'write_notice' => $this->flash($request, 'console.entries.notice'),
            'page_section' => 'FAQ and Topics',
            'nav_label' => 'entries',
            'footer_note' => 'Published vs draft entry state will later be driven by releases',
        ]);
    }

    public function ops(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if (!$this->app()->authCheck($request)) {
            return $this->redirect('/login', 302);
        }

        [$viewer, $workspace] = $this->consoleContext($request);
        $ops = $this->console->ops($workspace);
        $jobs = $ops['jobs'];
        $logs = $ops['logs'];

        return $this->render_with_layout('console_ops.html', 'layout.html', [
            'title' => 'Ops and Audit',
            'viewer_name' => is_array($viewer) ? (string) ($viewer['name'] ?? '') : '',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'jobs' => $jobs,
            'logs' => $logs,
            'write_error' => $this->flash($request, 'console.ops.error'),
            'write_notice' => $this->flash($request, 'console.ops.notice'),
            'page_section' => 'Ops and Audit',
            'nav_label' => 'ops',
            'footer_note' => 'Realtime job state and tool call logs will attach here next',
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
            '/console/knowledge/documents',
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
            '/console/knowledge/faqs',
            $result['ok'] ? 'console.entries.notice' : 'console.entries.error',
            $result['message'],
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
            '/console/ops',
            $result['ok'] ? 'console.ops.notice' : 'console.ops.error',
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
