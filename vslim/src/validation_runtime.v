module main

import strconv
import vphp

@[php_method]
pub fn VSlimValidator.make(data vphp.RequestBorrowedZBox, rules vphp.RequestBorrowedZBox) &VSlimValidator {
	mut validator := &VSlimValidator{}
	validator.construct()
	validator.set_data(data)
	validator.set_rules(rules)
	return validator
}

@[php_method]
pub fn (mut validator VSlimValidator) construct() &VSlimValidator {
	validator.input_data = map[string]vphp.DynValue{}
	validator.rule_map = map[string][]string{}
	validator.error_map = map[string][]string{}
	validator.validated_data = map[string]vphp.DynValue{}
	validator.validation_ran = false
	return &validator
}

@[php_method: 'setData']
pub fn (mut validator VSlimValidator) set_data(data vphp.RequestBorrowedZBox) &VSlimValidator {
	validator.input_data = validator_extract_input(data)
	validator.validation_ran = false
	validator.error_map = map[string][]string{}
	validator.validated_data = map[string]vphp.DynValue{}
	return &validator
}

@[php_method: 'setRules']
pub fn (mut validator VSlimValidator) set_rules(rules vphp.RequestBorrowedZBox) &VSlimValidator {
	validator.rule_map = validator_extract_rules(rules)
	validator.validation_ran = false
	validator.error_map = map[string][]string{}
	validator.validated_data = map[string]vphp.DynValue{}
	return &validator
}

@[php_method]
pub fn (mut validator VSlimValidator) validate() &VSlimValidator {
	validator.error_map = map[string][]string{}
	validator.validated_data = map[string]vphp.DynValue{}
	for field, rules in validator.rule_map {
		value := validator.input_data[field] or { vphp.dyn_value_null() }
		present := field in validator.input_data
		mut field_errors := []string{}
		mut nullable := false
		for rule in rules {
			name, unused_arg := validator_split_rule(rule)
			_ = unused_arg
			if name == 'nullable' {
				nullable = true
				continue
			}
			if name == 'required' {
				if !present || validator_is_empty(value) {
					field_errors << 'The ${field} field is required.'
				}
			}
		}
		if field_errors.len > 0 {
			validator.error_map[field] = field_errors
			continue
		}
		if !present {
			continue
		}
		if nullable && validator_is_nullish(value) {
			validator.validated_data[field] = value
			continue
		}
		for rule in rules {
			name, arg := validator_split_rule(rule)
			if name in ['required', 'nullable', ''] {
				continue
			}
			if err_msg := validator_rule_error(field, value, name, arg) {
				field_errors << err_msg
			}
		}
		if field_errors.len > 0 {
			validator.error_map[field] = field_errors
			continue
		}
		validator.validated_data[field] = value
	}
	validator.validation_ran = true
	return &validator
}

@[php_method]
pub fn (mut validator VSlimValidator) passes() bool {
	validator.ensure_validated()
	return validator.error_map.len == 0
}

@[php_method]
pub fn (mut validator VSlimValidator) fails() bool {
	validator.ensure_validated()
	return validator.error_map.len > 0
}

@[php_method]
pub fn (mut validator VSlimValidator) errors() vphp.RequestOwnedZBox {
	validator.ensure_validated()
	return validator_errors_zbox(validator.error_map)
}

@[php_method]
pub fn (mut validator VSlimValidator) validated() vphp.RequestOwnedZBox {
	validator.ensure_validated()
	return validator_dyn_map_zbox(validator.validated_data)
}

@[php_method]
pub fn (mut validator VSlimValidator) data() vphp.RequestOwnedZBox {
	return validator_dyn_map_zbox(validator.input_data)
}

fn (mut validator VSlimValidator) ensure_validated() {
	if validator.validation_ran {
		return
	}
	validator.validate()
}

fn validator_extract_input(data vphp.RequestBorrowedZBox) map[string]vphp.DynValue {
	raw := data.to_zval()
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return map[string]vphp.DynValue{}
	}
	if raw.is_array() {
		return validator_map_from_zval(raw)
	}
	if raw.is_object()
		&& (raw.method_exists('getQueryParams') || raw.method_exists('getParsedBody')) {
		return validator_request_input_map(raw)
	}
	return map[string]vphp.DynValue{}
}

