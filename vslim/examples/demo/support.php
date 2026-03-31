<?php
declare(strict_types=1);

require_once __DIR__ . "/psr_stubs.php";

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;

if (!class_exists("DemoUserService", false)) {
    final class DemoUserService
    {
        public function find(string $id): array
        {
            return [
                "id" => $id,
                "name" => "user-" . $id,
                "role" => (int) $id % 2 === 0 ? "admin" : "member",
            ];
        }

        public function save(string $id, string $method, array $payload): array
        {
            return [
                "id" => $id,
                "method" => strtoupper($method),
                "payload" => $payload,
                "updated" => true,
            ];
        }
    }
}

if (!class_exists("DemoUserController", false)) {
    final class DemoUserController
    {
        public function __construct(private DemoUserService $svc) {}

        public function show(ServerRequestInterface $req): array
        {
            $query = $req->getQueryParams();
            return [
                "status" => 200,
                "content_type" => "application/json; charset=utf-8",
                "body" => json_encode(
                    [
                        "ok" => true,
                        "from" => "container-controller",
                        "user" => $this->svc->find((string) $req->getAttribute("id")),
                        "trace" => $query["trace_id"] ?? "",
                    ],
                    JSON_UNESCAPED_UNICODE,
                ),
            ];
        }

        public function index(ServerRequestInterface $req): array
        {
            return [
                "status" => 200,
                "content_type" => "application/json; charset=utf-8",
                "body" => json_encode(
                    [
                        "ok" => true,
                        "from" => "container-controller",
                        "action" => "index",
                        "trace" => $req->getHeaderLine("x-trace-id"),
                    ],
                    JSON_UNESCAPED_UNICODE,
                ),
            ];
        }

        public function store(ServerRequestInterface $req): array
        {
            $query = $req->getQueryParams();
            $parsed = $req->getParsedBody();
            return [
                "status" => 201,
                "content_type" => "application/json; charset=utf-8",
                "body" => json_encode(
                    [
                        "ok" => true,
                        "from" => "container-controller",
                        "action" => "store",
                        "payload" => array_merge(
                            is_array($query) ? $query : [],
                            is_array($parsed) ? $parsed : [],
                        ),
                    ],
                    JSON_UNESCAPED_UNICODE,
                ),
            ];
        }

        public function update(ServerRequestInterface $req): array
        {
            $query = $req->getQueryParams();
            $parsed = $req->getParsedBody();
            return [
                "status" => 200,
                "content_type" => "application/json; charset=utf-8",
                "body" => json_encode(
                    [
                        "ok" => true,
                        "from" => "container-controller",
                        "result" => $this->svc->save(
                            (string) $req->getAttribute("id"),
                            $req->getMethod(),
                            array_merge(
                                is_array($query) ? $query : [],
                                is_array($parsed) ? $parsed : [],
                            ),
                        ),
                    ],
                    JSON_UNESCAPED_UNICODE,
                ),
            ];
        }

        public function destroy(ServerRequestInterface $req): array
        {
            return [
                "status" => 200,
                "content_type" => "application/json; charset=utf-8",
                "body" => json_encode(
                    [
                        "ok" => true,
                        "from" => "container-controller",
                        "action" => "destroy",
                        "id" => $req->getAttribute("id"),
                    ],
                    JSON_UNESCAPED_UNICODE,
                ),
            ];
        }

        public function create(ServerRequestInterface $req): array
        {
            return [
                "status" => 200,
                "content_type" => "application/json; charset=utf-8",
                "body" => json_encode(
                    [
                        "ok" => true,
                        "from" => "container-controller",
                        "action" => "create",
                    ],
                    JSON_UNESCAPED_UNICODE,
                ),
            ];
        }

        public function edit(ServerRequestInterface $req): array
        {
            return [
                "status" => 200,
                "content_type" => "application/json; charset=utf-8",
                "body" => json_encode(
                    [
                        "ok" => true,
                        "from" => "container-controller",
                        "action" => "edit",
                        "id" => $req->getAttribute("id"),
                    ],
                    JSON_UNESCAPED_UNICODE,
                ),
            ];
        }
    }
}

if (!class_exists("DemoAutoPing", false)) {
    final class DemoAutoPing
    {
        public function __invoke(ServerRequestInterface $req): string
        {
            return "auto-ping:" . $req->getAttribute("id");
        }
    }
}

if (!class_exists("DemoPageController", false)) {
    final class DemoPageController extends VSlim\Controller
    {
        public function home(ServerRequestInterface $req): VSlim\Vhttpd\Response
        {
            return $this->render("home.html", [
                "title" => "VSlim MVC Demo",
                "name" => $req->getAttribute("name") ?: "guest",
                "trace" => $req->getHeaderLine("x-trace-id") ?: "",
            ]);
        }
    }
}

if (!class_exists("DemoTraceMiddleware", false)) {
    final class DemoTraceMiddleware implements MiddlewareInterface
    {
        public function process(
            ServerRequestInterface $request,
            RequestHandlerInterface $handler,
        ): ResponseInterface {
            $trace = trim((string) $request->getHeaderLine("x-trace-id"));
            if ($trace === "") {
                $query = $request->getQueryParams();
                $candidate = $query["trace_id"] ?? "";
                $trace = is_string($candidate) && $candidate !== ""
                    ? $candidate
                    : "demo-trace";
                $request = $request->withHeader("x-trace-id", $trace);
            }

            return $handler
                ->handle($request)
                ->withHeader("x-demo-app", "vslim-demo")
                ->withHeader("x-trace-id", $trace);
        }
    }
}

if (!class_exists("DemoAppServiceProvider", false)) {
    final class DemoAppServiceProvider extends VSlim\Support\ServiceProvider
    {
        public function register(): void
        {
            $container = $this->app()->container();
            $container->set(DemoUserService::class, new DemoUserService());

            /** @var DemoUserService $svc */
            $svc = $container->get(DemoUserService::class);
            $container->set(DemoUserController::class, new DemoUserController($svc));
            $container->set(DemoPageController::class, new DemoPageController($this->app()));
        }
    }
}
