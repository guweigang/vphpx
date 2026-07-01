import rt

fn wc_admin_get_core_pages_to_connect() rt.PhpVal {
	mut var_all_reports := fn () rt.PhpVal {
		mut temp := Class_WC_Admin_Reports{}
		return temp.get_reports()
	}()
	mut var_report_tabs := rt.new_array()
	{
		mut iter_1 := var_all_reports.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_report_data := item_1.val
			mut var_report_id := item_1.key
			var_report_tabs.array_set(var_report_id, var_report_data.array_get('title'))
		}
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'wc-addons', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Extensions'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'tabs', val: rt.new_array() },
		]) },
		rt.ArrayItem{ key: 'wc-reports', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Reports'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'tabs', val: var_report_tabs },
		]) },
		rt.ArrayItem{ key: 'wc-settings', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Settings'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'tabs', val: rt.call_function('apply_filters', [
				rt.new_string('woocommerce_settings_tabs_array'),
				rt.new_array(),
			]) },
		]) },
		rt.ArrayItem{ key: 'wc-status', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Status'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'tabs', val: rt.call_function('apply_filters', [
				rt.new_string('woocommerce_admin_status_tabs'),
				rt.create_array([
					rt.ArrayItem{ key: 'status', val: rt.call_function('__', [
						rt.new_string('System status'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'tools', val: rt.call_function('__', [
						rt.new_string('Tools'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'logs', val: rt.call_function('__', [
						rt.new_string('Logs'),
						rt.new_string('woocommerce'),
					]) },
				]),
			]) },
		]) },
	])
}

fn wc_admin_filter_core_page_breadcrumbs(var_breadcrumbs rt.PhpVal) rt.PhpVal {
	mut var_screen_id := rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Admin_PageController{}
		return temp.get_instance()
	}(), 'get_current_screen_id', []rt.PhpVal{})
	mut var_pages_to_connect := wc_admin_get_core_pages_to_connect()
	mut var_woocommerce_breadcrumb := [rt.new_string('admin.php?page=wc-admin'),
		rt.call_function('__', [rt.new_string('WooCommerce'),
			rt.new_string('woocommerce')])]
	{
		mut iter_1 := var_pages_to_connect.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_page_data := item_1.val
			mut var_page_id := item_1.key
			if rt.is_true(rt.call_function('preg_match', [
				rt.new_string('/^woocommerce_page_${var_page_id.to_string()}\\-/'),
				var_screen_id.dup(),
			]))
			{
				if !rt.is_true(var_page_data.array_get('tabs')) {
					mut var_new_breadcrumbs := [var_woocommerce_breadcrumb, var_page_data.array_get('title')]
				} else {
					var_new_breadcrumbs = [var_woocommerce_breadcrumb,
						[
							rt.call_function('add_query_arg', [
								rt.new_string('page'), var_page_id.dup(),
								rt.new_string('admin.php')]),
							var_page_data.array_get('title'),
						]]
					if rt.get_superglobal('_GET').array_isset(rt.new_string('tab')) {
						mut var_current_tab := rt.call_function('wc_clean', [
							rt.call_function('wp_unslash',
								[rt.get_superglobal('_GET').array_get('tab')]),
						])
					} else {
						var_current_tab = rt.call_function('key', [
							var_page_data.array_get('tabs')])
					}
					var_new_breadcrumbs << var_page_data.array_get('tabs').array_get(var_current_tab)
				}
				return var_new_breadcrumbs.dup()
			}
		}
	}
	return var_breadcrumbs.dup()
}

fn wc_admin_connect_core_pages(var_is_connected rt.PhpVal, var_current_page rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_is_connected))
		&& rt.is_true(rt.identical(rt.new_bool(false), var_current_page))))
	{
		mut var_screen_id := rt.call_method(fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Admin_PageController{}
			return temp.get_instance()
		}(), 'get_current_screen_id', []rt.PhpVal{})
		mut var_pages_to_connect := wc_admin_get_core_pages_to_connect()
		{
			mut iter_1 := var_pages_to_connect.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_page_data := item_1.val
				mut var_page_id := item_1.key
				if rt.is_true(rt.call_function('preg_match', [
					rt.new_string('/^woocommerce_page_${var_page_id.to_string()}\\-/'),
					var_screen_id.dup(),
				]))
				{
					rt.call_function('add_filter', [
						rt.new_string('woocommerce_navigation_get_breadcrumbs'),
						rt.new_string('wc_admin_filter_core_page_breadcrumbs'),
					])
					return true
				}
			}
		}
	}
	return var_is_connected.to_bool()
}

