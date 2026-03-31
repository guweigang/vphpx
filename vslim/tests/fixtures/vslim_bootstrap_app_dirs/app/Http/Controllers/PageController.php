<?php
declare(strict_types=1);

namespace App\Http\Controllers;

use Psr\Http\Message\ServerRequestInterface;

final class PageController extends \VSlim\Controller
{
    public function home(ServerRequestInterface $request): string
    {
        return implode("|", [
            "controller",
            (string) $request->getAttribute("dir_mw", ""),
            $this->url_for("appdir.home", []),
        ]);
    }
}
