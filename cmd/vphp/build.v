module main

import os

fn build_extension(name string, staged string, runtime string, repo string) !string {
	if os.user_os() == 'windows' {
		return build_windows_extension(name, staged, runtime, repo)
	}
	requested_gc := os.getenv('VPHP_V_GC').trim_space()
	gc_mode := if requested_gc in ['', 'auto'] { 'boehm' } else { requested_gc }
	cc := selected_cc()
	php_config := selected_php_config()
	php_includes := os.split_args(run_tool([php_config, '--includes'])!)!
	transpiled := os.join_path(staged, '${name}_generated.c')
	flags_file := transpiled + '.flags'
	v_executable := selected_v()
	mut args := [v_executable, '-nocache', '-enable-globals', '-gc', gc_mode, '-cc', cc, '-path',
		'${staged}:${repo}:@vmodules:@vlib', '-shared', '-dump-c-flags', flags_file, '-o', transpiled]
	args << gc_build_flags(os.user_os(), os.read_file('/etc/alpine-release') or { '' }, gc_mode)
	build_script := os.join_path(staged, 'build.v')
	if os.is_file(build_script) {
		args << ['-exclude', build_script]
	}
	args << staged
	run_tool(args)!

	output := os.join_path(os.dir(staged), '${name}.so')
	mut link := [cc, '-shared', '-fPIC', '-D_GNU_SOURCE', '-DCOMPILE_DL_${name.to_upper()}=1']
	link << php_includes
	link << ['-I' + runtime, '-I' + staged, transpiled, os.join_path(staged, 'php_bridge.c'),
		os.join_path(runtime, 'v_bridge.c'), '-o', output]
	link << native_flags(flags_file)!
	link << '-fvisibility=default'
	if os.user_os() == 'macos' {
		link << ['-undefined', 'dynamic_lookup']
	} else if os.user_os() == 'linux' {
		// V workers and the collector can still run during PHP's dlclose.
		link << '-Wl,-z,nodelete'
	}
	run_tool(link)!
	return output
}

// Alpine provides a musl-compatible shared collector through gc-dev. The V
// bundled collector can misidentify data roots when loaded into musl/arm64 PHP.
fn gc_build_flags(platform string, alpine_release string, gc_mode string) []string {
	if platform != 'linux' || gc_mode != 'boehm' {
		return []
	}
	if alpine_release.trim_space() != '' {
		return ['-d', 'dynamic_boehm']
	}
	return ['-d', 'use_bundled_libgc']
}

fn native_flags(path string) ![]string {
	mut flags := []string{}
	mut skip_language := false
	for line in os.read_lines(path)! {
		for flag in os.split_args(line)! {
			if skip_language {
				skip_language = false
				continue
			}
			if flag == '-x' {
				skip_language = true
				continue
			}
			if flag == '-shared' || flag == '-fvisibility=hidden'
				|| flag.starts_with('-Wl,-exported_symbol,')
				|| flag.starts_with('-Wl,--version-script') {
				continue
			}
			flags << flag
		}
	}
	return flags
}

fn run_tool(args []string) !string {
	result := os.exec(args)
	if result.exit_code != 0 {
		return error('${args[0]} exited with code ${result.exit_code}\n${result.output.trim_space()}')
	}
	return result.output
}
