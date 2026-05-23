module liveviewx

import containerx
import httpx
import vphp

fn render_live_html(handler vphp.PhpObject, request vphp.PhpValue, socket_obj vphp.PhpObject, socket &VSlimLiveSocket) string {
	if handler.method_exists('render') {
		mut rendered := handler.call_method('render', request, socket_obj)
		if rendered.is_string() {
			return rendered.to_string()
		}
		body, ok := httpx.VSlimResponse.body_from_route_result(rendered)
		if ok {
			return body
		}
	}
	if is_live_view_value(handler.to_value()) {
		mut live := handler.to_v_object[VSlimLiveView]() or { return '' }
		return live.html(socket)
	}
	return ''
}

fn live_socket_build_request(socket &VSlimLiveSocket, frame vphp.PhpArray, message vphp.PhpValue) &httpx.VSlimRequest {
	raw_path := message.string_at('path', socket.raw_path)
	mut req := httpx.VSlimRequest.new('GET', raw_path, '')
	req.set_headers(frame.value_at('headers').as_array() or { vphp.PhpArray.empty() })
	req.set_remote_addr(frame.string_at('remote_addr', ''))
	req.set_scheme(frame.string_at('scheme', ''))
	req.set_host(frame.string_at('host', ''))
	req.set_port(frame.string_at('port', ''))
	return req
}

fn live_socket_for_message(mut live_ws_sockets map[string]vphp.PhpObject, handler vphp.PhpObject, frame vphp.PhpArray, message vphp.PhpValue) (vphp.PhpObject, &VSlimLiveSocket) {
	if live_uses_dispatch(frame) {
		return live_socket_from_frame_metadata(handler, frame, message)
	}
	conn_id := frame.string_at('id', '').trim_space()
	if conn_id != '' && conn_id in live_ws_sockets {
		socket_owned := live_ws_sockets[conn_id] or { vphp.PhpObject.invalid() }
		socket_obj := socket_owned.owned()
		mut existing := socket_obj.to_v_object[VSlimLiveSocket]() or { unsafe { nil } }
		if existing != unsafe { nil } {
			existing.connected = true
			existing.raw_path = normalize_target(message.string_at('path', existing.raw_path))
			root_id := message.string_at('root_id', existing.root_id)
			if root_id != '' {
				existing.root_id = root_id
			}
			return socket_obj, existing
		}
	}
	socket_obj := VSlimLiveSocket.new_object() or {
		return vphp.PhpObject.invalid(), unsafe { nil }
	}
	mut created := socket_obj.to_v_object[VSlimLiveSocket]() or { unsafe { nil } }
	if created == unsafe { nil } {
		return vphp.PhpObject.invalid(), unsafe { nil }
	}
	created.id = conn_id
	created.connected = true
	created.raw_path = normalize_target(message.string_at('path', frame.string_at('path', '/')))
	mut root_id := message.string_at('root_id', '')
	if root_id == '' {
		root_id = live_view_root_id(handler)
	}
	created.root_id = root_id
	if conn_id != '' {
		live_ws_sockets[conn_id] = socket_obj.retain()
	}
	return socket_obj, created
}

fn live_socket_for_event(mut live_ws_sockets map[string]vphp.PhpObject, handler vphp.PhpObject, frame vphp.PhpArray) (vphp.PhpObject, &VSlimLiveSocket) {
	if live_uses_dispatch(frame) {
		return live_socket_from_frame_metadata(handler, frame, frame.value_at('metadata'))
	}
	conn_id := frame.string_at('id', '').trim_space()
	if conn_id != '' && conn_id in live_ws_sockets {
		socket_owned := live_ws_sockets[conn_id] or { vphp.PhpObject.invalid() }
		socket_obj := socket_owned.owned()
		mut existing := socket_obj.to_v_object[VSlimLiveSocket]() or { unsafe { nil } }
		if existing != unsafe { nil } {
			existing.connected = true
			return socket_obj, existing
		}
	}
	socket_obj := VSlimLiveSocket.new_object() or {
		return vphp.PhpObject.invalid(), unsafe { nil }
	}
	mut created := socket_obj.to_v_object[VSlimLiveSocket]() or { unsafe { nil } }
	if created == unsafe { nil } {
		return vphp.PhpObject.invalid(), unsafe { nil }
	}
	created.id = conn_id
	created.connected = true
	created.raw_path = normalize_target(frame.string_at('path', '/'))
	created.root_id = live_view_root_id(handler)
	if conn_id != '' {
		live_ws_sockets[conn_id] = socket_obj.retain()
	}
	return socket_obj, created
}

fn live_uses_dispatch(frame vphp.PhpArray) bool {
	return frame.string_at('mode', '').trim_space().to_lower() == 'websocket_dispatch'
}

