module websocketx

import vphp

@[vphp.PhpClassAttribute(name: 'VHttpd\\Attribute\\Dispatchable', args: '"websocket"')]
@[vphp.PhpExportClass(name: 'VSlim\\WebSocket\\App')]
@[heap]
pub struct VSlimWebSocketApp {
mut:
	callbacks   map[string]vphp.PhpCallable
	connections map[string]vphp.PhpObject
	rooms       map[string][]string
}

@[vphp.PhpArgDefaults(defaults: 'on_open=null,on_message=null,on_close=null')]
@[vphp.PhpArgNames(names: 'on_open=onOpen,on_message=onMessage,on_close=onClose')]
@[vphp.PhpExportMethod(name: '')]
pub fn (mut app VSlimWebSocketApp) construct(on_open ?vphp.PhpCallable, on_message ?vphp.PhpCallable, on_close ?vphp.PhpCallable) &VSlimWebSocketApp {
	for _, mut callback in app.callbacks {
		callback.release()
	}
	for _, mut connection in app.connections {
		connection.release()
	}
	app.callbacks = map[string]vphp.PhpCallable{}
	app.connections = map[string]vphp.PhpObject{}
	app.rooms = map[string][]string{}
	if state := vphp.owned_object_php_state(app) {
		for key in ['open', 'message', 'close', 'connections'] {
			state.remove(key)
		}
	}
	if handler := on_open {
		app.store_handler('open', handler)
	}
	if handler := on_message {
		app.store_handler('message', handler)
	}
	if handler := on_close {
		app.store_handler('close', handler)
	}
	return &app
}

@[vphp.PhpExportMethod(name: 'onOpen')]
pub fn (mut app VSlimWebSocketApp) on_open(handler vphp.PhpCallable) &VSlimWebSocketApp {
	app.store_handler('open', handler)
	return &app
}

@[vphp.PhpExportMethod(name: 'onMessage')]
pub fn (mut app VSlimWebSocketApp) on_message(handler vphp.PhpCallable) &VSlimWebSocketApp {
	app.store_handler('message', handler)
	return &app
}

@[vphp.PhpExportMethod(name: 'onClose')]
pub fn (mut app VSlimWebSocketApp) on_close(handler vphp.PhpCallable) &VSlimWebSocketApp {
	app.store_handler('close', handler)
	return &app
}

fn (mut app VSlimWebSocketApp) store_handler(event string, handler vphp.PhpCallable) {
	if state := vphp.owned_object_php_state(app) {
		state.set_callable(event, handler)
		return
	}
	mut previous := app.callbacks[event] or { vphp.PhpCallable.invalid() }
	app.callbacks[event] = handler.retain()
	previous.release()
}

fn (app &VSlimWebSocketApp) handler(event string) vphp.PhpCallable {
	if state := vphp.owned_object_php_state(app) {
		return state.value_at(event).as_callable() or { vphp.PhpCallable.invalid() }
	}
	return (app.callbacks[event] or { vphp.PhpCallable.invalid() }).borrowed()
}

fn (app &VSlimWebSocketApp) connection_state() ?vphp.PhpArray {
	state := vphp.owned_object_php_state(app) or { return none }
	if connections := state.value_at('connections').as_array() {
		return connections
	}
	mut connections := vphp.PhpArray.new()
	defer {
		connections.release()
	}
	state.set('connections', connections)
	return state.value_at('connections').as_array()
}

fn (app &VSlimWebSocketApp) connection_at(id string) ?vphp.PhpObject {
	if id == '' {
		return none
	}
	if connections := app.connection_state() {
		return connections.value_at(id).as_object()
	}
	if connection := app.connections[id] {
		return connection.borrowed()
	}
	return none
}

pub fn (mut app VSlimWebSocketApp) init_php_state() {
	state := vphp.owned_object_php_state(app) or { return }
	for event, mut callback in app.callbacks {
		state.set_callable(event, callback)
		callback.release()
	}
	app.callbacks.clear()
	if connections := app.connection_state() {
		for id, mut connection in app.connections {
			mut pin := connection.to_request_owned()
			connections.set(id, pin)
			pin.release()
			connection.release()
		}
		app.connections.clear()
	}
}

@[vphp.PhpExportMethod(name: 'hasOnOpen')]
pub fn (app &VSlimWebSocketApp) has_on_open() bool {
	return is_ws_handler_valid(app.handler('open'))
}

@[vphp.PhpExportMethod(name: 'hasOnMessage')]
pub fn (app &VSlimWebSocketApp) has_on_message() bool {
	return is_ws_handler_valid(app.handler('message'))
}

@[vphp.PhpExportMethod(name: 'hasOnClose')]
pub fn (app &VSlimWebSocketApp) has_on_close() bool {
	return is_ws_handler_valid(app.handler('close'))
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut app VSlimWebSocketApp) remember(conn vphp.PhpObject) &VSlimWebSocketApp {
	app.remember_connection(websocket_connection_id(conn), conn)
	return &app
}

