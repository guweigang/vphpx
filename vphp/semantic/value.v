module semantic

pub enum ValueKind {
	null_
	bool_
	int_
	float_
	string_
	array
	object
	zend
}

pub struct NullValue {}

pub struct BoolValue {
pub:
	value bool
}

pub struct IntValue {
pub:
	value i64
}

pub struct FloatValue {
pub:
	value f64
}

pub struct StringValue {
pub:
	value string
}

pub struct ArrayValue {
pub:
	value &Array
}

pub struct ObjectValue {
pub:
	value &Object
}

// ZendValue is an opaque leaf for values owned by the real Zend runtime.
// The semantic layer does not manage this pointer; bridge code must attach
// explicit vphp ownership before converting it back to a zval-facing value.
pub struct ZendValue {
pub:
	handle    voidptr
	ownership string
	type_name string
}

pub type Value = ArrayValue
	| BoolValue
	| FloatValue
	| IntValue
	| NullValue
	| ObjectValue
	| StringValue
	| ZendValue

pub fn null_value() Value {
	return NullValue{}
}

pub fn bool_value(v bool) Value {
	return BoolValue{
		value: v
	}
}

pub fn int_value(v i64) Value {
	return IntValue{
		value: v
	}
}

pub fn float_value(v f64) Value {
	return FloatValue{
		value: v
	}
}

pub fn string_value(v string) Value {
	return StringValue{
		value: v.clone()
	}
}

pub fn array_value(arr &Array) Value {
	return ArrayValue{
		value: arr
	}
}

pub fn object_value(obj &Object) Value {
	return ObjectValue{
		value: obj
	}
}

pub fn zend_value(handle voidptr, ownership string, type_name string) Value {
	return ZendValue{
		handle:    handle
		ownership: ownership
		type_name: type_name
	}
}

pub fn (v Value) kind() ValueKind {
	return match v {
		NullValue { .null_ }
		BoolValue { .bool_ }
		IntValue { .int_ }
		FloatValue { .float_ }
		StringValue { .string_ }
		ArrayValue { .array }
		ObjectValue { .object }
		ZendValue { .zend }
	}
}

pub fn (v Value) clone() Value {
	return match v {
		NullValue {
			null_value()
		}
		BoolValue {
			bool_value(v.value)
		}
		IntValue {
			int_value(v.value)
		}
		FloatValue {
			float_value(v.value)
		}
		StringValue {
			string_value(v.value)
		}
		ArrayValue {
			array_value(v.value.clone_boxed())
		}
		ObjectValue {
			object_value(v.value.clone_boxed())
		}
		ZendValue {
			zend_value(v.handle, v.ownership, v.type_name)
		}
	}
}

pub fn (v Value) is_null() bool {
	return v is NullValue
}

pub fn (v Value) to_bool() bool {
	return match v {
		NullValue { false }
		BoolValue { v.value }
		IntValue { v.value != 0 }
		FloatValue { v.value != 0.0 }
		StringValue { v.value != '' && v.value != '0' }
		ArrayValue { v.value.count() > 0 }
		ObjectValue { true }
		ZendValue { true }
	}
}

pub fn (v Value) to_i64() i64 {
	return match v {
		IntValue {
			v.value
		}
		BoolValue {
			if v.value {
				i64(1)
			} else {
				i64(0)
			}
		}
		FloatValue {
			i64(v.value)
		}
		StringValue {
			v.value.i64()
		}
		else {
			i64(0)
		}
	}
}

pub fn (v Value) to_string() string {
	return match v {
		NullValue {
			''
		}
		BoolValue {
			if v.value {
				'1'
			} else {
				''
			}
		}
		IntValue {
			v.value.str()
		}
		FloatValue {
			v.value.str()
		}
		StringValue {
			v.value
		}
		ArrayValue {
			'Array'
		}
		ObjectValue {
			'Object'
		}
		ZendValue {
			'[Zend ${v.type_name}]'
		}
	}
}

pub fn (v Value) is_int() bool {
	return v is IntValue
}

pub fn (v Value) is_string() bool {
	return v is StringValue
}

pub fn (v Value) is_array() bool {
	return v is ArrayValue
}
