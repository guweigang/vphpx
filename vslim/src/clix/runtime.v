module clix

import appx
import logger
import vphp

struct CliRuntimeInvocation {
mut:
	argv0          string
	bootstrap_dir  string
	bootstrap_file string
	command_name   string
	command_args   []string
	show_help      bool
	show_list      bool
	show_version   bool
}

struct CliCommandListingGroup {
	title    string
	commands []string
}

fn (cli &VSlimCliApp) runtime_invocation(argv []string) CliRuntimeInvocation {
	mut inv := CliRuntimeInvocation{}
	if argv.len == 0 {
		return inv
	}
	inv.argv0 = argv[0].clone()
	if argv[0].trim_space() == '' {
		if argv.len > 1 {
			inv.command_args = clone_string_slice(argv[1..])
		}
		return inv
	}
	if cli_runtime_should_strip_argv0(argv[0], cli, argv) {
		if argv.len > 1 {
			inv.command_args = clone_string_slice(argv[1..])
		}
		logger.cli_debug_log('effective_args exit argv0=${inv.argv0} strip=true args=${inv.command_args}')
		return inv
	}
	inv.command_args = clone_string_slice(argv)
	logger.cli_debug_log('effective_args exit argv0=${inv.argv0} strip=false args=${inv.command_args}')
	return inv
}

fn cli_runtime_should_strip_argv0(first string, cli &VSlimCliApp, argv []string) bool {
	token := first.trim_space()
	if token == '' || token.starts_with('-') {
		return false
	}
	if cli.has_command(token) {
		return false
	}
	lower := token.to_lower()
	if token.contains('/') || token.contains('\\') || lower.ends_with('.php')
		|| lower.ends_with('.phar') || lower.ends_with('.exe') {
		return true
	}
	if argv.len > 1 {
		next := argv[1].trim_space()
		if next.starts_with('-') || cli.has_command(next) {
			return true
		}
	}
	return false
}

fn (mut cli VSlimCliApp) command_summary_text(command_name string) !string {
	mut handler_z := cli.lookup_command_handler(command_name)!
	defer {
		handler_z.release()
	}
	mut runtime := cli.resolve_command_runtime(handler_z)!
	defer {
		runtime.release()
	}
	return command_summary_text_from_runtime(runtime)
}

fn (mut cli VSlimCliApp) command_help_text(program string, command_name string) !string {
	logger.cli_debug_log('command_help_text start command="${command_name}" program="${program}"')
	mut handler_z := cli.lookup_command_handler(command_name)!
	defer {
		handler_z.release()
	}
	mut runtime := cli.resolve_command_runtime(handler_z)!
	defer {
		runtime.release()
	}
	logger.cli_debug_log('command_help_text runtime_ready command="${command_name}"')
	return command_help_text_from_runtime(runtime, program, command_name)
}

fn (mut cli VSlimCliApp) command_listing_line(command_name string) string {
	name := command_name.trim_space().clone()
	if name == '' {
		logger.cli_debug_log('listing_line empty command_name raw="${command_name}"')
		return ''
	}
	mut summary := cli.command_summary_text(name) or { '' }
	aliases := cli.command_aliases_for_listing(name)
	if aliases.len > 0 {
		alias_text := 'aliases: ${aliases.join(',')}'
		summary = if summary != '' { '${summary} [${alias_text}]' } else { '[${alias_text}]' }
	}
	logger.cli_debug_log('listing_line name="${name}" summary="${summary}"')
	return help_line(name, summary)
}

fn (cli &VSlimCliApp) visible_command_names() []string {
	mut out := []string{}
	source := if cli.command_order.len > 0 {
		cli.command_order
	} else {
		mut keys := cli.command_handlers.keys()
		keys.sort()
		keys
	}
	for name in source {
		clean := name.trim_space().clone()
		if clean == '' || cli.hidden_command(clean) {
			continue
		}
		out << clean
	}
	return out
}

