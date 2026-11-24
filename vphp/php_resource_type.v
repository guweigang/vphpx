module vphp

import strings
import time
import vphp.zend

@[params]
pub struct StreamOpenOptions {
pub:
	context       ?PhpResource
	report_errors bool = true
}

@[params]
pub struct PhpStreamConnectOptions {
pub:
	timeout_ms i64 = -1
	context    ?PhpResource
}

pub struct PhpResource {
mut:
	value PhpValueZBox
}

// new_stream_context creates an independent request-owned context resource.
pub fn PhpResource.new_stream_context(options PhpArray) !PhpResource {
	mut result := ZVal.new_request()
	created := options.value.with_request_zval[bool](fn [result] (raw ZVal) bool {
		return zend.new_stream_context(raw.raw_ptr(), result.raw_ptr())
	})
	if !created {
		result.release()
		return error('failed to create PHP stream context')
	}
	return PhpResource{
		value: PhpValueZBox.request_owned(RequestOwnedZBox.adopt_zval(result))
	}
}

// open_stream returns a request-owned stream. The PHP wrapper can raise an
// exception even when its open warnings are disabled.
pub fn PhpResource.open_stream(path string, mode string, options StreamOpenOptions) !PhpResource {
	mut result := ZVal.new_request()
	report_errors := options.report_errors
	opened := if context := options.context {
		context.value.with_request_zval[bool](fn [path, mode, report_errors, result] (z ZVal) bool {
			return zend.open_stream(path, mode, z.raw_ptr(), report_errors, result.raw_ptr())
		})
	} else {
		zend.open_stream(path, mode, unsafe { nil }, report_errors, result.raw_ptr())
	}
	if !opened {
		result.release()
		return error('failed to open PHP stream')
	}
	return PhpResource.from_request_owned_zbox(RequestOwnedZBox.adopt_zval(result)) or {
		result.release()
		return error('opening PHP stream did not return a resource')
	}
}

// connect_stream opens a nonblocking TCP or Unix stream. The caller owns the
// connected resource. A failed or cancelled wait releases the connection.
pub fn PhpResource.connect_stream(address string, options PhpStreamConnectOptions) !PhpResource {
	deadline := checked_task_stream_deadline(options.timeout_ms)!
	mut stream := open_task_socket(address, options.context, false)!
	mut connected := false
	defer {
		if !connected {
			stream.release()
		}
	}
	if (options.timeout_ms > 0 && time.sys_mono_now() >= u64(deadline))
		|| !wait_php_stream_until(stream, true, deadline)! {
		return error('Timed out connecting PHP stream')
	}
	mut failure := ZVal.new_request()
	defer {
		failure.release()
	}
	if !zend.task_socket_connected(stream.to_zval().raw_ptr(), failure.raw_ptr()) {
		return task_socket_error('connect', failure)
	}
	connected = true
	return stream
}

// listen_stream binds and opens a request-owned, nonblocking TCP or Unix listener.
pub fn PhpResource.listen_stream(address string, context ?PhpResource) !PhpResource {
	return open_task_socket(address, context, true)
}

fn open_task_socket(address string, stream_context ?PhpResource, listen bool) !PhpResource {
	if !address.starts_with('tcp://') && !address.starts_with('unix://') {
		return error('A PHP socket requires a tcp:// or unix:// address')
	}
	mut result := ZVal.new_request()
	mut failure := ZVal.new_request()
	defer {
		failure.release()
		result.release()
	}
	opened := if context := stream_context {
		context.value.with_request_zval[bool](fn [address, listen, result, failure] (raw ZVal) bool {
			return zend.task_socket_open(address, listen, raw.raw_ptr(), result.raw_ptr(), failure.raw_ptr())
		})
	} else {
		zend.task_socket_open(address, listen, unsafe { nil }, result.raw_ptr(), failure.raw_ptr())
	}
	if !opened {
		return task_socket_error(if listen { 'listen on' } else { 'connect' }, failure)
	}
	return PhpResource.must_from_zval(result)!.owned()
}

fn task_socket_error(operation string, failure ZVal) IError {
	message := failure.to_string()
	return error(if message == '' {
		'Unable to ${operation} PHP stream'
	} else {
		'Unable to ${operation} PHP stream: ${message}'
	})
}

