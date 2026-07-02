import rt

struct Class_WC_Admin_Taxonomies {
	rt.PhpObjectBase
pub mut:
	default_cat_id rt.PhpVal = rt.new_int(0)
}

fn init_static_wc_admin_taxonomies() {
	rt.init_static_prop('WC_Admin_Taxonomies', 'instance', rt.new_bool(false))
}

fn Class_WC_Admin_Taxonomies.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('WC_Admin_Taxonomies', 'instance'))))) {
		rt.set_static_prop('WC_Admin_Taxonomies', 'instance', rt.new_object('WC_Admin_Taxonomies',
			[]string{}, create_wc_admin_taxonomies()))
	}
	return rt.get_static_prop('WC_Admin_Taxonomies', 'instance')
}

fn (mut this Class_WC_Admin_Taxonomies) construct() {
	this.default_cat_id = rt.call_function('get_option', [
		rt.new_string('default_product_cat'),
		rt.new_int(0),
	])
	rt.call_function('add_action', [rt.new_string('create_term'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'create_term' },
		]),
		rt.new_int(5), rt.new_int(3)])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_AssignDefaultCategory.class(),
		]), 'schedule_action', []rt.PhpVal{})
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('delete_product_cat'),
		rt.new_closure(closure_1_fn)])
	rt.call_function('add_action', [rt.new_string('product_cat_add_form_fields'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_category_fields' },
		])])
	rt.call_function('add_action', [rt.new_string('product_cat_edit_form_fields'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'edit_category_fields' },
		]),
		rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('created_term'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'save_category_fields' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('edit_term'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'save_category_fields' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('manage_edit-product_cat_columns'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'product_cat_columns' },
		])])
	rt.call_function('add_filter', [rt.new_string('manage_product_cat_custom_column'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'product_cat_column' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('product_cat_row_actions'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'product_cat_row_actions' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('admin_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_product_cat_row_actions' },
		])])
	rt.call_function('add_action', [rt.new_string('product_cat_pre_add_form'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'product_cat_description' },
		])])
	rt.call_function('add_action', [rt.new_string('after-product_cat-table'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'product_cat_notes' },
		])])
	mut var_attribute_taxonomies := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{})
	if !(!rt.is_true(var_attribute_taxonomies)) {
		mut iter_1 := var_attribute_taxonomies.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_attribute := item_1.val
			rt.call_function('add_action', [
				rt.new_string('pa_' + (rt.get_property(var_attribute, 'attribute_name')).str() +
					'_pre_add_form'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{},
						&this) },
					rt.ArrayItem{ key: none, val: 'product_attribute_description' },
				]),
			])
		}
	}
	rt.call_function('add_filter', [rt.new_string('wp_terms_checklist_args'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'disable_checked_ontop' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_footer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'scripts_at_product_cat_screen_footer' },
		])])
}

fn (mut this Class_WC_Admin_Taxonomies) create_term(var_term_id rt.PhpVal, tt_id string, taxonomy string) {
	if rt.is_true(rt.new_bool('product_cat' != taxonomy))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_is_product_attribute', [rt.new_string(taxonomy)]))))) {
		return
	}
	rt.call_function('update_term_meta', [var_term_id.clone(),
		rt.new_string('order'), rt.new_int(0)])
}

fn (mut this Class_WC_Admin_Taxonomies) delete_term(var_term_id rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [rt.new_string('delete_term'),
		rt.new_string('3.6')])
}