fn live_socket_from_frame_metadata(handler vphp.PhpObject, frame vphp.PhpArray, message vphp.PhpValue) (vphp.PhpObject, &VSlimLiveSocket) {
	socket_obj := VSlimLiveSocket.new_object() or {
		return vphp.PhpObject.invalid(), unsafe { nil }
	}
	mut created := socket_obj.to_v_object[VSlimLiveSocket]() or { unsafe { nil } }
	if created == unsafe { nil } {
		return vphp.PhpObject.invalid(), unsafe { nil }
	}
	created.id = frame.string_at('id', '').trim_space()
	created.connected = true
	metadata := frame.value_at('metadata')
	session_meta := live_session_metadata(metadata)
	path_from_message := normalize_target(message.string_at('path', ''))
	path_from_meta := normalize_target(session_meta['target'] or { '' })
	path_from_frame := normalize_target(frame.string_at('path', '/'))
	if path_from_message != '' && path_from_message != '/' {
		created.raw_path = path_from_message
	} else if path_from_meta != '' && path_from_meta != '/' {
		created.raw_path = path_from_meta
	} else {
		created.raw_path = path_from_frame
	}
	root_from_message := message.string_at('root_id', '').trim_space()
	root_from_meta := (session_meta['root_id'] or { '' }).trim_space()
	if root_from_message != '' {
		created.root_id = root_from_message
	} else if root_from_meta != '' {
		created.root_id = root_from_meta
	} else {
		created.root_id = live_view_root_id(handler)
	}
	for key, value in live_assigns_metadata(metadata) {
		mut value_arg := vphp.PhpString.of(value)
		created.assign_string(key, value_arg)
		value_arg.release()
	}
	return socket_obj, created
}

const live_meta_session_key = '_vslim_live_session'
const live_meta_assigns_key = '_vslim_live_assigns'
const live_meta_root_key = '_vslim_live_root'
const live_meta_path_key = '_vslim_live_path'

fn persist_live_socket_state(handler vphp.PhpObject, conn vphp.PhpObject, socket &VSlimLiveSocket) {
	if !conn.is_valid() {
		return
	}
	session_json := encode_live_session(handler, socket)
	mut key_arg := vphp.PhpString.of(live_meta_session_key)
	defer {
		key_arg.release()
	}
	mut session_arg := vphp.PhpString.of(session_json)
	defer {
		session_arg.release()
	}
	conn.with_method_result[vphp.PhpValue, bool]('setMeta', fn (result vphp.PhpValue) bool {
		return result.is_valid()
	}, key_arg, session_arg) or {}
}

fn clear_live_socket_state(conn vphp.PhpObject) {
	if !conn.is_valid() {
		return
	}
	for key in [live_meta_session_key, live_meta_assigns_key, live_meta_root_key, live_meta_path_key] {
		mut key_arg := vphp.PhpString.of(key)
		conn.with_method_result[vphp.PhpValue, bool]('clearMeta', fn (result vphp.PhpValue) bool {
			return result.is_valid()
		}, key_arg) or {}
		key_arg.release()
	}
}

fn live_session_metadata(metadata vphp.PhpValue) map[string]string {
	session_json := metadata.string_at(live_meta_session_key, '').trim_space()
	if session_json == '' {
		return map[string]string{}
	}
	session_z := decode_message(session_json) or { vphp.PhpValue.null() }
	if !session_z.is_valid() || session_z.is_null() || session_z.is_undef() || !session_z.is_array() {
		return map[string]string{}
	}
	mut out := map[string]string{}
	session_arr := session_z.as_array() or { vphp.PhpArray.empty() }
	for key in session_arr.assoc_keys() {
		if key == 'assigns' {
			continue
		}
		out[key] = session_z.value_at(key).to_string()
	}
	return out
}

fn live_assigns_metadata(metadata vphp.PhpValue) map[string]string {
	session_json := metadata.string_at(live_meta_session_key, '').trim_space()
	if session_json != '' {
		session_z := decode_message(session_json) or { vphp.PhpValue.null() }
		assigns_z := session_z.value_at('assigns')
		if assigns_z.is_valid() && !assigns_z.is_null() && !assigns_z.is_undef()
			&& assigns_z.is_array() {
			return string_map(assigns_z)
		}
	}
	assigns_json := metadata.string_at(live_meta_assigns_key, '')
	if assigns_json.trim_space() == '' {
		return map[string]string{}
	}
	assigns_z := decode_message(assigns_json) or { vphp.PhpValue.null() }
	if assigns_z.is_valid() && !assigns_z.is_null() && !assigns_z.is_undef() && assigns_z.is_array() {
		return string_map(assigns_z)
	}
	return map[string]string{}
}

