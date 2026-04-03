module main

import os
import strconv
import vphp

enum CliInputValueType {
	string_
	bool_
	int_
	float_
}

struct CliCommandArgumentSpec {
	name           string
	value_type     CliInputValueType = .string_
	required       bool              = true
	multiple       bool
	env_name       string
	placeholder    string
	value_hint     string
	description    string
	choices        []string
	has_default    bool
	default_values []string
}

struct CliCommandOptionSpec {
	name           string
	short          string
	value_type     CliInputValueType = .bool_
	required       bool
	multiple       bool
	hidden         bool
	deprecated     bool
	deprecation    string
	env_name       string
	placeholder    string
	value_hint     string
	description    string
	choices        []string
	has_default    bool
	default_values []string
}

struct CliCommandDefinition {
mut:
	usage        string
	description  string
	aliases      []string
	hidden       bool
	examples     []string
	epilog       string
	arguments    []CliCommandArgumentSpec
	options      []CliCommandOptionSpec
	option_index map[string]int
	short_index  map[string]int
}

struct CliCommandInput {
	positional_args []string
	arguments       map[string]vphp.DynValue
	options         map[string]vphp.DynValue
	option_seen     map[string]bool
	warnings        []string
	raw_args        []string
	parsed          bool
}

fn clone_cli_string_slice(items []string) []string {
	mut out := []string{cap: items.len}
	for item in items {
		out << item.clone()
	}
	return out
}

fn reset_cli_command_input(mut cli VSlimCliApp) {
	cli.last_command_name = ''
	cli.last_raw_args = []string{}
	cli.last_arguments = map[string]vphp.DynValue{}
	cli.last_options = map[string]vphp.DynValue{}
	cli.last_option_seen = map[string]bool{}
	cli.last_warnings = []string{}
	cli.last_input_parsed = false
}

fn set_cli_command_input(mut cli VSlimCliApp, command_name string, input CliCommandInput) {
	cli.last_command_name = command_name
	cli.last_raw_args = clone_cli_string_slice(input.raw_args)
	cli.last_arguments = input.arguments.clone()
	cli.last_options = input.options.clone()
	cli.last_option_seen = input.option_seen.clone()
	cli.last_warnings = clone_cli_string_slice(input.warnings)
	cli.last_input_parsed = input.parsed
}

fn cli_dyn_value_to_value(value vphp.DynValue) vphp.Value {
	return vphp.Value.adopt_request_zval(vphp.new_zval_from_dyn_value(value) or {
		vphp.ZVal.new_null()
	})
}

fn cli_definition_string_item(item vphp.ZVal) ?string {
	if !item.is_valid() || item.is_null() || item.is_undef() || !item.is_string() {
		return none
	}
	name := item.to_string().trim_space()
	if name == '' {
		return none
	}
	return name
}

fn cli_definition_bool(spec vphp.ZVal, keys []string, fallback bool) bool {
	value := app_bootstrap_lookup(spec, keys) or { return fallback }
	return cli_bool_from_value(value, fallback)
}

fn cli_bool_from_value(value vphp.ZVal, fallback bool) bool {
	if value.is_bool() {
		return value.to_bool()
	}
	if value.is_long() {
		return value.to_i64() != 0
	}
	text := value.to_string().trim_space().to_lower()
	return match text {
		'1', 'true', 'yes', 'on' { true }
		'0', 'false', 'no', 'off' { false }
		else { fallback }
	}
}

fn cli_string_list_from_value(value vphp.ZVal) ![]string {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return []string{}
	}
	if value.is_string() {
		item := value.to_string().trim_space()
		return if item == '' { []string{} } else { [item] }
	}
	normalized := psr16_iterable_to_array(value)!
	mut out := []string{}
	mut seen := map[string]bool{}
	for idx := 0; idx < normalized.array_count(); idx++ {
		item := normalized.array_get(idx).to_string().trim_space()
		if item == '' || item in seen {
			continue
		}
		seen[item] = true
		out << item
	}
	return out
}

fn cli_definition_value_type(spec vphp.ZVal, keys []string, fallback CliInputValueType) !CliInputValueType {
	raw := app_bootstrap_string(spec, keys) or { return fallback }
	return match raw.to_lower() {
		'', 'string', 'str' { .string_ }
		'bool', 'boolean', 'flag' { .bool_ }
		'int', 'integer' { .int_ }
		'float', 'double', 'number' { .float_ }
		else { error('unsupported CLI value type "${raw}"') }
	}
}

