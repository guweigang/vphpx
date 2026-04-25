<?php
declare(strict_types=1);

namespace App\Http\Controllers;

use App\Repositories\WorkspaceRepository;
use App\Support\DemoCatalog;
use App\Support\LocaleCatalog;
use App\Support\LocalizedUrlBuilder;

final class AuthController extends \VSlim\Controller
{
    public function __construct(
        \VSlim\App $app,
        private DemoCatalog $catalog,
        private WorkspaceRepository $workspaces,
        private LocaleCatalog $locales,
        private LocalizedUrlBuilder $urls,
    )
    {
        parent::__construct($app);
    }

    public function show(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if ($this->app()->authCheck($request)) {
            return $this->redirect($this->urls->console((string) $request->getAttribute('studio.locale', 'zh-CN')), 302);
        }

        $flash = $this->app()->session($request)->pullFlash('auth.error');
        $locale = $this->locales->resolve((string) $request->getAttribute('studio.locale', 'zh-CN'));
        $copy = $this->locales->login($locale);
        $shared = $this->locales->shared($locale, '/login');

        return $this->renderWithLayout('login.html', 'layout.html', [
            'title' => $copy['title'],
            'error' => is_string($flash) ? $flash : '',
            'password_hint' => $this->workspaces->loginPasswordHint(),
            'password_value' => '',
            'login_action' => $this->urls->login($locale),
            'page_section' => $copy['page_section'],
            'nav_label' => $copy['nav_label'],
            'footer_note' => $copy['footer_note'],
            'sidebar_copy' => $copy['sidebar_copy'],
            'eyebrow' => $copy['eyebrow'],
            'intro' => $copy['intro'],
            'card_form_title' => $copy['card_form_title'],
            'card_form_body' => $copy['card_form_body'],
            'email_label' => $copy['email_label'],
            'password_label' => $copy['password_label'],
            'submit_label' => $copy['submit_label'],
            'card_demo_title' => $copy['card_demo_title'],
            'card_demo_body' => $copy['card_demo_body'],
            'demo_owner_acme' => $copy['demo_owner_acme'],
            'demo_editor_acme' => $copy['demo_editor_acme'],
            'demo_owner_nova' => $copy['demo_owner_nova'],
            'password_hint_label' => $copy['password_hint_label'],
            'password_required_notice' => $copy['password_required_notice'],
            'path_title' => $copy['path_title'],
            'path_one' => $copy['path_one'],
            'path_two' => $copy['path_two'],
            'path_three' => $copy['path_three'],
            ...$shared,
        ]);
    }

    public function login(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if ($this->app()->authCheck($request)) {
            return $this->redirect($this->urls->console((string) $request->getAttribute('studio.locale', 'zh-CN')), 302);
        }

        $parsed = $request->getParsedBody();
        if (!is_array($parsed)) {
            $raw = (string) $request->getBody();
            if ($raw !== '') {
                parse_str($raw, $parsedFallback);
                if (is_array($parsedFallback)) {
                    $parsed = $parsedFallback;
                }
            }
        }

        $email = is_array($parsed) ? trim((string) ($parsed['email'] ?? '')) : '';
        $password = is_array($parsed) ? trim((string) ($parsed['password'] ?? '')) : '';

        $locale = $this->locales->resolve((string) $request->getAttribute('studio.locale', 'zh-CN'));
        $user = $this->workspaces->authenticate($email, $password);
        if ($user === null) {
            $copy = $this->locales->login($locale);
            $session = $this->app()->session($request);
            $session->flash('auth.error', $copy['invalid_credentials']);
            $response = new \VSlim\Vhttpd\Response(302, '', 'text/plain; charset=utf-8');
            $response->redirectWithStatus($this->urls->login($locale), 302);
            $session->commit($response);
            return $response;
        }

        $response = new \VSlim\Vhttpd\Response(302, '', 'text/plain; charset=utf-8');
        $redirect = $this->workspaces->requiresPasswordReset($user)
            ? $this->urls->consoleAccount($locale)
            : $this->urls->console($locale);
        $response->redirectWithStatus($redirect, 302);
        $this->app()->login($request, $response, (string) $user['id']);

        return $response;
    }

    public function logout(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        $locale = $this->locales->resolve((string) $request->getAttribute('studio.locale', 'zh-CN'));
        $response = new \VSlim\Vhttpd\Response(302, '', 'text/plain; charset=utf-8');
        $response->redirectWithStatus($this->urls->home($locale), 302);
        $this->app()->logout($request, $response);

        return $response;
    }
}
