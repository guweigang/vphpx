module main

import os
import rand
import json2
import vphp.compiler
import v.vmod

const usage = 'Usage: vphp new <directory>\n       vphp <build|check|stub> [project-directory] [--output <file>]\n       vphp doctor\n       vphp setup [--dry-run|--yes]\n\nOptions:\n  -h, --help       Show help\n  -v, --version    Show CLI version\n\nsetup installs missing dependencies and verifies an extension build.\n--dry-run previews only; --yes skips installer confirmations where supported.\nEnvironment: VPHP_V, VPHP_PHP, VPHP_PHP_CONFIG, VPHP_CC, VPHP_V_GC'

struct Command {
	action  string
	project string
	output  string
	apply   bool
	yes     bool
}

fn main() {
	// V's runtime may seed this with the packaging machine's compiler path.
	// External tools must discover their own V root; VPHP_V is our override.
	os.unsetenv('VEXE')
	run(parse_command(os.args[1..]) or {
		eprintln('vphp: ${err}\n${usage}')
		exit(2)
	}) or {
		eprintln('vphp: ${err}')
		exit(1)
	}
}

fn parse_command(args []string) !Command {
	if args.len == 0 {
		return Command{ action: 'help' }
	}
	action := args[0]
	if action in ['-h', '--help', 'help', '-v', '--version', 'version'] {
		if args.len != 1 {
			return error('unexpected argument ${args[1]}')
		}
		if action in ['-v', '--version', 'version'] {
			return Command{ action: 'version' }
		}
		return Command{ action: 'help' }
	}
	if args.len == 2 && action in ['new', 'build', 'check', 'stub', 'doctor', 'setup']
		&& args[1] in ['-h', '--help'] {
		return Command{ action: 'help' }
	}
	if action in ['doctor', 'setup'] {
		if args.len > 2 || (args.len == 2 && (action == 'doctor'
			|| args[1] !in ['--dry-run', '--yes'])) {
			return error('expected doctor or setup [--dry-run|--yes]')
		}
		return Command{ action: action, apply: action == 'setup' && (args.len == 1 || args[1] != '--dry-run'), yes: args.len == 2 && args[1] == '--yes' }
	}
	if action == 'new' {
		if args.len != 2 || args[1].starts_with('-') {
			return error('new requires one project directory')
		}
		project := os.abs_path(args[1])
		if !valid_extension_name(os.file_name(project)) {
			return error('extension directory name must be a C identifier')
		}
		return Command{ action: action, project: project }
	}
	if action !in ['build', 'check', 'stub'] {
		return error('unknown command ${action}')
	}
	mut project := ''
	mut output := ''
	mut i := 1
	for i < args.len {
		arg := args[i]
		if arg == '--output' && output == '' && action != 'check' {
			i++
			if i == args.len || args[i].starts_with('-') {
				return error('--output requires a file path')
			}
			output = os.abs_path(args[i])
		} else if !arg.starts_with('-') && project == '' {
			project = os.real_path(arg)
		} else {
			return error('unexpected argument ${arg}')
		}
		i++
	}
	if project == '' {
		project = os.getwd()
	}
	if !os.is_dir(project) {
		return error('project directory does not exist: ${project}')
	}
	return Command{ action: action, project: project, output: output }
}

