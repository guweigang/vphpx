module main

import vphp

@[php_method]
pub fn (mut app VSlimWebSocketApp) construct() &VSlimWebSocketApp {
	app.on_open_handler = vphp.PersistentOwnedZBox.new_null()
	app.on_message_handler = vphp.PersistentOwnedZBox.new_null()
	app.on_close_handler = vphp.PersistentOwnedZBox.new_null()
	app.connections = map[string]vphp.PersistentOwnedZBox{}
	app.rooms = map[string][]string{}
	return &app
}

@[php_method: 'onOpen']
pub fn (mut app VSlimWebSocketApp) on_open(handler vphp.RequestBorrowedZBox) &VSlimWebSocketApp {
	if !handler.is_valid() || !handler.is_callable() {
		vphp.PhpException.raise_class('InvalidArgumentException', 'on_open handler must be callable',
			0)
		return &app
	}
	release_ws_handler(mut app.on_open_handler)
	app.on_open_handler = vphp.PersistentOwnedZBox.from_callable_zval(handler.to_zval())
	return &app
}

@[php_method: 'onMessage']
pub fn (mut app VSlimWebSocketApp) on_message(handler vphp.RequestBorrowedZBox) &VSlimWebSocketApp {
	if !handler.is_valid() || !handler.is_callable() {
		vphp.PhpException.raise_class('InvalidArgumentException', 'on_message handler must be callable',
			0)
		return &app
	}
	release_ws_handler(mut app.on_message_handler)
	app.on_message_handler = vphp.PersistentOwnedZBox.from_callable_zval(handler.to_zval())
	return &app
}

