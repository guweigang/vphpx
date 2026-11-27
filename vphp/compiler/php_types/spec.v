module php_types

pub fn is_sensitive_parameter_attribute(name string) bool {
	return class_lookup_name(name).to_lower() == 'sensitiveparameter'
}

pub fn is_deprecated_attribute(name string) bool {
	return class_lookup_name(name).to_lower() == 'deprecated'
}

pub fn is_nodiscard_attribute(name string) bool {
	return class_lookup_name(name).to_lower() == 'nodiscard'
}

pub fn is_override_attribute(name string) bool {
	return class_lookup_name(name).to_lower() == 'override'
}

// normalize_php_type_literal decodes namespace separators retained by legacy attributes.
pub fn normalize_php_type_literal(name string) string {
	return name.replace('\\\\', '\\')
}

// class_lookup_name converts a PHP class reference to a name accepted by Zend's class table.
pub fn class_lookup_name(name string) string {
	return normalize_php_type_literal(name).trim_string_left('\\')
}

pub struct PhpTypeSpec {
pub:
	v_key        string
	php_code     string
	php_mask     string
	php_class    string
	arg_method   string
	arg_label    string
	is_total_arg bool
}

pub fn is_reference_parameter(v_type string, variadic bool) bool {
	element_type := if variadic && v_type.starts_with('[]') { v_type[2..] } else { v_type }
	return element_type.trim_left('?') in ['PhpReference', 'vphp.PhpReference']
}

pub fn accepts_named_variadic(v_type string, variadic bool) bool {
	return variadic && v_type.trim_string_left('[]') in ['PhpArg', 'vphp.PhpArg']
}

pub fn is_reference_return(v_type string) bool {
	return v_type.trim_left('!') in ['PhpReference', 'vphp.PhpReference']
}

pub fn normalize_v_type_key(v_type string) string {
	mut clean_type := v_type.trim_space().replace('vphp.ZVal', 'ZVal')
	if clean_type.starts_with('&') || clean_type.starts_with('!') || clean_type.starts_with('?') {
		clean_type = clean_type[1..]
	}
	if !clean_type.starts_with('[]') && !clean_type.starts_with('map[') && clean_type.contains('.') {
		clean_type = clean_type.all_after('.')
	}
	return clean_type
}

