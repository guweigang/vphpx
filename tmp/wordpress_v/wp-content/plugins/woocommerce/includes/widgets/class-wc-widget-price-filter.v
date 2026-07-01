import rt

struct Class_WC_Widget_Price_Filter {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Widget_Price_Filter) construct()  {
	this.dispatch_set_prop('widget_cssclass', rt.new_string('woocommerce widget_price_filter'))
	this.dispatch_set_prop('widget_description', rt.call_function('__', [rt.new_string('Display a slider to filter products in your store by price.'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('widget_id', rt.new_string('woocommerce_price_filter'))
	this.dispatch_set_prop('widget_name', rt.call_function('__', [rt.new_string('Filter Products by Price'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('settings', rt.create_array([rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'std', val: rt.call_function('__', [rt.new_string('Filter by price'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Title'), rt.new_string('woocommerce')]) }]) }]))
	mut var_suffix := rt.new_string(if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('SCRIPT_DEBUG'))) { rt.new_string('') } else { rt.new_string('.min') })
	mut var_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))
	rt.call_function('wp_register_script', [rt.new_string('wc-accounting'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/js/accounting/accounting' + (var_suffix).str() + '.js', rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]), rt.new_string('0.4.2'), rt.new_bool(true)])
	rt.call_function('wp_register_script', [rt.new_string('accounting'), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: none, val: 'wc-accounting' }]), rt.new_string('0.4.2'), rt.new_bool(true)])
	rt.call_function('wp_register_script', [rt.new_string('wc-jquery-ui-touchpunch'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/js/jquery-ui-touch-punch/jquery-ui-touch-punch' + (var_suffix).str() + '.js', rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-slider' }]), var_version.dup(), rt.new_bool(true)])
	rt.call_function('wp_register_script', [rt.new_string('wc-price-slider'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/js/frontend/price-slider' + (var_suffix).str() + '.js', rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-slider' }, rt.ArrayItem{ key: none, val: 'wc-jquery-ui-touchpunch' }, rt.ArrayItem{ key: none, val: 'wc-accounting' }]), var_version.dup(), rt.new_bool(true)])
	rt.call_function('wp_localize_script', [rt.new_string('wc-price-slider'), rt.new_string('woocommerce_price_slider_params'), rt.create_array([rt.ArrayItem{ key: 'currency_format_num_decimals', val: 0 }, rt.ArrayItem{ key: 'currency_format_symbol', val: rt.call_function('get_woocommerce_currency_symbol', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'currency_format_decimal_sep', val: rt.call_function('esc_attr', [rt.call_function('wc_get_price_decimal_separator', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'currency_format_thousand_sep', val: rt.call_function('esc_attr', [rt.call_function('wc_get_price_thousand_separator', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'currency_format', val: rt.call_function('esc_attr', [rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '%1$s' }, rt.ArrayItem{ key: none, val: '%2$s' }]), rt.create_array([rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%v' }]), rt.call_function('get_woocommerce_price_format', []rt.PhpVal{})])]) }])])
	if rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{})) {
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-price-slider')])
	}
	this.Class_WC_Widget.construct()
}

fn (mut this Class_WC_Widget_Price_Filter) widget(var_args rt.PhpVal, var_instance rt.PhpVal)  {
	mut var_wp := rt.new_null()
	mut var_args_mutated := var_args
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.call_function('version_compare', [rt.call_function('get_option', [rt.new_string('woocommerce_db_version'), rt.new_null()]), rt.new_string('3.6'), rt.new_string('<')])) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_shop', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_product_taxonomy', []rt.PhpVal{}))))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_main_query', []rt.PhpVal{}), 'post_count'))))) && !(rt.get_superglobal('_GET').array_isset(rt.new_string('min_price'))))) && !(rt.get_superglobal('_GET').array_isset(rt.new_string('max_price'))))) {
		return rt.new_null()
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-price-slider')])
	mut var_step := rt.call_function('max', [rt.call_function('apply_filters', [rt.new_string('woocommerce_price_filter_widget_step'), rt.new_int(10)]), rt.new_int(1)])
	mut var_prices := this.get_filtered_price()
	mut var_min_price := rt.get_property(var_prices, 'min_price')
	mut var_max_price := rt.get_property(var_prices, 'max_price')
	mut var_tax_display_mode := rt.call_function('get_option', [rt.new_string('woocommerce_tax_display_shop')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{}))))))) && rt.is_true(rt.identical(rt.new_string('incl'), var_tax_display_mode)))) {
		mut var_tax_class := rt.call_function('apply_filters', [rt.new_string('woocommerce_price_filter_widget_tax_class'), rt.new_string('')])
		mut var_tax_rates := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.get_rates(arg_0) }(var_tax_class.dup())
		if rt.is_true(var_tax_rates) {
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported expression: Expr_AssignOp_Plus
		}
	}
	var_min_price = rt.call_function('apply_filters', [rt.new_string('woocommerce_price_filter_widget_min_amount'), rt.mul(rt.call_function('floor', [rt.div(var_min_price, var_step)]), var_step)])
	var_max_price = rt.call_function('apply_filters', [rt.new_string('woocommerce_price_filter_widget_max_amount'), rt.mul(rt.call_function('ceil', [rt.div(var_max_price, var_step)]), var_step)])
	if rt.is_true(rt.identical(var_min_price, var_max_price)) {
		return rt.new_null()
	}
	mut var_current_min_price := if rt.get_superglobal('_GET').array_isset(rt.new_string('min_price')) { rt.mul(rt.call_function('floor', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('min_price')]).to_f64() / var_step]), var_step) } else { var_min_price }
	mut var_current_max_price := if rt.get_superglobal('_GET').array_isset(rt.new_string('max_price')) { rt.mul(rt.call_function('ceil', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('max_price')]).to_f64() / var_step]), var_step) } else { var_max_price }
	this.widget_start(var_args_mutated.dup(), var_instance.dup())
	if rt.is_true(rt.identical(rt.new_string(''), rt.call_function('get_option', [rt.new_string('permalink_structure')]))) {
		mut var_form_action := rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'paged' }, rt.ArrayItem{ key: none, val: 'product-page' }]), rt.call_function('add_query_arg', [rt.get_property(var_wp, 'query_string'), rt.new_string(''), rt.call_function('home_url', [rt.get_property(var_wp, 'request')])])])
	} else {
		var_form_action = rt.call_function('preg_replace', [rt.new_string('%\\/page/[0-9]+%'), rt.new_string(''), rt.call_function('home_url', [rt.call_function('trailingslashit', [rt.get_property(var_wp, 'request')])])])
	}
	rt.call_function('wc_get_template', [rt.new_string('content-widget-price-filter.php'), rt.create_array([rt.ArrayItem{ key: 'form_action', val: var_form_action }, rt.ArrayItem{ key: 'step', val: var_step }, rt.ArrayItem{ key: 'min_price', val: var_min_price }, rt.ArrayItem{ key: 'max_price', val: var_max_price }, rt.ArrayItem{ key: 'current_min_price', val: var_current_min_price }, rt.ArrayItem{ key: 'current_max_price', val: var_current_max_price }])])
	this.widget_end(var_args_mutated.dup())
}

