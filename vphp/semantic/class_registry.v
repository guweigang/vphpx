module semantic

pub struct ClassMeta {
pub:
	name       string
	parents    []string
	methods    []string
	properties []string
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

pub fn (mut registry ClassRegistry) register(meta ClassMeta) {
	registry.classes[meta.name] = meta
}

pub fn (registry &ClassRegistry) meta(name string) ?ClassMeta {
	if item := registry.classes[name] {
		return item
	}
	return none
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

pub struct StaticStore {
mut:
	props map[string]map[string]Value
}

pub fn StaticStore.new() StaticStore {
	return StaticStore{
		props: map[string]map[string]Value{}
	}
}

pub fn (mut store StaticStore) init_prop(class_name string, prop_name string, default_value Value) {
	if class_name !in store.props {
		store.props[class_name] = map[string]Value{}
	}
	if prop_name !in store.props[class_name] {
		store.props[class_name][prop_name] = default_value.clone()
	}
}

pub fn (store &StaticStore) get(class_name string, prop_name string) Value {
	if class_name in store.props {
		return store.props[class_name][prop_name] or { null_value() }.clone()
	}
	return null_value()
}

pub fn (mut store StaticStore) set(class_name string, prop_name string, value Value) {
	if class_name !in store.props {
		store.props[class_name] = map[string]Value{}
	}
	store.props[class_name][prop_name] = value.clone()
}

pub interface ObjectLike {
mut:
	dispatch_method(method_name string, args []Value) ?Value
	dispatch_get_prop(prop_name string) ?Value
	dispatch_set_prop(prop_name string, val Value) bool
	has_method(method_name string) bool
	has_property(prop_name string) bool
}

pub struct ObjectBase {
mut:
	props map[string]Value
}

pub fn ObjectBase.new() ObjectBase {
	return ObjectBase{
		props: map[string]Value{}
	}
}

pub fn (mut base ObjectBase) dispatch_method(method_name string, args []Value) ?Value {
	return none
}

pub fn (mut base ObjectBase) dispatch_get_prop(prop_name string) ?Value {
	if value := base.props[prop_name] {
		return value.clone()
	}
	return none
}

pub fn (mut base ObjectBase) dispatch_set_prop(prop_name string, val Value) bool {
	base.props[prop_name] = val.clone()
	return true
}

pub fn (mut base ObjectBase) has_method(method_name string) bool {
	return false
}

pub fn (mut base ObjectBase) has_property(prop_name string) bool {
	return prop_name in base.props
}

@[heap]
pub struct Object {
pub:
	class_name string
	parents    []string
mut:
	impl ObjectLike
}

pub fn Object.new(class_name string, parents []string, impl ObjectLike) Object {
	return Object{
		class_name: class_name
		parents:    parents.clone()
		impl:       impl
	}
}

pub fn Object.new_boxed(class_name string, parents []string, impl ObjectLike) &Object {
	mut obj := &Object{
		class_name: class_name
		parents:    parents.clone()
		impl:       impl
	}
	return obj
}

pub fn (obj &Object) clone_boxed() &Object {
	return Object.new_boxed(obj.class_name, obj.parents, obj.impl)
}

pub fn (mut obj Object) call(method_name string, args []Value) Value {
	return obj.impl.dispatch_method(method_name, args) or { null_value() }
}

pub fn (mut obj Object) get_prop(prop_name string) Value {
	return obj.impl.dispatch_get_prop(prop_name) or { null_value() }
}

pub fn (mut obj Object) set_prop(prop_name string, val Value) bool {
	return obj.impl.dispatch_set_prop(prop_name, val)
}

pub fn (mut obj Object) has_method(method_name string) bool {
	return obj.impl.has_method(method_name)
}

pub fn (mut obj Object) has_property(prop_name string) bool {
	return obj.impl.has_property(prop_name)
}
