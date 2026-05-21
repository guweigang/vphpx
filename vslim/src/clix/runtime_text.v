module clix

import vphp

pub fn parse_value_option(arg string, name string) ?string {
	prefix := '--${name}='
	if arg.starts_with(prefix) && arg.len > prefix.len {
		return arg[prefix.len..].trim_space()
	}
	return none
}

pub fn program_name(argv0 string) string {
	clean := argv0.trim_space()
	if clean == '' {
		return 'vslim'
	}
	stem := file_stem(clean)
	if stem != '' {
		return stem
	}
	return clean
}

fn file_stem(path string) string {
	clean := path.trim_space()
	if clean == '' {
		return ''
	}
	normalized := clean.replace('\\', '/')
	mut base := normalized
	if idx := normalized.last_index('/') {
		if idx + 1 < normalized.len {
			base = normalized[idx + 1..]
		}
	}
	if base == '' || base == '.' || base == '..' {
		return ''
	}
	if idx := base.last_index('.') {
		if idx > 0 {
			return base[..idx]
		}
	}
	return base
}

pub fn version_text() string {
	return 'VSlim CLI runtime'
}

pub fn help_line(label string, description string) string {
	if description.trim_space() == '' {
		return '  ${label}'
	}
	width := 28
	if label.len >= width {
		return '  ${label} ${description}'
	}
	return '  ${label}' + ' '.repeat(width - label.len) + description
}

pub fn command_usage_text_from_runtime(runtime vphp.PhpValue, program string, command_name string) string {
	def := command_definition(runtime) or {
		prefix := if program.trim_space() != '' {
			'${program} ${command_name}'
		} else {
			command_name
		}
		return 'Usage:\n  ${prefix} [args...]\n'
	}
	return def.usage_text(program, command_name)
}

pub fn append_indented_text_lines(mut lines []string, text string) {
	for raw_line in text.split_into_lines() {
		line := raw_line.trim_space()
		if line == '' {
			lines << ''
			continue
		}
		lines << '  ${line}'
	}
}

pub fn command_examples_text_from_runtime(runtime vphp.PhpValue) []string {
	def := command_definition(runtime) or {
		return runtime_string_list_method(runtime, 'examples')
	}
	if def.examples.len > 0 {
		return def.examples.clone()
	}
	return runtime_string_list_method(runtime, 'examples')
}

pub fn command_epilog_text_from_runtime(runtime vphp.PhpValue) string {
	def := command_definition(runtime) or { return runtime_text_method(runtime, 'epilog') }
	if def.epilog != '' {
		return def.epilog
	}
	return runtime_text_method(runtime, 'epilog')
}

pub fn command_help_text_from_runtime(runtime vphp.PhpValue, program string, command_name string) string {
	def := command_definition(runtime) or {
		return command_usage_text_from_runtime(runtime, program, command_name)
	}
	description := if def.description != '' {
		def.description
	} else {
		runtime_text_method(runtime, 'description')
	}
	mut lines := []string{}
	lines << def.usage_text(program, command_name).trim_space()
	if description != '' {
		lines << ''
		lines << 'Description:'
		lines << '  ${description}'
	}
	if def.arguments.len > 0 {
		lines << ''
		lines << 'Arguments:'
		for arg in def.arguments {
			label := arg.usage_token()
			lines << help_line(label, arg.description_text())
		}
	}
	lines << ''
	lines << 'Options:'
	for opt in def.options {
		if opt.hidden {
			continue
		}
		label := opt.label()
		lines << help_line(label, opt.description_text())
	}
	lines << help_line('-h, --help', 'Show this help message')
	examples := command_examples_text_from_runtime(runtime)
	if examples.len > 0 {
		lines << ''
		lines << 'Examples:'
		for example in examples {
			if example.trim_space() != '' {
				lines << '  ${example.trim_space()}'
			}
		}
	}
	epilog := command_epilog_text_from_runtime(runtime).trim_space()
	if epilog != '' {
		lines << ''
		lines << 'Notes:'
		append_indented_text_lines(mut lines, epilog)
	}
	return lines.join('\n') + '\n'
}

pub fn command_summary_text_from_runtime(runtime vphp.PhpValue) string {
	def := command_definition(runtime) or {
		return runtime_text_method(runtime, 'description')
	}
	if def.description != '' {
		return def.description
	}
	return runtime_text_method(runtime, 'description')
}

pub fn command_group_title(command_name string) string {
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

pub fn args_request_command_help(args []string) bool {
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
