import rt

struct Class_WC_Brands_Admin {
	rt.PhpObjectBase
pub mut:
		settings_tabs rt.PhpVal = rt.new_null()
		settings rt.PhpVal = rt.new_null()
		fields rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Brands_Admin) construct()  {
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'scripts' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'styles' }])])
	rt.call_function('add_action', [rt.new_string('product_brand_add_form_fields'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_thumbnail_field' }])])
	rt.call_function('add_action', [rt.new_string('product_brand_edit_form_fields'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'edit_thumbnail_field' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('created_term'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'thumbnail_field_save' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('edit_term'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'thumbnail_field_save' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('product_brand_pre_add_form'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'taxonomy_description' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_sortable_taxonomies'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'sort_brands' }])])
	rt.call_function('add_filter', [rt.new_string('manage_edit-product_brand_columns'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'columns' }])])
	rt.call_function('add_filter', [rt.new_string('manage_product_brand_custom_column'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'column' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('manage_product_posts_columns'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'product_columns' }]), rt.new_int(20), rt.new_int(1)])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_args := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	var_args.array_set('product_brand', rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_product_brand_filter' }]))
	return
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_products_admin_list_table_filters'), rt.new_closure(closure_1_fn)])
	mut var_setting_value := rt.call_function('get_option', [rt.new_string('wc_brands_show_description')])
	if rt.is_true(rt.new_bool(var_setting_value.dup().is_string())) {
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	this.init_form_fields()
	this.settings_tabs = rt.create_array([rt.ArrayItem{ key: 'brands', val: rt.call_function('__', [rt.new_string('Brands'), rt.new_string('woocommerce')]) }])
	return rt.new_null()
	}
		rt.call_function('add_action', [rt.new_string('before_woocommerce_init'), rt.new_closure(closure_2_fn)])
		rt.call_function('add_action', [rt.new_string('woocommerce_get_sections_products'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_settings_tab' }])])
		rt.call_function('add_action', [rt.new_string('woocommerce_get_settings_products'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_settings_section' }]), rt.new_null(), rt.new_int(2)])
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_update_options_catalog'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'save_admin_settings' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_update_options_products'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'save_admin_settings' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_coupon_options_usage_restriction'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_coupon_brands_fields' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_coupon_options_save'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'save_coupon_brands' }])])
	rt.call_function('add_filter', [rt.new_string('pre_update_option_woocommerce_permalinks'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'validate_product_base' }])])
	rt.call_function('add_action', [rt.new_string('current_screen'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_brand_base_setting' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_csv_product_import_mapping_options'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_column_to_importer_exporter' }]), rt.new_int(10)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_csv_product_import_mapping_default_columns'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_default_column_mapping' }]), rt.new_int(10)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_product_importer_formatting_callbacks'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_formatting_callback' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_product_import_inserted_product_object'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'process_import' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_product_export_column_names'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_column_to_importer_exporter' }]), rt.new_int(10)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_product_export_product_default_columns'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_column_to_importer_exporter' }]), rt.new_int(10)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_product_export_product_column_brand_ids'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_column_value_brand_ids' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_WC_Brands_Admin) add_settings_section(var_settings rt.PhpVal, var_current_section rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	if rt.is_true(rt.identical(rt.new_string('brands'), var_current_section)) {
		var_settings_mutated = this.settings
	}
	return var_settings_mutated.dup()
}

fn (mut this Class_WC_Brands_Admin) add_settings_tab(var_sections rt.PhpVal) rt.PhpVal {
	mut var_sections_mutated := var_sections
	var_sections_mutated = rt.call_function('array_merge', [var_sections_mutated.dup(), this.settings_tabs])
	return var_sections_mutated.dup()
}

fn (mut this Class_WC_Brands_Admin) add_coupon_brands_fields()  {
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_Global
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('And'), rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Product brands'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Any brand'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_category_ids := rt.cast_array(rt.call_function('get_post_meta', [rt.get_property(var_post, 'ID'), rt.new_string('product_brands'), rt.new_bool(true)]))
	mut var_categories := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_brand' }, rt.ArrayItem{ key: 'orderby', val: 'name' }, rt.ArrayItem{ key: 'hide_empty', val: false }])])
	if rt.is_true(var_categories) {
		{
			mut iter_1 := var_categories.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_cat := item_1.val
				print('<option value="' + (rt.call_function('esc_attr', [rt.get_property(var_cat, 'term_id')])).str() + '"' + (rt.call_function('selected', [rt.call_function('in_array', [rt.get_property(var_cat, 'term_id'), var_category_ids.dup(), rt.new_bool(true)]), rt.new_bool(true), rt.new_bool(false)])).str() + '>' + (rt.call_function('esc_html', [rt.get_property(var_cat, 'name')])).str() + '</option>')
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('esc_html__', [rt.new_string('A product must be associated with this brand for the coupon to remain valid or, for "Product Discounts", products with these brands will be discounted.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Exclude brands'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('No brands'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	var_category_ids = rt.cast_array(rt.call_function('get_post_meta', [rt.get_property(var_post, 'ID'), rt.new_string('exclude_product_brands'), rt.new_bool(true)]))
	var_categories = rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_brand' }, rt.ArrayItem{ key: 'orderby', val: 'name' }, rt.ArrayItem{ key: 'hide_empty', val: false }])])
	if rt.is_true(var_categories) {
		{
			mut iter_1 := var_categories.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_cat := item_1.val
				print('<option value="' + (rt.call_function('esc_attr', [rt.get_property(var_cat, 'term_id')])).str() + '"' + (rt.call_function('selected', [rt.call_function('in_array', [rt.get_property(var_cat, 'term_id'), var_category_ids.dup(), rt.new_bool(true)]), rt.new_bool(true), rt.new_bool(false)])).str() + '>' + (rt.call_function('esc_html', [rt.get_property(var_cat, 'name')])).str() + '</option>')
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('esc_html__', [rt.new_string('Product must not be associated with these brands for the coupon to remain valid or, for "Product Discounts", products associated with these brands will not be discounted.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Brands_Admin) save_coupon_brands(var_post_id rt.PhpVal)  {
	mut var_product_brands := if rt.get_superglobal('_POST').array_isset(rt.new_string('product_brands')) { rt.call_function('array_map', [rt.new_string('intval'), rt.get_superglobal('_POST').array_get('product_brands')]) } else { rt.new_array() }
	mut var_exclude_product_brands := if rt.get_superglobal('_POST').array_isset(rt.new_string('exclude_product_brands')) { rt.call_function('array_map', [rt.new_string('intval'), rt.get_superglobal('_POST').array_get('exclude_product_brands')]) } else { rt.new_array() }
	rt.call_function('update_post_meta', [var_post_id.dup(), rt.new_string('product_brands'), var_product_brands.dup()])
	rt.call_function('update_post_meta', [var_post_id.dup(), rt.new_string('exclude_product_brands'), var_exclude_product_brands.dup()])
}

fn (mut this Class_WC_Brands_Admin) init_form_fields()  {
	this.settings = rt.call_function('apply_filters', [rt.new_string('woocommerce_brands_settings_fields'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Brands Archives'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'title' }, rt.ArrayItem{ key: 'desc', val: '' }, rt.ArrayItem{ key: 'id', val: 'brands_archives' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Show description'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Choose to show the brand description on the archive page. Turn this off if you intend to use the description widget instead. Please note: this is only for themes that do not show the description.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'tip', val: '' }, rt.ArrayItem{ key: 'id', val: 'wc_brands_show_description' }, rt.ArrayItem{ key: 'css', val: '' }, rt.ArrayItem{ key: 'std', val: 'yes' }, rt.ArrayItem{ key: 'type', val: 'checkbox' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'sectionend' }, rt.ArrayItem{ key: 'id', val: 'brands_archives' }]) }])])
}

fn (mut this Class_WC_Brands_Admin) scripts()  {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))
	mut var_suffix := rt.new_string(if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('SCRIPT_DEBUG'))) { rt.new_string('') } else { rt.new_string('.min') })
	if rt.is_true(rt.identical(rt.new_string('edit-product'), rt.get_property(var_screen, 'id'))) {
		rt.call_function('wp_register_script', [rt.new_string('wc-brands-enhanced-select'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/js/admin/wc-brands-enhanced-select' + (var_suffix).str() + '.js', rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'selectWoo' }, rt.ArrayItem{ key: none, val: 'wc-enhanced-select' }, rt.ArrayItem{ key: none, val: 'wp-api' }]), var_version.dup(), rt.new_bool(true)])
		rt.call_function('wp_localize_script', [rt.new_string('wc-brands-enhanced-select'), rt.new_string('wc_brands_enhanced_select_params'), rt.create_array([rt.ArrayItem{ key: 'ajax_url', val: (rt.call_function('get_rest_url', []rt.PhpVal{})).str() + 'brands/search' }])])
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-brands-enhanced-select')])
	}
	if rt.is_true(rt.call_function('in_array', [rt.get_property(var_screen, 'id'), rt.create_array([rt.ArrayItem{ key: none, val: 'edit-product_brand' }]), rt.new_bool(true)])) {
		rt.call_function('wp_enqueue_media', []rt.PhpVal{})
		rt.call_function('wp_enqueue_style', [rt.new_string('woocommerce_admin_styles')])
	}
}

fn (mut this Class_WC_Brands_Admin) styles()  {
	mut var_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))
	rt.call_function('wp_enqueue_style', [rt.new_string('brands-admin-styles'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/css/brands-admin.css', rt.new_array(), var_version.dup()])
}

fn (mut this Class_WC_Brands_Admin) admin_settings()  {
	rt.call_function('woocommerce_admin_fields', [this.settings])
}

fn (mut this Class_WC_Brands_Admin) save_admin_settings()  {
	if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('section')) && rt.is_true(rt.identical(rt.new_string('brands'), rt.get_superglobal('_GET').array_get('section'))))) {
		rt.call_function('woocommerce_update_options', [this.settings])
	}
}

fn (mut this Class_WC_Brands_Admin) add_thumbnail_field()  {
	mut var_woocommerce := rt.new_null()
	// unsupported statement: Stmt_Global
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Thumbnail'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('wc_placeholder_img_src', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Upload/Add image'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Remove image'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [rt.call_function('wc_placeholder_img_src', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [rt.call_function('__', [, ])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val()
}

fn (mut this Class_WC_Brands_Admin) edit_thumbnail_field(var_term rt.PhpVal)  {
	mut var_woocommerce := rt.new_null()
	mut var_term_mutated := var_term
}

fn (mut this Class_WC_Brands_Admin) thumbnail_field_save(var_term_id rt.PhpVal)  {
	mut var_term_id_mutated := var_term_id
}

fn (mut this Class_WC_Brands_Admin) taxonomy_description()  {
}

fn (mut this Class_WC_Brands_Admin) sort_brands(var_sortable rt.PhpVal) rt.PhpVal {
	mut var_sortable_mutated := var_sortable
}

fn (mut this Class_WC_Brands_Admin) product_columns(var_columns rt.PhpVal) rt.PhpVal {
	mut var_columns_mutated := var_columns
}

fn (mut this Class_WC_Brands_Admin) columns(var_columns rt.PhpVal) rt.PhpVal {
	mut var_columns_mutated := var_columns
}

fn (mut this Class_WC_Brands_Admin) column(var_columns rt.PhpVal, var_column rt.PhpVal, var_id rt.PhpVal) rt.PhpVal {
	mut var_woocommerce := rt.new_null()
	mut var_columns_mutated := var_columns
}

fn (mut this Class_WC_Brands_Admin) render_product_brand_filter()  {
}

fn (mut this Class_WC_Brands_Admin) add_brand_base_setting()  {
}

fn (mut this Class_WC_Brands_Admin) product_brand_slug_input()  {
}

fn (mut this Class_WC_Brands_Admin) save_permalink_settings()  {
}

fn (mut this Class_WC_Brands_Admin) validate_product_base(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Brands_Admin) add_column_to_importer_exporter(var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
}

fn (mut this Class_WC_Brands_Admin) add_default_column_mapping(var_mappings rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Brands_Admin) add_formatting_callback(var_callbacks rt.PhpVal, var_importer rt.PhpVal) rt.PhpVal {
	mut var_callbacks_mutated := var_callbacks
}

fn (mut this Class_WC_Brands_Admin) process_import(var_product rt.PhpVal, var_data rt.PhpVal)  {
}

fn (mut this Class_WC_Brands_Admin) parse_brands_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Brands_Admin) get_column_value_brand_ids(var_value rt.PhpVal, var_product rt.PhpVal) string {
	mut var_value_mutated := var_value
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_brands_admin() &Class_WC_Brands_Admin {
	mut obj := &Class_WC_Brands_Admin{
		PhpObjectBase: rt.PhpObjectBase{}
		settings_tabs: rt.new_null()
		settings: rt.new_null()
		fields: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Brands_Admin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'add_settings_section' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_settings_section(dispatch_arg_0, dispatch_arg_1)
		}
		'add_settings_tab' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_settings_tab(dispatch_arg_0)
		}
		'add_coupon_brands_fields' {
			this.add_coupon_brands_fields()
			return rt.new_null()
		}
		'save_coupon_brands' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.save_coupon_brands(dispatch_arg_0)
			return rt.new_null()
		}
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		'scripts' {
			this.scripts()
			return rt.new_null()
		}
		'styles' {
			this.styles()
			return rt.new_null()
		}
		'admin_settings' {
			this.admin_settings()
			return rt.new_null()
		}
		'save_admin_settings' {
			this.save_admin_settings()
			return rt.new_null()
		}
		'add_thumbnail_field' {
			this.add_thumbnail_field()
			return rt.new_null()
		}
		'edit_thumbnail_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.edit_thumbnail_field(dispatch_arg_0)
			return rt.new_null()
		}
		'thumbnail_field_save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.thumbnail_field_save(dispatch_arg_0)
			return rt.new_null()
		}
		'taxonomy_description' {
			this.taxonomy_description()
			return rt.new_null()
		}
		'sort_brands' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sort_brands(dispatch_arg_0)
		}
		'product_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.product_columns(dispatch_arg_0)
		}
		'columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.columns(dispatch_arg_0)
		}
		'column' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.column(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'render_product_brand_filter' {
			this.render_product_brand_filter()
			return rt.new_null()
		}
		'add_brand_base_setting' {
			this.add_brand_base_setting()
			return rt.new_null()
		}
		'product_brand_slug_input' {
			this.product_brand_slug_input()
			return rt.new_null()
		}
		'save_permalink_settings' {
			this.save_permalink_settings()
			return rt.new_null()
		}
		'validate_product_base' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.validate_product_base(dispatch_arg_0)
		}
		'add_column_to_importer_exporter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_column_to_importer_exporter(dispatch_arg_0)
		}
		'add_default_column_mapping' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_default_column_mapping(dispatch_arg_0)
		}
		'add_formatting_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_formatting_callback(dispatch_arg_0, dispatch_arg_1)
		}
		'process_import' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.process_import(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'parse_brands_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_brands_field(dispatch_arg_0)
		}
		'get_column_value_brand_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.get_column_value_brand_ids(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_WC_Brands_Admin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'settings_tabs' { return this.settings_tabs }
		'settings' { return this.settings }
		'fields' { return this.fields }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Brands_Admin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'settings_tabs' { this.settings_tabs = val; return true }
		'settings' { this.settings = val; return true }
		'fields' { this.fields = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_includes_admin_class_wc_admin_brands_php() {
	mut var_GLOBALS := rt.new_null()
	// unsupported statement: Stmt_Declare
}
