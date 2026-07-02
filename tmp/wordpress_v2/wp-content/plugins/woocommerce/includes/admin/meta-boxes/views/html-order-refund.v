import rt

struct Class_WP_User {
	rt.PhpObjectBase
}

fn create_wp_user(_args ...rt.PhpVal) &Class_WP_User {
	mut obj := &Class_WP_User{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_User) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_refund := rt.new_null()
	mut var_class := rt.new_null()
	mut var_cogs_is_enabled := rt.new_null()
	mut var_order_taxes := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	mut var_who_refunded := create_wp_user(rt.call_method(var_refund, 'get_refunded_by',
		[]rt.PhpVal{}))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(!rt.is_true(var_class)) { rt.call_function('esc_attr', [
			var_class.clone()]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_refund, 'get_id', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_who_refunded.exists()) {
		rt.call_function('printf', [
			rt.call_function('esc_html__', [rt.new_string('Refund #%1$s - %2$s by %3$s'),
				rt.new_string('woocommerce')]),
			rt.call_function('esc_html', [rt.call_method(var_refund, 'get_id', []rt.PhpVal{})]),
			rt.call_function('esc_html', [
				rt.call_function('wc_format_datetime', [
					rt.call_method(var_refund, 'get_date_created', []rt.PhpVal{}),
					rt.new_string(
						(rt.call_function('get_option', [rt.new_string('date_format')])).str() +
						', ' +
						(rt.call_function('get_option', [rt.new_string('time_format')])).str()),
				]),
			]),
			rt.call_function('sprintf', [
				rt.new_string('<abbr class="refund_by" title="%1$s">%2$s</abbr>'),
				rt.call_function('sprintf', [
					rt.call_function('esc_attr__', [
						rt.new_string('ID: %d'),
						rt.new_string('woocommerce'),
					]),
					rt.call_function('absint', [
						rt.get_property(var_who_refunded, 'ID'),
					]),
				]),
				rt.call_function('esc_html', [
					rt.get_property(var_who_refunded, 'display_name'),
				]),
			]),
		])
	} else {
		rt.call_function('printf', [
			rt.call_function('esc_html__', [rt.new_string('Refund #%1$s - %2$s'),
				rt.new_string('woocommerce')]),
			rt.call_function('esc_html', [rt.call_method(var_refund, 'get_id', []rt.PhpVal{})]),
			rt.call_function('esc_html', [
				rt.call_function('wc_format_datetime', [
					rt.call_method(var_refund, 'get_date_created', []rt.PhpVal{}),
					rt.new_string(
						(rt.call_function('get_option', [rt.new_string('date_format')])).str() +
						', ' +
						(rt.call_function('get_option', [rt.new_string('time_format')])).str()),
				]),
			]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_refund, 'get_reason', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_method(var_refund, 'get_reason', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_refund, 'get_id', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_after_order_refund_item_name'),
		var_refund.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_admin_order_item_values'),
		rt.new_null(), var_refund.clone(), rt.call_method(var_refund, 'get_id', []rt.PhpVal{})])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_cogs_is_enabled) {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('wc_price', [
			rt.new_string('-' + (rt.call_method(var_refund, 'get_amount', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'currency', val: rt.call_method(var_refund, 'get_currency',
					[]rt.PhpVal{}) },
			]),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		mut var_total_taxes := var_order_taxes.clone().array_count()
		// unsupported statement: Stmt_InlineHTML
		mut var_i := 0
		for {
			if !(var_i < var_total_taxes) { break
			 }
			// unsupported statement: Stmt_InlineHTML
			var_i += 1
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
