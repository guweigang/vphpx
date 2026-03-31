<?php
declare(strict_types=1);

namespace App\Http\Controllers;

use Psr\Http\Message\ServerRequestInterface;

final class BoundPageController
{
    public function __construct(private string $message) {}

    public function show(ServerRequestInterface $request): string
    {
        return implode("|", [
            "bound-controller",
            $this->message,
            (string) $request->getAttribute("dir_mw", ""),
        ]);
    }
}
