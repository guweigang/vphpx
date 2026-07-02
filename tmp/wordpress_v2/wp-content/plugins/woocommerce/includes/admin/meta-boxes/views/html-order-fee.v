import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_class := rt.new_null()
	mut var_item_id := rt.new_null()
	mut var_item := rt.new_null()
	mut var_cogs_is_enabled := rt.new_null()
	mut var_order := rt.new_null()
	mut var_order_taxes := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(!rt.is_true(var_class)) { rt.call_function('esc_attr', [
			var_class.clone()]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_item_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [if rt.is_true(rt.call_method(var_item, 'get_name', []rt.PhpVal{})) { rt.call_method(var_item, 'get_name', []rt.PhpVal{}) } else { rt.call_function('__', [
			rt.new_string('Fee'),
			rt.new_string('woocommerce'),
		]) }]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Fee name'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_item_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.is_true(rt.call_method(var_item, 'get_name', []rt.PhpVal{})) { rt.call_function('esc_attr', [
			rt.call_method(var_item, 'get_name', []rt.PhpVal{}),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_item_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_item_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_item, 'get_tax_class', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_after_order_fee_item_name'),
		var_item_id.clone(),
		var_item.clone(),
		rt.new_null(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_admin_order_item_values'),
		rt.new_null(), var_item.clone(), rt.call_function('absint', [
			var_item_id.clone()])])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_cogs_is_enabled) {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_price', [
		rt.call_method(var_item, 'get_total', []rt.PhpVal{}),
		rt.create_array([
			rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency',
				[]rt.PhpVal{}) },
		]),
	]))
	mut var_refunded := rt.mul(-1, rt.call_method(var_order, 'get_total_refunded_for_item', [
		var_item_id.clone(),
		rt.new_string('fee'),
	]))
	if rt.is_true(var_refunded) {
		print('<small class="refunded">' +
			(rt.call_function('wc_price', [var_refunded.clone(), rt.create_array([rt.ArrayItem{
			key: 'currency'
			val: rt.call_method(var_order, 'get_currency', []rt.PhpVal{})
		}])])).str() +
			'</small>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_item_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('wc_format_localized_price', [rt.new_int(0)]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('wc_format_localized_price', [
			rt.call_method(var_item, 'get_total', []rt.PhpVal{}),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_item_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('wc_format_localized_price', [rt.new_int(0)]),
	]))
	// unsupported statement: Stmt_InlineHTML
	mut var_tax_data := rt.call_method(var_item, 'get_taxes', []rt.PhpVal{})
	if rt.is_true(var_tax_data) && rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		mut iter_1 := var_order_taxes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax_item := item_1.val
			mut var_tax_item_id := rt.call_method(var_tax_item, 'get_rate_id', []rt.PhpVal{})
			mut var_tax_item_total := if var_tax_data.array_get(rt.new_string('total')).array_isset(var_tax_item_id) {
				var_tax_data.array_get(rt.new_string('total')).array_get(var_tax_item_id)
			} else {
				rt.new_string('')
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_tax_item_total)))) { rt.call_function('wc_price', [
					rt.call_function('wc_round_tax_total', [var_tax_item_total.clone()]),
					rt.create_array([rt.ArrayItem{
						key: 'currency'
						val: rt.call_method(var_order, 'get_currency', []rt.PhpVal{})
					}]),
				]) } else { rt.new_string('&ndash;') })
			var_refunded = rt.mul(-1, rt.call_method(var_order, 'get_tax_refunded_for_item', [
				var_item_id.clone(),
				var_tax_item_id.clone(),
				rt.new_string('fee'),
			]))
			if rt.is_true(var_refunded) {
				print('<small class="refunded">' +
					(rt.call_function('wc_price', [var_refunded.clone(), rt.create_array([rt.ArrayItem{
					key: 'currency'
					val: rt.call_method(var_order, 'get_currency', []rt.PhpVal{})
				}])])).str() +
					'</small>')
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('absint', [var_item_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_tax_item_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('wc_format_localized_price', [
					rt.new_int(0)]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(if !var_tax_item_total.is_null() { rt.call_function('esc_attr', [
					rt.call_function('wc_format_localized_price', [
						var_tax_item_total.clone()]),
				]) } else { rt.new_string('') })
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('absint', [var_item_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_tax_item_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('wc_format_localized_price', [
					rt.new_int(0)]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_tax_item_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_order, 'is_editable', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Edit fee'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Edit fee'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Delete fee'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Delete fee'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
