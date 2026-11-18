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

@[vphp.PhpImplements(names: 'Psr\\SimpleCache\\CacheException')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr16\\CacheException')]
@[vphp.PhpExtends(name: 'Exception')]
@[heap]
pub struct VSlimPsr16CacheException {}

@[vphp.PhpImplements(names: 'Psr\\SimpleCache\\InvalidArgumentException')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr16\\InvalidArgumentException')]
@[vphp.PhpExtends(name: 'VSlim\\Psr16\\CacheException')]
@[heap]
pub struct VSlimPsr16InvalidArgumentException {}

@[vphp.PhpImplements(names: 'Psr\\SimpleCache\\CacheInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr16\\Cache')]
@[heap]
pub struct VSlimPsr16Cache {
mut:
	entries             map[string]PsrCacheEntry
	clock_ref           vphp.PhpObject = vphp.PhpObject.invalid() @[vphp.PhpIgnoreField]
	namespace_prefix    string @[vphp.PhpProperty; vphp.PhpProperty_name: 'namespacePrefix']
	default_ttl_seconds int    @[vphp.PhpProperty; vphp.PhpProperty_name: 'defaultTtlSeconds']
}

@[vphp.PhpExportClass(name: 'VSlim\\Psr6\\CacheException')]
@[vphp.PhpImplements(names: 'Psr\\Cache\\CacheException')]
@[vphp.PhpExtends(name: 'Exception')]
@[heap]
pub struct VSlimPsr6CacheException {}

@[vphp.PhpExportClass(name: 'VSlim\\Psr6\\InvalidArgumentException')]
@[vphp.PhpImplements(names: 'Psr\\Cache\\InvalidArgumentException')]
@[vphp.PhpExtends(name: 'VSlim\\Psr6\\CacheException')]
@[heap]
pub struct VSlimPsr6InvalidArgumentException {}

@[vphp.PhpImplements(names: 'Psr\\Cache\\CacheItemInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr6\\CacheItem')]
@[heap]
pub struct VSlimPsr6CacheItem {
mut:
	key             string
	value_ref       vphp.PhpValue  = vphp.PhpValue.invalid()  @[vphp.PhpIgnoreField]
	clock_ref       vphp.PhpObject = vphp.PhpObject.invalid() @[vphp.PhpIgnoreField]
	hit             bool
	has_value       bool @[vphp.PhpProperty; vphp.PhpProperty_name: 'hasValue']
	expires_at_unix i64  @[vphp.PhpProperty; vphp.PhpProperty_name: 'expiresAtUnix']
}

@[vphp.PhpImplements(names: 'Psr\\Cache\\CacheItemPoolInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr6\\CacheItemPool')]
@[heap]
pub struct VSlimPsr6CacheItemPool {
mut:
	entries             map[string]PsrCacheEntry
	deferred            map[string]Psr6DeferredEntry
	clock_ref           vphp.PhpObject = vphp.PhpObject.invalid() @[vphp.PhpIgnoreField]
	namespace_prefix    string @[vphp.PhpProperty; vphp.PhpProperty_name: 'namespacePrefix']
	default_ttl_seconds int    @[vphp.PhpProperty; vphp.PhpProperty_name: 'defaultTtlSeconds']
}
