module vphp

import vphp.semantic

pub enum SemanticMaterializePolicy {
	request_owned
}

pub struct SemanticMaterializeOptions {
pub:
	policy SemanticMaterializePolicy = .request_owned
}

pub fn semantic_to_php_value(value semantic.Value) !PhpValue {
	return semantic_to_php_value_with_options(value, SemanticMaterializeOptions{})
}

pub fn semantic_to_php_value_with_options(value semantic.Value, options SemanticMaterializeOptions) !PhpValue {
	match options.policy {
		.request_owned {}
	}
	return match value {
		semantic.NullValue {
			PhpValue.null()
		}
		semantic.BoolValue {
			PhpValue.bool(value.value)
		}
		semantic.IntValue {
			PhpValue.int(value.value)
		}
		semantic.FloatValue {
			PhpValue.double(value.value)
		}
		semantic.StringValue {
			PhpValue.string(value.value)
		}
		semantic.ArrayValue {
			semantic_array_to_php_value(value.value)!
		}
		semantic.ObjectValue {
			error('semantic object materialization requires an explicit Zend facade bridge')
		}
		semantic.ZendValue {
			error('opaque Zend semantic value cannot be materialized without ownership bridge')
		}
	}
}

pub fn semantic_array_to_php_value(arr &semantic.Array) !PhpValue {
	php_arr := PhpArray.empty()
	mut iter := arr.iter()
	for {
		item := iter.next() or { break }
		child := semantic_to_php_value(item.val)!
		mut owned := child.owned()
		z := owned.take_zval()
		if item.key is semantic.IntValue {
			php_arr.index_zval(item.key.value, z)
		} else {
			php_arr.assoc_zval(item.key.to_string(), z)
		}
	}
	mut out := php_arr
	return out.take_value()
}
