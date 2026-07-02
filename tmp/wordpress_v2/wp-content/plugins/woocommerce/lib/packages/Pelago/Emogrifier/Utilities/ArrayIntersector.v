import rt

struct Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_ArrayIntersector {
	rt.PhpObjectBase
pub mut:
	invertedArray rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_ArrayIntersector) construct(mut var_array Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_array) {
	this.invertedArray = rt.call_function('array_flip', [var_array])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_ArrayIntersector) intersectwith(mut var_array Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_array) rt.PhpVal {
	mut var_invertedArray := rt.call_function('array_flip', [var_array])
	mut var_invertedIntersection := rt.call_function('array_intersect_key', [
		var_invertedArray.clone(), this.invertedArray])
	return rt.call_function('array_flip', [var_invertedIntersection.clone()])
}

fn create_automattic_woocommerce_vendor_pelago_emogrifier_utilities_arrayintersector(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_ArrayIntersector {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_ArrayIntersector{
		PhpObjectBase: rt.PhpObjectBase{}
		invertedArray: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_ArrayIntersector) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'intersectWith' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.intersectwith(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_ArrayIntersector) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'invertedArray' { return this.invertedArray }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_ArrayIntersector) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'invertedArray' {
			this.invertedArray = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