// accept_stream waits for a connection on a nonblocking TCP or Unix listener.
// The caller owns the accepted socket. On timeout or cancellation the listener
// remains available to its owner and any peers waiting on it.
pub fn (listener PhpResource) accept_stream(timeout_ms i64) !PhpResource {
	deadline := checked_task_stream_deadline(timeout_ms)!
	if !listener.is_nonblocking_stream() {
		return error('Accepting requires an open nonblocking PHP socket listener')
	}
	mut result := ZVal.new_request()
	mut failure := ZVal.new_request()
	defer {
		failure.release()
		result.release()
	}
	for {
		status := zend.task_socket_accept(listener.to_zval().raw_ptr(), result.raw_ptr(),
			failure.raw_ptr())
		if status == 1 {
			return PhpResource.must_from_zval(result)!.owned()
		}
		if status < 0 {
			return task_socket_error('accept', failure)
		}
		if deadline > 0 && time.sys_mono_now() >= u64(deadline) {
			break
		}
		ready := wait_php_stream_until(listener, false, deadline)!
		if !listener.is_stream() {
			return error('PHP socket listener closed while waiting to accept')
		}
		if !ready || (deadline > 0 && time.sys_mono_now() >= u64(deadline)) {
			break
		}
	}
	return error('Timed out accepting PHP stream')
}

pub fn PhpResource.from_zval(z ZVal) ?PhpResource {
	if !z.is_resource() {
		return none
	}
	return PhpResource{
		value: PhpValueZBox.from_zval(z)
	}
}

pub fn PhpResource.must_from_zval(z ZVal) !PhpResource {
	res := PhpResource.from_zval(z) or { return error('zval is not resource') }
	return res
}

pub fn PhpResource.from_request_owned_zbox(value RequestOwnedZBox) ?PhpResource {
	if !value.is_resource() {
		return none
	}
	return PhpResource{
		value: PhpValueZBox.request_owned(value)
	}
}

pub fn PhpResource.from_persistent_owned_zbox(value PersistentOwnedZBox) ?PhpResource {
	if !value.is_resource() {
		return none
	}
	return PhpResource{
		value: PhpValueZBox.persistent_owned(value)
	}
}

pub fn PhpResource.from_persistent_zval(z ZVal) ?PhpResource {
	return PhpResource.from_persistent_owned_zbox(PersistentOwnedZBox.from_persistent_zval(z))
}

pub fn (r PhpResource) to_zval() ZVal {
	return r.value.to_zval()
}

pub fn (r PhpResource) to_borrowed() PhpResource {
	return PhpResource.from_zval(r.value.to_borrowed_zbox().to_zval()) or { r }
}

pub fn (r PhpResource) borrowed() PhpResource {
	return r.to_borrowed()
}

pub fn (r PhpResource) borrow() PhpResource {
	return r.to_borrowed()
}

pub fn (r PhpResource) to_borrowed_zbox() RequestBorrowedZBox {
	return r.value.to_borrowed_zbox()
}

pub fn (r PhpResource) to_request_owned() PhpResource {
	return PhpResource.from_request_owned_zbox(r.value.to_request_owned_zbox()) or {
		r.to_borrowed()
	}
}

pub fn (r PhpResource) owned() PhpResource {
	return r.to_request_owned()
}

pub fn (r PhpResource) to_request_owned_zbox() RequestOwnedZBox {
	return r.value.to_request_owned_zbox()
}

pub fn (r PhpResource) to_persistent_owned() PhpResource {
	return PhpResource.from_persistent_owned_zbox(r.value.to_persistent_owned_zbox()) or {
		r.to_borrowed()
	}
}

pub fn (r PhpResource) retain() PhpResource {
	return r.to_persistent_owned()
}

pub fn (r PhpResource) retained() PhpResource {
	return r.to_persistent_owned()
}

pub fn (r PhpResource) to_persistent_owned_zbox() PersistentOwnedZBox {
	return r.value.to_persistent_owned_zbox()
}

pub fn (r PhpResource) is_borrowed() bool {
	return r.value.is_borrowed()
}

pub fn (r PhpResource) is_owned() bool {
	return r.value.is_request_owned()
}

pub fn (r PhpResource) is_retained() bool {
	return r.value.is_retained()
}

pub fn (mut r PhpResource) take_zval() ZVal {
	return r.value.take_zval()
}

