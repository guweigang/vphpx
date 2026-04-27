module main

import vphp

@[php_arg_name: 'default_content=defaultContent']
@[php_arg_default: 'default_content=""']
@[php_arg_optional: 'default_content']
@[php_method]
pub fn (mut s VSlimPsr7Stream) construct(default_content string) &VSlimPsr7Stream {
	s.content = default_content
	s.position = 0
	s.detached = false
	if s.metadata.len == 0 {
		s.metadata = default_psr7_stream_metadata()
	}
	return &s
}

@[php_method]
pub fn (s &VSlimPsr7Stream) str() string {
	return s.stream_string()
}

@[php_method]
pub fn (s &VSlimPsr7Stream) close() {
	unsafe {
		mut writable := &VSlimPsr7Stream(s)
		writable.detached = true
		writable.position = 0
		writable.content = ''
		writable.metadata = map[string]string{}
	}
}

@[php_method]
pub fn (s &VSlimPsr7Stream) detach() vphp.RequestOwnedZBox {
	unsafe {
		mut writable := &VSlimPsr7Stream(s)
		writable.detached = true
		writable.position = 0
		writable.content = ''
		writable.metadata = map[string]string{}
	}
	return vphp.RequestOwnedZBox.new_null()
}

@[php_method: 'getSize']
pub fn (s &VSlimPsr7Stream) get_size() ?int {
	if s.detached {
		return none
	}
	return s.content.len
}

@[php_method]
pub fn (s &VSlimPsr7Stream) tell() int {
	if s.detached {
		vphp.PhpException.raise_class('RuntimeException', 'unable to determine stream position for a detached stream',
			0)
		return 0
	}
	return s.position
}

@[php_method]
pub fn (s &VSlimPsr7Stream) eof() bool {
	if s.detached {
		return true
	}
	return s.position >= s.content.len
}

@[php_method: 'isSeekable']
pub fn (s &VSlimPsr7Stream) is_seekable() bool {
	return !s.detached && stream_is_seekable(s)
}

@[php_arg_name: 'default_whence=defaultWhence']
@[php_arg_default: 'default_whence=SEEK_SET']
@[php_arg_optional: 'default_whence']
@[php_method]
pub fn (s &VSlimPsr7Stream) seek(offset vphp.RequestBorrowedZBox, default_whence vphp.RequestBorrowedZBox) {
	if s.detached {
		vphp.PhpException.raise_class('RuntimeException', 'cannot seek a detached stream',
			0)
		return
	}
	if !stream_is_seekable(s) {
		vphp.PhpException.raise_class('RuntimeException', 'stream is not seekable', 0)
		return
	}
	offset_value := int(offset.to_i64())
	whence := zval_to_psr7_seek_whence(default_whence.to_zval())
	if whence !in [0, 1, 2] {
		vphp.PhpException.raise_class('RuntimeException', 'invalid whence for stream seek',
			0)
		return
	}
	unsafe {
		mut writable := &VSlimPsr7Stream(s)
		match whence {
			1 {
				writable.position = clamp_stream_position(writable.position + offset_value,
					writable.content.len)
			}
			2 {
				writable.position = clamp_stream_position(writable.content.len + offset_value,
					writable.content.len)
			}
			else {
				writable.position = clamp_stream_position(offset_value, writable.content.len)
			}
		}
	}
}

@[php_method]
pub fn (s &VSlimPsr7Stream) rewind() {
	if s.detached {
		vphp.PhpException.raise_class('RuntimeException', 'cannot rewind a detached stream',
			0)
		return
	}
	if !stream_is_seekable(s) {
		vphp.PhpException.raise_class('RuntimeException', 'stream is not seekable', 0)
		return
	}
	unsafe {
		mut writable := &VSlimPsr7Stream(s)
		writable.position = 0
	}
}

@[php_method: 'isWritable']
pub fn (s &VSlimPsr7Stream) is_writable() bool {
	return !s.detached && stream_is_writable(s)
}

@[php_method]
pub fn (s &VSlimPsr7Stream) write(chunk vphp.RequestBorrowedZBox) int {
	if s.detached {
		vphp.PhpException.raise_class('RuntimeException', 'cannot write to a detached stream',
			0)
		return 0
	}
	if !stream_is_writable(s) {
		vphp.PhpException.raise_class('RuntimeException', 'stream is not writable', 0)
		return 0
	}
	text := zval_or_empty_string(chunk.to_zval())
	unsafe {
		mut writable := &VSlimPsr7Stream(s)
		if writable.position >= writable.content.len {
			writable.content += text
			writable.position = writable.content.len
			return text.len
		}
		prefix := writable.content[..writable.position]
		suffix_start := writable.position + text.len
		suffix := if suffix_start < writable.content.len {
			writable.content[suffix_start..]
		} else {
			''
		}
		writable.content = prefix + text + suffix
		writable.position += text.len
	}
	return text.len
}

@[php_method: 'isReadable']
pub fn (s &VSlimPsr7Stream) is_readable() bool {
	return !s.detached && stream_is_readable(s)
}

@[php_method]
pub fn (s &VSlimPsr7Stream) read(length vphp.RequestBorrowedZBox) string {
	if s.detached {
		vphp.PhpException.raise_class('RuntimeException', 'cannot read from a detached stream',
			0)
		return ''
	}
	if !stream_is_readable(s) {
		vphp.PhpException.raise_class('RuntimeException', 'stream is not readable', 0)
		return ''
	}
	length_value := int(length.to_i64())
	if length_value < 0 {
		vphp.PhpException.raise_class('RuntimeException', 'length must be greater than or equal to zero',
			0)
		return ''
	}
	if length_value == 0 || s.position >= s.content.len {
		return ''
	}
	end := clamp_stream_position(s.position + length_value, s.content.len)
	out := s.content[s.position..end]
	unsafe {
		mut writable := &VSlimPsr7Stream(s)
		writable.position = end
	}
	return out
}

@[php_method: 'getContents']
pub fn (s &VSlimPsr7Stream) get_contents() string {
	if s.detached {
		vphp.PhpException.raise_class('RuntimeException', 'cannot read from a detached stream',
			0)
		return ''
	}
	if !stream_is_readable(s) {
		vphp.PhpException.raise_class('RuntimeException', 'stream is not readable', 0)
		return ''
	}
	if s.position >= s.content.len {
		return ''
	}
	out := s.content[s.position..]
	unsafe {
		mut writable := &VSlimPsr7Stream(s)
		writable.position = writable.content.len
	}
	return out
}

@[php_arg_name: 'default_key=defaultKey']
@[php_method: 'getMetadata']
pub fn (s &VSlimPsr7Stream) get_metadata(default_key ?vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	if actual_key := default_key {
		key := actual_key.to_zval().to_string()
		if key == '' {
			return psr7_stream_metadata_map(s)
		}
		value := s.metadata[key] or { return vphp.RequestOwnedZBox.new_null() }
		return vphp.RequestOwnedZBox.new_string(value)
	}
	return psr7_stream_metadata_map(s)
}

fn psr7_stream_metadata_map(s &VSlimPsr7Stream) vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.of(vphp.new_zval_from[map[string]string](s.metadata.clone()) or {
		vphp.ZVal.new_null()
	})
}

fn psr7_default_value_or_null(default_value ?vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	if actual_default := default_value {
		return actual_default.clone_request_owned()
	}
	return vphp.RequestOwnedZBox.new_null()
}

@[php_arg_name: 'default_stream=defaultStream,default_size=defaultSize,default_error=defaultError,default_client_filename=defaultClientFilename,default_client_media_type=defaultClientMediaType']
@[php_method]
pub fn (mut u VSlimPsr7UploadedFile) construct(default_stream vphp.RequestBorrowedZBox, default_size ?int, default_error int, default_client_filename ?string, default_client_media_type ?string) &VSlimPsr7UploadedFile {
	u.stream_ref = zval_to_psr7_stream(default_stream.to_zval())
	u.size_hint = uploaded_file_size_hint(default_size, u.stream_ref)
	u.error_code = normalize_uploaded_file_error(default_error)
	u.client_filename = default_client_filename or { '' }
	u.client_media_type = default_client_media_type or { '' }
	u.moved = false
	u.target_path = ''
	return &u
}

@[php_return_type: 'Psr\\Http\\Message\\StreamInterface']
@[php_method: 'getStream']
pub fn (u &VSlimPsr7UploadedFile) get_stream() &VSlimPsr7Stream {
	if u.moved {
		vphp.PhpException.raise_class('RuntimeException', 'uploaded file stream is no longer available after moveTo',
			0)
		return u.stream_ref
	}
	if u.error_code != 0 {
		vphp.PhpException.raise_class('RuntimeException', 'cannot retrieve stream for errored upload',
			0)
		return u.stream_ref
	}
	if u.stream_ref == unsafe { nil } {
		unsafe {
			mut writable := &VSlimPsr7UploadedFile(u)
			writable.stream_ref = new_psr7_stream('')
		}
	}
	return u.stream_ref
}

@[php_arg_name: 'target_path=targetPath']
@[php_method: 'moveTo']
pub fn (u &VSlimPsr7UploadedFile) move_to(target_path vphp.RequestBorrowedZBox) {
	path := zval_to_log_message(target_path.to_zval()).trim_space()
	if path == '' {
		vphp.PhpException.raise_class('InvalidArgumentException', 'target path must not be empty',
			0)
		return
	}
	if u.moved {
		vphp.PhpException.raise_class('RuntimeException', 'uploaded file has already been moved',
			0)
		return
	}
	if u.error_code != 0 {
		vphp.PhpException.raise_class('RuntimeException', 'cannot move uploaded file with upload error',
			0)
		return
	}
	stream := if u.stream_ref == unsafe { nil } { new_psr7_stream('') } else { u.stream_ref }
	content := stream.stream_string()
	size := if u.size_hint >= 0 { u.size_hint } else { content.len }
	moved := vphp.PhpFunction.named('file_put_contents').with_result_zval([
		vphp.RequestOwnedZBox.new_string(path).to_zval(),
		vphp.RequestOwnedZBox.new_string(content).to_zval(),
	], fn (result vphp.ZVal) bool {
		return result.is_valid() && !result.is_null() && !result.is_undef()
			&& (!result.is_bool() || result.to_bool())
	})
	if !moved {
		vphp.PhpException.raise_class('RuntimeException', 'failed to move uploaded file to target path',
			0)
		return
	}
	unsafe {
		mut writable := &VSlimPsr7UploadedFile(u)
		writable.size_hint = size
		writable.target_path = path
		writable.moved = true
		writable.stream_ref = nil
	}
}

@[php_method: 'getSize']
pub fn (u &VSlimPsr7UploadedFile) get_size() ?int {
	if u.size_hint >= 0 {
		return u.size_hint
	}
	if u.stream_ref != unsafe { nil } {
		return u.stream_ref.get_size()
	}
	return none
}

@[php_method: 'getError']
pub fn (u &VSlimPsr7UploadedFile) get_error() int {
	return normalize_uploaded_file_error(u.error_code)
}

@[php_method: 'getClientFilename']
pub fn (u &VSlimPsr7UploadedFile) get_client_filename() ?string {
	if u.client_filename.trim_space() == '' {
		return none
	}
	return u.client_filename
}

@[php_method: 'getClientMediaType']
pub fn (u &VSlimPsr7UploadedFile) get_client_media_type() ?string {
	if u.client_media_type.trim_space() == '' {
		return none
	}
	return u.client_media_type
}

