import rt

struct Class_WC_Admin_Taxonomies {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_bool(false)
		default_cat_id rt.PhpVal = rt.new_int(0)
}

fn Class_WC_Admin_Taxonomies.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_WC_Admin_Taxonomies) construct()  {
	this.default_cat_id = rt.call_function('get_option', [rt.new_string('default_product_cat'), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('create_term'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'create_term' }]), rt.new_int(5), rt.new_int(3)])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_AssignDefaultCategory.class()]), 'schedule_action', []rt.PhpVal{})
	return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('delete_product_cat'), rt.new_closure(closure_1_fn)])
	rt.call_function('add_action', [rt.new_string('product_cat_add_form_fields'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_category_fields' }])])
	rt.call_function('add_action', [rt.new_string('product_cat_edit_form_fields'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'edit_category_fields' }]), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('created_term'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'save_category_fields' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('edit_term'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'save_category_fields' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('manage_edit-product_cat_columns'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'product_cat_columns' }])])
	rt.call_function('add_filter', [rt.new_string('manage_product_cat_custom_column'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'product_cat_column' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('product_cat_row_actions'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'product_cat_row_actions' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_product_cat_row_actions' }])])
	rt.call_function('add_action', [rt.new_string('product_cat_pre_add_form'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'product_cat_description' }])])
	rt.call_function('add_action', [rt.new_string('after-product_cat-table'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'product_cat_notes' }])])
	mut var_attribute_taxonomies := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{})
	if !(!rt.is_true(var_attribute_taxonomies)) {
		{
			mut iter_1 := var_attribute_taxonomies.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_attribute := item_1.val
				rt.call_function('add_action', ['pa_' + (rt.get_property(var_attribute, 'attribute_name')).str() + '_pre_add_form', rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'product_attribute_description' }])])
			}
		}
	}
	rt.call_function('add_filter', [rt.new_string('wp_terms_checklist_args'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'disable_checked_ontop' }])])
	rt.call_function('add_action', [rt.new_string('admin_footer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Taxonomies', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'scripts_at_product_cat_screen_footer' }])])
}

fn (mut this Class_WC_Admin_Taxonomies) create_term(var_term_id rt.PhpVal, tt_id string, taxonomy string)  {
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_is_product_attribute', [rt.new_string(taxonomy)]))))))) {
		return rt.new_null()
	}
	rt.call_function('update_term_meta', [var_term_id.dup(), rt.new_string('order'), rt.new_int(0)])
}

fn (mut this Class_WC_Admin_Taxonomies) delete_term(var_term_id rt.PhpVal)  {
	rt.call_function('wc_deprecated_function', [rt.new_string('delete_term'), rt.new_string('3.6')])
}

fn (mut this Class_WC_Admin_Taxonomies) add_category_fields()  {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Display type'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Default'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Products'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Subcategories'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Both'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Thumbnail'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('wc_placeholder_img_src', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Upload/Add image'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Remove image'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Choose an image'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Use image'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [rt.call_function('wc_placeholder_img_src', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [rt.call_function('wc_placeholder_img_src', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Taxonomies) edit_category_fields(var_term rt.PhpVal)  {
	mut var_display_type := rt.call_function('get_term_meta', [rt.get_property(var_term, 'term_id'), rt.new_string('display_type'), rt.new_bool(true)])
	mut var_thumbnail_id := rt.call_function('absint', [rt.call_function('get_term_meta', [rt.get_property(var_term, 'term_id'), rt.new_string('thumbnail_id'), rt.new_bool(true)])])
	if rt.is_true(var_thumbnail_id) {
		mut var_image := rt.call_function('wp_get_attachment_thumb_url', [var_thumbnail_id.dup()])
	} else {
		var_image = rt.call_function('wc_placeholder_img_src', []rt.PhpVal{})
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Display type'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string(''), var_display_type.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Default'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string('products'), var_display_type.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Products'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string('subcategories'), var_display_type.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Subcategories'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string('both'), var_display_type.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Both'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Thumbnail'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_thumbnail_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Upload/Add image'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Remove image'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Choose an image'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Use image'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [rt.call_function('wc_placeholder_img_src', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Taxonomies) save_category_fields(var_term_id rt.PhpVal, tt_id string, taxonomy string)  {
	if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('display_type')) && rt.is_true(rt.identical(rt.new_string('product_cat'), rt.new_string(taxonomy))))) {
		rt.call_function('update_term_meta', [var_term_id.dup(), rt.new_string('display_type'), rt.call_function('esc_attr', [rt.get_superglobal('_POST').array_get('display_type')])])
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('product_cat_thumbnail_id')) && rt.is_true(rt.identical(rt.new_string('product_cat'), rt.new_string(taxonomy))))) {
		rt.call_function('update_term_meta', [var_term_id.dup(), rt.new_string('thumbnail_id'), rt.call_function('absint', [])])
		// unsupported statement: Stmt_Nop
	}
}

fn (mut this Class_WC_Admin_Taxonomies) product_cat_description()  {
	rt.echo_val(rt.call_function('wp_kses', [, ]))
}

fn (mut this Class_WC_Admin_Taxonomies) product_cat_notes()  {
	
}

fn (mut this Class_WC_Admin_Taxonomies) product_attribute_description()  {
}

fn (mut this Class_WC_Admin_Taxonomies) product_cat_columns(var_columns rt.PhpVal) rt.PhpVal {
	mut var_columns_mutated := var_columns
}

fn (mut this Class_WC_Admin_Taxonomies) product_cat_row_actions(var_actions rt.PhpVal, var_term rt.PhpVal) rt.PhpVal {
	mut var_actions_mutated := var_actions
}

fn (mut this Class_WC_Admin_Taxonomies) handle_product_cat_row_actions()  {
}

fn (mut this Class_WC_Admin_Taxonomies) product_cat_column(var_columns rt.PhpVal, var_column rt.PhpVal, var_id rt.PhpVal) rt.PhpVal {
	mut var_columns_mutated := var_columns
}

fn (mut this Class_WC_Admin_Taxonomies) disable_checked_ontop(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WC_Admin_Taxonomies) scripts_at_product_cat_screen_footer()  {
}

fn create_wc_admin_taxonomies() &Class_WC_Admin_Taxonomies {
	mut obj := &Class_WC_Admin_Taxonomies{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_bool(false)
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
		else { return none }
	}
}

fn (this &Class_WC_Admin_Taxonomies) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		'default_cat_id' { return this.default_cat_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Admin_Taxonomies) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		'default_cat_id' { this.default_cat_id = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_class_wc_admin_taxonomies_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
}
