module httpx

import vphp

pub fn VSlimPsr7Stream.from_content(content string) &VSlimPsr7Stream {
	return &VSlimPsr7Stream{
		content:  content
		position: 0
		detached: false
		metadata: default_psr7_stream_metadata()
	}
}

fn VSlimPsr7Stream.from_object(object vphp.PhpObject) &VSlimPsr7Stream {
	if object.is_instance_of('VSlim\\Psr7\\Stream') || object.is_instance_of('VSlimPsr7Stream') {
		return object.to_v_object[VSlimPsr7Stream]() or {
			VSlimPsr7Stream.from_content('')
		}
	}
	if object.method_exists('__toString') {
		return object.with_method_result[vphp.PhpString, &VSlimPsr7Stream]('__toString',
			fn (raw vphp.PhpString) &VSlimPsr7Stream {
				return VSlimPsr7Stream.from_content(raw.value())
			}) or { VSlimPsr7Stream.from_content('') }
	}
	return VSlimPsr7Stream.from_content('')
}

pub fn VSlimPsr7Stream.from_value(value vphp.PhpValue) &VSlimPsr7Stream {
	if mut object := value.as_object() {
		defer {
			object.release()
		}
		if object.is_instance_of('VSlim\\Psr7\\Stream') || object.is_instance_of('VSlimPsr7Stream') {
			return object.to_v_object[VSlimPsr7Stream]() or {
				VSlimPsr7Stream.from_content(value_subject(value).log_message())
			}
		}
		if object.method_exists('__toString') {
			return object.with_method_result[vphp.PhpString, &VSlimPsr7Stream]('__toString',
				fn (raw vphp.PhpString) &VSlimPsr7Stream {
					return VSlimPsr7Stream.from_content(raw.value())
				}) or { VSlimPsr7Stream.from_content(value_subject(value).log_message()) }
		}
	}
	return VSlimPsr7Stream.from_content(value_subject(value).log_message())
}

fn value_or_empty_string(value vphp.PhpValue) string {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return ''
	}
	return value.to_string()
}

fn (subject PhpValueSubject) psr7_seek_whence() int {
	value := subject.value
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return 0
	}
	return int(value.to_i64())
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

pub fn VSlimPsr7Stream.from_file(filename string, default_mode string) vphp.PhpValue {
	if filename == '' {
		vphp.PhpException.raise_class('InvalidArgumentException', 'filename must not be empty', 0)
		return vphp.PhpValue.null()
	}
	mode := normalize_psr7_stream_mode(default_mode)
	mut resource := vphp.PhpResource.open_stream(filename, mode, report_errors: false) or {
		raise_stream_error('failed to open stream from file')
		return vphp.PhpValue.null()
	}
	defer {
		resource.release()
	}
	return VSlimPsr7Stream.from_resource(resource)
}

pub fn VSlimPsr7Stream.from_resource(resource vphp.PhpResource) vphp.PhpValue {
	if !resource.is_stream() {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'resource must be a valid PHP stream resource', 0)
		return vphp.PhpValue.null()
	}
	stream := &VSlimPsr7Stream{ native_backed: true }
	mut object := vphp.bind_owned_object_value[VSlimPsr7Stream](stream)
	state := vphp.owned_object_php_state(stream) or {
		object.release()
		raise_stream_error('unable to retain the PHP stream resource')
		return vphp.PhpValue.null()
	}
	state.set_zval('resource', resource.to_zval())
	return object.move_to_request_scope()
}

fn (s &VSlimPsr7Stream) native_resource() ?vphp.PhpResource {
	if !s.native_backed || s.detached {
		return none
	}
	state := vphp.owned_object_php_state(s) or { return none }
	resource := state.value_at('resource').as_resource() or { return none }
	return if resource.is_stream() { resource } else { none }
}

fn (s &VSlimPsr7Stream) is_detached() bool {
	return s.detached || (s.native_backed && s.native_resource() == none)
}

fn raise_stream_error(message string) {
	if !vphp.PhpException.has_current() {
		vphp.PhpException.raise_class('RuntimeException', message, 0)
	}
}

pub fn (s &VSlimPsr7Stream) stream_string() string {
	if s.is_detached() {
		return ''
	}
	if borrowed := s.native_resource() {
		// Stream wrappers can call PHP again and detach this stream during I/O.
		mut resource := borrowed.owned()
		defer {
			resource.release()
		}
		metadata := resource.stream_metadata() or { return '' }
		if !readable_stream_mode(metadata.mode) {
			return ''
		}
		position := if metadata.seekable { resource.tell() } else { none }
		if original := position {
			if !resource.rewind() {
				return ''
			}
			defer {
				_ = resource.seek(original, .start)
			}
			return resource.contents() or { '' }
		}
		return resource.contents() or { '' }
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
	if resource := s.native_resource() {
		metadata := resource.stream_metadata() or { return '' }
		return metadata.mode
	}
	return normalize_psr7_stream_mode(s.metadata['mode'] or { 'r+' })
}

fn normalize_psr7_stream_mode(mode string) string {
	trimmed := mode.trim_space()
	return if trimmed == '' { 'r' } else { trimmed }
}

fn stream_is_seekable(s &VSlimPsr7Stream) bool {
	if resource := s.native_resource() {
		metadata := resource.stream_metadata() or { return false }
		return metadata.seekable
	}
	return (s.metadata['seekable'] or { '1' }) != '0'
}

fn stream_is_readable(s &VSlimPsr7Stream) bool {
	return readable_stream_mode(stream_mode(s))
}

fn readable_stream_mode(mode string) bool {
	return mode.contains('r') || mode.contains('+')
}

fn stream_is_writable(s &VSlimPsr7Stream) bool {
	mode := stream_mode(s)
	return mode.contains('+') || mode.contains('x') || mode.contains('c') || mode.contains('a')
		|| mode.contains('w')
}
