module gateway

import os

pub enum TargetKind {
	php
	static_file
}

pub struct Target {
pub:
	kind          TargetKind
	path          string
	document_root string
	script_name   string
}

pub fn match_pattern(pattern string, path string) bool {
	if pattern == '' || pattern == '*' || pattern == '/*' {
		return true
	}
	if pattern.ends_with('/*') {
		prefix := pattern.all_before_last('/*')
		return path == prefix || path.starts_with(prefix + '/')
	}
	if pattern.ends_with('*') {
		return path.starts_with(pattern.all_before_last('*'))
	}
	return path == pattern || path == pattern + '/' || pattern == path + '/'
}

pub fn resolve_target(config Config, request_path string) !Target {
	path := normalize_request_path(request_path)!
	for rule in config.routes {
		if (rule.mode == 'deny' || rule.mode == 'forbidden')
			&& match_pattern(rule.match_pattern, path) {
			return error('forbidden')
		}
	}

	for rule in config.routes {
		if !match_pattern(rule.match_pattern, path) {
			continue
		}
		match rule.mode {
			'static', 'try_static' {
				if rule.root == '' {
					return error('static route ${rule.match_pattern} has no root')
				}
				file_path := safe_join(rule.root, path)!
				if os.is_file(file_path) {
					if is_php_source_path(file_path) {
						if rule.mode == 'static' {
							return error('forbidden')
						}
						continue
					}
					return Target{
						kind:          .static_file
						path:          file_path
						document_root: rule.root
					}
				}
			}
			'embed_php' {
				return resolve_php_target(rule, path)!
			}
			else {}
		}
	}
	return error('no gateway route matched ${path}')
}

fn is_php_source_path(path string) bool {
	extension := os.file_ext(path).to_lower()
	return extension in ['.php', '.php3', '.php4', '.php5', '.php7', '.php8', '.phtml', '.phar',
		'.inc']
}

fn resolve_php_target(rule RouteRule, path string) !Target {
	if rule.entry == '' {
		return error('embed_php route ${rule.match_pattern} has no entry')
	}
	document_root := if rule.root != '' { rule.root } else { os.dir(rule.entry) }
	direct_path := safe_join(document_root, path)!
	if path.ends_with('.php') && os.is_file(direct_path) {
		return Target{
			kind:          .php
			path:          direct_path
			document_root: document_root
			script_name:   path
		}
	}
	if os.is_dir(direct_path) {
		index_path := os.join_path(direct_path, 'index.php')
		if os.is_file(index_path) {
			return Target{
				kind:          .php
				path:          index_path
				document_root: document_root
				script_name:   path.trim_right('/') + '/index.php'
			}
		}
		if !rule.autoindex {
			return error('directory listing is disabled')
		}
	}
	if !os.is_file(rule.entry) {
		return error('PHP entry script not found: ${rule.entry}')
	}
	return Target{
		kind:          .php
		path:          rule.entry
		document_root: document_root
		script_name:   '/index.php'
	}
}

fn normalize_request_path(raw string) !string {
	mut path := raw.all_before('?')
	if path == '' {
		path = '/'
	}
	if !path.starts_with('/') {
		path = '/' + path
	}
	for segment in path.split('/') {
		if segment == '..' {
			return error('request path escapes the document root')
		}
	}
	return path
}

fn safe_join(root string, request_path string) !string {
	clean_root := os.real_path(root)
	candidate := os.norm_path(os.join_path(clean_root, request_path.trim_left('/')))
	if candidate != clean_root && !candidate.starts_with(clean_root + os.path_separator) {
		return error('request path escapes the document root')
	}
	if os.exists(candidate) {
		resolved := os.real_path(candidate)
		if resolved != clean_root && !resolved.starts_with(clean_root + os.path_separator) {
			return error('request path escapes the document root through a symlink')
		}
		return resolved
	}
	return candidate
}
