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

fn (mut cli VSlimCliApp) reset_command_input() {
	cli.last_command_name = ''
	cli.last_raw_args = []string{}
	cli.last_arguments = map[string]vphp.DynValue{}
	cli.last_options = map[string]vphp.DynValue{}
	cli.last_option_seen = map[string]bool{}
	cli.last_warnings = []string{}
	cli.last_input_parsed = false
}

fn (mut cli VSlimCliApp) set_command_input(command_name string, input CliCommandInput) {
	cli.last_command_name = command_name
	cli.last_raw_args = clone_cli_string_slice(input.raw_args)
	cli.last_arguments = input.arguments.clone()
	cli.last_options = input.options.clone()
	cli.last_option_seen = input.option_seen.clone()
	cli.last_warnings = clone_cli_string_slice(input.warnings)
	cli.last_input_parsed = input.parsed
}

fn (subject PhpValueSubject) cli_definition_string_item() ?string {
	item := subject.value
	if !item.is_valid() || item.is_null() || item.is_undef() || !item.is_string() {
		return none
	}
	name := item.to_string().trim_space()
	if name == '' {
		return none
	}
	return name
}

fn (subject AppBootstrapSpec) cli_bool(keys []string, fallback bool) bool {
	value := subject.lookup(keys) or { return fallback }
	return value_subject(value).cli_bool(fallback)
}

fn (subject PhpValueSubject) cli_bool(fallback bool) bool {
	value := subject.value
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

fn (subject PhpValueSubject) cli_string_list() ![]string {
	value := subject.value
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return []string{}
	}
	if value.is_string() {
		item := value.to_string().trim_space()
		return if item == '' { []string{} } else { [item] }
	}
	iter := value.as_iterable() or { return error('value must be iterable') }
	mut normalized := iter.to_array()!
	defer {
		normalized.release()
	}
	mut out := []string{}
	mut seen := map[string]bool{}
	for idx := 0; idx < normalized.count(); idx++ {
		item := normalized.index_value(idx).to_string().trim_space()
		if item == '' || item in seen {
			continue
		}
		seen[item] = true
		out << item
	}
	return out
}

fn (subject AppBootstrapSpec) cli_value_type(keys []string, fallback CliInputValueType) !CliInputValueType {
	raw := subject.string(keys) or { return fallback }
	return match raw.to_lower() {
		'', 'string', 'str' { .string_ }
		'bool', 'boolean', 'flag' { .bool_ }
		'int', 'integer' { .int_ }
		'float', 'double', 'number' { .float_ }
		else { error('unsupported CLI value type "${raw}"') }
	}
}

fn (subject AppBootstrapSpec) cli_choices(keys []string) ![]string {
	if raw_choices := subject.lookup(keys) {
		iter := raw_choices.as_iterable() or { return error('CLI choices must be iterable') }
		mut normalized := iter.to_array()!
		defer {
			normalized.release()
		}
		mut out := []string{}
		for idx := 0; idx < normalized.count(); idx++ {
			choice := normalized.index_value(idx).to_string().trim_space()
			if choice != '' {
				out << choice
			}
		}
		return out
	}
	return []string{}
}

fn (subject AppBootstrapSpec) cli_string_list(keys []string) ![]string {
	if raw := subject.lookup(keys) {
		return value_subject(raw).cli_string_list()!
	}
	return []string{}
}

fn cli_default_strings(value vphp.PhpValue, multiple bool) ![]string {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return []string{}
	}
	if value.is_bool() {
		bool_value := if value.to_bool() { 'true' } else { 'false' }
		return [bool_value]
	}
	if value.is_array() {
		arr := value.as_array() or { return []string{} }
		mut normalized := arr.borrow()
		defer {
			normalized.release()
		}
		mut out := []string{}
		for idx := 0; idx < normalized.count(); idx++ {
			out << normalized.index_value(idx).to_string()
		}
		return out
	}
	if multiple {
		return [value.to_string()]
	}
	return [value.to_string()]
}

