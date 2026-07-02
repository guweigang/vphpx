import rt

struct Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Utilities_MetaDataUtil.update(var_meta_data rt.PhpVal, mut var_target Class_WC_Data, default_id string) {
	if !(var_meta_data.clone().is_array()) {
		return
	}
	mut iter_1 := Class_Automattic_WooCommerce_Utilities_MetaDataUtil.normalize(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](var_meta_data),
		default_id).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_meta := item_1.val
		var_target.update_meta_data(var_meta.array_get(rt.new_string('key')),
			var_meta.array_get(rt.new_string('value')), var_meta.array_get(rt.new_string('id')))
	}
}

fn Class_Automattic_WooCommerce_Utilities_MetaDataUtil.normalize(mut var_meta_data Class_Automattic_WooCommerce_Utilities_array, default_id string) rt.PhpVal {
	mut var_normalized := rt.new_array()
	mut iter_2 := var_meta_data.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_meta := item_2.val
		if var_meta.clone().is_array() && var_meta.array_isset(rt.new_string('key')) {
			var_normalized.array_push(rt.create_array([
				rt.ArrayItem{ key: 'key', val: var_meta.array_get(rt.new_string('key')) },
				rt.ArrayItem{
					key: 'value'
					val: if !(var_meta.array_get(rt.new_string('value'))).is_null() {
						var_meta.array_get(rt.new_string('value'))
					} else {
						rt.new_null()
					}
				},
				rt.ArrayItem{
					key: 'id'
					val: if !(var_meta.array_get(rt.new_string('id'))).is_null() {
						var_meta.array_get(rt.new_string('id'))
					} else {
						rt.new_string(default_id)
					}
				},
			]))
		}
	}
	return var_normalized.clone()
}

fn create_automattic_woocommerce_utilities_metadatautil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_MetaDataUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Data](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Utilities_MetaDataUtil.update(dispatch_arg_0, mut
				dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'normalize' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Utilities_MetaDataUtil.normalize(mut dispatch_arg_0,
				dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