fn (mut app VSlimWebSocketApp) remember_connection(id string, conn vphp.PhpObject) {
	if id == '' {
		return
	}
	if connections := app.connection_state() {
		connections.set(id, conn)
		return
	}
	mut previous := app.connections[id] or { vphp.PhpObject.invalid() }
	app.connections[id] = conn.retain()
	previous.release()
}

@[vphp.PhpArgName(v_name: 'conn_or_id', php_name: 'connOrId')]
@[vphp.PhpExportMethod(name: '')]
pub fn (mut app VSlimWebSocketApp) forget(conn_or_id vphp.PhpValue) &VSlimWebSocketApp {
	app.forget_connection(websocket_conn_key(conn_or_id))
	return &app
}

@[vphp.PhpArgName(v_name: 'conn_or_id', php_name: 'connOrId')]
@[vphp.PhpExportMethod(name: 'hasConnection')]
pub fn (app &VSlimWebSocketApp) has_connection(conn_or_id vphp.PhpValue) bool {
	id := websocket_conn_key(conn_or_id)
	app.connection_at(id) or { return false }
	return true
}

@[vphp.PhpArgName(v_name: 'conn_or_id', php_name: 'connOrId')]
@[vphp.PhpExportMethod(name: '')]
pub fn (mut app VSlimWebSocketApp) join(room string, conn_or_id vphp.PhpValue) &VSlimWebSocketApp {
	id := websocket_conn_key(conn_or_id)
	key := normalize_ws_room(room)
	if id == '' || key == '' {
		return &app
	}
	mut members := app.rooms[key] or { []string{} }
	if id !in members {
		members << id
	}
	app.rooms[key] = members
	return &app
}

@[vphp.PhpArgName(v_name: 'conn_or_id', php_name: 'connOrId')]
@[vphp.PhpExportMethod(name: '')]
pub fn (mut app VSlimWebSocketApp) leave(room string, conn_or_id vphp.PhpValue) &VSlimWebSocketApp {
	id := websocket_conn_key(conn_or_id)
	key := normalize_ws_room(room)
	if id == '' || key == '' || key !in app.rooms {
		return &app
	}
	members := app.rooms[key] or { return &app }
	filtered := members.filter(it != id)
	app.rooms[key] = filtered
	if filtered.len == 0 {
		app.rooms.delete(key)
	}
	return &app
}

@[vphp.PhpExportMethod(name: '')]
pub fn (app &VSlimWebSocketApp) members(room string) []string {
	key := normalize_ws_room(room)
	if key == '' {
		return []string{}
	}
	return (app.rooms[key] or { []string{} }).clone()
}

@[vphp.PhpExportMethod(name: 'connectionIds')]
pub fn (app &VSlimWebSocketApp) connection_ids() []string {
	mut ids := app.connection_keys()
	ids.sort()
	return ids
}

fn (app &VSlimWebSocketApp) connection_keys() []string {
	if connections := app.connection_state() {
		return connections.key_strings()
	}
	return app.connections.keys()
}

@[vphp.PhpArgName(v_name: 'conn_or_id', php_name: 'connOrId')]
@[vphp.PhpExportMethod(name: 'roomsFor')]
pub fn (app &VSlimWebSocketApp) rooms_for(conn_or_id vphp.PhpValue) []string {
	id := websocket_conn_key(conn_or_id)
	if id == '' {
		return []string{}
	}
	mut names := []string{}
	for room, members in app.rooms {
		if id in members {
			names << room
		}
	}
	names.sort()
	return names
}

@[vphp.PhpArgName(v_name: 'conn_or_id', php_name: 'connOrId')]
@[vphp.PhpExportMethod(name: 'sendTo')]
pub fn (app &VSlimWebSocketApp) send_to(conn_or_id vphp.PhpValue, data string) bool {
	id := websocket_conn_key(conn_or_id)
	return app.send_to_connection_id(id, data)
}

fn (app &VSlimWebSocketApp) send_to_connection_id(id string, data string) bool {
	connection := app.connection_at(id) or { return false }
	mut conn := connection.owned()
	defer {
		conn.release()
	}
	if !conn.method_exists('send') {
		return false
	}
	mut data_arg := vphp.PhpString.of(data)
	defer {
		data_arg.release()
	}
	conn.with_method_result[vphp.PhpValue, bool]('send', fn (result vphp.PhpValue) bool {
		return result.is_valid()
	}, data_arg) or { return false }
	return true
}

