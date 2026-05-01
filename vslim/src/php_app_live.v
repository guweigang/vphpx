module main

import vphp

fn live_call_method(obj vphp.ZVal, method string, args ...vphp.PhpFnArg) bool {
	if !obj.is_object() || !obj.method_exists(method) {
		return false
	}
	return vphp.PhpObject.borrowed(obj).with_method_result[vphp.PhpValue, bool](method,
		fn (_ vphp.PhpValue) bool {
		return true
	}, ...args) or { false }
}

fn dispatch_live_route_handler(handler vphp.ZVal, payload vphp.RequestBorrowedZBox) !vphp.ZVal {
	socket_obj := vphp.PhpClass.named('VSlim\\Live\\Socket').construct() or {
		return error('Live socket bootstrap failed')
	}
	socket := socket_obj.to_zval()
	if handler.method_exists('mount') {
		mut mount_res := vphp.PhpObject.borrowed(handler).method_request_owned('mount',
			vphp.PhpValue.from_zval(payload.to_zval()), vphp.PhpValue.from_zval(socket))
		if mount_res.is_valid() && !mount_res.is_null() && !mount_res.is_undef() {
			return mount_res.take_zval()
		}
		mount_res.release()
	}
	if handler.method_exists('render') {
		mut res := vphp.PhpObject.borrowed(handler).method_request_owned('render',
			vphp.PhpValue.from_zval(payload.to_zval()), vphp.PhpValue.from_zval(socket))
		if res.is_string() {
			return build_php_response_object(VSlimResponse{
				status:       200
				body:         res.to_zval().get_string()
				content_type: 'text/html; charset=utf-8'
				headers:      {
					'content-type': 'text/html; charset=utf-8'
				}
			})
		}
		return res.take_zval()
	}
	if handler.method_exists('__invoke') {
		mut result := vphp.PhpObject.borrowed(handler).method_request_owned('__invoke',
			vphp.PhpValue.from_zval(payload.to_zval()), vphp.PhpValue.from_zval(socket))
		return result.take_zval()
	}
	return error('Live handler must define render() or __invoke()')
}

fn dispatch_live_websocket_handler(mut app VSlimApp, handler vphp.ZVal, event string, frame vphp.ZVal, conn vphp.ZVal) vphp.ZVal {
	if !handler.is_object() {
		return vphp.RequestOwnedZBox.new_null().to_zval()
	}
	match event {
		'open' {
			if conn.is_object() && conn.method_exists('accept') {
				live_call_method(conn, 'accept')
			}
			return vphp.RequestOwnedZBox.new_null().to_zval()
		}
		'message' {
			data := zval_string_key(frame, 'data', '')
			message := decode_live_message(data) or {
				return vphp.RequestOwnedZBox.new_string(live_protocol_error('invalid_json',
					'Invalid JSON message')).to_zval()
			}
			match zval_string_key(message, 'type', '') {
				'join' {
					return vphp.RequestOwnedZBox.new_string(dispatch_live_join(mut app,
						handler, frame, conn, message)).to_zval()
				}
				'event' {
					return vphp.RequestOwnedZBox.new_string(dispatch_live_event(mut app,
						handler, frame, conn, message)).to_zval()
				}
				'heartbeat' {
					return vphp.RequestOwnedZBox.new_string(live_heartbeat_response()).to_zval()
				}
				else {
					return vphp.RequestOwnedZBox.new_string(live_protocol_error('unsupported_type',
						'Unsupported live message type')).to_zval()
				}
			}
		}
		'info' {
			data := zval_string_key(frame, 'data', '')
			message := decode_live_message(data) or {
				return vphp.RequestOwnedZBox.new_string(live_protocol_error('invalid_info',
					'Invalid info message')).to_zval()
			}
			return vphp.RequestOwnedZBox.new_string(dispatch_live_info(mut app, handler,
				frame, conn, message)).to_zval()
		}
		'close' {
			conn_id := zval_string_key(frame, 'id', '').trim_space()
			clear_live_socket_state(conn)
			if conn_id != '' && conn_id in app.live_ws_sockets {
				app.live_ws_sockets.delete(conn_id)
			}
			return vphp.RequestOwnedZBox.new_null().to_zval()
		}
		else {
			return vphp.RequestOwnedZBox.new_null().to_zval()
		}
	}
}