fn (cli &VSlimCliApp) command_listing_groups() []CliCommandListingGroup {
	visible := cli.visible_command_names()
	if visible.len == 0 {
		return []CliCommandListingGroup{}
	}
	mut order := []string{}
	mut grouped := map[string][]string{}
	for name in visible {
		command_name := name.trim_space().clone()
		title := command_group_title(command_name)
		if title !in grouped {
			order << title.clone()
			grouped[title] = []string{}
		}
		mut items := grouped[title] or { []string{} }
		items << command_name
		grouped[title] = items
	}
	mut out := []CliCommandListingGroup{}
	for title in order {
		source := grouped[title] or { []string{} }
		mut commands := []string{}
		for name in source {
			clean := name.trim_space().clone()
			if clean != '' {
				commands << clean
			}
		}
		out << CliCommandListingGroup{
			title:    title.clone()
			commands: commands
		}
	}
	return out
}

fn cli_append_command_listing_lines(mut lines []string, mut cli VSlimCliApp, groups []CliCommandListingGroup, indent bool) {
	if groups.len == 0 {
		lines << '  (none registered)'
		return
	}
	if groups.len == 1 && groups[0].title == '' {
		for name in groups[0].commands {
			command_name := name.trim_space().clone()
			if command_name == '' {
				logger.cli_debug_log('listing_inline empty command_name raw="${name}"')
				continue
			}
			mut summary := cli.command_summary_text(command_name) or { '' }
			aliases := (&cli).command_aliases_for_listing(command_name)
			if aliases.len > 0 {
				alias_text := 'aliases: ${aliases.join(',')}'
				summary = if summary != '' {
					'${summary} [${alias_text}]'
				} else {
					'[${alias_text}]'
				}
			}
			logger.cli_debug_log('listing_inline name="${command_name}" summary="${summary}"')
			mut base_line := command_name.clone()
			if summary != '' {
				width := 28
				base_line = if command_name.len >= width {
					'${command_name} ${summary}'
				} else {
					command_name + ' '.repeat(width - command_name.len) + summary
				}
			}
			lines << '  ${base_line}'
		}
		return
	}
	for idx, group in groups {
		if idx > 0 {
			lines << ''
		}
		heading := if group.title == '' { 'General:' } else { '${group.title}:' }
		lines << if indent { '  ${heading}' } else { heading }
		for name in group.commands {
			command_name := name.trim_space().clone()
			if command_name == '' {
				logger.cli_debug_log('listing_inline empty grouped command_name raw="${name}"')
				continue
			}
			mut summary := cli.command_summary_text(command_name) or { '' }
			aliases := (&cli).command_aliases_for_listing(command_name)
			if aliases.len > 0 {
				alias_text := 'aliases: ${aliases.join(',')}'
				summary = if summary != '' {
					'${summary} [${alias_text}]'
				} else {
					'[${alias_text}]'
				}
			}
			logger.cli_debug_log('listing_inline name="${command_name}" summary="${summary}"')
			mut base_line := command_name.clone()
			if summary != '' {
				width := 28
				base_line = if command_name.len >= width {
					'${command_name} ${summary}'
				} else {
					command_name + ' '.repeat(width - command_name.len) + summary
				}
			}
			lines << if indent { '    ${base_line}' } else { '  ${base_line}' }
		}
	}
}

fn (mut cli VSlimCliApp) runtime_list_text() string {
	logger.cli_debug_log('list_text start')
	logger.cli_debug_log('list_text order=${cli.command_order}')
	mut lines := []string{}
	groups := cli.command_listing_groups()
	logger.cli_debug_log('list_text groups=${groups.len}')
	cli_append_command_listing_lines(mut lines, mut cli, groups, false)
	logger.cli_debug_log('list_text lines=${lines.len}')
	return lines.join('\n') + '\n'
}