fn (mut this Class_WC_Admin_Taxonomies) add_category_fields() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Display type'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Default'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Products'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Subcategories'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Both'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Thumbnail'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wc_placeholder_img_src', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Upload/Add image'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Remove image'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Choose an image'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Use image'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('wc_placeholder_img_src', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('wc_placeholder_img_src', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Taxonomies) edit_category_fields(var_term rt.PhpVal) {
	mut var_display_type := rt.call_function('get_term_meta', [
		rt.get_property(var_term, 'term_id'),
		rt.new_string('display_type'),
		rt.new_bool(true),
	])
	mut var_thumbnail_id := rt.call_function('absint', [
		rt.call_function('get_term_meta', [rt.get_property(var_term, 'term_id'),
			rt.new_string('thumbnail_id'), rt.new_bool(true)]),
	])
	if rt.is_true(var_thumbnail_id) {
		mut var_image := rt.call_function('wp_get_attachment_thumb_url', [
			var_thumbnail_id.clone()])
	} else {
		var_image = rt.call_function('wc_placeholder_img_src', []rt.PhpVal{})
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Display type'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string(''), var_display_type.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Default'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string('products'), var_display_type.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Products'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string('subcategories'),
		var_display_type.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Subcategories'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string('both'), var_display_type.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Both'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Thumbnail'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_thumbnail_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Upload/Add image'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Remove image'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Choose an image'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Use image'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('wc_placeholder_img_src', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Taxonomies) save_category_fields(var_term_id rt.PhpVal, tt_id string, taxonomy string) {
	if rt.get_superglobal('_POST').array_isset(rt.new_string('display_type'))
		&& rt.is_true(rt.identical(rt.new_string('product_cat'), rt.new_string(taxonomy))) {
		rt.call_function('update_term_meta', [var_term_id.clone(),
			rt.new_string('display_type'),
			rt.call_function('esc_attr', [
				rt.get_superglobal('_POST').array_get(rt.new_string('display_type')),
			])])
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('product_cat_thumbnail_id'))
		&& rt.is_true(rt.identical(rt.new_string('product_cat'), rt.new_string(taxonomy))) {
		rt.call_function('update_term_meta', [var_term_id.clone(),
			rt.new_string('thumbnail_id'),
			rt.call_function('absint', [
				rt.get_superglobal('_POST').array_get(rt.new_string('product_cat_thumbnail_id')),
			])])
	}
}

fn (mut this Class_WC_Admin_Taxonomies) product_cat_description() {
	rt.echo_val(rt.call_function('wp_kses', [
		rt.call_function('wpautop', [
			rt.call_function('__', [
				rt.new_string('Product categories for your store can be managed here. To change the order of categories on the front-end you can drag and drop to sort them. To see more categories listed click the "screen options" link at the top-right of this page.'),
				rt.new_string('woocommerce'),
			]),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'p', val: rt.new_array() },
		]),
	]))
}

fn (mut this Class_WC_Admin_Taxonomies) product_cat_notes() {
	mut var_category_id := rt.call_function('get_option', [
		rt.new_string('default_product_cat'),
		rt.new_int(0),
	])
	mut var_category := rt.call_function('get_term', [var_category_id.clone(),
		rt.new_string('product_cat')])
	mut var_category_name := if rt.is_true(rt.new_bool(!(rt.is_true(var_category)))) || rt.is_true(rt.call_function('is_wp_error', [var_category.clone()])) { rt.call_function('_x', [
			rt.new_string('Uncategorized'),
			rt.new_string('Default category slug'),
			rt.new_string('woocommerce'),
		]) } else { rt.get_property(var_category, 'name') }
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Note:'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('esc_html__', [
			rt.new_string('Deleting a category does not delete the products in that category. Instead, products that were only assigned to the deleted category are set to the category %s.'),
			rt.new_string('woocommerce'),
		]),
		rt.new_string('<strong>' +
			(rt.call_function('esc_html', [var_category_name.clone()])).str() + '</strong>'),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Taxonomies) product_attribute_description() {
	rt.echo_val(rt.call_function('wp_kses', [
		rt.call_function('wpautop', [
			rt.call_function('__', [
				rt.new_string('Attribute terms can be assigned to products and variations.<br/><br/><b>Note</b>: Deleting a term will remove it from all products and variations to which it has been assigned. Recreating a term will not automatically assign it back to products.'),
				rt.new_string('woocommerce'),
			]),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'p', val: rt.new_array() },
		]),
	]))
}