fn (mut this Class_WC_Widget_Price_Filter) get_filtered_price() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_args := rt.get_property(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_main_query', []rt.PhpVal{}), 'query_vars')
	mut var_tax_query := if var_args.array_isset(rt.new_string('tax_query')) { var_args.array_get('tax_query') } else { rt.new_array() }
	mut var_meta_query := if var_args.array_isset(rt.new_string('meta_query')) { var_args.array_get('meta_query') } else { rt.new_array() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_type_archive', [rt.new_string('product')]))))) && !(!rt.is_true(var_args.array_get('taxonomy'))))) && !(!rt.is_true(var_args.array_get('term'))))) {
		var_tax_query.array_push(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_main_tax_query', []rt.PhpVal{}))
	}
	{
		mut iter_1 := rt.add(var_meta_query, var_tax_query).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_query := item_1.val
			mut var_key := item_1.key
			if !(!rt.is_true(var_query.array_get('price_filter'))) || !(!rt.is_true(var_query.array_get('rating_filter'))) {
				var_meta_query.array_unset(var_key)
			}
		}
	}
	var_meta_query = create_wp_meta_query(var_meta_query.dup())
	var_tax_query = create_wp_tax_query(var_tax_query.dup())
	mut var_search := fn () rt.PhpVal { mut temp := Class_WC_Query{}; return temp.get_main_search_query_sql() }()
	mut var_meta_query_sql := rt.call_method(var_meta_query, 'get_sql', [rt.new_string('post'), rt.get_property(var_wpdb, 'posts'), rt.new_string('ID')])
	mut var_tax_query_sql := rt.call_method(var_tax_query, 'get_sql', [rt.get_property(var_wpdb, 'posts'), rt.new_string('ID')])
	mut var_search_query_sql := rt.new_string(if rt.is_true(var_search) { ' AND ' + (var_search).str() } else { rt.new_string('') })
	mut var_sql := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT min( min_price ) as min_price, MAX( max_price ) as max_price\n\t\t\tFROM '), rt.get_property(var_wpdb, 'wc_product_meta_lookup')), rt.new_string('\n\t\t\tWHERE product_id IN (\n\t\t\t\tSELECT ID FROM ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('\n\t\t\t\t')) + (var_tax_query_sql.array_get('join')).str() + (var_meta_query_sql.array_get('join')).str() + rt.concat(rt.concat(rt.new_string('\n\t\t\t\tWHERE '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_type IN (\'')) + (rt.call_function('implode', [rt.new_string('\',\''), rt.call_function('array_map', [rt.new_string('esc_sql'), rt.call_function('apply_filters', [rt.new_string('woocommerce_price_filter_post_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'product' }])])])])).str() + rt.concat(rt.concat(rt.new_string('\')\n\t\t\t\tAND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_status = \'publish\'\n\t\t\t\t')) + (var_tax_query_sql.array_get('where')).str() + (var_meta_query_sql.array_get('where')).str() + (var_search_query_sql).str() + '\n\t\t\t)')
	var_sql = rt.call_function('apply_filters', [rt.new_string('woocommerce_price_filter_sql'), var_sql.dup(), var_meta_query_sql.dup(), var_tax_query_sql.dup()])
	return rt.call_method(var_wpdb, 'get_row', [var_sql.dup()])
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

struct Class_WC_Widget {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_WP_Meta_Query {
	rt.PhpObjectBase
}

struct Class_WP_Tax_Query {
	rt.PhpObjectBase
}

struct Class_WC_Query {
	rt.PhpObjectBase
}

fn create_wc_widget_price_filter() &Class_WC_Widget_Price_Filter {
	mut obj := &Class_WC_Widget_Price_Filter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_widget() &Class_WC_Widget {
	mut obj := &Class_WC_Widget{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tax() &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_meta_query() &Class_WP_Meta_Query {
	mut obj := &Class_WP_Meta_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_tax_query() &Class_WP_Tax_Query {
	mut obj := &Class_WP_Tax_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_query() &Class_WC_Query {
	mut obj := &Class_WC_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Widget_Price_Filter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.widget(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_filtered_price' {
			return this.get_filtered_price()
		}
		else { return none }
	}
}

fn (this &Class_WC_Widget_Price_Filter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Widget_Price_Filter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Widget) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Widget) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Widget) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_WP_Meta_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Meta_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Meta_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Tax_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Tax_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Tax_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_widgets_class_wc_widget_price_filter_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
