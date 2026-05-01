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

    public function index(\VSlim\Psr7\ServerRequest $request): \Psr\Http\Message\ResponseInterface
    {
        $user = $this->app()->authUser($request);
        $locale = $this->locales->resolve((string) $request->getAttribute('studio.locale', 'zh-CN'));
        $copy = $this->locales->home($locale);
        $shared = $this->locales->shared($locale, '/');

        return $this->renderWithLayout('home.html', 'layout.html', [
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
            'fit_title' => $copy['fit_title'],
            'fit_body' => $copy['fit_body'],
            'fit_one' => $copy['fit_one'],
            'fit_two' => $copy['fit_two'],
            'fit_three' => $copy['fit_three'],
            'workflow_title' => $copy['workflow_title'],
            'workflow_body' => $copy['workflow_body'],
            'workflow_one' => $copy['workflow_one'],
            'workflow_two' => $copy['workflow_two'],
            'workflow_three' => $copy['workflow_three'],
            'why_title' => $copy['why_title'],
            'why_body' => $copy['why_body'],
            'why_one' => $copy['why_one'],
            'why_two' => $copy['why_two'],
            'why_three' => $copy['why_three'],
            'replace_title' => $copy['replace_title'],
            'replace_body' => $copy['replace_body'],
            'replace_one' => $copy['replace_one'],
            'replace_two' => $copy['replace_two'],
            'replace_three' => $copy['replace_three'],
            'start_title' => $copy['start_title'],
            'start_body' => $copy['start_body'],
            'start_one_title' => $copy['start_one_title'],
            'start_one_body' => $copy['start_one_body'],
            'start_one_cta' => $copy['start_one_cta'],
            'start_two_title' => $copy['start_two_title'],
            'start_two_body' => $copy['start_two_body'],
            'start_two_cta' => $copy['start_two_cta'],
            'start_three_title' => $copy['start_three_title'],
            'start_three_body' => $copy['start_three_body'],
            'start_three_cta' => $copy['start_three_cta'],
            'login_cta' => $copy['login_cta'],
            'console_cta' => $copy['console_cta'],
            'brand_cta' => $copy['brand_cta'],
            ...$shared,
        ]);
    }
}
