import rt

struct Class_WC_Admin_List_Table_Products {
	rt.PhpObjectBase
pub mut:
	list_table_type        rt.PhpVal = rt.new_string('product')
	cogs_is_enabled        rt.PhpVal = rt.new_null()
	use_cogs_lookup_column bool
}

fn (mut this Class_WC_Admin_List_Table_Products) construct() {
	this.Class_WC_Admin_List_Table.construct()
	rt.call_function('add_filter', [rt.new_string('disable_months_dropdown'),
		rt.new_string('__return_true')])
	rt.call_function('add_filter', [rt.new_string('query_vars'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
				'WC_Admin_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'add_custom_query_var' },
		])])
	rt.call_function('add_filter', [rt.new_string('views_edit-product'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
				'WC_Admin_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'product_views' },
		])])
	rt.call_function('add_filter', [rt.new_string('get_search_query'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
				'WC_Admin_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'search_label' },
		])])
	rt.call_function('add_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
				'WC_Admin_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'posts_clauses' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('manage_product_posts_custom_column'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
				'WC_Admin_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'add_sample_product_badge' },
		]),
		rt.new_int(9), rt.new_int(2)])
	mut var_cogs_controller := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class(),
	])
	this.cogs_is_enabled = rt.call_method(var_cogs_controller, 'feature_is_enabled', []rt.PhpVal{})
	this.use_cogs_lookup_column = rt.is_true(this.cogs_is_enabled)
		&& rt.is_true(rt.call_method(var_cogs_controller, 'product_meta_lookup_table_cogs_value_columns_exist', []rt.PhpVal{}))
}

fn (mut this Class_WC_Admin_List_Table_Products) render_blank_state() {
	print('<div class="woocommerce-BlankState">')
	print('<h2 class="woocommerce-BlankState-message">' +
		(rt.call_function('esc_html__', [rt.new_string('Ready to start selling something awesome?'), rt.new_string('woocommerce')])).str() +
		'</h2>')
	print('<div class="woocommerce-BlankState-buttons">')
	print('<a class="woocommerce-BlankState-cta button-primary button" href="' +
		(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('post-new.php?post_type=product&tutorial=true')])])).str() +
		'">' +
		(rt.call_function('esc_html__', [rt.new_string('Create Product'), rt.new_string('woocommerce')])).str() +
		'</a>')
	print('<a class="woocommerce-BlankState-cta button" href="' +
		(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('edit.php?post_type=product&page=product_importer')])])).str() +
		'">' +
		(rt.call_function('esc_html__', [rt.new_string('Start Import'), rt.new_string('woocommerce')])).str() +
		'</a>')
	print('</div>')
	print('</div>')
}

fn (mut this Class_WC_Admin_List_Table_Products) get_primary_column() string {
	return 'name'
}

fn (mut this Class_WC_Admin_List_Table_Products) get_row_actions(var_actions rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	return rt.call_function('array_merge', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('ID: %d'),
					rt.new_string('woocommerce')]),
				rt.get_property(var_post, 'ID'),
			]) },
		]),
		var_actions.clone(),
	])
}

fn (mut this Class_WC_Admin_List_Table_Products) define_sortable_columns(var_columns rt.PhpVal) rt.PhpVal {
	mut var_columns_mutated := var_columns
	mut var_custom := {
		'price':            'price'
		'sku':              'sku'
		'name':             'title'
		'global_unique_id': 'global_unique_id'
	}
	if this.use_cogs_lookup_column {
		var_custom['cogs_value'] = 'cogs_value'
	}
	return rt.call_function('wp_parse_args', [
		rt.create_array_from_native_map(var_custom),
		var_columns_mutated.clone(),
	])
}

fn (mut this Class_WC_Admin_List_Table_Products) define_columns(var_columns rt.PhpVal) rt.PhpVal {
	mut var_columns_mutated := var_columns
	if !rt.is_true(var_columns_mutated) && !(var_columns_mutated.clone().is_array()) {
		var_columns_mutated = rt.new_array()
	}
	var_columns_mutated.array_unset(rt.new_string('title'))
	var_columns_mutated.array_unset(rt.new_string('comments'))
	var_columns_mutated.array_unset(rt.new_string('date'))
	mut var_show_columns := rt.new_array()
	var_show_columns['cb'] = rt.new_string('<input type="checkbox" />')
	var_show_columns['thumb'] = '<span class="wc-image tips" data-tip="' +
		(rt.call_function('esc_attr__', [rt.new_string('Image'), rt.new_string('woocommerce')])).str() +
		'">' +
		(rt.call_function('__', [rt.new_string('Image'), rt.new_string('woocommerce')])).str() +
		'</span>'
	var_show_columns['name'] = rt.call_function('__', [rt.new_string('Name'),
		rt.new_string('woocommerce')])
	if rt.is_true(rt.call_function('wc_product_sku_enabled', []rt.PhpVal{})) {
		var_show_columns['sku'] = rt.call_function('__', [rt.new_string('SKU'),
			rt.new_string('woocommerce')])
	}
	var_show_columns['global_unique_id'] = rt.call_function('__', [
		rt.new_string('GTIN, UPC, EAN, or ISBN'),
		rt.new_string('woocommerce'),
	])
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_manage_stock'),
	])))
	{
		var_show_columns['is_in_stock'] = rt.call_function('__', [
			rt.new_string('Stock'), rt.new_string('woocommerce')])
	}
	var_show_columns['price'] = rt.call_function('__', [rt.new_string('Price'),
		rt.new_string('woocommerce')])
	if rt.is_true(this.cogs_is_enabled) {
		var_show_columns['cogs_value'] = rt.call_function('__', [
			rt.new_string('Cost'), rt.new_string('woocommerce')])
	}
	var_show_columns['product_cat'] = rt.call_function('__', [
		rt.new_string('Categories'),
		rt.new_string('woocommerce'),
	])
	var_show_columns['product_tag'] = rt.call_function('__', [
		rt.new_string('Tags'), rt.new_string('woocommerce')])
	var_show_columns['featured'] = '<span class="wc-featured parent-tips" data-tip="' +
		(rt.call_function('esc_attr__', [rt.new_string('Featured'), rt.new_string('woocommerce')])).str() +
		'">' +
		(rt.call_function('__', [rt.new_string('Featured'), rt.new_string('woocommerce')])).str() +
		'</span>'
	var_show_columns['date'] = rt.call_function('__', [rt.new_string('Date'),
		rt.new_string('woocommerce')])
	return rt.call_function('array_merge', [
		rt.create_array_from_native_map(var_show_columns),
		var_columns_mutated.clone(),
	])
}

