module main

import os
import rand

fn create_project(project string) ! {
	if os.exists(project) || os.is_link(project) {
		return error('destination already exists: ${project}')
	}
	name := os.file_name(project)
	// Prepare next to the destination, then publish the complete scaffold.
	os.mkdir_all(os.dir(project))!
	pending := os.join_path(os.dir(project), '.vphp-new-${rand.uuid_v4()}')
	os.mkdir(pending)!
	defer {
		os.rmdir_all(pending) or {}
	}
	os.mkdir(os.join_path(pending, 'tests'))!
	os.write_file(os.join_path(pending, 'v.mod'), "Module {\n\tname: '${name}'\n\tversion: '0.1.0'\n\tdescription: 'PHP extension built with VPHP'\n}\n")!
	os.write_file(os.join_path(pending, 'extension.v'), "module main\n\nimport vphp\n\nconst ext_config = vphp.ExtensionConfig{\n\tname: '${name}'\n\tversion: '0.1.0'\n\tdescription: 'PHP extension built with VPHP'\n}\n\n@[vphp.PhpExportFunction(name: '${name}_hello')]\nfn hello(name string) string {\n\treturn 'Hello, \u0024{name}!'\n}\n")!
	os.write_file(os.join_path(pending, 'tests', 'smoke.php'), '<?php\n\nif (${name}_hello(\'VPHP\') !== \'Hello, VPHP!\') {\n    throw new RuntimeException(\'Unexpected greeting\');\n}\necho "OK\\n";\n')!
	os.write_file(os.join_path(pending, '.gitignore'), '/build/\n')!
	library := if os.user_os() == 'windows' { 'php_${name}.dll' } else { '${name}.so' }
	os.write_file(os.join_path(pending, 'README.md'), '# ${name}\n\nRequires V, a C compiler, PHP CLI and matching PHP development headers.\nThe bundled `vphp` executable includes the VPHP SDK; no repository checkout is needed.\nUse `vphp setup --dry-run` to preview setup or `vphp doctor` to check dependencies.\nOn Windows, use an x64 MSVC developer prompt and set `VPHP_PHP_SDK` to the matching NTS PHP devel pack containing `phpize.bat`.\n\n```sh\nvphp check\nvphp build\nphp -n -d extension=build/${library} tests/smoke.php\nvphp stub\n```\n\nSet `VPHP_V`, `VPHP_PHP`, `VPHP_PHP_CONFIG`, `VPHP_PHP_SDK`, `VPHP_CC` or `VPHP_V_GC` to select your local tools.\n')!
	if os.exists(project) || os.is_link(project) {
		return error('destination already exists: ${project}')
	}
	os.rename(pending, project)!
	println('Created ${project}\nNext: cd ${os.quoted_path(project)} && vphp build')
}
