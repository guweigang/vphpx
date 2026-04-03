module main

import vphp

#include "php_bridge.h"

@[heap]
@[php_class: 'VSlim\\Container\\ContainerException']
@[php_extends: 'Exception']
@[php_implements: 'Psr\\Container\\ContainerExceptionInterface']
struct VSlimContainerException {}

@[heap]
@[php_class: 'VSlim\\Container\\NotFoundException']
@[php_extends: 'VSlim\\Container\\ContainerException']
@[php_implements: 'Psr\\Container\\NotFoundExceptionInterface']
struct VSlimContainerNotFoundException {}

@[heap]
@[php_class: 'VSlim\\Container']
@[php_implements: 'Psr\\Container\\ContainerInterface']
struct VSlimContainer {
mut:
	entries   map[string]vphp.PersistentOwnedZVal
	factories map[string]vphp.PersistentOwnedZVal
	resolved  map[string]vphp.PersistentOwnedZVal
	app_ref   &VSlimApp = unsafe { nil }
}

fn new_vslim_container() &VSlimContainer {
	return &VSlimContainer{
		entries:   map[string]vphp.PersistentOwnedZVal{}
		factories: map[string]vphp.PersistentOwnedZVal{}
		resolved:  map[string]vphp.PersistentOwnedZVal{}
	}
}

@[php_method]
pub fn (mut c VSlimContainer) construct() &VSlimContainer {
	c.entries = map[string]vphp.PersistentOwnedZVal{}
	c.factories = map[string]vphp.PersistentOwnedZVal{}
	c.resolved = map[string]vphp.PersistentOwnedZVal{}
	return &c
}

@[php_method]
pub fn (mut c VSlimContainer) set(id string, value vphp.BorrowedValue) &VSlimContainer {
	c.entries[id] = vphp.PersistentOwnedZVal.from_zval(value.to_zval())
	c.factories.delete(id)
	c.resolved.delete(id)
	return &c
}

@[php_method]
pub fn (mut c VSlimContainer) factory(id string, callable vphp.BorrowedValue) &VSlimContainer {
	if !callable.is_valid() || !callable.is_callable() {
		throw_container_exception('factory for "${id}" must be callable')
		return &c
	}
	c.factories[id] = vphp.PersistentOwnedZVal.from_zval(callable.to_zval())
	c.entries.delete(id)
	c.resolved.delete(id)
	return &c
}

@[php_method]
pub fn (c &VSlimContainer) has(id string) bool {
	if c.has_native_service(id) {
		return true
	}
	return id in c.entries || id in c.factories || id in c.resolved
}

@[php_method]
pub fn (mut c VSlimContainer) get(id string) vphp.Value {
	return c.get_entry_or_throw(id)
}

fn (mut c VSlimContainer) get_entry(id string) !vphp.Value {
	if native := c.get_native_service(id) {
		return native
	}
	if id in c.resolved {
		resolved := c.resolved[id] or { return error('entry "${id}" not found') }
		return vphp.Value.from_zval(resolved.clone_request_owned().to_zval())
	}
	if id in c.entries {
		entry := c.entries[id] or { return error('entry "${id}" not found') }
		return vphp.Value.from_zval(entry.clone_request_owned().to_zval())
	}
	if id in c.factories {
		factory_owned := c.factories[id] or { return error('entry "${id}" not found') }
		factory := factory_owned.to_zval()
		res := factory.call_owned_request([])
		if !res.is_valid() {
			return error('factory "${id}" returned invalid value')
		}
		c.resolved[id] = vphp.PersistentOwnedZVal.from_zval(res)
		return vphp.Value.from_zval(res)
	}
	return error('entry "${id}" not found')
}

