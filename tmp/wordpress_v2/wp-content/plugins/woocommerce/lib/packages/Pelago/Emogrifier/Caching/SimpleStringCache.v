import rt

struct Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_SimpleStringCache {
	rt.PhpObjectBase
pub mut:
	values rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_SimpleStringCache) has(key string) bool {
	this.assertnotemptykey(key)
	return (rt.new_bool(this.values.array_isset(rt.new_string(key)))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_SimpleStringCache) get(key string) string {
	if !(this.has(key)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_BadMethodCallException',
			[]string{}, create_automattic_woocommerce_vendor_pelago_emogrifier_caching_badmethodcallexception(rt.new_string('You can only call `get` with a key for an existing value.'),
			rt.new_int(1625996246))))
	}
	return (this.values.array_get(rt.new_string(key))).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_SimpleStringCache) set(key string, value string) {
	this.assertnotemptykey(key)
	this.values.array_set(key, value)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_SimpleStringCache) assertnotemptykey(key string) {
	if rt.is_true(rt.identical(rt.new_string(key), rt.new_string(''))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_InvalidArgumentException',
			[]string{}, create_automattic_woocommerce_vendor_pelago_emogrifier_caching_invalidargumentexception(rt.new_string('Please provide a non-empty key.'),
			rt.new_int(1625995840))))
	}
}

struct Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_BadMethodCallException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_pelago_emogrifier_caching_simplestringcache(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_SimpleStringCache {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_SimpleStringCache{
		PhpObjectBase: rt.PhpObjectBase{}
		values:        rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_pelago_emogrifier_caching_badmethodcallexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_BadMethodCallException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_BadMethodCallException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_pelago_emogrifier_caching_invalidargumentexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_SimpleStringCache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'has' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.has(dispatch_arg_0))
		}
		'get' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get(dispatch_arg_0))
		}
		'set' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'assertNotEmptyKey' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.assertnotemptykey(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_SimpleStringCache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'values' { return this.values }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_SimpleStringCache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'values' {
			this.values = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_BadMethodCallException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_BadMethodCallException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_BadMethodCallException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Caching_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