fn run(command Command) ! {
	if command.action == 'doctor' {
		return doctor()
	}
	if command.action == 'setup' {
		return setup_dependencies(command.apply, command.yes)
	}
	if command.action == 'help' {
		println(usage)
		return
	}
	if command.action == 'version' {
		manifest := vmod.decode(@VMOD_FILE)!
		println('vphp ${manifest.version}')
		return
	}
	if command.action == 'new' {
		create_project(command.project)!
		return
	}
	if os.user_os() !in ['macos', 'linux'] {
		return error('the standalone builder currently targets macOS and Linux')
	}
	entries := os.ls(command.project)!
	if !entries.any(is_extension_source(it) && os.is_file(os.join_path(command.project, it))) {
		return error('expected a V source file at the project root')
	}
	php := selected_php()
	inferred_php := os.getenv_opt('VPHP_PHP') == none
	if inferred_php {
		// The compiler's internal-parent reflection probes must use the same PHP.
		os.setenv('VPHP_PHP', php, true)
	}
	defer {
		if inferred_php { os.unsetenv('VPHP_PHP') }
	}
	scratch_parent := os.real_path(os.getenv_opt('VPHP_CLI_SCRATCH') or { os.temp_dir() })
	scratch := os.join_path(scratch_parent, 'vphp-${rand.uuid_v4()}')
	os.mkdir(scratch)!
	defer {
		os.rmdir_all(scratch) or {}
	}
	runtime := prepare_sdk(scratch)!
	repo := os.dir(runtime)
	staged := os.join_path(scratch, 'project')
	os.mkdir(staged)!
	os.symlink(runtime, os.join_path(scratch, 'vphp'))!
	mut sources := []string{}
	stage_sources(command.project, staged, mut sources)!
	sources.sort()
	previous_dir := os.getwd()
	os.chdir(staged)!
	defer {
		os.chdir(previous_dir) or {}
	}

	mut generator := compiler.new(sources)
	name := generator.compile() or {
		return error(rebase_diagnostic(err.msg(), staged, command.project))
	}
	if !valid_extension_name(name) {
		return error('ExtensionConfig.name must be a C identifier: ${name}')
	}
	generator.generate_all() or {
		return error(rebase_diagnostic(err.msg(), staged, command.project))
	}

	declarations := generator.userland_class_declarations()
	classes_file := os.join_path(scratch, '${name}.so.classes.php')
	if declarations != '' {
		os.write_file(classes_file, '${compiler.userland_classes_header}\n${declarations}\n')!
		run_tool([php, '-n', '-l', classes_file])!
	}
	extension := build_extension(name, staged, runtime, repo) or {
		return error(rebase_diagnostic(err.msg(), staged, command.project))
	}
	if command.action == 'check' {
		println('Checked ${name}')
		return
	}
	if command.action == 'stub' {
		renderer := os.join_path(runtime, 'stub', 'render.php')
		mut php_command := [php, '-n']
		tokenizer := run_tool([php, '-n', os.join_path(runtime, 'stub', 'tokenizer_path.php')]) or { '' }
		if os.is_file(tokenizer) {
			php_command << ['-d', 'extension=${tokenizer}']
		}
		adaptations := os.join_path(scratch, 'trait-adaptations.json')
		os.write_file(adaptations, json2.encode(generator.stub_trait_adaptations()))!
		overrides := {
			'methods':    generator.stub_override_interfaces()
			'properties': generator.stub_property_override_interfaces()
			'hooks':      generator.stub_hook_interfaces()
		}
		expressions := os.join_path(scratch, 'stub-expressions.json')
		os.write_file(expressions, json2.encode(generator.stub_expressions()))!
		stub := run_tool([...php_command, '-d', 'extension=${extension}', '-r',
			'require $argv[1]; $rules = json_decode(file_get_contents($argv[3]), true, 512, JSON_THROW_ON_ERROR); $overrides = json_decode($argv[4], true, 512, JSON_THROW_ON_ERROR); $interfaces = $overrides["methods"] + (PHP_VERSION_ID >= 80400 ? $overrides["hooks"] : []) + (PHP_VERSION_ID >= 80500 ? $overrides["properties"] : []); $expressions = json_decode(file_get_contents($argv[5]), true, 512, JSON_THROW_ON_ERROR); echo generate_stub(new ReflectionExtension($argv[2]), traitPrecedences: $rules["precedences"], traitAliases: $rules["aliases"], overrideInterfaces: $interfaces, attributeExpressions: $expressions["attributes"], parameterDefaults: $expressions["parameter_defaults"]);',
			renderer, name, adaptations, json2.encode(overrides), expressions])!
		file := os.join_path(scratch, '${name}.php')
		os.write_file(file, if declarations == '' {
			stub
		} else {
			stub.trim_space() +
				'\n\n' + declarations + '\n'
		})!
		run_tool([php, '-n', '-l', file])!
		publish(file, command.output, command.project)!
	} else {
		publish(extension, command.output, command.project)!
		output := if command.output != '' {
			command.output
		} else {
			os.join_path(command.project, 'build', os.file_name(extension))
		}
		if declarations != '' {
			publish(classes_file, '${output}.classes.php', command.project)!
		} else {
			compiler.remove_stale_userland_classes('${output}.classes.php')!
		}
	}
}

fn valid_extension_name(name string) bool {
	return name.len > 0 && !name[0].is_digit()
		&& name.bytes().all(it.is_alnum() || it == `_`)
}

fn is_extension_source(entry string) bool {
	return entry.ends_with('.v') && !entry.ends_with('_test.v')
		&& entry !in ['build.v', 'mod.v', 'vphp_bridge.v'] && !entry.starts_with('.')
}

fn stage_sources(source string, target string, mut sources []string) ! {
	for entry in os.ls(source)! {
		if entry.starts_with('.') || entry in ['build', 'vendor', 'node_modules', 'tests',
			'vphp_bridge.v', 'php_bridge.c', 'php_bridge.h'] || entry.ends_with('_generated.c')
			|| entry.ends_with('_generated.c.flags') || entry.ends_with('_generated.c.objects') {
			continue
		}
		from := os.join_path(source, entry)
		to := os.join_path(target, entry)
		if os.is_link(from) {
			if os.is_dir(from) || entry.ends_with('.v') {
				return error('symlinked source entries are unsupported: ${from}')
			}
			continue
		}
		if os.is_dir(from) {
			os.mkdir(to)!
			stage_sources(from, to, mut sources)!
		} else if os.is_file(from) {
			os.cp(from, to)!
			if is_extension_source(entry) {
				sources << to
			}
		}
	}
}

fn publish(source string, requested string, project string) ! {
	output := if requested != '' {
		requested
	} else {
		os.join_path(project, 'build', os.file_name(source))
	}
	os.mkdir_all(os.dir(output))!
	pending := os.join_path(os.dir(output), '.vphp-${rand.uuid_v4()}')
	defer {
		os.rm(pending) or {}
	}
	os.cp(source, pending)!
	os.rename(pending, output)!
	println(output)
}

fn rebase_diagnostic(message string, staged string, project string) string {
	mut lines := message.replace(staged + os.path_separator, project + os.path_separator).split('\n')
	for mut line in lines {
		separator := line.index(':') or { continue }
		path := line[..separator]
		if path.ends_with('.v') && !os.is_abs_path(path)
			&& os.is_file(os.join_path(project, path)) {
			line = os.join_path(project, path) + line[separator..]
		}
	}
	return lines.join('\n')
}
