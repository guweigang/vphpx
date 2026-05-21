module httpx

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
pub fn (s &VSlimPsr7Stream) detach() vphp.PhpNull {
	unsafe {
		mut writable := &VSlimPsr7Stream(s)
		writable.detached = true
		writable.position = 0
		writable.content = ''
		writable.metadata = map[string]string{}
	}
	return vphp.PhpNull.value()
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
		vphp.PhpException.raise_class('RuntimeException',
			'unable to determine stream position for a detached stream', 0)
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
pub fn (s &VSlimPsr7Stream) seek(offset vphp.PhpValue, default_whence vphp.PhpValue) {
	if s.detached {
		vphp.PhpException.raise_class('RuntimeException', 'cannot seek a detached stream', 0)
		return
	}
	if !stream_is_seekable(s) {
		vphp.PhpException.raise_class('RuntimeException', 'stream is not seekable', 0)
		return
	}
	offset_value := int(offset.to_i64())
	whence := value_subject(default_whence).psr7_seek_whence()
	if whence !in [0, 1, 2] {
		vphp.PhpException.raise_class('RuntimeException', 'invalid whence for stream seek', 0)
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
		vphp.PhpException.raise_class('RuntimeException', 'cannot rewind a detached stream', 0)
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
pub fn (s &VSlimPsr7Stream) write(chunk vphp.PhpValue) int {
	if s.detached {
		vphp.PhpException.raise_class('RuntimeException', 'cannot write to a detached stream', 0)
		return 0
	}
	if !stream_is_writable(s) {
		vphp.PhpException.raise_class('RuntimeException', 'stream is not writable', 0)
		return 0
	}
	text := value_or_empty_string(chunk)
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
pub fn (s &VSlimPsr7Stream) read(length vphp.PhpValue) string {
	if s.detached {
		vphp.PhpException.raise_class('RuntimeException', 'cannot read from a detached stream', 0)
		return ''
	}
	if !stream_is_readable(s) {
		vphp.PhpException.raise_class('RuntimeException', 'stream is not readable', 0)
		return ''
	}
	length_value := int(length.to_i64())
	if length_value < 0 {
		vphp.PhpException.raise_class('RuntimeException',
			'length must be greater than or equal to zero', 0)
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
		vphp.PhpException.raise_class('RuntimeException', 'cannot read from a detached stream', 0)
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
pub fn (s &VSlimPsr7Stream) get_metadata(default_key ?vphp.PhpValue) vphp.PhpValue {
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