fn (c &VSlimContainer) has_native_service(id string) bool {
	return c.app_ref != unsafe { nil } && id.trim_space() in [
		'config',
		'clock',
		'Psr\\Clock\\ClockInterface',
		'logger',
		'Psr\\Log\\LoggerInterface',
		'listener_provider',
		'events.provider',
		'Psr\\EventDispatcher\\ListenerProviderInterface',
		'events',
		'dispatcher',
		'Psr\\EventDispatcher\\EventDispatcherInterface',
		'cache',
		'Psr\\SimpleCache\\CacheInterface',
		'cache.pool',
		'Psr\\Cache\\CacheItemPoolInterface',
		'http',
		'http_client',
		'Psr\\Http\\Client\\ClientInterface',
	]
}

fn container_borrowed_object_value(v_ptr voidptr, ce voidptr, handlers voidptr) ?vphp.Value {
	unsafe {
		if v_ptr == 0 || ce == 0 {
			return none
		}
		mut payload := vphp.RequestOwnedZVal.new_null().to_zval()
		vphp.return_borrowed_object_raw(payload.raw, v_ptr, ce, handlers)
		return vphp.Value.from_zval(payload)
	}
}

fn (mut c VSlimContainer) get_native_service(id string) ?vphp.Value {
	if c.app_ref == unsafe { nil } {
		return none
	}
	match id.trim_space() {
		'config' {
			return container_borrowed_object_value(c.app_ref.config(), C.vslim__config_ce,
				vslimconfig_handlers())
		}
		'clock', 'Psr\\Clock\\ClockInterface' {
			return c.app_ref.clock()
		}
		'logger' {
			return container_borrowed_object_value(c.app_ref.logger(), C.vslim__log__logger_ce,
				vslimlogger_handlers())
		}
		'Psr\\Log\\LoggerInterface' {
			return container_borrowed_object_value(c.app_ref.psr_logger(), C.vslim__log__psrlogger_ce,
				vslimpsrlogger_handlers())
		}
		'listener_provider', 'events.provider', 'Psr\\EventDispatcher\\ListenerProviderInterface' {
			return container_borrowed_object_value(c.app_ref.listener_provider(),
				C.vslim__psr14__listenerprovider_ce,
				vslimpsr14listenerprovider_handlers())
		}
		'events', 'dispatcher', 'Psr\\EventDispatcher\\EventDispatcherInterface' {
			return container_borrowed_object_value(c.app_ref.dispatcher(),
				C.vslim__psr14__eventdispatcher_ce,
				vslimpsr14eventdispatcher_handlers())
		}
		'cache', 'Psr\\SimpleCache\\CacheInterface' {
			return container_borrowed_object_value(c.app_ref.cache(), C.vslim__psr16__cache_ce,
				vslimpsr16cache_handlers())
		}
		'cache.pool', 'Psr\\Cache\\CacheItemPoolInterface' {
			return container_borrowed_object_value(c.app_ref.cache_pool(),
				C.vslim__psr6__cacheitempool_ce,
				vslimpsr6cacheitempool_handlers())
		}
		'http', 'http_client', 'Psr\\Http\\Client\\ClientInterface' {
			return container_borrowed_object_value(c.app_ref.http_client(), C.vslim__psr18__client_ce,
				vslimpsr18client_handlers())
		}
		else {}
	}
	return none
}

fn (mut c VSlimContainer) get_entry_or_throw(id string) vphp.Value {
	return c.get_entry(id) or {
		if err.msg().contains('not found') {
			throw_not_found(id)
		} else {
			throw_container_exception(err.msg())
		}
		return vphp.Value.new_null()
	}
}

fn throw_not_found(id string) {
	vphp.throw_exception_class('VSlim\\Container\\NotFoundException',
		'Container entry "${id}" not found', 0)
}

fn throw_container_exception(msg string) {
	vphp.throw_exception_class('VSlim\\Container\\ContainerException', msg, 0)
}

fn (c &VSlimContainer) free() {
	for _, entry in c.entries {
		mut z := entry
		z.release()
	}
	for _, factory in c.factories {
		mut z := factory
		z.release()
	}
	for _, resolved in c.resolved {
		mut z := resolved
		z.release()
	}
	unsafe {
		c.entries.free()
		c.factories.free()
		c.resolved.free()
	}
}
