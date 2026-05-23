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
	if object := value.as_object() {
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

pub fn VSlimPsr7Stream.from_file(filename string, default_mode string) &VSlimPsr7Stream {
	path := filename.trim_space()
	if path == '' {
		vphp.PhpException.raise_class('InvalidArgumentException', 'filename must not be empty', 0)
		return VSlimPsr7Stream.from_content('')
	}
	mode := normalize_psr7_stream_mode(default_mode)
	content := read_stream_factory_file(path, mode) or { return VSlimPsr7Stream.from_content('') }
	return &VSlimPsr7Stream{
		content:  content
		position: 0
		detached: false
		metadata: psr7_stream_metadata_for(mode, path, true)
	}
}

pub fn VSlimPsr7Stream.from_resource(resource vphp.PhpResource) &VSlimPsr7Stream {
	if !resource.is_stream() {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'resource must be a valid PHP stream resource', 0)
		return VSlimPsr7Stream.from_content('')
	}
	meta := stream_metadata_from_resource(resource) or {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'resource must be a PHP stream resource', 0)
		return VSlimPsr7Stream.from_content('')
	}
	content := read_stream_resource(resource) or { return VSlimPsr7Stream.from_content('') }
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

fn stream_metadata_from_resource(resource vphp.PhpResource) ?map[string]string {
	meta := resource.stream_metadata() or { return none }
	return psr7_stream_metadata_for(meta.mode, meta.uri, meta.seekable)
}

fn read_stream_factory_file(filename string, mode string) ?string {
	if mode.contains('r') {
		mut filename_arg := vphp.PhpString.of(filename)
		defer {
			filename_arg.release()
		}
		exists := vphp.PhpFunction.named('is_file').result_bool(filename_arg)
		if !exists {
			vphp.PhpException.raise_class('RuntimeException', 'failed to open stream from file', 0)
			return none
		}
		return vphp.PhpFunction.named('file_get_contents').result_string(filename_arg)
	}
	return ''
}

fn read_stream_resource(resource vphp.PhpResource) ?string {
	if !resource.is_stream() {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'resource must be a valid PHP stream resource', 0)
		return none
	}
	meta := stream_metadata_from_resource(resource) or {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'resource must be a PHP stream resource', 0)
		return none
	}
	if (meta['seekable'] or { '1' }) != '0' {
		_ = resource.rewind()
	}
	content := resource.contents() or {
		vphp.PhpException.raise_class('RuntimeException', 'failed to read from stream resource', 0)
		return none
	}
	return content
}
