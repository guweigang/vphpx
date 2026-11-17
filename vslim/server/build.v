module main

import os
import crypto.sha256
import compress.gzip

fn main() {
	project_dir := os.dir(os.real_path(@FILE))
	prefix := os.getenv_opt('VPHP_EMBED_PREFIX') or { '/usr/local/php-embed' }
	header := os.join_path(prefix, 'include', 'php', 'sapi', 'embed', 'php_embed.h')
	shared_library_name := if os.user_os() == 'macos' { 'libphp.dylib' } else { 'libphp.so' }
	shared_library := os.join_path(prefix, 'lib', shared_library_name)
	static_library := os.join_path(prefix, 'lib', 'libphp.a')
	requested_link_mode := os.getenv_opt('VSLIM_RUNTIME_LINK') or { 'auto' }
	link_mode := resolve_link_mode(requested_link_mode, shared_library, static_library) or {
		eprintln(err)
		exit(1)
	}
	library := if link_mode == 'shared' { shared_library } else { static_library }
	if !os.is_file(header) || !os.is_file(library) {
		eprintln('PHP embed SDK not found under ${prefix}')
		eprintln('Set VPHP_EMBED_PREFIX to a PHP build containing sapi/embed and ${os.file_name(library)}.')
		exit(1)
	}
	php_config := os.join_path(prefix, 'bin', 'php-config')
	if !os.is_executable(php_config) {
		eprintln('php-config not found under ${prefix}')
		exit(1)
	}
	configure_options := command_output([php_config, '--configure-options']) or {
		eprintln(err)
		exit(1)
	}
	if !configure_options.contains('--enable-zts') {
		eprintln('VSlim embedded runtime currently requires a ZTS PHP embed SDK.')
		exit(1)
	}
	php_ldflags := if link_mode == 'shared' {
		''
	} else {
		os.getenv_opt('VSLIM_PHP_LDFLAGS') or {
			command_output([php_config, '--ldflags']) or {
				eprintln(err)
				exit(1)
			}
		}
	}
	php_libs := if link_mode == 'shared' {
		''
	} else {
		os.getenv_opt('VSLIM_PHP_LIBS') or {
			command_output([php_config, '--libs']) or {
				eprintln(err)
				exit(1)
			}
		}
	}
	compiler := os.getenv_opt('VSLIM_RUNTIME_CC') or { os.getenv_opt('CC') or { 'clang' } }

	include_root := os.join_path(prefix, 'include', 'php')
	flags := [
		'-DZTS',
		'-I${os.quoted_path(os.join_path(project_dir, 'src', 'embedx'))}',
		'-I${os.quoted_path(include_root)}',
		'-I${os.quoted_path(os.join_path(include_root, 'main'))}',
		'-I${os.quoted_path(os.join_path(include_root, 'TSRM'))}',
		'-I${os.quoted_path(os.join_path(include_root, 'Zend'))}',
		'-I${os.quoted_path(os.join_path(include_root, 'ext'))}',
		php_ldflags,
		if link_mode == 'shared' {
			'-L${os.quoted_path(os.join_path(prefix, 'lib'))} -lphp -Wl,-rpath,${os.quoted_path(os.join_path(prefix, 'lib'))}'
		} else if os.user_os() == 'linux' {
			'-Wl,--whole-archive ${os.quoted_path(static_library)} -Wl,--no-whole-archive'
		} else {
			os.quoted_path(static_library)
		},
		php_libs,
		if link_mode == 'mostly-static' && os.user_os() == 'linux' {
			'-Wl,--export-dynamic'
		} else {
			''
		},
		'-lpthread',
	].join(' ')
	module_path := os.getenv_opt('VSLIM_SERVER_V_MODULE_PATH') or {
		'${os.join_path(project_dir, 'src')}:@vlib'
	}
	gc_mode := (os.getenv_opt('VPHP_V_GC') or { '' }).trim_space()
	action := if os.args.len > 1 { os.args[1] } else { 'build' }
	mut args := [@VEXE, '-nocache', '-path', module_path, '-cc', compiler, '-cflags', flags]
	if action != 'test' && gc_mode != '' {
		args << ['-gc', gc_mode]
	}
	mut generated_path := ''
	mut compressed_extension_path := ''
	match action {
		'test' {
			args << ['test', os.join_path(project_dir, 'src', 'serverx')]
		}
		'app' {
			image := os.getenv('VSLIM_APP_IMAGE')
			extension := os.getenv('VSLIM_APP_EXTENSION')
			output := os.getenv('VSLIM_APP_OUTPUT')
			if !os.is_file(image) {
				eprintln('Set VSLIM_APP_IMAGE to a .vslim-app image.')
				exit(1)
			}
			if !os.is_file(extension) {
				eprintln('Set VSLIM_APP_EXTENSION to the matching ZTS VSlim extension.')
				exit(1)
			}
			if output == '' {
				eprintln('Set VSLIM_APP_OUTPUT to the application executable path.')
				exit(1)
			}
			image_bytes := os.read_bytes(image) or {
				eprintln(err)
				exit(1)
			}
			extension_bytes := os.read_bytes(extension) or {
				eprintln(err)
				exit(1)
			}
			mut fingerprint_bytes := image_bytes.clone()
			fingerprint_bytes << extension_bytes
			app_id := sha256.sum(fingerprint_bytes).hex()[..24]
			compressed_extension := gzip.compress(extension_bytes) or {
				eprintln('Unable to compress VSlim extension: ${err}')
				exit(1)
			}
			compressed_extension_path = os.join_path(project_dir,
				'build_vslim_extension_${os.getpid()}.gz')
			os.write_file_array(compressed_extension_path, compressed_extension) or {
				eprintln(err)
				exit(1)
			}
			generated_path = os.join_path(project_dir, 'build_vslim_app_${os.getpid()}.v')
			os.write_file(generated_path, embedded_app_source(image, compressed_extension_path,
				app_id)) or {
				eprintln(err)
				exit(1)
			}
			// V embeds the payload bytes only in production builds.
			args << ['-prod', '-o', os.real_path(output), generated_path]
		}
		else {
			output := os.join_path(project_dir, 'vslim-server')
			source := os.join_path(project_dir, 'cmd', 'vslim-server')
			args << ['-o', output, source]
		}
	}
	result := os.exec(args)
	if generated_path != '' {
		os.rm(generated_path) or {}
	}
	if compressed_extension_path != '' {
		os.rm(compressed_extension_path) or {}
	}
	print(result.output)
	if result.exit_code != 0 {
		exit(result.exit_code)
	}
}

