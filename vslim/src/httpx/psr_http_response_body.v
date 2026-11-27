module httpx

import strconv
import strings
import vphp

const http_chunk_line_limit = 8192

fn read_psr18_response_body(stream vphp.PhpResource, mut head Psr18ParsedResponseHead, method string) !string {
	if method == 'HEAD' || response_forbids_body(head.status) {
		return ''
	}
	if codings := head.headers['transfer-encoding'] {
		last := codings.last()
		separator := last.last_index(',') or { -1 }
		if last[separator + 1..].trim_space().to_lower() == 'chunked' {
			body := read_http_chunked_body(stream)!
			mut remaining := codings[..codings.len - 1].clone()
			if separator >= 0 {
				remaining << last[..separator].trim_space()
			}
			head.headers.delete('content-length')
			head.header_names.delete('content-length')
			if remaining.len == 0 {
				head.headers.delete('transfer-encoding')
				head.header_names.delete('transfer-encoding')
			} else {
				head.headers['transfer-encoding'] = remaining
			}
			return body
		}
		return stream.read_to_end() or { return error('failed to read upstream response body') }
	}
	mut length := i64(-1)
	for field in head.headers['content-length'] {
		for value in field.split(',') {
			declared := value.trim_space()
			if declared == '' || !declared.bytes().all(it.is_digit()) {
				return error('upstream response body has an invalid Content-Length')
			}
			size := strconv.parse_uint(declared, 10, 63) or {
				return error('upstream response body has an invalid Content-Length')
			}
			if length >= 0 && length != i64(size) {
				return error('upstream response body has conflicting Content-Length values')
			}
			length = i64(size)
		}
	}
	if length >= 0 {
		return stream.read_exactly(length) or { return error('failed to read upstream response body to Content-Length') }
	}
	return stream.read_to_end() or { return error('failed to read upstream response body') }
}

fn read_http_chunked_body(stream vphp.PhpResource) !string {
	mut body := strings.new_builder(0)
	defer {
		body.free()
	}
	for {
		line := read_http_chunk_line(stream)!
		size_text := line.all_before(';').trim_right(' \t')
		if size_text == '' || !size_text.bytes().all(it.is_hex_digit()) {
			return error('upstream response body contains an invalid chunk size')
		}
		size := strconv.parse_uint(size_text, 16, 63) or {
			return error('upstream response body contains an invalid chunk size')
		}
		if size == 0 {
			discard_http_chunk_trailers(stream)!
			return body.str()
		}
		chunk := stream.read_exactly(i64(size)) or {
			return error('upstream response body contains a truncated chunk')
		}
		body.write_string(chunk)
		unsafe {
			chunk.free()
		}
		delimiter := stream.read_exactly(2) or { '' }
		if delimiter != '\r\n' {
			return error('upstream response body contains an invalid chunk delimiter')
		}
	}
	return error('upstream response body has no final chunk')
}

fn discard_http_chunk_trailers(stream vphp.PhpResource) ! {
	for {
		line := read_http_chunk_line(stream)!
		if line == '' {
			return
		}
		separator := line.index(':') or {
			return error('upstream response body contains an invalid trailer')
		}
		if !is_valid_header_name(line[..separator]) {
			return error('upstream response body contains an invalid trailer')
		}
	}
}

fn read_http_chunk_line(stream vphp.PhpResource) !string {
	line := stream.read_complete_line(http_chunk_line_limit) or {
		return error('upstream response body contains an incomplete or overlong chunk line')
	}
	if !line.ends_with('\r\n') {
		return error('upstream response body contains an invalid chunk line')
	}
	text := line[..line.len - 2]
	if text.bytes().any((it < 32 && it != `\t`) || it == 127) {
		return error('upstream response body contains an invalid chunk line')
	}
	return text
}
