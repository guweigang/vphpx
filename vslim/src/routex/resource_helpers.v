module routex

pub struct Resource {}

pub fn Resource.normalize_path(path string) string {
	mut clean := path.trim_space()
	if clean == '' {
		return ''
	}
	if !clean.starts_with('/') {
		clean = '/${clean}'
	}
	clean = clean.trim_right('/')
	if clean == '' {
		return '/'
	}
	return clean
}

pub fn Resource.name_from_path(path string) string {
	mut clean := path.trim_space()
	if clean.starts_with('/') {
		clean = clean[1..]
	}
	if clean == '' {
		return 'resource'
	}
	return clean.replace('/', '.')
}

pub fn Resource.normalize_param_name(param_name string) string {
	mut clean := param_name.trim_space().trim_left(':')
	if clean == '' {
		return 'id'
	}
	return clean
}

pub fn Resource.shallow_member_base_path(path string) string {
	mut clean := Resource.normalize_path(path)
	if clean == '' || clean == '/' {
		return clean
	}
	segments := clean.trim_left('/').split('/').filter(it.len > 0)
	if segments.len == 0 {
		return clean
	}
	last_segment := segments[segments.len - 1]
	return '/${last_segment}'
}