@[php_method: 'onClose']
pub fn (mut app VSlimWebSocketApp) on_close(handler vphp.RequestBorrowedZBox) &VSlimWebSocketApp {
	if !handler.is_valid() || !handler.is_callable() {
		vphp.PhpException.raise_class('InvalidArgumentException', 'on_close handler must be callable',
			0)
		return &app
	}
	release_ws_handler(mut app.on_close_handler)
	app.on_close_handler = vphp.PersistentOwnedZBox.from_callable_zval(handler.to_zval())
	return &app
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
pub fn (mut app VSlimWebSocketApp) remember(conn vphp.RequestBorrowedZBox) &VSlimWebSocketApp {
	id := websocket_connection_id(conn.to_zval())
	if id == '' {
		return &app
	}
	if id in app.connections {
		mut existing := app.connections[id] or { vphp.PersistentOwnedZBox.new_null() }
		release_ws_handler(mut existing)
	}
	app.connections[id] = vphp.PersistentOwnedZBox.from_object_zval(conn.to_zval())
	return &app
}

@[php_arg_name: 'conn_or_id=connOrId']
@[php_method]
pub fn (mut app VSlimWebSocketApp) forget(conn_or_id vphp.RequestBorrowedZBox) &VSlimWebSocketApp {
	id := websocket_conn_key(conn_or_id.to_zval())
	if id == '' {
		return &app
	}
	if id in app.connections {
		mut existing := app.connections[id] or { vphp.PersistentOwnedZBox.new_null() }
		release_ws_handler(mut existing)
		app.connections.delete(id)
	}
	app.remove_conn_from_rooms(id)
	return &app
}

@[php_arg_name: 'conn_or_id=connOrId']
@[php_method: 'hasConnection']
pub fn (app &VSlimWebSocketApp) has_connection(conn_or_id vphp.RequestBorrowedZBox) bool {
	id := websocket_conn_key(conn_or_id.to_zval())
	return id != '' && id in app.connections
}

@[php_arg_name: 'conn_or_id=connOrId']
@[php_method]
pub fn (mut app VSlimWebSocketApp) join(room string, conn_or_id vphp.RequestBorrowedZBox) &VSlimWebSocketApp {
	id := websocket_conn_key(conn_or_id.to_zval())
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
pub fn (mut app VSlimWebSocketApp) leave(room string, conn_or_id vphp.RequestBorrowedZBox) &VSlimWebSocketApp {
	id := websocket_conn_key(conn_or_id.to_zval())
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
pub fn (app &VSlimWebSocketApp) rooms_for(conn_or_id vphp.RequestBorrowedZBox) []string {
	id := websocket_conn_key(conn_or_id.to_zval())
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
pub fn (app &VSlimWebSocketApp) send_to(conn_or_id vphp.RequestBorrowedZBox, data string) bool {
	id := websocket_conn_key(conn_or_id.to_zval())
	if id == '' || id !in app.connections {
		return false
	}
	conn_owned := app.connections[id] or { return false }
	return conn_owned.with_request_object(fn [data] (conn vphp.PhpObject) bool {
		if !conn.method_exists('send') {
			return false
		}
		mut data_arg := vphp.PhpString.of(data)
		defer {
			data_arg.release()
		}
		conn.with_method_result[vphp.PhpValue, bool]('send', fn (result vphp.PhpValue) bool {
			return result.to_zval().is_valid()
		}, data_arg) or { return false }
		return true
	}) or { false }
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
			mut id_arg := vphp.PhpString.of(id)
			sent_to_id := app.send_to(vphp.RequestBorrowedZBox.from_zval(id_arg.to_zval()),
				data)
			id_arg.release()
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
		mut id_arg := vphp.PhpString.of(id)
		sent_to_id := app.send_to(vphp.RequestBorrowedZBox.from_zval(id_arg.to_zval()),
			data)
		id_arg.release()
		if sent_to_id {
			sent++
		}
	}
	return sent
}

@[php_method: 'handleWebSocket']
pub fn (mut app VSlimWebSocketApp) handle_websocket(frame vphp.RequestBorrowedZBox, conn vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	raw_frame := frame.to_zval()
	raw_conn := conn.to_zval()
	event := zval_string_key(raw_frame, 'event', '').trim_space().to_lower()
	match event {
		'open' {
			app.remember(conn)
			mut args := []vphp.PhpFnArg{}
			args << vphp.PhpValue.from_zval(raw_conn)
			args << vphp.PhpValue.from_zval(raw_frame)
			return vphp.RequestOwnedZBox.adopt_zval(invoke_ws_handler(app.on_open_handler,
				args))
		}
		'message' {
			mut frame_scope := vphp.PhpScope.frame()
			defer {
				frame_scope.release()
			}
			mut args := []vphp.PhpFnArg{}
			args << vphp.PhpValue.from_zval(raw_conn)
			args << frame_scope.string(zval_string_key(raw_frame, 'data', ''))
			args << vphp.PhpValue.from_zval(raw_frame)
			return vphp.RequestOwnedZBox.adopt_zval(invoke_ws_handler(app.on_message_handler,
				args))
		}
		'close' {
			mut frame_scope := vphp.PhpScope.frame()
			defer {
				frame_scope.release()
			}
			mut args := []vphp.PhpFnArg{}
			args << vphp.PhpValue.from_zval(raw_conn)
			args << frame_scope.int(zval_int_key(raw_frame, 'code', 1000))
			args << frame_scope.string(zval_string_key(raw_frame, 'reason', ''))
			args << vphp.PhpValue.from_zval(raw_frame)
			result := invoke_ws_handler(app.on_close_handler, args)
			app.forget(conn)
			return vphp.RequestOwnedZBox.adopt_zval(result)
		}
		else {
			return vphp.RequestOwnedZBox.new_null()
		}
	}
}

fn is_ws_handler_valid(handler vphp.PersistentOwnedZBox) bool {
	return handler.is_valid() && !handler.is_null() && !handler.is_undef() && handler.is_callable()
}

fn invoke_ws_handler(handler vphp.PersistentOwnedZBox, args []vphp.PhpFnArg) vphp.ZVal {
	if !is_ws_handler_valid(handler) {
		return vphp.RequestOwnedZBox.new_null().to_zval()
	}
	mut result := handler.fn_request_owned(...args)
	return result.take_zval()
}

fn release_ws_handler(mut handler vphp.PersistentOwnedZBox) {
	if !handler.is_valid() {
		return
	}
	unsafe {
		mut owned := handler
		owned.release()
	}
}

pub fn (app &VSlimWebSocketApp) free() {
	unsafe {
		mut writable := &VSlimWebSocketApp(app)
		// PersistentOwnedZBox fields/maps are released by generic_free_raw()
		// after cleanup() returns. Keep custom cleanup limited to plain V maps.
		writable.rooms.free()
	}
}

fn websocket_connection_id(conn vphp.ZVal) string {
	if !conn.is_object() || !conn.method_exists('id') {
		return ''
	}
	return vphp.PhpObject.borrowed(conn).with_method_result[vphp.PhpString, string]('id',
		fn (result vphp.PhpString) string {
		return result.value().trim_space()
	}) or { '' }
}

fn websocket_conn_key(conn_or_id vphp.ZVal) string {
	if conn_or_id.is_string() {
		return conn_or_id.to_string().trim_space()
	}
	return websocket_connection_id(conn_or_id)
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
