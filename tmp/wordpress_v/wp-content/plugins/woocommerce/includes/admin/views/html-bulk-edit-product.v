import rt

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_I18nUtil {
	rt.PhpObjectBase
}

fn create_wc_tax() &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_i18nutil() &Class_Automattic_WooCommerce_Utilities_I18nUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_I18nUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_views_html_bulk_edit_product_php() {
	mut var_shipping_class := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Product data'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_product_bulk_edit_start')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Price'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_options := rt.create_array([rt.ArrayItem{ key: '', val: rt.call_function('__', [rt.new_string('— No change —'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: '1', val: rt.call_function('__', [rt.new_string('Change to:'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: '2', val: rt.call_function('__', [rt.new_string('Increase existing price by (fixed amount or %):'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: '3', val: rt.call_function('__', [rt.new_string('Decrease existing price by (fixed amount or %):'), rt.new_string('woocommerce')]) }])
	{
		mut iter_1 := var_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			print('<option value="' + (rt.call_function('esc_attr', [var_key.dup()])).str() + '">' + (rt.call_function('esc_html', [var_value.dup()])).str() + '</option>')
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_attr__', [rt.new_string('Enter price (%s)'), rt.new_string('woocommerce')]), rt.call_function('get_woocommerce_currency_symbol', []rt.PhpVal{})])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Sale'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	var_options = rt.create_array([rt.ArrayItem{ key: '', val: rt.call_function('__', [rt.new_string('— No change —'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: '1', val: rt.call_function('__', [rt.new_string('Change to:'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: '2', val: rt.call_function('__', [rt.new_string('Increase existing sale price by (fixed amount or %):'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: '3', val: rt.call_function('__', [rt.new_string('Decrease existing sale price by (fixed amount or %):'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: '4', val: rt.call_function('__', [rt.new_string('Set to regular price decreased by (fixed amount or %):'), rt.new_string('woocommerce')]) }])
	{
		mut iter_1 := var_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			print('<option value="' + (rt.call_function('esc_attr', [var_key.dup()])).str() + '">' + (rt.call_function('esc_html', [var_value.dup()])).str() + '</option>')
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_attr__', [rt.new_string('Enter sale price (%s)'), rt.new_string('woocommerce')]), rt.call_function('get_woocommerce_currency_symbol', []rt.PhpVal{})])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class()]), 'feature_is_enabled', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Cost'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		var_options = rt.create_array([rt.ArrayItem{ key: '', val: rt.call_function('__', [rt.new_string('— No change —'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: '1', val: rt.call_function('__', [rt.new_string('Change to:'), rt.new_string('woocommerce')]) }])
		{
			mut iter_1 := var_options.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				print('<option value="' + (rt.call_function('esc_attr', [var_key.dup()])).str() + '">' + (rt.call_function('esc_html', [var_value.dup()])).str() + '</option>')
			}
		}
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr', [rt.call_function('printf', [rt.call_function('__', [rt.new_string('Enter cost value (%s)'), rt.new_string('woocommerce')]), rt.call_function('get_woocommerce_currency_symbol', []rt.PhpVal{})])])
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Tax status'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		var_options = rt.create_array([rt.ArrayItem{ key: '', val: rt.call_function('__', [rt.new_string('— No change —'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable(), val: rt.call_function('__', [rt.new_string('Taxable'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.shipping(), val: rt.call_function('__', [rt.new_string('Shipping only'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.none(), val: rt.call_function('_x', [rt.new_string('None'), rt.new_string('Tax status'), rt.new_string('woocommerce')]) }])
		{
			mut iter_1 := var_options.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				print('<option value="' + (rt.call_function('esc_attr', [var_key.dup()])).str() + '">' + (rt.call_function('esc_html', [var_value.dup()])).str() + '</option>')
			}
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Tax class'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		var_options = rt.create_array([rt.ArrayItem{ key: '', val: rt.call_function('__', [rt.new_string('— No change —'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'standard', val: rt.call_function('__', [rt.new_string('Standard'), rt.new_string('woocommerce')]) }])
		mut var_tax_classes := fn () rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.get_tax_classes() }()
		if !(!rt.is_true(var_tax_classes)) {
			{
				mut iter_1 := var_tax_classes.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_class := item_1.val
					var_options.array_set(rt.call_function('sanitize_title', [var_class.dup()]), rt.call_function('esc_html', [var_class.dup()]))
				}
			}
		}
		{
			mut iter_1 := var_options.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				print('<option value="' + (rt.call_function('esc_attr', [var_key.dup()])).str() + '">' + (rt.call_function('esc_html', [var_value.dup()])).str() + '</option>')
			}
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wc_product_weight_enabled', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Weight'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		var_options = rt.create_array([rt.ArrayItem{ key: '', val: rt.call_function('__', [rt.new_string('— No change —'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: '1', val: rt.call_function('__', [rt.new_string('Change to:'), rt.new_string('woocommerce')]) }])
		{
			mut iter_1 := var_options.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				print('<option value="' + (rt.call_function('esc_attr', [var_key.dup()])).str() + '">' + (rt.call_function('esc_html', [var_value.dup()])).str() + '</option>')
			}
		}
		// unsupported statement: Stmt_InlineHTML
		mut var_placeholder := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s (%2$s)'), rt.new_string('woocommerce')]), rt.call_function('wc_format_localized_decimal', [rt.new_int(0)]), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_I18nUtil{}; return temp.get_weight_unit_label(arg_0) }(rt.call_function('get_option', [rt.new_string('woocommerce_weight_unit'), rt.new_string('kg')]))])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_placeholder.dup()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wc_product_dimensions_enabled', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('L/W/H'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		var_options = rt.create_array([rt.ArrayItem{ key: '', val: rt.call_function('__', [rt.new_string('— No change —'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: '1', val: rt.call_function('__', [rt.new_string('Change to:'), rt.new_string('woocommerce')]) }])
		{
			mut iter_1 := var_options.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				print('<option value="' + (rt.call_function('esc_attr', [var_key.dup()])).str() + '">' + (rt.call_function('esc_html', [var_value.dup()])).str() + '</option>')
			}
		}
		// unsupported statement: Stmt_InlineHTML
		mut var_dimension_unit_label := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_I18nUtil{}; return temp.get_dimensions_unit_label(arg_0) }(rt.call_function('get_option', [rt.new_string('woocommerce_dimension_unit'), rt.new_string('cm')]))
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('esc_attr__', [rt.new_string('Length (%s)'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_dimension_unit_label.dup()])])
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('esc_attr__', [rt.new_string('Width (%s)'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_dimension_unit_label.dup()])])
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('esc_attr__', [rt.new_string('Height (%s)'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_dimension_unit_label.dup()])])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Shipping class'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('— No change —'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [, ])
	// unsupported statement: Stmt_InlineHTML
}