fn cli_definition_choices(spec vphp.ZVal, keys []string) ![]string {
	if raw_choices := app_bootstrap_lookup(spec, keys) {
		normalized := psr16_iterable_to_array(raw_choices)!
		mut out := []string{}
		for idx := 0; idx < normalized.array_count(); idx++ {
			choice := normalized.array_get(idx).to_string().trim_space()
			if choice != '' {
				out << choice
			}
		}
		return out
	}
	return []string{}
}

fn cli_definition_string_list(spec vphp.ZVal, keys []string) ![]string {
	if raw := app_bootstrap_lookup(spec, keys) {
		return cli_string_list_from_value(raw)!
	}
	return []string{}
}

fn cli_default_strings(value vphp.ZVal, multiple bool) ![]string {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return []string{}
	}
	if value.is_array() {
		normalized := psr16_iterable_to_array(value)!
		mut out := []string{}
		for idx := 0; idx < normalized.array_count(); idx++ {
			out << normalized.array_get(idx).to_string()
		}
		return out
	}
	if multiple {
		return [value.to_string()]
	}
	return [value.to_string()]
}

fn cli_definition_string(spec vphp.ZVal, keys []string) string {
	return app_bootstrap_string(spec, keys) or { '' }
}

fn cli_env_value(name string) ?string {
	env_name := name.trim_space()
	if env_name == '' {
		return none
	}
	raw := os.getenv(env_name)
	if raw == '' {
		return none
	}
	return raw
}

fn cli_parse_argument_spec(item vphp.ZVal) !CliCommandArgumentSpec {
	if name := cli_definition_string_item(item) {
		return CliCommandArgumentSpec{
			name: name
		}
	}
	spec := psr16_iterable_to_array(item)!
	name := app_bootstrap_string(spec, ['name', 'arg', 'argument']) or {
		return error('CLI argument definition must include a non-empty name')
	}
	multiple := cli_definition_bool(spec, ['multiple', 'variadic', 'array'], false)
	default_values := if default_value := app_bootstrap_lookup(spec, ['default']) {
		cli_default_strings(default_value, multiple)!
	} else {
		[]string{}
	}
	has_default := default_values.len > 0
	required_default := !multiple && !has_default
	value_type := cli_definition_value_type(spec, ['type'], .string_)!
	return CliCommandArgumentSpec{
		name:           name
		value_type:     value_type
		required:       cli_definition_bool(spec, ['required'], required_default)
		multiple:       multiple
		env_name:       cli_definition_string(spec, ['env', 'env_name', 'envName'])
		placeholder:    cli_definition_string(spec, ['placeholder', 'value_placeholder',
			'valuePlaceholder'])
		value_hint:     cli_definition_string(spec, ['value_hint', 'valueHint', 'hint'])
		description:    app_bootstrap_string(spec, ['description', 'help']) or { '' }
		choices:        cli_definition_choices(spec, ['choices', 'enum', 'values'])!
		has_default:    has_default
		default_values: default_values
	}
}

fn cli_parse_option_spec(item vphp.ZVal) !CliCommandOptionSpec {
	if name := cli_definition_string_item(item) {
		return CliCommandOptionSpec{
			name: name
		}
	}
	spec := psr16_iterable_to_array(item)!
	name := app_bootstrap_string(spec, ['name', 'option', 'flag']) or {
		return error('CLI option definition must include a non-empty name')
	}
	short := app_bootstrap_string(spec, ['short', 'abbrev']) or { '' }
	if short.len > 1 {
		return error('CLI option "${name}" short name must be a single character')
	}
	value_type := cli_definition_value_type(spec, ['type'], .bool_)!
	multiple := cli_definition_bool(spec, ['multiple', 'array'], false)
	if multiple && value_type == .bool_ {
		return error('CLI option "${name}" cannot be both bool and multiple')
	}
	default_values := if default_value := app_bootstrap_lookup(spec, ['default']) {
		cli_default_strings(default_value, multiple)!
	} else {
		[]string{}
	}
	has_default := default_values.len > 0
	deprecated := cli_definition_bool(spec, ['deprecated'], false)
	deprecation := app_bootstrap_string(spec, ['deprecation_message', 'deprecationMessage',
		'deprecated_message', 'deprecatedMessage']) or { '' }
	return CliCommandOptionSpec{
		name:           name
		short:          short
		value_type:     value_type
		required:       cli_definition_bool(spec, ['required'], false)
		multiple:       multiple
		hidden:         cli_definition_bool(spec, ['hidden'], false)
		deprecated:     deprecated
		deprecation:    deprecation
		env_name:       cli_definition_string(spec, ['env', 'env_name', 'envName'])
		placeholder:    cli_definition_string(spec, ['placeholder', 'value_placeholder',
			'valuePlaceholder'])
		value_hint:     cli_definition_string(spec, ['value_hint', 'valueHint', 'hint'])
		description:    app_bootstrap_string(spec, ['description', 'help']) or { '' }
		choices:        cli_definition_choices(spec, ['choices', 'enum', 'values'])!
		has_default:    has_default
		default_values: default_values
	}
}

