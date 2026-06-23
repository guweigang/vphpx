module rt

// 声明 Zend C 运算 API
fn C.add_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.sub_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.mul_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.div_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.mod_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.concat_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.compare_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.is_equal_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.is_identical_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.is_smaller_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.is_smaller_or_equal_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.boolean_not_function(result &C.zval, op1 &C.zval) int

// 算术加法 (+)
pub fn add(a PhpVal, b PhpVal) PhpVal {
	res := new_null()
	unsafe { C.add_function(res.raw, a.raw, b.raw) }
	return res
}

// 算术减法 (-)
pub fn sub(a PhpVal, b PhpVal) PhpVal {
	res := new_null()
	unsafe { C.sub_function(res.raw, a.raw, b.raw) }
	return res
}

// 算术乘法 (*)
pub fn mul(a PhpVal, b PhpVal) PhpVal {
	res := new_null()
	unsafe { C.mul_function(res.raw, a.raw, b.raw) }
	return res
}

// 算术除法 (/)
pub fn div(a PhpVal, b PhpVal) PhpVal {
	res := new_null()
	unsafe { C.div_function(res.raw, a.raw, b.raw) }
	return res
}

// 算术取模 (%)
pub fn mod_(a PhpVal, b PhpVal) PhpVal {
	res := new_null()
	unsafe { C.mod_function(res.raw, a.raw, b.raw) }
	return res
}

// 字符串拼接 (.)
pub fn concat(a PhpVal, b PhpVal) PhpVal {
	res := new_null()
	unsafe { C.concat_function(res.raw, a.raw, b.raw) }
	return res
}

// 弱等于 (==)
pub fn equal(a PhpVal, b PhpVal) PhpVal {
	res := new_null()
	unsafe { C.is_equal_function(res.raw, a.raw, b.raw) }
	return res
}

// 强等于 (===)
pub fn identical(a PhpVal, b PhpVal) PhpVal {
	res := new_null()
	unsafe { C.is_identical_function(res.raw, a.raw, b.raw) }
	return res
}

// 小于 (<)
pub fn less(a PhpVal, b PhpVal) PhpVal {
	res := new_null()
	unsafe { C.is_smaller_function(res.raw, a.raw, b.raw) }
	return res
}

// 小于等于 (<=)
pub fn less_equal(a PhpVal, b PhpVal) PhpVal {
	res := new_null()
	unsafe { C.is_smaller_or_equal_function(res.raw, a.raw, b.raw) }
	return res
}

// 大于 (>)
pub fn greater(a PhpVal, b PhpVal) PhpVal {
	res := new_null()
	unsafe { C.is_smaller_function(res.raw, b.raw, a.raw) }
	return res
}

// 大于等于 (>=)
pub fn greater_equal(a PhpVal, b PhpVal) PhpVal {
	res := new_null()
	unsafe { C.is_smaller_or_equal_function(res.raw, b.raw, a.raw) }
	return res
}

// 一元逻辑非 (!)
pub fn boolean_not(a PhpVal) PhpVal {
	res := new_null()
	unsafe { C.boolean_not_function(res.raw, a.raw) }
	return res
}