fn dispatch_live_join(mut app VSlimApp, handler vphp.ZVal, frame vphp.ZVal, conn vphp.ZVal, message vphp.ZVal) string {
	socket_z, mut socket := live_socket_for_message(mut app, handler, frame, message)
	socket.clear_patches()
	socket.clear_events()
	socket.clear_flashes()
	socket.clear_pubsub()
	socket.clear_redirect()
	socket.clear_navigate()
	req := build_live_request(frame, message, socket)
	req_z := build_php_request_object(req, map[string]string{})
	if handler.method_exists('mount') {
		live_call_method(handler, 'mount', vphp.PhpValue.from_zval(req_z), vphp.PhpValue.from_zval(socket_z))
	}
	persist_live_socket_state(handler, conn, socket)
	execute_live_socket_pubsub(conn, socket)
	html := render_live_html(handler, req_z, socket_z, socket)
	return live_patch_response(socket, html, live_default_root_id(handler, socket))
}

fn dispatch_live_event(mut app VSlimApp, handler vphp.ZVal, frame vphp.ZVal, conn vphp.ZVal, message vphp.ZVal) string {
	socket_z, mut socket := live_socket_for_event(mut app, handler, frame)
	socket.clear_patches()
	socket.clear_events()
	socket.clear_flashes()
	socket.clear_pubsub()
	socket.clear_redirect()
	socket.clear_navigate()
	req := build_live_request(frame, message, socket)
	req_z := build_php_request_object(req, map[string]string{})
	name_z := vphp.RequestOwnedZBox.new_string(zval_string_key(message, 'event', '')).to_zval()
	payload := zval_key(message, 'payload')
	if dispatch_live_component_event(handler, payload, name_z, socket_z) {
		// handled by target component
	} else if handler.method_exists('handleEvent') {
		live_call_method(handler, 'handleEvent', vphp.PhpValue.from_zval(name_z),
			vphp.PhpValue.from_zval(payload), vphp.PhpValue.from_zval(socket_z))
	}
	persist_live_socket_state(handler, conn, socket)
	execute_live_socket_pubsub(conn, socket)
	html := render_live_html(handler, req_z, socket_z, socket)
	return live_patch_response(socket, html, live_default_root_id(handler, socket))
}

fn dispatch_live_info(mut app VSlimApp, handler vphp.ZVal, frame vphp.ZVal, conn vphp.ZVal, message vphp.ZVal) string {
	socket_z, mut socket := live_socket_for_event(mut app, handler, frame)
	socket.clear_patches()
	socket.clear_events()
	socket.clear_flashes()
	socket.clear_pubsub()
	socket.clear_redirect()
	socket.clear_navigate()
	req := build_live_request(frame, message, socket)
	req_z := build_php_request_object(req, map[string]string{})
	mut payload := zval_key(message, 'payload')
	room := zval_string_key(frame, 'room', '').trim_space()
	if room != '' {
		payload = live_info_payload_with_topic(payload, room)
	}
	name_z := vphp.RequestOwnedZBox.new_string(zval_string_key(message, 'event', '')).to_zval()
	if dispatch_live_component_info(handler, payload, name_z, socket_z) {
		// handled by target component
	} else if handler.method_exists('handleInfo') {
		live_call_method(handler, 'handleInfo', vphp.PhpValue.from_zval(name_z),
			vphp.PhpValue.from_zval(payload), vphp.PhpValue.from_zval(socket_z))
	}
	persist_live_socket_state(handler, conn, socket)
	execute_live_socket_pubsub(conn, socket)
	html := render_live_html(handler, req_z, socket_z, socket)
	return live_patch_response(socket, html, live_default_root_id(handler, socket))
}

fn render_live_html(handler vphp.ZVal, req_z vphp.ZVal, socket_z vphp.ZVal, socket &VSlimLiveSocket) string {
	if handler.method_exists('render') {
		mut rendered := vphp.PhpObject.borrowed(handler).method_request_owned('render',
			vphp.PhpValue.from_zval(req_z), vphp.PhpValue.from_zval(socket_z))
		if rendered.is_string() {
			return rendered.to_zval().to_string()
		}
		body, ok := normalize_php_route_response_body(rendered.to_zval())
		if ok {
			return body
		}
	}
	if is_live_view_object(handler) {
		mut live := handler.to_object[VSlimLiveView]() or { return '' }
		return live.html(socket)
	}
	return ''
}