fn (mut cli VSlimCliApp) runtime_help_text(program string) string {
	mut lines := []string{}
	lines << 'Usage:'
	lines << '  ${program} [--bootstrap-dir <path> | --bootstrap-file <path>] <command> [args...]'
	lines << '  ${program} --help'
	lines << ''
	lines << 'Options:'
	lines << '  --bootstrap-dir <path>   Bootstrap shared app + CLI conventions from a project root'
	lines << '  --bootstrap-file <path>  Bootstrap from a specific app.php or cli.php file'
	lines << '  -h, --help               Show this help message'
	lines << '  --list                   List registered commands'
	lines << '  -V, --version            Show runtime banner'
	lines << ''
	lines << 'Commands:'
	groups := cli.command_listing_groups()
	cli_append_command_listing_lines(mut lines, mut cli, groups, true)
	lines << ''
	lines << 'Notes:'
	lines << '  Runtime options are parsed before the command name and remaining args are passed through unchanged.'
	return lines.join('\n') + '\n'
}

fn (mut cli VSlimCliApp) runtime_print_help(program string) {
	vphp.PhpOutput.write(cli.runtime_help_text(program))
}

fn cli_runtime_write_stderr(message string) {
	text := message.trim_space()
	if text == '' {
		return
	}
	eprintln(text)
}

fn cli_runtime_parse_invocation(argv []string, cli &VSlimCliApp) !CliRuntimeInvocation {
	mut inv := cli.runtime_invocation(argv)
	mut args := clone_string_slice(inv.command_args)
	inv.command_args = []string{}
	mut idx := 0
	logger.cli_debug_log('parse_invocation start args=${args}')
	for idx < args.len {
		arg := args[idx].trim_space()
		if arg == '' {
			idx++
			continue
		}
		if arg == '--' {
			idx++
			break
		}
		mut matched_option := false
		match arg {
			'-h', '--help' {
				inv.show_help = true
				idx++
				matched_option = true
			}
			'--list' {
				inv.show_list = true
				idx++
				matched_option = true
			}
			'-V', '--version' {
				inv.show_version = true
				idx++
				matched_option = true
			}
			'--bootstrap-dir' {
				if idx + 1 >= args.len || args[idx + 1].trim_space() == '' {
					return error('CLI option `--bootstrap-dir` requires a non-empty path')
				}
				inv.bootstrap_dir = args[idx + 1].trim_space().clone()
				idx += 2
				matched_option = true
			}
			'--bootstrap-file' {
				if idx + 1 >= args.len || args[idx + 1].trim_space() == '' {
					return error('CLI option `--bootstrap-file` requires a non-empty path')
				}
				inv.bootstrap_file = args[idx + 1].trim_space().clone()
				idx += 2
				matched_option = true
			}
			else {}
		}

		if matched_option {
			continue
		}
		if dir_value := parse_value_option(arg, 'bootstrap-dir') {
			inv.bootstrap_dir = dir_value.clone()
			idx++
			matched_option = true
		}
		if file_value := parse_value_option(arg, 'bootstrap-file') {
			inv.bootstrap_file = file_value.clone()
			idx++
			matched_option = true
		}
		if matched_option {
			continue
		}
		if arg.starts_with('-') {
			return error('unknown CLI option `${arg}`')
		}
		inv.command_name = arg.clone()
		idx++
		break
	}
	if idx < args.len {
		inv.command_args = clone_string_slice(args[idx..])
		logger.cli_debug_log('parse_invocation found command_args=${inv.command_args} from index ${idx}')
	} else {
		logger.cli_debug_log('parse_invocation no command_args found, idx=${idx} len=${args.len}')
	}
	if inv.bootstrap_dir != '' && inv.bootstrap_file != '' {
		return error('CLI options `--bootstrap-dir` and `--bootstrap-file` cannot be used together')
	}
	if inv.command_name == '' && !inv.show_help && !inv.show_list && !inv.show_version {
		return error('missing command name')
	}
	return inv
}

fn (mut cli VSlimCliApp) runtime_apply_bootstrap(bootstrap_file string, bootstrap_dir string) ! {
	if bootstrap_file != '' {
		cli.bootstrap_file_apply(bootstrap_file)!
		return
	}
	if bootstrap_dir != '' {
		cli.bootstrap_dir_apply(bootstrap_dir)!
	}
}

