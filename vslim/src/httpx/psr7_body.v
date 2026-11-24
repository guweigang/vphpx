module httpx

import vphp

fn psr7_body_object(owner voidptr, pending vphp.PhpValue) ?vphp.PhpValue {
	if pending.is_object() {
		return pending
	}
	state := vphp.owned_object_php_state(owner) or { return none }
	return state.find('body')
}

fn copy_psr7_body(owner voidptr, pending vphp.PhpValue) vphp.PhpValue {
	body := psr7_body_object(owner, pending) or { return vphp.PhpValue.invalid() }
	return body.owned()
}

// A PHP clone must keep the same stream alive even if the original message
// was the first one to bind its V stream to a PHP object.
fn clone_psr7_body(owner voidptr, body &VSlimPsr7Stream, pending vphp.PhpValue) vphp.PhpValue {
	if current := psr7_body_object(owner, pending) {
		return current.owned()
	}
	return bind_psr7_body(owner, body)
}

fn install_psr7_body(owner voidptr, mut pending vphp.PhpValue) {
	if pending.is_object() {
		state := vphp.owned_object_php_state(owner) or { return }
		state.set_value('body', pending)
		pending.release()
	}
}

fn psr7_body_value(owner voidptr, stream &VSlimPsr7Stream, pending vphp.PhpValue) vphp.PhpValue {
	if body := psr7_body_object(owner, pending) {
		return body.to_request_scoped()
	}
	mut value := bind_psr7_body(owner, stream)
	return value.move_to_request_scope()
}

fn bind_psr7_body(owner voidptr, stream &VSlimPsr7Stream) vphp.PhpValue {
	body := if stream == unsafe { nil } { VSlimPsr7Stream.from_content('') } else { stream }
	value := vphp.bind_owned_object_value[VSlimPsr7Stream](body)
	if state := vphp.owned_object_php_state(owner) {
		state.set_value('body', value)
	}
	return value
}

// Convert a PHP stream only at the V boundary that needs bytes.
fn psr7_body_stream(owner voidptr, stream &VSlimPsr7Stream, pending vphp.PhpValue) &VSlimPsr7Stream {
	if body := psr7_body_object(owner, pending) {
		return VSlimPsr7Stream.from_value(body)
	}
	if stream != unsafe { nil } {
		return stream
	}
	return VSlimPsr7Stream.from_content('')
}

// The holder shares a single load across immutable response copies. Zend can
// trace the message and its stream through the response's PHP-owned state.
fn deferred_psr7_body(message vphp.PhpObject) vphp.PhpValue {
	mut holder := vphp.PhpClass.named('stdClass').construct() or {
		return vphp.PhpValue.invalid()
	}
	holder.set_prop('message', message.to_zval())
	return holder.take_value()
}

fn (r &VSlimPsr7Response) response_body_object() ?vphp.PhpValue {
	body := psr7_body_object(r, r.body_pending) or { return none }
	// A deferred holder is a plain stdClass. Actual bodies implement
	// StreamInterface or use the native VSlim stream class.
	if body.class_name() != 'stdClass' {
		return body
	}
	holder := body.require_object() or { return none }
	if holder.has_prop('body') {
		return vphp.PhpValue.from_zval(holder.prop_borrowed('body'))
	}
	if holder.has_prop('loading') {
		vphp.PhpException.raise_class('LogicException', 'Recursive PSR-7 response body acquisition', 0)
		return none
	}
	message := vphp.PhpObject.from_zval(holder.prop_borrowed('message')) or { return none }
	mut loading := vphp.PhpBool.of(true)
	holder.set_prop('loading', loading.to_zval())
	loading.release()
	defer {
		vphp.PhpException.with_preserved_pending(fn [holder] () {
			holder.unset_prop('loading')
		})
	}
	stream, mut loaded := import_psr7_body(message)
	if vphp.PhpException.has_current() {
		loaded.release()
		return none
	}
	if !loaded.is_object() {
		loaded = vphp.bind_owned_object_value[VSlimPsr7Stream](stream)
	}
	defer {
		loaded.release()
	}
	holder.set_prop('body', loaded.to_zval())
	holder.unset_prop('message')
	return vphp.PhpValue.from_zval(holder.prop_borrowed('body'))
}

// Preserve real PSR-7 streams from foreign messages. Older duck-typed adapters
// still get a memory stream when their getBody() returns a string-like value.
fn import_psr7_body(message vphp.PhpObject) (&VSlimPsr7Stream, vphp.PhpValue) {
	if !message.method_exists('getBody') {
		return VSlimPsr7Stream.from_content(''), vphp.PhpValue.invalid()
	}
	mut value := message.call_method_by_value('getBody')
	if vphp.PhpException.has_current() {
		value.release()
		return unsafe { nil }, vphp.PhpValue.invalid()
	}
	if value.is_instance_of('Psr\\Http\\Message\\StreamInterface')
		|| value.is_instance_of('VSlim\\Psr7\\Stream') {
		return unsafe { nil }, value
	}
	defer {
		value.release()
	}
	return VSlimPsr7Stream.from_value(value), vphp.PhpValue.invalid()
}

pub fn (mut r VSlimPsr7ServerRequest) dispatch_body_is_seekable() bool {
	if body := psr7_body_object(r, r.body_pending) {
		object := body.as_object() or { return false }
		return object.with_method_result[vphp.PhpBool, bool]('isSeekable', fn (answer vphp.PhpBool) bool {
			return answer.value()
		}) or { false }
	}
	return r.body_ref == unsafe { nil } || r.body_ref.is_seekable()
}

// Inspect bytes only when routing or validation requires them. Buffer a
// non-seekable body so later PHP middleware can still read the same bytes.
pub fn (mut r VSlimPsr7ServerRequest) inspect_dispatch_body() string {
	body := r.get_body()
	object := body.as_object() or { return '' }
	if r.dispatch_body_is_seekable() {
		position := object.with_method_result[vphp.PhpInt, i64]('tell', fn (result vphp.PhpInt) i64 {
			return result.value()
		}) or { return '' }
		mut offset := vphp.PhpInt.of(position)
		defer {
			offset.release()
		}
		mut rewound := object.call_method('rewind')
		rewound.release()
		if vphp.PhpException.has_current() {
			return ''
		}
		content := object.with_method_result[vphp.PhpString, string]('getContents', fn (result vphp.PhpString) string {
			return result.value()
		}) or { '' }
		// A foreign stream can throw during I/O. Restore its cursor without
		// replacing the original exception with one from seek().
		vphp.PhpException.with_preserved_pending(fn [object, offset] () {
			mut restored := object.call_method('seek', offset)
			restored.release()
		})
		return content
	}
	content := object.with_method_result[vphp.PhpString, string]('getContents', fn (result vphp.PhpString) string {
		return result.value()
	}) or { return '' }
	r.body_pending.release()
	r.body_ref = VSlimPsr7Stream.from_content(content)
	if state := vphp.owned_object_php_state(r) {
		state.remove('body')
	}
	return content
}
