module main

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

fn cli_clone_string_list(items []string) []string {
	if items.len == 0 {
		return []string{}
	}
	mut out := []string{cap: items.len}
	for item in items {
		out << item.clone()
	}
	return out
}

fn cli_runtime_effective_args(argv []string, cli &VSlimCliApp) CliRuntimeInvocation {
	mut inv := CliRuntimeInvocation{}
	if argv.len == 0 {
		return inv
	}
	inv.argv0 = argv[0].clone()
	if argv[0].trim_space() == '' {
		if argv.len > 1 {
			inv.command_args = cli_clone_string_list(argv[1..])
		}
		return inv
	}
	if cli_runtime_should_strip_argv0(argv[0], cli, argv) {
		if argv.len > 1 {
			inv.command_args = cli_clone_string_list(argv[1..])
		}
		return inv
	}
	inv.command_args = cli_clone_string_list(argv)
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

fn cli_runtime_parse_value_option(arg string, name string) ?string {
	prefix := '--${name}='
	if arg.starts_with(prefix) && arg.len > prefix.len {
		return arg[prefix.len..].trim_space()
	}
	return none
}

fn cli_runtime_program_name(argv0 string) string {
	clean := argv0.trim_space()
	if clean == '' {
		return 'vslim'
	}
	stem := path_file_stem(clean)
	if stem != '' {
		return stem
	}
	return clean
}

fn cli_runtime_version_text() string {
	return 'VSlim CLI runtime'
}

fn cli_help_line(label string, description string) string {
	if description.trim_space() == '' {
		return '  ${label}'
	}
	width := 28
	if label.len >= width {
		return '  ${label} ${description}'
	}
	return '  ${label}' + ' '.repeat(width - label.len) + description
}

fn cli_argument_usage_token(spec CliCommandArgumentSpec) string {
	name := if spec.placeholder.trim_space() != '' {
		spec.placeholder.trim_space()
	} else {
		spec.name.trim_space()
	}
	if name == '' {
		return ''
	}
	if spec.multiple {
		if spec.required {
			return '<${name}>...'
		}
		return '[<${name}>...]'
	}
	if spec.required {
		return '<${name}>'
	}
	return '[<${name}>]'
}

fn cli_value_placeholder(placeholder string, value_type CliInputValueType) string {
	clean := placeholder.trim_space()
	if clean != '' {
		return clean
	}
	return match value_type {
		.string_ { 'string' }
		.bool_ { 'bool' }
		.int_ { 'int' }
		.float_ { 'float' }
	}
}

fn cli_command_usage_suffix(def CliCommandDefinition) string {
	usage_override := def.usage.trim_space()
	if usage_override != '' {
		return usage_override
	}
	mut usage_tokens := []string{}
	if def.options.len > 0 {
		usage_tokens << '[options]'
	}
	for arg in def.arguments {
		token := cli_argument_usage_token(arg)
		if token != '' {
			usage_tokens << token
		}
	}
	return usage_tokens.join(' ')
}

fn cli_command_usage_text_from_definition(def CliCommandDefinition, program string, command_name string) string {
	suffix := cli_command_usage_suffix(def)
	prefix := if program.trim_space() != '' { '${program} ${command_name}' } else { command_name }
	if suffix == '' {
		return 'Usage:\n  ${prefix}\n'
	}
	return 'Usage:\n  ${prefix} ${suffix}\n'
}

fn cli_command_usage_text_from_runtime(runtime vphp.ZVal, program string, command_name string) string {
	def := cli_command_definition(runtime) or {
		prefix := if program.trim_space() != '' {
			'${program} ${command_name}'
		} else {
			command_name
		}
		return 'Usage:\n  ${prefix} [args...]\n'
	}
	return cli_command_usage_text_from_definition(def, program, command_name)
}

fn cli_option_usage_token(spec CliCommandOptionSpec) string {
	mut token := '--${spec.name}'
	if spec.value_type != .bool_ {
		token += ' <${cli_value_placeholder(spec.placeholder, spec.value_type)}>'
		if spec.multiple {
			token += '...'
		}
	}
	return token
}

fn cli_option_label(spec CliCommandOptionSpec) string {
	mut parts := []string{}
	if spec.short != '' {
		parts << '-${spec.short}'
	}
	parts << '--${spec.name}'
	if spec.value_type != .bool_ {
		mut suffix := '<${cli_value_placeholder(spec.placeholder, spec.value_type)}>'
		if spec.multiple {
			suffix += '...'
		}
		parts[parts.len - 1] += ' ${suffix}'
	}
	return parts.join(', ')
}

fn cli_option_description(spec CliCommandOptionSpec) string {
	mut desc := spec.description
	mut meta := cli_meta_suffix(spec.required, spec.multiple, spec.has_default, spec.default_values,
		spec.choices)
	if spec.env_name.trim_space() != '' {
		meta = if meta != '' {
			'${meta} [env: ${spec.env_name.trim_space()}]'
		} else {
			'[env: ${spec.env_name.trim_space()}]'
		}
	}
	if spec.value_hint.trim_space() != '' {
		meta = if meta != '' {
			'${meta} [hint: ${spec.value_hint.trim_space()}]'
		} else {
			'[hint: ${spec.value_hint.trim_space()}]'
		}
	}
	if spec.deprecated {
		deprecation := cli_deprecation_warning(spec)
		meta = if meta != '' {
			'${meta} [deprecated: ${deprecation}]'
		} else {
			'[deprecated: ${deprecation}]'
		}
	}
	if meta != '' {
		desc = if desc != '' { '${desc} ${meta}' } else { meta }
	}
	return desc
}

fn cli_argument_description(spec CliCommandArgumentSpec) string {
	mut desc := spec.description
	mut meta := cli_meta_suffix(spec.required, spec.multiple, spec.has_default, spec.default_values,
		spec.choices)
	if spec.env_name.trim_space() != '' {
		meta = if meta != '' {
			'${meta} [env: ${spec.env_name.trim_space()}]'
		} else {
			'[env: ${spec.env_name.trim_space()}]'
		}
	}
	if spec.value_hint.trim_space() != '' {
		meta = if meta != '' {
			'${meta} [hint: ${spec.value_hint.trim_space()}]'
		} else {
			'[hint: ${spec.value_hint.trim_space()}]'
		}
	}
	if meta != '' {
		desc = if desc != '' { '${desc} ${meta}' } else { meta }
	}
	return desc
}

fn cli_meta_suffix(required bool, multiple bool, has_default bool, default_values []string, choices []string) string {
	mut parts := []string{}
	if required {
		parts << 'required'
	}
	if multiple {
		parts << 'multiple'
	}
	if has_default && default_values.len > 0 {
		parts << 'default: ${default_values.join(',')}'
	}
	if choices.len > 0 {
		parts << 'choices: ${choices.join(',')}'
	}
	if parts.len == 0 {
		return ''
	}
	return '[' + parts.join('; ') + ']'
}

fn cli_append_indented_text_lines(mut lines []string, text string) {
	for raw_line in text.split_into_lines() {
		line := raw_line.trim_space()
		if line == '' {
			lines << ''
			continue
		}
		lines << '  ${line}'
	}
}

fn cli_command_examples_text_from_runtime(runtime vphp.ZVal) []string {
	def := cli_command_definition(runtime) or {
		return cli_runtime_string_list_method(runtime, 'examples')
	}
	if def.examples.len > 0 {
		return def.examples.clone()
	}
	return cli_runtime_string_list_method(runtime, 'examples')
}

fn cli_command_epilog_text_from_runtime(runtime vphp.ZVal) string {
	def := cli_command_definition(runtime) or { return cli_runtime_text_method(runtime, 'epilog') }
	if def.epilog != '' {
		return def.epilog
	}
	return cli_runtime_text_method(runtime, 'epilog')
}

fn cli_command_help_text_from_runtime(runtime vphp.ZVal, program string, command_name string) string {
	def := cli_command_definition(runtime) or {
		return cli_command_usage_text_from_runtime(runtime, program, command_name)
	}
	description := if def.description != '' {
		def.description
	} else {
		cli_runtime_text_method(runtime, 'description')
	}
	mut lines := []string{}
	lines << cli_command_usage_text_from_definition(def, program, command_name).trim_space()
	if description != '' {
		lines << ''
		lines << 'Description:'
		lines << '  ${description}'
	}
	if def.arguments.len > 0 {
		lines << ''
		lines << 'Arguments:'
		for arg in def.arguments {
			label := cli_argument_usage_token(arg)
			lines << cli_help_line(label, cli_argument_description(arg))
		}
	}
	lines << ''
	lines << 'Options:'
	for opt in def.options {
		if opt.hidden {
			continue
		}
		label := cli_option_label(opt)
		lines << cli_help_line(label, cli_option_description(opt))
	}
	lines << cli_help_line('-h, --help', 'Show this help message')
	examples := cli_command_examples_text_from_runtime(runtime)
	if examples.len > 0 {
		lines << ''
		lines << 'Examples:'
		for example in examples {
			if example.trim_space() != '' {
				lines << '  ${example.trim_space()}'
			}
		}
	}
	epilog := cli_command_epilog_text_from_runtime(runtime).trim_space()
	if epilog != '' {
		lines << ''
		lines << 'Notes:'
		cli_append_indented_text_lines(mut lines, epilog)
	}
	return lines.join('\n') + '\n'
}

fn cli_command_summary_text_from_runtime(runtime vphp.ZVal) string {
	def := cli_command_definition(runtime) or {
		return cli_runtime_text_method(runtime, 'description')
	}
	if def.description != '' {
		return def.description
	}
	return cli_runtime_text_method(runtime, 'description')
}

fn cli_command_summary_text(mut cli VSlimCliApp, command_name string) !string {
	mut handler_z := lookup_cli_command_handler(&cli, command_name)!
	defer {
		handler_z.release()
	}
	mut runtime := resolve_cli_command_runtime(mut cli, handler_z)!
	defer {
		runtime.release()
	}
	return cli_command_summary_text_from_runtime(runtime)
}

fn cli_command_help_text(mut cli VSlimCliApp, program string, command_name string) !string {
	cli_debug_log('command_help_text start command="${command_name}" program="${program}"')
	mut handler_z := lookup_cli_command_handler(&cli, command_name)!
	defer {
		handler_z.release()
	}
	mut runtime := resolve_cli_command_runtime(mut cli, handler_z)!
	defer {
		runtime.release()
	}
	cli_debug_log('command_help_text runtime_ready command="${command_name}"')
	return cli_command_help_text_from_runtime(runtime, program, command_name)
}

fn cli_command_listing_line(mut cli VSlimCliApp, command_name string) string {
	name := command_name.trim_space().clone()
	if name == '' {
		return ''
	}
	mut summary := cli_command_summary_text(mut cli, name) or { '' }
	aliases := cli_command_aliases_for_listing(&cli, name)
	if aliases.len > 0 {
		alias_text := 'aliases: ${aliases.join(',')}'
		summary = if summary != '' { '${summary} [${alias_text}]' } else { '[${alias_text}]' }
	}
	return cli_help_line(name, summary)
}

fn cli_command_group_title(command_name string) string {
	name := command_name.trim_space().clone()
	if name == '' {
		return ''
	}
	if idx := name.index(':') {
		if idx > 0 {
			return name[..idx].clone()
		}
	}
	return ''
}

fn cli_visible_command_names(cli &VSlimCliApp) []string {
	mut out := []string{}
	for name in cli.command_order {
		clean := name.trim_space().clone()
		if clean == '' || cli_hidden_command(cli, clean) {
			continue
		}
		out << clean
	}
	return out
}

fn cli_command_listing_groups(cli &VSlimCliApp) []CliCommandListingGroup {
	visible := cli_visible_command_names(cli)
	if visible.len == 0 {
		return []CliCommandListingGroup{}
	}
	mut order := []string{}
	mut grouped := map[string][]string{}
	for name in visible {
		command_name := name.trim_space().clone()
		title := cli_command_group_title(command_name)
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
			lines << cli_command_listing_line(mut cli, command_name)
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
			line := cli_command_listing_line(mut cli, command_name).trim_space().clone()
			lines << if indent { '    ${line}' } else { '  ${line}' }
		}
	}
}

