module main

import vphp

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
	socket.raw_path = live_normalize_target(raw_path)
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
	socket.assigns[name] = live_value_string(value)
	return &socket
}

fn (mut socket VSlimLiveSocket) assign_string(key string, value vphp.PhpString) &VSlimLiveSocket {
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
			socket.assigns[name] = live_form_value_string(value)
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
	for field in live_field_names(fields) {
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
	socket.assigns[key] = live_value_string(value)
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
	key := live_error_key(field)
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
		socket.assign_error(field, live_value_string(values[key]))
	}
	return &socket
}

@[php_method: 'clearError']
pub fn (mut socket VSlimLiveSocket) clear_error(field string) &VSlimLiveSocket {
	key := live_error_key(field)
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
	key := live_error_key(field)
	return if key == '' { '' } else { socket.get(key) }
}

@[php_method: 'hasError']
pub fn (socket &VSlimLiveSocket) has_error(field string) bool {
	key := live_error_key(field)
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
pub fn (form &VSlimLiveForm) name() string {
	return form.name
}

@[php_method]
pub fn (form &VSlimLiveForm) available() bool {
	return !isnil(form.socket_ref)
}

@[php_method]
pub fn (mut form VSlimLiveForm) fill(values vphp.PhpArray) &VSlimLiveForm {
	if isnil(form.socket_ref) {
		return &form
	}
	form.track_fields(values)
	unsafe {
		mut socket := &VSlimLiveSocket(form.socket_ref)
		socket.assign_form(values)
	}
	return &form
}

@[php_method]
pub fn (mut form VSlimLiveForm) reset(values vphp.PhpArray) &VSlimLiveForm {
	if isnil(form.socket_ref) {
		return &form
	}
	form.track_fields(values)
	unsafe {
		mut socket := &VSlimLiveSocket(form.socket_ref)
		socket.reset_form(values)
	}
	form.last_error_count = 0
	form.validated = false
	return &form
}

@[php_method]
pub fn (mut form VSlimLiveForm) validate(validator vphp.PhpValue) &VSlimLiveForm {
	form.validated = true
	form.last_error_count = 0
	if isnil(form.socket_ref) {
		return &form
	}
	unsafe {
		mut socket := &VSlimLiveSocket(form.socket_ref)
		socket.clear_errors()
		mut errors := vphp.PhpValue.null()
		if validator.is_valid() && !validator.is_null() && !validator.is_undef() {
			if callable := validator.as_callable() {
				mut result := callable.invoke(form.data())
				errors = result.owned()
			} else if validator.is_array() {
				errors = validator.owned()
			}
		}
		defer {
			errors.release()
		}
		if errors.is_valid() && !errors.is_null() && !errors.is_undef() && errors.is_array() {
			errors_arr := errors.as_array() or { vphp.PhpArray.empty() }
			socket.assign_errors(errors_arr)
			form.last_error_count = errors_arr.assoc_keys().len
		}
	}
	return &form
}

@[php_method]
pub fn (mut form VSlimLiveForm) errors(values vphp.PhpArray) &VSlimLiveForm {
	if isnil(form.socket_ref) {
		return &form
	}
	unsafe {
		mut socket := &VSlimLiveSocket(form.socket_ref)
		socket.assign_errors(values)
	}
	form.last_error_count = values.assoc_keys().len
	form.validated = true
	return &form
}

@[php_method: 'clearErrors']
pub fn (mut form VSlimLiveForm) clear_errors() &VSlimLiveForm {
	if isnil(form.socket_ref) {
		return &form
	}
	unsafe {
		mut socket := &VSlimLiveSocket(form.socket_ref)
		socket.clear_errors()
	}
	form.last_error_count = 0
	return &form
}

@[php_method: 'clearError']
pub fn (mut form VSlimLiveForm) clear_error(field string) &VSlimLiveForm {
	if isnil(form.socket_ref) {
		return &form
	}
	unsafe {
		mut socket := &VSlimLiveSocket(form.socket_ref)
		socket.clear_error(field)
	}
	return &form
}

@[php_method]
pub fn (mut form VSlimLiveForm) forget(field string) &VSlimLiveForm {
	if isnil(form.socket_ref) {
		return &form
	}
	unsafe {
		mut socket := &VSlimLiveSocket(form.socket_ref)
		socket.forget_input(field)
	}
	return &form
}

@[php_method: 'forgetMany']
pub fn (mut form VSlimLiveForm) forget_many(fields vphp.PhpArray) &VSlimLiveForm {
	if isnil(form.socket_ref) {
		return &form
	}
	unsafe {
		mut socket := &VSlimLiveSocket(form.socket_ref)
		socket.forget_inputs(fields)
	}
	return &form
}

@[php_method]
pub fn (form &VSlimLiveForm) input(field string) string {
	if isnil(form.socket_ref) {
		return ''
	}
	return form.socket_ref.input(field)
}

@[php_method: 'inputOr']
pub fn (form &VSlimLiveForm) input_or(field string, fallback string) string {
	value := form.input(field)
	return if value == '' { fallback } else { value }
}

@[php_method]
pub fn (form &VSlimLiveForm) error(field string) string {
	if isnil(form.socket_ref) {
		return ''
	}
	return form.socket_ref.error(field)
}

@[php_method: 'hasError']
pub fn (form &VSlimLiveForm) has_error(field string) bool {
	return !isnil(form.socket_ref) && form.socket_ref.has_error(field)
}

@[php_method]
pub fn (form &VSlimLiveForm) valid() bool {
	return form.validated && form.last_error_count == 0
}

@[php_method]
pub fn (form &VSlimLiveForm) invalid() bool {
	return form.last_error_count > 0
}

@[php_method: 'errorCount']
pub fn (form &VSlimLiveForm) error_count() int {
	return form.last_error_count
}

@[php_method]
pub fn (form &VSlimLiveForm) data() vphp.PhpArray {
	mut out := vphp.PhpArray.new()
	if isnil(form.socket_ref) {
		return out
	}
	for field in form.field_names() {
		out.string(field, form.socket_ref.input(field))
	}
	return out
}

fn (mut form VSlimLiveForm) track_fields(values vphp.PhpArray) {
	if !values.is_valid() {
		return
	}
	for key in values.assoc_keys() {
		field := key.trim_space()
		if field == '' || field in form.fields {
			continue
		}
		form.fields << field
	}
}

fn (form &VSlimLiveForm) field_names() []string {
	return form.fields.clone()
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

@[php_arg_name: 'target_id=targetId']
@[php_method]
pub fn (mut socket VSlimLiveSocket) patch(target_id string, html string) &VSlimLiveSocket {
	id := target_id.trim_space()
	if id == '' {
		return &socket
	}
	socket.patches << {
		'op':   'replace'
		'id':   id
		'html': html
	}
	return &socket
}

@[php_arg_name: 'target_id=targetId']
@[php_method]
pub fn (mut socket VSlimLiveSocket) append(target_id string, html string) &VSlimLiveSocket {
	id := target_id.trim_space()
	if id == '' {
		return &socket
	}
	socket.patches << {
		'op':   'append'
		'id':   id
		'html': html
	}
	return &socket
}

@[php_arg_name: 'target_id=targetId']
@[php_method]
pub fn (mut socket VSlimLiveSocket) prepend(target_id string, html string) &VSlimLiveSocket {
	id := target_id.trim_space()
	if id == '' {
		return &socket
	}
	socket.patches << {
		'op':   'prepend'
		'id':   id
		'html': html
	}
	return &socket
}

@[php_arg_name: 'target_id=targetId']
@[php_method: 'setText']
pub fn (mut socket VSlimLiveSocket) set_text(target_id string, text string) &VSlimLiveSocket {
	id := target_id.trim_space()
	if id == '' {
		return &socket
	}
	socket.patches << {
		'op':   'set_text'
		'id':   id
		'text': text
	}
	return &socket
}

@[php_arg_name: 'target_id=targetId']
@[php_method: 'setAttr']
pub fn (mut socket VSlimLiveSocket) set_attr(target_id string, name string, value string) &VSlimLiveSocket {
	id := target_id.trim_space()
	attr_name := name.trim_space()
	if id == '' || attr_name == '' {
		return &socket
	}
	socket.patches << {
		'op':    'set_attr'
		'id':    id
		'name':  attr_name
		'value': value
	}
	return &socket
}

@[php_arg_name: 'target_id=targetId']
@[php_method]
pub fn (mut socket VSlimLiveSocket) remove(target_id string) &VSlimLiveSocket {
	id := target_id.trim_space()
	if id == '' {
		return &socket
	}
	socket.patches << {
		'op': 'remove'
		'id': id
	}
	return &socket
}

@[php_method]
pub fn (socket &VSlimLiveSocket) patches() []map[string]string {
	return clone_live_entries(socket.patches)
}

@[php_method: 'clearPatches']
pub fn (mut socket VSlimLiveSocket) clear_patches() &VSlimLiveSocket {
	socket.patches = []map[string]string{}
	return &socket
}

@[php_method: 'pushEvent']
pub fn (mut socket VSlimLiveSocket) push_event(event string, payload string) &VSlimLiveSocket {
	name := event.trim_space()
	if name == '' {
		return &socket
	}
	socket.events << {
		'event':   name
		'payload': payload
	}
	return &socket
}

@[php_method]
pub fn (socket &VSlimLiveSocket) events() []map[string]string {
	return clone_live_entries(socket.events)
}

@[php_method: 'clearEvents']
pub fn (mut socket VSlimLiveSocket) clear_events() &VSlimLiveSocket {
	socket.events = []map[string]string{}
	return &socket
}

@[php_method]
pub fn (mut socket VSlimLiveSocket) flash(kind string, message string) &VSlimLiveSocket {
	level := kind.trim_space()
	body := message.trim_space()
	if level == '' || body == '' {
		return &socket
	}
	socket.flashes << {
		'kind':    level
		'message': body
	}
	return &socket
}

@[php_method]
pub fn (socket &VSlimLiveSocket) flashes() []map[string]string {
	return clone_live_entries(socket.flashes)
}

@[php_method: 'clearFlashes']
pub fn (mut socket VSlimLiveSocket) clear_flashes() &VSlimLiveSocket {
	socket.flashes = []map[string]string{}
	return &socket
}

@[php_method: 'joinTopic']
pub fn (mut socket VSlimLiveSocket) join_topic(room string) &VSlimLiveSocket {
	topic := room.trim_space()
	if topic == '' {
		return &socket
	}
	socket.pubsub << {
		'op':   'join'
		'room': topic
	}
	return &socket
}

@[php_method: 'leaveTopic']
pub fn (mut socket VSlimLiveSocket) leave_topic(room string) &VSlimLiveSocket {
	topic := room.trim_space()
	if topic == '' {
		return &socket
	}
	socket.pubsub << {
		'op':   'leave'
		'room': topic
	}
	return &socket
}

@[php_arg_name: 'include_self=includeSelf']
@[php_method: 'broadcastInfo']
pub fn (mut socket VSlimLiveSocket) broadcast_info(room string, event string, payload vphp.PhpValue, include_self bool) &VSlimLiveSocket {
	topic := room.trim_space()
	name := event.trim_space()
	if topic == '' || name == '' {
		return &socket
	}
	socket.pubsub << {
		'op':           'broadcast_info'
		'room':         topic
		'event':        name
		'payload':      live_json_payload(payload)
		'include_self': if include_self { 'true' } else { 'false' }
	}
	return &socket
}

@[php_method: 'pubsubCommands']
pub fn (socket &VSlimLiveSocket) pubsub_commands() []map[string]string {
	return clone_live_entries(socket.pubsub)
}

@[php_method: 'clearPubsub']
pub fn (mut socket VSlimLiveSocket) clear_pubsub() &VSlimLiveSocket {
	socket.pubsub = []map[string]string{}
	return &socket
}

@[php_method]
pub fn (mut socket VSlimLiveSocket) redirect(location string) &VSlimLiveSocket {
	socket.redirect_to = location.trim_space()
	socket.navigate_to = ''
	return &socket
}

@[php_method: 'redirectTo']
pub fn (socket &VSlimLiveSocket) redirect_to() string {
	return socket.redirect_to
}

@[php_method: 'clearRedirect']
pub fn (mut socket VSlimLiveSocket) clear_redirect() &VSlimLiveSocket {
	socket.redirect_to = ''
	return &socket
}

@[php_method]
pub fn (mut socket VSlimLiveSocket) navigate(location string) &VSlimLiveSocket {
	socket.navigate_to = location.trim_space()
	socket.redirect_to = ''
	return &socket
}

@[php_method: 'navigateTo']
pub fn (socket &VSlimLiveSocket) navigate_to() string {
	return socket.navigate_to
}

@[php_method: 'clearNavigate']
pub fn (mut socket VSlimLiveSocket) clear_navigate() &VSlimLiveSocket {
	socket.navigate_to = ''
	return &socket
}

@[php_method]
pub fn (mut live VSlimLiveView) construct() &VSlimLiveView {
	live.sockets = map[string]&VSlimLiveSocket{}
	return &live
}

@[php_method: 'setApp']
pub fn (mut live VSlimLiveView) set_app(app &VSlimApp) &VSlimLiveView {
	live.host.set_app_ref(app)
	return &live
}

@[php_method: 'setView']
pub fn (mut live VSlimLiveView) set_view(view &VSlimView) &VSlimLiveView {
	live.host.set_view_ref(view)
	return &live
}

@[php_method]
pub fn (mut live VSlimLiveView) view() &VSlimView {
	return live.host.view()
}

@[php_method: 'setTemplate']
pub fn (mut live VSlimLiveView) set_template(template string) &VSlimLiveView {
	live.host.set_template_name(template)
	return &live
}

@[php_method]
pub fn (live &VSlimLiveView) template() string {
	return live.host.template_name()
}

@[php_method: 'setLayout']
pub fn (mut live VSlimLiveView) set_layout(layout string) &VSlimLiveView {
	live.host.set_layout_name(layout)
	return &live
}

@[php_method]
pub fn (live &VSlimLiveView) layout() string {
	return live.host.layout_name()
}

@[php_arg_name: 'root_id=rootId']
@[php_method: 'setRootId']
pub fn (mut live VSlimLiveView) set_root_id(root_id string) &VSlimLiveView {
	live.root_id = root_id.trim_space()
	return &live
}

@[php_method: 'rootId']
pub fn (live &VSlimLiveView) root_id() string {
	return live.root_id
}

@[php_method: 'liveMarker']
pub fn (live &VSlimLiveView) live_marker() bool {
	return true
}

@[php_method: 'attrPrefix']
pub fn (live &VSlimLiveView) attr_prefix() string {
	return 'vphp'
}

@[php_method: 'attrName']
pub fn (live &VSlimLiveView) attr_name(name string) string {
	suffix := name.trim_space().trim('-')
	if suffix == '' {
		return 'vphp'
	}
	return 'vphp-${suffix}'
}

@[php_method: 'runtimeAsset']
pub fn (mut live VSlimLiveView) runtime_asset() string {
	mut view := live.view()
	return view.asset('vphp_live.js')
}

@[php_method: 'runtimeScriptTag']
pub fn (mut live VSlimLiveView) runtime_script_tag() string {
	return '<script defer src="' + escape_html_text(live.runtime_asset()) + '"></script>'
}

@[php_method: 'bootstrapAttrs']
pub fn (live &VSlimLiveView) bootstrap_attrs(socket &VSlimLiveSocket, endpoint string) string {
	ws_path := live_normalize_target(endpoint)
	target := socket.target()
	mut root_id := socket.root_id()
	if root_id == '' {
		root_id = live.root_id()
	}
	if root_id == '' {
		root_id = 'live-root'
	}
	return 'data-vphp-live="1" data-vphp-live-endpoint="' + escape_html_text(ws_path) +
		'" data-vphp-live-path="' + escape_html_text(target) + '" data-vphp-live-root="' +
		escape_html_text(root_id) + '"'
}

@[php_method: 'renderTemplate']
pub fn (mut live VSlimLiveView) render_template(template string, data vphp.PhpValue) string {
	return live.host.render_template_data(template, data)
}

@[php_method: 'renderTemplateWithLayout']
pub fn (mut live VSlimLiveView) render_template_with_layout(template string, layout string, data vphp.PhpValue) string {
	return live.host.render_template_with_layout_data(template, layout, data)
}

@[php_method: 'renderSocket']
pub fn (mut live VSlimLiveView) render_socket(template string, socket &VSlimLiveSocket) string {
	return live.host.render_map_template(template, socket.assigns.clone())
}

@[php_method: 'renderSocketWithLayout']
pub fn (mut live VSlimLiveView) render_socket_with_layout(template string, layout string, socket &VSlimLiveSocket) string {
	return live.host.render_map_template_with_layout(template, layout, socket.assigns.clone())
}

@[php_method]
pub fn (mut live VSlimLiveView) html(socket &VSlimLiveSocket) string {
	return live.host.html_map(socket.assigns.clone())
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method]
pub fn (mut live VSlimLiveView) response(socket &VSlimLiveSocket) &VSlimPsr7Response {
	body := live.html(socket)
	return (*VSlimResponse.live_html(body)).to_psr7_response()
}

@[php_arg_name: 'target_id=targetId']
@[php_method]
pub fn (mut live VSlimLiveView) patch(socket &VSlimLiveSocket, target_id string) &VSlimLiveSocket {
	body := live.html(socket)
	unsafe {
		mut mutable_socket := &VSlimLiveSocket(socket)
		return mutable_socket.patch(target_id, body)
	}
}

@[php_arg_name: 'target_id=targetId']
@[php_method: 'patchTemplate']
pub fn (mut live VSlimLiveView) patch_template(socket &VSlimLiveSocket, target_id string, template string) &VSlimLiveSocket {
	body := live.render_socket(template, socket)
	unsafe {
		mut mutable_socket := &VSlimLiveSocket(socket)
		return mutable_socket.patch(target_id, body)
	}
}

@[php_method]
pub fn (mut component VSlimLiveComponent) construct() &VSlimLiveComponent {
	component.assigns = map[string]string{}
	component.socket_ref = unsafe { nil }
	return &component
}

@[php_method: 'setApp']
pub fn (mut component VSlimLiveComponent) set_app(app &VSlimApp) &VSlimLiveComponent {
	component.host.set_app_ref(app)
	return &component
}

@[php_method: 'setView']
pub fn (mut component VSlimLiveComponent) set_view(view &VSlimView) &VSlimLiveComponent {
	component.host.set_view_ref(view)
	return &component
}

@[php_method]
pub fn (mut component VSlimLiveComponent) view() &VSlimView {
	return component.host.view()
}

@[php_method: 'setTemplate']
pub fn (mut component VSlimLiveComponent) set_template(template string) &VSlimLiveComponent {
	component.host.set_template_name(template)
	return &component
}

@[php_method]
pub fn (component &VSlimLiveComponent) template() string {
	return component.host.template_name()
}

@[php_method: 'setLayout']
pub fn (mut component VSlimLiveComponent) set_layout(layout string) &VSlimLiveComponent {
	component.host.set_layout_name(layout)
	return &component
}

@[php_method]
pub fn (component &VSlimLiveComponent) layout() string {
	return component.host.layout_name()
}

@[php_method: 'setId']
pub fn (mut component VSlimLiveComponent) set_id(id string) &VSlimLiveComponent {
	component.id = id.trim_space()
	return &component
}

@[php_method]
pub fn (component &VSlimLiveComponent) id() string {
	return component.id
}

@[php_method: 'bindSocket']
pub fn (mut component VSlimLiveComponent) bind_socket(socket &VSlimLiveSocket) &VSlimLiveComponent {
	component.socket_ref = socket
	return &component
}

@[php_method: 'hasSocket']
pub fn (component &VSlimLiveComponent) has_socket() bool {
	return !isnil(component.socket_ref)
}

fn (component &VSlimLiveComponent) bound_socket() ?&VSlimLiveSocket {
	if isnil(component.socket_ref) {
		return none
	}
	return component.socket_ref
}

@[php_method]
pub fn (component &VSlimLiveComponent) state() &VSlimLiveComponentState {
	return &VSlimLiveComponentState{
		component_id: component.id.trim_space()
		socket_ref:   component.socket_ref
	}
}

@[php_method]
pub fn (mut component VSlimLiveComponent) assign(key string, value vphp.PhpValue) &VSlimLiveComponent {
	name := key.trim_space()
	if name == '' {
		return &component
	}
	component.assigns[name] = live_value_string(value)
	return &component
}

fn (mut component VSlimLiveComponent) assign_string(key string, value vphp.PhpString) &VSlimLiveComponent {
	name := key.trim_space()
	if name == '' {
		return &component
	}
	component.assigns[name] = value.value()
	return &component
}

@[php_method: 'assignMany']
pub fn (mut component VSlimLiveComponent) assign_many(values vphp.PhpArray) &VSlimLiveComponent {
	for key in values.assoc_keys() {
		component.assign(key, values.value_at(key))
	}
	return &component
}

@[php_method]
pub fn (component &VSlimLiveComponent) assigns() map[string]string {
	return component.assigns.clone()
}

@[php_method: 'clearAssigns']
pub fn (mut component VSlimLiveComponent) clear_assigns() &VSlimLiveComponent {
	component.assigns = map[string]string{}
	return &component
}

@[php_method: 'renderTemplate']
pub fn (mut component VSlimLiveComponent) render_template(template string, data vphp.PhpValue) string {
	return component.host.render_template_data(template, data)
}

@[php_method]
pub fn (mut component VSlimLiveComponent) html() string {
	return component.host.html_map(component.assigns.clone())
}

@[php_method]
pub fn (mut component VSlimLiveComponent) patch(socket &VSlimLiveSocket) &VSlimLiveSocket {
	body := component.html()
	target_id := component.id.trim_space()
	if target_id == '' {
		return unsafe { &VSlimLiveSocket(socket) }
	}
	unsafe {
		mut mutable_socket := &VSlimLiveSocket(socket)
		return mutable_socket.patch(target_id, body)
	}
}

@[php_method: 'patchBound']
pub fn (mut component VSlimLiveComponent) patch_bound() &VSlimLiveSocket {
	if socket := component.bound_socket() {
		return component.patch(socket)
	}
	return VSlimLiveSocket.bound_result()
}

@[php_method: 'componentMarker']
pub fn (mut component VSlimLiveComponent) component_marker() bool {
	return true
}

@[php_arg_name: 'target_id=targetId']
@[php_method: 'appendTo']
pub fn (mut component VSlimLiveComponent) append_to(socket &VSlimLiveSocket, target_id string) &VSlimLiveSocket {
	body := component.html()
	id := target_id.trim_space()
	if id == '' {
		return unsafe { &VSlimLiveSocket(socket) }
	}
	unsafe {
		mut mutable_socket := &VSlimLiveSocket(socket)
		return mutable_socket.append(id, body)
	}
}

@[php_arg_name: 'target_id=targetId']
@[php_method: 'appendToBound']
pub fn (mut component VSlimLiveComponent) append_to_bound(target_id string) &VSlimLiveSocket {
	if socket := component.bound_socket() {
		return component.append_to(socket, target_id)
	}
	return VSlimLiveSocket.bound_result()
}

@[php_arg_name: 'target_id=targetId']
@[php_method: 'prependTo']
pub fn (mut component VSlimLiveComponent) prepend_to(socket &VSlimLiveSocket, target_id string) &VSlimLiveSocket {
	body := component.html()
	id := target_id.trim_space()
	if id == '' {
		return unsafe { &VSlimLiveSocket(socket) }
	}
	unsafe {
		mut mutable_socket := &VSlimLiveSocket(socket)
		return mutable_socket.prepend(id, body)
	}
}

@[php_arg_name: 'target_id=targetId']
@[php_method: 'prependToBound']
pub fn (mut component VSlimLiveComponent) prepend_to_bound(target_id string) &VSlimLiveSocket {
	if socket := component.bound_socket() {
		return component.prepend_to(socket, target_id)
	}
	return VSlimLiveSocket.bound_result()
}

@[php_method]
pub fn (mut component VSlimLiveComponent) remove(socket &VSlimLiveSocket) &VSlimLiveSocket {
	target_id := component.id.trim_space()
	if target_id == '' {
		return unsafe { &VSlimLiveSocket(socket) }
	}
	unsafe {
		mut mutable_socket := &VSlimLiveSocket(socket)
		return mutable_socket.remove(target_id)
	}
}

@[php_method: 'removeBound']
pub fn (mut component VSlimLiveComponent) remove_bound() &VSlimLiveSocket {
	if socket := component.bound_socket() {
		return component.remove(socket)
	}
	return VSlimLiveSocket.bound_result()
}

@[php_method]
pub fn (mut state VSlimLiveComponentState) set(field string, value vphp.PhpValue) &VSlimLiveComponentState {
	if isnil(state.socket_ref) {
		return &state
	}
	unsafe {
		mut socket := &VSlimLiveSocket(state.socket_ref)
		socket.assign_component_state(state.component_id, field, value)
	}
	return &state
}

@[php_method]
pub fn (state &VSlimLiveComponentState) get(field string) string {
	if isnil(state.socket_ref) {
		return ''
	}
	return state.socket_ref.component_state(state.component_id, field)
}

@[php_method: 'getOr']
pub fn (state &VSlimLiveComponentState) get_or(field string, fallback string) string {
	value := state.get(field)
	return if value == '' { fallback } else { value }
}

@[php_method]
pub fn (mut state VSlimLiveComponentState) clear(field string) &VSlimLiveComponentState {
	if isnil(state.socket_ref) {
		return &state
	}
	unsafe {
		mut socket := &VSlimLiveSocket(state.socket_ref)
		socket.clear_component_state(state.component_id, field)
	}
	return &state
}

@[php_method]
pub fn (state &VSlimLiveComponentState) available() bool {
	return !isnil(state.socket_ref) && state.component_id != ''
}

fn VSlimLiveSocket.bound_result() &VSlimLiveSocket {
	mut socket := &VSlimLiveSocket{}
	socket.construct()
	return socket
}

fn live_value_string(value vphp.PhpValue) string {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return ''
	}
	if value.is_string() {
		return value.to_string()
	}
	if value.is_bool() {
		return if value.to_bool() { '1' } else { '0' }
	}
	if value.is_long() {
		return value.to_i64().str()
	}
	if value.is_double() {
		return value.to_f64().str()
	}
	return value.to_string()
}

fn live_form_value_string(value vphp.PhpValue) string {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return ''
	}
	if !value.is_array() {
		return live_value_string(value)
	}
	arr := value.as_array() or { return '' }
	mut parts := []string{}
	for item in arr.value_items() {
		parts << live_value_string(item)
	}
	return parts.join(', ')
}