fn encode_live_session(handler vphp.PhpObject, socket &VSlimLiveSocket) string {
	mut out := vphp.PhpArray.new()
	out.string('version', '1')
	out.string('view', handler.class_name().trim_space())
	out.string('root_id', socket.root_id.trim_space())
	out.string('target', socket.raw_path.trim_space())
	mut assigns := live_socket_encode_assigns_array(socket)
	out.set('assigns', assigns)
	assigns.release()
	return out.to_json_with_flags(256)
}

fn live_socket_encode_assigns(socket &VSlimLiveSocket) string {
	mut assigns := live_socket_encode_assigns_array(socket)
	json := assigns.to_json_with_flags(256)
	assigns.release()
	return json
}

fn live_socket_encode_assigns_array(socket &VSlimLiveSocket) vphp.PhpArray {
	mut out := vphp.PhpArray.new()
	for key, value in socket.assigns {
		out.string(key, value)
	}
	return out
}

fn string_map(value vphp.PhpValue) map[string]string {
	mut out := map[string]string{}
	if !value.is_valid() || value.is_null() || value.is_undef() || !value.is_array() {
		return out
	}
	arr := value.as_array() or { return out }
	for key in arr.assoc_keys() {
		out[key] = value.value_at(key).to_string()
	}
	return out
}

fn live_default_root_id(handler vphp.PhpObject, socket &VSlimLiveSocket) string {
	if socket.root_id.trim_space() != '' {
		return socket.root_id.trim_space()
	}
	root_id := live_view_root_id(handler)
	if root_id != '' {
		return root_id
	}
	return 'live-root'
}

fn live_view_root_id(handler vphp.PhpObject) string {
	if !is_live_view_value(handler.to_value()) {
		return ''
	}
	if live := handler.to_v_object[VSlimLiveView]() {
		return live.root_id().trim_space()
	}
	if handler.method_exists('rootId') {
		return handler.with_method_result[vphp.PhpValue, string]('rootId', fn (root vphp.PhpValue) string {
			if root.is_valid() && !root.is_null() && !root.is_undef() {
				return root.to_string().trim_space()
			}
			return ''
		}) or { '' }
	}
	return ''
}

fn execute_live_socket_pubsub(conn vphp.PhpObject, socket &VSlimLiveSocket) {
	if !conn.is_valid() {
		return
	}
	for cmd in socket.pubsub {
		match cmd['op'] {
			'join' {
				if conn.method_exists('join') {
					mut room_arg := vphp.PhpString.of(cmd['room'] or { '' })
					conn.with_method_result[vphp.PhpValue, bool]('join', fn (result vphp.PhpValue) bool {
						return result.is_valid()
					}, room_arg) or {}
					room_arg.release()
				}
			}
			'leave' {
				if conn.method_exists('leave') {
					mut room_arg := vphp.PhpString.of(cmd['room'] or { '' })
					conn.with_method_result[vphp.PhpValue, bool]('leave', fn (result vphp.PhpValue) bool {
						return result.is_valid()
					}, room_arg) or {}
					room_arg.release()
				}
			}
			'broadcast_info' {
				if conn.method_exists('broadcastDispatch') {
					except_id := if (cmd['include_self'] or { 'false' }) == 'true' {
						''
					} else {
						socket.id
					}
					mut room_arg := vphp.PhpString.of(cmd['room'] or { '' })
					mut payload_arg := vphp.PhpString.of(info_payload(cmd['event'] or { '' }, cmd['payload'] or {
						'{}'
					}))
					mut except_arg := vphp.PhpString.of(except_id)
					conn.with_method_result[vphp.PhpValue, bool]('broadcastDispatch', fn (result vphp.PhpValue) bool {
						return result.is_valid()
					}, room_arg, payload_arg, except_arg) or {}
					room_arg.release()
					payload_arg.release()
					except_arg.release()
				}
			}
			else {}
		} or { '' }
	}
}

fn is_live_view_value(handler vphp.PhpValue) bool {
	if !handler.is_object() {
		return false
	}
	if handler.is_instance_of('VSlim\\Live\\View') || handler.is_instance_of('VSlimLiveView') {
		return true
	}
	class_name := handler.class_name().trim_space()
	return class_name == 'VSlim\\Live\\View' || class_name == 'VSlimLiveView'
}

pub fn bind_live_view(handler vphp.PhpValue, container &containerx.VSlimContainer) {
	if !is_live_view_value(handler) {
		return
	}
	handler_obj := handler.as_object() or { return }
	mut live := handler_obj.to_v_object[VSlimLiveView]() or { return }
	live.set_container(container)
}
