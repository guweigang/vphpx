module main

import os
import rand

struct DependencyCheck {
	key        string
	ok         bool
	detail     string
	customized bool
}

fn managed_v_directory() string {
	configured := os.getenv('XDG_DATA_HOME')
	data := if os.is_abs_path(configured) {
		configured
	} else {
		os.join_path(os.home_dir(), '.local', 'share')
	}
	return os.join_path(data, 'vphp', 'toolchains', 'v')
}

fn selected_v() string {
	if selected := os.getenv_opt('VPHP_V') {
		return selected
	}
	if installed := find_program('v') {
		return installed
	}
	managed := os.join_path(managed_v_directory(), 'v')
	return if os.is_executable(managed) { managed } else { 'v' }
}

fn probe_dependency(key string, env_key string, args []string) DependencyCheck {
	result := os.exec(args)
	return DependencyCheck{
		key:        key
		ok:         result.exit_code == 0 && result.output.trim_space() != ''
		detail:     '${args[0]}: ${result.output.trim_space().all_before('\n')}'
		customized: os.getenv_opt(env_key) != none
	}
}

fn probe_c_compiler(cc string) DependencyCheck {
	$if macos {
		// Apple's compiler stubs can open an installer even for --version.
		// Keep doctor and --dry-run read-only; the setup phase owns installation.
		if os.real_path(cc).starts_with('/usr/bin/') {
			tools := os.exec(['/usr/bin/xcode-select', '--print-path'])
			if tools.exit_code != 0 {
				return DependencyCheck{ key: 'C compiler', detail: 'Apple Command Line Tools are not installed', customized: os.getenv_opt('VPHP_CC') != none }
			}
		}
	}
	return probe_dependency('C compiler', 'VPHP_CC', [cc, '--version'])
}

fn inspect_dependencies() ![]DependencyCheck {
	if os.user_os() == 'windows' {
		return inspect_windows_dependencies()
	}
	cc := selected_cc()
	php := selected_php()
	php_config := selected_php_config()
	mut checks := [
		probe_dependency('V', 'VPHP_V', [selected_v(), 'version']),
		probe_c_compiler(cc),
		probe_dependency('PHP CLI', 'VPHP_PHP', [php, '-n', '-r', 'echo PHP_VERSION_ID;']),
		probe_dependency('PHP SDK', 'VPHP_PHP_CONFIG', [php_config, '--version']),
	]
	mut headers := DependencyCheck{
		key:    'PHP headers / ABI'
		detail: 'requires a working C compiler, PHP CLI and php-config'
	}
	if checks[1].ok && checks[2].ok && checks[3].ok {
		headers = probe_php_headers(cc, php, php_config) or {
			DependencyCheck{ key: 'PHP headers / ABI', detail: err.msg() }
		}
	}
	checks << headers
	return checks
}

fn probe_php_headers(cc string, php string, php_config string) !DependencyCheck {
	version := run_tool([php, '-n', '-r', 'echo PHP_VERSION_ID;'])!.trim_space()
	mode := run_tool([php, '-n', '-r', 'echo (int) PHP_ZTS, ":", (int) PHP_DEBUG;'])!.trim_space().split(':')
	if version == '' || !version.bytes().all(it.is_digit()) || version.int() < 80200
		|| mode.len != 2 || mode.any(it !in ['0', '1']) {
		return DependencyCheck{ key: 'PHP headers / ABI', detail: 'PHP 8.2+ is required; invalid PHP build metadata' }
	}
	includes := os.split_args(run_tool([php_config, '--includes'])!)!
	directory := os.join_path(os.temp_dir(), 'vphp-doctor-${rand.uuid_v4()}')
	os.mkdir(directory)!
	defer { os.rmdir_all(directory) or {} }
	probe := os.join_path(directory, 'probe.c')
	os.write_file(probe, '#include <php.h>\n#if PHP_VERSION_ID != ${version}\n#error PHP CLI and headers have different versions\n#endif\n#ifndef ZTS\n#define ZTS 0\n#endif\n#if ZTS != ${mode[0]} || ZEND_DEBUG != ${mode[1]}\n#error PHP CLI and headers have different build modes\n#endif\nint main(void) { return 0; }\n')!
	result := os.exec([cc, ...includes, '-D_GNU_SOURCE', '-fsyntax-only', probe])
	return DependencyCheck{
		key:    'PHP headers / ABI'
		ok:     result.exit_code == 0
		detail: if result.exit_code == 0 {
			'headers match PHP ${version} (ZTS=${mode[0]}, debug=${mode[1]})'
		} else {
			result.output.trim_space()
		}
	}
}

fn print_dependency_checks(checks []DependencyCheck) {
	for check in checks {
		println('[${if check.ok { 'OK' } else { 'MISSING/INVALID' }}] ${check.key}: ${check.detail}')
	}
}

fn doctor() ! {
	checks := inspect_dependencies()!
	print_dependency_checks(checks)
	if checks.any(!it.ok) {
		return error('development environment is incomplete; run vphp setup to install dependencies or setup --dry-run to preview')
	}
	println('Development environment is ready.')
}