fn (mut this Class_WC_Admin_Taxonomies) product_cat_columns(var_columns rt.PhpVal) rt.PhpVal {
	mut var_columns_mutated := var_columns
	mut var_new_columns := rt.new_array()
	if var_columns_mutated.array_isset(rt.new_string('cb')) {
		var_new_columns['cb'] = var_columns_mutated.array_get(rt.new_string('cb'))
		var_columns_mutated.array_unset(rt.new_string('cb'))
	}
	var_new_columns['thumb'] = rt.call_function('__', [rt.new_string('Image'),
		rt.new_string('woocommerce')])
	var_columns_mutated = rt.call_function('array_merge', [
		rt.create_array_from_native_map(var_new_columns),
		var_columns_mutated.clone(),
	])
	var_columns_mutated.array_set('handle', '')
	return var_columns_mutated.clone()
}

fn (mut this Class_WC_Admin_Taxonomies) product_cat_row_actions(var_actions rt.PhpVal, var_term rt.PhpVal) rt.PhpVal {
	mut var_actions_mutated := var_actions
	mut var_default_category_id := rt.call_function('absint', [
		rt.call_function('get_option', [rt.new_string('default_product_cat'),
			rt.new_int(0)]),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_default_category_id, rt.get_property(var_term, 'term_id')))))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_term'), rt.get_property(var_term, 'term_id')])) {
		var_actions_mutated.array_set('make_default', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" aria-label="%s">%s</a>'),
			rt.call_function('wp_nonce_url', [
				rt.new_string(
					'edit-tags.php?action=make_default&amp;taxonomy=product_cat&amp;post_type=product&amp;tag_ID=' +
					(rt.call_function('absint', [rt.get_property(var_term, 'term_id')])).str()),
				rt.new_string('make_default_' +
					(rt.call_function('absint', [rt.get_property(var_term, 'term_id')])).str()),
			]),
			rt.call_function('esc_attr', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Make &#8220;%s&#8221; the default category'),
						rt.new_string('woocommerce'),
					]),
					rt.get_property(var_term, 'name'),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Make default'),
				rt.new_string('woocommerce'),
			]),
		]))
	}
	return var_actions_mutated.clone()
}

fn (mut this Class_WC_Admin_Taxonomies) handle_product_cat_row_actions() {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('action'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('tag_ID'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('_wpnonce'))
		&& rt.is_true(rt.identical(rt.new_string('make_default'), rt.get_superglobal('_GET').array_get(rt.new_string('action')))) {
		mut var_make_default_id := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('tag_ID')),
		])
		if rt.is_true(rt.call_function('wp_verify_nonce', [rt.get_superglobal('_GET').array_get(rt.new_string('_wpnonce')), rt.new_string('make_default_' + var_make_default_id.str())]))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_term'), var_make_default_id.clone()])) {
			rt.call_function('update_option', [rt.new_string('default_product_cat'),
				var_make_default_id.clone()])
		}
	}
}

fn (mut this Class_WC_Admin_Taxonomies) product_cat_column(var_columns rt.PhpVal, var_column rt.PhpVal, var_id rt.PhpVal) rt.PhpVal {
	mut var_columns_mutated := var_columns
	if rt.is_true(rt.identical(rt.new_string('thumb'), var_column)) {
		mut var_default_category_id := rt.call_function('absint', [
			rt.call_function('get_option', [rt.new_string('default_product_cat'),
				rt.new_int(0)]),
		])
		if rt.is_true(rt.identical(var_default_category_id, var_id)) {
			var_columns_mutated = rt.concat(var_columns_mutated, rt.call_function('wc_help_tip', [
				rt.call_function('__', [
					rt.new_string('This is the default category and it cannot be deleted. It will be automatically assigned to products with no category.'),
					rt.new_string('woocommerce'),
				]),
			]))
		}
		mut var_thumbnail_id := rt.call_function('get_term_meta', [
			var_id.clone(), rt.new_string('thumbnail_id'), rt.new_bool(true)])
		if rt.is_true(var_thumbnail_id) {
			mut var_image := rt.call_function('wp_get_attachment_thumb_url', [
				var_thumbnail_id.clone()])
		} else {
			var_image = rt.call_function('wc_placeholder_img_src', []rt.PhpVal{})
		}
		var_image = rt.call_function('str_replace', [rt.new_string(' '),
			rt.new_string('%20'), var_image.clone()])
		var_columns_mutated = rt.concat(var_columns_mutated, rt.new_string('<img src="' +
			(rt.call_function('esc_url', [var_image.clone()])).str() + '" alt="' +
			(rt.call_function('esc_attr__', [rt.new_string('Thumbnail'), rt.new_string('woocommerce')])).str() +
			'" class="wp-post-image" height="48" width="48" />'))
	}
	if rt.is_true(rt.identical(rt.new_string('handle'), var_column)) {
		var_columns_mutated = rt.concat(var_columns_mutated, rt.new_string(
			'<input type="hidden" name="term_id" value="' +
			(rt.call_function('esc_attr', [var_id.clone()])).str() + '" />'))
	}
	return var_columns_mutated.clone()
}

