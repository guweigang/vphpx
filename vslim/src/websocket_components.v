module main

import vphp

@[php_arg_default(on_open: 'null', on_message: 'null', on_close: 'null')]
@[php_arg_name(on_open: 'onOpen', on_message: 'onMessage', on_close: 'onClose')]
@[php_arg_optional(on_open: true, on_message: true, on_close: true)]
@[php_method]
pub fn (mut app VSlimWebSocketApp) construct(on_open ?vphp.PhpCallable, on_message ?vphp.PhpCallable, on_close ?vphp.PhpCallable) &VSlimWebSocketApp {
	app.on_open_handler = vphp.PhpCallable.invalid()
	app.on_message_handler = vphp.PhpCallable.invalid()
	app.on_close_handler = vphp.PhpCallable.invalid()
	app.connections = map[string]vphp.PhpObject{}
	app.rooms = map[string][]string{}
	if handler := on_open {
		app.store_on_open_handler(handler)
	}
	if handler := on_message {
		app.store_on_message_handler(handler)
	}
	if handler := on_close {
		app.store_on_close_handler(handler)
	}
	return &app
}

@[php_method: 'onOpen']
pub fn (mut app VSlimWebSocketApp) on_open(handler vphp.PhpCallable) &VSlimWebSocketApp {
	app.store_on_open_handler(handler)
	return &app
}

@[php_method: 'onMessage']
pub fn (mut app VSlimWebSocketApp) on_message(handler vphp.PhpCallable) &VSlimWebSocketApp {
	app.store_on_message_handler(handler)
	return &app
}

@[php_method: 'onClose']
pub fn (mut app VSlimWebSocketApp) on_close(handler vphp.PhpCallable) &VSlimWebSocketApp {
	app.store_on_close_handler(handler)
	return &app
}

fn (mut app VSlimWebSocketApp) store_on_open_handler(handler vphp.PhpCallable) {
	app.on_open_handler.release()
	app.on_open_handler = handler.retain()
}

fn (mut app VSlimWebSocketApp) store_on_message_handler(handler vphp.PhpCallable) {
	app.on_message_handler.release()
	app.on_message_handler = handler.retain()
}

fn (mut app VSlimWebSocketApp) store_on_close_handler(handler vphp.PhpCallable) {
	app.on_close_handler.release()
	app.on_close_handler = handler.retain()
}

@[php_method: 'hasOnOpen']
pub fn (app &VSlimWebSocketApp) has_on_open() bool {
	return is_ws_handler_valid(app.on_open_handler)
}

@[php_method: 'hasOnMessage']
pub fn (app &VSlimWebSocketApp) has_on_message() bool {
	return is_ws_handler_valid(app.on_message_handler)
}

@[php_method: 'hasOnClose']
pub fn (app &VSlimWebSocketApp) has_on_close() bool {
	return is_ws_handler_valid(app.on_close_handler)
}

@[php_method]
pub fn (mut app VSlimWebSocketApp) remember(conn vphp.PhpObject) &VSlimWebSocketApp {
	id := websocket_connection_id(conn)
	if id == '' {
		return &app
	}
	if id in app.connections {
		mut existing := app.connections[id] or { vphp.PhpObject.invalid() }
		existing.release()
	}
	app.connections[id] = conn.retain()
	return &app
}

@[php_arg_name: 'conn_or_id=connOrId']
@[php_method]
pub fn (mut app VSlimWebSocketApp) forget(conn_or_id vphp.PhpValue) &VSlimWebSocketApp {
	id := websocket_conn_key(conn_or_id)
	if id == '' {
		return &app
	}
	if id in app.connections {
		mut existing := app.connections[id] or { vphp.PhpObject.invalid() }
		existing.release()
		app.connections.delete(id)
	}
	app.remove_conn_from_rooms(id)
	return &app
}

@[php_arg_name: 'conn_or_id=connOrId']
@[php_method: 'hasConnection']
pub fn (app &VSlimWebSocketApp) has_connection(conn_or_id vphp.PhpValue) bool {
	id := websocket_conn_key(conn_or_id)
	return id != '' && id in app.connections
}

