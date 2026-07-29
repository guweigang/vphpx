module main

import os

fn main() {
	project_dir := os.dir(os.real_path(@FILE))
	repo_root := os.dir(project_dir)
	prefix := os.getenv_opt('VPHP_EMBED_PREFIX') or { '/usr/local/php-embed' }
	header := os.join_path(prefix, 'include', 'php', 'sapi', 'embed', 'php_embed.h')
	library := os.join_path(prefix, 'lib', 'libphp.dylib')
	if !os.is_file(header) || !os.is_file(library) {
		eprintln('PHP embed SDK not found under ${prefix}')
		eprintln('Set VPHP_EMBED_PREFIX to a PHP build containing sapi/embed and libphp.')
		exit(1)
	}

	include_root := os.join_path(prefix, 'include', 'php')
	flags := [
		'-DZTS',
		'-I${os.join_path(project_dir, 'src', 'embed')}',
		'-I${include_root}',
		'-I${os.join_path(include_root, 'main')}',
		'-I${os.join_path(include_root, 'TSRM')}',
		'-I${os.join_path(include_root, 'Zend')}',
		'-I${os.join_path(include_root, 'ext')}',
		'-L${os.join_path(prefix, 'lib')}',
		'-lphp',
		'-Wl,-rpath,${os.join_path(prefix, 'lib')}',
		'-lpthread',
	].join(' ')
	module_path := '${os.join_path(project_dir, 'src')}:${repo_root}:@vlib'
	action := if os.args.len > 1 { os.args[1] } else { 'build' }
	command := match action {
		'test' {
			'VFLAGS=\'-cc clang -cflags "${flags}"\' v -nocache -path "${module_path}" test "${os.join_path(project_dir,
				'src', 'gateway')}"'
		}
		else {
			output := os.join_path(project_dir, 'gateway')
			source := os.join_path(project_dir, 'cmd', 'gateway')
			'v -nocache -path "${module_path}" -cc clang -cflags "${flags}" -o "${output}" "${source}"'
		}
	}
	result := os.execute(command)
	print(result.output)
	if result.exit_code != 0 {
		exit(result.exit_code)
	}
}