fn cli_runtime_list_text(mut cli VSlimCliApp) string {
	cli_debug_log('list_text start')
	cli_debug_log('list_text order=${cli.command_order}')
	mut lines := []string{}
	groups := cli_command_listing_groups(&cli)
	cli_debug_log('list_text groups=${groups.len}')
	cli_append_command_listing_lines(mut lines, mut cli, groups, false)
	cli_debug_log('list_text lines=${lines.len}')
	return lines.join('\n') + '\n'
}

fn cli_args_request_command_help(args []string) bool {
	for arg in args {
		if arg == '--' {
			return false
		}
		if arg == '-h' || arg == '--help' {
			return true
		}
	}
	return false
}

fn cli_runtime_help_text(mut cli VSlimCliApp, program string) string {
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
	groups := cli_command_listing_groups(&cli)
	cli_append_command_listing_lines(mut lines, mut cli, groups, true)
	lines << ''
	lines << 'Notes:'
	lines << '  Runtime options are parsed before the command name and remaining args are passed through unchanged.'
	return lines.join('\n') + '\n'
}

fn cli_runtime_print_help(mut cli VSlimCliApp, program string) {
	vphp.write_output(cli_runtime_help_text(mut cli, program))
}

fn cli_runtime_write_stderr(message string) {
	text := message.trim_space()
	if text == '' {
		return
	}
	eprintln(text)
}

