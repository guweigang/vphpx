module clix

import vphp

fn cli_note_option_warning(mut warnings []string, spec CliCommandOptionSpec) {
	if !spec.deprecated {
		return
	}
	warning := spec.deprecation_warning()
	if warning == '' || warning in warnings {
		return
	}
	warnings << warning
}

fn cli_mark_bool_option(mut raw_values map[string][]string, mut option_seen map[string]bool, spec CliCommandOptionSpec, value bool) ! {
	cli_assign_option_value(mut raw_values, mut option_seen, spec, if value {
		'true'
	} else {
		'false'
	})!
}

fn cli_parse_long_option(mut raw_values map[string][]string, mut option_seen map[string]bool, mut warnings []string, def CliCommandDefinition, args []string, idx int) !int {
	arg := args[idx]
	payload := arg[2..]
	name, attached_has_value, attached_value := if eq := payload.index('=') {
		payload[..eq], true, payload[eq + 1..]
	} else {
		payload, false, ''
	}
	spec := def.find_option(name) or { return error('unknown CLI option `--${name}`') }
	cli_note_option_warning(mut warnings, spec)
	if spec.value_type == .bool_ {
		if attached_has_value {
			value := cli_parse_bool_string(attached_value)!
			cli_mark_bool_option(mut raw_values, mut option_seen, spec, value)!
			return 1
		}
		if idx + 1 < args.len {
			next := args[idx + 1].trim_space()
			if next in ['true', 'false', '1', '0', 'yes', 'no', 'on', 'off'] {
				value := cli_parse_bool_string(next)!
				cli_mark_bool_option(mut raw_values, mut option_seen, spec, value)!
				return 2
			}
		}
		cli_mark_bool_option(mut raw_values, mut option_seen, spec, true)!
		return 1
	}
	raw_value, consumed := if attached_has_value {
		attached_value, 1
	} else {
		cli_option_value_from_next(args, idx, '--${name}')!
	}
	cli_assign_option_value(mut raw_values, mut option_seen, spec, raw_value)!
	return consumed
}

fn cli_parse_short_option(mut raw_values map[string][]string, mut option_seen map[string]bool, mut warnings []string, def CliCommandDefinition, args []string, idx int) !int {
	arg := args[idx]
	payload := arg[1..]
	if eq := payload.index('=') {
		short_name := payload[..eq]
		if short_name.len != 1 {
			return error('invalid CLI short option syntax `${arg}`')
		}
		spec := def.find_short_option(short_name) or {
			return error('unknown CLI option `-${short_name}`')
		}
		cli_note_option_warning(mut warnings, spec)
		if spec.value_type == .bool_ {
			value := cli_parse_bool_string(payload[eq + 1..])!
			cli_mark_bool_option(mut raw_values, mut option_seen, spec, value)!
			return 1
		}
		cli_assign_option_value(mut raw_values, mut option_seen, spec, payload[eq + 1..])!
		return 1
	}
	if payload.len > 1 {
		for ch in payload {
			short_name := rune(ch).str()
			spec := def.find_short_option(short_name) or {
				return error('unknown CLI option `-${short_name}`')
			}
			cli_note_option_warning(mut warnings, spec)
			if spec.value_type != .bool_ {
				return error('CLI short option `-${short_name}` requires a value and cannot be grouped')
			}
			cli_mark_bool_option(mut raw_values, mut option_seen, spec, true)!
		}
		return 1
	}
	spec := def.find_short_option(payload) or { return error('unknown CLI option `-${payload}`') }
	cli_note_option_warning(mut warnings, spec)
	if spec.value_type == .bool_ {
		if idx + 1 < args.len {
			next := args[idx + 1].trim_space()
			if next in ['true', 'false', '1', '0', 'yes', 'no', 'on', 'off'] {
				value := cli_parse_bool_string(next)!
				cli_mark_bool_option(mut raw_values, mut option_seen, spec, value)!
				return 2
			}
		}
		cli_mark_bool_option(mut raw_values, mut option_seen, spec, true)!
		return 1
	}
	raw_value, consumed := cli_option_value_from_next(args, idx, '-${payload}')!
	cli_assign_option_value(mut raw_values, mut option_seen, spec, raw_value)!
	return consumed
}