fn (mut this Class_WC_Admin_List_Table_Products) prepare_row_data(var_post_id rt.PhpVal) {
	mut var_the_product := rt.get_superglobal('the_product')
	if !rt.is_true(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_id', []rt.PhpVal{}), var_post_id)))) {
		var_the_product = rt.call_function('wc_get_product', [
			var_post_id.clone()])
		this.dispatch_set_prop('object', var_the_product.clone())
	}
}

fn (mut this Class_WC_Admin_List_Table_Products) render_thumb_column() {
	print('<a href="' +
		(rt.call_function('esc_url', [rt.call_function('get_edit_post_link', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_id', []rt.PhpVal{})])])).str() +
		'">' +
		(rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_image', [rt.new_string('thumbnail')])).str() +
		'</a>')
}

fn (mut this Class_WC_Admin_List_Table_Products) render_name_column() {
	mut var_post := rt.new_null()
	mut var_edit_link := rt.call_function('get_edit_post_link', [
		rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', [
			'WC_Admin_List_Table',
		], &this), 'object'), 'get_id', []rt.PhpVal{}),
	])
	mut var_title := rt.call_function('_draft_or_post_title', []rt.PhpVal{})
	print('<strong><a class="row-title" href="' +
		(rt.call_function('esc_url', [var_edit_link.clone()])).str() + '">' +
		(rt.call_function('esc_html', [var_title.clone()])).str() + '</a>')
	rt.call_function('_post_states', [var_post.clone()])
	print('</strong>')
	if rt.is_true(rt.greater(rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', [
		'WC_Admin_List_Table',
	], &this), 'object'), 'get_parent_id', []rt.PhpVal{}), rt.new_int(0)))
	{
		print('&nbsp;&nbsp;&larr; <a href="' +
			(rt.call_function('esc_url', [rt.call_function('get_edit_post_link', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_parent_id', []rt.PhpVal{})])])).str() +
			'">' +
			(rt.call_function('get_the_title', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_parent_id', []rt.PhpVal{})])).str() +
			'</a>')
	}
	rt.call_function('get_inline_data', [var_post.clone()])
	mut var_cogs_value_html := rt.new_string((if rt.is_true(this.cogs_is_enabled) {
			'<div class="cogs_value">' +
			(rt.call_function('esc_html', [if !(rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_cogs_value', []rt.PhpVal{})).is_null() { rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_cogs_value', []rt.PhpVal{}) } else { rt.new_string('0') }])).str() +
			'</div>'
	 } else { ''
	 }).str())
	print('\n\t\t\t<div class="hidden" id="woocommerce_inline_' +
		(rt.call_function('absint', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_id', []rt.PhpVal{})])).str() +
		'">\n\t\t\t\t<div class="menu_order">' +
		(rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_menu_order', []rt.PhpVal{})])).str() +
		'</div>\n\t\t\t\t<div class="sku">' +
		(rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_sku', []rt.PhpVal{})])).str() +
		'</div>\n\t\t\t\t<div class="global_unique_id">' +
		(rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_global_unique_id', []rt.PhpVal{})])).str() +
		'</div>\n\t\t\t\t<div class="regular_price">' +
		(rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_regular_price', []rt.PhpVal{})])).str() +
		'</div>\n\t\t\t\t<div class="sale_price">' +
		(rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_sale_price', []rt.PhpVal{})])).str() +
		'</div>\n\t\t\t\t<div class="weight">' +
		(rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_weight', []rt.PhpVal{})])).str() +
		'</div>\n\t\t\t\t<div class="length">' +
		(rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_length', []rt.PhpVal{})])).str() +
		'</div>\n\t\t\t\t<div class="width">' +
		(rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_width', []rt.PhpVal{})])).str() +
		'</div>\n\t\t\t\t<div class="height">' +
		(rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_height', []rt.PhpVal{})])).str() +
		'</div>\n\t\t\t\t<div class="shipping_class">' +
		(rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_shipping_class', []rt.PhpVal{})])).str() +
		'</div>\n\t\t\t\t<div class="visibility">' +
		(rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_catalog_visibility', []rt.PhpVal{})])).str() +
		'</div>\n\t\t\t\t<div class="stock_status">' +
		(rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_stock_status', []rt.PhpVal{})])).str() +
		'</div>\n\t\t\t\t<div class="stock">' +
		(rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_stock_quantity', []rt.PhpVal{})])).str() +
		'</div>\n\t\t\t\t<div class="manage_stock">' +
		(rt.call_function('esc_html', [rt.call_function('wc_bool_to_string', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_manage_stock', []rt.PhpVal{})])])).str() +
		'</div>\n\t\t\t\t<div class="featured">' +
		(rt.call_function('esc_html', [rt.call_function('wc_bool_to_string', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_featured', []rt.PhpVal{})])])).str() +
		'</div>\n\t\t\t\t<div class="product_type">' +
		(rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_type', []rt.PhpVal{})])).str() +
		'</div>\n\t\t\t\t<div class="product_is_virtual">' +
		(rt.call_function('esc_html', [rt.call_function('wc_bool_to_string', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_virtual', []rt.PhpVal{})])])).str() +
		'</div>\n\t\t\t\t<div class="tax_status">' +
		(rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_tax_status', []rt.PhpVal{})])).str() +
		'</div>\n\t\t\t\t<div class="tax_class">' +
		(rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_tax_class', []rt.PhpVal{})])).str() +
		'</div>\n\t\t\t\t<div class="backorders">' +
		(rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_backorders', []rt.PhpVal{})])).str() +
		'</div>\n\t\t\t\t<div class="low_stock_amount">' +
		(rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_low_stock_amount', []rt.PhpVal{})])).str() +
		'</div>' + var_cogs_value_html.str() + '</div>')
}

fn (mut this Class_WC_Admin_List_Table_Products) render_sku_column() {
	rt.echo_val(if rt.is_true(rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', [
		'WC_Admin_List_Table',
	], &this), 'object'), 'get_sku', []rt.PhpVal{}))
	{ rt.call_function('esc_html', [
			rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', [
				'WC_Admin_List_Table',
			], &this), 'object'), 'get_sku', []rt.PhpVal{}),
		]) } else { rt.new_string('<span class="na">&ndash;</span>') })
}

fn (mut this Class_WC_Admin_List_Table_Products) render_global_unique_id_column() {
	rt.echo_val(if rt.is_true(rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', [
		'WC_Admin_List_Table',
	], &this), 'object'), 'get_global_unique_id', []rt.PhpVal{}))
	{ rt.call_function('esc_html', [
			rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', [
				'WC_Admin_List_Table',
			], &this), 'object'), 'get_global_unique_id', []rt.PhpVal{}),
		]) } else { rt.new_string('<span class="na">&ndash;</span>') })
}

fn (mut this Class_WC_Admin_List_Table_Products) render_price_column() {
	mut var_html := rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', [
		'WC_Admin_List_Table',
	], &this), 'object'), 'get_price_html', []rt.PhpVal{})
	rt.echo_val(if rt.is_true(var_html) { rt.call_function('wp_kses_post', [
			var_html.clone()]) } else { rt.new_string('<span class="na">&ndash;</span>') })
}

fn (mut this Class_WC_Admin_List_Table_Products) render_cogs_value_column() {
	mut var_html := rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', [
		'WC_Admin_List_Table',
	], &this), 'object'), 'get_cogs_value_html', []rt.PhpVal{})
	rt.echo_val(if rt.is_true(var_html) { rt.call_function('wp_kses_post', [
			var_html.clone()]) } else { rt.new_string('<span class="na">&ndash;</span>') })
}

fn (mut this Class_WC_Admin_List_Table_Products) render_product_cat_column() {
	mut var_terms := rt.call_function('get_the_terms', [
		rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', [
			'WC_Admin_List_Table',
		], &this), 'object'), 'get_id', []rt.PhpVal{}),
		rt.new_string('product_cat'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_terms)))) {
		print('<span class="na">&ndash;</span>')
	} else {
		mut var_termlist := rt.new_array()
		mut iter_1 := var_terms.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			var_termlist << '<a href="' +
				(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('edit.php?product_cat=' + (rt.get_property(var_term, 'slug')).str() +
				'&post_type=product')])])).str() + '">' +
				(rt.call_function('esc_html', [rt.get_property(var_term, 'name')])).str() + '</a>'
		}
		rt.echo_val(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_admin_product_term_list'),
			rt.call_function('implode', [rt.new_string(', '),
				rt.create_array_from_list(var_termlist)]),
			rt.new_string('product_cat'),
			rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', [
				'WC_Admin_List_Table'], &this), 'object'), 'get_id', []rt.PhpVal{}),
			rt.create_array_from_list(var_termlist),
			var_terms.clone(),
		]))
	}
}