pub fn (mut r PhpResource) release() {
	r.value.release()
}

pub fn (r PhpResource) ptr() voidptr {
	return r.to_zval().resource_ptr()
}

pub fn (r PhpResource) type_name() string {
	return r.to_zval().resource_type() or { '' }
}

pub fn (r PhpResource) is_stream() bool {
	return r.to_zval().is_stream_resource()
}

pub fn (r PhpResource) stream_metadata() ?StreamMetadata {
	return r.to_zval().stream_metadata()
}

// stream_wrapper_data returns a request-owned copy of this stream's metadata
// from its wrapper, such as the status line and headers of an HTTP response.
pub fn (r PhpResource) stream_wrapper_data() ?PhpValue {
	mut result := ZVal.new_request()
	copied := r.value.with_request_zval[bool](fn [result] (z ZVal) bool {
		return zend.stream_wrapper_data(z.raw_ptr(), result.raw_ptr())
	})
	if !copied {
		result.release()
		return none
	}
	return PhpValue.adopt_zval(result)
}

pub fn (r PhpResource) rewind() bool {
	return r.to_zval().stream_rewind()
}

pub fn (r PhpResource) contents() ?string {
	return r.to_zval().stream_get_contents()
}

// read_to_end returns the remaining bytes only after reaching EOF.
// A read error or no progress before EOF discards the partial result.
pub fn (r PhpResource) read_to_end() !string {
	return r.read_checked(-1) or { return error('failed to read PHP stream to EOF') }
}

@[params]
pub struct PhpStreamReadOptions {
pub:
	timeout_ms ?i64
}

enum PhpStreamReadMode {
	exact
	line
}

// read_exactly returns the requested bytes and leaves any remainder unread.
// Providing timeout_ms waits on a nonblocking stream across short reads.
pub fn (r PhpResource) read_exactly(length i64, options PhpStreamReadOptions) !string {
	if length < 0 {
		return error('PHP stream length must be non-negative')
	}
	if timeout_ms := options.timeout_ms {
		return r.read_with_timeout(length, timeout_ms, .exact)
	}
	return r.read_checked(length) or { return error('failed to read the requested number of PHP stream bytes') }
}

fn (r PhpResource) read_with_timeout(length i64, timeout_ms i64, mode PhpStreamReadMode) !string {
	deadline := checked_task_stream_deadline(timeout_ms)!
	if length >= max_i32 {
		return error('PHP stream read length exceeds V string capacity')
	}
	if !r.is_nonblocking_stream() {
		return error('Reading with a deadline requires an open nonblocking PHP stream')
	}
	if length == 0 {
		return ''
	}
	mut bytes := strings.new_builder(int(if length < 8192 { length } else { i64(8192) }))
	defer {
		unsafe { bytes.free() }
	}
	for {
		remaining := length - bytes.len
		limit := if remaining < 8192 { int(remaining) } else { 8192 }
		maybe_chunk := if mode == .line { r.read_line_fragment(limit) } else { r.read(limit) }
		chunk := maybe_chunk or {
			return error('Unable to read PHP stream after reading ${bytes.len} of ${length} bytes')
		}
		bytes.write_string(chunk)
		if mode == .line && chunk.ends_with('\n') {
			return bytes.str()
		}
		if bytes.len == length {
			if mode == .line {
				return error('PHP stream line exceeds the ${length} byte limit')
			}
			return bytes.str()
		}
		if chunk.len == 0 && r.eof() {
			if mode == .line {
				return error('PHP stream reached EOF before LF after reading ${bytes.len} bytes')
			}
			return error('PHP stream reached EOF after reading ${bytes.len} of ${length} bytes')
		}
		if timeout_ms > 0 && time.sys_mono_now() >= u64(deadline) {
			break
		}
		if chunk.len == 0 {
			if timeout_ms == 0 {
				break
			}
			ready := wait_php_stream_until(r, false, deadline)!
			if !r.is_stream() {
				return error('PHP stream closed after reading ${bytes.len} of ${length} bytes')
			}
			if !ready || (deadline > 0 && time.sys_mono_now() >= u64(deadline)) {
				break
			}
			if !r.is_nonblocking_stream() {
				return error('PHP stream became blocking after reading ${bytes.len} of ${length} bytes')
			}
		}
	}
	return error('Timed out reading PHP stream after reading ${bytes.len} of ${length} bytes')
}