fn dispatch_live_component_event(handler vphp.ZVal, payload vphp.ZVal, event_name vphp.ZVal, socket_z vphp.ZVal) bool {
	target := live_component_target(payload)
	if target == '' {
		return false
	}
	target_z := vphp.RequestOwnedZBox.new_string(target).to_zval()
	if handler.method_exists('component') {
		mut component := vphp.PhpObject.borrowed(handler).method_request_owned('component',
			vphp.PhpValue.from_zval(target_z), vphp.PhpValue.from_zval(socket_z))
		if component.is_object() {
			bind_live_component_socket(component.to_zval(), socket_z)
		}
		if component.is_object() && live_component_handles_event(component.to_zval()) {
			if component.method_exists('handleEvent') {
				live_call_method(component.to_zval(), 'handleEvent', vphp.PhpValue.from_zval(event_name),
					vphp.PhpValue.from_zval(payload), vphp.PhpValue.from_zval(socket_z))
			}
			return true
		}
	}
	if handler.method_exists('handleComponentEvent') {
		live_call_method(handler, 'handleComponentEvent', vphp.PhpValue.from_zval(target_z),
			vphp.PhpValue.from_zval(event_name), vphp.PhpValue.from_zval(payload),
			vphp.PhpValue.from_zval(socket_z))
		return true
	}
	return false
}

fn dispatch_live_component_info(handler vphp.ZVal, payload vphp.ZVal, event_name vphp.ZVal, socket_z vphp.ZVal) bool {
	target := live_component_target(payload)
	if target == '' {
		return false
	}
	target_z := vphp.RequestOwnedZBox.new_string(target).to_zval()
	if handler.method_exists('component') {
		mut component := vphp.PhpObject.borrowed(handler).method_request_owned('component',
			vphp.PhpValue.from_zval(target_z), vphp.PhpValue.from_zval(socket_z))
		if component.is_object() {
			bind_live_component_socket(component.to_zval(), socket_z)
		}
		if component.is_object() && live_component_handles_info(component.to_zval()) {
			if component.method_exists('handleInfo') {
				live_call_method(component.to_zval(), 'handleInfo', vphp.PhpValue.from_zval(event_name),
					vphp.PhpValue.from_zval(payload), vphp.PhpValue.from_zval(socket_z))
			}
			return true
		}
	}
	if handler.method_exists('handleComponentInfo') {
		live_call_method(handler, 'handleComponentInfo', vphp.PhpValue.from_zval(target_z),
			vphp.PhpValue.from_zval(event_name), vphp.PhpValue.from_zval(payload),
			vphp.PhpValue.from_zval(socket_z))
		return true
	}
	return false
}

fn bind_live_component_socket(component vphp.ZVal, socket_z vphp.ZVal) {
	if !component.is_object() {
		return
	}
	if component.method_exists('bindSocket') {
		live_call_method(component, 'bindSocket', vphp.PhpValue.from_zval(socket_z))
	}
}

fn live_component_target(payload vphp.ZVal) string {
	if !payload.is_valid() || payload.is_null() || payload.is_undef() || !payload.is_array() {
		return ''
	}
	target := zval_string_key(payload, 'target', '').trim_space()
	if !target.starts_with('component:') {
		return ''
	}
	return target.all_after('component:').trim_space()
}

fn live_component_handles_event(component vphp.ZVal) bool {
	if !component.is_object() {
		return false
	}
	return component.method_exists('handleEvent')
}

fn live_component_handles_info(component vphp.ZVal) bool {
	if !component.is_object() {
		return false
	}
	return component.method_exists('handleInfo')
}

fn build_live_request(frame vphp.ZVal, message vphp.ZVal, socket &VSlimLiveSocket) &VSlimRequest {
	raw_path := zval_string_key(message, 'path', socket.raw_path)
	mut req := new_vslim_request('GET', raw_path, '')
	req.set_headers(vphp.RequestBorrowedZBox.of(zval_key(frame, 'headers')))
	req.set_remote_addr(zval_string_key(frame, 'remote_addr', ''))
	req.set_scheme(zval_string_key(frame, 'scheme', ''))
	req.set_host(zval_string_key(frame, 'host', ''))
	req.set_port(zval_string_key(frame, 'port', ''))
	return req
}