fn (mut this Class_WC_Admin_Taxonomies) disable_checked_ontop(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('taxonomy'))))
		&& rt.is_true(rt.identical(rt.new_string('product_cat'), var_args_mutated.array_get(rt.new_string('taxonomy')))) {
		var_args_mutated.array_set('checked_ontop', false)
	}
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Admin_Taxonomies) scripts_at_product_cat_screen_footer() {
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('taxonomy')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product_cat'), rt.get_superglobal('_GET').array_get(rt.new_string('taxonomy')))))) {
		return
	}
	mut var_handle := rt.new_string('wc-admin-taxonomies')
	rt.call_function('wp_register_script', [var_handle.clone(),
		rt.new_string(''), rt.new_array(), rt.get_constant('WC_VERSION'),
		rt.create_array([rt.ArrayItem{ key: 'in_footer', val: true }])])
	rt.call_function('wp_enqueue_script', [var_handle.clone()])
	rt.call_function('wp_add_inline_script', [var_handle.clone(),
		rt.call_function('sprintf', [
			rt.new_string("(function() {\n                    'use strict';\n                    const product_cat = document.getElementById('tag-%d');\n                    if (product_cat) {\n                        const th = product_cat.querySelector('th');\n                        const thumbSpan = product_cat.querySelector('td.thumb span');\n                        if (th && thumbSpan) {\n                            th.innerHTML = '';\n                            th.appendChild(thumbSpan);\n                        }\n                    }\n                })();"),
			rt.call_function('absint', [this.default_cat_id]),
		])])
}

fn create_wc_admin_taxonomies() &Class_WC_Admin_Taxonomies {
	mut var_wc_admin_taxonomies := Class_WC_Admin_Taxonomies.get_instance()
	mut obj := &Class_WC_Admin_Taxonomies{
		PhpObjectBase:  rt.PhpObjectBase{}
		default_cat_id: rt.new_int(0)
	}
	obj.construct()
	return obj
}

fn (mut this Class_WC_Admin_Taxonomies) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_WC_Admin_Taxonomies.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'create_term' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.create_term(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'delete_term' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_term(dispatch_arg_0)
			return rt.new_null()
		}
		'add_category_fields' {
			this.add_category_fields()
			return rt.new_null()
		}
		'edit_category_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.edit_category_fields(dispatch_arg_0)
			return rt.new_null()
		}
		'save_category_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.save_category_fields(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'product_cat_description' {
			this.product_cat_description()
			return rt.new_null()
		}
		'product_cat_notes' {
			this.product_cat_notes()
			return rt.new_null()
		}
		'product_attribute_description' {
			this.product_attribute_description()
			return rt.new_null()
		}
		'product_cat_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.product_cat_columns(dispatch_arg_0)
		}
		'product_cat_row_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.product_cat_row_actions(dispatch_arg_0, dispatch_arg_1)
		}
		'handle_product_cat_row_actions' {
			this.handle_product_cat_row_actions()
			return rt.new_null()
		}
		'product_cat_column' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.product_cat_column(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'disable_checked_ontop' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.disable_checked_ontop(dispatch_arg_0)
		}
		'scripts_at_product_cat_screen_footer' {
			this.scripts_at_product_cat_screen_footer()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_Taxonomies) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'default_cat_id' { return this.default_cat_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Admin_Taxonomies) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'default_cat_id' {
			this.default_cat_id = val
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

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