pub fn PhpTypeSpec.from_v_type(v_type string) ?PhpTypeSpec {
	clean := normalize_v_type_key(v_type)
	return match clean {
		'ZVal', 'RequestBorrowedZBox', 'RequestOwnedZBox', 'PersistentOwnedZBox', 'PhpArg' {
			PhpTypeSpec{
				v_key:    clean
				php_code: 'IS_MIXED'
			}
		}
		'[]string', '[]int', '[]i64', '[]bool', '[]f64', '[]f32', '[]', '[]ZVal',
		'map[string]string', 'map[string]int', 'map[string]i64', 'map[string]bool',
		'map[string]f64', 'map[string][]string', 'map[string]ZVal' {
			PhpTypeSpec{
				v_key:    clean
				php_code: 'IS_ARRAY'
			}
		}
		'PhpValue' {
			PhpTypeSpec{
				v_key:        clean
				php_code:     'IS_MIXED'
				arg_method:   'value'
				arg_label:    'value'
				is_total_arg: true
			}
		}
		'PhpNull' {
			PhpTypeSpec{
				v_key:      clean
				php_code:   'IS_NULL'
				arg_method: 'null_value'
				arg_label:  'null'
			}
		}
		'PhpBool' {
			PhpTypeSpec{
				v_key:      clean
				php_code:   '_IS_BOOL'
				arg_method: 'bool_value'
				arg_label:  'bool'
			}
		}
		'PhpInt' {
			PhpTypeSpec{
				v_key:      clean
				php_code:   'IS_LONG'
				arg_method: 'int_value'
				arg_label:  'int'
			}
		}
		'PhpDouble' {
			PhpTypeSpec{
				v_key:      clean
				php_code:   'IS_DOUBLE'
				arg_method: 'double_value'
				arg_label:  'double'
			}
		}
		'PhpString' {
			PhpTypeSpec{
				v_key:      clean
				php_code:   'IS_STRING'
				arg_method: 'string_value'
				arg_label:  'string'
			}
		}
		'PhpScalar' {
			PhpTypeSpec{
				v_key:      clean
				php_code:   'IS_MIXED'
				arg_method: 'scalar'
				arg_label:  'scalar'
			}
		}
		'PhpArray' {
			PhpTypeSpec{
				v_key:      clean
				php_code:   'IS_ARRAY'
				arg_method: 'array'
				arg_label:  'array'
			}
		}
		'PhpObject' {
			PhpTypeSpec{
				v_key:      clean
				php_code:   'IS_OBJECT'
				arg_method: 'object'
				arg_label:  'object'
			}
		}
		'PhpCallable' {
			PhpTypeSpec{
				v_key:      clean
				php_code:   'IS_CALLABLE'
				arg_method: 'callable'
				arg_label:  'callable'
			}
		}
		'PhpResource' {
			PhpTypeSpec{
				v_key:      clean
				php_code:   'IS_MIXED'
				arg_method: 'resource'
				arg_label:  'resource'
			}
		}
		'PhpReference' {
			PhpTypeSpec{
				v_key:      clean
				php_code:   'IS_MIXED'
				arg_method: 'reference'
				arg_label:  'reference'
			}
		}
		'PhpIterable' {
			PhpTypeSpec{
				v_key:      clean
				php_mask:   'MAY_BE_ARRAY'
				php_class:  'Traversable'
				arg_method: 'iterable'
				arg_label:  'iterable'
			}
		}
		'PhpGenerator' {
			PhpTypeSpec{
				v_key:      clean
				php_class:  'Generator'
				arg_method: 'generator'
				arg_label:  'Generator'
			}
		}
		'PhpFiber' {
			PhpTypeSpec{
				v_key:      clean
				php_class:  'Fiber'
				arg_method: 'fiber'
				arg_label:  'Fiber'
			}
		}
		'PhpDateInterval' {
			PhpTypeSpec{
				v_key:      clean
				php_class:  'DateInterval'
				arg_method: 'date_interval'
				arg_label:  'DateInterval'
			}
		}
		'PhpDateTimeInterface' {
			PhpTypeSpec{
				v_key:      clean
				php_class:  'DateTimeInterface'
				arg_method: 'date_time_interface'
				arg_label:  'DateTimeInterface'
			}
		}
		'PhpDateTimeImmutable' {
			PhpTypeSpec{
				v_key:      clean
				php_class:  'DateTimeImmutable'
				arg_method: 'date_time_immutable'
				arg_label:  'DateTimeImmutable'
			}
		}
		'PhpJsonSerializable' {
			PhpTypeSpec{
				v_key:      clean
				php_class:  'JsonSerializable'
				arg_method: 'json_serializable'
				arg_label:  'JsonSerializable'
			}
		}
		'PhpStringable' {
			PhpTypeSpec{
				v_key:      clean
				php_class:  'Stringable'
				arg_method: 'stringable'
				arg_label:  'Stringable'
			}
		}
		'PhpCountable' {
			PhpTypeSpec{
				v_key:      clean
				php_class:  'Countable'
				arg_method: 'countable'
				arg_label:  'Countable'
			}
		}
		'PhpArrayAccess' {
			PhpTypeSpec{
				v_key:      clean
				php_class:  'ArrayAccess'
				arg_method: 'array_access'
				arg_label:  'ArrayAccess'
			}
		}
		'PhpWeakMap' {
			PhpTypeSpec{
				v_key:      clean
				php_class:  'WeakMap'
				arg_method: 'weak_map'
				arg_label:  'WeakMap'
			}
		}
		'PhpWeakReference' {
			PhpTypeSpec{
				v_key:      clean
				php_class:  'WeakReference'
				arg_method: 'weak_reference'
				arg_label:  'WeakReference'
			}
		}
		'PhpIterator' {
			PhpTypeSpec{
				v_key:      clean
				php_class:  'Traversable'
				arg_method: 'iterator'
				arg_label:  'iterator'
			}
		}
		'PhpIteratorAggregate' {
			PhpTypeSpec{
				v_key:      clean
				php_class:  'IteratorAggregate'
				arg_method: 'iterator_aggregate'
				arg_label:  'IteratorAggregate'
			}
		}
		'PhpThrowable' {
			PhpTypeSpec{
				v_key:      clean
				php_code:   'IS_OBJECT'
				php_class:  'Throwable'
				arg_method: 'throwable'
				arg_label:  'throwable'
			}
		}
		'PhpEnumCase' {
			PhpTypeSpec{
				v_key:      clean
				php_code:   'IS_MIXED'
				php_class:  'UnitEnum'
				arg_method: 'enum_case'
				arg_label:  'enum case'
			}
		}
		'callable', 'Callable' {
			PhpTypeSpec{
				v_key:    clean
				php_code: 'IS_CALLABLE'
			}
		}
		else {
			none
		}
	}
}

pub fn PhpTypeSpec.semantic_wrapper_for(v_type string) ?PhpTypeSpec {
	spec := PhpTypeSpec.from_v_type(v_type) or { return none }
	if spec.arg_method == '' {
		return none
	}
	return spec
}
