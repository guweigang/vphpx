module main

import os

// Bootstrap must work before brew shellenv has been added to the user's shell.
fn find_program(name string) !string {
	if path := os.find_abs_path_of_executable(name) { return path }
	$if macos {
		prefix := os.getenv('HOMEBREW_PREFIX')
		directories := if os.is_abs_path(prefix) {
			[os.join_path(prefix, 'bin')]
		} else {
			['/opt/homebrew/bin', '/usr/local/bin']
		}
		for directory in directories {
			path := os.join_path(directory, name)
			if os.is_executable(path) { return path }
		}
	}
	return error('executable not found: ${name}')
}

fn selected_cc() string {
	return os.getenv_opt('VPHP_CC') or { find_program('cc') or { 'cc' } }
}

fn selected_php() string {
	if configured := os.getenv_opt('VPHP_PHP') { return configured }
	if path := find_program('php') { return path }
	for suffix in ['86', '85', '84', '83', '82', '8'] {
		if path := find_program('php${suffix}') { return path }
	}
	return 'php'
}

fn selected_php_config() string {
	if configured := os.getenv_opt('VPHP_PHP_CONFIG') { return configured }
	// Alpine's phpNN/php-configNN pair must stay together when versions coexist.
	php := os.file_name(os.real_path(selected_php()))
	if php.starts_with('php') && php.len > 3 && php[3..].bytes().all(it.is_digit()) {
		if path := find_program('php-config${php[3..]}') { return path }
	}
	return find_program('php-config') or { 'php-config' }
}