fn (mut this Class_WC_Admin_List_Table_Products) render_product_tag_column() {
	mut var_terms := rt.call_function('get_the_terms', [
		rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', [
			'WC_Admin_List_Table',
		], &this), 'object'), 'get_id', []rt.PhpVal{}),
		rt.new_string('product_tag'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_terms)))) {
		print('<span class="na">&ndash;</span>')
	} else {
		mut var_termlist := rt.new_array()
		mut iter_2 := var_terms.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_term := item_2.val
			var_termlist << '<a href="' +
				(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('edit.php?product_tag=' + (rt.get_property(var_term, 'slug')).str() +
				'&post_type=product')])])).str() + '">' +
				(rt.call_function('esc_html', [rt.get_property(var_term, 'name')])).str() + '</a>'
		}
		rt.echo_val(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_admin_product_term_list'),
			rt.call_function('implode', [rt.new_string(', '),
				rt.create_array_from_list(var_termlist)]),
			rt.new_string('product_tag'),
			rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', [
				'WC_Admin_List_Table'], &this), 'object'), 'get_id', []rt.PhpVal{}),
			rt.create_array_from_list(var_termlist),
			var_terms.clone(),
		]))
	}
}

fn (mut this Class_WC_Admin_List_Table_Products) render_featured_column() {
	mut var_url := rt.call_function('wp_nonce_url', [
		rt.call_function('admin_url', [
			rt.new_string('admin-ajax.php?action=woocommerce_feature_product&product_id=' +(rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_id', []rt.PhpVal{})).str()),
		]),
		rt.new_string('woocommerce-feature-product'),
	])
	print('<a href="' + (rt.call_function('esc_url', [var_url.clone()])).str() + '" aria-label="' +
		(rt.call_function('esc_attr__', [rt.new_string('Toggle featured'), rt.new_string('woocommerce')])).str() +
		'">')
	if rt.is_true(rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', [
		'WC_Admin_List_Table',
	], &this), 'object'), 'is_featured', []rt.PhpVal{}))
	{
		print('<span class="wc-featured tips" data-tip="' +
			(rt.call_function('esc_attr__', [rt.new_string('Yes'), rt.new_string('woocommerce')])).str() +
			'">' +
			(rt.call_function('esc_html__', [rt.new_string('Yes'), rt.new_string('woocommerce')])).str() +
			'</span>')
	} else {
		print('<span class="wc-featured not-featured tips" data-tip="' +
			(rt.call_function('esc_attr__', [rt.new_string('No'), rt.new_string('woocommerce')])).str() +
			'">' +
			(rt.call_function('esc_html__', [rt.new_string('No'), rt.new_string('woocommerce')])).str() +
			'</span>')
	}
	print('</a>')
}