fn cli_runtime_parse_invocation(argv []string, cli &VSlimCliApp) !CliRuntimeInvocation {
	mut inv := cli_runtime_effective_args(argv, cli)
	mut args := cli_clone_string_list(inv.command_args)
	inv.command_args = []string{}
	mut idx := 0
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
		match arg {
			'-h', '--help' {
				inv.show_help = true
				idx++
				continue
			}
			'--list' {
				inv.show_list = true
				idx++
				continue
			}
			'-V', '--version' {
				inv.show_version = true
				idx++
				continue
			}
			'--bootstrap-dir' {
				if idx + 1 >= args.len || args[idx + 1].trim_space() == '' {
					return error('CLI option `--bootstrap-dir` requires a non-empty path')
				}
				inv.bootstrap_dir = args[idx + 1].trim_space().clone()
				idx += 2
				continue
			}
			'--bootstrap-file' {
				if idx + 1 >= args.len || args[idx + 1].trim_space() == '' {
					return error('CLI option `--bootstrap-file` requires a non-empty path')
				}
				inv.bootstrap_file = args[idx + 1].trim_space().clone()
				idx += 2
				continue
			}
			else {}
		}
		if dir_value := cli_runtime_parse_value_option(arg, 'bootstrap-dir') {
			inv.bootstrap_dir = dir_value.clone()
			idx++
			continue
		}
		if file_value := cli_runtime_parse_value_option(arg, 'bootstrap-file') {
			inv.bootstrap_file = file_value.clone()
			idx++
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
		inv.command_args = cli_clone_string_list(args[idx..])
	}
	if inv.bootstrap_dir != '' && inv.bootstrap_file != '' {
		return error('CLI options `--bootstrap-dir` and `--bootstrap-file` cannot be used together')
	}
	if inv.command_name == '' && !inv.show_help && !inv.show_list && !inv.show_version {
		return error('missing command name')
	}
	return inv
}

