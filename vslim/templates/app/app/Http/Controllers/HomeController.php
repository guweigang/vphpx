<?php
declare(strict_types=1);

namespace App\Http\Controllers;

use Psr\Http\Message\ResponseInterface;

final class HomeController extends \VSlim\Controller
{
    public function index(\VSlim\Psr7\ServerRequest $request): ResponseInterface
    {
        return $this->render("home.html", [
            "title" => "VSlim Template",
            "app_name" => "vslim-template",
            "health_url" => $this->urlFor("template.home", []),
            "trace" => (string) $request->getHeaderLine("x-trace-id"),
        ]);
    }
}
