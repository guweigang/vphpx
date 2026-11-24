module repr

pub struct PhpFuncRepr {
pub mut:
	name            string
	module_name     string
	original_name   string // 原始 V 函数名
	return_spec     PhpReturnRepr
	args            []PhpArgRepr
	attributes      []PhpAttributeRepr
	has_export      bool
	borrowed_return bool
	is_internal     bool
	uses_context    bool
	min_php_version int
}

pub fn (r PhpFuncRepr) symbol() string {
	// Encode the entire name so namespace separators and underscores cannot collide.
	if r.name.contains('\\') || r.name.to_lower().starts_with('vphp_ns_')
		|| r.name.bytes().any(it >= 128) {
		return 'vphp_ns_${r.name.hex()}'
	}
	return r.name
}

pub fn (r PhpFuncRepr) wrapper_symbol() string {
	symbol := r.symbol()
	if symbol != r.name {
		return 'vphp_function_${symbol}'
	}
	return 'vphp_wrap_${symbol}'
}

pub fn (r PhpFuncRepr) qualified_original_name() string {
	name := if r.original_name != '' { r.original_name } else { r.name }
	if r.module_name == '' || r.module_name == 'main' {
		return name
	}
	return '${r.module_name.all_after_last('.')}.${name}'
}

pub fn new_func_repr() &PhpFuncRepr {
	return &PhpFuncRepr{}
}