fn live_socket_for_message(mut app VSlimApp, handler vphp.ZVal, frame vphp.ZVal, message vphp.ZVal) (vphp.ZVal, &VSlimLiveSocket) {
	if live_uses_dispatch(frame) {
		return live_socket_from_frame_metadata(handler, frame, message)
	}
	conn_id := zval_string_key(frame, 'id', '').trim_space()
	if conn_id != '' && conn_id in app.live_ws_sockets {
		socket_owned := app.live_ws_sockets[conn_id] or { vphp.PersistentOwnedZBox.new_null() }
		mut socket_request := socket_owned.clone_request_owned()
		socket_z := socket_request.take_zval()
		mut existing := socket_z.to_object[VSlimLiveSocket]() or { unsafe { nil } }
		if existing != unsafe { nil } {
			existing.connected = true
			existing.raw_path = live_normalize_target(zval_string_key(message, 'path',
				existing.raw_path))
			root_id := zval_string_key(message, 'root_id', existing.root_id)
			if root_id != '' {
				existing.root_id = root_id
			}
			return socket_z, existing
		}
	}
	socket_obj := vphp.PhpClass.named('VSlim\\Live\\Socket').construct() or {
		return vphp.RequestOwnedZBox.new_null().to_zval(), unsafe { nil }
	}
	socket_z := socket_obj.to_zval()
	mut created := socket_z.to_object[VSlimLiveSocket]() or { unsafe { nil } }
	if created == unsafe { nil } {
		return vphp.RequestOwnedZBox.new_null().to_zval(), unsafe { nil }
	}
	created.id = conn_id
	created.connected = true
	created.raw_path = live_normalize_target(zval_string_key(message, 'path', zval_string_key(frame,
		'path', '/')))
	mut root_id := zval_string_key(message, 'root_id', '')
	if root_id == '' {
		root_id = live_view_root_id(handler)
	}
	created.root_id = root_id
	if conn_id != '' {
		app.live_ws_sockets[conn_id] = vphp.PersistentOwnedZBox.from_object_zval(socket_z)
	}
	return socket_z, created
}

fn live_socket_for_event(mut app VSlimApp, handler vphp.ZVal, frame vphp.ZVal) (vphp.ZVal, &VSlimLiveSocket) {
	if live_uses_dispatch(frame) {
		return live_socket_from_frame_metadata(handler, frame, zval_key(frame, 'metadata'))
	}
	conn_id := zval_string_key(frame, 'id', '').trim_space()
	if conn_id != '' && conn_id in app.live_ws_sockets {
		socket_owned := app.live_ws_sockets[conn_id] or { vphp.PersistentOwnedZBox.new_null() }
		mut socket_request := socket_owned.clone_request_owned()
		socket_z := socket_request.take_zval()
		mut existing := socket_z.to_object[VSlimLiveSocket]() or { unsafe { nil } }
		if existing != unsafe { nil } {
			existing.connected = true
			return socket_z, existing
		}
	}
	socket_obj := vphp.PhpClass.named('VSlim\\Live\\Socket').construct() or {
		return vphp.RequestOwnedZBox.new_null().to_zval(), unsafe { nil }
	}
	socket_z := socket_obj.to_zval()
	mut created := socket_z.to_object[VSlimLiveSocket]() or { unsafe { nil } }
	if created == unsafe { nil } {
		return vphp.RequestOwnedZBox.new_null().to_zval(), unsafe { nil }
	}
	created.id = conn_id
	created.connected = true
	created.raw_path = live_normalize_target(zval_string_key(frame, 'path', '/'))
	created.root_id = live_view_root_id(handler)
	if conn_id != '' {
		app.live_ws_sockets[conn_id] = vphp.PersistentOwnedZBox.from_object_zval(socket_z)
	}
	return socket_z, created
}

fn live_uses_dispatch(frame vphp.ZVal) bool {
	return zval_string_key(frame, 'mode', '').trim_space().to_lower() == 'websocket_dispatch'
}