fn (mut this Class_WC_Admin_List_Table_Products) render_is_in_stock_column() {
	if rt.is_true(rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', [
		'WC_Admin_List_Table',
	], &this), 'object'), 'is_on_backorder', []rt.PhpVal{}))
	{
		mut var_stock_html := rt.new_string('<mark class="onbackorder">' +
			(rt.call_function('__', [rt.new_string('On backorder'), rt.new_string('woocommerce')])).str() +
			'</mark>')
	} else if rt.is_true(rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', [
		'WC_Admin_List_Table',
	], &this), 'object'), 'is_in_stock', []rt.PhpVal{}))
	{
		var_stock_html = rt.new_string('<mark class="instock">' +
			(rt.call_function('__', [rt.new_string('In stock'), rt.new_string('woocommerce')])).str() +
			'</mark>')
	} else {
		var_stock_html = rt.new_string('<mark class="outofstock">' +
			(rt.call_function('__', [rt.new_string('Out of stock'), rt.new_string('woocommerce')])).str() +
			'</mark>')
	}
	if rt.is_true(rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', [
		'WC_Admin_List_Table',
	], &this), 'object'), 'managing_stock', []rt.PhpVal{}))
	{
		var_stock_html = rt.concat(var_stock_html, rt.new_string(
			' (' + (rt.call_function('wc_stock_amount', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Products', ['WC_Admin_List_Table'], &this), 'object'), 'get_stock_quantity', []rt.PhpVal{})])).str() +
			')'))
	}
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_stock_html'),
			var_stock_html.clone(),
			rt.get_property(rt.new_object('WC_Admin_List_Table_Products', [
				'WC_Admin_List_Table',
			], &this), 'object')]),
	]))
}

fn (mut this Class_WC_Admin_List_Table_Products) add_custom_query_var(var_public_query_vars rt.PhpVal) rt.PhpVal {
	mut var_public_query_vars_mutated := var_public_query_vars
	var_public_query_vars_mutated.array_push('sku')
	return var_public_query_vars_mutated.clone()
}

fn (mut this Class_WC_Admin_List_Table_Products) render_filters() {
	mut var_filters := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_products_admin_list_table_filters'),
		rt.create_array([
			rt.ArrayItem{ key: 'product_category', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
					'WC_Admin_List_Table',
				], &this) },
				rt.ArrayItem{ key: none, val: 'render_products_category_filter' },
			]) },
			rt.ArrayItem{ key: 'product_type', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
					'WC_Admin_List_Table',
				], &this) },
				rt.ArrayItem{ key: none, val: 'render_products_type_filter' },
			]) },
			rt.ArrayItem{ key: 'stock_status', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
					'WC_Admin_List_Table',
				], &this) },
				rt.ArrayItem{ key: none, val: 'render_products_stock_status_filter' },
			]) },
		]),
	])
	rt.call_function('ob_start', []rt.PhpVal{})
	mut iter_3 := var_filters.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_filter_callback := item_3.val
		rt.call_function('call_user_func', [var_filter_callback.clone()])
	}
	mut var_output := rt.call_function('ob_get_clean', []rt.PhpVal{})
	rt.echo_val(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_filters'),
		var_output.clone(),
	]))
}

fn (mut this Class_WC_Admin_List_Table_Products) render_products_category_filter() {
	mut var_categories_count := rt.new_int((rt.call_function('wp_count_terms', [
		rt.new_string('product_cat'),
	])).to_i64())
	if rt.is_true(rt.less_equal(var_categories_count, rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_category_filter_threshold'),
		rt.new_int(100),
	])))
	{
		rt.call_function('wc_product_dropdown_categories', [
			rt.create_array([
				rt.ArrayItem{ key: 'option_select_text', val: rt.call_function('__', [
					rt.new_string('Filter by category'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'hide_empty', val: 0 },
			]),
		])
	} else {
		mut var_current_category_slug := if rt.get_superglobal('_GET').array_isset(rt.new_string('product_cat')) { rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_GET').array_get(rt.new_string('product_cat')),
				]),
			]) } else { rt.new_bool(false) }
		mut var_current_category := if rt.is_true(var_current_category_slug) { rt.call_function('get_term_by', [
				rt.new_string('slug'),
				var_current_category_slug.clone(),
				rt.new_string('product_cat'),
			]) } else { rt.new_bool(false) }
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Filter by category'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_current_category_slug) && rt.is_true(var_current_category) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_current_category_slug.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('htmlspecialchars', [
					rt.call_function('wp_kses_post', [
						rt.get_property(var_current_category, 'name'),
					]),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_WC_Admin_List_Table_Products) render_products_type_filter() {
	mut var_current_product_type := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('product_type')) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('product_type'))]),
		]) } else { rt.new_bool(false) }
	mut var_output := rt.new_string(
		'<select name="product_type" id="dropdown_product_type"><option value="">' +
		(rt.call_function('esc_html__', [rt.new_string('Filter by product type'), rt.new_string('woocommerce')])).str() +
		'</option>')
	mut iter_4 := rt.call_function('wc_get_product_types', []rt.PhpVal{}).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_label := item_4.val
		mut var_value := item_4.key
		var_output = rt.concat(var_output, rt.new_string('<option value="' +
			(rt.call_function('esc_attr', [var_value.clone()])).str() + '" '))
		var_output = rt.concat(var_output, rt.call_function('selected', [
			var_value.clone(), var_current_product_type.clone(),
			rt.new_bool(false)]))
		var_output = rt.concat(var_output, rt.new_string('>' +
			(rt.call_function('esc_html', [var_label.clone()])).str() + '</option>'))
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.simple(),
			var_value))
		{
			var_output = rt.concat(var_output, rt.new_string('<option value="downloadable" '))
			var_output = rt.concat(var_output, rt.call_function('selected', [
				rt.new_string('downloadable'),
				var_current_product_type.clone(),
				rt.new_bool(false),
			]))
			var_output = rt.concat(var_output, rt.new_string('> ' +
				if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { '&larr;' } else { '&rarr;' } +
				' ' +
				(rt.call_function('esc_html__', [rt.new_string('Downloadable'), rt.new_string('woocommerce')])).str() +
				'</option>'))
			var_output = rt.concat(var_output, rt.new_string('<option value="virtual" '))
			var_output = rt.concat(var_output, rt.call_function('selected', [
				rt.new_string('virtual'),
				var_current_product_type.clone(),
				rt.new_bool(false),
			]))
			var_output = rt.concat(var_output, rt.new_string('> ' +
				if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { '&larr;' } else { '&rarr;' } +
				' ' +
				(rt.call_function('esc_html__', [rt.new_string('Virtual'), rt.new_string('woocommerce')])).str() +
				'</option>'))
		}
	}
	var_output = rt.concat(var_output, rt.new_string('</select>'))
	rt.echo_val(var_output)
}

