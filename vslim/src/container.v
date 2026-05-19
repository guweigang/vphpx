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
	entries   map[string]vphp.PhpValue    @[php_ignore]
	factories map[string]vphp.PhpCallable @[php_ignore]
	resolved  map[string]vphp.PhpValue    @[php_ignore]
	app_ref   &VSlimApp = unsafe { nil }                   @[php_ignore]
}

fn VSlimContainer.new() &VSlimContainer {
	return &VSlimContainer{
		entries:   map[string]vphp.PhpValue{}
		factories: map[string]vphp.PhpCallable{}
		resolved:  map[string]vphp.PhpValue{}
	}
}

fn container_release_map(mut values map[string]vphp.PhpValue) {
	for _, entry in values {
		mut value := entry
		value.release()
	}
	values.clear()
}

fn container_release_factory_map(mut values map[string]vphp.PhpCallable) {
	for _, entry in values {
		mut owned := entry
		owned.release()
	}
	values.clear()
}

fn (mut c VSlimContainer) release_entry_key(id string) {
	if id in c.entries {
		mut entry := c.entries[id] or { vphp.PhpValue.invalid() }
		entry.release()
		c.entries.delete(id)
	}
}

fn (mut c VSlimContainer) release_factory_key(id string) {
	if id in c.factories {
		mut factory := c.factories[id] or { vphp.PhpCallable.invalid() }
		factory.release()
		c.factories.delete(id)
	}
}

fn (mut c VSlimContainer) release_resolved_key(id string) {
	if id in c.resolved {
		mut resolved := c.resolved[id] or { vphp.PhpValue.invalid() }
		resolved.release()
		c.resolved.delete(id)
	}
}

@[php_method]
pub fn (mut c VSlimContainer) construct() &VSlimContainer {
	container_release_map(mut c.entries)
	container_release_factory_map(mut c.factories)
	container_release_map(mut c.resolved)
	c.entries = map[string]vphp.PhpValue{}
	c.factories = map[string]vphp.PhpCallable{}
	c.resolved = map[string]vphp.PhpValue{}
	return &c
}

@[php_method]
pub fn (mut c VSlimContainer) set(id string, value vphp.PhpValue) &VSlimContainer {
	c.release_entry_key(id)
	c.entries[id] = value.retain()
	c.release_factory_key(id)
	c.release_resolved_key(id)
	return &c
}

fn (mut c VSlimContainer) set_object(id string, value vphp.PhpObject) &VSlimContainer {
	c.release_entry_key(id)
	mut retained := value.retain()
	c.entries[id] = retained.to_value()
	retained.release()
	c.release_factory_key(id)
	c.release_resolved_key(id)
	return &c
}

@[php_method]
pub fn (mut c VSlimContainer) factory(id string, callable vphp.PhpCallable) &VSlimContainer {
	c.release_factory_key(id)
	c.factories[id] = callable.retain()
	c.release_entry_key(id)
	c.release_resolved_key(id)
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
pub fn (mut c VSlimContainer) get(id string) vphp.PhpValue {
	return c.get_value_or_throw(id)
}

pub fn (mut c VSlimContainer) get_value(id string) !vphp.PhpValue {
	if native := c.get_native_service(id) {
		return native
	}
	if id in c.resolved {
		resolved := c.resolved[id] or { return error('entry "${id}" not found') }
		return resolved.owned()
	}
	if id in c.entries {
		entry := c.entries[id] or { return error('entry "${id}" not found') }
		return entry.owned()
	}
	if id in c.factories {
		factory_owned := c.factories[id] or { return error('entry "${id}" not found') }
		mut res := factory_owned.invoke()
		if !res.is_valid() {
			return error('factory "${id}" returned invalid value')
		}
		c.release_resolved_key(id)
		c.resolved[id] = res.retain()
		return res.owned()
	}
	return error('entry "${id}" not found')
}

pub fn (mut c VSlimContainer) get_value_or_throw(id string) vphp.PhpValue {
	return c.get_value(id) or {
		if err.msg().contains('not found') {
			throw_not_found(id)
		} else {
			throw_container_exception(err.msg())
		}
		vphp.PhpValue.null()
	}
}

pub fn (c &VSlimContainer) has_native_service(id string) bool {
	app := c.effective_app()
	return app != unsafe { nil }
		&& id.trim_space() in ['config', 'clock', 'Psr\\Clock\\ClockInterface', 'logger', 'Psr\\Log\\LoggerInterface', 'listener_provider', 'events.provider', 'Psr\\EventDispatcher\\ListenerProviderInterface', 'events', 'dispatcher', 'Psr\\EventDispatcher\\EventDispatcherInterface', 'cache', 'Psr\\SimpleCache\\CacheInterface', 'cache.pool', 'Psr\\Cache\\CacheItemPoolInterface', 'http', 'http_client', 'Psr\\Http\\Client\\ClientInterface']
}

fn (c &VSlimContainer) effective_app() &VSlimApp {
	runtime := current_runtime_dispatch_app()
	if runtime != unsafe { nil } {
		return runtime
	}
	return c.app_ref
}

pub fn (mut c VSlimContainer) get_native_service(id string) ?vphp.PhpValue {
	mut app := c.effective_app()
	if app == unsafe { nil } {
		return none
	}
	match id.trim_space() {
		'config' {
			return app.config().bind_php_object_value()
		}
		'clock', 'Psr\\Clock\\ClockInterface' {
			mut clock := app.clock().owned()
			return clock.take_value()
		}
		'logger' {
			return app.logger().bind_php_object_value()
		}
		'Psr\\Log\\LoggerInterface' {
			return app.psr_logger().bind_php_object_value()
		}
		'listener_provider', 'events.provider', 'Psr\\EventDispatcher\\ListenerProviderInterface' {
			return app.listener_provider().bind_php_object_value()
		}
		'events', 'dispatcher', 'Psr\\EventDispatcher\\EventDispatcherInterface' {
			return app.dispatcher().bind_php_object_value()
		}
		'cache', 'Psr\\SimpleCache\\CacheInterface' {
			return app.cache().bind_php_object_value()
		}
		'cache.pool', 'Psr\\Cache\\CacheItemPoolInterface' {
			return app.cache_pool().bind_php_object_value()
		}
		'http', 'http_client', 'Psr\\Http\\Client\\ClientInterface' {
			return app.http_client().bind_php_object_value()
		}
		'database', 'db', 'VSlim\\Database\\Manager' {
			return app.database().bind_php_object_value()
		}
		else {}
	}

	return none
}

fn throw_not_found(id string) {
	vphp.PhpException.raise_class('VSlim\\Container\\NotFoundException',
		'Container entry "${id}" not found', 0)
}

fn throw_container_exception(msg string) {
	vphp.PhpException.raise_class('VSlim\\Container\\ContainerException', msg, 0)
}

// VSlimContainer fields are automatically managed by the bridge lifecycle.
