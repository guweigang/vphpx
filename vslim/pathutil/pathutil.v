module pathutil

pub fn is_windows_drive_root_path(path string) bool {
	return path.len == 3 && path[1] == `:` && path[2] == `/`
}

pub fn normalize_bootstrap_dir_path(path string) string {
	mut clean := path.trim_space().replace('\\', '/')
	for clean.len > 1 && clean.ends_with('/') && !is_windows_drive_root_path(clean) {
		clean = clean[..clean.len - 1]
	}
	return clean
}

pub fn path_join(base string, child string) string {
	root := normalize_bootstrap_dir_path(base)
	if root == '' {
		return child
	}
	return root + '/' + child
}

pub fn path_dirname(path string) string {
	clean := normalize_bootstrap_dir_path(path)
	last_forward := clean.last_index('/') or { -1 }
	last_back := clean.last_index('\\') or { -1 }
	last_sep := if last_forward > last_back { last_forward } else { last_back }
	if last_sep <= 0 {
		return ''
	}
	return clean[..last_sep]
}

pub fn path_file_stem(path string) string {
	clean := normalize_bootstrap_dir_path(path)
	last_forward := clean.last_index('/') or { -1 }
	last_back := clean.last_index('\\') or { -1 }
	last_sep := if last_forward > last_back { last_forward } else { last_back }
	mut base := if last_sep >= 0 { clean[last_sep + 1..] } else { clean }
	if base.ends_with('.php') && base.len > 4 {
		base = base[..base.len - 4]
	}
	return base
}

pub fn is_bootstrap_dir_path(path string) bool {
	clean := normalize_bootstrap_dir_path(path).to_lower()
	return clean.ends_with('/bootstrap') || clean.ends_with('\\bootstrap')
}
