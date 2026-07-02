import rt

struct Class_Automattic_WooCommerce_Api_Scalars_DateTime {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Api_Scalars_DateTime.serialize(mut var_value Class_Automattic_WooCommerce_Api_Scalars_mixed) string {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Api_Scalars_mixed',
		[]string{}, var_value), 'Automattic_WooCommerce_Api_Scalars_DateTimeInterface')))
	{
		return (var_value.format(Class_Automattic_WooCommerce_Api_Scalars_DateTimeInterface.atom())).str()
	}
	return var_value.str()
}

fn Class_Automattic_WooCommerce_Api_Scalars_DateTime.parse(value string) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_Api_Scalars_DateTimeImmutable', []string{},
		create_automattic_woocommerce_api_scalars_datetimeimmutable(rt.new_string(value)))
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Api_Scalars_Exception') {
		mut var_e := var_e_1.clone()
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Api_Scalars_InvalidArgumentException',
			[]string{}, create_automattic_woocommerce_api_scalars_invalidargumentexception(rt.call_function('sprintf', [
			rt.new_string('Invalid ISO 8601 date/time: %s'),
			rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
		]), rt.new_int(0), var_e.clone())))
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Api_Scalars_DateTimeImmutable {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Scalars_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_api_scalars_datetime(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Scalars_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Api_Scalars_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_scalars_datetimeimmutable(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Scalars_DateTimeImmutable {
	mut obj := &Class_Automattic_WooCommerce_Api_Scalars_DateTimeImmutable{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_scalars_invalidargumentexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Scalars_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Api_Scalars_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Scalars_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'serialize' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Scalars_mixed](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Api_Scalars_DateTime.serialize(mut dispatch_arg_0))
		}
		'parse' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Api_Scalars_DateTime.parse(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Api_Scalars_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Scalars_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Api_Scalars_DateTimeImmutable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Scalars_DateTimeImmutable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Scalars_DateTimeImmutable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Api_Scalars_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Scalars_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Scalars_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
