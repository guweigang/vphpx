module liveviewx

import containerx
import httpx
import viewx
import vphp

@[php_method]
pub fn (mut live VSlimLiveView) construct() &VSlimLiveView {
	live.sockets = map[string]&VSlimLiveSocket{}
	return &live
}

@[php_method: 'setContainer']
pub fn (mut live VSlimLiveView) set_container(container &containerx.VSlimContainer) &VSlimLiveView {
	live.host.set_container_ref(container)
	return &live
}

@[php_method: 'setView']
pub fn (mut live VSlimLiveView) set_view(view &viewx.VSlimView) &VSlimLiveView {
	live.host.set_view_ref(view)
	return &live
}

@[php_method]
pub fn (mut live VSlimLiveView) view() &viewx.VSlimView {
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
	return '<script defer src="' + viewx.escape_html_text(live.runtime_asset()) + '"></script>'
}

@[php_method: 'bootstrapAttrs']
pub fn (live &VSlimLiveView) bootstrap_attrs(socket &VSlimLiveSocket, endpoint string) string {
	ws_path := normalize_target(endpoint)
	target := socket.target()
	mut root_id := socket.root_id()
	if root_id == '' {
		root_id = live.root_id()
	}
	if root_id == '' {
		root_id = 'live-root'
	}
	return 'data-vphp-live="1" data-vphp-live-endpoint="' + viewx.escape_html_text(ws_path) +
		'" data-vphp-live-path="' + viewx.escape_html_text(target) + '" data-vphp-live-root="' +
		viewx.escape_html_text(root_id) + '"'
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
pub fn (mut live VSlimLiveView) response(socket &VSlimLiveSocket) &httpx.VSlimPsr7Response {
	body := live.html(socket)
	return (*httpx.VSlimResponse.live_html(body)).to_psr7_response()
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

@[php_method: 'setContainer']
pub fn (mut component VSlimLiveComponent) set_container(container &containerx.VSlimContainer) &VSlimLiveComponent {
	component.host.set_container_ref(container)
	return &component
}

@[php_method: 'setView']
pub fn (mut component VSlimLiveComponent) set_view(view &viewx.VSlimView) &VSlimLiveComponent {
	component.host.set_view_ref(view)
	return &component
}

@[php_method]
pub fn (mut component VSlimLiveComponent) view() &viewx.VSlimView {
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
	component.assigns[name] = value_string(value)
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