@[php_method]
pub fn (u &VSlimPsr7UploadedFile) str() string {
	return 'VSlim\\Psr7\\UploadedFile(filename=${u.client_filename}, error=${u.error_code}, moved=${u.moved})'
}

pub fn (mut u VSlimPsr7UploadedFile) cleanup() {
	if u.stream_ref != unsafe { nil } {
		vphp.unregister_vptr_root(u.stream_ref)
		u.stream_ref = unsafe { nil }
	}
}

@[php_arg_name: 'default_status=defaultStatus,default_reason_phrase=defaultReasonPhrase']
@[php_arg_default: 'default_status=200,default_reason_phrase=""']
@[php_arg_optional: 'default_status,default_reason_phrase']
@[php_method]
pub fn (mut r VSlimPsr7Response) construct(default_status int, default_reason_phrase string) &VSlimPsr7Response {
	r.status = default_psr7_status(default_status)
	r.reason_phrase = normalize_reason_phrase(r.status, default_reason_phrase)
	r.protocol_version = normalize_protocol_version(r.protocol_version)
	if r.headers.len == 0 {
		r.headers = map[string][]string{}
	}
	if r.header_names.len == 0 {
		r.header_names = map[string]string{}
	}
	if r.body_ref == unsafe { nil } {
		r.body_ref = new_psr7_stream('')
	}
	return &r
}

@[php_method: 'getProtocolVersion']
pub fn (r &VSlimPsr7Response) get_protocol_version() string {
	return normalize_protocol_version(r.protocol_version)
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'withProtocolVersion']
pub fn (r &VSlimPsr7Response) with_protocol_version(version vphp.RequestBorrowedZBox) &VSlimPsr7Response {
	return clone_psr7_response(r, normalize_protocol_version(zval_to_log_message(version.to_zval())),
		clone_header_values(r.headers), clone_header_names(r.header_names), response_body_or_empty(r),
		r.status, r.reason_phrase)
}

@[php_method: 'getHeaders']
pub fn (r &VSlimPsr7Response) get_headers() map[string][]string {
	return materialize_psr7_headers(r.headers, r.header_names)
}

@[php_method: 'hasHeader']
pub fn (r &VSlimPsr7Response) has_header(name vphp.RequestBorrowedZBox) bool {
	return normalize_psr7_header_name(zval_to_log_message(name.to_zval())) in r.headers
}

@[php_method: 'getHeader']
pub fn (r &VSlimPsr7Response) get_header(name vphp.RequestBorrowedZBox) []string {
	key := normalize_psr7_header_name(zval_to_log_message(name.to_zval()))
	return clone_header_list(r.headers[key] or { []string{} })
}

@[php_method: 'getHeaderLine']
pub fn (r &VSlimPsr7Response) get_header_line(name vphp.RequestBorrowedZBox) string {
	return r.get_header(name).join(', ')
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'withHeader']
pub fn (r &VSlimPsr7Response) with_header(name vphp.RequestBorrowedZBox, value vphp.RequestBorrowedZBox) &VSlimPsr7Response {
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	original_name := zval_to_log_message(name.to_zval()).trim_space()
	key := validate_psr7_header_name_or_throw(zval_to_log_message(name.to_zval())) or {
		return clone_psr7_response(r, r.protocol_version, clone_header_values(r.headers),
			clone_header_names(r.header_names), response_body_or_empty(r), r.status, r.reason_phrase)
	}
	values := zval_to_header_values(value.to_zval()) or {
		return clone_psr7_response(r, r.protocol_version, clone_header_values(r.headers),
			clone_header_names(r.header_names), response_body_or_empty(r), r.status, r.reason_phrase)
	}
	headers[key] = values
	header_names[key] = original_name
	return clone_psr7_response(r, r.protocol_version, headers, header_names, response_body_or_empty(r),
		r.status, r.reason_phrase)
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'withAddedHeader']
pub fn (r &VSlimPsr7Response) with_added_header(name vphp.RequestBorrowedZBox, value vphp.RequestBorrowedZBox) &VSlimPsr7Response {
	original_name := zval_to_log_message(name.to_zval()).trim_space()
	key := validate_psr7_header_name_or_throw(zval_to_log_message(name.to_zval())) or {
		return clone_psr7_response(r, r.protocol_version, clone_header_values(r.headers),
			clone_header_names(r.header_names), response_body_or_empty(r), r.status, r.reason_phrase)
	}
	values := zval_to_header_values(value.to_zval()) or {
		return clone_psr7_response(r, r.protocol_version, clone_header_values(r.headers),
			clone_header_names(r.header_names), response_body_or_empty(r), r.status, r.reason_phrase)
	}
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	mut existing := headers[key] or { []string{} }
	existing << values
	headers[key] = existing
	if key !in header_names {
		header_names[key] = original_name
	}
	return clone_psr7_response(r, r.protocol_version, headers, header_names, response_body_or_empty(r),
		r.status, r.reason_phrase)
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'withoutHeader']
pub fn (r &VSlimPsr7Response) without_header(name vphp.RequestBorrowedZBox) &VSlimPsr7Response {
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	key := normalize_psr7_header_name(zval_to_log_message(name.to_zval()))
	headers.delete(key)
	header_names.delete(key)
	return clone_psr7_response(r, r.protocol_version, headers, header_names, response_body_or_empty(r),
		r.status, r.reason_phrase)
}

@[php_return_type: 'Psr\\Http\\Message\\StreamInterface']
@[php_method: 'getBody']
@[php_borrowed_return]
pub fn (r &VSlimPsr7Response) get_body() &VSlimPsr7Stream {
	if r.body_ref == unsafe { nil } {
		unsafe {
			mut writable := &VSlimPsr7Response(r)
			writable.body_ref = new_psr7_stream('')
		}
	}
	return r.body_ref
}

@[php_arg_type: 'body=Psr\\Http\\Message\\StreamInterface']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'withBody']
pub fn (r &VSlimPsr7Response) with_body(body vphp.RequestBorrowedZBox) &VSlimPsr7Response {
	return clone_psr7_response(r, r.protocol_version, clone_header_values(r.headers),
		clone_header_names(r.header_names), zval_to_psr7_stream(body.to_zval()), r.status,
		r.reason_phrase)
}

@[php_method: 'getStatusCode']
pub fn (r &VSlimPsr7Response) get_status_code() int {
	return default_psr7_status(r.status)
}

@[php_arg_name: 'default_reason_phrase=defaultReasonPhrase']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_arg_default: 'default_reason_phrase=""']
@[php_arg_optional: 'default_reason_phrase']
@[php_method: 'withStatus']
pub fn (r &VSlimPsr7Response) with_status(code vphp.RequestBorrowedZBox, default_reason_phrase vphp.RequestBorrowedZBox) &VSlimPsr7Response {
	status := validate_psr7_status_or_throw(int(code.to_i64())) or {
		return clone_psr7_response(r, r.protocol_version, clone_header_values(r.headers),
			clone_header_names(r.header_names), response_body_or_empty(r), r.status, r.reason_phrase)
	}
	return clone_psr7_response(r, r.protocol_version, clone_header_values(r.headers),
		clone_header_names(r.header_names), response_body_or_empty(r), status, normalize_reason_phrase(status,
		zval_or_empty_string(default_reason_phrase.to_zval())))
}

@[php_method: 'getReasonPhrase']
pub fn (r &VSlimPsr7Response) get_reason_phrase() string {
	return normalize_reason_phrase(r.status, r.reason_phrase)
}

@[php_method]
pub fn (r &VSlimPsr7Response) str() string {
	return 'VSlim\\Psr7\\Response(status=${r.get_status_code()}, headers=${r.headers.len})'
}

pub fn (mut r VSlimPsr7Response) cleanup() {
	if r.body_ref != unsafe { nil } {
		// `getBody()` is exported as a borrowed return, so nested stream refs are
		// not owned vptr roots of the parent response object.
		r.body_ref = unsafe { nil }
	}
}

@[php_method]
pub fn (mut r VSlimPsr7Request) construct() &VSlimPsr7Request {
	r.method = 'GET'
	r.request_target = ''
	r.protocol_version = '1.1'
	if r.headers.len == 0 {
		r.headers = map[string][]string{}
	}
	if r.header_names.len == 0 {
		r.header_names = map[string]string{}
	}
	if r.body_ref == unsafe { nil } {
		r.body_ref = new_psr7_stream('')
	}
	if r.uri_ref == unsafe { nil } {
		r.uri_ref = new_psr7_uri('/')
	}
	return &r
}

@[php_method: 'getProtocolVersion']
pub fn (r &VSlimPsr7Request) get_protocol_version() string {
	return normalize_protocol_version(r.protocol_version)
}

@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_method: 'withProtocolVersion']
pub fn (r &VSlimPsr7Request) with_protocol_version(version vphp.RequestBorrowedZBox) &VSlimPsr7Request {
	return clone_psr7_request(r, r.method, r.request_target, normalize_protocol_version(zval_to_log_message(version.to_zval())),
		clone_header_values(r.headers), clone_header_names(r.header_names), request_body_or_empty(r),
		request_uri_or_default(r))
}

@[php_method: 'getHeaders']
pub fn (r &VSlimPsr7Request) get_headers() map[string][]string {
	return materialize_psr7_headers(r.headers, r.header_names)
}

@[php_method: 'hasHeader']
pub fn (r &VSlimPsr7Request) has_header(name vphp.RequestBorrowedZBox) bool {
	return normalize_psr7_header_name(zval_to_log_message(name.to_zval())) in r.headers
}

@[php_method: 'getHeader']
pub fn (r &VSlimPsr7Request) get_header(name vphp.RequestBorrowedZBox) []string {
	key := normalize_psr7_header_name(zval_to_log_message(name.to_zval()))
	return clone_header_list(r.headers[key] or { []string{} })
}

@[php_method: 'getHeaderLine']
pub fn (r &VSlimPsr7Request) get_header_line(name vphp.RequestBorrowedZBox) string {
	return r.get_header(name).join(', ')
}

@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_method: 'withHeader']
pub fn (r &VSlimPsr7Request) with_header(name vphp.RequestBorrowedZBox, value vphp.RequestBorrowedZBox) &VSlimPsr7Request {
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	original_name := zval_to_log_message(name.to_zval()).trim_space()
	key := validate_psr7_header_name_or_throw(zval_to_log_message(name.to_zval())) or {
		return clone_psr7_request(r, r.method, r.request_target, r.protocol_version, clone_header_values(r.headers),
			clone_header_names(r.header_names), request_body_or_empty(r), request_uri_or_default(r))
	}
	values := zval_to_header_values(value.to_zval()) or {
		return clone_psr7_request(r, r.method, r.request_target, r.protocol_version, clone_header_values(r.headers),
			clone_header_names(r.header_names), request_body_or_empty(r), request_uri_or_default(r))
	}
	headers[key] = values
	header_names[key] = original_name
	return clone_psr7_request(r, r.method, r.request_target, r.protocol_version, headers,
		header_names, request_body_or_empty(r), request_uri_or_default(r))
}