fn cli_parse_command_definition(raw vphp.ZVal) !CliCommandDefinition {
	spec := psr16_iterable_to_array(raw)!
	mut def := CliCommandDefinition{
		usage:        app_bootstrap_string(spec, ['usage']) or { '' }
		description:  app_bootstrap_string(spec, ['description', 'summary', 'help']) or { '' }
		aliases:      cli_definition_string_list(spec, ['aliases', 'alias']) or { []string{} }
		hidden:       cli_definition_bool(spec, ['hidden'], false)
		examples:     cli_definition_string_list(spec, ['examples', 'example']) or { []string{} }
		epilog:       app_bootstrap_string(spec, ['epilog', 'footer']) or { '' }
		arguments:    []CliCommandArgumentSpec{}
		options:      []CliCommandOptionSpec{}
		option_index: map[string]int{}
		short_index:  map[string]int{}
	}
	if raw_args := app_bootstrap_lookup(spec, ['arguments', 'args']) {
		normalized := psr16_iterable_to_array(raw_args)!
		for idx := 0; idx < normalized.array_count(); idx++ {
			arg_spec := cli_parse_argument_spec(normalized.array_get(idx))!
			if arg_spec.name in def.option_index {
				return error('CLI argument "${arg_spec.name}" conflicts with an option name')
			}
			if def.arguments.len > 0 && def.arguments[def.arguments.len - 1].multiple {
				return error('CLI variadic argument must be the last declared argument')
			}
			def.arguments << arg_spec
		}
	}
	if raw_options := app_bootstrap_lookup(spec, ['options', 'flags']) {
		normalized := psr16_iterable_to_array(raw_options)!
		for idx := 0; idx < normalized.array_count(); idx++ {
			opt_spec := cli_parse_option_spec(normalized.array_get(idx))!
			if opt_spec.name in def.option_index {
				return error('CLI option "${opt_spec.name}" is declared more than once')
			}
			if opt_spec.name in def.short_index {
				return error('CLI option "${opt_spec.name}" conflicts with an existing short option')
			}
			if opt_spec.short != '' && opt_spec.short in def.short_index {
				return error('CLI short option "-${opt_spec.short}" is declared more than once')
			}
			def.option_index[opt_spec.name] = def.options.len
			if opt_spec.short != '' {
				def.short_index[opt_spec.short] = def.options.len
			}
			def.options << opt_spec
		}
	}
	return def
}

fn cli_find_option(def CliCommandDefinition, name string) ?CliCommandOptionSpec {
	index := def.option_index[name] or { return none }
	return def.options[index]
}

fn cli_find_short_option(def CliCommandDefinition, short string) ?CliCommandOptionSpec {
	index := def.short_index[short] or { return none }
	return def.options[index]
}

fn cli_parse_bool_string(raw string) !bool {
	return match raw.trim_space().to_lower() {
		'1', 'true', 'yes', 'on' { true }
		'0', 'false', 'no', 'off' { false }
		else { error('invalid boolean value "${raw}"') }
	}
}

fn cli_label_message(label string) string {
	if label.starts_with('--') || label.starts_with('-') {
		return 'CLI option `${label}`'
	}
	if label.starts_with('argument `') {
		return 'CLI ${label}'
	}
	return label
}

