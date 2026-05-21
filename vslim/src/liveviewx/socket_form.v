module liveviewx

import vphp

@[php_class: 'VSlim\\Live\\Socket']
@[heap]
pub struct VSlimLiveSocket {
pub mut:
	id          string
	connected   bool
	redirect_to string @[php_prop: redirectTo]
	navigate_to string @[php_prop: navigateTo]
	raw_path    string @[php_prop: rawPath]
	root_id     string @[php_prop: rootId]
	assigns     map[string]string
	patches     []map[string]string
	events      []map[string]string
	flashes     []map[string]string
	pubsub      []map[string]string
}

@[php_method]
pub fn (mut socket VSlimLiveSocket) construct() &VSlimLiveSocket {
	socket.id = ''
	socket.connected = false
	socket.redirect_to = ''
	socket.navigate_to = ''
	socket.raw_path = '/'
	socket.root_id = ''
	socket.assigns = map[string]string{}
	socket.patches = []map[string]string{}
	socket.events = []map[string]string{}
	socket.flashes = []map[string]string{}
	socket.pubsub = []map[string]string{}
	return &socket
}

pub fn VSlimLiveSocket.new_object() !vphp.PhpObject {
	return vphp.PhpClass.named('VSlim\\Live\\Socket').construct() or {
		error('Live socket bootstrap failed')
	}
}

@[php_method: 'setId']
pub fn (mut socket VSlimLiveSocket) set_id(id string) &VSlimLiveSocket {
	socket.id = id.trim_space()
	return &socket
}

@[php_method]
pub fn (socket &VSlimLiveSocket) id() string {
	return socket.id
}

@[php_method: 'setConnected']
pub fn (mut socket VSlimLiveSocket) set_connected(connected bool) &VSlimLiveSocket {
	socket.connected = connected
	return &socket
}

@[php_method]
pub fn (socket &VSlimLiveSocket) connected() bool {
	return socket.connected
}

@[php_arg_name: 'raw_path=rawPath']
@[php_method: 'setTarget']
pub fn (mut socket VSlimLiveSocket) set_target(raw_path string) &VSlimLiveSocket {
	socket.raw_path = normalize_target(raw_path)
	return &socket
}

@[php_method]
pub fn (socket &VSlimLiveSocket) target() string {
	return socket.raw_path
}

@[php_arg_name: 'root_id=rootId']
@[php_method: 'setRootId']
pub fn (mut socket VSlimLiveSocket) set_root_id(root_id string) &VSlimLiveSocket {
	socket.root_id = root_id.trim_space()
	return &socket
}

@[php_method: 'rootId']
pub fn (socket &VSlimLiveSocket) root_id() string {
	return socket.root_id
}

@[php_method]
pub fn (mut socket VSlimLiveSocket) assign(key string, value vphp.PhpValue) &VSlimLiveSocket {
	name := key.trim_space()
	if name == '' {
		return &socket
	}
	socket.assigns[name] = value_string(value)
	return &socket
}

pub fn (mut socket VSlimLiveSocket) assign_string(key string, value vphp.PhpString) &VSlimLiveSocket {
	name := key.trim_space()
	if name == '' {
		return &socket
	}
	socket.assigns[name] = value.value()
	return &socket
}

@[php_method: 'assignMany']
pub fn (mut socket VSlimLiveSocket) assign_many(values vphp.PhpArray) &VSlimLiveSocket {
	for key in values.assoc_keys() {
		socket.assign(key, values.value_at(key))
	}
	return &socket
}

@[php_method: 'assignForm']
pub fn (mut socket VSlimLiveSocket) assign_form(values vphp.PhpArray) &VSlimLiveSocket {
	for key in values.assoc_keys() {
		name := key.trim_space()
		if name == '' {
			continue
		}
		value := values.value_at(key)
		if value.is_array() {
			socket.assigns[name] = form_value_string(value)
			continue
		}
		socket.assign(name, value)
	}
	return &socket
}

@[php_method: 'resetForm']
pub fn (mut socket VSlimLiveSocket) reset_form(values vphp.PhpArray) &VSlimLiveSocket {
	socket.clear_errors()
	return socket.assign_form(values)
}

@[php_method]
pub fn (mut socket VSlimLiveSocket) forget(key string) &VSlimLiveSocket {
	name := key.trim_space()
	if name == '' {
		return &socket
	}
	socket.assigns.delete(name)
	return &socket
}

@[php_method: 'forgetInput']
pub fn (mut socket VSlimLiveSocket) forget_input(field string) &VSlimLiveSocket {
	return socket.forget(field)
}

@[php_method: 'forgetInputs']
pub fn (mut socket VSlimLiveSocket) forget_inputs(fields vphp.PhpArray) &VSlimLiveSocket {
	for field in field_names(fields) {
		socket.forget(field)
	}
	return &socket
}