fn (subject AppBootstrapSpec) cli_string(keys []string) string {
	return subject.string(keys) or { '' }
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

fn (subject PhpValueSubject) parse_cli_argument_spec() !CliCommandArgumentSpec {
	item := subject.value
	if name := subject.cli_definition_string_item() {
		return CliCommandArgumentSpec{
			name: name
		}
	}
	iter := item.as_iterable() or { return error('CLI argument definition must be iterable') }
	mut spec_arr := iter.to_array()!
	defer {
		spec_arr.release()
	}
	name := app_bootstrap_spec(spec_arr).string(['name', 'arg', 'argument']) or {
		return error('CLI argument definition must include a non-empty name')
	}
	multiple := app_bootstrap_spec(spec_arr).cli_bool(['multiple', 'variadic', 'array'], false)
	default_values := if default_value := app_bootstrap_spec(spec_arr).lookup(['default']) {
		cli_default_strings(default_value, multiple)!
	} else {
		[]string{}
	}
	has_default := default_values.len > 0
	required_default := !multiple && !has_default
	value_type := app_bootstrap_spec(spec_arr).cli_value_type(['type'], .string_)!
	return CliCommandArgumentSpec{
		name:           name
		value_type:     value_type
		required:       app_bootstrap_spec(spec_arr).cli_bool(['required'], required_default)
		multiple:       multiple
		env_name:       app_bootstrap_spec(spec_arr).cli_string(['env', 'env_name', 'envName'])
		placeholder:    app_bootstrap_spec(spec_arr).cli_string(['placeholder', 'value_placeholder',
			'valuePlaceholder'])
		value_hint:     app_bootstrap_spec(spec_arr).cli_string(['value_hint', 'valueHint', 'hint'])
		description:    app_bootstrap_spec(spec_arr).string(['description', 'help']) or { '' }
		choices:        app_bootstrap_spec(spec_arr).cli_choices(['choices', 'enum', 'values'])!
		has_default:    has_default
		default_values: default_values
	}
}

fn (subject PhpValueSubject) parse_cli_option_spec() !CliCommandOptionSpec {
	item := subject.value
	if name := subject.cli_definition_string_item() {
		return CliCommandOptionSpec{
			name: name
		}
	}
	iter := item.as_iterable() or { return error('CLI option definition must be iterable') }
	mut spec_arr := iter.to_array()!
	defer {
		spec_arr.release()
	}
	name := app_bootstrap_spec(spec_arr).string(['name', 'option', 'flag']) or {
		return error('CLI option definition must include a non-empty name')
	}
	short := app_bootstrap_spec(spec_arr).string(['short', 'abbrev']) or { '' }
	if short.len > 1 {
		return error('CLI option "${name}" short name must be a single character')
	}
	value_type := app_bootstrap_spec(spec_arr).cli_value_type(['type'], .bool_)!
	multiple := app_bootstrap_spec(spec_arr).cli_bool(['multiple', 'array'], false)
	if multiple && value_type == .bool_ {
		return error('CLI option "${name}" cannot be both bool and multiple')
	}
	default_values := if default_value := app_bootstrap_spec(spec_arr).lookup(['default']) {
		cli_default_strings(default_value, multiple)!
	} else {
		[]string{}
	}
	has_default := default_values.len > 0
	deprecated := app_bootstrap_spec(spec_arr).cli_bool(['deprecated'], false)
	deprecation := app_bootstrap_spec(spec_arr).string(['deprecation_message', 'deprecationMessage',
		'deprecated_message', 'deprecatedMessage']) or { '' }
	return CliCommandOptionSpec{
		name:           name
		short:          short
		value_type:     value_type
		required:       app_bootstrap_spec(spec_arr).cli_bool(['required'], false)
		multiple:       multiple
		hidden:         app_bootstrap_spec(spec_arr).cli_bool(['hidden'], false)
		deprecated:     deprecated
		deprecation:    deprecation
		env_name:       app_bootstrap_spec(spec_arr).cli_string(['env', 'env_name', 'envName'])
		placeholder:    app_bootstrap_spec(spec_arr).cli_string(['placeholder', 'value_placeholder',
			'valuePlaceholder'])
		value_hint:     app_bootstrap_spec(spec_arr).cli_string(['value_hint', 'valueHint', 'hint'])
		description:    app_bootstrap_spec(spec_arr).string(['description', 'help']) or { '' }
		choices:        app_bootstrap_spec(spec_arr).cli_choices(['choices', 'enum', 'values'])!
		has_default:    has_default
		default_values: default_values
	}
}

fn (subject PhpValueSubject) parse_cli_command_definition() !CliCommandDefinition {
	raw := subject.value
	mut spec_arr := iterable_array(raw)!
	defer {
		spec_arr.release()
	}
	mut def := CliCommandDefinition{
		usage:        app_bootstrap_spec(spec_arr).string(['usage']) or { '' }
		description:  app_bootstrap_spec(spec_arr).string(['description', 'summary', 'help']) or { '' }
		aliases:      app_bootstrap_spec(spec_arr).cli_string_list(['aliases', 'alias']) or { []string{} }
		hidden:       app_bootstrap_spec(spec_arr).cli_bool(['hidden'], false)
		examples:     app_bootstrap_spec(spec_arr).cli_string_list(['examples', 'example']) or {
			[]string{}
		}
		epilog:       app_bootstrap_spec(spec_arr).string(['epilog', 'footer']) or { '' }
		arguments:    []CliCommandArgumentSpec{}
		options:      []CliCommandOptionSpec{}
		option_index: map[string]int{}
		short_index:  map[string]int{}
	}
	if raw_args := app_bootstrap_spec(spec_arr).lookup(['arguments', 'args']) {
		iter := raw_args.as_iterable() or {
			return error('CLI arguments definition must be iterable')
		}
		mut normalized := iter.to_array()!
		defer {
			normalized.release()
		}
		for idx := 0; idx < normalized.count(); idx++ {
			arg_spec := value_subject(normalized.index_value(idx)).parse_cli_argument_spec()!
			if arg_spec.name in def.option_index {
				return error('CLI argument "${arg_spec.name}" conflicts with an option name')
			}
			if def.arguments.len > 0 && def.arguments[def.arguments.len - 1].multiple {
				return error('CLI variadic argument must be the last declared argument')
			}
			def.arguments << arg_spec
		}
	}
	if raw_options := app_bootstrap_spec(spec_arr).lookup(['options', 'flags']) {
		iter := raw_options.as_iterable() or {
			return error('CLI options definition must be iterable')
		}
		mut normalized := iter.to_array()!
		defer {
			normalized.release()
		}
		for idx := 0; idx < normalized.count(); idx++ {
			opt_spec := value_subject(normalized.index_value(idx)).parse_cli_option_spec()!
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

fn (def CliCommandDefinition) find_option(name string) ?CliCommandOptionSpec {
	index := def.option_index[name] or { return none }
	return def.options[index]
}

fn (def CliCommandDefinition) find_short_option(short string) ?CliCommandOptionSpec {
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
			vphp.DynValue.of_string(raw)
		}
		.bool_ {
			vphp.DynValue.of_bool(cli_parse_bool_string(raw)!)
		}
		.int_ {
			vphp.DynValue.of_int(strconv.atoi64(raw.trim_space()) or {
				return error('${cli_label_message(label)} expects an integer value')
			})
		}
		.float_ {
			vphp.DynValue.of_float(strconv.atof64(raw.trim_space(), strconv.AtoF64Param{}) or {
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
		return vphp.DynValue.of_list(out)
	}
	if values.len == 0 {
		return vphp.DynValue.null()
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

fn (spec CliCommandOptionSpec) deprecation_warning() string {
	if spec.deprecation.trim_space() != '' {
		return spec.deprecation.trim_space()
	}
	return 'CLI option `--${spec.name}` is deprecated'
}

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
	spec := def.find_short_option(payload) or {
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

fn (def CliCommandDefinition) parse_command_input(raw_args []string) !CliCommandInput {
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
		if !stop_options && arg.starts_with('-') && arg.len > 1
			&& !cli_is_negative_number_token(arg) {
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

fn cli_command_definition(runtime vphp.PhpValue) !CliCommandDefinition {
	if !runtime.is_valid() || !runtime.is_object() || !runtime.method_exists('definition') {
		return error('command has no CLI definition')
	}
	mut definition_z := runtime.call_method('definition')
	defer {
		definition_z.release()
	}
	return value_subject(definition_z).parse_cli_command_definition()!
}

fn cli_runtime_text_method(runtime vphp.PhpValue, method_name string) string {
	if !runtime.is_valid() || !runtime.is_object() || !runtime.method_exists(method_name) {
		return ''
	}
	mut value_z := runtime.call_method(method_name)
	defer {
		value_z.release()
	}
	return value_z.to_string().trim_space()
}

fn cli_runtime_string_list_method(runtime vphp.PhpValue, method_name string) []string {
	if !runtime.is_valid() || !runtime.is_object() || !runtime.method_exists(method_name) {
		return []string{}
	}
	mut value_z := runtime.call_method(method_name)
	defer {
		value_z.release()
	}
	return value_subject(value_z).cli_string_list() or { []string{} }
}

fn cli_runtime_bool_method(runtime vphp.PhpValue, method_name string, fallback bool) bool {
	if !runtime.is_valid() || !runtime.is_object() || !runtime.method_exists(method_name) {
		return fallback
	}
	mut value_z := runtime.call_method(method_name)
	defer {
		value_z.release()
	}
	return value_subject(value_z).cli_bool(fallback)
}

fn (mut cli VSlimCliApp) bind_runtime_to_command(runtime vphp.PhpValue) {
	if !runtime.is_valid() || !runtime.is_object() {
		return
	}
	mut cli_value := cli.self_value()
	defer {
		cli_value.release()
	}
	if runtime.method_exists('setCli') {
		mut set_cli_result := runtime.call_method('setCli', cli_value)
		set_cli_result.release()
	}
	if runtime.method_exists('setApp') {
		mut app_value := cli.ensure_core_app().self_value()
		defer {
			app_value.release()
		}
		mut set_app_result := runtime.call_method('setApp', app_value)
		set_app_result.release()
	}
}

fn (mut cli VSlimCliApp) resolve_command_input(runtime vphp.PhpValue, raw_args []string) !CliCommandInput {
	cli.bind_runtime_to_command(runtime)
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
	return def.parse_command_input(raw_args)!
}

fn cli_command_input_error(runtime vphp.PhpValue, program string, command_name string, message string) !int {
	usage := cli_command_usage_text_from_runtime(runtime, program, command_name).trim_space()
	if usage == '' {
		return error(message)
	}
	return error('${message}\n${usage}')
}
