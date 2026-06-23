module rt

// is_true 根据 PHP 的真值规则判断 PhpVal 是否为真
pub fn is_true(v PhpVal) bool {
	if !v.is_valid() {
		return false
	}
	if v.is_null() {
		return false
	}
	if v.is_bool() {
		return v.to_bool()
	}
	if v.is_long() {
		return v.to_i64() != 0
	}
	if v.is_double() {
		return v.to_f64() != 0.0
	}
	if v.is_string() {
		s := v.to_string()
		return s != '' && s != '0'
	}
	if v.is_array() {
		return v.array_count() > 0
	}
	return true
}