fn resolve_link_mode(requested string, shared_library string, static_library string) !string {
	if requested !in ['auto', 'shared', 'mostly-static'] {
		return error('VSLIM_RUNTIME_LINK must be auto, shared, or mostly-static. Fully static linking requires static VSlim module registration and is not implemented yet.')
	}
	if requested == 'auto' {
		return if os.is_file(static_library) { 'mostly-static' } else { 'shared' }
	}
	if requested == 'shared' && !os.is_file(shared_library) {
		return error('shared libphp not found: ${shared_library}')
	}
	if requested != 'shared' && !os.is_file(static_library) {
		return error('${requested} linking requires libphp.a: ${static_library}')
	}
	return requested
}

fn command_output(args []string) !string {
	result := os.exec(args)
	if result.exit_code != 0 {
		return error('command failed: ${args.join(' ')}\n${result.output}')
	}
	return result.output.trim_space()
}

fn embedded_app_source(image string, compressed_extension string, app_id string) string {
	image_path := v_quote(os.real_path(image))
	extension_path := v_quote(os.real_path(compressed_extension))
	dollar := '\$'
	return [
		'module main',
		'',
		'import os',
		'import compress.gzip',
		'import compress.szip',
		'import serverx',
		'',
		"const embedded_app_image = ${dollar}embed_file('${image_path}')",
		"const embedded_vslim_extension_gzip = ${dollar}embed_file('${extension_path}')",
		"const embedded_app_id = '${app_id}'",
		'',
		'fn prepare_embedded_app() !string {',
		"\tcache_root := os.getenv_opt('VSLIM_APP_CACHE') or { os.join_path(os.cache_dir(), 'vslim', 'apps') }",
		'\tapp_root := os.join_path(cache_root, embedded_app_id)',
		"\tmarker := os.join_path(app_root, '.vslim-ready')",
		'\tif !os.is_file(marker) {',
		'\t\tos.mkdir_all(app_root)!',
		"\t\timage_path := os.join_path(app_root, '.vslim-app.zip')",
		'\t\tos.write_file_array(image_path, embedded_app_image.to_bytes())!',
		'\t\tszip.extract_zip_to_dir(image_path, app_root)!',
		'\t\tos.rm(image_path)!',
		"\t\tos.mkdir_all(os.join_path(app_root, '.vslim'))!",
		'\t\textension_bytes := gzip.decompress(embedded_vslim_extension_gzip.to_bytes())!',
		"\t\tos.write_file_array(os.join_path(app_root, '.vslim', 'vslim-server-extension.so'), extension_bytes)!",
		'\t\tos.write_file(marker, embedded_app_id)!',
		'\t}',
		"\tos.setenv('VSLIM_EXTENSION_PATH', os.join_path(app_root, '.vslim', 'vslim-server-extension.so'), true)",
		"\treturn os.join_path(app_root, 'vslim.yaml')",
		'}',
		'',
		'fn main() {',
		'\tconfig_path := prepare_embedded_app() or {',
		"\t\teprintln('failed to prepare embedded VSlim application: ${dollar}{err}')",
		'\t\texit(1)',
		'\t}',
		'\tserverx.start(config_path) or {',
		"\t\teprintln('VSlim application failed: ${dollar}{err}')",
		'\t\texit(1)',
		'\t}',
		'}',
		'',
	].join('\n')
}

fn v_quote(value string) string {
	return value.replace('\\', '\\\\').replace("'", "\\'")
}