fn validator_request_input_map(request vphp.ZVal) map[string]vphp.DynValue {
	mut out := map[string]vphp.DynValue{}
	if request.method_exists('getQueryParams') {
		mut query := request.method_owned_request('getQueryParams', []vphp.ZVal{})
		defer {
			query.release()
		}
		out = validator_merge_input_maps(out, validator_map_from_zval(query))
	}
	if request.method_exists('getParsedBody') {
		mut parsed := request.method_owned_request('getParsedBody', []vphp.ZVal{})
		defer {
			parsed.release()
		}
		out = validator_merge_input_maps(out, validator_map_from_zval(parsed))
	}
	return out
}

fn validator_merge_input_maps(left map[string]vphp.DynValue, right map[string]vphp.DynValue) map[string]vphp.DynValue {
	mut out := left.clone()
	for key, value in right {
		out[key] = value
	}
	return out
}

fn validator_map_from_zval(raw vphp.ZVal) map[string]vphp.DynValue {
	if !raw.is_valid() || raw.is_null() || raw.is_undef() || !raw.is_array() {
		return map[string]vphp.DynValue{}
	}
	decoded := vphp.DynValue.from_zval(raw) or { return map[string]vphp.DynValue{} }
	return validator_map_from_dyn(decoded)
}

fn validator_map_from_dyn(value vphp.DynValue) map[string]vphp.DynValue {
	if value.type == .map_ {
		return value.map.clone()
	}
	return map[string]vphp.DynValue{}
}

fn validator_extract_rules(rules vphp.RequestBorrowedZBox) map[string][]string {
	raw := rules.to_zval()
	if !raw.is_valid() || raw.is_null() || raw.is_undef() || !raw.is_array() {
		return map[string][]string{}
	}
	mut out := map[string][]string{}
	for key in raw.assoc_keys() {
		value := raw.get(key) or { continue }
		parsed := validator_rule_list(value)
		if parsed.len > 0 {
			out[key] = parsed
		}
	}
	return out
}

fn validator_rule_list(value vphp.ZVal) []string {
	if value.is_string() {
		return validator_split_rule_list(value.to_string())
	}
	if value.is_array() {
		mut out := []string{}
		for idx := 0; idx < value.array_count(); idx++ {
			item := value.array_get(idx).to_string().trim_space()
			if item != '' {
				out << item
			}
		}
		return out
	}
	return []string{}
}

fn validator_split_rule_list(raw string) []string {
	mut out := []string{}
	for part in raw.split('|') {
		clean := part.trim_space()
		if clean != '' {
			out << clean
		}
	}
	return out
}

fn validator_split_rule(rule string) (string, string) {
	idx := rule.index(':') or { return rule.trim_space().to_lower(), '' }
	name := rule[..idx].trim_space().to_lower()
	arg := rule[idx + 1..].trim_space()
	return name, arg
}

fn validator_rule_error(field string, value vphp.DynValue, name string, arg string) ?string {
	match name {
		'string' {
			if value.type != .string_ {
				return 'The ${field} field must be a string.'
			}
		}
		'int', 'integer' {
			if !validator_is_int_like(value) {
				return 'The ${field} field must be an integer.'
			}
		}
		'numeric' {
			if !validator_is_numeric_like(value) {
				return 'The ${field} field must be numeric.'
			}
		}
		'bool', 'boolean' {
			if !validator_is_bool_like(value) {
				return 'The ${field} field must be a boolean.'
			}
		}
		'email' {
			if !validator_is_email_like(value) {
				return 'The ${field} field must be a valid email address.'
			}
		}
		'min' {
			min_value := strconv.atof64(arg, strconv.AtoF64Param{}) or { return none }
			if !validator_meets_min(value, min_value) {
				return 'The ${field} field must be at least ${arg}.'
			}
		}
		'max' {
			max_value := strconv.atof64(arg, strconv.AtoF64Param{}) or { return none }
			if !validator_meets_max(value, max_value) {
				return 'The ${field} field may not be greater than ${arg}.'
			}
		}
		'in' {
			choices := arg.split(',').map(it.trim_space()).filter(it != '')
			if choices.len > 0 && validator_string_value(value) !in choices {
				return 'The ${field} field must be one of: ${choices.join(', ')}.'
			}
		}
		else {}
	}
	return none
}

