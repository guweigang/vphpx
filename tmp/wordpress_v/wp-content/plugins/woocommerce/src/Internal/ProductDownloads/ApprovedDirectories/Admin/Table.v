import rt

struct Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) construct()  {
	this.Class_WP_List_Table.construct(rt.create_array([rt.ArrayItem{ key: 'singular', val: 'url' }, rt.ArrayItem{ key: 'plural', val: 'urls' }, rt.ArrayItem{ key: 'ajax', val: false }]))
	rt.call_function('add_filter', [rt.new_string('manage_woocommerce_page_wc-settings_columns'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'get_columns' }])])
	this.items_per_page()
	rt.call_function('set_screen_options', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) items_per_page()  {
	rt.call_function('add_screen_option', [rt.new_string('per_page'), rt.create_array([rt.ArrayItem{ key: 'default', val: 20 }, rt.ArrayItem{ key: 'option', val: 'edit_approved_directories_per_page' }])])
	rt.call_function('add_filter', [rt.new_string('set_screen_option_edit_approved_directories_per_page'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table', ['WP_List_Table'], &this) }, rt.ArrayItem{ key: none, val: 'set_items_per_page' }]), rt.new_int(10), rt.new_int(3)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) set_items_per_page(var_default rt.PhpVal, option string, value i64) rt.PhpVal {
	return if rt.is_true(rt.identical(rt.new_string('edit_approved_directories_per_page'), rt.new_string(option))) { rt.call_function('absint', [rt.new_int(value)]) } else { var_default }
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) no_items()  {
	rt.call_function('esc_html_e', [rt.new_string('No approved directory URLs found.'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) render_views()  {
	mut var_register := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.class()])
	mut var_enabled_count := rt.call_method(var_register, 'count', [rt.new_bool(true)])
	mut var_disabled_count := rt.call_method(var_register, 'count', [rt.new_bool(false)])
	mut var_all_count := rt.add(var_enabled_count, var_disabled_count)
	mut var_selected_view := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('view')) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('view')])]) } else { rt.new_string('all') }
	mut var_all_url := rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('view'), rt.new_string('all'), this.get_base_url()])])
	mut var_all_class := rt.new_string(if rt.is_true(rt.identical(rt.new_string('all'), var_selected_view)) { rt.new_string('class="current"') } else { rt.new_string('') })
	mut var_all_text := rt.call_function('sprintf', [rt.call_function('_nx', [rt.new_string('All <span class="count">(%s)</span>'), rt.new_string('All <span class="count">(%s)</span>'), var_all_count.dup(), rt.new_string('Approved product download directory views'), rt.new_string('woocommerce')]), var_all_count.dup()])
	mut var_enabled_url := rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('view'), rt.new_string('enabled'), this.get_base_url()])])
	mut var_enabled_class := rt.new_string(if rt.is_true(rt.identical(rt.new_string('enabled'), var_selected_view)) { rt.new_string('class="current"') } else { rt.new_string('') })
	mut var_enabled_text := rt.call_function('sprintf', [rt.call_function('_nx', [rt.new_string('Enabled <span class="count">(%s)</span>'), rt.new_string('Enabled <span class="count">(%s)</span>'), var_enabled_count.dup(), rt.new_string('Approved product download directory views'), rt.new_string('woocommerce')]), var_enabled_count.dup()])
	mut var_disabled_url := rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('view'), rt.new_string('disabled'), this.get_base_url()])])
	mut var_disabled_class := rt.new_string(if rt.is_true(rt.identical(rt.new_string('disabled'), var_selected_view)) { rt.new_string('class="current"') } else { rt.new_string('') })
	mut var_disabled_text := rt.call_function('sprintf', [rt.call_function('_nx', [rt.new_string('Disabled <span class="count">(%s)</span>'), rt.new_string('Disabled <span class="count">(%s)</span>'), var_disabled_count.dup(), rt.new_string('Approved product download directory views'), rt.new_string('woocommerce')]), var_disabled_count.dup()])
	mut var_views := rt.create_array([rt.ArrayItem{ key: 'all', val: "<a href='${var_all_url.to_string()}' ${var_all_class.to_string()}>${var_all_text.to_string()}</a>" }, rt.ArrayItem{ key: 'enabled', val: "<a href='${var_enabled_url.to_string()}' ${var_enabled_class.to_string()}>${var_enabled_text.to_string()}</a>" }, rt.ArrayItem{ key: 'disabled', val: "<a href='${var_disabled_url.to_string()}' ${var_disabled_class.to_string()}>${var_disabled_text.to_string()}</a>" }])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table', ['WP_List_Table'], &this), 'screen'), 'render_screen_reader_content', [rt.new_string('heading_views')])
	print('<ul class="subsubsub list-table-filters">')
	{
		mut iter_1 := var_views.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_view := item_1.val
			mut var_slug := item_1.key
			var_views.array_set(var_slug, "<li class='${var_slug.to_string()}'>${var_view.to_string()}")
		}
	}
	print((rt.call_function('implode', [rt.new_string(' | </li>'), var_views.dup()])).str() + '</li>\n')
	print('</ul>')
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) get_columns() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'cb', val: '<input type="checkbox" />' }, rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('URL'), rt.new_string('Approved product download directories'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enabled', val: rt.call_function('_x', [rt.new_string('Enabled'), rt.new_string('Approved product download directories'), rt.new_string('woocommerce')]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) column_cb(var_item rt.PhpVal) rt.PhpVal {
	return rt.call_function('sprintf', [rt.new_string('<input type="checkbox" name="%1$s[]" value="%2$s" />'), rt.call_function('esc_attr', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table', ['WP_List_Table'], &this), '_args').array_get('singular')]), rt.call_function('esc_attr', [rt.call_method(var_item, 'get_id', []rt.PhpVal{})])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) column_title(var_item rt.PhpVal) string {
	mut var_id := // unsupported expression: Expr_Cast_Int
	mut var_url := rt.call_function('esc_html', [rt.call_method(var_item, 'get_url', []rt.PhpVal{})])
	mut var_enabled := rt.call_method(var_item, 'is_enabled', []rt.PhpVal{})
	mut var_edit_url := rt.call_function('esc_url', [this.get_action_url('edit', (var_id).to_i64(), '')])
	mut var_enable_disable_url := rt.call_function('esc_url', [if rt.is_true(var_enabled) { this.get_action_url('disable', (var_id).to_i64(), '') } else { this.get_action_url('enable', (var_id).to_i64(), '') }])
	mut var_enable_disable_text := rt.call_function('esc_html', [if rt.is_true(var_enabled) { rt.call_function('__', [rt.new_string('Disable'), rt.new_string('woocommerce')]) } else { rt.call_function('__', [rt.new_string('Enable'), rt.new_string('woocommerce')]) }])
	mut var_delete_url := rt.call_function('esc_url', [this.get_action_url('delete', (var_id).to_i64(), '')])
	mut var_edit_link := rt.new_string("<a href='${var_edit_url.to_string()}'>" + (rt.call_function('esc_html_x', [rt.new_string('Edit'), rt.new_string('Product downloads list'), rt.new_string('woocommerce')])).str() + '</a>')
	mut var_enable_disable_link := rt.new_string(rt.new_string("<a href='${var_enable_disable_url.to_string()}'>${var_enable_disable_text.to_string()}</a>"))
	mut var_delete_link := rt.new_string("<a href='${var_delete_url.to_string()}' class='submitdelete wc-confirm-delete'>" + (rt.call_function('esc_html_x', [rt.new_string('Delete permanently'), rt.new_string('Product downloads list'), rt.new_string('woocommerce')])).str() + '</a>')
	mut var_url_link := rt.new_string(rt.new_string("<a href='${var_edit_url.to_string()}'>${var_url.to_string()}</a>"))
	return "\n\t\t\t<strong>${var_url_link.to_string()}</strong>\n\t\t\t<div class='row-actions'>\n\t\t\t\t<span class='id'>ID: ${var_id.to_string()}</span> |\n\t\t\t\t<span class='edit'>${var_edit_link.to_string()}</span> |\n\t\t\t\t<span class='enable-disable'>${var_enable_disable_link.to_string()}</span> |\n\t\t\t\t<span class='delete'><a class='submitdelete'>${var_delete_link.to_string()}</a></span>\n\t\t\t</div>\n\t\t"
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) column_enabled(mut var_item Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_StoredUrl) string {
	return if rt.is_true(var_item.is_enabled()) { '<mark class="yes" title="' + (rt.call_function('esc_html__', [rt.new_string('Enabled'), rt.new_string('woocommerce')])).str() + '"><span class="dashicons dashicons-yes"></span></mark>' } else { '<mark class="no" title="' + (rt.call_function('esc_html__', [rt.new_string('Disabled'), rt.new_string('woocommerce')])).str() + '">&ndash;</mark>' }
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) get_bulk_actions() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'enable', val: rt.call_function('__', [rt.new_string('Enable rule'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'disable', val: rt.call_function('__', [rt.new_string('Disable rule'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'delete', val: rt.call_function('__', [rt.new_string('Delete permanently'), rt.new_string('woocommerce')]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) get_action_url(action string, id i64, nonce_action string) string {
	mut id_mutated := id
	return (rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'check', val: rt.call_function('wp_create_nonce', [rt.new_string(nonce_action)]) }, rt.ArrayItem{ key: 'action', val: action }, rt.ArrayItem{ key: 'url', val: id_mutated }]), this.get_base_url()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) get_base_url() string {
	return (rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: 'wc-settings' }, rt.ArrayItem{ key: 'tab', val: 'products' }, rt.ArrayItem{ key: 'section', val: 'download_urls' }]), rt.call_function('admin_url', [rt.new_string('admin.php')])])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) display_tablenav(var_which rt.PhpVal)  {
	mut var_directories := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.class()])
	print('<div class="tablenav ' + (rt.call_function('esc_attr', [var_which.dup()])).str() + '">')
	if rt.is_true(this.has_items()) {
		print('<div class="alignleft actions bulkactions">')
		this.bulk_actions(var_which.dup())
		if rt.is_true(rt.greater(rt.call_method(var_directories, 'count', [rt.new_bool(false)]), rt.new_int(0))) {
			print('<a href="' + (rt.call_function('esc_url', [this.get_action_url('enable-all', 0, '')])).str() + '" class="wp-core-ui button">' + (rt.call_function('esc_html_x', [rt.new_string('Enable All'), rt.new_string('Approved product download directories'), rt.new_string('woocommerce')])).str() + '</a> ')
		}
		if rt.is_true(rt.greater(rt.call_method(var_directories, 'count', [rt.new_bool(true)]), rt.new_int(0))) {
			print('<a href="' + (rt.call_function('esc_url', [this.get_action_url('disable-all', 0, '')])).str() + '" class="wp-core-ui button">' + (rt.call_function('esc_html_x', [rt.new_string('Disable All'), rt.new_string('Approved product download directories'), rt.new_string('woocommerce')])).str() + '</a>')
		}
		print('</div>')
	}
	this.pagination(var_which.dup())
	print('<br class="clear" />')
	print('</div>')
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) prepare_items()  {
	mut var_current_page := this.get_pagenum()
	mut var_per_page := this.get_items_per_page(rt.new_string('edit_approved_directories_per_page'))
	mut var_search := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_REQUEST').array_get('s')).is_null() { rt.get_superglobal('_REQUEST').array_get('s') } else { rt.new_string('') }])])
	mut switch_val_1 := if !(rt.get_superglobal('_REQUEST').array_get('view')).is_null() { rt.get_superglobal('_REQUEST').array_get('view') } else { rt.new_string('') }
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('enabled'))) {
		mut var_enabled := rt.new_bool(rt.new_bool(true))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('disabled'))) {
		var_enabled = rt.new_bool(rt.new_bool(false))
	} else {
		var_enabled = rt.new_null()
	}
	mut var_approved_directories := rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.class()]), 'list', [rt.create_array([rt.ArrayItem{ key: 'page', val: var_current_page }, rt.ArrayItem{ key: 'per_page', val: var_per_page }, rt.ArrayItem{ key: 'search', val: var_search }, rt.ArrayItem{ key: 'enabled', val: var_enabled }])])
	this.dispatch_set_prop('items', var_approved_directories.array_get('approved_directories'))
	this.set_pagination_args(rt.create_array([rt.ArrayItem{ key: 'total_items', val: var_approved_directories.array_get('total_urls') }, rt.ArrayItem{ key: 'total_pages', val: var_approved_directories.array_get('total_pages') }, rt.ArrayItem{ key: 'per_page', val: var_per_page }]))
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productdownloads_approveddirectories_admin_table() &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_list_table() &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'items_per_page' {
			this.items_per_page()
			return rt.new_null()
		}
		'set_items_per_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.set_items_per_page(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'no_items' {
			this.no_items()
			return rt.new_null()
		}
		'render_views' {
			this.render_views()
			return rt.new_null()
		}
		'get_columns' {
			return this.get_columns()
		}
		'column_cb' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_cb(dispatch_arg_0)
		}
		'column_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.column_title(dispatch_arg_0))
		}
		'column_enabled' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_StoredUrl](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.column_enabled(mut dispatch_arg_0))
		}
		'get_bulk_actions' {
			return this.get_bulk_actions()
		}
		'get_action_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(this.get_action_url(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_base_url' {
			return rt.new_string(this.get_base_url())
		}
		'display_tablenav' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.display_tablenav(dispatch_arg_0)
			return rt.new_null()
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_productdownloads_approveddirectories_admin_table_php() {
}