fn cli_validate_choice(raw string, choices []string, label string) ! {
	if choices.len == 0 {
		return
	}
	if raw in choices {
		return
	}
	return error('${cli_label_message(label)} must be one of: ${choices.join(', ')}')
}

fn cli_parse_scalar_value(raw string, value_type CliInputValueType, label string, choices []string) !vphp.DynValue {
	cli_validate_choice(raw, choices, label)!
	return match value_type {
		.string_ {
			vphp.dyn_value_string(raw)
		}
		.bool_ {
			vphp.dyn_value_bool(cli_parse_bool_string(raw)!)
		}
		.int_ {
			vphp.dyn_value_int(strconv.atoi64(raw.trim_space()) or {
				return error('${cli_label_message(label)} expects an integer value')
			})
		}
		.float_ {
			vphp.dyn_value_float(strconv.atof64(raw.trim_space(), strconv.AtoF64Param{}) or {
				return error('${cli_label_message(label)} expects a float value')
			})
		}
	}
}

fn cli_value_from_defaults(values []string, value_type CliInputValueType, multiple bool, label string, choices []string) !vphp.DynValue {
	if multiple {
		mut out := []vphp.DynValue{}
		for item in values {
			out << cli_parse_scalar_value(item, value_type, label, choices)!
		}
		return vphp.dyn_value_list(out)
	}
	if values.len == 0 {
		return vphp.dyn_value_null()
	}
	return cli_parse_scalar_value(values[0], value_type, label, choices)!
}

fn cli_is_negative_number_token(token string) bool {
	if token.len < 2 || token[0] != `-` {
		return false
	}
	for idx, ch in token {
		if idx == 0 {
			continue
		}
		if ch < `0` || ch > `9` {
			return false
		}
	}
	return true
}

fn cli_option_value_from_next(args []string, idx int, label string) !(string, int) {
	if idx + 1 >= args.len {
		return error('${label} requires a value')
	}
	return args[idx + 1], 2
}

fn cli_assign_option_value(mut raw_values map[string][]string, mut option_seen map[string]bool, spec CliCommandOptionSpec, raw string) ! {
	if !spec.multiple && spec.name in raw_values {
		return error('CLI option `--${spec.name}` may only be provided once')
	}
	raw_values[spec.name] << raw
	option_seen[spec.name] = true
}

fn cli_deprecation_warning(spec CliCommandOptionSpec) string {
	if spec.deprecation.trim_space() != '' {
		return spec.deprecation.trim_space()
	}
	return 'CLI option `--${spec.name}` is deprecated'
}

fn cli_note_option_warning(mut warnings []string, spec CliCommandOptionSpec) {
	if !spec.deprecated {
		return
	}
	warning := cli_deprecation_warning(spec)
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
	spec := cli_find_option(def, name) or { return error('unknown CLI option `--${name}`') }
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
		spec := cli_find_short_option(def, short_name) or {
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
			spec := cli_find_short_option(def, short_name) or {
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
	spec := cli_find_short_option(def, payload) or {
		return error('unknown CLI option `-${payload}`')
	}
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

fn cli_finalize_options(def CliCommandDefinition, raw_values map[string][]string, option_seen map[string]bool) !map[string]vphp.DynValue {
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
				out[spec.name] = vphp.dyn_value_list([]vphp.DynValue{})
				continue
			}
			if spec.value_type == .bool_ {
				out[spec.name] = vphp.dyn_value_bool(false)
				continue
			}
			out[spec.name] = vphp.dyn_value_null()
			continue
		}
		out[spec.name] = cli_value_from_defaults(values, spec.value_type, spec.multiple,
			'--${spec.name}', spec.choices)!
	}
	for name, _ in option_seen {
		if name !in out {
			out[name] = vphp.dyn_value_null()
		}
	}
	return out
}

fn cli_finalize_arguments(def CliCommandDefinition, positionals []string) !(map[string]vphp.DynValue, []string) {
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
				out[spec.name] = vphp.dyn_value_list([]vphp.DynValue{})
				continue
			}
			mut parsed := []vphp.DynValue{}
			for value in values {
				parsed << cli_parse_scalar_value(value, spec.value_type, label, spec.choices)!
				handle_args << value
			}
			out[spec.name] = vphp.dyn_value_list(parsed)
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
				out[spec.name] = cli_parse_scalar_value(value, spec.value_type, label,
					spec.choices)!
				handle_args << value
				continue
			}
			if spec.required {
				return error('CLI ${label} is required')
			}
			out[spec.name] = vphp.dyn_value_null()
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