@[php_arg_name: 'conn_or_id=connOrId']
@[php_method]
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

@[php_arg_name: 'conn_or_id=connOrId']
@[php_method]
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

@[php_method]
pub fn (app &VSlimWebSocketApp) members(room string) []string {
	key := normalize_ws_room(room)
	if key == '' {
		return []string{}
	}
	return (app.rooms[key] or { []string{} }).clone()
}

@[php_method: 'connectionIds']
pub fn (app &VSlimWebSocketApp) connection_ids() []string {
	mut ids := app.connections.keys()
	ids.sort()
	return ids
}

@[php_arg_name: 'conn_or_id=connOrId']
@[php_method: 'roomsFor']
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

@[php_arg_name: 'conn_or_id=connOrId']
@[php_method: 'sendTo']
pub fn (app &VSlimWebSocketApp) send_to(conn_or_id vphp.PhpValue, data string) bool {
	id := websocket_conn_key(conn_or_id)
	return app.send_to_connection_id(id, data)
}

fn (app &VSlimWebSocketApp) send_to_connection_id(id string, data string) bool {
	if id == '' || id !in app.connections {
		return false
	}
	conn_owned := app.connections[id] or { return false }
	return conn_owned.with_object(fn [data] (conn vphp.PhpObject) bool {
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
	})
}

@[php_arg_name: 'except_id=exceptId']
@[php_method]
pub fn (app &VSlimWebSocketApp) broadcast(data string, room string, except_id string) int {
	target_room := normalize_ws_room(room)
	except := except_id.trim_space()
	mut sent := 0
	if target_room == '' {
		for id, _ in app.connections {
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

@[php_method]
pub fn (mut app VSlimWebSocketApp) handle(frame vphp.PhpArray, conn vphp.PhpObject) vphp.PhpValue {
	return app.handle_websocket(frame, conn)
}

@[php_method: 'handleWebSocket']
pub fn (mut app VSlimWebSocketApp) handle_websocket(frame vphp.PhpArray, conn vphp.PhpObject) vphp.PhpValue {
	event := frame.string_at('event', '').trim_space().to_lower()
	match event {
		'open' {
			app.remember(conn)
			mut args := []vphp.PhpArgInput{}
			args << conn
			args << frame
			return invoke_ws_handler(app.on_open_handler, args)
		}
		'message' {
			mut frame_scope := vphp.PhpScope.frame()
			defer {
				frame_scope.release()
			}
			mut args := []vphp.PhpArgInput{}
			args << conn
			args << frame_scope.string(frame.string_at('data', ''))
			args << frame
			return invoke_ws_handler(app.on_message_handler, args)
		}
		'close' {
			mut frame_scope := vphp.PhpScope.frame()
			defer {
				frame_scope.release()
			}
			mut args := []vphp.PhpArgInput{}
			args << conn
			args << frame_scope.int(frame.int_at('code', 1000))
			args << frame_scope.string(frame.string_at('reason', ''))
			args << frame
			result := invoke_ws_handler(app.on_close_handler, args)
			app.forget_connection(conn)
			return result
		}
		else {
			return vphp.PhpValue.null()
		}
	}
}

fn (mut app VSlimWebSocketApp) forget_connection(conn vphp.PhpObject) {
	id := websocket_connection_id(conn)
	if id == '' {
		return
	}
	if id in app.connections {
		mut existing := app.connections[id] or { vphp.PhpObject.invalid() }
		existing.release()
		app.connections.delete(id)
	}
	app.remove_conn_from_rooms(id)
}

fn is_ws_handler_valid(handler vphp.PhpCallable) bool {
	return handler.is_valid() && handler.is_callable()
}

fn invoke_ws_handler(handler vphp.PhpCallable, args []vphp.PhpArgInput) vphp.PhpValue {
	if !is_ws_handler_valid(handler) {
		return vphp.PhpValue.null()
	}
	return handler.invoke(...args)
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
	if conn := conn_or_id.as_object() {
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