@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_method: 'withAddedHeader']
pub fn (r &VSlimPsr7Request) with_added_header(name vphp.RequestBorrowedZBox, value vphp.RequestBorrowedZBox) &VSlimPsr7Request {
	original_name := zval_to_log_message(name.to_zval()).trim_space()
	key := validate_psr7_header_name_or_throw(zval_to_log_message(name.to_zval())) or {
		return clone_psr7_request(r, r.method, r.request_target, r.protocol_version, clone_header_values(r.headers),
			clone_header_names(r.header_names), request_body_or_empty(r), request_uri_or_default(r))
	}
	values := zval_to_header_values(value.to_zval()) or {
		return clone_psr7_request(r, r.method, r.request_target, r.protocol_version, clone_header_values(r.headers),
			clone_header_names(r.header_names), request_body_or_empty(r), request_uri_or_default(r))
	}
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	mut existing := headers[key] or { []string{} }
	existing << values
	headers[key] = existing
	if key !in header_names {
		header_names[key] = original_name
	}
	return clone_psr7_request(r, r.method, r.request_target, r.protocol_version, headers,
		header_names, request_body_or_empty(r), request_uri_or_default(r))
}

@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_method: 'withoutHeader']
pub fn (r &VSlimPsr7Request) without_header(name vphp.RequestBorrowedZBox) &VSlimPsr7Request {
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	key := normalize_psr7_header_name(zval_to_log_message(name.to_zval()))
	headers.delete(key)
	header_names.delete(key)
	return clone_psr7_request(r, r.method, r.request_target, r.protocol_version, headers,
		header_names, request_body_or_empty(r), request_uri_or_default(r))
}

@[php_return_type: 'Psr\\Http\\Message\\StreamInterface']
@[php_method: 'getBody']
@[php_borrowed_return]
pub fn (r &VSlimPsr7Request) get_body() &VSlimPsr7Stream {
	if r.body_ref == unsafe { nil } {
		unsafe {
			mut writable := &VSlimPsr7Request(r)
			writable.body_ref = new_psr7_stream('')
		}
	}
	return r.body_ref
}

@[php_arg_type: 'body=Psr\\Http\\Message\\StreamInterface']
@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_method: 'withBody']
pub fn (r &VSlimPsr7Request) with_body(body vphp.RequestBorrowedZBox) &VSlimPsr7Request {
	return clone_psr7_request(r, r.method, r.request_target, r.protocol_version, clone_header_values(r.headers),
		clone_header_names(r.header_names), zval_to_psr7_stream(body.to_zval()), request_uri_or_default(r))
}

@[php_method: 'getRequestTarget']
pub fn (r &VSlimPsr7Request) get_request_target() string {
	target := r.request_target.trim_space()
	if target != '' {
		return target
	}
	return build_psr7_request_target(request_uri_or_default(r))
}

@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_arg_name: 'request_target=requestTarget']
@[php_method: 'withRequestTarget']
pub fn (r &VSlimPsr7Request) with_request_target(request_target vphp.RequestBorrowedZBox) &VSlimPsr7Request {
	target := validate_psr7_request_target_or_throw(zval_to_log_message(request_target.to_zval())) or {
		return clone_psr7_request(r, r.method, r.request_target, r.protocol_version, clone_header_values(r.headers),
			clone_header_names(r.header_names), request_body_or_empty(r), request_uri_or_default(r))
	}
	return clone_psr7_request(r, r.method, target, r.protocol_version, clone_header_values(r.headers),
		clone_header_names(r.header_names), request_body_or_empty(r), request_uri_or_default(r))
}

@[php_method: 'getMethod']
pub fn (r &VSlimPsr7Request) get_method() string {
	return normalize_psr7_method(r.method)
}

@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_method: 'withMethod']
pub fn (r &VSlimPsr7Request) with_method(method vphp.RequestBorrowedZBox) &VSlimPsr7Request {
	next_method := validate_psr7_method_or_throw(zval_to_log_message(method.to_zval())) or {
		return clone_psr7_request(r, r.method, r.request_target, r.protocol_version, clone_header_values(r.headers),
			clone_header_names(r.header_names), request_body_or_empty(r), request_uri_or_default(r))
	}
	return clone_psr7_request(r, next_method, r.request_target, r.protocol_version, clone_header_values(r.headers),
		clone_header_names(r.header_names), request_body_or_empty(r), request_uri_or_default(r))
}

@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_method: 'getUri']
@[php_borrowed_return]
pub fn (r &VSlimPsr7Request) get_uri() &VSlimPsr7Uri {
	if r.uri_ref == unsafe { nil } {
		unsafe {
			mut writable := &VSlimPsr7Request(r)
			writable.uri_ref = new_psr7_uri('/')
		}
	}
	return r.uri_ref
}

@[php_arg_type: 'uri=Psr\\Http\\Message\\UriInterface']
@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_arg_name: 'preserve_host=preserveHost']
@[php_arg_default: 'preserve_host=false']
@[php_arg_optional: 'preserve_host']
@[php_method: 'withUri']
pub fn (r &VSlimPsr7Request) with_uri(uri vphp.RequestBorrowedZBox, preserve_host bool) &VSlimPsr7Request {
	next_uri := zval_to_psr7_uri(uri.to_zval())
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	current_host := headers[normalize_psr7_header_name('Host')] or { []string{} }
	if !preserve_host || current_host.len == 0 || current_host[0].trim_space() == '' {
		apply_psr7_host_header(mut headers, mut header_names, next_uri)
	}
	return clone_psr7_request(r, r.method, r.request_target, r.protocol_version, headers,
		header_names, request_body_or_empty(r), next_uri)
}

@[php_method]
pub fn (r &VSlimPsr7Request) str() string {
	return 'VSlim\\Psr7\\Request(method=${r.get_method()}, target=${r.get_request_target()})'
}

pub fn (mut r VSlimPsr7Request) cleanup() {
	if r.body_ref != unsafe { nil } {
		// `getBody()` is exported as a borrowed return; parent cleanup should only
		// sever the reference, not mutate the global vptr root table.
		r.body_ref = unsafe { nil }
	}
	if r.uri_ref != unsafe { nil } {
		// `getUri()` is exported as a borrowed return for PSR-7 requests.
		r.uri_ref = unsafe { nil }
	}
}

@[php_method]
pub fn (mut r VSlimPsr7ServerRequest) construct() &VSlimPsr7ServerRequest {
	r.method = 'GET'
	r.request_target = ''
	r.protocol_version = '1.1'
	if r.headers.len == 0 {
		r.headers = map[string][]string{}
	}
	if r.header_names.len == 0 {
		r.header_names = map[string]string{}
	}
	if r.body_ref == unsafe { nil } {
		r.body_ref = new_psr7_stream('')
	}
	if r.uri_ref == unsafe { nil } {
		r.uri_ref = new_psr7_uri('/')
	}
	if !r.server_params_ref.is_valid() || r.server_params_ref.is_null()
		|| r.server_params_ref.is_undef() {
		r.server_params_ref = empty_persistent_array()
	}
	if !r.cookie_params_ref.is_valid() || r.cookie_params_ref.is_null()
		|| r.cookie_params_ref.is_undef() {
		r.cookie_params_ref = empty_persistent_array()
	}
	if !r.query_params_ref.is_valid() || r.query_params_ref.is_null()
		|| r.query_params_ref.is_undef() {
		r.query_params_ref = empty_persistent_array()
	}
	if !r.uploaded_files_ref.is_valid() || r.uploaded_files_ref.is_null()
		|| r.uploaded_files_ref.is_undef() {
		r.uploaded_files_ref = empty_persistent_array()
	}
	if !r.attributes_ref.is_valid() || r.attributes_ref.is_null() || r.attributes_ref.is_undef() {
		r.attributes_ref = empty_persistent_array()
	}
	if !r.parsed_body_ref.is_valid() {
		r.parsed_body_ref = vphp.PersistentOwnedZBox.new_null()
	}
	return &r
}

@[php_method: 'getProtocolVersion']
pub fn (r &VSlimPsr7ServerRequest) get_protocol_version() string {
	return normalize_protocol_version(r.protocol_version)
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'withProtocolVersion']
pub fn (r &VSlimPsr7ServerRequest) with_protocol_version(version vphp.RequestBorrowedZBox) &VSlimPsr7ServerRequest {
	return clone_psr7_server_request(r, r.method, r.request_target, normalize_protocol_version(zval_to_log_message(version.to_zval())),
		clone_header_values(r.headers), clone_header_names(r.header_names), server_request_body_or_empty(r),
		server_request_uri_or_default(r), r.server_params_ref, r.cookie_params_ref, r.query_params_ref,
		r.uploaded_files_ref, r.parsed_body_ref, r.attributes_ref)
}

@[php_method: 'getHeaders']
pub fn (r &VSlimPsr7ServerRequest) get_headers() map[string][]string {
	return materialize_psr7_headers(r.headers, r.header_names)
}

@[php_method: 'hasHeader']
pub fn (r &VSlimPsr7ServerRequest) has_header(name vphp.RequestBorrowedZBox) bool {
	return normalize_psr7_header_name(zval_to_log_message(name.to_zval())) in r.headers
}

@[php_method: 'getHeader']
pub fn (r &VSlimPsr7ServerRequest) get_header(name vphp.RequestBorrowedZBox) []string {
	key := normalize_psr7_header_name(zval_to_log_message(name.to_zval()))
	return clone_header_list(r.headers[key] or { []string{} })
}

@[php_method: 'getHeaderLine']
pub fn (r &VSlimPsr7ServerRequest) get_header_line(name vphp.RequestBorrowedZBox) string {
	return r.get_header(name).join(', ')
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'withHeader']
pub fn (r &VSlimPsr7ServerRequest) with_header(name vphp.RequestBorrowedZBox, value vphp.RequestBorrowedZBox) &VSlimPsr7ServerRequest {
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	original_name := zval_to_log_message(name.to_zval()).trim_space()
	key := validate_psr7_header_name_or_throw(zval_to_log_message(name.to_zval())) or {
		return clone_psr7_server_request(r, r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names), server_request_body_or_empty(r),
			server_request_uri_or_default(r), r.server_params_ref, r.cookie_params_ref,
			r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref, r.attributes_ref)
	}
	values := zval_to_header_values(value.to_zval()) or {
		return clone_psr7_server_request(r, r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names), server_request_body_or_empty(r),
			server_request_uri_or_default(r), r.server_params_ref, r.cookie_params_ref,
			r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref, r.attributes_ref)
	}
	headers[key] = values
	header_names[key] = original_name
	return clone_psr7_server_request(r, r.method, r.request_target, r.protocol_version,
		headers, header_names, server_request_body_or_empty(r), server_request_uri_or_default(r),
		r.server_params_ref, r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref,
		r.parsed_body_ref, r.attributes_ref)
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'withAddedHeader']
pub fn (r &VSlimPsr7ServerRequest) with_added_header(name vphp.RequestBorrowedZBox, value vphp.RequestBorrowedZBox) &VSlimPsr7ServerRequest {
	original_name := zval_to_log_message(name.to_zval()).trim_space()
	key := validate_psr7_header_name_or_throw(zval_to_log_message(name.to_zval())) or {
		return clone_psr7_server_request(r, r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names), server_request_body_or_empty(r),
			server_request_uri_or_default(r), r.server_params_ref, r.cookie_params_ref,
			r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref, r.attributes_ref)
	}
	values := zval_to_header_values(value.to_zval()) or {
		return clone_psr7_server_request(r, r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names), server_request_body_or_empty(r),
			server_request_uri_or_default(r), r.server_params_ref, r.cookie_params_ref,
			r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref, r.attributes_ref)
	}
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	mut existing := headers[key] or { []string{} }
	existing << values
	headers[key] = existing
	if key !in header_names {
		header_names[key] = original_name
	}
	return clone_psr7_server_request(r, r.method, r.request_target, r.protocol_version,
		headers, header_names, server_request_body_or_empty(r), server_request_uri_or_default(r),
		r.server_params_ref, r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref,
		r.parsed_body_ref, r.attributes_ref)
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'withoutHeader']
pub fn (r &VSlimPsr7ServerRequest) without_header(name vphp.RequestBorrowedZBox) &VSlimPsr7ServerRequest {
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	key := normalize_psr7_header_name(zval_to_log_message(name.to_zval()))
	headers.delete(key)
	header_names.delete(key)
	return clone_psr7_server_request(r, r.method, r.request_target, r.protocol_version,
		headers, header_names, server_request_body_or_empty(r), server_request_uri_or_default(r),
		r.server_params_ref, r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref,
		r.parsed_body_ref, r.attributes_ref)
}

