module main

import os
import rand
import vphp.compiler

const usage = 'Usage: vphp <build|check|stub> [project-directory] [--output <file>]'

struct Command {
	action  string
	project string
	output  string
}

fn main() {
	if os.args.len == 1 || os.args[1] in ['-h', '--help', 'help'] {
		println(usage)
		return
	}
	run(parse_command(os.args[1..]) or {
		eprintln('vphp: ${err}\n${usage}')
		exit(2)
	}) or {
		eprintln('vphp: ${err}')
		exit(1)
	}
}

fn parse_command(args []string) !Command {
	action := args[0]
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
	return Command{action, project, output}
}

fn run(command Command) ! {
	if os.user_os() !in ['macos', 'linux'] {
		return error('the standalone builder currently targets macOS and Linux')
	}
	entries := os.ls(command.project)!
	if !entries.any(is_extension_source(it) && os.is_file(os.join_path(command.project, it))) {
		return error('expected a V source file at the project root')
	}
	repo := os.dir(os.dir(os.dir(os.real_path(@FILE))))
	runtime := os.join_path(repo, 'vphp')
	scratch_parent := os.real_path(os.getenv_opt('VPHP_CLI_SCRATCH') or { os.temp_dir() })
	scratch := os.join_path(scratch_parent, 'vphp-${rand.uuid_v4()}')
	os.mkdir(scratch)!
	defer {
		os.rmdir_all(scratch) or {}
	}
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

	extension := build_extension(name, staged, runtime, repo) or {
		return error(rebase_diagnostic(err.msg(), staged, command.project))
	}
	if command.action == 'check' {
		println('Checked ${name}')
		return
	}
	if command.action == 'stub' {
		renderer := os.join_path(runtime, 'stub', 'render.php')
		php := os.getenv_opt('VPHP_PHP') or { 'php' }
		stub := run_tool([php, '-n', '-d', 'extension=${extension}', '-r',
			'require $argv[1]; echo generate_stub(new ReflectionExtension($argv[2]));', renderer,
			name])!
		file := os.join_path(scratch, '${name}.php')
		os.write_file(file, stub)!
		run_tool([php, '-n', '-l', file])!
		publish(file, command.output, command.project)!
	} else {
		publish(extension, command.output, command.project)!
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
