module emitter

pub enum TypeTag {
	t_unknown
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
	tag        TypeTag
	class_name string
}

pub fn (t VarType) is_scalar() bool {
	return t.tag in [.t_int, .t_float, .t_string, .t_bool]
}

pub fn (t VarType) is_object() bool {
	return t.tag == .t_object && t.class_name.len > 0
}

pub fn (t VarType) to_v_type() string {
	match t.tag {
		.t_int { return 'i64' }
		.t_float { return 'f64' }
		.t_string { return 'string' }
		.t_bool { return 'bool' }
		else { return 'rt.PhpVal' }
	}
}
