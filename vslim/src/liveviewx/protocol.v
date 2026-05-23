module liveviewx

import vphp

pub fn decode_message(raw string) ?vphp.PhpValue {
	if raw.trim_space() == '' {
		return none
	}
	decoded := vphp.PhpJson.decode_assoc_value(raw)
	if !decoded.is_array() {
		return none
	}
	return decoded
}

pub fn json_payload(payload vphp.PhpValue) string {
	if !payload.is_valid() || payload.is_null() || payload.is_undef() {
		return '{}'
	}
	if payload.is_string() {
		raw := payload.to_string().trim_space()
		if raw == '' {
			return '{}'
		}
		decoded := decode_message(raw) or { vphp.PhpValue.null() }
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

pub fn patch_response(socket &VSlimLiveSocket, html string, root_id string) string {
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
			decoded_payload := decode_message(payload) or {
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

pub fn protocol_error(code string, message string) string {
	mut out := vphp.PhpArray.new()
	out.string('type', 'error')
	out.string('error', code)
	out.string('message', message)
	return out.to_json_with_flags(256)
}

pub fn info_payload(event string, payload_json string) string {
	mut out := vphp.PhpArray.new()
	out.string('type', 'info')
	out.string('event', event.trim_space())
	decoded_payload := decode_message(payload_json) or { vphp.PhpValue.null() }
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

pub fn info_payload_with_topic(payload vphp.PhpValue, room string) vphp.PhpValue {
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

pub fn heartbeat_response() string {
	mut out := vphp.PhpArray.new()
	out.string('type', 'heartbeat')
	out.bool('ok', true)
	return out.to_json_with_flags(256)
}
