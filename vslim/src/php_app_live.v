module main

import vphp

fn live_call_method(obj vphp.PhpObject, method string, args ...vphp.PhpArgInput) bool {
	if !obj.is_valid() || !obj.method_exists(method) {
		return false
	}
	mut result := obj.call_method(method, ...args)
	defer {
		result.release()
	}
	return result.is_valid()
}

fn dispatch_live_route_handler(handler vphp.PhpObject, payload vphp.PhpValue) !vphp.PhpValue {
	socket_obj := vphp.PhpClass.named('VSlim\\Live\\Socket').construct() or {
		return error('Live socket bootstrap failed')
	}
	payload_arg := payload.owned()
	defer {
		payload_arg.release()
		socket_obj.release()
	}
	if handler.method_exists('mount') {
		mut mount_res := handler.call_method('mount', payload_arg, socket_obj)
		if mount_res.is_valid() && !mount_res.is_null() && !mount_res.is_undef() {
			return mount_res.owned()
		}
		mount_res.release()
	}
	if handler.method_exists('render') {
		mut res := handler.call_method('render', payload_arg, socket_obj)
		if res.is_string() {
			return build_php_response_value(VSlimResponse{
				status:       200
				body:         res.to_string()
				content_type: 'text/html; charset=utf-8'
				headers:      {
					'content-type': 'text/html; charset=utf-8'
				}
			})
		}
		return res.owned()
	}
	if handler.method_exists('__invoke') {
		mut result := handler.call_method('__invoke', payload_arg, socket_obj)
		return result.owned()
	}
	return error('Live handler must define render() or __invoke()')
}

fn dispatch_live_websocket_handler(mut app VSlimApp, handler vphp.PhpValue, event string, frame vphp.PhpArray, conn vphp.PhpObject) vphp.PhpValue {
	if !handler.is_object() {
		return vphp.PhpValue.null()
	}
	match event {
		'open' {
			if conn.is_valid() && conn.method_exists('accept') {
				live_call_method(conn, 'accept')
			}
			return vphp.PhpValue.null()
		}
		'message' {
			data := frame.string_at('data', '')
			message := decode_live_message(data) or {
				return vphp.PhpValue.string(live_protocol_error('invalid_json', 'Invalid JSON message'))
			}
			match message.string_at('type', '') {
				'join' {
					return handler.with_object[vphp.PhpValue](fn [mut app, frame, conn, message] (handler_obj vphp.PhpObject) vphp.PhpValue {
						return vphp.PhpValue.string(dispatch_live_join(mut app, handler_obj, frame,
							conn, message))
					}) or { vphp.PhpValue.null() }
				}
				'event' {
					return handler.with_object[vphp.PhpValue](fn [mut app, frame, conn, message] (handler_obj vphp.PhpObject) vphp.PhpValue {
						return vphp.PhpValue.string(dispatch_live_event(mut app, handler_obj, frame,
							conn, message))
					}) or { vphp.PhpValue.null() }
				}
				'heartbeat' {
					return vphp.PhpValue.string(live_heartbeat_response())
				}
				else {
					return vphp.PhpValue.string(live_protocol_error('unsupported_type',
						'Unsupported live message type'))
				}
			}
		}
		'info' {
			data := frame.string_at('data', '')
			message := decode_live_message(data) or {
				return vphp.PhpValue.string(live_protocol_error('invalid_info', 'Invalid info message'))
			}
			return handler.with_object[vphp.PhpValue](fn [mut app, frame, conn, message] (handler_obj vphp.PhpObject) vphp.PhpValue {
				return vphp.PhpValue.string(dispatch_live_info(mut app, handler_obj, frame, conn,
					message))
			}) or { vphp.PhpValue.null() }
		}
		'close' {
			conn_id := frame.string_at('id', '').trim_space()
			clear_live_socket_state(conn)
			if conn_id != '' && conn_id in app.live_ws_sockets {
				mut socket_owned := app.live_ws_sockets[conn_id] or { vphp.PhpObject.invalid() }
				socket_owned.release()
				app.live_ws_sockets.delete(conn_id)
			}
			return vphp.PhpValue.null()
		}
		else {
			return vphp.PhpValue.null()
		}
	}
}