@[php_return_type: 'Psr\\Http\\Message\\StreamInterface']
@[php_method: 'getBody']
@[php_borrowed_return]
pub fn (r &VSlimPsr7ServerRequest) get_body() &VSlimPsr7Stream {
	if r.body_ref == unsafe { nil } {
		unsafe {
			mut writable := &VSlimPsr7ServerRequest(r)
			writable.body_ref = new_psr7_stream('')
		}
	}
	return r.body_ref
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_arg_type: 'body=Psr\\Http\\Message\\StreamInterface']
@[php_method: 'withBody']
pub fn (r &VSlimPsr7ServerRequest) with_body(body vphp.RequestBorrowedZBox) &VSlimPsr7ServerRequest {
	return clone_psr7_server_request(r, r.method, r.request_target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names), zval_to_psr7_stream(body.to_zval()),
		server_request_uri_or_default(r), r.server_params_ref, r.cookie_params_ref, r.query_params_ref,
		r.uploaded_files_ref, r.parsed_body_ref, r.attributes_ref)
}

pub fn (mut r VSlimPsr7ServerRequest) cleanup() {
	if r.body_ref != unsafe { nil } {
		// `getBody()` is exported as a borrowed return; nested stream refs are not
		// parent-owned vptr roots and must not be unregistered here.
		r.body_ref = unsafe { nil }
	}
	if r.uri_ref != unsafe { nil } {
		// `getUri()` is exported as a borrowed return for server requests.
		r.uri_ref = unsafe { nil }
	}
	// Note: other fields are PersistentOwnedZBox or native V,
	// generic_free_raw handles the boxes automatically.
}

@[php_method: 'getRequestTarget']
pub fn (r &VSlimPsr7ServerRequest) get_request_target() string {
	target := r.request_target.trim_space()
	if target != '' {
		return target
	}
	return build_psr7_request_target(server_request_uri_or_default(r))
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_arg_name: 'request_target=requestTarget']
@[php_method: 'withRequestTarget']
pub fn (r &VSlimPsr7ServerRequest) with_request_target(request_target vphp.RequestBorrowedZBox) &VSlimPsr7ServerRequest {
	target := validate_psr7_request_target_or_throw(zval_to_log_message(request_target.to_zval())) or {
		return clone_psr7_server_request(r, r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names), server_request_body_or_empty(r),
			server_request_uri_or_default(r), r.server_params_ref, r.cookie_params_ref,
			r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref, r.attributes_ref)
	}
	return clone_psr7_server_request(r, r.method, target, r.protocol_version, clone_header_values(r.headers),
		clone_header_names(r.header_names), server_request_body_or_empty(r), server_request_uri_or_default(r),
		r.server_params_ref, r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref,
		r.parsed_body_ref, r.attributes_ref)
}

@[php_method: 'getMethod']
pub fn (r &VSlimPsr7ServerRequest) get_method() string {
	return normalize_psr7_method(r.method)
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'withMethod']
pub fn (r &VSlimPsr7ServerRequest) with_method(method vphp.RequestBorrowedZBox) &VSlimPsr7ServerRequest {
	next_method := validate_psr7_method_or_throw(zval_to_log_message(method.to_zval())) or {
		return clone_psr7_server_request(r, r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names), server_request_body_or_empty(r),
			server_request_uri_or_default(r), r.server_params_ref, r.cookie_params_ref,
			r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref, r.attributes_ref)
	}
	return clone_psr7_server_request(r, next_method, r.request_target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names), server_request_body_or_empty(r),
		server_request_uri_or_default(r), r.server_params_ref, r.cookie_params_ref, r.query_params_ref,
		r.uploaded_files_ref, r.parsed_body_ref, r.attributes_ref)
}

@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_method: 'getUri']
@[php_borrowed_return]
pub fn (r &VSlimPsr7ServerRequest) get_uri() &VSlimPsr7Uri {
	if r.uri_ref == unsafe { nil } {
		unsafe {
			mut writable := &VSlimPsr7ServerRequest(r)
			writable.uri_ref = new_psr7_uri('/')
		}
	}
	return r.uri_ref
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_arg_type: 'uri=Psr\\Http\\Message\\UriInterface']
@[php_arg_name: 'preserve_host=preserveHost']
@[php_arg_default: 'preserve_host=false']
@[php_arg_optional: 'preserve_host']
@[php_method: 'withUri']
pub fn (r &VSlimPsr7ServerRequest) with_uri(uri vphp.RequestBorrowedZBox, preserve_host bool) &VSlimPsr7ServerRequest {
	next_uri := zval_to_psr7_uri(uri.to_zval())
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	current_host := headers[normalize_psr7_header_name('Host')] or { []string{} }
	if !preserve_host || current_host.len == 0 || current_host[0].trim_space() == '' {
		apply_psr7_host_header(mut headers, mut header_names, next_uri)
	}
	return clone_psr7_server_request(r, r.method, r.request_target, r.protocol_version,
		headers, header_names, server_request_body_or_empty(r), next_uri, r.server_params_ref,
		r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref,
		r.attributes_ref)
}

@[php_method: 'getServerParams']
@[php_return_type: 'array']
pub fn (r &VSlimPsr7ServerRequest) get_server_params() vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.adopt_zval(persistent_array_or_empty_zval(r.server_params_ref))
}

@[php_method: 'getCookieParams']
@[php_return_type: 'array']
pub fn (r &VSlimPsr7ServerRequest) get_cookie_params() vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.adopt_zval(persistent_array_or_empty_zval(r.cookie_params_ref))
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'withCookieParams']
pub fn (r &VSlimPsr7ServerRequest) with_cookie_params(cookies vphp.PhpArray) &VSlimPsr7ServerRequest {
	return clone_psr7_server_request(r, r.method, r.request_target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names), server_request_body_or_empty(r),
		server_request_uri_or_default(r), r.server_params_ref, persistent_array_owned(cookies.to_zval()),
		r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref, r.attributes_ref)
}

@[php_method: 'getQueryParams']
@[php_return_type: 'array']
pub fn (r &VSlimPsr7ServerRequest) get_query_params() vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.adopt_zval(persistent_array_or_empty_zval(r.query_params_ref))
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'withQueryParams']
pub fn (r &VSlimPsr7ServerRequest) with_query_params(query vphp.PhpArray) &VSlimPsr7ServerRequest {
	return clone_psr7_server_request(r, r.method, r.request_target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names), server_request_body_or_empty(r),
		server_request_uri_or_default(r), r.server_params_ref, r.cookie_params_ref, persistent_array_owned(query.to_zval()),
		r.uploaded_files_ref, r.parsed_body_ref, r.attributes_ref)
}

@[php_method: 'getUploadedFiles']
@[php_return_type: 'array']
pub fn (r &VSlimPsr7ServerRequest) get_uploaded_files() vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.adopt_zval(persistent_array_or_empty_zval(r.uploaded_files_ref))
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_arg_name: 'uploaded_files=uploadedFiles']
@[php_method: 'withUploadedFiles']
pub fn (r &VSlimPsr7ServerRequest) with_uploaded_files(uploaded_files vphp.RequestBorrowedZBox) &VSlimPsr7ServerRequest {
	return clone_psr7_server_request(r, r.method, r.request_target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names), server_request_body_or_empty(r),
		server_request_uri_or_default(r), r.server_params_ref, r.cookie_params_ref, r.query_params_ref,
		normalize_uploaded_files_tree(uploaded_files.to_zval()), r.parsed_body_ref, r.attributes_ref)
}

@[php_method: 'getParsedBody']
pub fn (r &VSlimPsr7ServerRequest) get_parsed_body() vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.adopt_zval(persistent_or_null(r.parsed_body_ref))
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_arg_name: 'parsed_body=parsedBody']
@[php_method: 'withParsedBody']
pub fn (r &VSlimPsr7ServerRequest) with_parsed_body(parsed_body vphp.RequestBorrowedZBox) &VSlimPsr7ServerRequest {
	if !is_valid_psr7_parsed_body(parsed_body.to_zval()) {
		vphp.PhpException.raise_class('InvalidArgumentException', 'parsed body must be null, an array, or an object',
			0)
		return clone_psr7_server_request(r, r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names), server_request_body_or_empty(r),
			server_request_uri_or_default(r), r.server_params_ref, r.cookie_params_ref,
			r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref, r.attributes_ref)
	}
	return clone_psr7_server_request(r, r.method, r.request_target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names), server_request_body_or_empty(r),
		server_request_uri_or_default(r), r.server_params_ref, r.cookie_params_ref, r.query_params_ref,
		r.uploaded_files_ref, persistent_owned_or_null(parsed_body.to_zval()), r.attributes_ref)
}

@[php_method: 'getAttributes']
@[php_return_type: 'array']
pub fn (r &VSlimPsr7ServerRequest) get_attributes() vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.from_zval(persistent_array_or_empty_zval(r.attributes_ref))
}

@[php_arg_name: 'default_value=defaultValue']
@[php_method: 'getAttribute']
pub fn (r &VSlimPsr7ServerRequest) get_attribute(name vphp.RequestBorrowedZBox, default_value ?vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	key := zval_to_log_message(name.to_zval())
	if key == '' {
		return psr7_default_value_or_null(default_value)
	}
	return r.attributes_ref.with_request_zval(fn [key, default_value] (attrs vphp.ZVal) vphp.RequestOwnedZBox {
		if !attrs.is_array() {
			return psr7_default_value_or_null(default_value)
		}
		value := attrs.get(key) or { return psr7_default_value_or_null(default_value) }
		return vphp.RequestOwnedZBox.adopt_zval(value.dup())
	})
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'withAttribute']
pub fn (r &VSlimPsr7ServerRequest) with_attribute(name vphp.RequestBorrowedZBox, value vphp.RequestBorrowedZBox) &VSlimPsr7ServerRequest {
	key := zval_to_log_message(name.to_zval())
	next_attrs := persistent_assoc_with_value(r.attributes_ref, key, value.to_zval())
	return clone_psr7_server_request_owned_attrs(r, r.method, r.request_target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names), server_request_body_or_empty(r),
		server_request_uri_or_default(r), r.server_params_ref, r.cookie_params_ref, r.query_params_ref,
		r.uploaded_files_ref, r.parsed_body_ref, next_attrs)
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'withoutAttribute']
pub fn (r &VSlimPsr7ServerRequest) without_attribute(name vphp.RequestBorrowedZBox) &VSlimPsr7ServerRequest {
	key := zval_to_log_message(name.to_zval())
	next_attrs := persistent_assoc_without_key(r.attributes_ref, key)
	return clone_psr7_server_request_owned_attrs(r, r.method, r.request_target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names), server_request_body_or_empty(r),
		server_request_uri_or_default(r), r.server_params_ref, r.cookie_params_ref, r.query_params_ref,
		r.uploaded_files_ref, r.parsed_body_ref, next_attrs)
}

