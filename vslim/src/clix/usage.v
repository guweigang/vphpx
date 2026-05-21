module clix

pub fn (spec CliCommandArgumentSpec) usage_token() string {
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

pub fn (def CliCommandDefinition) usage_suffix() string {
	usage_override := def.usage.trim_space()
	if usage_override != '' {
		return usage_override
	}
	mut usage_tokens := []string{}
	if def.options.len > 0 {
		usage_tokens << '[options]'
	}
	for arg in def.arguments {
		token := arg.usage_token()
		if token != '' {
			usage_tokens << token
		}
	}
	return usage_tokens.join(' ')
}

pub fn (def CliCommandDefinition) usage_text(program string, command_name string) string {
	suffix := def.usage_suffix()
	prefix := if program.trim_space() != '' { '${program} ${command_name}' } else { command_name }
	if suffix == '' {
		return 'Usage:\n  ${prefix}\n'
	}
	return 'Usage:\n  ${prefix} ${suffix}\n'
}

pub fn (spec CliCommandOptionSpec) usage_token() string {
	mut token := '--${spec.name}'
	if spec.value_type != .bool_ {
		token += ' <${cli_value_placeholder(spec.placeholder, spec.value_type)}>'
		if spec.multiple {
			token += '...'
		}
	}
	return token
}

pub fn (spec CliCommandOptionSpec) label() string {
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

fn cli_meta_suffix(required bool, multiple bool, has_default bool, default_values []string, choices []string) string {
	mut parts := []string{}
	if required {
		parts << 'required'
	}
	if multiple {
		parts << 'multiple'
	}
	if has_default {
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

pub fn (spec CliCommandOptionSpec) description_text() string {
	mut desc := spec.description
	mut meta := cli_meta_suffix(spec.required, spec.multiple, spec.has_default,
		spec.default_values, spec.choices)
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
		deprecation := spec.deprecation_warning()
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

pub fn (spec CliCommandArgumentSpec) description_text() string {
	mut desc := spec.description
	mut meta := cli_meta_suffix(spec.required, spec.multiple, spec.has_default,
		spec.default_values, spec.choices)
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
