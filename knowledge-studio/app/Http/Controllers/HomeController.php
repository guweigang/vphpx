<?php
declare(strict_types=1);

namespace App\Http\Controllers;

final class HomeController extends \VSlim\Controller
{
    public function __construct(\VSlim\App $app)
    {
        parent::__construct($app);
    }

    public function index(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        $user = $this->app()->authUser($request);

        return $this->render_with_layout('home.html', 'layout.html', [
            'title' => 'Knowledge Studio',
            'tagline' => 'Multi-tenant AI knowledge brand platform sample for VSlim.',
            'login_url' => '/login',
            'console_url' => '/console',
            'brand_url' => '/brand/acme-research',
            'trace' => (string) $request->getHeaderLine('x-trace-id'),
            'viewer_name' => is_array($user) ? (string) ($user['name'] ?? '') : '',
            'viewer_role' => is_array($user) ? (string) ($user['role'] ?? '') : '',
            'page_section' => 'Landing',
            'nav_label' => 'Overview',
            'footer_note' => 'Foundation skeleton running on VSlim View layout',
        ]);
    }
}
