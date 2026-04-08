module main

import net.unix
import time
import vphp

@[php_method]
pub fn (mut c VSlimVhttpdClient) construct(socket_path string, connect_timeout_seconds f64) &VSlimVhttpdClient {
	c.socket_path = socket_path.trim_space()
	c.connect_timeout_seconds = normalize_vhttpd_client_timeout(connect_timeout_seconds)
	return &c
}

@[php_method: 'socketPath']
pub fn (c &VSlimVhttpdClient) socket_path() string {
	return c.socket_path
}

@[php_method: 'connectTimeoutSeconds']
pub fn (c &VSlimVhttpdClient) connect_timeout_seconds() f64 {
	return c.connect_timeout_seconds
}

@[php_method]
pub fn (c &VSlimVhttpdClient) request(payload vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	return c.request_frames(payload, vphp.RequestBorrowedZBox.null())
}

@[php_method: 'requestFrames']
@[php_arg_type: 'frames=array']
@[php_optional_args: 'frames']
pub fn (c &VSlimVhttpdClient) request_frames(payload vphp.RequestBorrowedZBox, frames vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	if c.socket_path.trim_space() == '' {
		vphp.throw_exception_class('RuntimeException', 'socket path must not be empty', 0)
		return vphp.RequestOwnedZBox.new_null()
	}
	if !payload.is_array() {
		vphp.throw_exception_class('InvalidArgumentException', 'request payload must be an array', 0)
		return vphp.RequestOwnedZBox.new_null()
	}
	if frames.is_valid() && !frames.is_null() && !frames.is_undef() && !frames.is_array() {
		vphp.throw_exception_class('InvalidArgumentException', 'frames must be an array of strings', 0)
		return vphp.RequestOwnedZBox.new_null()
	}
	raw_payload := payload.to_zval()
	json_payload := vphp.json_encode_with_flags(raw_payload, 256)
	if json_payload == '' {
		vphp.throw_exception_class('RuntimeException', 'json_encode_failed', 0)
		return vphp.RequestOwnedZBox.new_null()
	}
	frame_list := if frames.is_valid() && frames.is_array() {
		frames.to_string_list()
	} else {
		[]string{}
	}
	mut conn := unix.connect_stream(c.socket_path) or {
		vphp.throw_exception_class('RuntimeException', 'connect_failed: ${err.msg()}', 0)
		return vphp.RequestOwnedZBox.new_null()
	}
	defer {
		conn.close() or {}
	}
	timeout := vhttpd_client_timeout(c.connect_timeout_seconds)
	conn.set_read_timeout(timeout)
	conn.set_write_timeout(timeout)
	vhttpd_client_write_frame(mut conn, json_payload) or {
		vphp.throw_exception_class('RuntimeException', 'write_failed: ${err.msg()}', 0)
		return vphp.RequestOwnedZBox.new_null()
	}
	for frame in frame_list {
		vhttpd_client_write_frame(mut conn, frame) or {
			vphp.throw_exception_class('RuntimeException', 'write_failed: ${err.msg()}', 0)
			return vphp.RequestOwnedZBox.new_null()
		}
	}
	raw_response := vhttpd_client_read_frame(mut conn) or {
		vphp.throw_exception_class('RuntimeException', 'read_failed: ${err.msg()}', 0)
		return vphp.RequestOwnedZBox.new_null()
	}
	if raw_response.trim_space() == '' {
		vphp.throw_exception_class('RuntimeException', 'empty_response', 0)
		return vphp.RequestOwnedZBox.new_null()
	}
	decoded := vphp.json_decode_assoc(raw_response)
	if !decoded.is_valid() || !decoded.is_array() {
		vphp.throw_exception_class('RuntimeException', 'invalid_response_json', 0)
		return vphp.RequestOwnedZBox.new_null()
	}
	return vphp.RequestOwnedZBox.adopt_zval(decoded)
}

fn normalize_vhttpd_client_timeout(timeout_seconds f64) f64 {
	return if timeout_seconds > 0 { timeout_seconds } else { 2.0 }
}

fn vhttpd_client_timeout(timeout_seconds f64) time.Duration {
	return i64(timeout_seconds * f64(time.second))
}

fn vhttpd_client_write_frame(mut conn unix.StreamConn, payload string) ! {
	header := [
		u8((payload.len >> 24) & 0xff),
		u8((payload.len >> 16) & 0xff),
		u8((payload.len >> 8) & 0xff),
		u8(payload.len & 0xff),
	]
	conn.write(header)!
	conn.write_string(payload)!
}

fn vhttpd_client_read_frame(mut conn unix.StreamConn) !string {
	header := vhttpd_client_read_exactly(mut conn, 4)!
	size := (int(header[0]) << 24) | (int(header[1]) << 16) | (int(header[2]) << 8) | int(header[3])
	if size <= 0 {
		return error('empty_response')
	}
	body := vhttpd_client_read_exactly(mut conn, size)!
	return body.bytestr()
}

fn vhttpd_client_read_exactly(mut conn unix.StreamConn, len int) ![]u8 {
	mut out := []u8{len: len}
	mut offset := 0
	for offset < len {
		read_now := conn.read(mut out[offset..])!
		if read_now <= 0 {
			return error('unexpected EOF')
		}
		offset += read_now
	}
	return out
}