fn (mut this Class_WC_Admin_List_Table_Products) render_products_stock_status_filter() {
	mut var_current_stock_status := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('stock_status')) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('stock_status'))]),
		]) } else { rt.new_bool(false) }
	mut var_stock_statuses := rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})
	mut var_output := rt.new_string('<select name="stock_status"><option value="">' +
		(rt.call_function('esc_html__', [rt.new_string('Filter by stock status'), rt.new_string('woocommerce')])).str() +
		'</option>')
	mut iter_5 := var_stock_statuses.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_label := item_5.val
		mut var_status := item_5.key
		var_output = rt.concat(var_output, rt.new_string('<option ' +
			(rt.call_function('selected', [var_status.clone(), var_current_stock_status.clone(), rt.new_bool(false)])).str() +
			' value="' + (rt.call_function('esc_attr', [var_status.clone()])).str() + '">' +
			(rt.call_function('esc_html', [var_label.clone()])).str() + '</option>'))
	}
	var_output = rt.concat(var_output, rt.new_string('</select>'))
	rt.echo_val(var_output)
}

fn (mut this Class_WC_Admin_List_Table_Products) sku_search(var_where rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Admin_List_Table_Products::sku_search'),
		rt.new_string('4.4.0'),
		rt.new_string('Logic moved to query_filters.'),
	])
	return var_where.clone()
}

fn (mut this Class_WC_Admin_List_Table_Products) product_views(var_views rt.PhpVal) rt.PhpVal {
	mut var_wp_query := rt.new_null()
	mut var_views_mutated := var_views
	var_views_mutated.array_unset(rt.new_string('mine'))
	if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_others_products'),
	]))
	{
		mut var_class := rt.new_string((if
			rt.get_property(var_wp_query, 'query').array_isset(rt.new_string('orderby'))
			&& rt.is_true(rt.identical(rt.new_string('menu_order title'), rt.get_property(var_wp_query, 'query').array_get(rt.new_string('orderby')))) {
			'current'
		} else {
			''
		}).str())
		mut var_query_string := rt.call_function('remove_query_arg', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'orderby' },
				rt.ArrayItem{ key: none, val: 'order' }]),
		])
		var_query_string = rt.call_function('add_query_arg', [
			rt.new_string('orderby'),
			rt.call_function('rawurlencode', [
				rt.new_string('menu_order title'),
			]),
			var_query_string.clone()])
		var_query_string = rt.call_function('add_query_arg', [
			rt.new_string('order'), rt.call_function('rawurlencode', [
				rt.new_string('ASC'),
			]),
			var_query_string.clone()])
		var_views_mutated.array_set('byorder', '<a href="' +
			(rt.call_function('esc_url', [var_query_string.clone()])).str() + '" class="' +
			(rt.call_function('esc_attr', [var_class.clone()])).str() + '">' +
			(rt.call_function('__', [rt.new_string('Sorting'), rt.new_string('woocommerce')])).str() +
			'</a>')
	}
	return var_views_mutated.clone()
}

fn (mut this Class_WC_Admin_List_Table_Products) search_label(var_query rt.PhpVal) rt.PhpVal {
	mut var_pagenow := rt.new_null()
	mut var_typenow := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('edit.php'), var_pagenow))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), var_typenow))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_query_var', [rt.new_string('product_search')])))))
		|| !(rt.get_superglobal('_GET').array_isset(rt.new_string('s'))) {
		return var_query.clone()
	}
	return rt.call_function('wc_clean', [
		rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('s'))]),
	])
	return rt.new_null()
}

