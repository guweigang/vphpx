module httpx

import vphp

fn VSlimPsr7UploadedFile.from_stream(stream &VSlimPsr7Stream, size ?int, error int, client_filename ?string, client_media_type ?string) &VSlimPsr7UploadedFile {
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

fn is_uploaded_file_leaf(value vphp.PhpValue) bool {
	return value.is_valid() && value.is_object()
		&& (value.is_instance_of('VSlim\\Psr7\\UploadedFile')
		|| value.is_instance_of('VSlimPsr7UploadedFile')
		|| value.is_instance_of('Psr\\Http\\Message\\UploadedFileInterface'))
}

fn uploaded_files_tree_is_valid(value vphp.PhpValue) bool {
	if !value.is_valid() || value.is_null() || value.is_undef() || !value.is_array() {
		return false
	}
	arr := value.as_array() or { return false }
	defer {
		arr.release()
	}
	return uploaded_files_tree_array_is_valid(arr)
}

fn uploaded_files_tree_array_is_valid(arr vphp.PhpArray) bool {
	result := arr.fold_values[[]bool]([true], fn (key vphp.PhpValue, child vphp.PhpValue, mut ok []bool) {
		_ = key
		if ok.len == 0 || !ok[0] {
			return
		}
		if child.is_array() {
			if !uploaded_files_tree_is_valid(child) {
				ok[0] = false
			}
			return
		}
		if !is_uploaded_file_leaf(child) {
			ok[0] = false
		}
	})
	return result.len > 0 && result[0]
}

pub fn normalize_uploaded_files_tree_value(value vphp.PhpValue) vphp.PhpArray {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return empty_persistent_array()
	}
	if !uploaded_files_tree_is_valid(value) {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'uploaded files must be an array tree of UploadedFileInterface instances', 0)
		return empty_persistent_array()
	}
	return persistent_array_value_owned(value)
}

pub fn normalize_uploaded_files_tree_array(value vphp.PhpArray) vphp.PhpArray {
	if !value.is_valid() {
		return empty_persistent_array()
	}
	if !uploaded_files_tree_array_is_valid(value) {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'uploaded files must be an array tree of UploadedFileInterface instances', 0)
		return empty_persistent_array()
	}
	return value.retain()
}
