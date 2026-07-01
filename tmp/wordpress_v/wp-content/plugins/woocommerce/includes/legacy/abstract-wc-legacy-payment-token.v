import rt

struct Class_WC_Legacy_Payment_Token {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Legacy_Payment_Token) set_type(var_type rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Payment_Token::set_type'),
		rt.new_string('3.0.0'),
		rt.new_string('Type cannot be overwritten.'),
	])
}

fn (mut this Class_WC_Legacy_Payment_Token) read(var_token_id rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Payment_Token::read'),
		rt.new_string('3.0.0'), rt.new_string('a new token class initialized with an ID.')])
	this.set_id(var_token_id.dup())
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WC_Data_Store{}
		return temp.load(arg_0)
	}(rt.new_string('payment-token'))
	rt.call_method(var_data_store, 'read', [
		rt.new_object('WC_Legacy_Payment_Token', ['WC_Data'], &this),
	])
}

fn (mut this Class_WC_Legacy_Payment_Token) update() {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Payment_Token::update'),
		rt.new_string('3.0.0'),
		rt.new_string('WC_Payment_Token::save instead.'),
	])
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WC_Data_Store{}
		return temp.load(arg_0)
	}(rt.new_string('payment-token'))
	rt.call_method(var_data_store, 'update', [
		rt.new_object('WC_Legacy_Payment_Token', ['WC_Data'], &this),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		return rt.new_bool(false)
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
}

fn (mut this Class_WC_Legacy_Payment_Token) create() {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Payment_Token::create'),
		rt.new_string('3.0.0'),
		rt.new_string('WC_Payment_Token::save instead.'),
	])
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WC_Data_Store{}
		return temp.load(arg_0)
	}(rt.new_string('payment-token'))
	rt.call_method(var_data_store, 'create', [
		rt.new_object('WC_Legacy_Payment_Token', ['WC_Data'], &this),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.dup()
		return rt.new_bool(false)
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
}

struct Class_WC_Data {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_legacy_payment_token() &Class_WC_Legacy_Payment_Token {
	mut obj := &Class_WC_Legacy_Payment_Token{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data() &Class_WC_Data {
	mut obj := &Class_WC_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Legacy_Payment_Token) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'set_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_type(dispatch_arg_0)
			return rt.new_null()
		}
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read(dispatch_arg_0)
			return rt.new_null()
		}
		'update' {
			this.update()
			return rt.new_null()
		}
		'create' {
			this.create()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Legacy_Payment_Token) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Legacy_Payment_Token) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_legacy_abstract_wc_legacy_payment_token_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