@[php_method: 'helpText']
pub fn (mut cli VSlimCliApp) help_text() string {
	logger.cli_debug_log('help_text cli=${usize(cli)} core=${usize(cli.core_app_ref)}')
	logger.cli_debug_log('help_text order=${cli.command_order}')
	return cli.runtime_help_text('vslim')
}

@[php_arg_name: 'command_name=commandName']
@[php_method: 'commandHelp']
pub fn (mut cli VSlimCliApp) command_help(command_name string) string {
	logger.cli_debug_log('command_help cli=${usize(cli)} core=${usize(cli.core_app_ref)} command="${command_name}"')
	return cli.command_help_text('vslim', command_name) or { '' }
}

@[php_method: 'runArgv']
pub fn (mut cli VSlimCliApp) run_argv(argv vphp.PhpIterable) int {
	logger.cli_debug_log('run_argv enter cli=${usize(cli)} core=${usize(cli.core_app_ref)}')
	argv_list := cli_args_to_array(argv) or {
		vphp.PhpException.raise_class('InvalidArgumentException', 'argv must be iterable', 0)
		return 1
	}
	inv := cli_runtime_parse_invocation(argv_list, cli) or {
		cli_runtime_write_stderr(err.msg())
		return 1
	}

	// ---- Extract invocation into heap-allocated cli fields BEFORE bootstrap ----
	// On Windows, passing `mut cli` to bootstrap functions corrupts ALL local
	// string and []string variables on the stack. We persist everything into
	// cli's heap fields and read them back after the bootstrap call.
	cli.last_command_name = inv.command_name.clone()
	cli.last_raw_args = clone_string_slice(inv.command_args)
	cli.last_show_help = inv.show_help
	cli.last_show_list = inv.show_list
	cli.last_show_version = inv.show_version
	argv0 := inv.argv0.clone()
	bootstrap_dir := inv.bootstrap_dir.clone()
	bootstrap_file := inv.bootstrap_file.clone()

	cli.runtime_apply_bootstrap(bootstrap_file, bootstrap_dir) or {
		cli_runtime_write_stderr(err.msg())
		return 1
	}

	// ---- Read back from heap fields after bootstrap ----
	mut command_name := cli.last_command_name.clone()
	mut command_args := clone_string_slice(cli.last_raw_args)
	show_help := cli.last_show_help
	show_list := cli.last_show_list
	show_version := cli.last_show_version
	program := program_name(argv0)

	if show_version {
		vphp.PhpOutput.line(version_text())
		if command_name == '' && !show_help && !show_list {
			return 0
		}
	}
	if show_help {
		logger.cli_debug_log('run_argv branch=help command="${command_name}"')
		logger.cli_debug_log('run_argv branch=help order=${cli.command_order}')
		if command_name != '' {
			vphp.PhpOutput.write(cli.command_help_text(program, command_name) or {
				cli_runtime_write_stderr(err.msg())
				return 1
			})
			return 0
		}
		cli.runtime_print_help(program)
		return 0
	}
	if show_list {
		logger.cli_debug_log('run_argv branch=list enter')
		logger.cli_debug_log('run_argv branch=list order=${cli.command_order}')
		vphp.PhpOutput.write(cli.runtime_list_text())
		logger.cli_debug_log('run_argv branch=list exit')
		return 0
	}
	if command_name == '' {
		cli.runtime_print_help(program)
		return 1
	}
	if args_request_command_help(command_args) {
		logger.cli_debug_log('run_argv branch=command_help command="${command_name}"')
		vphp.PhpOutput.write(cli.command_help_text(program, command_name) or {
			cli_runtime_write_stderr(err.msg())
			return 1
		})
		return 0
	}
	cli.last_command_name = command_name.trim_space().clone()
	code := cli.run_registered_cli_command_with_program(command_name, command_args, program) or {
		cli_runtime_write_stderr(err.msg())
		return 1
	}
	for warning in cli.warnings() {
		if warning.trim_space() != '' {
			cli_runtime_write_stderr(warning)
		}
	}
	logger.cli_debug_log('run_argv exit cli=${usize(cli)} code=${code}')
	return code
}