fn (mut this Class_WC_Admin_List_Table_Products) query_filters(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_query_vars_mutated := var_query_vars
	this.remove_ordering_args(rt.new_null())
	if var_query_vars_mutated.array_isset(rt.new_string('orderby')) {
		mut var_orderby :=
			rt.new_string(var_query_vars_mutated.array_get(rt.new_string('orderby')).to_string().to_lower())
		mut var_order := rt.new_string((if var_query_vars_mutated.array_isset(rt.new_string('order')) {
			var_query_vars_mutated.array_get(rt.new_string('order')).to_string().to_upper()
		} else {
			'DESC'
		}).str())
		if rt.is_true(rt.identical(rt.new_string('price'), var_orderby)) {
			mut var_callback := rt.new_string((if rt.is_true(rt.identical(rt.new_string('DESC'),
				var_order))
			{
				'order_by_price_desc_post_clauses'
			} else {
				'order_by_price_asc_post_clauses'
			}).str())
			rt.call_function('add_filter', [rt.new_string('posts_clauses'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
						'WC_Admin_List_Table',
					], &this) },
					rt.ArrayItem{ key: none, val: var_callback },
				])])
		}
		if rt.is_true(rt.identical(rt.new_string('sku'), var_orderby)) {
			var_callback = rt.new_string((if rt.is_true(rt.identical(rt.new_string('DESC'),
				var_order))
			{
				'order_by_sku_desc_post_clauses'
			} else {
				'order_by_sku_asc_post_clauses'
			}).str())
			rt.call_function('add_filter', [rt.new_string('posts_clauses'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
						'WC_Admin_List_Table',
					], &this) },
					rt.ArrayItem{ key: none, val: var_callback },
				])])
		}
		if rt.is_true(rt.identical(rt.new_string('cogs_value'), var_orderby))
			&& this.use_cogs_lookup_column {
			var_callback = rt.new_string((if rt.is_true(rt.identical(rt.new_string('DESC'),
				var_order))
			{
				'order_by_cogs_value_desc_post_clauses'
			} else {
				'order_by_cogs_value_asc_post_clauses'
			}).str())
			rt.call_function('add_filter', [rt.new_string('posts_clauses'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
						'WC_Admin_List_Table',
					], &this) },
					rt.ArrayItem{ key: none, val: var_callback },
				])])
		}
		if rt.is_true(rt.identical(rt.new_string('global_unique_id'), var_orderby)) {
			var_callback = rt.new_string((if rt.is_true(rt.identical(rt.new_string('DESC'),
				var_order))
			{
				'order_by_global_unique_id_desc_post_clauses'
			} else {
				'order_by_global_unique_id_asc_post_clauses'
			}).str())
			rt.call_function('add_filter', [rt.new_string('posts_clauses'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
						'WC_Admin_List_Table',
					], &this) },
					rt.ArrayItem{ key: none, val: var_callback },
				])])
		}
	}
	if var_query_vars_mutated.array_isset(rt.new_string('product_type')) {
		if rt.is_true(rt.identical(rt.new_string('downloadable'),
			var_query_vars_mutated.array_get(rt.new_string('product_type'))))
		{
			var_query_vars_mutated.array_set('product_type', '')
			rt.call_function('add_filter', [rt.new_string('posts_clauses'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
						'WC_Admin_List_Table',
					], &this) },
					rt.ArrayItem{ key: none, val: 'filter_downloadable_post_clauses' },
				])])
		} else if rt.is_true(rt.identical(rt.new_string('virtual'),
			var_query_vars_mutated.array_get(rt.new_string('product_type'))))
		{
			var_query_vars_mutated.array_set('product_type', '')
			rt.call_function('add_filter', [rt.new_string('posts_clauses'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
						'WC_Admin_List_Table',
					], &this) },
					rt.ArrayItem{ key: none, val: 'filter_virtual_post_clauses' },
				])])
		}
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('stock_status')))) {
		rt.call_function('add_filter', [rt.new_string('posts_clauses'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
					'WC_Admin_List_Table',
				], &this) },
				rt.ArrayItem{ key: none, val: 'filter_stock_status_post_clauses' },
			])])
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('product_shipping_class')))) {
		var_query_vars_mutated.array_get_mut('tax_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: 'product_shipping_class' },
			rt.ArrayItem{ key: 'field', val: 'slug' },
			rt.ArrayItem{ key: 'terms', val: rt.call_function('sanitize_title', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_GET').array_get(rt.new_string('product_shipping_class')),
				]),
			]) },
			rt.ArrayItem{ key: 'operator', val: 'IN' },
		]))
	}
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('s')))) {
		mut iife_temp_0 := Class_WC_Data_Store{}
		mut iife_result_0 := iife_temp_0.load(rt.new_string('product'))
		mut var_data_store := iife_result_0
		mut var_ids := rt.call_method(var_data_store, 'search_products', [
			rt.call_function('wc_clean', [
				rt.call_function('wp_unslash',
					[var_query_vars_mutated.array_get(rt.new_string('s'))]),
			]),
			rt.new_string(''),
			rt.new_bool(true),
			rt.new_bool(true),
		])
		var_query_vars_mutated.array_set('post__in', rt.call_function('array_merge', [
			var_ids.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 0 }]),
		]))
		var_query_vars_mutated.array_set('product_search', true)
		var_query_vars_mutated.array_unset(rt.new_string('s'))
	}
	return var_query_vars_mutated.clone()
}

fn (mut this Class_WC_Admin_List_Table_Products) posts_clauses(var_args rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Admin_List_Table_Products) remove_ordering_args(var_posts rt.PhpVal) rt.PhpVal {
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
				'WC_Admin_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'order_by_price_asc_post_clauses' },
		])])
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
				'WC_Admin_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'order_by_price_desc_post_clauses' },
		])])
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
				'WC_Admin_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'order_by_sku_asc_post_clauses' },
		])])
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
				'WC_Admin_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'order_by_sku_desc_post_clauses' },
		])])
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
				'WC_Admin_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'order_by_global_unique_id_asc_post_clauses' },
		])])
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
				'WC_Admin_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'order_by_global_unique_id_desc_post_clauses' },
		])])
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
				'WC_Admin_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'filter_downloadable_post_clauses' },
		])])
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
				'WC_Admin_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'filter_virtual_post_clauses' },
		])])
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
				'WC_Admin_List_Table',
			], &this) },
			rt.ArrayItem{ key: none, val: 'filter_stock_status_post_clauses' },
		])])
	if this.use_cogs_lookup_column {
		rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
					'WC_Admin_List_Table',
				], &this) },
				rt.ArrayItem{ key: none, val: 'order_by_cogs_value_asc_post_clauses' },
			])])
		rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table_Products', [
					'WC_Admin_List_Table',
				], &this) },
				rt.ArrayItem{ key: none, val: 'order_by_cogs_value_desc_post_clauses' },
			])])
	}
	return var_posts.clone()
	return rt.new_null()
}