@[php_method]
pub fn (r &VSlimPsr7ServerRequest) str() string {
	return 'VSlim\\Psr7\\ServerRequest(method=${r.get_method()}, target=${r.get_request_target()})'
}

@[php_arg_name: 'default_uri=defaultUri']
@[php_arg_default: 'default_uri=""']
@[php_arg_optional: 'default_uri']
@[php_method]
pub fn (mut u VSlimPsr7Uri) construct(default_uri string) &VSlimPsr7Uri {
	parsed := parse_psr7_uri(default_uri)
	u.scheme = parsed.scheme
	u.user = parsed.user
	u.password = parsed.password
	u.host = parsed.host
	u.port = parsed.port
	u.path = parsed.path
	u.query = parsed.query
	u.fragment = parsed.fragment
	return &u
}

@[php_method]
pub fn (u &VSlimPsr7Uri) str() string {
	return build_psr7_uri_string(u)
}

@[php_method: 'getScheme']
pub fn (u &VSlimPsr7Uri) get_scheme() string {
	return normalize_psr7_scheme(u.scheme)
}

@[php_method: 'getAuthority']
pub fn (u &VSlimPsr7Uri) get_authority() string {
	return build_psr7_authority(u)
}

@[php_method: 'getUserInfo']
pub fn (u &VSlimPsr7Uri) get_user_info() string {
	if u.user == '' {
		return ''
	}
	if u.password == '' {
		return u.user
	}
	return '${u.user}:${u.password}'
}

@[php_method: 'getHost']
pub fn (u &VSlimPsr7Uri) get_host() string {
	return normalize_psr7_host(u.host)
}

@[php_method: 'getPort']
pub fn (u &VSlimPsr7Uri) get_port() ?int {
	port := normalize_psr7_port(u.port)
	if port <= 0 {
		return none
	}
	scheme := normalize_psr7_scheme(u.scheme)
	if standard := default_port_for_scheme(scheme) {
		if port == standard {
			return none
		}
	}
	return port
}

@[php_method: 'getPath']
pub fn (u &VSlimPsr7Uri) get_path() string {
	return u.path
}

@[php_method: 'getQuery']
pub fn (u &VSlimPsr7Uri) get_query() string {
	return normalize_psr7_query(u.query)
}

@[php_method: 'getFragment']
pub fn (u &VSlimPsr7Uri) get_fragment() string {
	return normalize_psr7_fragment(u.fragment)
}

@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_method: 'withScheme']
pub fn (u &VSlimPsr7Uri) with_scheme(scheme vphp.RequestBorrowedZBox) &VSlimPsr7Uri {
	return clone_psr7_uri(u, zval_to_log_message(scheme.to_zval()), u.user, u.password,
		u.host, u.port, u.path, u.query, u.fragment)
}

@[php_arg_name: 'default_password=defaultPassword']
@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_arg_default: 'default_password=""']
@[php_arg_optional: 'default_password']
@[php_method: 'withUserInfo']
pub fn (u &VSlimPsr7Uri) with_user_info(user vphp.RequestBorrowedZBox, default_password vphp.RequestBorrowedZBox) &VSlimPsr7Uri {
	return clone_psr7_uri(u, u.scheme, zval_to_log_message(user.to_zval()), zval_or_empty_string(default_password.to_zval()),
		u.host, u.port, u.path, u.query, u.fragment)
}

@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_method: 'withHost']
pub fn (u &VSlimPsr7Uri) with_host(host vphp.RequestBorrowedZBox) &VSlimPsr7Uri {
	return clone_psr7_uri(u, u.scheme, u.user, u.password, zval_to_log_message(host.to_zval()),
		u.port, u.path, u.query, u.fragment)
}

@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_method: 'withPort']
pub fn (u &VSlimPsr7Uri) with_port(port vphp.RequestBorrowedZBox) &VSlimPsr7Uri {
	return clone_psr7_uri(u, u.scheme, u.user, u.password, u.host, zval_to_psr7_port(port.to_zval()),
		u.path, u.query, u.fragment)
}

@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_method: 'withPath']
pub fn (u &VSlimPsr7Uri) with_path(path vphp.RequestBorrowedZBox) &VSlimPsr7Uri {
	return clone_psr7_uri(u, u.scheme, u.user, u.password, u.host, u.port, zval_to_log_message(path.to_zval()),
		u.query, u.fragment)
}

@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_method: 'withQuery']
pub fn (u &VSlimPsr7Uri) with_query(query vphp.RequestBorrowedZBox) &VSlimPsr7Uri {
	return clone_psr7_uri(u, u.scheme, u.user, u.password, u.host, u.port, u.path, zval_to_log_message(query.to_zval()),
		u.fragment)
}

@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_method: 'withFragment']
pub fn (u &VSlimPsr7Uri) with_fragment(fragment vphp.RequestBorrowedZBox) &VSlimPsr7Uri {
	return clone_psr7_uri(u, u.scheme, u.user, u.password, u.host, u.port, u.path, u.query,
		zval_to_log_message(fragment.to_zval()))
}

@[php_method]
pub fn (mut f VSlimPsr17ResponseFactory) construct() &VSlimPsr17ResponseFactory {
	return &f
}

@[php_method]
pub fn (mut f VSlimPsr17RequestFactory) construct() &VSlimPsr17RequestFactory {
	return &f
}

@[php_method]
pub fn (mut f VSlimPsr17ServerRequestFactory) construct() &VSlimPsr17ServerRequestFactory {
	return &f
}

@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_method: 'createRequest']
pub fn (f &VSlimPsr17RequestFactory) create_request(method vphp.RequestBorrowedZBox, uri vphp.RequestBorrowedZBox) &VSlimPsr7Request {
	return new_psr7_request(validate_psr7_method_or_fallback(zval_to_log_message(method.to_zval()),
		'GET'), uri.to_zval())
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_arg_name: 'default_server_params=defaultServerParams']
@[php_arg_type: 'default_server_params=array']
@[php_arg_default: 'default_server_params=[]']
@[php_arg_optional: 'default_server_params']
@[php_method: 'createServerRequest']
pub fn (f &VSlimPsr17ServerRequestFactory) create_server_request(method vphp.RequestBorrowedZBox, uri vphp.RequestBorrowedZBox, default_server_params vphp.RequestBorrowedZBox) &VSlimPsr7ServerRequest {
	return new_psr7_server_request(validate_psr7_method_or_fallback(zval_to_log_message(method.to_zval()),
		'GET'), uri.to_zval(), default_server_params.to_zval())
}

@[params]
struct VSlimPsr17CreateResponseParams {
	status        int    = 200
	reason_phrase string = ''
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'createResponse']
pub fn (f &VSlimPsr17ResponseFactory) create_response(params VSlimPsr17CreateResponseParams) &VSlimPsr7Response {
	status := validate_psr17_response_status_or_throw(params.status) or {
		return &VSlimPsr7Response{
			status:           200
			reason_phrase:    'OK'
			protocol_version: '1.1'
			headers:          map[string][]string{}
			body_ref:         new_psr7_stream('')
		}
	}
	return &VSlimPsr7Response{
		status:           status
		reason_phrase:    normalize_reason_phrase(status, params.reason_phrase)
		protocol_version: '1.1'
		headers:          map[string][]string{}
		body_ref:         new_psr7_stream('')
	}
}

@[php_method]
pub fn (mut f VSlimPsr17StreamFactory) construct() &VSlimPsr17StreamFactory {
	return &f
}

@[php_method]
pub fn (mut f VSlimPsr17UploadedFileFactory) construct() &VSlimPsr17UploadedFileFactory {
	return &f
}

@[php_return_type: 'Psr\\Http\\Message\\StreamInterface']
@[php_arg_name: 'default_content=defaultContent']
@[php_arg_default: 'default_content=""']
@[php_arg_optional: 'default_content']
@[php_method: 'createStream']
pub fn (f &VSlimPsr17StreamFactory) create_stream(default_content vphp.RequestBorrowedZBox) &VSlimPsr7Stream {
	return new_psr7_stream(zval_or_empty_string(default_content.to_zval()))
}

@[php_return_type: 'Psr\\Http\\Message\\StreamInterface']
@[php_arg_name: 'default_mode=defaultMode']
@[php_method: 'createStreamFromFile']
@[php_arg_default: 'default_mode="r"']
@[php_arg_optional: 'default_mode']
pub fn (f &VSlimPsr17StreamFactory) create_stream_from_file(filename vphp.RequestBorrowedZBox, default_mode vphp.RequestBorrowedZBox) &VSlimPsr7Stream {
	return build_psr7_stream_from_file(zval_to_log_message(filename.to_zval()), zval_or_empty_string(default_mode.to_zval()))
}

@[php_return_type: 'Psr\\Http\\Message\\StreamInterface']
@[php_method: 'createStreamFromResource']
pub fn (f &VSlimPsr17StreamFactory) create_stream_from_resource(resource vphp.RequestBorrowedZBox) &VSlimPsr7Stream {
	return build_psr7_stream_from_resource(resource.to_zval())
}

@[php_method]
pub fn (mut f VSlimPsr17UriFactory) construct() &VSlimPsr17UriFactory {
	return &f
}

@[php_arg_name: 'default_size=defaultSize,default_error=defaultError,default_client_filename=defaultClientFilename,default_client_media_type=defaultClientMediaType']
@[php_arg_default: 'default_size=null,default_error=0,default_client_filename=null,default_client_media_type=null']
@[php_arg_optional: 'default_size,default_error,default_client_filename,default_client_media_type']
@[php_arg_type: 'stream=Psr\\Http\\Message\\StreamInterface']
@[php_return_type: 'Psr\\Http\\Message\\UploadedFileInterface']
@[php_method: 'createUploadedFile']
pub fn (f &VSlimPsr17UploadedFileFactory) create_uploaded_file(stream vphp.RequestBorrowedZBox, default_size vphp.RequestBorrowedZBox, default_error vphp.RequestBorrowedZBox, default_client_filename vphp.RequestBorrowedZBox, default_client_media_type vphp.RequestBorrowedZBox) &VSlimPsr7UploadedFile {
	return new_psr7_uploaded_file(zval_to_psr7_stream(stream.to_zval()), zval_to_optional_size(default_size.to_zval()),
		zval_to_upload_error_or(default_error.to_zval(), 0), zval_to_optional_trimmed_string(default_client_filename.to_zval()),
		zval_to_optional_trimmed_string(default_client_media_type.to_zval()))
}

@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_arg_name: 'default_uri=defaultUri']
@[php_arg_default: 'default_uri=""']
@[php_arg_optional: 'default_uri']
@[php_method: 'createUri']
pub fn (f &VSlimPsr17UriFactory) create_uri(default_uri vphp.RequestBorrowedZBox) &VSlimPsr7Uri {
	return new_psr7_uri(zval_or_empty_string(default_uri.to_zval()))
}

