module httpx

import vphp

@[php_arg_name: 'default_stream=defaultStream,default_size=defaultSize,default_error=defaultError,default_client_filename=defaultClientFilename,default_client_media_type=defaultClientMediaType']
@[php_method]
pub fn (mut u VSlimPsr7UploadedFile) construct(default_stream vphp.PhpValue, default_size ?int, default_error int, default_client_filename ?string, default_client_media_type ?string) &VSlimPsr7UploadedFile {
	u.stream_ref = VSlimPsr7Stream.from_value(default_stream)
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
		vphp.PhpException.raise_class('RuntimeException',
			'uploaded file stream is no longer available after moveTo', 0)
		return u.stream_ref
	}
	if u.error_code != 0 {
		vphp.PhpException.raise_class('RuntimeException',
			'cannot retrieve stream for errored upload', 0)
		return u.stream_ref
	}
	if u.stream_ref == unsafe { nil } {
		unsafe {
			mut writable := &VSlimPsr7UploadedFile(u)
			writable.stream_ref = VSlimPsr7Stream.from_content('')
		}
	}
	return u.stream_ref
}

@[php_arg_name: 'target_path=targetPath']
@[php_method: 'moveTo']
pub fn (u &VSlimPsr7UploadedFile) move_to(target_path vphp.PhpValue) {
	path := value_subject(target_path).log_message().trim_space()
	if path == '' {
		vphp.PhpException.raise_class('InvalidArgumentException', 'target path must not be empty',
			0)
		return
	}
	if u.moved {
		vphp.PhpException.raise_class('RuntimeException', 'uploaded file has already been moved', 0)
		return
	}
	if u.error_code != 0 {
		vphp.PhpException.raise_class('RuntimeException',
			'cannot move uploaded file with upload error', 0)
		return
	}
	stream := if u.stream_ref == unsafe { nil } { VSlimPsr7Stream.from_content('') } else { u.stream_ref }
	content := stream.stream_string()
	size := if u.size_hint >= 0 { u.size_hint } else { content.len }
	mut path_arg := vphp.PhpString.of(path)
	mut content_arg := vphp.PhpString.of(content)
	defer {
		path_arg.release()
		content_arg.release()
	}
	moved := vphp.PhpFunction.named('file_put_contents').with_result[vphp.PhpValue, bool](fn (result vphp.PhpValue) bool {
		return result.is_valid() && !result.is_null() && !result.is_undef()
			&& (!result.is_bool() || result.to_bool())
	}, path_arg, content_arg) or { false }
	if !moved {
		vphp.PhpException.raise_class('RuntimeException',
			'failed to move uploaded file to target path', 0)
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
