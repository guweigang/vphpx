module main

import vphp

#include "php_bridge.h"

@[php_implements: 'Psr\\Container\\ContainerExceptionInterface']
@[php_class: 'VSlim\\Container\\ContainerException']
@[php_extends: 'Exception']
@[heap]
struct VSlimContainerException {}

@[php_implements: 'Psr\\Container\\NotFoundExceptionInterface']
@[php_extends: 'VSlim\\Container\\ContainerException']
@[php_class: 'VSlim\\Container\\NotFoundException']
@[heap]
struct VSlimContainerNotFoundException {}

@[php_implements: 'Psr\\Container\\ContainerInterface']
@[php_class: 'VSlim\\Container']
@[heap]
struct VSlimContainer {
mut:
	entries   map[string]vphp.PersistentOwnedZBox @[php_ignore]
	factories map[string]vphp.PersistentOwnedZBox @[php_ignore]
	resolved  map[string]vphp.PersistentOwnedZBox @[php_ignore]
	app_ref   &VSlimApp = unsafe { nil } @[php_ignore]
}

fn new_vslim_container() &VSlimContainer {
	return &VSlimContainer{
		entries:   map[string]vphp.PersistentOwnedZBox{}
		factories: map[string]vphp.PersistentOwnedZBox{}
		resolved:  map[string]vphp.PersistentOwnedZBox{}
	}
}

@[php_method]
pub fn (mut c VSlimContainer) construct() &VSlimContainer {
	c.entries = map[string]vphp.PersistentOwnedZBox{}
	c.factories = map[string]vphp.PersistentOwnedZBox{}
	c.resolved = map[string]vphp.PersistentOwnedZBox{}
	return &c
}

@[php_method]
pub fn (mut c VSlimContainer) set(id string, value vphp.RequestBorrowedZBox) &VSlimContainer {
	raw := value.to_zval()
	c.entries[id] = if raw.is_object() && !raw.is_callable() {
		vphp.PersistentOwnedZBox.from_object_zval(raw)
	} else {
		vphp.PersistentOwnedZBox.from_mixed_zval(raw)
	}
	c.factories.delete(id)
	c.resolved.delete(id)
	return &c
}

