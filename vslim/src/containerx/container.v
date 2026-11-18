module containerx

import registrationx
import vphp

#include "php_bridge.h"

@[vphp.PhpImplements(names: 'Psr\\Container\\ContainerExceptionInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Container\\ContainerException')]
@[vphp.PhpExtends(name: 'Exception')]
@[heap]
pub struct VSlimContainerException {}

@[vphp.PhpImplements(names: 'Psr\\Container\\NotFoundExceptionInterface')]
@[vphp.PhpExtends(name: 'VSlim\\Container\\ContainerException')]
@[vphp.PhpExportClass(name: 'VSlim\\Container\\NotFoundException')]
@[heap]
pub struct VSlimContainerNotFoundException {}

@[vphp.PhpImplements(names: 'Psr\\Container\\ContainerInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Container')]
@[heap]
pub struct VSlimContainer {
mut:
	entries   map[string]vphp.PhpValue    @[vphp.PhpIgnoreField]
	factories map[string]vphp.PhpCallable @[vphp.PhpIgnoreField]
	resolved  map[string]vphp.PhpValue    @[vphp.PhpIgnoreField]
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

@[vphp.PhpExportMethod(name: '')]
pub fn (mut c VSlimContainer) construct() &VSlimContainer {
	container_release_map(mut c.entries)
	container_release_factory_map(mut c.factories)
	container_release_map(mut c.resolved)
	c.entries = map[string]vphp.PhpValue{}
	c.factories = map[string]vphp.PhpCallable{}
	c.resolved = map[string]vphp.PhpValue{}
	return &c
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut c VSlimContainer) set(id string, value vphp.PhpValue) &VSlimContainer {
	c.replace_registration(id, .registration, ContainerRegistration{ entry: value.retain() })
	return &c
}

pub fn (mut c VSlimContainer) set_object(id string, value vphp.PhpObject) &VSlimContainer {
	mut boxed := value.to_value()
	defer {
		boxed.release()
	}
	return c.set(id, boxed)
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

@[vphp.PhpExportMethod(name: '')]
pub fn (mut c VSlimContainer) factory(id string, callable vphp.PhpCallable) &VSlimContainer {
	c.replace_registration(id, .registration, ContainerRegistration{ factory: callable.retain() })
	return &c
}

@[vphp.PhpExportMethod(name: '')]
pub fn (c &VSlimContainer) has(id string) bool {
	return id in c.entries || id in c.factories || id in c.resolved
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut c VSlimContainer) get(id string) vphp.PhpValue {
	return c.get_value_or_throw(id)
}

pub fn (mut c VSlimContainer) get_value(id string) !vphp.PhpValue {
	if id in c.resolved {
		resolved := c.resolved[id] or { return error('entry "${id}" not found') }
		track_service_state(resolved)
		return resolved.owned()
	}
	if id in c.entries {
		entry := c.entries[id] or { return error('entry "${id}" not found') }
		track_service_state(entry)
		return entry.owned()
	}
	if id in c.factories {
		factory_owned := c.factories[id] or { return error('entry "${id}" not found') }
		mut res := c.invoke_container_factory(factory_owned)
		defer {
			res.release()
		}
		if vphp.has_exception() {
			return error('factory "${id}" threw an exception')
		}
		if !res.is_valid() {
			return error('factory "${id}" returned invalid value')
		}
		c.replace_registration(id, .resolution, ContainerRegistration{ resolved: res.retain() })
		track_service_state(res)
		return res.owned()
	}
	return error('entry "${id}" not found')
}

fn (c &VSlimContainer) invoke_container_factory(factory vphp.PhpCallable) vphp.PhpValue {
	mut scope := registrationx.begin_registration_scope()
	defer {
		scope.finish()
	}
	c.snapshot_services(mut scope)
	return factory.invoke()
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
	if vphp.has_exception() {
		return error('container service resolution failed')
	}
	mut created_obj := instantiate_container_service(id)!
	mut created_value := created_obj.take_value()
	c.set(id, created_value)
	out := created_value.owned()
	created_value.release()
	return ContainerResolvedService{
		value:   out
		created: true
	}
}

fn instantiate_container_service(id string) !vphp.PhpObject {
	mut scope := registrationx.begin_registration_scope()
	defer {
		scope.finish()
	}
	class := vphp.PhpClass.named(id)
	if !class.exists() {
		return error('container service not found')
	}
	mut instance := class.construct() or {
		return error('class "${id}" could not be instantiated')
	}
	if vphp.has_exception() {
		instance.release()
		return error('class "${id}" constructor threw an exception')
	}
	return instance
}

pub fn (mut c VSlimContainer) get_value_or_throw(id string) vphp.PhpValue {
	return c.get_value(id) or {
		if !vphp.has_exception() {
			if err.msg().contains('not found') {
				throw_not_found(id)
			} else {
				throw_container_exception(err.msg())
			}
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
