module main

import os

fn windows_sdk_path() !string {
	path := os.getenv('VPHP_PHP_SDK').trim_space()
	if path == '' || !os.is_file(os.join_path(path, 'phpize.bat')) {
		return error('set VPHP_PHP_SDK to the matching x64 NTS PHP devel pack containing phpize.bat')
	}
	return os.real_path(path)
}

fn windows_sdk_matches_php(sdk string, php string) !string {
	version := run_tool([php, '-n', '-r', 'echo PHP_VERSION;'])!.trim_space()
	for path in os.walk_ext(sdk, '.h') {
		if os.file_name(path).to_lower() != 'php_version.h' { continue }
		for line in os.read_lines(path)! {
			parts := line.fields()
			if parts.len >= 3 && parts[0] == '#define' && parts[1] == 'PHP_VERSION' {
				sdk_version := parts[2].trim('"')
				if sdk_version != version {
					return error('PHP version ${version} does not match SDK version ${sdk_version}')
				}
				return 'PHP ${version} matches SDK'
			}
		}
	}
	return error('PHP SDK version header was not found under ${sdk}')
}

fn inspect_windows_dependencies() ![]DependencyCheck {
	php := selected_php()
	mut checks := [
		probe_dependency('V', 'VPHP_V', [selected_v(), 'version']),
		probe_dependency('PHP CLI', 'VPHP_PHP', [php, '-n', '-r', 'echo PHP_VERSION_ID;']),
	]
	for tool in ['cl', 'nmake', 'bison', 're2c'] {
		path := find_program(tool) or { '' }
		checks << DependencyCheck{ key: tool, ok: path != '', detail: if path != '' {
			path
		} else {
			'not found; install Windows PHP build prerequisites and use an x64 MSVC developer prompt'
		} }
	}
	sdk := windows_sdk_path() or { '' }
	checks << DependencyCheck{ key: 'PHP SDK', ok: sdk != '', detail: if sdk != '' {
		sdk
	} else {
		'set VPHP_PHP_SDK to the matching PHP devel pack'
	} }
	if sdk != '' {
		sdk_match := windows_sdk_matches_php(sdk, php) or {
			checks << DependencyCheck{ key: 'PHP SDK version', detail: err.msg() }
			''
		}
		if sdk_match != '' {
			checks << DependencyCheck{ key: 'PHP SDK version', ok: true, detail: sdk_match }
		}
	}
	mode := os.exec([php, '-n', '-r', 'echo PHP_INT_SIZE, chr(58), (int) PHP_ZTS, chr(58), (int) PHP_DEBUG;'])
	checks << DependencyCheck{ key: 'PHP ABI', ok: mode.exit_code == 0 && mode.output.trim_space() == '8:0:0', detail: 'requires 64-bit non-debug NTS PHP; detected ${mode.output.trim_space()}' }
	return checks
}

fn windows_config(name string, runtime string, vroot string) string {
	php_dir := runtime.replace('/', '\\').replace('\\', '\\\\')
	v_dir := vroot.replace('/', '\\').replace('\\', '\\\\')
	return 'ARG_ENABLE("${name}", "${name} support", "yes");\n' +
		'if (PHP_${name.to_upper()} != "no") {\n' +
		'  EXTENSION("${name}", "php_bridge.c ${name}_generated.c", PHP_${name.to_upper()}_SHARED, \'/I "${php_dir}" /I "${v_dir}\\\\thirdparty\\\\zip"\');\n' +
		'  ADD_SOURCES("${php_dir}", "v_bridge.c", "${name}");\n' +
		'  ADD_SOURCES("${v_dir}\\\\vlib\\\\builtin", "core_windows.c", "${name}");\n' +
		'  ADD_FLAG("LIBS_${name.to_upper()}", " ws2_32.lib bcrypt.lib crypt32.lib secur32.lib user32.lib advapi32.lib shell32.lib iphlpapi.lib normaliz.lib dbghelp.lib ");\n}\n'
}

fn build_windows_extension(name string, staged string, runtime string, repo string) !string {
	checks := inspect_windows_dependencies()!
	if checks.any(!it.ok) {
		print_dependency_checks(checks)
		return error('Windows build dependencies are incomplete; run vphp doctor')
	}
	sdk := windows_sdk_path()!
	v := selected_v()
	vroot := os.dir(os.real_path(v))
	generated := os.join_path(staged, '${name}_generated.c')
	run_tool([v, '-nocache', '-enable-globals', '-gc', 'none', '-cc', 'msvc', '-path',
		'${staged};${repo};@vmodules;@vlib', '-shared', '-o', generated, staged])!
	os.write_file(os.join_path(staged, 'config.w32'), windows_config(name, runtime, vroot))!
	php_dir := os.dir(os.real_path(selected_php()))
	phpize := os.join_path(sdk, 'phpize.bat')
	run_tool(['cmd', '/c', phpize])!
	run_tool(['cmd', '/c', 'configure.bat', '--enable-${name}=shared', '--with-prefix=${php_dir}',
		'--with-php-build=${sdk}'])!
	run_tool(['nmake'])!
	for directory in ['x64/Release', 'Release', 'x64/Release_TS', 'Release_TS'] {
		dll := os.join_path(staged, directory, 'php_${name}.dll')
		if os.is_file(dll) { return dll }
	}
	return error('Windows build completed without php_${name}.dll')
}
