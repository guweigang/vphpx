module vphp

fn class_registry_key(name string) string {
	return name.to_lower()
}

pub struct ClassMeta {
pub:
	name         string
	parents      []string
	methods      []string
	properties   []string
	constants    map[string]DynValue
	static_props map[string]DynValue
}

pub fn (meta ClassMeta) clone() ClassMeta {
	mut constants := map[string]DynValue{}
	for key, value in meta.constants {
		constants[key] = value.clone()
	}
	mut static_props := map[string]DynValue{}
	for key, value in meta.static_props {
		static_props[key] = value.clone()
	}
	return ClassMeta{
		name:         meta.name.clone()
		parents:      meta.parents.clone()
		methods:      meta.methods.clone()
		properties:   meta.properties.clone()
		constants:    constants
		static_props: static_props
	}
}

pub fn (meta ClassMeta) to_request_escapable() !ClassMeta {
	mut constants := map[string]DynValue{}
	for key, value in meta.constants {
		constants[key] = value.to_request_escapable()!
	}
	mut static_props := map[string]DynValue{}
	for key, value in meta.static_props {
		static_props[key] = value.to_request_escapable()!
	}
	return ClassMeta{
		name:         meta.name.clone()
		parents:      meta.parents.clone()
		methods:      meta.methods.clone()
		properties:   meta.properties.clone()
		constants:    constants
		static_props: static_props
	}
}

pub struct ClassRegistry {
mut:
	classes map[string]ClassMeta
}

pub fn ClassRegistry.new() ClassRegistry {
	return ClassRegistry{
		classes: map[string]ClassMeta{}
	}
}

pub fn (mut registry ClassRegistry) register(meta ClassMeta) ! {
	escapable := meta.to_request_escapable()!
	registry.classes[class_registry_key(meta.name)] = escapable
}

pub fn (registry &ClassRegistry) meta(name string) ?ClassMeta {
	if item := registry.classes[class_registry_key(name)] {
		return item.clone()
	}
	return none
}

pub fn (registry &ClassRegistry) has_class(name string) bool {
	return class_registry_key(name) in registry.classes
}

pub fn (registry &ClassRegistry) has_method(class_name string, method_name string) bool {
	meta := registry.meta(class_name) or { return false }
	lower_method := method_name.to_lower()
	for method in meta.methods {
		if method.to_lower() == lower_method {
			return true
		}
	}
	for parent in meta.parents {
		if registry.has_method(parent, method_name) {
			return true
		}
	}
	return false
}

pub fn (registry &ClassRegistry) has_property(class_name string, prop_name string) bool {
	meta := registry.meta(class_name) or { return false }
	for property in meta.properties {
		if property == prop_name {
			return true
		}
	}
	for parent in meta.parents {
		if registry.has_property(parent, prop_name) {
			return true
		}
	}
	return false
}

pub fn (registry &ClassRegistry) parent_name(class_name string) ?string {
	meta := registry.meta(class_name) or { return none }
	if meta.parents.len == 0 {
		return none
	}
	return meta.parents[0]
}

pub fn (registry &ClassRegistry) is_subclass_of(class_name string, parent_name string) bool {
	meta := registry.meta(class_name) or { return false }
	lower_parent := parent_name.to_lower()
	for parent in meta.parents {
		if parent.to_lower() == lower_parent || registry.is_subclass_of(parent, parent_name) {
			return true
		}
	}
	return false
}

pub fn (registry &ClassRegistry) constant(class_name string, const_name string) DynValue {
	meta := registry.meta(class_name) or { return DynValue.null() }
	if value := meta.constants[const_name] {
		return value.clone()
	}
	for parent in meta.parents {
		value := registry.constant(parent, const_name)
		if value.type != .null_ {
			return value
		}
	}
	return DynValue.null()
}

pub fn (registry &ClassRegistry) static_default(class_name string, prop_name string) DynValue {
	meta := registry.meta(class_name) or { return DynValue.null() }
	if value := meta.static_props[prop_name] {
		return value.clone()
	}
	for parent in meta.parents {
		value := registry.static_default(parent, prop_name)
		if value.type != .null_ {
			return value
		}
	}
	return DynValue.null()
}