fn cli_parse_command_input(def CliCommandDefinition, raw_args []string) !CliCommandInput {
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
			idx += cli_parse_long_option(mut raw_values, mut option_seen, mut warnings,
				def, raw_args, idx)!
			continue
		}
		if !stop_options && arg.starts_with('-') && arg.len > 1
			&& !cli_is_negative_number_token(arg) {
			idx += cli_parse_short_option(mut raw_values, mut option_seen, mut warnings,
				def, raw_args, idx)!
			continue
		}
		positionals << arg
		idx++
	}
	arguments, handle_args := cli_finalize_arguments(def, positionals)!
	options := cli_finalize_options(def, raw_values, option_seen)!
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

fn cli_command_definition(runtime vphp.ZVal) !CliCommandDefinition {
	if !runtime.is_valid() || !runtime.is_object() || !runtime.method_exists('definition') {
		return error('command has no CLI definition')
	}
	mut definition_z := runtime.method_owned_request('definition', []vphp.ZVal{})
	defer {
		definition_z.release()
	}
	return cli_parse_command_definition(definition_z)!
}

fn cli_runtime_text_method(runtime vphp.ZVal, method_name string) string {
	if !runtime.is_valid() || !runtime.is_object() || !runtime.method_exists(method_name) {
		return ''
	}
	mut value_z := runtime.method_owned_request(method_name, []vphp.ZVal{})
	defer {
		value_z.release()
	}
	return value_z.to_string().trim_space()
}

fn cli_runtime_string_list_method(runtime vphp.ZVal, method_name string) []string {
	if !runtime.is_valid() || !runtime.is_object() || !runtime.method_exists(method_name) {
		return []string{}
	}
	mut value_z := runtime.method_owned_request(method_name, []vphp.ZVal{})
	defer {
		value_z.release()
	}
	return cli_string_list_from_value(value_z) or {
		[]string{}
	}
}

fn cli_runtime_bool_method(runtime vphp.ZVal, method_name string, fallback bool) bool {
	if !runtime.is_valid() || !runtime.is_object() || !runtime.method_exists(method_name) {
		return fallback
	}
	mut value_z := runtime.method_owned_request(method_name, []vphp.ZVal{})
	defer {
		value_z.release()
	}
	return cli_bool_from_value(value_z, fallback)
}

fn bind_cli_runtime_to_command(mut cli VSlimCliApp, runtime vphp.ZVal) {
	if !runtime.is_valid() || !runtime.is_object() {
		return
	}
	mut cli_z := cli_self_zval(&cli)
	defer {
		cli_z.release()
	}
	if runtime.method_exists('setCli') {
		mut set_cli_result := runtime.method_owned_request('setCli', [cli_z])
		set_cli_result.release()
	}
	if runtime.method_exists('setApp') {
		mut app_z := app_self_zval(ensure_cli_core_app(mut cli))
		defer {
			app_z.release()
		}
		mut set_app_result := runtime.method_owned_request('setApp', [app_z])
		set_app_result.release()
	}
}

fn resolve_cli_command_input(mut cli VSlimCliApp, runtime vphp.ZVal, raw_args []string) !CliCommandInput {
	bind_cli_runtime_to_command(mut cli, runtime)
	if !runtime.is_valid() || !runtime.is_object() || !runtime.method_exists('definition') {
		return CliCommandInput{
			positional_args: clone_cli_string_slice(raw_args)
			arguments:       map[string]vphp.DynValue{}
			options:         map[string]vphp.DynValue{}
			option_seen:     map[string]bool{}
			warnings:        []string{}
			raw_args:        clone_cli_string_slice(raw_args)
			parsed:          false
		}
	}
	def := cli_command_definition(runtime)!
	return cli_parse_command_input(def, raw_args)!
}

fn cli_command_input_error(runtime vphp.ZVal, program string, command_name string, message string) !int {
	usage := cli_command_usage_text_from_runtime(runtime, program, command_name).trim_space()
	if usage == '' {
		return error(message)
	}
	return error('${message}\n${usage}')
}
