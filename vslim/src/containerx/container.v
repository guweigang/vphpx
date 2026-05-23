module containerx

import vphp

#include "php_bridge.h"

@[php_implements: 'Psr\\Container\\ContainerExceptionInterface']
@[php_class: 'VSlim\\Container\\ContainerException']
@[php_extends: 'Exception']
@[heap]
pub struct VSlimContainerException {}

@[php_implements: 'Psr\\Container\\NotFoundExceptionInterface']
@[php_extends: 'VSlim\\Container\\ContainerException']
@[php_class: 'VSlim\\Container\\NotFoundException']
@[heap]
pub struct VSlimContainerNotFoundException {}

@[php_implements: 'Psr\\Container\\ContainerInterface']
@[php_class: 'VSlim\\Container']
@[heap]
pub struct VSlimContainer {
mut:
	entries   map[string]vphp.PhpValue    @[php_ignore]
	factories map[string]vphp.PhpCallable @[php_ignore]
	resolved  map[string]vphp.PhpValue    @[php_ignore]
}

pub struct ContainerResolvedService {
pub:
	value   vphp.PhpValue
	created bool
}

pub fn VSlimContainer.new() &VSlimContainer {
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

pub fn (mut c VSlimContainer) set_object(id string, value vphp.PhpObject) &VSlimContainer {
	c.release_entry_key(id)
	mut retained := value.retain()
	c.entries[id] = retained.to_value()
	retained.release()
	c.release_factory_key(id)
	c.release_resolved_key(id)
	return &c
}

pub fn (mut c VSlimContainer) set_borrowed_object[T](id string, object &T) &VSlimContainer {
	mut value := vphp.bind_borrowed_object_value[T](object)
	c.set(id, value)
	value.release()
	return &c
}

pub fn (mut c VSlimContainer) set_owned_object[T](id string, object &T) &VSlimContainer {
	mut value := vphp.bind_owned_object_value[T](object)
	c.set(id, value)
	value.release()
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
	return id in c.entries || id in c.factories || id in c.resolved
}

@[php_method]
pub fn (mut c VSlimContainer) get(id string) vphp.PhpValue {
	return c.get_value_or_throw(id)
}

pub fn (mut c VSlimContainer) get_value(id string) !vphp.PhpValue {
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

pub fn (mut c VSlimContainer) resolve_or_autowire_class(id string) !ContainerResolvedService {
	if id == '' {
		return error('empty service id')
	}
	if resolved := c.get_value(id) {
		return ContainerResolvedService{
			value:   resolved
			created: false
		}
	}
	if !vphp.PhpClass.named(id).exists() {
		return error('container service not found')
	}
	mut created_obj := vphp.PhpClass.named(id).construct() or {
		return error('class "${id}" could not be instantiated')
	}
	mut created_value := created_obj.take_value()
	c.set(id, created_value)
	out := created_value.owned()
	created_value.release()
	return ContainerResolvedService{
		value:   out
		created: true
	}
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

fn throw_not_found(id string) {
	vphp.PhpException.raise_class('VSlim\\Container\\NotFoundException',
		'Container entry "${id}" not found', 0)
}

fn throw_container_exception(msg string) {
	vphp.PhpException.raise_class('VSlim\\Container\\ContainerException', msg, 0)
}

// VSlimContainer fields are automatically managed by the bridge lifecycle.
