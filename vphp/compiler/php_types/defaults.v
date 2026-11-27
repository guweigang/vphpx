module php_types

pub struct PhpDefaultSpec {
pub:
	v_key    string
	v_expr   string
	php_expr string
}

pub fn PhpDefaultSpec.from_v_type(v_type string) PhpDefaultSpec {
	clean := v_type.trim_space()
	if clean.starts_with('?') {
		return PhpDefaultSpec{
			v_key:    clean
			v_expr:   'none'
			php_expr: 'null'
		}
	}
	normalized := normalize_v_type_key(clean)
	match normalized {
		'string' {
			return PhpDefaultSpec{
				v_key:    normalized
				v_expr:   "''"
				php_expr: "''"
			}
		}
		'bool' {
			return PhpDefaultSpec{
				v_key:    normalized
				v_expr:   'false'
				php_expr: 'false'
			}
		}
		'int', 'i8', 'i16', 'i32', 'i64', 'isize', 'u8', 'u16', 'u32', 'u64', 'usize' {
			return PhpDefaultSpec{
				v_key:    normalized
				v_expr:   '0'
				php_expr: '0'
			}
		}
		'f32', 'f64' {
			return PhpDefaultSpec{
				v_key:    normalized
				v_expr:   '0.0'
				php_expr: '0.0'
			}
		}
		'PhpNull' {
			return PhpDefaultSpec{
				v_key:    normalized
				v_expr:   'vphp.PhpNull.value()'
				php_expr: 'null'
			}
		}
		'PhpBool' {
			return PhpDefaultSpec{
				v_key:    normalized
				v_expr:   'vphp.PhpBool.false_value()'
				php_expr: 'false'
			}
		}
		'PhpInt' {
			return PhpDefaultSpec{
				v_key:    normalized
				v_expr:   'vphp.PhpInt.zero()'
				php_expr: '0'
			}
		}
		'PhpDouble' {
			return PhpDefaultSpec{
				v_key:    normalized
				v_expr:   'vphp.PhpDouble.zero()'
				php_expr: '0'
			}
		}
		'PhpString' {
			return PhpDefaultSpec{
				v_key:    normalized
				v_expr:   'vphp.PhpString.empty()'
				php_expr: "''"
			}
		}
		'PhpArray' {
			return PhpDefaultSpec{
				v_key:    normalized
				v_expr:   'vphp.PhpArray.empty()'
				php_expr: '[]'
			}
		}
		else {}
	}

	if clean.starts_with('[]') || clean.starts_with('map[') {
		return PhpDefaultSpec{
			v_key:    normalized
			v_expr:   '${clean}{}'
			php_expr: '[]'
		}
	}
	return PhpDefaultSpec{
		v_key:    normalized
		v_expr:   '${clean}{}'
		php_expr: 'null'
	}
}
