<?php
declare(strict_types=1);

namespace App\Http\Controllers;

final class HomeController extends \VSlim\Controller
{
    public function index(\VSlim\Psr7\ServerRequest $request): \VSlim\Vhttpd\Response
    {
        return $this->render("home.html", [
            "title" => "VSlim Template",
            "app_name" => "vslim-template",
            "health_url" => $this->urlFor("template.home", []),
            "trace" => (string) $request->getHeaderLine("x-trace-id"),
        ]);
    }
}