fn (mut this Class_WC_Admin_List_Table_Products) order_by_price_asc_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('join',
		this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
	var_args_mutated.array_set('orderby',
		' wc_product_meta_lookup.min_price ASC, wc_product_meta_lookup.product_id ASC ')
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Admin_List_Table_Products) order_by_price_desc_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('join',
		this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
	var_args_mutated.array_set('orderby',
		' wc_product_meta_lookup.max_price DESC, wc_product_meta_lookup.product_id DESC ')
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Admin_List_Table_Products) order_by_sku_asc_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('join',
		this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
	var_args_mutated.array_set('orderby',
		' wc_product_meta_lookup.sku ASC, wc_product_meta_lookup.product_id ASC ')
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Admin_List_Table_Products) order_by_sku_desc_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('join',
		this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
	var_args_mutated.array_set('orderby',
		' wc_product_meta_lookup.sku DESC, wc_product_meta_lookup.product_id DESC ')
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Admin_List_Table_Products) order_by_cogs_value_asc_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('join',
		this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
	var_args_mutated.array_set('orderby',
		' wc_product_meta_lookup.cogs_total_value ASC, wc_product_meta_lookup.product_id ASC ')
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Admin_List_Table_Products) order_by_cogs_value_desc_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('join',
		this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
	var_args_mutated.array_set('orderby',
		' wc_product_meta_lookup.cogs_total_value DESC, wc_product_meta_lookup.product_id DESC ')
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Admin_List_Table_Products) order_by_global_unique_id_asc_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('join',
		this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
	var_args_mutated.array_set('orderby',
		' wc_product_meta_lookup.global_unique_id ASC, wc_product_meta_lookup.product_id ASC ')
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Admin_List_Table_Products) order_by_global_unique_id_desc_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('join',
		this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
	var_args_mutated.array_set('orderby',
		' wc_product_meta_lookup.global_unique_id DESC, wc_product_meta_lookup.product_id DESC ')
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Admin_List_Table_Products) filter_downloadable_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('join',
		this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
	var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')),
		rt.new_string(' AND wc_product_meta_lookup.downloadable=1 '))
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Admin_List_Table_Products) filter_virtual_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('join',
		this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
	var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')),
		rt.new_string(' AND wc_product_meta_lookup.virtual=1 '))
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Admin_List_Table_Products) filter_stock_status_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('stock_status')))) {
		var_args_mutated.array_set('join',
			this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
		var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), rt.call_method(var_wpdb,
			'prepare', [rt.new_string(' AND wc_product_meta_lookup.stock_status=%s '),
			rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_GET').array_get(rt.new_string('stock_status')),
				]),
			])]))
	}
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Admin_List_Table_Products) append_product_sorting_table_join(var_sql rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [
		var_sql.clone(), rt.new_string('wc_product_meta_lookup')])))))
	{
		var_sql = rt.concat(var_sql, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' LEFT JOIN '), rt.get_property(var_wpdb,
			'wc_product_meta_lookup')), rt.new_string(' wc_product_meta_lookup ON ')), rt.get_property(var_wpdb,
			'posts')), rt.new_string('.ID = wc_product_meta_lookup.product_id ')))
	}
	return var_sql.clone()
}

fn (mut this Class_WC_Admin_List_Table_Products) add_variation_parents_for_shipping_class(var_pieces rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if rt.get_superglobal('_GET').array_isset(rt.new_string('product_shipping_class'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0'), rt.get_superglobal('_GET').array_get(rt.new_string('product_shipping_class')))))) {
		mut var_replaced_where := rt.call_function('str_replace', [
			rt.new_string(".post_type = 'product'"),
			rt.new_string(".post_type = 'product_variation'"),
			var_pieces.array_get(rt.new_string('where')),
		])
		var_pieces.array_get(rt.new_string('where')) = rt.concat(var_pieces.array_get(rt.new_string('where')), rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' OR '), rt.get_property(var_wpdb,
			'posts')), rt.new_string('.ID in (\n\t\t\t\tSELECT ')), rt.get_property(var_wpdb,
			'posts')), rt.new_string('.post_parent FROM\n\t\t\t\t')), rt.get_property(var_wpdb,
			'posts')), rt.new_string(' LEFT JOIN ')), rt.get_property(var_wpdb,
			'term_relationships')), rt.new_string(' ON (')), rt.get_property(var_wpdb, 'posts')),
			rt.new_string('.ID = ')), rt.get_property(var_wpdb, 'term_relationships')),
			rt.new_string('.object_id)\n\t\t\t\tWHERE 1=1 ')), var_replaced_where),
			rt.new_string('\n\t\t\t)')))
		return var_pieces.clone()
	}
	return var_pieces.clone()
}

fn (mut this Class_WC_Admin_List_Table_Products) add_sample_product_badge(var_column_name rt.PhpVal, var_post_id rt.PhpVal) {
	mut var_is_sample_product := rt.new_bool(
		rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [var_post_id.clone()])))
		&& rt.is_true(rt.call_function('get_post_meta', [var_post_id.clone(), rt.new_string('_headstart_post'), rt.new_bool(true)])))
	if rt.is_true(var_is_sample_product)
		&& rt.is_true(rt.identical(rt.new_string('name'), var_column_name)) {
		print(
			'<span class="sample-product-badge" style="margin-right: 6px;border-radius: 4px; background: #F6F7F7; padding: 4px; color: #3C434A;font-size: 12px;font-style: normal;font-weight: 400;line-height: 16px; height: 24px;">' +
			(rt.call_function('esc_html__', [rt.new_string('Sample'), rt.new_string('woocommerce')])).str() +
			'</span>')
	}
}

