--TEST--
VSlim native PSR-17 UriFactory builds immutable PSR-7 Uri objects
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
namespace Psr\Http\Message {
    if (!interface_exists(UriInterface::class, false)) {
        interface UriInterface {
            public function getScheme(): string;
            public function getAuthority(): string;
            public function getUserInfo(): string;
            public function getHost(): string;
            public function getPort(): ?int;
            public function getPath(): string;
            public function getQuery(): string;
            public function getFragment(): string;
            public function withScheme(string $scheme);
            public function withUserInfo(string $user, ?string $password = null);
            public function withHost(string $host);
            public function withPort(?int $port);
            public function withPath(string $path);
            public function withQuery(string $query);
            public function withFragment(string $fragment);
            public function __toString(): string;
        }
    }
    if (!interface_exists(UriFactoryInterface::class, false)) {
        interface UriFactoryInterface {
            public function createUri(string $uri = ''): UriInterface;
        }
    }
}

namespace {
    $factory = new VSlim\Psr17\UriFactory();
    echo ($factory instanceof Psr\Http\Message\UriFactoryInterface ? 'uf-yes' : 'uf-no') . PHP_EOL;

    $uri = $factory->createUri('https://user:pass@example.com:8443/api/items?x=1#frag');
    echo get_class($uri) . PHP_EOL;
    echo ($uri instanceof Psr\Http\Message\UriInterface ? 'uri-yes' : 'uri-no') . PHP_EOL;
    echo $uri->getScheme() . '|' . $uri->getAuthority() . '|' . $uri->getUserInfo() . '|' . $uri->getHost() . '|' . $uri->getPort() . PHP_EOL;
    echo $uri->getPath() . '|' . $uri->getQuery() . '|' . $uri->getFragment() . PHP_EOL;

    $uri2 = $uri
        ->withScheme('http')
        ->withHost('API.EXAMPLE.TEST')
        ->withPort(80)
        ->withPath('v1/list')
        ->withQuery('?page=2')
        ->withFragment('#top');
    echo (string) $uri . PHP_EOL;
    echo (string) $uri2 . PHP_EOL;
    echo $uri2->getAuthority() . PHP_EOL;
    echo ($uri2->getPort() === null ? 'null' : $uri2->getPort()) . PHP_EOL;

    $uri3 = $uri2->withUserInfo('neo')->withPort(8080);
    echo $uri3->getUserInfo() . '|' . $uri3->getAuthority() . PHP_EOL;

    $uri4 = $factory->createUri('/local/path?trace_id=abc#done');
    echo (string) $uri4 . PHP_EOL;
    echo $uri4->getHost() === '' ? 'host-empty' : 'host-set';
}
?>
--EXPECT--
uf-yes
VSlim\Psr7\Uri
uri-yes
https|user:pass@example.com:8443|user:pass|example.com|8443
/api/items|x=1|frag
https://user:pass@example.com:8443/api/items?x=1#frag
http://user:pass@api.example.test/v1/list?page=2#top
user:pass@api.example.test
null
neo|neo@api.example.test:8080
/local/path?trace_id=abc#done
host-empty