fn new_psr7_stream(content string) &VSlimPsr7Stream {
	return &VSlimPsr7Stream{
		content:  content
		position: 0
		detached: false
		metadata: default_psr7_stream_metadata()
	}
}

fn new_psr7_uploaded_file(stream &VSlimPsr7Stream, size ?int, error int, client_filename ?string, client_media_type ?string) &VSlimPsr7UploadedFile {
	return &VSlimPsr7UploadedFile{
		stream_ref:        stream
		size_hint:         uploaded_file_size_hint(size, stream)
		error_code:        normalize_uploaded_file_error(error)
		client_filename:   client_filename or { '' }
		client_media_type: client_media_type or { '' }
		moved:             false
		target_path:       ''
	}
}

fn new_psr7_request(method string, uri_input vphp.ZVal) &VSlimPsr7Request {
	uri := zval_to_psr7_uri(uri_input)
	mut headers := map[string][]string{}
	mut header_names := map[string]string{}
	apply_psr7_host_header(mut headers, mut header_names, uri)
	return &VSlimPsr7Request{
		method:           method
		request_target:   ''
		protocol_version: '1.1'
		headers:          headers
		header_names:     header_names
		body_ref:         new_psr7_stream('')
		uri_ref:          uri
	}
}

fn new_psr7_server_request(method string, uri_input vphp.ZVal, server_params_input vphp.ZVal) &VSlimPsr7ServerRequest {
	uri := zval_to_psr7_uri(uri_input)
	mut headers := map[string][]string{}
	mut header_names := map[string]string{}
	apply_psr7_host_header(mut headers, mut header_names, uri)
	mut out := &VSlimPsr7ServerRequest{}
	out.method = method
	out.request_target = ''
	out.protocol_version = '1.1'
	out.headers = clone_header_values(headers)
	out.header_names = clone_header_names(header_names)
	out.body_ref = new_psr7_stream('')
	out.uri_ref = uri
	out.server_params_ref = persistent_array_owned(server_params_input)
	out.cookie_params_ref = empty_persistent_array()
	out.query_params_ref = string_map_to_persistent_array(VSlimRequest.parse_query(normalize_psr7_query(uri.query)))
	out.uploaded_files_ref = empty_persistent_array()
	out.parsed_body_ref = vphp.PersistentOwnedZBox.invalid()
	out.attributes_ref = empty_persistent_array()
	return out
}

fn new_psr7_uri(raw string) &VSlimPsr7Uri {
	parsed := parse_psr7_uri(raw)
	return &VSlimPsr7Uri{
		scheme:   parsed.scheme
		user:     parsed.user
		password: parsed.password
		host:     parsed.host
		port:     parsed.port
		path:     parsed.path
		query:    parsed.query
		fragment: parsed.fragment
	}
}

fn response_body_or_empty(r &VSlimPsr7Response) &VSlimPsr7Stream {
	if r.body_ref != unsafe { nil } {
		return r.body_ref
	}
	return new_psr7_stream('')
}

fn request_body_or_empty(r &VSlimPsr7Request) &VSlimPsr7Stream {
	if r.body_ref != unsafe { nil } {
		return r.body_ref
	}
	return new_psr7_stream('')
}

fn request_uri_or_default(r &VSlimPsr7Request) &VSlimPsr7Uri {
	if r.uri_ref != unsafe { nil } {
		return r.uri_ref
	}
	return new_psr7_uri('/')
}

fn server_request_body_or_empty(r &VSlimPsr7ServerRequest) &VSlimPsr7Stream {
	if r.body_ref != unsafe { nil } {
		return r.body_ref
	}
	return new_psr7_stream('')
}

fn server_request_uri_or_default(r &VSlimPsr7ServerRequest) &VSlimPsr7Uri {
	if r.uri_ref != unsafe { nil } {
		return r.uri_ref
	}
	return new_psr7_uri('/')
}

fn clone_psr7_response(r &VSlimPsr7Response, protocol_version string, headers map[string][]string, header_names map[string]string, body &VSlimPsr7Stream, status int, reason_phrase string) &VSlimPsr7Response {
	resolved_status := default_psr7_status(status)
	return &VSlimPsr7Response{
		status:           resolved_status
		reason_phrase:    normalize_reason_phrase(resolved_status, reason_phrase).clone()
		protocol_version: normalize_protocol_version(protocol_version).clone()
		headers:          clone_header_values(headers)
		header_names:     clone_header_names(header_names)
		body_ref:         clone_psr7_stream(body)
	}
}

fn clone_psr7_request(r &VSlimPsr7Request, method string, request_target string, protocol_version string, headers map[string][]string, header_names map[string]string, body &VSlimPsr7Stream, uri &VSlimPsr7Uri) &VSlimPsr7Request {
	return &VSlimPsr7Request{
		method:           method.clone()
		request_target:   request_target.clone()
		protocol_version: normalize_protocol_version(protocol_version).clone()
		headers:          clone_header_values(headers)
		header_names:     clone_header_names(header_names)
		body_ref:         clone_psr7_stream(body)
		uri_ref:          clone_psr7_uri_or_default(uri)
	}
}

fn clone_psr7_server_request(r &VSlimPsr7ServerRequest, method string, request_target string, protocol_version string, headers map[string][]string, header_names map[string]string, body &VSlimPsr7Stream, uri &VSlimPsr7Uri, server_params_ref vphp.PersistentOwnedZBox, cookie_params_ref vphp.PersistentOwnedZBox, query_params_ref vphp.PersistentOwnedZBox, uploaded_files_ref vphp.PersistentOwnedZBox, parsed_body_ref vphp.PersistentOwnedZBox, attributes_ref vphp.PersistentOwnedZBox) &VSlimPsr7ServerRequest {
	return clone_psr7_server_request_owned_attrs(r, method, request_target, protocol_version,
		headers, header_names, body, uri, server_params_ref, cookie_params_ref, query_params_ref,
		uploaded_files_ref, parsed_body_ref, clone_assoc_payload_ref(attributes_ref))
}

fn clone_psr7_server_request_owned_attrs(r &VSlimPsr7ServerRequest, method string, request_target string, protocol_version string, headers map[string][]string, header_names map[string]string, body &VSlimPsr7Stream, uri &VSlimPsr7Uri, server_params_ref vphp.PersistentOwnedZBox, cookie_params_ref vphp.PersistentOwnedZBox, query_params_ref vphp.PersistentOwnedZBox, uploaded_files_ref vphp.PersistentOwnedZBox, parsed_body_ref vphp.PersistentOwnedZBox, attributes_ref vphp.PersistentOwnedZBox) &VSlimPsr7ServerRequest {
	mut out := &VSlimPsr7ServerRequest{}
	out.method = method.clone()
	out.request_target = request_target.clone()
	out.protocol_version = normalize_protocol_version(protocol_version).clone()
	out.headers = clone_header_values(headers)
	out.header_names = clone_header_names(header_names)
	out.body_ref = clone_psr7_stream(body)
	out.uri_ref = clone_psr7_uri_or_default(uri)
	out.server_params_ref = clone_assoc_payload_ref(server_params_ref)
	out.cookie_params_ref = clone_assoc_payload_ref(cookie_params_ref)
	out.query_params_ref = clone_assoc_payload_ref(query_params_ref)
	out.uploaded_files_ref = clone_assoc_payload_ref(uploaded_files_ref)
	out.parsed_body_ref = clone_parsed_body_ref(parsed_body_ref)
	out.attributes_ref = clone_assoc_payload_ref(attributes_ref)
	return out
}

fn clone_assoc_payload_ref(value vphp.PersistentOwnedZBox) vphp.PersistentOwnedZBox {
	if !value.is_valid() || value.is_undef() || value.is_null() {
		return empty_persistent_array()
	}
	return value.clone()
}

fn clone_parsed_body_ref(value vphp.PersistentOwnedZBox) vphp.PersistentOwnedZBox {
	if !value.is_valid() || value.is_undef() || value.is_null() {
		return vphp.PersistentOwnedZBox.new_null()
	}
	return value.clone()
}

fn clone_psr7_stream(stream &VSlimPsr7Stream) &VSlimPsr7Stream {
	if stream == unsafe { nil } {
		return new_psr7_stream('')
	}
	return &VSlimPsr7Stream{
		content:  stream.content.clone()
		position: stream.position
		detached: stream.detached
		metadata: stream.metadata.clone()
	}
}

fn clone_psr7_uri_or_default(uri &VSlimPsr7Uri) &VSlimPsr7Uri {
	if uri == unsafe { nil } {
		return new_psr7_uri('/')
	}
	return clone_psr7_uri(uri, uri.scheme, uri.user, uri.password, uri.host, uri.port,
		uri.path, uri.query, uri.fragment)
}

fn clone_psr7_uri(u &VSlimPsr7Uri, scheme string, user string, password string, host string, port int, path string, query string, fragment string) &VSlimPsr7Uri {
	return &VSlimPsr7Uri{
		scheme:   normalize_psr7_scheme(scheme).clone()
		user:     user.clone()
		password: password.clone()
		host:     normalize_psr7_host(host).clone()
		port:     normalize_psr7_port(port)
		path:     normalize_psr7_path(path, normalize_psr7_host(host)).clone()
		query:    normalize_psr7_query(query).clone()
		fragment: normalize_psr7_fragment(fragment).clone()
	}
}

fn clone_header_values(headers map[string][]string) map[string][]string {
	mut out := map[string][]string{}
	for key, values in headers {
		out[key.clone()] = clone_header_list(values)
	}
	return out
}

fn clone_header_list(values []string) []string {
	mut out := []string{}
	for value in values {
		out << value.clone()
	}
	return out
}

fn clone_header_names(header_names map[string]string) map[string]string {
	mut out := map[string]string{}
	for key, value in header_names {
		out[key.clone()] = value.clone()
	}
	return out
}

fn materialize_psr7_headers(headers map[string][]string, header_names map[string]string) map[string][]string {
	mut out := map[string][]string{}
	for key, values in headers {
		resolved_name := (header_names[key] or { key }).clone()
		out[resolved_name] = clone_header_list(values)
	}
	return out
}

fn zval_to_header_values(value vphp.ZVal) ?[]string {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return []string{}
	}
	if value.is_array() {
		mut out := []string{}
		for entry in value.to_string_list() {
			if !is_valid_psr7_header_value(entry) {
				vphp.PhpException.raise_class('InvalidArgumentException', 'header values must not contain CR or LF characters',
					0)
				return none
			}
			out << entry.trim_space()
		}
		return out
	}
	entry := value.to_string()
	if !is_valid_psr7_header_value(entry) {
		vphp.PhpException.raise_class('InvalidArgumentException', 'header values must not contain CR or LF characters',
			0)
		return none
	}
	return [entry.trim_space()]
}

fn zval_to_psr7_port(value vphp.ZVal) int {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return -1
	}
	port := int(value.to_i64())
	if port < 1 || port > 65535 {
		vphp.PhpException.raise_class('InvalidArgumentException', 'port must be null or an integer between 1 and 65535',
			0)
		return -1
	}
	return port
}

fn zval_to_psr7_uri(value vphp.ZVal) &VSlimPsr7Uri {
	if value.is_valid() && value.is_object()
		&& (value.is_instance_of('VSlim\\Psr7\\Uri') || value.is_instance_of('VSlimPsr7Uri')) {
		return unsafe { &VSlimPsr7Uri(C.vphp_get_v_ptr_from_zval(value.raw)) }
	}
	if value.is_valid() && value.is_object() && value.method_exists('__toString') {
		return vphp.PhpObject.borrowed(value).with_method_result_zval('__toString', []vphp.ZVal{}, fn (raw vphp.ZVal) &VSlimPsr7Uri {
			return new_psr7_uri(raw.to_string())
		})
	}
	return new_psr7_uri(zval_to_log_message(value))
}