fn (r PhpResource) read_checked(length i64) !string {
	mut result := ZVal.new_request()
	defer {
		result.release()
	}
	complete := r.value.with_request_zval[bool](fn [length, result] (raw ZVal) bool {
		return zend.stream_read_checked(raw.raw_ptr(), length, result.raw_ptr())
	})
	if !complete {
		return error('incomplete PHP stream read')
	}
	return result.to_string()
}

pub fn (r PhpResource) eof() bool {
	return r.to_zval().stream_eof()
}

pub fn (r PhpResource) read_line() ?string {
	return r.to_zval().stream_read_line()
}

// read_complete_line includes the closing LF in its result and in max_bytes.
// An incomplete or overlong line returns an error. With timeout_ms, a
// nonblocking stream can wait for the rest of a partial line.
pub fn (r PhpResource) read_complete_line(max_bytes int, options PhpStreamReadOptions) !string {
	if max_bytes <= 0 {
		return error('PHP stream line limit must be positive')
	}
	if timeout_ms := options.timeout_ms {
		return r.read_with_timeout(max_bytes, timeout_ms, .line)
	}
	mut result := ZVal.new_request()
	defer {
		result.release()
	}
	complete := r.value.with_request_zval[bool](fn [max_bytes, result] (raw ZVal) bool {
		return zend.stream_read_complete_line(raw.raw_ptr(), max_bytes, result.raw_ptr())
	})
	if !complete {
		return error('failed to read a complete PHP stream line')
	}
	return result.to_string()
}

fn (r PhpResource) read_line_fragment(max_bytes int) ?string {
	mut result := ZVal.new_request()
	defer {
		result.release()
	}
	read := r.value.with_request_zval[bool](fn [max_bytes, result] (raw ZVal) bool {
		return zend.stream_read_line_fragment(raw.raw_ptr(), max_bytes, result.raw_ptr())
	})
	if !read {
		return none
	}
	return result.to_string()
}

pub fn (r PhpResource) close() bool {
	return r.to_zval().stream_close()
}

// stream_metadata_value returns PHP's complete stream metadata as an owned array.
pub fn (r PhpResource) stream_metadata_value() ?PhpArray {
	if !r.is_stream() {
		return none
	}
	return PhpFunction.named('stream_get_meta_data').with_result[PhpArray, PhpArray](fn (metadata PhpArray) PhpArray {
		return metadata.owned()
	}, r) or { none }
}

pub fn (r PhpResource) read(length i64) ?string {
	if !r.is_stream() || length < 0 {
		return none
	}
	if length == 0 {
		return ''
	}
	mut count := PhpInt.of(length)
	defer {
		count.release()
	}
	return PhpFunction.named('fread').with_result[PhpString, string](fn (value PhpString) string {
		return value.value()
	}, r, count) or { none }
}

pub fn (r PhpResource) write(text string) ?i64 {
	if !r.is_stream() {
		return none
	}
	mut data := PhpString.of(text)
	defer {
		data.release()
	}
	return PhpFunction.named('fwrite').with_result[PhpInt, i64](fn (value PhpInt) i64 {
		return value.value()
	}, r, data) or { none }
}

fn (r PhpResource) is_nonblocking_stream() bool {
	mut metadata := r.stream_metadata_value() or { return false }
	defer {
		metadata.release()
	}
	return !metadata.bool_at('blocked', true)
}

// write_all sends the entire string on a nonblocking stream. The timeout
// bounds the entire write. Bytes already sent remain committed on error.
pub fn (r PhpResource) write_all(data string, timeout_ms i64) !i64 {
	deadline := checked_task_stream_deadline(timeout_ms)!
	if !r.is_nonblocking_stream() {
		return error('Writing all bytes requires an open nonblocking PHP stream')
	}
	return r.write_all_until(data, deadline, 0)
}