fn dispatch_live_join(mut app VSlimApp, handler vphp.PhpObject, frame vphp.PhpArray, conn vphp.PhpObject, message vphp.PhpValue) string {
	socket_obj, mut socket := live_socket_for_message(mut app, handler, frame, message)
	socket.clear_patches()
	socket.clear_events()
	socket.clear_flashes()
	socket.clear_pubsub()
	socket.clear_redirect()
	socket.clear_navigate()
	req := build_live_request(frame, message, socket)
	req_value := build_php_request_value(req, map[string]string{})
	if handler.method_exists('mount') {
		live_call_method(handler, 'mount', req_value, socket_obj)
	}
	persist_live_socket_state(handler, conn, socket)
	execute_live_socket_pubsub(conn, socket)
	html := render_live_html(handler, req_value, socket_obj, socket)
	return live_patch_response(socket, html, live_default_root_id(handler, socket))
}

fn dispatch_live_event(mut app VSlimApp, handler vphp.PhpObject, frame vphp.PhpArray, conn vphp.PhpObject, message vphp.PhpValue) string {
	socket_obj, mut socket := live_socket_for_event(mut app, handler, frame)
	socket.clear_patches()
	socket.clear_events()
	socket.clear_flashes()
	socket.clear_pubsub()
	socket.clear_redirect()
	socket.clear_navigate()
	req := build_live_request(frame, message, socket)
	req_value := build_php_request_value(req, map[string]string{})
	mut name_arg := vphp.PhpString.of(message.string_at('event', ''))
	defer {
		name_arg.release()
	}
	payload := message.value_at('payload')
	if dispatch_live_component_event(handler, payload, name_arg, socket_obj) {
		// handled by target component
	} else if handler.method_exists('handleEvent') {
		live_call_method(handler, 'handleEvent', name_arg, payload, socket_obj)
	}
	persist_live_socket_state(handler, conn, socket)
	execute_live_socket_pubsub(conn, socket)
	html := render_live_html(handler, req_value, socket_obj, socket)
	return live_patch_response(socket, html, live_default_root_id(handler, socket))
}

fn dispatch_live_info(mut app VSlimApp, handler vphp.PhpObject, frame vphp.PhpArray, conn vphp.PhpObject, message vphp.PhpValue) string {
	socket_obj, mut socket := live_socket_for_event(mut app, handler, frame)
	socket.clear_patches()
	socket.clear_events()
	socket.clear_flashes()
	socket.clear_pubsub()
	socket.clear_redirect()
	socket.clear_navigate()
	req := build_live_request(frame, message, socket)
	req_value := build_php_request_value(req, map[string]string{})
	mut payload := message.value_at('payload')
	room := frame.string_at('room', '').trim_space()
	if room != '' {
		payload = live_info_payload_with_topic(payload, room)
	}
	mut name_arg := vphp.PhpString.of(message.string_at('event', ''))
	defer {
		name_arg.release()
	}
	if dispatch_live_component_info(handler, payload, name_arg, socket_obj) {
		// handled by target component
	} else if handler.method_exists('handleInfo') {
		live_call_method(handler, 'handleInfo', name_arg, payload, socket_obj)
	}
	persist_live_socket_state(handler, conn, socket)
	execute_live_socket_pubsub(conn, socket)
	html := render_live_html(handler, req_value, socket_obj, socket)
	return live_patch_response(socket, html, live_default_root_id(handler, socket))
}

