--TEST--
VSlim map and map_named register one handler for multiple methods
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = new VSlim\App();
$app->map(['GET', 'POST'], '/multi/:id', function ($req) {
    return $req->getMethod() . ':' . $req->getAttribute('id');
});
$app->map('PUT|PATCH', '/edit/:id', function ($req) {
    return $req->getMethod() . ':' . $req->getAttribute('id');
});
$app->mapNamed(['DELETE', 'OPTIONS'], 'api.remove', '/api/items/:id', function ($req) {
    return $req->getMethod() . ':' . $req->getAttribute('id');
});
$group = $app->group('/v1');
$group->map(['GET', 'HEAD'], '/ping', function ($req) {
    return 'pong:' . $req->getMethod();
});

echo $app->dispatch('GET', '/multi/7')->body . PHP_EOL;
echo $app->dispatch('POST', '/multi/7')->body . PHP_EOL;
echo $app->dispatch('PUT', '/edit/8')->body . PHP_EOL;
echo $app->dispatch('PATCH', '/edit/8')->body . PHP_EOL;
echo $app->dispatch('DELETE', '/api/items/9')->body . PHP_EOL;
echo $app->dispatch('OPTIONS', '/api/items/9')->body . PHP_EOL;
echo $app->dispatch('GET', '/v1/ping')->body . PHP_EOL;
echo $app->dispatch('HEAD', '/v1/ping')->status . '|' . strlen($app->dispatch('HEAD', '/v1/ping')->body) . PHP_EOL;
echo $app->urlFor('api.remove', ['id' => '99']) . PHP_EOL;

$probe = new class implements ArrayAccess {
    public array $reads = [];
    private array $values = ['body' => 'array access', 'headers' => ['X-Envelope' => 'custom']];
    public function offsetExists(mixed $offset): bool { return array_key_exists($offset, $this->values); }
    public function &offsetGet(mixed $offset): mixed
    {
        $this->reads[] = $offset;
        return $this->values[$offset];
    }
    public function offsetSet(mixed $offset, mixed $value): void { throw new LogicException('Read only'); }
    public function offsetUnset(mixed $offset): void { throw new LogicException('Read only'); }
};
$app->get('/offsets', static fn () => $probe);
$response = $app->dispatch('GET', '/offsets');
if ($response->status !== 200 || $response->body !== 'array access'
    || $response->header('x-envelope') !== 'custom' || $probe->reads !== ['body', 'headers']) {
    throw new RuntimeException('ArrayAccess response did not use present offsets and array defaults');
}
$failure = new DomainException('response offset failure');
$app->get('/offset-failure', static fn () => new class($failure) extends ArrayObject {
    public function __construct(private Throwable $failure) {}
    public function offsetExists(mixed $offset): bool { throw $this->failure; }
});
try {
    $app->dispatch('GET', '/offset-failure');
    throw new LogicException('VSlim swallowed the response offset exception');
} catch (DomainException $caught) {
    if ($caught !== $failure) { throw $caught; }
}

$serialized = new class implements JsonSerializable {
    public int $calls = 0;
    public function jsonSerialize(): mixed { ++$this->calls; return ['enabled' => true, 'optional' => null]; }
};
$app->get('/document', static fn () => $serialized);
$app->get('/text-document', static fn () => new class implements JsonSerializable, Stringable {
    public function __toString(): string { return 'text'; }
    public function jsonSerialize(): mixed { throw new LogicException('Stringable must be handled first'); }
});
$app->get('/serialization-failure', static fn () => new class($failure) implements JsonSerializable {
    public function __construct(private Throwable $failure) {}
    public function jsonSerialize(): mixed { throw $this->failure; }
});
$app->get('/invalid-document', static fn () => new class implements JsonSerializable {
    public function jsonSerialize(): mixed { return "\xff"; }
});
$document = $app->dispatch('GET', '/document');
$textDocument = $app->dispatch('GET', '/text-document');
if ($document->status !== 200 || $document->body !== '{"enabled":true,"optional":null}'
    || $document->contentType !== 'application/json; charset=utf-8' || $serialized->calls !== 1
    || $textDocument->body !== 'text' || $textDocument->contentType !== 'text/plain; charset=utf-8') {
    throw new RuntimeException('Unexpected JSON response or Stringable precedence');
}
try {
    $app->dispatch('GET', '/serialization-failure');
    throw new LogicException('VSlim swallowed the serialization exception');
} catch (DomainException $caught) {
    if ($caught !== $failure) { throw $caught; }
}
try {
    $app->dispatch('GET', '/invalid-document');
    throw new LogicException('VSlim accepted invalid JSON data');
} catch (JsonException $caught) {
    if ($caught->getCode() !== JSON_ERROR_UTF8) { throw $caught; }
}

$fragment = new class {
    public int $casts = 0;
    public function __toString(): string { ++$this->casts; return "fragment\0字"; }
};
$app->get('/fragment', static fn () => $fragment);
$app->get('/empty-fragment', static fn () => new class implements Stringable {
    public function __toString(): string { return ''; }
});
$app->get('/hybrid', static fn () => new class(['status' => 204]) extends ArrayObject {
    public function __toString(): string { throw new LogicException('Envelope must be read first'); }
});
$app->get('/bad-fragment', static fn () => new class($failure) implements Stringable {
    public function __construct(private Throwable $failure) {}
    public function __toString(): string { throw $this->failure; }
});
$rendered = $app->dispatch('GET', '/fragment');
$empty = $app->dispatch('GET', '/empty-fragment');
if ($rendered->status !== 200 || $rendered->body !== "fragment\0字" || $fragment->casts !== 1
    || $empty->status !== 200 || $empty->body !== '' || $app->dispatch('GET', '/hybrid')->status !== 204) {
    throw new RuntimeException('Unexpected Stringable response or envelope precedence');
}
try {
    $app->dispatch('GET', '/bad-fragment');
    throw new LogicException('VSlim swallowed the string conversion exception');
} catch (DomainException $caught) {
    if ($caught !== $failure) { throw $caught; }
}
?>
--EXPECT--
GET:7
POST:7
PUT:8
PATCH:8
DELETE:9
OPTIONS:9
pong:GET
200|0
/api/items/99