fn live_socket_from_frame_metadata(handler vphp.ZVal, frame vphp.ZVal, message vphp.ZVal) (vphp.ZVal, &VSlimLiveSocket) {
	socket_obj := vphp.PhpClass.named('VSlim\\Live\\Socket').construct() or {
		return vphp.RequestOwnedZBox.new_null().to_zval(), unsafe { nil }
	}
	socket_z := socket_obj.to_zval()
	mut created := socket_z.to_object[VSlimLiveSocket]() or { unsafe { nil } }
	if created == unsafe { nil } {
		return vphp.RequestOwnedZBox.new_null().to_zval(), unsafe { nil }
	}
	created.id = zval_string_key(frame, 'id', '').trim_space()
	created.connected = true
	metadata := zval_key(frame, 'metadata')
	session_meta := decode_live_session_metadata(metadata)
	path_from_message := live_normalize_target(zval_string_key(message, 'path', ''))
	path_from_meta := live_normalize_target(session_meta['target'] or { '' })
	path_from_frame := live_normalize_target(zval_string_key(frame, 'path', '/'))
	if path_from_message != '' && path_from_message != '/' {
		created.raw_path = path_from_message
	} else if path_from_meta != '' && path_from_meta != '/' {
		created.raw_path = path_from_meta
	} else {
		created.raw_path = path_from_frame
	}
	root_from_message := zval_string_key(message, 'root_id', '').trim_space()
	root_from_meta := (session_meta['root_id'] or { '' }).trim_space()
	if root_from_message != '' {
		created.root_id = root_from_message
	} else if root_from_meta != '' {
		created.root_id = root_from_meta
	} else {
		created.root_id = live_view_root_id(handler)
	}
	for key, value in decode_live_assigns_metadata(metadata) {
		mut value_arg := vphp.PhpString.of(value)
		created.assign(key, vphp.RequestBorrowedZBox.from_zval(value_arg.to_zval()))
		value_arg.release()
	}
	return socket_z, created
}

const live_meta_session_key = '_vslim_live_session'
const live_meta_assigns_key = '_vslim_live_assigns'
const live_meta_root_key = '_vslim_live_root'
const live_meta_path_key = '_vslim_live_path'

