module clix

import os
import strconv
import vphp

pub enum CliInputValueType {
	string_
	bool_
	int_
	float_
}

pub struct CliCommandArgumentSpec {
pub:
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

pub struct CliCommandOptionSpec {
pub:
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

pub struct CliCommandDefinition {
pub mut:
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

pub struct CliCommandInput {
pub:
	positional_args []string
	arguments       map[string]vphp.DynValue
	options         map[string]vphp.DynValue
	option_seen     map[string]bool
	warnings        []string
	raw_args        []string
	parsed          bool
}

pub fn clone_string_slice(items []string) []string {
	mut out := []string{cap: items.len}
	for item in items {
		out << item.clone()
	}
	return out
}

struct CliSpec {
	value vphp.PhpArray
}

fn cli_spec(value vphp.PhpArray) CliSpec {
	return CliSpec{
		value: value
	}
}

fn iterable_array(raw vphp.PhpValue) !vphp.PhpArray {
	iter := raw.as_iterable() or { return error('value must be iterable') }
	return iter.to_array()!
}

fn (subject CliSpec) lookup(keys []string) ?vphp.PhpValue {
	for key in keys {
		value := subject.value.value_at(key)
		if value.is_valid() && !value.is_null() && !value.is_undef() {
			return value
		}
	}
	return none
}

fn (subject CliSpec) string(keys []string) ?string {
	value := subject.lookup(keys) or { return none }
	clean := value.to_string().trim_space()
	if clean == '' {
		return none
	}
	return clean
}

fn cli_definition_string_item(item vphp.PhpValue) ?string {
	if !item.is_valid() || item.is_null() || item.is_undef() || !item.is_string() {
		return none
	}
	name := item.to_string().trim_space()
	if name == '' {
		return none
	}
	return name
}

fn (subject CliSpec) cli_bool(keys []string, fallback bool) bool {
	value := subject.lookup(keys) or { return fallback }
	return cli_bool_value(value, fallback)
}

pub fn cli_bool_value(value vphp.PhpValue, fallback bool) bool {
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

pub fn cli_string_list_value(value vphp.PhpValue) ![]string {
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

fn (subject CliSpec) cli_value_type(keys []string, fallback CliInputValueType) !CliInputValueType {
	raw := subject.string(keys) or { return fallback }
	return match raw.to_lower() {
		'', 'string', 'str' { .string_ }
		'bool', 'boolean', 'flag' { .bool_ }
		'int', 'integer' { .int_ }
		'float', 'double', 'number' { .float_ }
		else { error('unsupported CLI value type "${raw}"') }
	}
}

fn (subject CliSpec) cli_choices(keys []string) ![]string {
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

fn (subject CliSpec) cli_string_list(keys []string) ![]string {
	if raw := subject.lookup(keys) {
		return cli_string_list_value(raw)!
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

fn (subject CliSpec) cli_string(keys []string) string {
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

fn parse_cli_argument_spec_value(item vphp.PhpValue) !CliCommandArgumentSpec {
	if name := cli_definition_string_item(item) {
		return CliCommandArgumentSpec{
			name: name
		}
	}
	iter := item.as_iterable() or { return error('CLI argument definition must be iterable') }
	mut spec_arr := iter.to_array()!
	defer {
		spec_arr.release()
	}
	name := cli_spec(spec_arr).string(['name', 'arg', 'argument']) or {
		return error('CLI argument definition must include a non-empty name')
	}
	multiple := cli_spec(spec_arr).cli_bool(['multiple', 'variadic', 'array'], false)
	default_values := if default_value := cli_spec(spec_arr).lookup(['default']) {
		cli_default_strings(default_value, multiple)!
	} else {
		[]string{}
	}
	has_default := default_values.len > 0
	required_default := !multiple && !has_default
	value_type := cli_spec(spec_arr).cli_value_type(['type'], .string_)!
	return CliCommandArgumentSpec{
		name:           name
		value_type:     value_type
		required:       cli_spec(spec_arr).cli_bool(['required'], required_default)
		multiple:       multiple
		env_name:       cli_spec(spec_arr).cli_string(['env', 'env_name', 'envName'])
		placeholder:    cli_spec(spec_arr).cli_string(['placeholder', 'value_placeholder',
			'valuePlaceholder'])
		value_hint:     cli_spec(spec_arr).cli_string(['value_hint', 'valueHint', 'hint'])
		description:    cli_spec(spec_arr).string(['description', 'help']) or { '' }
		choices:        cli_spec(spec_arr).cli_choices(['choices', 'enum', 'values'])!
		has_default:    has_default
		default_values: default_values
	}
}

fn parse_cli_option_spec_value(item vphp.PhpValue) !CliCommandOptionSpec {
	if name := cli_definition_string_item(item) {
		return CliCommandOptionSpec{
			name: name
		}
	}
	iter := item.as_iterable() or { return error('CLI option definition must be iterable') }
	mut spec_arr := iter.to_array()!
	defer {
		spec_arr.release()
	}
	name := cli_spec(spec_arr).string(['name', 'option', 'flag']) or {
		return error('CLI option definition must include a non-empty name')
	}
	short := cli_spec(spec_arr).string(['short', 'abbrev']) or { '' }
	if short.len > 1 {
		return error('CLI option "${name}" short name must be a single character')
	}
	value_type := cli_spec(spec_arr).cli_value_type(['type'], .bool_)!
	multiple := cli_spec(spec_arr).cli_bool(['multiple', 'array'], false)
	if multiple && value_type == .bool_ {
		return error('CLI option "${name}" cannot be both bool and multiple')
	}
	default_values := if default_value := cli_spec(spec_arr).lookup(['default']) {
		cli_default_strings(default_value, multiple)!
	} else {
		[]string{}
	}
	has_default := default_values.len > 0
	deprecated := cli_spec(spec_arr).cli_bool(['deprecated'], false)
	deprecation := cli_spec(spec_arr).string(['deprecation_message', 'deprecationMessage',
		'deprecated_message', 'deprecatedMessage']) or { '' }
	return CliCommandOptionSpec{
		name:           name
		short:          short
		value_type:     value_type
		required:       cli_spec(spec_arr).cli_bool(['required'], false)
		multiple:       multiple
		hidden:         cli_spec(spec_arr).cli_bool(['hidden'], false)
		deprecated:     deprecated
		deprecation:    deprecation
		env_name:       cli_spec(spec_arr).cli_string(['env', 'env_name', 'envName'])
		placeholder:    cli_spec(spec_arr).cli_string(['placeholder', 'value_placeholder',
			'valuePlaceholder'])
		value_hint:     cli_spec(spec_arr).cli_string(['value_hint', 'valueHint', 'hint'])
		description:    cli_spec(spec_arr).string(['description', 'help']) or { '' }
		choices:        cli_spec(spec_arr).cli_choices(['choices', 'enum', 'values'])!
		has_default:    has_default
		default_values: default_values
	}
}

pub fn parse_command_definition_value(raw vphp.PhpValue) !CliCommandDefinition {
	mut spec_arr := iterable_array(raw)!
	defer {
		spec_arr.release()
	}
	mut def := CliCommandDefinition{
		usage:        cli_spec(spec_arr).string(['usage']) or { '' }
		description:  cli_spec(spec_arr).string(['description', 'summary', 'help']) or { '' }
		aliases:      cli_spec(spec_arr).cli_string_list(['aliases', 'alias']) or { []string{} }
		hidden:       cli_spec(spec_arr).cli_bool(['hidden'], false)
		examples:     cli_spec(spec_arr).cli_string_list(['examples', 'example']) or { []string{} }
		epilog:       cli_spec(spec_arr).string(['epilog', 'footer']) or { '' }
		arguments:    []CliCommandArgumentSpec{}
		options:      []CliCommandOptionSpec{}
		option_index: map[string]int{}
		short_index:  map[string]int{}
	}
	if raw_args := cli_spec(spec_arr).lookup(['arguments', 'args']) {
		iter := raw_args.as_iterable() or {
			return error('CLI arguments definition must be iterable')
		}
		mut normalized := iter.to_array()!
		defer {
			normalized.release()
		}
		for idx := 0; idx < normalized.count(); idx++ {
			arg_spec := parse_cli_argument_spec_value(normalized.index_value(idx))!
			if arg_spec.name in def.option_index {
				return error('CLI argument "${arg_spec.name}" conflicts with an option name')
			}
			if def.arguments.len > 0 && def.arguments[def.arguments.len - 1].multiple {
				return error('CLI variadic argument must be the last declared argument')
			}
			def.arguments << arg_spec
		}
	}
	if raw_options := cli_spec(spec_arr).lookup(['options', 'flags']) {
		iter := raw_options.as_iterable() or {
			return error('CLI options definition must be iterable')
		}
		mut normalized := iter.to_array()!
		defer {
			normalized.release()
		}
		for idx := 0; idx < normalized.count(); idx++ {
			opt_spec := parse_cli_option_spec_value(normalized.index_value(idx))!
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

pub fn (def CliCommandDefinition) find_option(name string) ?CliCommandOptionSpec {
	index := def.option_index[name] or { return none }
	return def.options[index]
}

pub fn (def CliCommandDefinition) find_short_option(short string) ?CliCommandOptionSpec {
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

pub fn command_definition(runtime vphp.PhpValue) !CliCommandDefinition {
	if !runtime.is_valid() || !runtime.is_object() || !runtime.method_exists('definition') {
		return error('command has no CLI definition')
	}
	mut definition_z := runtime.call_method('definition')
	defer {
		definition_z.release()
	}
	return parse_command_definition_value(definition_z)!
}

pub fn runtime_text_method(runtime vphp.PhpValue, method_name string) string {
	if !runtime.is_valid() || !runtime.is_object() || !runtime.method_exists(method_name) {
		return ''
	}
	mut value_z := runtime.call_method(method_name)
	defer {
		value_z.release()
	}
	return value_z.to_string().trim_space()
}

pub fn runtime_string_list_method(runtime vphp.PhpValue, method_name string) []string {
	if !runtime.is_valid() || !runtime.is_object() || !runtime.method_exists(method_name) {
		return []string{}
	}
	mut value_z := runtime.call_method(method_name)
	defer {
		value_z.release()
	}
	return cli_string_list_value(value_z) or { []string{} }
}

pub fn runtime_bool_method(runtime vphp.PhpValue, method_name string, fallback bool) bool {
	if !runtime.is_valid() || !runtime.is_object() || !runtime.method_exists(method_name) {
		return fallback
	}
	mut value_z := runtime.call_method(method_name)
	defer {
		value_z.release()
	}
	return cli_bool_value(value_z, fallback)
}

pub fn unparsed_input(raw_args []string) CliCommandInput {
	return CliCommandInput{
		positional_args: clone_string_slice(raw_args)
		arguments:       map[string]vphp.DynValue{}
		options:         map[string]vphp.DynValue{}
		option_seen:     map[string]bool{}
		warnings:        []string{}
		raw_args:        clone_string_slice(raw_args)
		parsed:          false
	}
}
