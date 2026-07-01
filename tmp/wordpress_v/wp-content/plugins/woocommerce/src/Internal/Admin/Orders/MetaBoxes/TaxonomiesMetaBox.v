import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_TaxonomiesMetaBox {
	rt.PhpObjectBase
pub mut:
	orders_table_data_store rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_TaxonomiesMetaBox) init(mut var_orders_table_data_store Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) {
	this.orders_table_data_store = var_orders_table_data_store.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_TaxonomiesMetaBox) add_taxonomies_meta_boxes(screen_id string, order_type string) {
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/meta-boxes.php', '2')
	mut var_taxonomies := rt.call_function('get_object_taxonomies', [
		rt.new_string(order_type),
	])
	{
		mut iter_1 := var_taxonomies.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax_name := item_1.val
			mut var_taxonomy := rt.call_function('get_taxonomy', [
				var_tax_name.dup()])
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_taxonomy, 'show_ui')))))
				|| rt.is_true(rt.identical(rt.new_bool(false), rt.get_property(var_taxonomy, 'meta_box_cb')))))
			{
				continue
			}
			if rt.is_true(rt.identical(rt.new_string('post_categories_meta_box'), rt.get_property(var_taxonomy,
				'meta_box_cb')))
			{
				rt.set_property(var_taxonomy, 'meta_box_cb', rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_TaxonomiesMetaBox',
						[]string{}, &this) },
					rt.ArrayItem{ key: none, val: 'order_categories_meta_box' },
				]))
			}
			if rt.is_true(rt.identical(rt.new_string('post_tags_meta_box'), rt.get_property(var_taxonomy,
				'meta_box_cb')))
			{
				rt.set_property(var_taxonomy, 'meta_box_cb', rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_TaxonomiesMetaBox',
						[]string{}, &this) },
					rt.ArrayItem{ key: none, val: 'order_tags_meta_box' },
				]))
			}
			mut var_label := rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'name')
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
				var_tax_name.dup(),
			])))))
			{
				mut var_tax_meta_box_id := rt.new_string('tagsdiv-' + var_tax_name.str())
			} else {
				var_tax_meta_box_id = rt.new_string(var_tax_name.str() + 'div')
			}
			rt.call_function('add_meta_box', [var_tax_meta_box_id.dup(),
				var_label.dup(), rt.get_property(var_taxonomy, 'meta_box_cb'),
				rt.new_string(screen_id), rt.new_string('side'),
				rt.new_string('core'),
				rt.create_array([
					rt.ArrayItem{ key: 'taxonomy', val: var_tax_name },
					rt.ArrayItem{ key: '__back_compat_meta_box', val: true },
				])])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_TaxonomiesMetaBox) save_taxonomies(mut var_order Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_WC_Abstract_Order, var_taxonomy_input rt.PhpVal) {
	if !(!var_taxonomy_input.is_null()) {
		return rt.new_null()
	}
	mut var_sanitized_tax_input := this.sanitize_tax_input(var_taxonomy_input.dup())
	var_sanitized_tax_input = rt.call_method(this.orders_table_data_store,
		'init_default_taxonomies', [var_order, var_sanitized_tax_input.dup()])
	rt.call_method(this.orders_table_data_store, 'set_custom_taxonomies',
		[var_order, var_sanitized_tax_input.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_TaxonomiesMetaBox) sanitize_tax_input(var_taxonomy_data rt.PhpVal) rt.PhpVal {
	mut var_sanitized_tax_input := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_taxonomy_data.dup().is_array()))))) {
		return var_sanitized_tax_input.dup()
	}
	{
		mut iter_1 := var_taxonomy_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_terms := item_1.val
			mut var_taxonomy := item_1.key
			mut var_tax_object := rt.call_function('get_taxonomy', [
				var_taxonomy.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(var_tax_object)
				&& !(rt.get_property(var_tax_object, 'meta_box_sanitize_cb')).is_null()))
			{
				var_sanitized_tax_input.array_set(var_taxonomy, rt.call_function('call_user_func_array', [
					rt.get_property(var_tax_object, 'meta_box_sanitize_cb'),
					rt.create_array([rt.ArrayItem{ key: none, val: var_taxonomy },
						rt.ArrayItem{ key: none, val: var_terms }]),
				]))
			}
		}
	}
	return var_sanitized_tax_input.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_TaxonomiesMetaBox) order_categories_meta_box(var_order rt.PhpVal, var_box rt.PhpVal) {
	mut var_post := rt.call_function('get_post', [
		rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
	])
	rt.call_function('post_categories_meta_box', [var_post.dup(),
		var_box.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_TaxonomiesMetaBox) order_tags_meta_box(var_order rt.PhpVal, var_box rt.PhpVal) {
	mut var_post := rt.call_function('get_post', [
		rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
	])
	rt.call_function('post_tags_meta_box', [var_post.dup(), var_box.dup()])
}

fn create_automattic_woocommerce_internal_admin_orders_metaboxes_taxonomiesmetabox() &Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_TaxonomiesMetaBox {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_TaxonomiesMetaBox{
		PhpObjectBase:           rt.PhpObjectBase{}
		orders_table_data_store: rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_TaxonomiesMetaBox) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'add_taxonomies_meta_boxes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.add_taxonomies_meta_boxes(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'save_taxonomies' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_WC_Abstract_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.save_taxonomies(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'sanitize_tax_input' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_tax_input(dispatch_arg_0)
		}
		'order_categories_meta_box' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.order_categories_meta_box(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'order_tags_meta_box' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.order_tags_meta_box(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_TaxonomiesMetaBox) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'orders_table_data_store' { return this.orders_table_data_store }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_TaxonomiesMetaBox) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'orders_table_data_store' {
			this.orders_table_data_store = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_internal_admin_orders_metaboxes_taxonomiesmetabox_php() {
}
