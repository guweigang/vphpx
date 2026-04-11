<?php
declare(strict_types=1);

namespace App\Http\Controllers;

use App\Support\DemoCatalog;

final class AuthController extends \VSlim\Controller
{
    public function __construct(\VSlim\App $app, private DemoCatalog $catalog)
    {
        parent::__construct($app);
    }

    public function show(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if ($this->app()->authCheck($request)) {
            return $this->redirect('/console', 302);
        }

        $flash = $this->app()->session($request)->pullFlash('auth.error');

        return $this->render_with_layout('login.html', 'layout.html', [
            'title' => 'Sign In',
            'error' => is_string($flash) ? $flash : '',
            'password_hint' => $this->catalog->passwordHint(),
            'page_section' => 'Tenant Access',
            'nav_label' => 'Sign In',
            'footer_note' => 'Demo identities will be replaced by persistent auth in milestone 1',
        ]);
    }

    public function login(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        if ($this->app()->authCheck($request)) {
            return $this->redirect('/console', 302);
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

        $user = $this->catalog->authenticate($email, $password);
        if ($user === null) {
            $session = $this->app()->session($request);
            $session->flash('auth.error', 'Invalid demo credentials. Try owner@acme.test / demo123.');
            $response = new \VSlim\Vhttpd\Response(302, '', 'text/plain; charset=utf-8');
            $response->redirect_with_status('/login', 302);
            $session->commit($response);
            return $response;
        }

        $response = new \VSlim\Vhttpd\Response(302, '', 'text/plain; charset=utf-8');
        $response->redirect_with_status('/console', 302);
        $this->app()->login($request, $response, (string) $user['id']);

        return $response;
    }

    public function logout(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        $response = new \VSlim\Vhttpd\Response(302, '', 'text/plain; charset=utf-8');
        $response->redirect_with_status('/', 302);
        $this->app()->logout($request, $response);

        return $response;
    }
}