fn cli_runtime_apply_bootstrap(mut cli VSlimCliApp, bootstrap_file string, bootstrap_dir string) ! {
	if bootstrap_file != '' {
		cli_bootstrap_file_apply(mut cli, bootstrap_file)!
		return
	}
	if bootstrap_dir != '' {
		cli_bootstrap_dir_apply(mut cli, bootstrap_dir)!
	}
}

@[php_method: 'helpText']
pub fn (mut cli VSlimCliApp) help_text() string {
	cli_debug_log('help_text cli=${usize(&cli)} core=${usize(cli.core_app_ref)}')
	cli_debug_log('help_text order=${cli.command_order}')
	return cli_runtime_help_text(mut cli, 'vslim')
}

@[php_method: 'commandHelp']
pub fn (mut cli VSlimCliApp) command_help(command_name string) string {
	cli_debug_log('command_help cli=${usize(&cli)} core=${usize(cli.core_app_ref)} command="${command_name}"')
	return cli_command_help_text(mut cli, 'vslim', command_name) or { '' }
}

@[php_arg_type: 'argv=iterable']
@[php_method: 'runArgv']
pub fn (mut cli VSlimCliApp) run_argv(argv vphp.RequestBorrowedZBox) int {
	cli_debug_log('run_argv enter cli=${usize(&cli)} core=${usize(cli.core_app_ref)}')
	argv_list := cli_args_to_array(argv.to_zval()) or {
		vphp.throw_exception_class('InvalidArgumentException', 'argv must be iterable',
			0)
		return 1
	}
	inv := cli_runtime_parse_invocation(argv_list, &cli) or {
		cli_runtime_write_stderr(err.msg())
		return 1
	}
	argv0 := inv.argv0.clone()
	bootstrap_dir := inv.bootstrap_dir.clone()
	bootstrap_file := inv.bootstrap_file.clone()
	command_name := inv.command_name.clone()
	command_args := cli_clone_string_list(inv.command_args)
	show_help := inv.show_help
	show_list := inv.show_list
	show_version := inv.show_version
	cli_debug_log('run_argv parsed argv0="${argv0}" command="${command_name}" show_help=${show_help} show_list=${show_list} show_version=${show_version}')
	cli_runtime_apply_bootstrap(mut cli, bootstrap_file, bootstrap_dir) or {
		cli_runtime_write_stderr(err.msg())
		return 1
	}
	program := cli_runtime_program_name(argv0)
	if show_version {
		vphp.write_output_line(cli_runtime_version_text())
		if command_name == '' && !show_help && !show_list {
			return 0
		}
	}
	if show_help {
		cli_debug_log('run_argv branch=help command="${command_name}"')
		cli_debug_log('run_argv branch=help order=${cli.command_order}')
		if command_name != '' {
			vphp.write_output(cli_command_help_text(mut cli, program, command_name) or {
				cli_runtime_write_stderr(err.msg())
				return 1
			})
			return 0
		}
		cli_runtime_print_help(mut cli, program)
		return 0
	}
	if show_list {
		cli_debug_log('run_argv branch=list enter')
		cli_debug_log('run_argv branch=list order=${cli.command_order}')
		vphp.write_output(cli_runtime_list_text(mut cli))
		cli_debug_log('run_argv branch=list exit')
		return 0
	}
	if command_name == '' {
		cli_runtime_print_help(mut cli, program)
		return 1
	}
	if cli_args_request_command_help(command_args) {
		cli_debug_log('run_argv branch=command_help command="${command_name}"')
		vphp.write_output(cli_command_help_text(mut cli, program, command_name) or {
			cli_runtime_write_stderr(err.msg())
			return 1
		})
		return 0
	}
	code := run_registered_cli_command_with_program(mut cli, command_name, command_args, program) or {
		cli_runtime_write_stderr(err.msg())
		return 1
	}
	for warning in cli.warnings() {
		if warning.trim_space() != '' {
			cli_runtime_write_stderr(warning)
		}
	}
	cli_debug_log('run_argv exit cli=${usize(&cli)} code=${code}')
	return code
}
