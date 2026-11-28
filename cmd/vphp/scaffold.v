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
	os.mkdir(os.join_path(pending, 'src'))!
	os.write_file(os.join_path(pending, 'v.mod'), "Module {\n\tname: '${name}'\n\tversion: '0.1.0'\n\tdescription: 'PHP extension built with VPHP'\n}\n")!
	os.write_file(os.join_path(pending, 'src', 'config.toml'), '[extension]\nname = "${name}"\nversion = "0.1.0"\ndescription = "PHP extension built with VPHP"\n\n# [ini."${name}.example"]\n# default = "1"\n# access = "all"\n')!
	os.write_file(os.join_path(pending, 'src', 'config.v'), 'module main\n\nimport vphp\n\n// Module globals are accessed through VPHP\'s request-aware API.\n@[vphp.PhpGlobals]\npub struct ExampleGlobals {\npub mut:\n    calls int\n}\n\n@[vphp.PhpExportConstant(name: \'${name}_VERSION\')]\nconst example_version = \'1.0.0\'\n\n@[vphp.PhpExportFunction(name: \'${name}_hello\')]\nfn hello(name string) string {\n    return \'Hello, \u0024{name}!\'\n}\n\n@[vphp.PhpExportFunction(name: \'${name}_count_calls\')]\nfn count_calls() int {\n    vphp.with_globals[ExampleGlobals](fn (mut globals ExampleGlobals) {\n        globals.calls++\n    })\n    return vphp.get_globals[ExampleGlobals]().calls\n}\n\n// PHP inheritance is declared explicitly with PhpExtends.\n@[vphp.PhpExportClass(name: \'${name}_Greeter\')]\n@[vphp.PhpDeclaredPropertyWithDefault(name: \'greeting\', php_type: \'string\', default_value: "\'Hello\'")]\npub struct Greeter {}\n\n@[vphp.PhpExportClass(name: \'${name}_FriendlyGreeter\')]\n@[vphp.PhpExtends(name: \'Greeter\')]\npub struct FriendlyGreeter {}\n\n@[vphp.PhpExportMethod(name: \'message\')]\npub fn (greeter &FriendlyGreeter) message() string {\n    return \'Welcome to VPHP!\'\n}\n')!
	os.write_file(os.join_path(pending, 'tests', 'smoke.php'), '<?php\n\nif (${name}_hello(\'VPHP\') !== \'Hello, VPHP!\') {\n    throw new RuntimeException(\'Unexpected greeting\');\n}\nif (constant(\'${name}_VERSION\') !== \'1.0.0\') {\n    throw new RuntimeException(\'Unexpected constant\');\n}\nif (${name}_count_calls() !== 1 || ${name}_count_calls() !== 2) {\n    throw new RuntimeException(\'Unexpected globals\');\n}\n\u0024greeter = new ${name}_FriendlyGreeter();\nif (!(\u0024greeter instanceof ${name}_Greeter) || \u0024greeter->greeting !== \'Hello\' || \u0024greeter->message() !== \'Welcome to VPHP!\') {\n    throw new RuntimeException(\'Unexpected class inheritance\');\n}\necho "OK\\n";\n')!
	os.write_file(os.join_path(pending, '.gitignore'), '/build/\n')!
	library := if os.user_os() == 'windows' { 'php_${name}.dll' } else { '${name}.so' }
	os.write_file(os.join_path(pending, 'README.md'), '# ${name}\n\nRequires V, a C compiler, PHP CLI and matching PHP development headers.\nThe bundled `vphp` executable includes the VPHP SDK; no repository checkout is needed.\nEdit `src/config.toml` to configure extension metadata and PHP INI entries.\n`src/config.v` demonstrates functions, module globals, constants, classes, and PHP inheritance.\n`tests/smoke.php` shows how to call the exported API.\nUse `vphp setup --dry-run` to preview setup or `vphp doctor` to check dependencies.\nOn Windows, use an x64 MSVC developer prompt and set `VPHP_PHP_SDK` to the matching NTS PHP devel pack containing `phpize.bat`.\n\n```sh\nvphp check\nvphp build\nphp -n -d extension=build/${library} tests/smoke.php\nvphp stub\n```\n\nSet `VPHP_V`, `VPHP_PHP`, `VPHP_PHP_CONFIG`, `VPHP_PHP_SDK`, `VPHP_CC` or `VPHP_V_GC` to select your local tools.\n')!
	if os.exists(project) || os.is_link(project) {
		return error('destination already exists: ${project}')
	}
	os.rename(pending, project)!
	println('Created ${project}\nNext: cd ${os.quoted_path(project)} && vphp build')
}
