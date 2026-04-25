<?php
declare(strict_types=1);

namespace App\Http\Controllers;

use Psr\Http\Message\ServerRequestInterface;

final class HomeController extends \VSlim\Controller
{
    public function index(ServerRequestInterface $request): \VSlim\VHttpd\Response
    {
        return $this->render("home.html", [
            "title" => "VSlim Skeleton Home",
            "trace" => (string) $request->getHeaderLine("x-trace-id"),
            "middleware" => (string) $request->getAttribute("skeleton_layer", ""),
            "catalog_url" => $this->urlFor("skeleton.catalog", ["slug" => "books"]),
        ]);
    }
}