fn render_live_html(handler vphp.PhpObject, request vphp.PhpValue, socket_obj vphp.PhpObject, socket &VSlimLiveSocket) string {
	if handler.method_exists('render') {
		mut rendered := handler.call_method('render', request, socket_obj)
		if rendered.is_string() {
			return rendered.to_string()
		}
		body, ok := normalize_php_route_response_body_value(rendered)
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

fn dispatch_live_component_event(handler vphp.PhpObject, payload vphp.PhpValue, event_name vphp.PhpString, socket_obj vphp.PhpObject) bool {
	target := live_component_target(payload)
	if target == '' {
		return false
	}
	mut target_arg := vphp.PhpString.of(target)
	defer {
		target_arg.release()
	}
	if handler.method_exists('component') {
		mut component := handler.call_method('component', target_arg, socket_obj)
		defer {
			component.release()
		}
		if component_obj := component.as_object() {
			bind_live_component_socket(component_obj, socket_obj)
			if live_component_handles_event(component_obj)
				&& component_obj.method_exists('handleEvent') {
				live_call_method(component_obj, 'handleEvent', event_name,
					payload, socket_obj)
				return true
			}
		}
	}
	if handler.method_exists('handleComponentEvent') {
		live_call_method(handler, 'handleComponentEvent', target_arg, event_name,
			payload, socket_obj)
		return true
	}
	return false
}

fn dispatch_live_component_info(handler vphp.PhpObject, payload vphp.PhpValue, event_name vphp.PhpString, socket_obj vphp.PhpObject) bool {
	target := live_component_target(payload)
	if target == '' {
		return false
	}
	mut target_arg := vphp.PhpString.of(target)
	defer {
		target_arg.release()
	}
	if handler.method_exists('component') {
		mut component := handler.call_method('component', target_arg, socket_obj)
		defer {
			component.release()
		}
		if component_obj := component.as_object() {
			bind_live_component_socket(component_obj, socket_obj)
			if live_component_handles_info(component_obj)
				&& component_obj.method_exists('handleInfo') {
				live_call_method(component_obj, 'handleInfo', event_name,
					payload, socket_obj)
				return true
			}
		}
	}
	if handler.method_exists('handleComponentInfo') {
		live_call_method(handler, 'handleComponentInfo', target_arg, event_name,
			payload, socket_obj)
		return true
	}
	return false
}

fn bind_live_component_socket(component vphp.PhpObject, socket_obj vphp.PhpObject) {
	if component.method_exists('bindSocket') {
		live_call_method(component, 'bindSocket', socket_obj)
	}
}

fn live_component_target(payload vphp.PhpValue) string {
	if !payload.is_valid() || payload.is_null() || payload.is_undef() || !payload.is_array() {
		return ''
	}
	target := payload.string_at('target', '').trim_space()
	if !target.starts_with('component:') {
		return ''
	}
	return target.all_after('component:').trim_space()
}

fn live_component_handles_event(component vphp.PhpObject) bool {
	return component.method_exists('handleEvent')
}

fn live_component_handles_info(component vphp.PhpObject) bool {
	return component.method_exists('handleInfo')
}

fn build_live_request(frame vphp.PhpArray, message vphp.PhpValue, socket &VSlimLiveSocket) &VSlimRequest {
	raw_path := message.string_at('path', socket.raw_path)
	mut req := new_vslim_request('GET', raw_path, '')
	req.set_headers(frame.value_at('headers').as_array() or { vphp.PhpArray.empty() })
	req.set_remote_addr(frame.string_at('remote_addr', ''))
	req.set_scheme(frame.string_at('scheme', ''))
	req.set_host(frame.string_at('host', ''))
	req.set_port(frame.string_at('port', ''))
	return req
}

fn live_socket_for_message(mut app VSlimApp, handler vphp.PhpObject, frame vphp.PhpArray, message vphp.PhpValue) (vphp.PhpObject, &VSlimLiveSocket) {
	if live_uses_dispatch(frame) {
		return live_socket_from_frame_metadata(handler, frame, message)
	}
	conn_id := frame.string_at('id', '').trim_space()
	if conn_id != '' && conn_id in app.live_ws_sockets {
		socket_owned := app.live_ws_sockets[conn_id] or { vphp.PhpObject.invalid() }
		socket_obj := socket_owned.owned()
		mut existing := socket_obj.to_v_object[VSlimLiveSocket]() or { unsafe { nil } }
		if existing != unsafe { nil } {
			existing.connected = true
			existing.raw_path = live_normalize_target(message.string_at('path', existing.raw_path))
			root_id := message.string_at('root_id', existing.root_id)
			if root_id != '' {
				existing.root_id = root_id
			}
			return socket_obj, existing
		}
	}
	socket_obj := vphp.PhpClass.named('VSlim\\Live\\Socket').construct() or {
		return vphp.PhpObject.invalid(), unsafe { nil }
	}
	mut created := socket_obj.to_v_object[VSlimLiveSocket]() or { unsafe { nil } }
	if created == unsafe { nil } {
		return vphp.PhpObject.invalid(), unsafe { nil }
	}
	created.id = conn_id
	created.connected = true
	created.raw_path =
		live_normalize_target(message.string_at('path', frame.string_at('path', '/')))
	mut root_id := message.string_at('root_id', '')
	if root_id == '' {
		root_id = live_view_root_id(handler)
	}
	created.root_id = root_id
	if conn_id != '' {
		app.live_ws_sockets[conn_id] = socket_obj.retain()
	}
	return socket_obj, created
}

fn live_socket_for_event(mut app VSlimApp, handler vphp.PhpObject, frame vphp.PhpArray) (vphp.PhpObject, &VSlimLiveSocket) {
	if live_uses_dispatch(frame) {
		return live_socket_from_frame_metadata(handler, frame, frame.value_at('metadata'))
	}
	conn_id := frame.string_at('id', '').trim_space()
	if conn_id != '' && conn_id in app.live_ws_sockets {
		socket_owned := app.live_ws_sockets[conn_id] or { vphp.PhpObject.invalid() }
		socket_obj := socket_owned.owned()
		mut existing := socket_obj.to_v_object[VSlimLiveSocket]() or { unsafe { nil } }
		if existing != unsafe { nil } {
			existing.connected = true
			return socket_obj, existing
		}
	}
	socket_obj := vphp.PhpClass.named('VSlim\\Live\\Socket').construct() or {
		return vphp.PhpObject.invalid(), unsafe { nil }
	}
	mut created := socket_obj.to_v_object[VSlimLiveSocket]() or { unsafe { nil } }
	if created == unsafe { nil } {
		return vphp.PhpObject.invalid(), unsafe { nil }
	}
	created.id = conn_id
	created.connected = true
	created.raw_path = live_normalize_target(frame.string_at('path', '/'))
	created.root_id = live_view_root_id(handler)
	if conn_id != '' {
		app.live_ws_sockets[conn_id] = socket_obj.retain()
	}
	return socket_obj, created
}

fn live_uses_dispatch(frame vphp.PhpArray) bool {
	return frame.string_at('mode', '').trim_space().to_lower() == 'websocket_dispatch'
}

fn live_socket_from_frame_metadata(handler vphp.PhpObject, frame vphp.PhpArray, message vphp.PhpValue) (vphp.PhpObject, &VSlimLiveSocket) {
	socket_obj := vphp.PhpClass.named('VSlim\\Live\\Socket').construct() or {
		return vphp.PhpObject.invalid(), unsafe { nil }
	}
	mut created := socket_obj.to_v_object[VSlimLiveSocket]() or { unsafe { nil } }
	if created == unsafe { nil } {
		return vphp.PhpObject.invalid(), unsafe { nil }
	}
	created.id = frame.string_at('id', '').trim_space()
	created.connected = true
	metadata := frame.value_at('metadata')
	session_meta := decode_live_session_metadata(metadata)
	path_from_message := live_normalize_target(message.string_at('path', ''))
	path_from_meta := live_normalize_target(session_meta['target'] or { '' })
	path_from_frame := live_normalize_target(frame.string_at('path', '/'))
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
	for key, value in decode_live_assigns_metadata(metadata) {
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

fn decode_live_session_metadata(metadata vphp.PhpValue) map[string]string {
	session_json := metadata.string_at(live_meta_session_key, '').trim_space()
	if session_json == '' {
		return map[string]string{}
	}
	session_z := decode_live_message(session_json) or { vphp.PhpValue.null() }
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

fn decode_live_assigns_metadata(metadata vphp.PhpValue) map[string]string {
	session_json := metadata.string_at(live_meta_session_key, '').trim_space()
	if session_json != '' {
		session_z := decode_live_message(session_json) or {
			vphp.PhpValue.null()
		}
		assigns_z := session_z.value_at('assigns')
		if assigns_z.is_valid() && !assigns_z.is_null() && !assigns_z.is_undef()
			&& assigns_z.is_array() {
			return php_value_string_map(assigns_z)
		}
	}
	assigns_json := metadata.string_at(live_meta_assigns_key, '')
	if assigns_json.trim_space() == '' {
		return map[string]string{}
	}
	assigns_z := decode_live_message(assigns_json) or { vphp.PhpValue.null() }
	if assigns_z.is_valid() && !assigns_z.is_null() && !assigns_z.is_undef() && assigns_z.is_array() {
		return php_value_string_map(assigns_z)
	}
	return map[string]string{}
}

fn encode_live_session(handler vphp.PhpObject, socket &VSlimLiveSocket) string {
	mut out := vphp.PhpArray.new()
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

fn encode_live_assigns_array(socket &VSlimLiveSocket) vphp.PhpArray {
	mut out := vphp.PhpArray.new()
	for key, value in socket.assigns {
		out.string(key, value)
	}
	return out
}

fn php_value_string_map(value vphp.PhpValue) map[string]string {
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
		return live.root_id.trim_space()
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

fn live_patch_response(socket &VSlimLiveSocket, html string, root_id string) string {
	mut ops := socket.patches.clone()
	if ops.len == 0 && html.trim_space() != '' {
		ops << {
			'op':   'replace'
			'id':   root_id
			'html': html
		}
	}
	mut out := vphp.PhpArray.new()
	out.string('type', 'patch')
	mut ops_z := vphp.PhpArray.new()
	for op in ops {
		mut row := vphp.PhpArray.new()
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
	mut events_z := vphp.PhpArray.new()
	for event in socket.events {
		mut row := vphp.PhpArray.new()
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
			row.set_value('payload', decoded_payload)
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
	mut flash_z := vphp.PhpArray.new()
	for item in socket.flashes {
		mut row := vphp.PhpArray.new()
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
	mut out := vphp.PhpArray.new()
	out.string('type', 'error')
	out.string('error', code)
	out.string('message', message)
	return out.to_json_with_flags(256)
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
					mut payload_arg := vphp.PhpString.of(live_info_payload(cmd['event'] or { '' }, cmd['payload'] or {
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

fn live_info_payload(event string, payload_json string) string {
	mut out := vphp.PhpArray.new()
	out.string('type', 'info')
	out.string('event', event.trim_space())
	decoded_payload := decode_live_message(payload_json) or {
		vphp.PhpValue.null()
	}
	if decoded_payload.is_valid() && !decoded_payload.is_null() && !decoded_payload.is_undef() {
		out.set_value('payload', decoded_payload)
	} else {
		mut fallback := vphp.PhpArray.new()
		fallback.string('value', payload_json)
		out.set('payload', fallback)
		fallback.release()
	}
	return out.to_json_with_flags(256)
}

fn live_info_payload_with_topic(payload vphp.PhpValue, room string) vphp.PhpValue {
	topic := room.trim_space()
	if topic == '' {
		return payload.owned()
	}
	mut out := vphp.PhpArray.new()
	if payload.is_valid() && !payload.is_null() && !payload.is_undef() && payload.is_array() {
		arr := payload.as_array() or { vphp.PhpArray.empty() }
		if arr.is_list() {
			for item in arr.value_items() {
				out.push_value(item)
			}
		} else {
			for key in arr.assoc_keys() {
				out.set_value(key, payload.value_at(key))
			}
		}
	} else if payload.is_valid() && !payload.is_null() && !payload.is_undef() {
		out.set_value('value', payload)
	}
	out.string('topic', topic)
	return out.to_value()
}

fn live_heartbeat_response() string {
	mut out := vphp.PhpArray.new()
	out.string('type', 'heartbeat')
	out.bool('ok', true)
	return out.to_json_with_flags(256)
}

fn decode_live_message(raw string) ?vphp.PhpValue {
	if raw.trim_space() == '' {
		return none
	}
	decoded := vphp.PhpJson.decode_assoc_value(raw)
	if !decoded.is_array() {
		return none
	}
	return decoded
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

fn bind_live_view_to_app(mut app VSlimApp, handler vphp.PhpValue) {
	if !is_live_view_value(handler) {
		return
	}
	handler_obj := handler.as_object() or { return }
	mut live := handler_obj.to_v_object[VSlimLiveView]() or { return }
	live.set_app(app)
}
