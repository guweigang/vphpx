<?php
declare(strict_types=1);

namespace App\Http\Controllers;

use App\Support\LocaleCatalog;
use App\Support\LocalizedUrlBuilder;

final class HomeController extends \VSlim\Controller
{
    public function __construct(
        \VSlim\App $app,
        private LocaleCatalog $locales,
        private LocalizedUrlBuilder $urls,
    )
    {
        parent::__construct($app);
    }

    public function index(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        $user = $this->app()->authUser($request);
        $locale = $this->locales->resolve((string) $request->getAttribute('studio.locale', 'zh-CN'));
        $copy = $this->locales->home($locale);
        $shared = $this->locales->shared($locale, '/');

        return $this->render_with_layout('home.html', 'layout.html', [
            'title' => 'Knowledge Studio',
            'tagline' => $copy['tagline'],
            'login_url' => $this->urls->login($locale),
            'console_url' => $this->urls->console($locale),
            'brand_url' => $this->urls->brand('acme-research', $locale),
            'trace' => (string) $request->getHeaderLine('x-trace-id'),
            'viewer_name' => is_array($user) ? (string) ($user['name'] ?? '') : '',
            'viewer_role' => is_array($user) ? (string) ($user['role'] ?? '') : '',
            'page_section' => $copy['page_section'],
            'nav_label' => $copy['nav_label'],
            'footer_note' => $copy['footer_note'],
            'sidebar_copy' => $copy['sidebar_copy'],
            'eyebrow' => $copy['eyebrow'],
            'trace_label' => $copy['trace_label'],
            'viewer_label' => $copy['viewer_label'],
            'card_console_title' => $copy['card_console_title'],
            'card_console_body' => $copy['card_console_body'],
            'card_brand_title' => $copy['card_brand_title'],
            'card_brand_body' => $copy['card_brand_body'],
            'card_db_title' => $copy['card_db_title'],
            'card_db_body' => $copy['card_db_body'],
            'login_cta' => $copy['login_cta'],
            'console_cta' => $copy['console_cta'],
            'brand_cta' => $copy['brand_cta'],
            ...$shared,
        ]);
    }
}
