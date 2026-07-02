import rt

struct Class_WC_Meta_Box_Order_Notes {
	rt.PhpObjectBase
}

fn Class_WC_Meta_Box_Order_Notes.output(var_post rt.PhpVal) {
	if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WC_Order'))) {
		mut var_order_id := rt.call_method(var_post, 'get_id', []rt.PhpVal{})
	} else {
		var_order_id = rt.get_property(var_post, 'ID')
	}
	mut var_args := {
		'order_id': var_order_id
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_order_id)))) {
		mut var_notes := rt.call_function('wc_get_order_notes', [
			rt.create_array_from_native_map(var_args),
		])
	} else {
		var_notes = rt.new_array()
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add note'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('Add a note for your reference, or add a customer note (the user will be notified).'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Note type'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Private note'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Note to customer'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.include_file(@DIR + '/views/html-order-notes.php', '1')
}

fn create_wc_meta_box_order_notes(_args ...rt.PhpVal) &Class_WC_Meta_Box_Order_Notes {
	mut obj := &Class_WC_Meta_Box_Order_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Meta_Box_Order_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Meta_Box_Order_Notes.output(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Meta_Box_Order_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Meta_Box_Order_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