@[php_method: 'clearAssigns']
pub fn (mut socket VSlimLiveSocket) clear_assigns() &VSlimLiveSocket {
	socket.assigns = map[string]string{}
	return &socket
}

fn live_component_state_key(component_id string, field string) string {
	id := component_id.trim_space()
	name := field.trim_space()
	if id == '' || name == '' {
		return ''
	}
	return '_component_${id}_${name}'
}

@[php_arg_name: 'component_id=componentId']
@[php_method: 'assignComponentState']
pub fn (mut socket VSlimLiveSocket) assign_component_state(component_id string, field string, value vphp.PhpValue) &VSlimLiveSocket {
	key := live_component_state_key(component_id, field)
	if key == '' {
		return &socket
	}
	socket.assigns[key] = value_string(value)
	return &socket
}

@[php_arg_name: 'component_id=componentId']
@[php_method: 'componentState']
pub fn (socket &VSlimLiveSocket) component_state(component_id string, field string) string {
	key := live_component_state_key(component_id, field)
	return if key == '' { '' } else { socket.get(key) }
}

@[php_arg_name: 'component_id=componentId']
@[php_method: 'componentStateOr']
pub fn (socket &VSlimLiveSocket) component_state_or(component_id string, field string, fallback string) string {
	value := socket.component_state(component_id, field)
	return if value == '' { fallback } else { value }
}

@[php_arg_name: 'component_id=componentId']
@[php_method: 'clearComponentState']
pub fn (mut socket VSlimLiveSocket) clear_component_state(component_id string, field string) &VSlimLiveSocket {
	key := live_component_state_key(component_id, field)
	if key == '' {
		return &socket
	}
	socket.assigns.delete(key)
	return &socket
}

// Low-level error helpers remain available for direct socket manipulation,
// but new code should usually prefer socket.form(...)->validate(...).
@[php_method: 'assignError']
pub fn (mut socket VSlimLiveSocket) assign_error(field string, message string) &VSlimLiveSocket {
	key := error_key(field)
	if key == '' {
		return &socket
	}
	socket.assigns[key] = message.trim_space()
	return &socket
}

@[php_method: 'assignErrors']
pub fn (mut socket VSlimLiveSocket) assign_errors(values vphp.PhpArray) &VSlimLiveSocket {
	for key in values.assoc_keys() {
		field := key.trim_space()
		if field == '' {
			continue
		}
		socket.assign_error(field, value_string(values[key]))
	}
	return &socket
}

@[php_method: 'clearError']
pub fn (mut socket VSlimLiveSocket) clear_error(field string) &VSlimLiveSocket {
	key := error_key(field)
	if key == '' {
		return &socket
	}
	socket.assigns.delete(key)
	return &socket
}

@[php_method: 'clearErrors']
pub fn (mut socket VSlimLiveSocket) clear_errors() &VSlimLiveSocket {
	for key in socket.assigns.keys() {
		if key.starts_with('error_') {
			socket.assigns.delete(key)
		}
	}
	return &socket
}

@[php_method]
pub fn (socket &VSlimLiveSocket) input(field string) string {
	return socket.get(field)
}

@[php_method: 'inputOr']
pub fn (socket &VSlimLiveSocket) input_or(field string, fallback string) string {
	value := socket.input(field)
	return if value == '' { fallback } else { value }
}

// Compatibility aliases for older form-oriented examples.
// Prefer input()/input_or() in new code.
@[php_method]
pub fn (socket &VSlimLiveSocket) old(field string) string {
	return socket.input(field)
}

@[php_method: 'oldOr']
pub fn (socket &VSlimLiveSocket) old_or(field string, fallback string) string {
	return socket.input_or(field, fallback)
}

@[php_method]
pub fn (socket &VSlimLiveSocket) error(field string) string {
	key := error_key(field)
	return if key == '' { '' } else { socket.get(key) }
}

@[php_method: 'hasError']
pub fn (socket &VSlimLiveSocket) has_error(field string) bool {
	key := error_key(field)
	return key != '' && socket.has(key)
}

@[php_method]
pub fn (socket &VSlimLiveSocket) form(name string) &VSlimLiveForm {
	return &VSlimLiveForm{
		name:             name.trim_space()
		socket_ref:       socket
		fields:           []string{}
		last_error_count: 0
		validated:        false
	}
}

@[php_method]
pub fn (socket &VSlimLiveSocket) get(key string) string {
	return socket.assigns[key.trim_space()] or { '' }
}

@[php_method]
pub fn (socket &VSlimLiveSocket) has(key string) bool {
	name := key.trim_space()
	return name != '' && name in socket.assigns
}

@[php_method]
pub fn (socket &VSlimLiveSocket) assigns() map[string]string {
	return socket.assigns.clone()
}

pub fn VSlimLiveSocket.bound_result() &VSlimLiveSocket {
	mut socket := &VSlimLiveSocket{}
	socket.construct()
	return socket
}
