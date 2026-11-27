module httpx

import vphp

@[vphp.PhpStringParam('default_content', php_name: 'defaultContent', default_value: '', optional: true)]
@[vphp.PhpExportMethod(name: '')]
pub fn (mut s VSlimPsr7Stream) construct(default_content string) &VSlimPsr7Stream {
	if s.native_backed {
		s.close()
		s.native_backed = false
	}
	s.content = default_content
	s.position = 0
	s.detached = false
	if s.metadata.len == 0 {
		s.metadata = default_psr7_stream_metadata()
	}
	return &s
}

@[vphp.PhpExportMethod(name: '')]
pub fn (s &VSlimPsr7Stream) str() string {
	if vphp.PhpException.has_current() {
		return ''
	}
	content := s.stream_string()
	if vphp.PhpException.has_current() {
		vphp.PhpException.clear()
		return ''
	}
	return content
}

@[vphp.PhpExportMethod(name: '')]
pub fn (s &VSlimPsr7Stream) close() {
	resource := s.detach().as_resource() or { return }
	_ = resource.close()
}

@[vphp.PhpExportMethod(name: '')]
pub fn (s &VSlimPsr7Stream) detach() vphp.PhpValue {
	mut result := vphp.PhpValue.null()
	if s.native_backed {
		if state := vphp.owned_object_php_state(s) {
			if value := state.find('resource') {
				if resource := value.as_resource() {
					if resource.is_stream() {
						result = value.to_request_scoped()
					}
				}
				state.remove('resource')
			}
		}
	}
	unsafe {
		mut writable := &VSlimPsr7Stream(s)
		writable.detached = true
		writable.position = 0
		writable.content = ''
		writable.metadata = map[string]string{}
	}
	return result
}

@[vphp.PhpExportMethod(name: 'getSize')]
pub fn (s &VSlimPsr7Stream) get_size() ?i64 {
	if s.is_detached() {
		return none
	}
	if resource := s.native_resource() {
		return resource.size()
	}
	return i64(s.content.len)
}

@[vphp.PhpExportMethod(name: '')]
pub fn (s &VSlimPsr7Stream) tell() i64 {
	if s.is_detached() {
		vphp.PhpException.raise_class('RuntimeException',
			'unable to determine stream position for a detached stream', 0)
		return 0
	}
	if resource := s.native_resource() {
		result := resource.tell() or {
			raise_stream_error('unable to determine stream position')
			return 0
		}
		return result
	}
	return i64(s.position)
}

@[vphp.PhpExportMethod(name: '')]
pub fn (s &VSlimPsr7Stream) eof() bool {
	if s.is_detached() {
		return true
	}
	if resource := s.native_resource() {
		return resource.eof()
	}
	return s.position >= s.content.len
}

@[vphp.PhpExportMethod(name: 'isSeekable')]
pub fn (s &VSlimPsr7Stream) is_seekable() bool {
	return !s.is_detached() && stream_is_seekable(s)
}