fn (mut this Class_WC_Admin_List_Table_Products) define_hidden_columns() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'global_unique_id' }])
}

struct Class_WC_Admin_List_Table {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_admin_list_table_products() &Class_WC_Admin_List_Table_Products {
	mut obj := &Class_WC_Admin_List_Table_Products{
		PhpObjectBase:          rt.PhpObjectBase{}
		list_table_type:        rt.new_string('product')
		cogs_is_enabled:        rt.new_null()
		use_cogs_lookup_column: false
	}
	obj.construct()
	return obj
}

fn create_wc_admin_list_table(_args ...rt.PhpVal) &Class_WC_Admin_List_Table {
	mut obj := &Class_WC_Admin_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_List_Table_Products) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'render_blank_state' {
			this.render_blank_state()
			return rt.new_null()
		}
		'get_primary_column' {
			return rt.new_string(this.get_primary_column())
		}
		'get_row_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_row_actions(dispatch_arg_0, dispatch_arg_1)
		}
		'define_sortable_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.define_sortable_columns(dispatch_arg_0)
		}
		'define_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.define_columns(dispatch_arg_0)
		}
		'prepare_row_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.prepare_row_data(dispatch_arg_0)
			return rt.new_null()
		}
		'render_thumb_column' {
			this.render_thumb_column()
			return rt.new_null()
		}
		'render_name_column' {
			this.render_name_column()
			return rt.new_null()
		}
		'render_sku_column' {
			this.render_sku_column()
			return rt.new_null()
		}
		'render_global_unique_id_column' {
			this.render_global_unique_id_column()
			return rt.new_null()
		}
		'render_price_column' {
			this.render_price_column()
			return rt.new_null()
		}
		'render_cogs_value_column' {
			this.render_cogs_value_column()
			return rt.new_null()
		}
		'render_product_cat_column' {
			this.render_product_cat_column()
			return rt.new_null()
		}
		'render_product_tag_column' {
			this.render_product_tag_column()
			return rt.new_null()
		}
		'render_featured_column' {
			this.render_featured_column()
			return rt.new_null()
		}
		'render_is_in_stock_column' {
			this.render_is_in_stock_column()
			return rt.new_null()
		}
		'add_custom_query_var' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_custom_query_var(dispatch_arg_0)
		}
		'render_filters' {
			this.render_filters()
			return rt.new_null()
		}
		'render_products_category_filter' {
			this.render_products_category_filter()
			return rt.new_null()
		}
		'render_products_type_filter' {
			this.render_products_type_filter()
			return rt.new_null()
		}
		'render_products_stock_status_filter' {
			this.render_products_stock_status_filter()
			return rt.new_null()
		}
		'sku_search' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sku_search(dispatch_arg_0)
		}
		'product_views' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.product_views(dispatch_arg_0)
		}
		'search_label' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.search_label(dispatch_arg_0)
		}
		'query_filters' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.query_filters(dispatch_arg_0)
		}
		'posts_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.posts_clauses(dispatch_arg_0, dispatch_arg_1)
		}
		'remove_ordering_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.remove_ordering_args(dispatch_arg_0)
		}
		'order_by_price_asc_post_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.order_by_price_asc_post_clauses(dispatch_arg_0)
		}
		'order_by_price_desc_post_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.order_by_price_desc_post_clauses(dispatch_arg_0)
		}
		'order_by_sku_asc_post_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.order_by_sku_asc_post_clauses(dispatch_arg_0)
		}
		'order_by_sku_desc_post_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.order_by_sku_desc_post_clauses(dispatch_arg_0)
		}
		'order_by_cogs_value_asc_post_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.order_by_cogs_value_asc_post_clauses(dispatch_arg_0)
		}
		'order_by_cogs_value_desc_post_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.order_by_cogs_value_desc_post_clauses(dispatch_arg_0)
		}
		'order_by_global_unique_id_asc_post_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.order_by_global_unique_id_asc_post_clauses(dispatch_arg_0)
		}
		'order_by_global_unique_id_desc_post_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.order_by_global_unique_id_desc_post_clauses(dispatch_arg_0)
		}
		'filter_downloadable_post_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_downloadable_post_clauses(dispatch_arg_0)
		}
		'filter_virtual_post_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_virtual_post_clauses(dispatch_arg_0)
		}
		'filter_stock_status_post_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_stock_status_post_clauses(dispatch_arg_0)
		}
		'append_product_sorting_table_join' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.append_product_sorting_table_join(dispatch_arg_0)
		}
		'add_variation_parents_for_shipping_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_variation_parents_for_shipping_class(dispatch_arg_0, dispatch_arg_1)
		}
		'add_sample_product_badge' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_sample_product_badge(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'define_hidden_columns' {
			return this.define_hidden_columns()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_List_Table_Products) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'list_table_type' { return this.list_table_type }
		'cogs_is_enabled' { return this.cogs_is_enabled }
		'use_cogs_lookup_column' { return rt.new_bool(this.use_cogs_lookup_column) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Admin_List_Table_Products) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'list_table_type' {
			this.list_table_type = val
			return true
		}
		'cogs_is_enabled' {
			this.cogs_is_enabled = val
			return true
		}
		'use_cogs_lookup_column' {
			this.use_cogs_lookup_column = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Admin_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Admin_List_Table_Products'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Admin_List_Table'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file(@DIR + '/abstract-class-wc-admin-list-table.php', '2')
	}
}