fn validator_is_empty(value vphp.DynValue) bool {
	return match value.type {
		.null_ { true }
		.string_ { value.string_value().trim_space() == '' }
		.list_ { value.list.len == 0 }
		.map_ { value.map.len == 0 }
		else { false }
	}
}

fn validator_is_nullish(value vphp.DynValue) bool {
	return match value.type {
		.null_ { true }
		.string_ { value.string_value().trim_space() == '' }
		else { false }
	}
}

fn validator_is_int_like(value vphp.DynValue) bool {
	return match value.type {
		.int_ {
			true
		}
		.string_ {
			raw := value.string_value().trim_space()
			if raw == '' {
				return false
			}
			_ := strconv.atoi64(raw) or { return false }
			return true
		}
		else {
			false
		}
	}
}

fn validator_is_numeric_like(value vphp.DynValue) bool {
	return match value.type {
		.int_, .float_ {
			true
		}
		.string_ {
			raw := value.string_value().trim_space()
			if raw == '' {
				return false
			}
			_ := strconv.atof64(raw, strconv.AtoF64Param{}) or { return false }
			return true
		}
		else {
			false
		}
	}
}

fn validator_is_bool_like(value vphp.DynValue) bool {
	return match value.type {
		.bool_ {
			true
		}
		.int_ {
			value.int_value() in [i64(0), i64(1)]
		}
		.string_ {
			raw := value.string_value().trim_space().to_lower()
			raw in ['1', '0', 'true', 'false', 'yes', 'no', 'on', 'off']
		}
		else {
			false
		}
	}
}

fn validator_is_email_like(value vphp.DynValue) bool {
	if value.type != .string_ {
		return false
	}
	raw := value.string_value().trim_space()
	if raw.len < 3 || !raw.contains('@') {
		return false
	}
	parts := raw.split('@')
	if parts.len != 2 {
		return false
	}
	local := parts[0].trim_space()
	domain := parts[1].trim_space()
	return local != '' && domain.contains('.') && !domain.starts_with('.') && !domain.ends_with('.')
}

fn validator_numeric_value(value vphp.DynValue) ?f64 {
	return match value.type {
		.int_ {
			f64(value.int_value())
		}
		.float_ {
			value.float_value()
		}
		.string_ {
			raw := value.string_value().trim_space()
			if raw == '' {
				return none
			}
			strconv.atof64(raw, strconv.AtoF64Param{}) or { return none }
		}
		else {
			none
		}
	}
}

fn validator_length_value(value vphp.DynValue) ?f64 {
	return match value.type {
		.string_ { f64(value.string_value().len) }
		.list_ { f64(value.list.len) }
		.map_ { f64(value.map.len) }
		else { none }
	}
}

fn validator_meets_min(value vphp.DynValue, minimum f64) bool {
	numeric := validator_numeric_value(value) or {
		length := validator_length_value(value) or { return false }
		return length >= minimum
	}
	return numeric >= minimum
}

fn validator_meets_max(value vphp.DynValue, maximum f64) bool {
	numeric := validator_numeric_value(value) or {
		length := validator_length_value(value) or { return false }
		return length <= maximum
	}
	return numeric <= maximum
}

fn validator_string_value(value vphp.DynValue) string {
	return match value.type {
		.null_ {
			''
		}
		.bool_ {
			if value.bool_value() {
				'true'
			} else {
				'false'
			}
		}
		.int_ {
			'${value.int_value()}'
		}
		.float_ {
			'${value.float_value()}'
		}
		.string_ {
			value.string_value()
		}
		.list_ {
			'[list]'
		}
		.map_ {
			'[map]'
		}
		.object_ref {
			'[object]'
		}
		.callable_ref {
			'[callable]'
		}
		.resource_ref {
			'[resource]'
		}
	}
}

fn validator_dyn_map_zbox(values map[string]vphp.DynValue) vphp.RequestOwnedZBox {
	return database_result_box_from_dyn(vphp.dyn_value_map(values))
}

fn validator_errors_zbox(errors map[string][]string) vphp.RequestOwnedZBox {
	mut out := map[string]vphp.DynValue{}
	for key, values in errors {
		mut items := []vphp.DynValue{}
		for value in values {
			items << vphp.dyn_value_string(value)
		}
		out[key] = vphp.dyn_value_list(items)
	}
	return database_result_box_from_dyn(vphp.dyn_value_map(out))
}