@[vphp.PhpArgName(v_name: 'default_whence', php_name: 'defaultWhence')]
@[vphp.PhpArgDefault(v_name: 'default_whence', default_value: 'SEEK_SET')]
@[vphp.PhpExportMethod(name: '')]
pub fn (s &VSlimPsr7Stream) seek(offset vphp.PhpValue, default_whence vphp.PhpValue) {
	if s.is_detached() {
		vphp.PhpException.raise_class('RuntimeException', 'cannot seek a detached stream', 0)
		return
	}
	if !stream_is_seekable(s) {
		vphp.PhpException.raise_class('RuntimeException', 'stream is not seekable', 0)
		return
	}
	whence := value_subject(default_whence).psr7_seek_whence()
	if whence !in [0, 1, 2] {
		vphp.PhpException.raise_class('RuntimeException', 'invalid whence for stream seek', 0)
		return
	}
	if resource := s.native_resource() {
		origin := match whence {
			1 { vphp.StreamWhence.current }
			2 { vphp.StreamWhence.end }
			else { vphp.StreamWhence.start }
		}
		if !resource.seek(offset.to_i64(), origin) {
			raise_stream_error('failed to seek the stream')
		}
		return
	}
	offset_value := int(offset.to_i64())
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

@[vphp.PhpExportMethod(name: '')]
pub fn (s &VSlimPsr7Stream) rewind() {
	if s.is_detached() {
		vphp.PhpException.raise_class('RuntimeException', 'cannot rewind a detached stream', 0)
		return
	}
	if !stream_is_seekable(s) {
		vphp.PhpException.raise_class('RuntimeException', 'stream is not seekable', 0)
		return
	}
	if resource := s.native_resource() {
		if !resource.rewind() {
			raise_stream_error('failed to rewind the stream')
		}
		return
	}
	unsafe {
		mut writable := &VSlimPsr7Stream(s)
		writable.position = 0
	}
}

@[vphp.PhpExportMethod(name: 'isWritable')]
pub fn (s &VSlimPsr7Stream) is_writable() bool {
	return !s.is_detached() && stream_is_writable(s)
}

@[vphp.PhpExportMethod(name: '')]
pub fn (s &VSlimPsr7Stream) write(chunk vphp.PhpValue) int {
	if s.is_detached() {
		vphp.PhpException.raise_class('RuntimeException', 'cannot write to a detached stream', 0)
		return 0
	}
	if !stream_is_writable(s) {
		vphp.PhpException.raise_class('RuntimeException', 'stream is not writable', 0)
		return 0
	}
	text := value_or_empty_string(chunk)
	if resource := s.native_resource() {
		written := resource.write(text) or {
			raise_stream_error('failed to write to the stream')
			return 0
		}
		return int(written)
	}
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

@[vphp.PhpExportMethod(name: 'isReadable')]
pub fn (s &VSlimPsr7Stream) is_readable() bool {
	return !s.is_detached() && stream_is_readable(s)
}

@[vphp.PhpExportMethod(name: '')]
pub fn (s &VSlimPsr7Stream) read(length vphp.PhpValue) string {
	if s.is_detached() {
		vphp.PhpException.raise_class('RuntimeException', 'cannot read from a detached stream', 0)
		return ''
	}
	if !stream_is_readable(s) {
		vphp.PhpException.raise_class('RuntimeException', 'stream is not readable', 0)
		return ''
	}
	length_value := length.to_i64()
	if length_value < 0 {
		vphp.PhpException.raise_class('RuntimeException',
			'length must be greater than or equal to zero', 0)
		return ''
	}
	if resource := s.native_resource() {
		result := resource.read(length_value) or {
			raise_stream_error('failed to read from the stream')
			return ''
		}
		return result
	}
	if length_value == 0 || s.position >= s.content.len {
		return ''
	}
	remaining := s.content.len - s.position
	end := if length_value >= remaining { s.content.len } else { s.position + int(length_value) }
	out := s.content[s.position..end]
	unsafe {
		mut writable := &VSlimPsr7Stream(s)
		writable.position = end
	}
	return out
}

@[vphp.PhpExportMethod(name: 'getContents')]
pub fn (s &VSlimPsr7Stream) get_contents() string {
	if s.is_detached() {
		vphp.PhpException.raise_class('RuntimeException', 'cannot read from a detached stream', 0)
		return ''
	}
	if !stream_is_readable(s) {
		vphp.PhpException.raise_class('RuntimeException', 'stream is not readable', 0)
		return ''
	}
	if resource := s.native_resource() {
		result := resource.contents() or {
			raise_stream_error('failed to read the contents of the stream')
			return ''
		}
		return result
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

@[vphp.PhpArgName(v_name: 'default_key', php_name: 'defaultKey')]
@[vphp.PhpExportMethod(name: 'getMetadata')]
pub fn (s &VSlimPsr7Stream) get_metadata(default_key ?vphp.PhpValue) vphp.PhpValue {
	if resource := s.native_resource() {
		mut metadata := resource.stream_metadata_value() or { return psr7_stream_metadata_map(s) }
		defer {
			metadata.release()
		}
		if actual_key := default_key {
			key := actual_key.to_string()
			if key != '' {
				value := metadata.find(key) or { return vphp.PhpValue.null() }
				return value.to_request_scoped()
			}
		}
		return metadata.to_value().to_request_scoped()
	}
	if actual_key := default_key {
		key := actual_key.to_string()
		if key == '' {
			return psr7_stream_metadata_map(s)
		}
		value := s.metadata[key] or { return vphp.PhpValue.null() }
		mut out := vphp.PhpString.of(value)
		return out.take_value()
	}
	return psr7_stream_metadata_map(s)
}

fn psr7_stream_metadata_map(s &VSlimPsr7Stream) vphp.PhpValue {
	return vphp.PhpValue.from_v[map[string]string](s.metadata.clone()) or { vphp.PhpValue.null() }
}