pub struct StaticStore {
mut:
	props map[string]map[string]DynValue
}

pub fn StaticStore.new() StaticStore {
	return StaticStore{
		props: map[string]map[string]DynValue{}
	}
}

pub fn (mut store StaticStore) init_prop(class_name string, prop_name string, default_value DynValue) ! {
	key := class_registry_key(class_name)
	mut class_props := (store.props[key] or {
		map[string]DynValue{}
	}).clone()
	if prop_name !in class_props {
		class_props[prop_name] = default_value.to_request_escapable()!
		store.props[key] = class_props.clone()
	}
}

pub fn (store &StaticStore) get(class_name string, prop_name string) DynValue {
	key := class_registry_key(class_name)
	class_props := (store.props[key] or { return DynValue.null() }).clone()
	if value := class_props[prop_name] {
		return value.clone()
	}
	return DynValue.null()
}

pub fn (mut store StaticStore) set(class_name string, prop_name string, value DynValue) ! {
	key := class_registry_key(class_name)
	mut class_props := (store.props[key] or {
		map[string]DynValue{}
	}).clone()
	class_props[prop_name] = value.to_request_escapable()!
	store.props[key] = class_props.clone()
}

pub interface VNativeObjectLike {
mut:
	dispatch_method(method_name string, args []DynValue) ?DynValue
	dispatch_get_prop(prop_name string) ?DynValue
	dispatch_set_prop(prop_name string, val DynValue) bool
	has_method(method_name string) bool
	has_property(prop_name string) bool
}

pub struct VNativeObjectBase {
mut:
	props map[string]DynValue
}

pub fn VNativeObjectBase.new() VNativeObjectBase {
	return VNativeObjectBase{
		props: map[string]DynValue{}
	}
}

pub fn (mut base VNativeObjectBase) dispatch_method(method_name string, args []DynValue) ?DynValue {
	return none
}

pub fn (mut base VNativeObjectBase) dispatch_get_prop(prop_name string) ?DynValue {
	if value := base.props[prop_name] {
		return value.clone()
	}
	return none
}

pub fn (mut base VNativeObjectBase) dispatch_set_prop(prop_name string, val DynValue) bool {
	base.props[prop_name] = val.to_request_escapable() or { return false }
	return true
}

pub fn (mut base VNativeObjectBase) has_method(method_name string) bool {
	return false
}

pub fn (mut base VNativeObjectBase) has_property(prop_name string) bool {
	return prop_name in base.props
}

@[heap]
pub struct VNativeObject {
pub:
	class_name string
	parents    []string
mut:
	impl VNativeObjectLike
}

pub fn VNativeObject.new(class_name string, parents []string, impl VNativeObjectLike) VNativeObject {
	return VNativeObject{
		class_name: class_name
		parents:    parents.clone()
		impl:       impl
	}
}

pub fn VNativeObject.new_boxed(class_name string, parents []string, impl VNativeObjectLike) &VNativeObject {
	return &VNativeObject{
		class_name: class_name
		parents:    parents.clone()
		impl:       impl
	}
}

pub fn (obj &VNativeObject) clone_boxed() &VNativeObject {
	return VNativeObject.new_boxed(obj.class_name, obj.parents, obj.impl)
}

pub fn (mut obj VNativeObject) call(method_name string, args []DynValue) DynValue {
	return obj.impl.dispatch_method(method_name, args) or { DynValue.null() }
}

pub fn (mut obj VNativeObject) get_prop(prop_name string) DynValue {
	return obj.impl.dispatch_get_prop(prop_name) or { DynValue.null() }
}

pub fn (mut obj VNativeObject) set_prop(prop_name string, val DynValue) bool {
	return obj.impl.dispatch_set_prop(prop_name, val)
}

pub fn (mut obj VNativeObject) has_method(method_name string) bool {
	return obj.impl.has_method(method_name)
}

pub fn (mut obj VNativeObject) has_property(prop_name string) bool {
	return obj.impl.has_property(prop_name)
}