struct Class_WC_Admin_Reports {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

fn create_wc_admin_reports() &Class_WC_Admin_Reports {
	mut obj := &Class_WC_Admin_Reports{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller() &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Reports) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Reports) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Reports) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PageController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_react_admin_connect_existing_pages_php() {
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_navigation_is_connected_page'),
		rt.new_string('wc_admin_connect_core_pages'),
		rt.new_int(10),
		rt.new_int(2),
	])
	mut var_posttype_list_base := 'edit.php'
	rt.call_function('wc_admin_connect_page', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-orders' },
			rt.ArrayItem{ key: 'screen_id', val: 'edit-shop_order' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Orders'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'path', val: rt.call_function('add_query_arg', [
				rt.new_string('post_type'),
				rt.new_string('shop_order'),
				rt.new_string(var_posttype_list_base).dup(),
			]) }]),
	])
	rt.call_function('wc_admin_connect_page', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-add-order' },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-orders' },
			rt.ArrayItem{ key: 'screen_id', val: 'shop_order-add' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Add New'),
				rt.new_string('woocommerce'),
			]) }]),
	])
	rt.call_function('wc_admin_connect_page', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-edit-order' },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-orders' },
			rt.ArrayItem{ key: 'screen_id', val: 'shop_order' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Edit Order'),
				rt.new_string('woocommerce'),
			]) }]),
	])
	if rt.is_true(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
		return temp.custom_orders_table_usage_is_enabled()
	}())
	{
		rt.call_function('wc_admin_connect_page', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-custom-orders' },
				rt.ArrayItem{ key: 'screen_id', val: rt.call_function('wc_get_page_screen_id', [
					rt.new_string('shop-order'),
				]) }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Orders'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'path', val: 'admin.php?page=wc-orders' }]),
		])
	}
	rt.call_function('wc_admin_connect_page', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-coupons' },
			rt.ArrayItem{
				key: 'parent'
				val: if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
					mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}return temp.is_enabled(arg_0)}(rt.new_string('coupons')))
				{ rt.new_string('woocommerce-marketing') } else { rt.new_null() }
			}, rt.ArrayItem{ key: 'screen_id', val: 'edit-shop_coupon' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Coupons'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'path', val: rt.call_function('add_query_arg', [
				rt.new_string('post_type'),
				rt.new_string('shop_coupon'),
				rt.new_string(var_posttype_list_base).dup(),
			]) }]),
	])
	rt.call_function('wc_admin_connect_page', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-add-coupon' },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-coupons' },
			rt.ArrayItem{ key: 'screen_id', val: 'shop_coupon-add' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Add New'),
				rt.new_string('woocommerce'),
			]) }]),
	])
	rt.call_function('wc_admin_connect_page', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-edit-coupon' },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-coupons' },
			rt.ArrayItem{ key: 'screen_id', val: 'shop_coupon' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Edit Coupon'),
				rt.new_string('woocommerce'),
			]) }]),
	])
	rt.call_function('wc_admin_connect_page', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-products' },
			rt.ArrayItem{ key: 'screen_id', val: 'edit-product' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Products'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'path', val: rt.call_function('add_query_arg', [
				rt.new_string('post_type'),
				rt.new_string('product'),
				rt.new_string(var_posttype_list_base).dup(),
			]) }]),
	])
	rt.call_function('wc_admin_connect_page', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-add-product' },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-products' },
			rt.ArrayItem{ key: 'screen_id', val: 'product-add' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Add New'),
				rt.new_string('woocommerce'),
			]) }]),
	])
	rt.call_function('wc_admin_connect_page', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-edit-product' },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-products' },
			rt.ArrayItem{ key: 'screen_id', val: 'product' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Edit Product'),
				rt.new_string('woocommerce'),
			]) }]),
	])
	rt.call_function('wc_admin_connect_page', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-import-products' },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-products' },
			rt.ArrayItem{ key: 'screen_id', val: 'product_page_product_importer' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Import Products'),
				rt.new_string('woocommerce'),
			]) }]),
	])
	rt.call_function('wc_admin_connect_page', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-export-products' },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-products' },
			rt.ArrayItem{ key: 'screen_id', val: 'product_page_product_exporter' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Export Products'),
				rt.new_string('woocommerce'),
			]) }]),
	])
	rt.call_function('wc_admin_connect_page', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce-product-categories' },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-products' },
			rt.ArrayItem{ key: 'screen_id', val: 'edit-product_cat' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Product categories'),
				rt.new_string('woocommerce'),
			]) },
		]),
	])
	rt.call_function('wc_admin_connect_page', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce-product-edit-category' },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-products' },
			rt.ArrayItem{ key: 'screen_id', val: 'product_cat' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Edit category'),
				rt.new_string('woocommerce'),
			]) },
		]),
	])
	rt.call_function('wc_admin_connect_page', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-product-tags' },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-products' },
			rt.ArrayItem{ key: 'screen_id', val: 'edit-product_tag' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Product tags'),
				rt.new_string('woocommerce'),
			]) }]),
	])
	rt.call_function('wc_admin_connect_page', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-product-edit-tag' },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-products' },
			rt.ArrayItem{ key: 'screen_id', val: 'product_tag' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Edit tag'),
				rt.new_string('woocommerce'),
			]) }]),
	])
	rt.call_function('wc_admin_connect_page', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce-product-attributes' },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-products' },
			rt.ArrayItem{ key: 'screen_id', val: 'product_page_product_attributes' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Attributes'),
				rt.new_string('woocommerce'),
			]) },
		]),
	])
	rt.call_function('wc_admin_connect_page', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-product-reviews' },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-products' },
			rt.ArrayItem{ key: 'screen_id', val: 'product_page_product-reviews' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Product Reviews'),
				rt.new_string('woocommerce'),
			]) }]),
	])
	rt.call_function('wc_admin_connect_page', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce-product-edit-attribute' },
			rt.ArrayItem{ key: 'parent', val: 'woocommerce-products' },
			rt.ArrayItem{ key: 'screen_id', val: 'product_page_product_attribute-edit' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Edit attribute'),
				rt.new_string('woocommerce'),
			]) },
		]),
	])
}