fn zval_to_string_map(value vphp.ZVal) map[string]string {
	if !value.is_valid() || value.is_null() || value.is_undef() || !value.is_array() {
		return map[string]string{}
	}
	return value.to_string_map()
}

fn string_map_to_persistent_array(values map[string]string) vphp.PersistentOwnedZBox {
	mut out := new_array_zval()
	for key, value in values {
		add_assoc_zval(out, key, vphp.RequestOwnedZBox.new_string(value).to_zval())
	}
	return vphp.PersistentOwnedZBox.of(out)
}

fn persistent_array_or_empty_zval(value vphp.PersistentOwnedZBox) vphp.ZVal {
	if !value.is_valid() || value.is_null() || value.is_undef() || !value.is_array() {
		return new_array_zval()
	}
	return value.with_request_zval(fn (z vphp.ZVal) vphp.ZVal {
		return z.dup()
	})
}

fn persistent_array_to_string_map(value vphp.PersistentOwnedZBox) map[string]string {
	if !value.is_valid() || value.is_null() || value.is_undef() || !value.is_array() {
		return map[string]string{}
	}
	return value.with_request_zval(fn (z vphp.ZVal) map[string]string {
		return zval_to_string_map(z)
	})
}

fn zval_to_psr7_stream(value vphp.ZVal) &VSlimPsr7Stream {
	if value.is_valid() && value.is_object()
		&& (value.is_instance_of('VSlim\\Psr7\\Stream') || value.is_instance_of('VSlimPsr7Stream')) {
		return unsafe { &VSlimPsr7Stream(C.vphp_get_v_ptr_from_zval(value.raw)) }
	}
	if value.is_valid() && value.is_object() && value.method_exists('__toString') {
		return vphp.PhpObject.borrowed(value).with_method_result_zval('__toString', []vphp.ZVal{}, fn (raw vphp.ZVal) &VSlimPsr7Stream {
			return new_psr7_stream(raw.to_string())
		})
	}
	return new_psr7_stream(zval_to_log_message(value))
}

fn zval_or_empty_string(value vphp.ZVal) string {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return ''
	}
	return value.to_string()
}

fn zval_to_bool_or(value vphp.ZVal, default_value bool) bool {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return default_value
	}
	return value.to_bool()
}

fn zval_to_psr7_seek_whence(value vphp.ZVal) int {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return 0
	}
	return int(value.to_i64())
}

fn zval_to_psr17_response_status(value vphp.ZVal) int {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return 200
	}
	return int(value.to_i64())
}

fn zval_to_optional_size(value vphp.ZVal) ?int {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return none
	}
	size := int(value.to_i64())
	return if size < 0 { none } else { size }
}

fn zval_to_upload_error_or(value vphp.ZVal, default_value int) int {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return default_value
	}
	return int(value.to_i64())
}

fn empty_persistent_array() vphp.PersistentOwnedZBox {
	return vphp.PersistentOwnedZBox.of(new_array_zval())
}

fn zval_to_optional_trimmed_string(value vphp.ZVal) ?string {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return none
	}
	return value.to_string().trim_space()
}

fn persistent_array_owned(value vphp.ZVal) vphp.PersistentOwnedZBox {
	if value.is_valid() && !value.is_null() && !value.is_undef() && value.is_array() {
		return vphp.PersistentOwnedZBox.of(value)
	}
	return empty_persistent_array()
}

fn persistent_owned_or_null(value vphp.ZVal) vphp.PersistentOwnedZBox {
	if value.is_valid() && !value.is_undef() && !value.is_null() {
		return vphp.PersistentOwnedZBox.of(value)
	}
	return vphp.PersistentOwnedZBox.new_null()
}

fn persistent_or_null(value vphp.PersistentOwnedZBox) vphp.ZVal {
	if !value.is_valid() || value.is_undef() {
		return vphp.ZVal.new_null()
	}
	return value.with_request_zval(fn (z vphp.ZVal) vphp.ZVal {
		return z.dup()
	})
}

fn persistent_assoc_zvals(value vphp.PersistentOwnedZBox) map[string]vphp.ZVal {
	if !value.is_valid() || value.is_null() || value.is_undef() || !value.is_array() {
		return map[string]vphp.ZVal{}
	}
	return value.with_request_zval(fn (z vphp.ZVal) map[string]vphp.ZVal {
		return z.foreach_with_ctx[map[string]vphp.ZVal](map[string]vphp.ZVal{}, fn (key vphp.ZVal, child vphp.ZVal, mut acc map[string]vphp.ZVal) {
			acc[key.to_string()] = child
		})
	})
}

fn persistent_assoc_with_value(value vphp.PersistentOwnedZBox, key string, child vphp.ZVal) vphp.PersistentOwnedZBox {
	mut out := new_array_zval()
	if key == '' {
		return vphp.PersistentOwnedZBox.of(out)
	}
	if value.is_valid() && !value.is_null() && !value.is_undef() && value.is_array() {
		value.with_request_zval(fn [mut out] (raw vphp.ZVal) bool {
			raw.foreach(fn [mut out] (key vphp.ZVal, val vphp.ZVal) {
				if key.is_string() {
					add_assoc_zval(out, key.get_string(), val.dup())
				}
			})
			return true
		})
	}
	add_assoc_zval(out, key, child.dup())
	return vphp.PersistentOwnedZBox.of(out)
}

fn persistent_assoc_without_key(value vphp.PersistentOwnedZBox, key string) vphp.PersistentOwnedZBox {
	mut out := new_array_zval()
	if value.is_valid() && !value.is_null() && !value.is_undef() && value.is_array() {
		value.with_request_zval(fn [mut out, key] (raw vphp.ZVal) bool {
			raw.foreach(fn [mut out, key] (k vphp.ZVal, val vphp.ZVal) {
				if k.is_string() && k.get_string() != key {
					add_assoc_zval(out, k.get_string(), val.dup())
				}
			})
			return true
		})
	}
	return vphp.PersistentOwnedZBox.of(out)
}

fn normalize_uploaded_file_error(code int) int {
	return if code < 0 || code > 8 { 0 } else { code }
}

fn uploaded_file_size_hint(size ?int, stream &VSlimPsr7Stream) int {
	if explicit := size {
		return if explicit < 0 { -1 } else { explicit }
	}
	if stream != unsafe { nil } {
		if measured := stream.get_size() {
			return measured
		}
	}
	return -1
}

fn is_uploaded_file_leaf(value vphp.ZVal) bool {
	return value.is_valid() && value.is_object()
		&& (value.is_instance_of('VSlim\\Psr7\\UploadedFile')
		|| value.is_instance_of('VSlimPsr7UploadedFile')
		|| value.is_instance_of('Psr\\Http\\Message\\UploadedFileInterface'))
}

fn uploaded_files_tree_is_valid(value vphp.ZVal) bool {
	if !value.is_valid() || value.is_null() || value.is_undef() || !value.is_array() {
		return false
	}
	keys := value.keys()
	for idx := 0; idx < keys.array_count(); idx++ {
		key := keys.array_get(idx)
		child := value.get_key(key) or { return false }
		if child.is_array() {
			if !uploaded_files_tree_is_valid(child) {
				return false
			}
			continue
		}
		if !is_uploaded_file_leaf(child) {
			return false
		}
	}
	return true
}

fn normalize_uploaded_files_tree(value vphp.ZVal) vphp.PersistentOwnedZBox {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return empty_persistent_array()
	}
	if !uploaded_files_tree_is_valid(value) {
		vphp.PhpException.raise_class('InvalidArgumentException', 'uploaded files must be an array tree of UploadedFileInterface instances',
			0)
		return empty_persistent_array()
	}
	return vphp.PersistentOwnedZBox.of(value)
}

fn normalize_psr7_header_name(name string) string {
	return VSlimRequest.normalize_header_name(name)
}

fn validate_psr7_header_name_or_throw(name string) ?string {
	key := normalize_psr7_header_name(name)
	if key == '' || !is_valid_psr7_header_name(key) {
		vphp.PhpException.raise_class('InvalidArgumentException', 'header name must be a non-empty RFC 7230 token',
			0)
		return none
	}
	return key
}

fn normalize_psr7_method(method string) string {
	trimmed := method.trim_space()
	return if trimmed == '' { 'GET' } else { trimmed }
}

fn validate_psr7_method_or_throw(method string) ?string {
	trimmed := method.trim_space()
	if trimmed == '' {
		vphp.PhpException.raise_class('InvalidArgumentException', 'HTTP method must be a non-empty token',
			0)
		return none
	}
	for ch in trimmed.bytes() {
		if ch <= 32 || ch == 127 {
			vphp.PhpException.raise_class('InvalidArgumentException', 'HTTP method must be a non-empty token',
				0)
			return none
		}
	}
	return trimmed
}

fn validate_psr7_method_or_fallback(method string, fallback string) string {
	return validate_psr7_method_or_throw(method) or { fallback }
}

fn normalize_psr7_scheme(scheme string) string {
	return scheme.trim_space().trim_right(':').to_lower()
}

fn normalize_psr7_host(host string) string {
	return host.trim_space().to_lower()
}

fn normalize_psr7_path(path string, host string) string {
	mut clean := path
	if host != '' && clean != '' && !clean.starts_with('/') {
		clean = '/' + clean
	}
	if host == '' && clean.starts_with('//') {
		clean = '/' + clean.trim_left('/')
	}
	return clean
}

fn normalize_psr7_query(query string) string {
	return query.trim_space().trim_left('?')
}

fn normalize_psr7_fragment(fragment string) string {
	return fragment.trim_space().trim_left('#')
}

fn normalize_psr7_port(port int) int {
	return if port <= 0 { -1 } else { port }
}

fn normalize_protocol_version(version string) string {
	trimmed := version.trim_space()
	return if trimmed == '' { '1.1' } else { trimmed }
}

fn validate_psr7_request_target_or_throw(request_target string) ?string {
	trimmed := request_target.trim_space()
	if trimmed == '' {
		vphp.PhpException.raise_class('InvalidArgumentException', 'request target must be a non-empty string without whitespace',
			0)
		return none
	}
	for ch in request_target.bytes() {
		if ch == ` ` || ch == `\t` || ch == `\r` || ch == `\n` {
			vphp.PhpException.raise_class('InvalidArgumentException', 'request target must be a non-empty string without whitespace',
				0)
			return none
		}
	}
	return request_target
}

fn default_psr7_status(status int) int {
	return if status <= 0 { 200 } else { status }
}

fn normalize_psr7_status(status int) int {
	return default_psr7_status(status)
}

fn validate_psr17_response_status_or_throw(status int) ?int {
	if status <= 0 {
		return 200
	}
	return validate_psr7_status_or_throw(status)
}

fn validate_psr7_status_or_throw(status int) ?int {
	if status < 100 || status > 599 {
		vphp.PhpException.raise_class('InvalidArgumentException', 'status code must be an integer between 100 and 599',
			0)
		return none
	}
	return status
}

