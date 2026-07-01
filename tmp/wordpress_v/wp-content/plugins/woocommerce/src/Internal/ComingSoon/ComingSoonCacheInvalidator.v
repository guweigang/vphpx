import rt

struct Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonCacheInvalidator {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonCacheInvalidator) init() {
	rt.call_function('add_action', [
		rt.new_string('update_option_woocommerce_coming_soon'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ComingSoon_ComingSoonCacheInvalidator',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'invalidate_caches' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('update_option_woocommerce_store_pages_only'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ComingSoon_ComingSoonCacheInvalidator',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'invalidate_caches' },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonCacheInvalidator) invalidate_caches() {
	rt.call_function('wp_cache_flush', []rt.PhpVal{})
	mut var_cart_page_id := if !(rt.call_function('get_option', [
		rt.new_string('woocommerce_cart_page_id'),
	])).is_null() { rt.call_function('get_option', [
			rt.new_string('woocommerce_cart_page_id'),
		]) } else { rt.new_null() }
	if rt.is_true(var_cart_page_id) {
		rt.call_function('wp_update_post', [
			rt.create_array([rt.ArrayItem{ key: 'ID', val: var_cart_page_id },
				rt.ArrayItem{ key: 'post_status', val: 'publish' }]),
		])
	}
}

fn create_automattic_woocommerce_internal_comingsoon_comingsooncacheinvalidator() &Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonCacheInvalidator {
	mut obj := &Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonCacheInvalidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonCacheInvalidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'invalidate_caches' {
			this.invalidate_caches()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonCacheInvalidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonCacheInvalidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_comingsoon_comingsooncacheinvalidator_php() {
}
