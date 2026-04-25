# vslim / vhttpd PSR-7 Bridge Plan

This document describes how `vhttpd`, `php-worker.php`, and `vslim` should evolve so that
`vhttpd` can serve as a more generic HTTP runtime for the PHP ecosystem while `vslim`
keeps a lightweight native V request/response core.

## Goal

We want these three properties at the same time:

1. `vhttpd` should stay generic and not be hard-coded to `vslim` route semantics.
2. PHP frameworks and middleware that expect PSR-7 should be usable behind `vhttpd`.
3. `vslim` should keep a small, mutable, V-friendly core model instead of immediately
   becoming a full immutable PSR-7 implementation.

The result is a layered design:

```text
HTTP client
    -> vhttpd transport/runtime
    -> request envelope
    -> php-worker bridge
    -> PSR-7 adapter (optional)
    -> vslim adapter or other PHP framework
```

## Why not implement PSR-7 directly in the extension first?

PSR-7 is interface-only. The `php-fig/http-message` package defines interfaces, not a concrete
implementation. See:

- [PSR-7 specification](https://www.php-fig.org/psr/psr-7/)
- [php-fig/http-message](https://github.com/php-fig/http-message)

A direct extension-level implementation would immediately require:

1. immutable `with*()` semantics
2. `StreamInterface`
3. `UriInterface`
4. `UploadedFileInterface`
5. normalized request attributes/body/cookies/server params

That is a much larger project than what `vslim` needs right now.

## Recommended architecture

### Layer 1: vhttpd owns transport

`vhttpd` should parse network traffic and turn it into a complete request envelope.
It should *not* try to model PHP framework semantics.

Recommended envelope fields:

- `method`
- `path`
- `protocol_version`
- `scheme`
- `host`
- `port`
- `headers`
- `cookies`
- `query`
- `body`
- `remote_addr`
- `server`
- `uploaded_files`
- `attributes`

Notes:

- Transport should stay structured and array-based across `vhttpd -> php-worker -> vslim`.
- This keeps `veb`-derived request data intact and avoids a second JSON compatibility shape.
- Additional fields can still be added later without changing the high-level architecture.

### Layer 2: php-worker owns PHP ecosystem adaptation

`php-worker.php` should be the place where transport envelopes are adapted into PHP-facing
runtime objects.

This layer can choose one of two paths:

1. If a PSR-7 implementation is available, build a real `ServerRequestInterface`.
2. Otherwise, adapt the envelope into `VSlim\Vhttpd\Request` and call `dispatchEnvelope(...)`.

This means `php-worker` becomes the compatibility seam between:

- generic transport (`vhttpd`)
- PHP ecosystem semantics (PSR-7/PSR-15/frameworks)

### Layer 3: vslim keeps a native core and adds adapters

`vslim` should keep:

- `VSlim\Vhttpd\Request`
- `VSlim\Vhttpd\Response`
- `SlimApp`
- middleware chain
- route matching

These remain mutable and compact.

On top of that, `vslim` can later add adapter entry points:

- `from_psr7(ServerRequestInterface $request)`
- `to_psr7_response(VSlim\Vhttpd\Response $response)`
- or a PHP-side adapter class that translates between PSR-7 and `dispatchRequest(...)`

This lets `vslim` participate in PSR-7 workflows without forcing the internal model to copy PSR-7.

## Phase plan

### Phase 1: complete the transport envelope

Deliverables:

- `vhttpd` emits a richer request envelope
- `php-worker` keeps forwarding to `dispatchEnvelope(...)`
- `vslim` continues to consume the envelope directly

At this stage, `vslim` gains better request fidelity without taking on PSR-7 complexity.

### Phase 2: worker-side PSR-7 construction

Deliverables:

- detect installed PSR-7 implementation in PHP worker
- create a real `ServerRequestInterface`
- allow worker-side apps to be written in PSR-7/PSR-15 style

Examples of implementations that may be supported by userland:

- Nyholm PSR-7
- Guzzle PSR-7
- Laminas Diactoros

`vhttpd` still stays generic; only the worker changes.

### Phase 3: vslim adapter layer

Deliverables:

- define a `vslim` adapter that can read a PSR-7 request and produce a `VSlim\Vhttpd\Response`
- optionally define a PSR-7 response adapter for outgoing responses

This can live either:

- in PHP userland beside `php-worker.php`, or
- partially inside `vslim` as exported helper APIs

### Phase 4: optional native PSR-7 implementation

Only do this if the project later proves it is worth it.

Reasons to delay this:

- high implementation cost
- lots of edge cases
- adapter approach already unlocks framework compatibility

## Suggested responsibilities

### vhttpd

Responsible for:

- HTTP parsing
- connection management
- request envelope creation
- proxying requests to worker
- lifecycle and observability

Not responsible for:

- PSR-7 object semantics
- framework routing semantics
- message immutability

### php-worker.php

Responsible for:

- adapting envelope -> PHP runtime request form
- optional PSR-7 request creation
- dispatching to `vslim` or another app
- serializing response back to `vhttpd`

### vslim

Responsible for:

- routing and middleware
- native request/response model
- adapter hooks for PSR-7 later

Not responsible for:

- raw network IO
- socket supervision
- full PSR-7 implementation in phase 1

## Proposed request envelope v2

Minimal recommended shape:

```php
[
    'method' => 'GET',
    'path' => '/users/42?trace_id=worker',
    'body' => '',
    'scheme' => 'https',
    'host' => 'example.test',
    'port' => '443',
    'protocol_version' => '1.1',
    'remote_addr' => '127.0.0.1',
    'headers' => ['x-request-id' => 'abc'],
    'cookies' => ['sid' => 'cookie-7'],
    'query' => ['trace_id' => 'worker'],
    'server' => ['REQUEST_TIME_FLOAT' => '...'],
    'uploaded_files' => [],
    'attributes' => [],
]
```

Notes:

- `path` can remain the canonical request target.
- `query` is still useful even if query is also embedded in `path`; it avoids reparsing later.
- `attributes` maps cleanly to PSR-7 request attributes and also to route params.

## Suggested PHP worker strategy

Pseudo-flow:

```php
if (class_exists(VSlim\App::class)) {
    return $app->dispatchEnvelope($envelope);
}

if ($psr7FactoryIsAvailable) {
    $request = buildServerRequestFromEnvelope($envelope);
    return $app($request); // or PSR-15 dispatch
}

// fallback legacy dispatch
return dispatchLegacy($envelope);
```

This lets the worker support both:

- `vslim` native mode
- broader PSR-7 app mode

## Suggested vslim adapter API

Native core should stay close to what we already have.

Current guidance is to keep entrypoints and adapters separate:

```php
$psrResponse = $app->handle($serverRequest);
$response = VSlim\Psr7Adapter::toVSlimResponse($psrResponse);
```

or, when you want to stay on the `VSlim\Vhttpd\Request` facade side:

```php
$request = VSlim\Psr7Adapter::toVSlimRequest($serverRequest);
$response = $app->dispatchRequest($request);
```

This keeps the adapter focused on translation instead of turning it into another app entrypoint.

## Current recommendation

The next implementation steps should be:

1. enrich the request envelope in `vhttpd`
2. mirror those fields into `VSlim\Vhttpd\Request`
3. make `php-worker.php` able to build a PSR-7 request when userland provides a PSR-7 implementation
4. keep the adapter layer focused on `toVSlimRequest(...)` / `toVSlimResponse(...)`

This keeps the system incremental and avoids prematurely forcing `vslim` to become a full
PSR-7 library.
