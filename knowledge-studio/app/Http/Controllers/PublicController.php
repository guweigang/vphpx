<?php
declare(strict_types=1);

namespace App\Http\Controllers;

use App\Support\DemoCatalog;

final class PublicController extends \VSlim\Controller
{
    public function __construct(\VSlim\App $app, private DemoCatalog $catalog)
    {
        parent::__construct($app);
    }

    public function landing(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        $workspace = $request->getAttribute('studio.workspace');
        if (!is_array($workspace)) {
            $workspace = $this->catalog->findWorkspaceBySlug($this->tenantFromPath($request));
        }

        return $this->render_with_layout('brand.html', 'layout.html', [
            'title' => is_array($workspace) ? (string) ($workspace['brand_name'] ?? '') : 'Brand',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'tagline' => is_array($workspace) ? (string) ($workspace['tagline'] ?? '') : '',
            'assistant_url' => is_array($workspace)
                ? '/brand/' . (string) ($workspace['slug'] ?? '') . '/assistant'
                : '#',
            'page_section' => 'Public Brand',
            'nav_label' => is_array($workspace) ? (string) ($workspace['brand_name'] ?? '') : 'brand',
            'footer_note' => 'Public experience will gain subscriptions and streaming answers next',
        ]);
    }

    public function assistant(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        $workspace = $request->getAttribute('studio.workspace');
        if (!is_array($workspace)) {
            $workspace = $this->catalog->findWorkspaceBySlug($this->tenantFromPath($request));
        }

        return $this->render_with_layout('assistant.html', 'layout.html', [
            'title' => is_array($workspace) ? (string) ($workspace['brand_name'] ?? '') : 'Assistant',
            'workspace_name' => is_array($workspace) ? (string) ($workspace['name'] ?? '') : '',
            'workspace_slug' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : '',
            'tagline' => is_array($workspace) ? (string) ($workspace['tagline'] ?? '') : '',
            'page_section' => 'Assistant Preview',
            'nav_label' => is_array($workspace) ? (string) ($workspace['slug'] ?? '') : 'assistant',
            'footer_note' => 'Streaming, sources, and subscription gating land in the next milestone',
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
}