fn (def CliCommandDefinition) finalize_options(raw_values map[string][]string, option_seen map[string]bool) !map[string]vphp.DynValue {
	mut out := map[string]vphp.DynValue{}
	for spec in def.options {
		mut values := raw_values[spec.name] or { []string{} }
		if values.len == 0 {
			if env_value := cli_env_value(spec.env_name) {
				values = [env_value]
			}
		}
		if values.len == 0 {
			if spec.has_default {
				out[spec.name] = cli_value_from_defaults(spec.default_values, spec.value_type,
					spec.multiple, '--${spec.name}', spec.choices)!
				continue
			}
			if spec.required {
				return error('CLI option `--${spec.name}` is required')
			}
			if spec.multiple {
				out[spec.name] = vphp.DynValue.of_list([]vphp.DynValue{})
				continue
			}
			if spec.value_type == .bool_ {
				out[spec.name] = vphp.DynValue.of_bool(false)
				continue
			}
			out[spec.name] = vphp.DynValue.null()
			continue
		}
		out[spec.name] = cli_value_from_defaults(values, spec.value_type, spec.multiple,
			'--${spec.name}', spec.choices)!
	}
	for name, _ in option_seen {
		if name !in out {
			out[name] = vphp.DynValue.null()
		}
	}
	return out
}

fn (def CliCommandDefinition) finalize_arguments(positionals []string) !(map[string]vphp.DynValue, []string) {
	mut out := map[string]vphp.DynValue{}
	mut handle_args := []string{}
	mut idx := 0
	for spec in def.arguments {
		label := 'argument `${spec.name}`'
		if spec.multiple {
			mut values := if idx < positionals.len { positionals[idx..].clone() } else { []string{} }
			if values.len == 0 && spec.has_default {
				values = spec.default_values.clone()
			}
			if values.len == 0 {
				if spec.required {
					return error('CLI ${label} is required')
				}
				out[spec.name] = vphp.DynValue.of_list([]vphp.DynValue{})
				continue
			}
			mut parsed := []vphp.DynValue{}
			for value in values {
				parsed << cli_parse_scalar_value(value, spec.value_type, label, spec.choices)!
				handle_args << value
			}
			out[spec.name] = vphp.DynValue.of_list(parsed)
			idx = positionals.len
			continue
		}
		if idx >= positionals.len {
			if env_value := cli_env_value(spec.env_name) {
				out[spec.name] = cli_parse_scalar_value(env_value, spec.value_type, label,
					spec.choices)!
				handle_args << env_value
				continue
			}
			if spec.has_default {
				value := spec.default_values[0]
				out[spec.name] =
					cli_parse_scalar_value(value, spec.value_type, label, spec.choices)!
				handle_args << value
				continue
			}
			if spec.required {
				return error('CLI ${label} is required')
			}
			out[spec.name] = vphp.DynValue.null()
			continue
		}
		value := positionals[idx]
		idx++
		out[spec.name] = cli_parse_scalar_value(value, spec.value_type, label, spec.choices)!
		handle_args << value
	}
	if idx < positionals.len {
		return error('too many CLI arguments')
	}
	return out, handle_args
}

pub fn (def CliCommandDefinition) parse_command_input(raw_args []string) !CliCommandInput {
	mut raw_values := map[string][]string{}
	mut option_seen := map[string]bool{}
	mut warnings := []string{}
	mut positionals := []string{}
	mut idx := 0
	mut stop_options := false
	for idx < raw_args.len {
		arg := raw_args[idx]
		if !stop_options && arg == '--' {
			stop_options = true
			idx++
			continue
		}
		if !stop_options && arg.starts_with('--') && arg.len > 2 {
			idx += cli_parse_long_option(mut raw_values, mut option_seen, mut warnings, def,
				raw_args, idx)!
			continue
		}
		if !stop_options && arg.starts_with('-') && arg.len > 1 && !cli_is_negative_number_token(arg) {
			idx += cli_parse_short_option(mut raw_values, mut option_seen, mut warnings, def,
				raw_args, idx)!
			continue
		}
		positionals << arg
		idx++
	}
	arguments, handle_args := def.finalize_arguments(positionals)!
	options := def.finalize_options(raw_values, option_seen)!
	return CliCommandInput{
		positional_args: handle_args
		arguments:       arguments
		options:         options
		option_seen:     option_seen
		warnings:        warnings
		raw_args:        raw_args.clone()
		parsed:          true
	}
}
