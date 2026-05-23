module cachex

import vphp

struct PsrCacheEntry {
mut:
	value           vphp.PhpValue = vphp.PhpValue.invalid()
	expires_at_unix i64
}

struct Psr6DeferredEntry {
mut:
	value           vphp.PhpValue = vphp.PhpValue.invalid()
	has_value       bool
	expires_at_unix i64
}

@[php_implements: 'Psr\\SimpleCache\\CacheException']
@[php_class: 'VSlim\\Psr16\\CacheException']
@[php_extends: 'Exception']
@[heap]
pub struct VSlimPsr16CacheException {}

@[php_implements: 'Psr\\SimpleCache\\InvalidArgumentException']
@[php_class: 'VSlim\\Psr16\\InvalidArgumentException']
@[php_extends: 'VSlim\\Psr16\\CacheException']
@[heap]
pub struct VSlimPsr16InvalidArgumentException {}

@[php_implements: 'Psr\\SimpleCache\\CacheInterface']
@[php_class: 'VSlim\\Psr16\\Cache']
@[heap]
pub struct VSlimPsr16Cache {
mut:
	entries             map[string]PsrCacheEntry
	clock_ref           vphp.PhpObject = vphp.PhpObject.invalid() @[php_ignore]
	namespace_prefix    string         @[php_prop: namespacePrefix]
	default_ttl_seconds int            @[php_prop: defaultTtlSeconds]
}

@[php_class: 'VSlim\\Psr6\\CacheException']
@[php_implements: 'Psr\\Cache\\CacheException']
@[php_extends: 'Exception']
@[heap]
pub struct VSlimPsr6CacheException {}

@[php_class: 'VSlim\\Psr6\\InvalidArgumentException']
@[php_implements: 'Psr\\Cache\\InvalidArgumentException']
@[php_extends: 'VSlim\\Psr6\\CacheException']
@[heap]
pub struct VSlimPsr6InvalidArgumentException {}

@[php_implements: 'Psr\\Cache\\CacheItemInterface']
@[php_class: 'VSlim\\Psr6\\CacheItem']
@[heap]
pub struct VSlimPsr6CacheItem {
mut:
	key             string
	value_ref       vphp.PhpValue  = vphp.PhpValue.invalid()  @[php_ignore]
	clock_ref       vphp.PhpObject = vphp.PhpObject.invalid() @[php_ignore]
	hit             bool
	has_value       bool @[php_prop: hasValue]
	expires_at_unix i64  @[php_prop: expiresAtUnix]
}

@[php_implements: 'Psr\\Cache\\CacheItemPoolInterface']
@[php_class: 'VSlim\\Psr6\\CacheItemPool']
@[heap]
pub struct VSlimPsr6CacheItemPool {
mut:
	entries             map[string]PsrCacheEntry
	deferred            map[string]Psr6DeferredEntry
	clock_ref           vphp.PhpObject = vphp.PhpObject.invalid() @[php_ignore]
	namespace_prefix    string         @[php_prop: namespacePrefix]
	default_ttl_seconds int            @[php_prop: defaultTtlSeconds]
}