@[vphp.PhpArgName(v_name: 'except_id', php_name: 'exceptId')]
@[vphp.PhpExportMethod(name: '')]
pub fn (app &VSlimWebSocketApp) broadcast(data string, room string, except_id string) int {
	target_room := normalize_ws_room(room)
	except := except_id.trim_space()
	mut sent := 0
	if target_room == '' {
		for id in app.connection_keys() {
			if except != '' && id == except {
				continue
			}
			sent_to_id := app.send_to_connection_id(id, data)
			if sent_to_id {
				sent++
			}
		}
		return sent
	}
	for id in app.rooms[target_room] or { []string{} } {
		if except != '' && id == except {
			continue
		}
		sent_to_id := app.send_to_connection_id(id, data)
		if sent_to_id {
			sent++
		}
	}
	return sent
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut app VSlimWebSocketApp) handle(frame vphp.PhpArray, conn vphp.PhpObject) vphp.PhpValue {
	return app.handle_websocket(frame, conn)
}

@[vphp.PhpExportMethod(name: 'handleWebSocket')]
pub fn (mut app VSlimWebSocketApp) handle_websocket(frame vphp.PhpArray, conn vphp.PhpObject) vphp.PhpValue {
	event := frame.string_at('event', '').trim_space().to_lower()
	mut frame_scope := vphp.PhpScope.frame()
	defer {
		frame_scope.release()
	}
	mut result := match event {
		'open' {
			id := websocket_connection_id(conn)
			app.remember_connection(id, conn)
			result := app.invoke_handler('open', handler_args(mut frame_scope, event,
				frame, conn))
			if websocket_open_failed(result, conn) {
				app.forget_connection(id)
			}
			result
		}
		'message' {
			app.invoke_handler('message', handler_args(mut frame_scope, event,
				frame, conn))
		}
		'close' {
			id := websocket_connection_id(conn)
			result := app.invoke_handler('close', handler_args(mut frame_scope, event,
				frame, conn))
			app.forget_connection(id)
			result
		}
		else {
			vphp.PhpValue.null()
		}
	}
	return result.move_to_request_scope()
}

fn (mut app VSlimWebSocketApp) forget_connection(id string) {
	if id == '' {
		return
	}
	app.remove_conn_from_rooms(id)
	if connections := app.connection_state() {
		connections.remove(id)
		return
	}
	if mut connection := app.connections[id] {
		app.connections.delete(id)
		connection.release()
	}
}

fn websocket_open_failed(result vphp.PhpValue, conn vphp.PhpObject) bool {
	if vphp.has_exception() {
		return true
	}
	// The worker's final Connection class exposes the handshake state.
	if conn.class_name() == 'VHttpd\\PhpWorker\\WebSocket\\Connection' {
		if worker_connection_flag(conn, 'accepted') {
			return false
		}
		if worker_connection_flag(conn, 'rejected') || worker_connection_flag(conn, 'closed') {
			return true
		}
	}
	return result.is_bool() && !result.to_bool()
}

fn worker_connection_flag(conn vphp.PhpObject, method string) bool {
	if !conn.method_exists(method) {
		return false
	}
	return conn.with_method_result[vphp.PhpBool, bool](method, fn (flag vphp.PhpBool) bool {
		return flag.value()
	}) or { false }
}

fn is_ws_handler_valid(handler vphp.PhpCallable) bool {
	return handler.is_valid() && handler.is_callable()
}

fn (app &VSlimWebSocketApp) invoke_handler(event string, args []vphp.PhpArgInput) vphp.PhpValue {
	callback := app.handler(event)
	if !is_ws_handler_valid(callback) {
		return vphp.PhpValue.null()
	}
	mut callback_pin := callback.to_request_owned()
	defer {
		callback_pin.release()
	}
	return callback_pin.invoke_by_value(...args)
}

pub fn (app &VSlimWebSocketApp) free() {
	unsafe {
		mut writable := &VSlimWebSocketApp(app)
		writable.rooms.free()
	}
}

fn websocket_connection_id(conn vphp.PhpObject) string {
	if !conn.is_valid() || !conn.method_exists('id') {
		return ''
	}
	return conn.with_method_result[vphp.PhpString, string]('id', fn (result vphp.PhpString) string {
		return result.value().trim_space()
	}) or { '' }
}

fn websocket_conn_key(conn_or_id vphp.PhpValue) string {
	if conn_or_id.is_string() {
		return conn_or_id.to_string().trim_space()
	}
	if mut conn := conn_or_id.as_object() {
		defer {
			conn.release()
		}
		return websocket_connection_id(conn)
	}
	return ''
}

fn normalize_ws_room(room string) string {
	return room.trim_space()
}

pub fn (mut app VSlimWebSocketApp) remove_conn_from_rooms(id string) {
	if id == '' {
		return
	}
	mut empty := []string{}
	for room, members in app.rooms {
		filtered := members.filter(it != id)
		app.rooms[room] = filtered
		if filtered.len == 0 {
			empty << room
		}
	}
	for room in empty {
		app.rooms.delete(room)
	}
}