fn live_field_names(value vphp.PhpArray) []string {
	if !value.is_valid() {
		return []string{}
	}
	mut out := []string{}
	for item in value.value_items() {
		name := item.to_string().trim_space()
		if name != '' {
			out << name
		}
	}
	if out.len > 0 {
		return out
	}
	for key in value.assoc_keys() {
		name := key.trim_space()
		if name != '' {
			out << name
		}
	}
	return out
}

fn live_error_key(field string) string {
	name := field.trim_space()
	return if name == '' { '' } else { 'error_${name}' }
}

fn live_json_payload(payload vphp.PhpValue) string {
	if !payload.is_valid() || payload.is_null() || payload.is_undef() {
		return '{}'
	}
	if payload.is_string() {
		raw := payload.to_string().trim_space()
		if raw == '' {
			return '{}'
		}
		decoded := decode_live_message(raw) or { vphp.PhpValue.null() }
		if decoded.is_valid() && !decoded.is_null() && !decoded.is_undef() {
			return raw
		}
		mut out := vphp.PhpArray.new()
		out.string('value', raw)
		return out.to_json_with_flags(256)
	}
	if payload.is_array() || payload.is_object() || payload.is_bool() || payload.is_long()
		|| payload.is_double() {
		return payload.to_json_with_flags(256)
	}
	mut out := vphp.PhpArray.new()
	out.string('value', payload.to_string())
	return out.to_json_with_flags(256)
}

fn clone_live_entries(entries []map[string]string) []map[string]string {
	mut out := []map[string]string{cap: entries.len}
	for entry in entries {
		out << entry.clone()
	}
	return out
}

fn live_normalize_target(raw_path string) string {
	clean := raw_path.trim_space()
	return if clean == '' { '/' } else { clean }
}

fn VSlimResponse.live_html(body string) &VSlimResponse {
	return &VSlimResponse{
		status:       200
		body:         body
		content_type: 'text/html; charset=utf-8'
		headers:      {
			'content-type': 'text/html; charset=utf-8'
		}
	}
}