fn normalize_reason_phrase(status int, reason_phrase string) string {
	trimmed := reason_phrase.trim_space()
	if trimmed != '' {
		return trimmed
	}
	return match default_psr7_status(status) {
		200 { 'OK' }
		201 { 'Created' }
		202 { 'Accepted' }
		204 { 'No Content' }
		301 { 'Moved Permanently' }
		302 { 'Found' }
		303 { 'See Other' }
		304 { 'Not Modified' }
		307 { 'Temporary Redirect' }
		308 { 'Permanent Redirect' }
		400 { 'Bad Request' }
		401 { 'Unauthorized' }
		403 { 'Forbidden' }
		404 { 'Not Found' }
		409 { 'Conflict' }
		422 { 'Unprocessable Content' }
		429 { 'Too Many Requests' }
		500 { 'Internal Server Error' }
		502 { 'Bad Gateway' }
		503 { 'Service Unavailable' }
		504 { 'Gateway Timeout' }
		else { '' }
	}
}

fn default_port_for_scheme(scheme string) ?int {
	return match normalize_psr7_scheme(scheme) {
		'http' { 80 }
		'https' { 443 }
		else { none }
	}
}

fn build_psr7_authority(u &VSlimPsr7Uri) string {
	host := normalize_psr7_host(u.host)
	if host == '' {
		return ''
	}
	mut authority := ''
	user_info := u.get_user_info()
	if user_info != '' {
		authority += user_info + '@'
	}
	authority += host
	if port := u.get_port() {
		authority += ':' + port.str()
	}
	return authority
}

fn build_psr7_uri_string(u &VSlimPsr7Uri) string {
	scheme := normalize_psr7_scheme(u.scheme)
	authority := build_psr7_authority(u)
	mut path := normalize_psr7_path(u.path, u.host)
	if authority != '' && path != '' && !path.starts_with('/') {
		path = '/' + path
	}
	if authority == '' && path.starts_with('//') {
		path = '/' + path.trim_left('/')
	}
	mut out := ''
	if scheme != '' {
		out += scheme + ':'
	}
	if authority != '' {
		out += '//' + authority
	}
	out += path
	query := normalize_psr7_query(u.query)
	if query != '' {
		out += '?' + query
	}
	fragment := normalize_psr7_fragment(u.fragment)
	if fragment != '' {
		out += '#' + fragment
	}
	return out
}

fn build_psr7_request_target(uri &VSlimPsr7Uri) string {
	mut path := normalize_psr7_path(uri.path, uri.host)
	if path == '' {
		path = '/'
	}
	query := normalize_psr7_query(uri.query)
	return if query == '' { path } else { '${path}?${query}' }
}

fn build_psr7_host_header(uri &VSlimPsr7Uri) string {
	host := normalize_psr7_host(uri.host)
	if host == '' {
		return ''
	}
	mut out := host
	if port := uri.get_port() {
		out += ':' + port.str()
	}
	return out
}

fn apply_psr7_host_header(mut headers map[string][]string, mut header_names map[string]string, uri &VSlimPsr7Uri) {
	key := normalize_psr7_header_name('Host')
	host := build_psr7_host_header(uri)
	if host == '' {
		headers.delete(key)
		header_names.delete(key)
		return
	}
	headers[key] = [host]
	header_names[key] = 'Host'
}

fn parse_psr7_uri(raw string) VSlimPsr7Uri {
	trimmed := raw.trim_space()
	if trimmed == '' {
		return VSlimPsr7Uri{
			port: -1
		}
	}
	// Relative request targets are the hot path for dispatch_request(). Keep URI
	// normalization inside V instead of bouncing bridge values back through
	// PHP's `parse_url()`.
	if trimmed.starts_with('/') || trimmed.starts_with('?')
		|| trimmed.starts_with('#')
		|| (!trimmed.contains('://') && !trimmed.starts_with('//')) {
		return fallback_psr7_uri(trimmed)
	}
	return absolute_psr7_uri(trimmed) or { fallback_psr7_uri(trimmed) }
}

fn fallback_psr7_uri(raw string) VSlimPsr7Uri {
	mut base := raw
	mut fragment := ''
	if idx := raw.index('#') {
		base = raw[..idx]
		fragment = raw[idx + 1..]
	}
	mut path := base
	mut query := ''
	if idx := base.index('?') {
		path = base[..idx]
		query = base[idx + 1..]
	}
	return VSlimPsr7Uri{
		port:     -1
		path:     normalize_psr7_path(path, '')
		query:    normalize_psr7_query(query)
		fragment: normalize_psr7_fragment(fragment)
	}
}

fn absolute_psr7_uri(raw string) ?VSlimPsr7Uri {
	scheme_sep := raw.index('://') or { return none }
	scheme := normalize_psr7_scheme(raw[..scheme_sep])
	if scheme == '' {
		return none
	}
	mut rest := raw[scheme_sep + 3..]
	mut fragment := ''
	if idx := rest.index('#') {
		fragment = normalize_psr7_fragment(rest[idx + 1..])
		rest = rest[..idx]
	}
	mut query := ''
	if idx := rest.index('?') {
		query = normalize_psr7_query(rest[idx + 1..])
		rest = rest[..idx]
	}
	mut authority := rest
	mut path := ''
	if idx := rest.index('/') {
		authority = rest[..idx]
		path = rest[idx..]
	}
	mut user := ''
	mut password := ''
	mut host_port := authority
	if at := authority.last_index('@') {
		user_info := authority[..at]
		host_port = authority[at + 1..]
		if colon := user_info.index(':') {
			user = user_info[..colon]
			password = user_info[colon + 1..]
		} else {
			user = user_info
		}
	}
	mut host := host_port
	mut port := -1
	if host_port.starts_with('[') {
		end := host_port.index(']') or { -1 }
		if end > 0 {
			host = host_port[..end + 1]
			if end + 1 < host_port.len && host_port[end + 1] == `:` {
				port = normalize_psr7_port(host_port[end + 2..].int())
			}
		}
	} else if colon := host_port.last_index(':') {
		port_candidate := host_port[colon + 1..]
		if port_candidate != '' && port_candidate.bytes().all(it >= `0` && it <= `9`) {
			host = host_port[..colon]
			port = normalize_psr7_port(port_candidate.int())
		}
	}
	return VSlimPsr7Uri{
		scheme:   scheme
		user:     user
		password: password
		host:     normalize_psr7_host(host)
		port:     port
		path:     normalize_psr7_path(path, normalize_psr7_host(host))
		query:    query
		fragment: fragment
	}
}

pub fn (r &VSlimPsr7ServerRequest) free() {
	_ = r
}

fn clamp_stream_position(position int, max_len int) int {
	if position < 0 {
		return 0
	}
	if position > max_len {
		return max_len
	}
	return position
}

fn build_psr7_stream_from_file(filename string, default_mode string) &VSlimPsr7Stream {
	path := filename.trim_space()
	if path == '' {
		vphp.PhpException.raise_class('InvalidArgumentException', 'filename must not be empty',
			0)
		return new_psr7_stream('')
	}
	mode := normalize_psr7_stream_mode(default_mode)
	content := read_stream_factory_file(path, mode) or { return new_psr7_stream('') }
	return &VSlimPsr7Stream{
		content:  content
		position: 0
		detached: false
		metadata: psr7_stream_metadata_for(mode, path, true)
	}
}

fn build_psr7_stream_from_resource(resource vphp.ZVal) &VSlimPsr7Stream {
	if !resource.is_resource() {
		vphp.PhpException.raise_class('InvalidArgumentException', 'resource must be a valid PHP stream resource',
			0)
		return new_psr7_stream('')
	}
	meta := php_stream_metadata(resource) or {
		vphp.PhpException.raise_class('InvalidArgumentException', 'resource must be a PHP stream resource',
			0)
		return new_psr7_stream('')
	}
	content := read_stream_resource(resource) or { return new_psr7_stream('') }
	return &VSlimPsr7Stream{
		content:  content
		position: 0
		detached: false
		metadata: meta
	}
}

pub fn (s &VSlimPsr7Stream) stream_string() string {
	if s.detached {
		return ''
	}
	return s.content
}

fn default_psr7_stream_metadata() map[string]string {
	return psr7_stream_metadata_for('r+', '', true)
}

fn psr7_stream_metadata_for(mode string, uri string, seekable bool) map[string]string {
	mut metadata := map[string]string{}
	metadata['mode'] = normalize_psr7_stream_mode(mode)
	metadata['seekable'] = if seekable { '1' } else { '0' }
	if uri != '' {
		metadata['uri'] = uri
	}
	return metadata
}

fn stream_mode(s &VSlimPsr7Stream) string {
	return normalize_psr7_stream_mode(s.metadata['mode'] or { 'r+' })
}

fn normalize_psr7_stream_mode(mode string) string {
	trimmed := mode.trim_space()
	return if trimmed == '' { 'r' } else { trimmed }
}

fn stream_is_seekable(s &VSlimPsr7Stream) bool {
	return (s.metadata['seekable'] or { '1' }) != '0'
}

fn stream_is_readable(s &VSlimPsr7Stream) bool {
	mode := stream_mode(s)
	return mode.contains('r') || mode.contains('+')
}

fn stream_is_writable(s &VSlimPsr7Stream) bool {
	mode := stream_mode(s)
	return mode.contains('+') || mode.contains('x') || mode.contains('c') || mode.contains('a')
		|| mode.contains('w')
}

fn is_valid_psr7_header_name(name string) bool {
	if name == '' {
		return false
	}
	symbols := "!#$%&'*+-.^_`|~"
	for ch in name.bytes() {
		if (ch >= `a` && ch <= `z`) || (ch >= `A` && ch <= `Z`) || (ch >= `0` && ch <= `9`) {
			continue
		}
		if symbols.contains(ch.ascii_str()) {
			continue
		}
		return false
	}
	return true
}

fn is_valid_psr7_header_value(value string) bool {
	return !value.contains('\r') && !value.contains('\n')
}

fn is_valid_psr7_parsed_body(value vphp.ZVal) bool {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return true
	}
	return value.is_array() || value.is_object()
}

fn php_stream_metadata(resource vphp.ZVal) ?map[string]string {
	meta := resource.stream_metadata() or { return none }
	return psr7_stream_metadata_for(meta.mode, meta.uri, meta.seekable)
}

fn read_stream_factory_file(filename string, mode string) ?string {
	if mode.contains('r') {
		exists := vphp.PhpFunction.named('is_file').result_bool([
			vphp.RequestOwnedZBox.new_string(filename).to_zval(),
		])
		if !exists {
			vphp.PhpException.raise_class('RuntimeException', 'failed to open stream from file',
				0)
			return none
		}
		return vphp.PhpFunction.named('file_get_contents').result_string([
			vphp.RequestOwnedZBox.new_string(filename).to_zval(),
		])
	}
	return ''
}

fn read_stream_resource(resource vphp.ZVal) ?string {
	if !resource.is_resource() {
		vphp.PhpException.raise_class('InvalidArgumentException', 'resource must be a valid PHP stream resource',
			0)
		return none
	}
	meta := php_stream_metadata(resource) or {
		vphp.PhpException.raise_class('InvalidArgumentException', 'resource must be a PHP stream resource',
			0)
		return none
	}
	if (meta['seekable'] or { '1' }) != '0' {
		_ = resource.stream_rewind()
	}
	content := resource.stream_get_contents() or {
		vphp.PhpException.raise_class('RuntimeException', 'failed to read from stream resource',
			0)
		return none
	}
	return content
}
