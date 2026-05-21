module liveviewx

import httpx
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

pub fn is_live_route_handler_object(handler vphp.PhpObject) bool {
	return handler.is_valid() && (handler.method_exists('mount') || handler.method_exists('render')
		|| handler.method_exists('__invoke'))
}

pub fn dispatch_live_route_handler(handler vphp.PhpObject, payload vphp.PhpValue) !vphp.PhpValue {
	socket_obj := VSlimLiveSocket.new_object()!
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
			return httpx.vslim_response_to_value(httpx.VSlimResponse.html(200, res.to_string()))
		}
		return res.owned()
	}
	if handler.method_exists('__invoke') {
		mut result := handler.call_method('__invoke', payload_arg, socket_obj)
		return result.owned()
	}
	return error('Live handler must define render() or __invoke()')
}

pub fn dispatch_live_websocket_handler(mut live_ws_sockets map[string]vphp.PhpObject, handler vphp.PhpValue, event string, frame vphp.PhpArray, conn vphp.PhpObject) vphp.PhpValue {
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
			message := decode_message(data) or {
				return vphp.PhpValue.string(protocol_error('invalid_json', 'Invalid JSON message'))
			}
			match message.string_at('type', '') {
				'join' {
					return handler.with_object[vphp.PhpValue](fn [mut live_ws_sockets, frame, conn, message] (handler_obj vphp.PhpObject) vphp.PhpValue {
						return vphp.PhpValue.string(dispatch_live_join(mut live_ws_sockets,
							handler_obj, frame, conn, message))
					}) or { vphp.PhpValue.null() }
				}
				'event' {
					return handler.with_object[vphp.PhpValue](fn [mut live_ws_sockets, frame, conn, message] (handler_obj vphp.PhpObject) vphp.PhpValue {
						return vphp.PhpValue.string(dispatch_live_event(mut live_ws_sockets,
							handler_obj, frame, conn, message))
					}) or { vphp.PhpValue.null() }
				}
				'heartbeat' {
					return vphp.PhpValue.string(heartbeat_response())
				}
				else {
					return vphp.PhpValue.string(protocol_error('unsupported_type',
						'Unsupported live message type'))
				}
			}
		}
		'info' {
			data := frame.string_at('data', '')
			message := decode_message(data) or {
				return vphp.PhpValue.string(protocol_error('invalid_info', 'Invalid info message'))
			}
			return handler.with_object[vphp.PhpValue](fn [mut live_ws_sockets, frame, conn, message] (handler_obj vphp.PhpObject) vphp.PhpValue {
				return vphp.PhpValue.string(dispatch_live_info(mut live_ws_sockets, handler_obj,
					frame, conn, message))
			}) or { vphp.PhpValue.null() }
		}
		'close' {
			conn_id := frame.string_at('id', '').trim_space()
			clear_live_socket_state(conn)
			if conn_id != '' && conn_id in live_ws_sockets {
				mut socket_owned := live_ws_sockets[conn_id] or { vphp.PhpObject.invalid() }
				socket_owned.release()
				live_ws_sockets.delete(conn_id)
			}
			return vphp.PhpValue.null()
		}
		else {
			return vphp.PhpValue.null()
		}
	}
}

fn dispatch_live_join(mut live_ws_sockets map[string]vphp.PhpObject, handler vphp.PhpObject, frame vphp.PhpArray, conn vphp.PhpObject, message vphp.PhpValue) string {
	socket_obj, mut socket := live_socket_for_message(mut live_ws_sockets, handler, frame, message)
	socket.clear_patches()
	socket.clear_events()
	socket.clear_flashes()
	socket.clear_pubsub()
	socket.clear_redirect()
	socket.clear_navigate()
	req := live_socket_build_request(socket, frame, message)
	req_value := httpx.vslim_request_build_value(req, map[string]string{})
	if handler.method_exists('mount') {
		live_call_method(handler, 'mount', req_value, socket_obj)
	}
	persist_live_socket_state(handler, conn, socket)
	execute_live_socket_pubsub(conn, socket)
	html := render_live_html(handler, req_value, socket_obj, socket)
	return patch_response(socket, html, live_default_root_id(handler, socket))
}

fn dispatch_live_event(mut live_ws_sockets map[string]vphp.PhpObject, handler vphp.PhpObject, frame vphp.PhpArray, conn vphp.PhpObject, message vphp.PhpValue) string {
	socket_obj, mut socket := live_socket_for_event(mut live_ws_sockets, handler, frame)
	socket.clear_patches()
	socket.clear_events()
	socket.clear_flashes()
	socket.clear_pubsub()
	socket.clear_redirect()
	socket.clear_navigate()
	req := live_socket_build_request(socket, frame, message)
	req_value := httpx.vslim_request_build_value(req, map[string]string{})
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
	return patch_response(socket, html, live_default_root_id(handler, socket))
}

fn dispatch_live_info(mut live_ws_sockets map[string]vphp.PhpObject, handler vphp.PhpObject, frame vphp.PhpArray, conn vphp.PhpObject, message vphp.PhpValue) string {
	socket_obj, mut socket := live_socket_for_event(mut live_ws_sockets, handler, frame)
	socket.clear_patches()
	socket.clear_events()
	socket.clear_flashes()
	socket.clear_pubsub()
	socket.clear_redirect()
	socket.clear_navigate()
	req := live_socket_build_request(socket, frame, message)
	req_value := httpx.vslim_request_build_value(req, map[string]string{})
	mut payload := message.value_at('payload')
	room := frame.string_at('room', '').trim_space()
	if room != '' {
		payload = info_payload_with_topic(payload, room)
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
	return patch_response(socket, html, live_default_root_id(handler, socket))
}