fn (r PhpResource) write_all_until(data string, deadline i64, already_written i64) !i64 {
	mut offset := 0
	for offset < data.len {
		count := if offset == 0 {
			r.write(data)
		} else {
			remaining := data[offset..]
			defer {
				unsafe { remaining.free() }
			}
			r.write(remaining)
		}
		written := count or {
			return error('Unable to write to PHP stream after writing ${already_written + offset} bytes')
		}
		if written < 0 || written > data.len - offset {
			return error('PHP stream returned an invalid write count')
		}
		offset += int(written)
		if offset == data.len {
			break
		}
		if deadline > 0 && time.sys_mono_now() >= u64(deadline) {
			return error('Timed out writing to PHP stream after writing ${already_written + offset} bytes')
		}
		if written == 0 {
			ready := wait_php_stream_until(r, true, deadline)!
			if !r.is_stream() {
				return error('PHP stream closed after writing ${already_written + offset} bytes')
			}
			if !ready || (deadline > 0 && time.sys_mono_now() >= u64(deadline)) {
				return error('Timed out writing to PHP stream after writing ${already_written + offset} bytes')
			}
			if !r.is_nonblocking_stream() {
				return error('PHP stream became blocking after writing ${already_written + offset} bytes')
			}
		}
	}
	return i64(offset)
}

// copy_to copies up to length bytes between two distinct nonblocking streams.
// Pass -1 for length to copy to EOF. The same deadline covers reads and writes.
pub fn (source PhpResource) copy_to(destination PhpResource, length i64, timeout_ms i64) !i64 {
	if length < -1 {
		return error('PHP stream copy length must be -1 or non-negative')
	}
	deadline := checked_task_stream_deadline(timeout_ms)!
	if !source.is_nonblocking_stream() || !destination.is_nonblocking_stream() {
		return error('Copying requires two open nonblocking PHP streams')
	}
	if zend.task_stream_same(source.to_zval().raw_ptr(), destination.to_zval().raw_ptr()) {
		return error('Copying requires distinct source and destination streams')
	}
	mut copied := i64(0)
	for length < 0 || copied < length {
		if copied > 0 && timeout_ms > 0 && time.sys_mono_now() >= u64(deadline) {
			break
		}
		remaining := length - copied
		chunk := source.read(if length < 0 || remaining > 8192 { i64(8192) } else { remaining }) or {
			return error('Unable to read PHP source stream after copying ${copied} bytes')
		}
		if chunk.len > 0 {
			defer {
				unsafe { chunk.free() }
			}
			copied += destination.write_all_until(chunk, deadline, copied)!
			if (length < 0 || copied < length) && !source.is_nonblocking_stream() {
				return error('PHP source stream was closed or became blocking after copying ${copied} bytes')
			}
			continue
		}
		if source.eof() {
			return copied
		}
		if deadline > 0 && time.sys_mono_now() >= u64(deadline) {
			break
		}
		ready := wait_php_stream_until(source, false, deadline)!
		if !source.is_stream() {
			return error('PHP source stream closed after copying ${copied} bytes')
		}
		if !ready || (deadline > 0 && time.sys_mono_now() >= u64(deadline)) {
			break
		}
		if !source.is_nonblocking_stream() || !destination.is_nonblocking_stream() {
			return error('A PHP stream was closed or became blocking after copying ${copied} bytes')
		}
	}
	if length >= 0 && copied == length {
		return copied
	}
	return error('Timed out copying PHP stream after copying ${copied} bytes')
}

pub enum StreamWhence {
	start
	current
	end
}

pub fn (r PhpResource) seek(offset i64, whence StreamWhence) bool {
	if !r.is_stream() {
		return false
	}
	mut distance := PhpInt.of(offset)
	mut origin := PhpInt.of(int(whence))
	defer {
		distance.release()
		origin.release()
	}
	return PhpFunction.named('fseek').with_result[PhpInt, bool](fn (value PhpInt) bool {
		return value.value() == 0
	}, r, distance, origin) or { false }
}

pub fn (r PhpResource) tell() ?i64 {
	if !r.is_stream() {
		return none
	}
	return PhpFunction.named('ftell').with_result[PhpInt, i64](fn (value PhpInt) i64 {
		return value.value()
	}, r) or { none }
}

pub fn (r PhpResource) size() ?i64 {
	if !r.is_stream() {
		return none
	}
	mut stat := PhpFunction.named('fstat').with_result[PhpArray, PhpArray](fn (info PhpArray) PhpArray {
		return info.owned()
	}, r) or { return none }
	defer {
		stat.release()
	}
	size := stat.find('size') or { return none }
	return if size.is_int() { size.to_i64() } else { none }
}