@[php_method]
pub fn (mut c VSlimContainer) factory(id string, callable vphp.RequestBorrowedZBox) &VSlimContainer {
	if !callable.is_valid() || !callable.is_callable() {
		throw_container_exception('factory for "${id}" must be callable')
		return &c
	}
	c.factories[id] = vphp.PersistentOwnedZBox.from_callable_zval(callable.to_zval())
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
pub fn (mut c VSlimContainer) get(id string) vphp.RequestOwnedZBox {
	return c.get_entry_or_throw(id)
}

pub fn (mut c VSlimContainer) get_entry(id string) !vphp.RequestOwnedZBox {
	if native := c.get_native_service(id) {
		return native
	}
	if id in c.resolved {
		resolved := c.resolved[id] or { return error('entry "${id}" not found') }
		return resolved.clone_request_owned()
	}
	if id in c.entries {
		entry := c.entries[id] or { return error('entry "${id}" not found') }
		return entry.clone_request_owned()
	}
	if id in c.factories {
		factory_owned := c.factories[id] or { return error('entry "${id}" not found') }
		mut res := factory_owned.fn_request_owned()
		if !res.is_valid() {
			return error('factory "${id}" returned invalid value')
		}
		raw := res.to_zval()
		c.resolved[id] = if raw.is_object() && !raw.is_callable() {
			vphp.PersistentOwnedZBox.from_object_zval(raw)
		} else {
			vphp.PersistentOwnedZBox.from_mixed_zval(raw)
		}
		return res
	}
	return error('entry "${id}" not found')
}

pub fn (c &VSlimContainer) has_native_service(id string) bool {
	app := container_effective_app(c)
	return app != unsafe { nil }
		&& id.trim_space() in ['config', 'clock', 'Psr\\Clock\\ClockInterface', 'logger', 'Psr\\Log\\LoggerInterface', 'listener_provider', 'events.provider', 'Psr\\EventDispatcher\\ListenerProviderInterface', 'events', 'dispatcher', 'Psr\\EventDispatcher\\EventDispatcherInterface', 'cache', 'Psr\\SimpleCache\\CacheInterface', 'cache.pool', 'Psr\\Cache\\CacheItemPoolInterface', 'http', 'http_client', 'Psr\\Http\\Client\\ClientInterface']
}

fn container_effective_app(c &VSlimContainer) &VSlimApp {
	runtime := current_runtime_dispatch_app()
	if runtime != unsafe { nil } {
		return runtime
	}
	return c.app_ref
}

fn container_borrowed_object_value(v_ptr voidptr, ce voidptr, handlers voidptr) ?vphp.RequestOwnedZBox {
	unsafe {
		if v_ptr == 0 || ce == 0 {
			return none
		}
		mut payload := vphp.RequestOwnedZBox.new_null().to_zval()
		vphp.PhpReturn.new(payload.raw).borrowed_object(v_ptr, ce, handlers)
		return vphp.RequestOwnedZBox.adopt_zval(payload)
	}
}

pub fn (mut c VSlimContainer) get_native_service(id string) ?vphp.RequestOwnedZBox {
	mut app := container_effective_app(c)
	if app == unsafe { nil } {
		return none
	}
	match id.trim_space() {
		'config' {
			return container_borrowed_object_value(app.config(), C.vslim__config_ce, vslimconfig_handlers())
		}
		'clock', 'Psr\\Clock\\ClockInterface' {
			return app.clock()
		}
		'logger' {
			return container_borrowed_object_value(app.logger(), C.vslim__log__logger_ce,
				vslimlogger_handlers())
		}
		'Psr\\Log\\LoggerInterface' {
			return container_borrowed_object_value(app.psr_logger(), C.vslim__log__psrlogger_ce,
				vslimpsrlogger_handlers())
		}
		'listener_provider', 'events.provider', 'Psr\\EventDispatcher\\ListenerProviderInterface' {
			return container_borrowed_object_value(app.listener_provider(), C.vslim__psr14__listenerprovider_ce,
				vslimpsr14listenerprovider_handlers())
		}
		'events', 'dispatcher', 'Psr\\EventDispatcher\\EventDispatcherInterface' {
			return container_borrowed_object_value(app.dispatcher(), C.vslim__psr14__eventdispatcher_ce,
				vslimpsr14eventdispatcher_handlers())
		}
		'cache', 'Psr\\SimpleCache\\CacheInterface' {
			return container_borrowed_object_value(app.cache(), C.vslim__psr16__cache_ce,
				vslimpsr16cache_handlers())
		}
		'cache.pool', 'Psr\\Cache\\CacheItemPoolInterface' {
			return container_borrowed_object_value(app.cache_pool(), C.vslim__psr6__cacheitempool_ce,
				vslimpsr6cacheitempool_handlers())
		}
		'http', 'http_client', 'Psr\\Http\\Client\\ClientInterface' {
			return container_borrowed_object_value(app.http_client(), C.vslim__psr18__client_ce,
				vslimpsr18client_handlers())
		}
		'database', 'db', 'VSlim\\Database\\Manager' {
			return container_borrowed_object_value(app.database(), C.vslim__database__manager_ce,
				vslimdatabasemanager_handlers())
		}
		else {}
	}
	return none
}

pub fn (mut c VSlimContainer) get_entry_or_throw(id string) vphp.RequestOwnedZBox {
	return c.get_entry(id) or {
		if err.msg().contains('not found') {
			throw_not_found(id)
		} else {
			throw_container_exception(err.msg())
		}
		return vphp.RequestOwnedZBox.new_null()
	}
}

fn throw_not_found(id string) {
	vphp.PhpException.raise_class('VSlim\\Container\\NotFoundException', 'Container entry "${id}" not found',
		0)
}

fn throw_container_exception(msg string) {
	vphp.PhpException.raise_class('VSlim\\Container\\ContainerException', msg, 0)
}

// VSlimContainer fields are automatically managed by the bridge lifecycle.
