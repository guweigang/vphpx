module emitter

pub enum TypeTag {
	t_unknown
	t_void
	t_int
	t_float
	t_string
	t_bool
	t_null
	t_array
	t_object
}

pub struct VarType {
pub mut:
	tag              TypeTag
	class_name       string
	is_native_list   bool
	is_native_map    bool
	element_type_tag TypeTag
}

pub fn (t VarType) is_scalar() bool {
	return t.tag in [.t_int, .t_float, .t_string, .t_bool]
}

pub fn (t VarType) is_object() bool {
	return t.tag == .t_object && t.class_name.len > 0
}

pub fn (t VarType) to_v_type() string {
	if t.is_native_list {
		elem := match t.element_type_tag {
			.t_int { 'i64' }
			.t_float { 'f64' }
			.t_string { 'string' }
			.t_bool { 'bool' }
			else { 'rt.PhpVal' }
		}
		return '[]' + elem
	}
	if t.is_native_map {
		elem := match t.element_type_tag {
			.t_int { 'i64' }
			.t_float { 'f64' }
			.t_string { 'string' }
			.t_bool { 'bool' }
			else { 'rt.PhpVal' }
		}
		return 'map[string]' + elem
	}
	match t.tag {
		.t_int { return 'i64' }
		.t_float { return 'f64' }
		.t_string { return 'string' }
		.t_bool { return 'bool' }
		.t_object { return 'Class_${t.class_name}' }
		else { return 'rt.PhpVal' }
	}
}