fn persist_live_socket_state(handler vphp.ZVal, conn vphp.ZVal, socket &VSlimLiveSocket) {
	if !conn.is_object() {
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
	vphp.PhpObject.borrowed(conn).with_method_result[vphp.PhpValue, bool]('setMeta',
		fn (result vphp.PhpValue) bool {
		return result.to_zval().is_valid()
	}, key_arg, session_arg) or {}
}

fn clear_live_socket_state(conn vphp.ZVal) {
	if !conn.is_object() {
		return
	}
	for key in [live_meta_session_key, live_meta_assigns_key, live_meta_root_key, live_meta_path_key] {
		mut key_arg := vphp.PhpString.of(key)
		vphp.PhpObject.borrowed(conn).with_method_result[vphp.PhpValue, bool]('clearMeta',
			fn (result vphp.PhpValue) bool {
			return result.to_zval().is_valid()
		}, key_arg) or {}
		key_arg.release()
	}
}

fn decode_live_session_metadata(metadata vphp.ZVal) map[string]string {
	session_json := zval_string_key(metadata, live_meta_session_key, '').trim_space()
	if session_json == '' {
		return map[string]string{}
	}
	session_z := decode_live_message(session_json) or { vphp.RequestOwnedZBox.new_null().to_zval() }
	if !session_z.is_valid() || session_z.is_null() || session_z.is_undef() || !session_z.is_array() {
		return map[string]string{}
	}
	mut out := map[string]string{}
	for key in session_z.assoc_keys() {
		if key == 'assigns' {
			continue
		}
		out[key] = zval_key(session_z, key).to_string()
	}
	return out
}

fn decode_live_assigns_metadata(metadata vphp.ZVal) map[string]string {
	session_json := zval_string_key(metadata, live_meta_session_key, '').trim_space()
	if session_json != '' {
		session_z := decode_live_message(session_json) or {
			vphp.RequestOwnedZBox.new_null().to_zval()
		}
		assigns_z := zval_key(session_z, 'assigns')
		if assigns_z.is_valid() && !assigns_z.is_null() && !assigns_z.is_undef()
			&& assigns_z.is_array() {
			return zval_string_map(assigns_z)
		}
	}
	assigns_json := zval_string_key(metadata, live_meta_assigns_key, '')
	if assigns_json.trim_space() == '' {
		return map[string]string{}
	}
	assigns_z := decode_live_message(assigns_json) or { vphp.RequestOwnedZBox.new_null().to_zval() }
	if assigns_z.is_valid() && !assigns_z.is_null() && !assigns_z.is_undef() && assigns_z.is_array() {
		return zval_string_map(assigns_z)
	}
	return map[string]string{}
}

fn encode_live_session(handler vphp.ZVal, socket &VSlimLiveSocket) string {
	mut out := new_array()
	out.string('version', '1')
	out.string('view', handler.class_name().trim_space())
	out.string('root_id', socket.root_id.trim_space())
	out.string('target', socket.raw_path.trim_space())
	mut assigns := encode_live_assigns_array(socket)
	out.set('assigns', assigns)
	assigns.release()
	return out.to_json_with_flags(256)
}

fn encode_live_assigns(socket &VSlimLiveSocket) string {
	mut assigns := encode_live_assigns_array(socket)
	json := assigns.to_json_with_flags(256)
	assigns.release()
	return json
}

fn encode_live_assigns_zval(socket &VSlimLiveSocket) vphp.ZVal {
	mut out := encode_live_assigns_array(socket)
	return out.take_zval()
}

fn encode_live_assigns_array(socket &VSlimLiveSocket) vphp.PhpArray {
	mut out := new_array()
	for key, value in socket.assigns {
		out.string(key, value)
	}
	return out
}

fn zval_string_map(value vphp.ZVal) map[string]string {
	mut out := map[string]string{}
	if !value.is_valid() || value.is_null() || value.is_undef() || !value.is_array() {
		return out
	}
	for key in value.assoc_keys() {
		out[key] = zval_key(value, key).to_string()
	}
	return out
}

fn live_default_root_id(handler vphp.ZVal, socket &VSlimLiveSocket) string {
	if socket.root_id.trim_space() != '' {
		return socket.root_id.trim_space()
	}
	root_id := live_view_root_id(handler)
	if root_id != '' {
		return root_id
	}
	return 'live-root'
}

fn live_view_root_id(handler vphp.ZVal) string {
	if !is_live_view_object(handler) {
		return ''
	}
	if live := handler.to_object[VSlimLiveView]() {
		return live.root_id.trim_space()
	}
	if handler.method_exists('rootId') {
		return vphp.PhpObject.borrowed(handler).with_method_result[vphp.PhpValue, string]('rootId',
			fn (root vphp.PhpValue) string {
			raw := root.to_zval()
			if raw.is_valid() && !raw.is_null() && !raw.is_undef() {
				return raw.to_string().trim_space()
			}
			return ''
		}) or { '' }
	}
	return ''
}

fn live_patch_response(socket &VSlimLiveSocket, html string, root_id string) string {
	mut ops := socket.patches.clone()
	if ops.len == 0 && html.trim_space() != '' {
		ops << {
			'op':   'replace'
			'id':   root_id
			'html': html
		}
	}
	mut out := new_array()
	out.string('type', 'patch')
	mut ops_z := new_array()
	for op in ops {
		mut row := new_array()
		row.string('op', op['op'] or { '' })
		row.string('id', op['id'] or { '' })
		if 'html' in op {
			row.string('html', op['html'] or { '' })
		}
		if 'text' in op {
			row.string('text', op['text'] or { '' })
		}
		if 'name' in op {
			row.string('name', op['name'] or { '' })
		}
		if 'value' in op {
			row.string('value', op['value'] or { '' })
		}
		ops_z.push(row)
		row.release()
	}
	out.set('ops', ops_z)
	ops_z.release()
	mut events_z := new_array()
	for event in socket.events {
		mut row := new_array()
		row.string('event', event['event'] or { '' })
		payload := event['payload'] or { '' }
		if payload.trim_space() == '' {
			row.string('payload', '')
		} else {
			decoded_payload := decode_live_message(payload) or {
				row.string('payload', payload)
				events_z.push(row)
				row.release()
				continue
			}
			row.set_zval('payload', decoded_payload)
		}
		events_z.push(row)
		row.release()
	}
	out.set('events', events_z)
	events_z.release()
	if socket.redirect_to.trim_space() != '' {
		out.string('redirect_to', socket.redirect_to)
	}
	if socket.navigate_to.trim_space() != '' {
		out.string('navigate_to', socket.navigate_to)
	}
	mut flash_z := new_array()
	for item in socket.flashes {
		mut row := new_array()
		row.string('kind', item['kind'] or { '' })
		row.string('message', item['message'] or { '' })
		flash_z.push(row)
		row.release()
	}
	out.set('flash', flash_z)
	flash_z.release()
	return out.to_json_with_flags(256)
}

fn live_protocol_error(code string, message string) string {
	mut out := new_array()
	out.string('type', 'error')
	out.string('error', code)
	out.string('message', message)
	return out.to_json_with_flags(256)
}

fn execute_live_socket_pubsub(conn vphp.ZVal, socket &VSlimLiveSocket) {
	if !conn.is_object() {
		return
	}
	for cmd in socket.pubsub {
		match cmd['op'] or { '' } {
			'join' {
				if conn.method_exists('join') {
					mut room_arg := vphp.PhpString.of(cmd['room'] or { '' })
					vphp.PhpObject.borrowed(conn).with_method_result[vphp.PhpValue, bool]('join',
						fn (result vphp.PhpValue) bool {
						return result.to_zval().is_valid()
					}, room_arg) or {}
					room_arg.release()
				}
			}
			'leave' {
				if conn.method_exists('leave') {
					mut room_arg := vphp.PhpString.of(cmd['room'] or { '' })
					vphp.PhpObject.borrowed(conn).with_method_result[vphp.PhpValue, bool]('leave',
						fn (result vphp.PhpValue) bool {
						return result.to_zval().is_valid()
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
					mut payload_arg := vphp.PhpString.of(live_info_payload(cmd['event'] or { '' },
						cmd['payload'] or { '{}' }))
					mut except_arg := vphp.PhpString.of(except_id)
					vphp.PhpObject.borrowed(conn).with_method_result[vphp.PhpValue, bool]('broadcastDispatch',
						fn (result vphp.PhpValue) bool {
						return result.to_zval().is_valid()
					}, room_arg, payload_arg, except_arg) or {}
					room_arg.release()
					payload_arg.release()
					except_arg.release()
				}
			}
			else {}
		}
	}
}

fn live_info_payload(event string, payload_json string) string {
	mut out := new_array()
	out.string('type', 'info')
	out.string('event', event.trim_space())
	decoded_payload := decode_live_message(payload_json) or {
		vphp.RequestOwnedZBox.new_null().to_zval()
	}
	if decoded_payload.is_valid() && !decoded_payload.is_null() && !decoded_payload.is_undef() {
		out.set_zval('payload', decoded_payload)
	} else {
		mut fallback := new_array()
		fallback.string('value', payload_json)
		out.set('payload', fallback)
		fallback.release()
	}
	return out.to_json_with_flags(256)
}

fn live_info_payload_with_topic(payload vphp.ZVal, room string) vphp.ZVal {
	topic := room.trim_space()
	if topic == '' {
		return payload
	}
	mut out := new_array()
	if payload.is_valid() && !payload.is_null() && !payload.is_undef() && payload.is_array() {
		if payload.is_list() {
			for idx := 0; idx < payload.array_count(); idx++ {
				out.push(vphp.PhpValue.from_zval(payload.array_get(idx)))
			}
		} else {
			for key in payload.assoc_keys() {
				out.set_zval(key, zval_key(payload, key))
			}
		}
	} else if payload.is_valid() && !payload.is_null() && !payload.is_undef() {
		out.set_zval('value', payload)
	}
	out.string('topic', topic)
	return out.take_zval()
}

fn live_heartbeat_response() string {
	mut out := new_array()
	out.string('type', 'heartbeat')
	out.bool('ok', true)
	return out.to_json_with_flags(256)
}

fn decode_live_message(raw string) ?vphp.ZVal {
	if raw.trim_space() == '' {
		return none
	}
	decoded := vphp.PhpJson.decode_assoc(raw)
	if !decoded.is_array() {
		return none
	}
	return decoded
}

fn is_live_view_object(handler vphp.ZVal) bool {
	if !handler.is_object() {
		return false
	}
	if handler.is_instance_of('VSlim\\Live\\View') || handler.is_instance_of('VSlimLiveView') {
		return true
	}
	class_name := handler.class_name().trim_space()
	return class_name == 'VSlim\\Live\\View' || class_name == 'VSlimLiveView'
}

fn bind_live_view_to_app(mut app VSlimApp, handler vphp.ZVal) {
	if !is_live_view_object(handler) {
		return
	}
	mut live := handler.to_object[VSlimLiveView]() or { return }
	live.set_app(app)
}
