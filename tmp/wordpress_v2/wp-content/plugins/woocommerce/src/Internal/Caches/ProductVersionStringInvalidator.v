import rt

pub fn Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator.default_taxonomy_lookup_cache_ttl() i64 {
	return 300
}
struct Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) init() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_feature_rest_api_caching_enabled')]))))) {
		return
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_rest_api_enable_backend_caching'), rt.new_string('no')]))) {
		this.register_hooks()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) register_hooks() {
	rt.call_function('add_action', [rt.new_string('save_post_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_save_post_product' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('delete_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_delete_post' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('trashed_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_trashed_post' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('untrashed_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_untrashed_post' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('transition_post_status'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_transition_post_status' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_new_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_woocommerce_new_product' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_update_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_woocommerce_update_product' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_before_delete_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_woocommerce_before_delete_product' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_trash_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_woocommerce_trash_product' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_new_product_variation'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_woocommerce_new_product_variation' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_update_product_variation'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_woocommerce_update_product_variation' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_before_delete_product_variation'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_woocommerce_before_delete_product_variation' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_trash_product_variation'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_woocommerce_trash_product_variation' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_updated_product_stock'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_woocommerce_updated_product_stock' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_updated_product_price'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_woocommerce_updated_product_price' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_updated_product_sales'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_woocommerce_updated_product_sales' }]), rt.new_int(10), rt.new_int(1)])
	if this.is_using_cpt_data_store() {
		rt.call_function('add_action', [rt.new_string('woocommerce_attribute_updated'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_woocommerce_attribute_updated' }]), rt.new_int(10), rt.new_int(2)])
		rt.call_function('add_action', [rt.new_string('woocommerce_attribute_deleted'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_woocommerce_attribute_deleted' }]), rt.new_int(10), rt.new_int(3)])
		rt.call_function('add_action', [rt.new_string('woocommerce_updated_product_attribute_summary'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_woocommerce_updated_product_attribute_summary' }]), rt.new_int(10), rt.new_int(1)])
		rt.call_function('add_action', [rt.new_string('edited_term'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_edited_term' }]), rt.new_int(10), rt.new_int(3)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) is_using_cpt_data_store() bool {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Caches_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('product'))
	mut var_data_store := iife_result_0
	return (rt.identical(rt.call_method(var_data_store, 'get_current_class_name', []rt.PhpVal{}), rt.new_string('WC_Product_Data_Store_CPT'))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_save_post_product(var_post_id rt.PhpVal) {
	mut var_post_id_mutated := var_post_id
	var_post_id_mutated = rt.new_int((var_post_id_mutated).to_i64())
	if rt.is_true(rt.call_function('wp_is_post_autosave', [var_post_id_mutated.clone()])) || rt.is_true(rt.call_function('wp_is_post_revision', [var_post_id_mutated.clone()])) {
		return
	}
	this.invalidate((var_post_id_mutated).to_i64())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_delete_post(var_post_id rt.PhpVal, var_post rt.PhpVal) {
	mut var_post_id_mutated := var_post_id
	mut var_post_mutated := var_post
	var_post_id_mutated = rt.new_int((var_post_id_mutated).to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post_mutated, 'Automattic_WooCommerce_Internal_Caches_WP_Post')))))) {
	var_post_mutated = rt.call_function('get_post', [var_post_id_mutated.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_mutated)))) {
		return
	}
	if rt.is_true(rt.identical(rt.new_string('product_variation'), rt.get_property(var_post_mutated, 'post_type'))) {
		mut var_parent_id := rt.new_int((rt.get_property(var_post_mutated, 'post_parent')).to_i64())
		this.invalidate_variation_and_parent((var_post_id_mutated).to_i64(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Caches_?int](var_parent_id))
		this.invalidate_variations_list(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Caches_?int](var_parent_id))
		this.invalidate_variation_parent_cache((var_post_id_mutated).to_i64())
	} else if rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(var_post_mutated, 'post_type'))) {
		this.invalidate((var_post_id_mutated).to_i64())
		this.invalidate_products_list()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_trashed_post(var_post_id rt.PhpVal) {
	mut var_post_id_mutated := var_post_id
	this.handle_trashed_or_untrashed_post(rt.new_int((var_post_id_mutated).to_i64()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_untrashed_post(var_post_id rt.PhpVal) {
	mut var_post_id_mutated := var_post_id
	this.handle_trashed_or_untrashed_post(rt.new_int((var_post_id_mutated).to_i64()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_transition_post_status(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_post rt.PhpVal) {
	mut var_post_mutated := var_post
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post_mutated, 'Automattic_WooCommerce_Internal_Caches_WP_Post')))))) {
		return
	}
	if rt.is_true(rt.identical(var_new_status, var_old_status)) {
		return
	}
	if rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(var_post_mutated, 'post_type'))) {
		this.invalidate_products_list()
	} else if rt.is_true(rt.identical(rt.new_string('product_variation'), rt.get_property(var_post_mutated, 'post_type'))) {
		this.invalidate_variations_list(mut rt.new_int((rt.get_property(var_post_mutated, 'post_parent')).to_i64()))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_trashed_or_untrashed_post(post_id i64) {
	mut post_id_mutated := post_id
	mut var_post := rt.call_function('get_post', [rt.new_int(post_id_mutated).clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return
	}
	if rt.is_true(rt.identical(rt.new_string('product_variation'), rt.get_property(var_post, 'post_type'))) {
		mut var_parent_id := rt.new_int((rt.get_property(var_post, 'post_parent')).to_i64())
		this.invalidate_variation_and_parent(post_id_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Caches_?int](var_parent_id))
		this.invalidate_variations_list(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Caches_?int](var_parent_id))
		this.invalidate_variation_parent_cache(post_id_mutated)
	} else if rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(var_post, 'post_type'))) {
		this.invalidate(post_id_mutated)
		this.invalidate_products_list()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_woocommerce_new_product_variation(var_variation_id rt.PhpVal, var_variation rt.PhpVal) {
	mut var_variation_id_mutated := var_variation_id
	mut var_variation_mutated := var_variation
	var_variation_id_mutated = rt.new_int((var_variation_id_mutated).to_i64())
	mut var_parent_id := if rt.is_true(rt.new_bool(rt.instance_of(var_variation_mutated, 'Automattic_WooCommerce_Internal_Caches_WC_Product'))) { rt.call_method(var_variation_mutated, 'get_parent_id', []rt.PhpVal{}) } else { rt.new_null() }
	this.invalidate_variation_and_parent((var_variation_id_mutated).to_i64(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Caches_?int](var_parent_id))
	this.invalidate_variations_list(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Caches_?int](var_parent_id))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_woocommerce_update_product_variation(var_variation_id rt.PhpVal, var_variation rt.PhpVal) {
	mut var_variation_id_mutated := var_variation_id
	mut var_variation_mutated := var_variation
	var_variation_id_mutated = rt.new_int((var_variation_id_mutated).to_i64())
	mut var_parent_id := if rt.is_true(rt.new_bool(rt.instance_of(var_variation_mutated, 'Automattic_WooCommerce_Internal_Caches_WC_Product'))) { rt.call_method(var_variation_mutated, 'get_parent_id', []rt.PhpVal{}) } else { rt.new_null() }
	this.invalidate_variation_and_parent((var_variation_id_mutated).to_i64(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Caches_?int](var_parent_id))
	this.invalidate_variation_parent_cache((var_variation_id_mutated).to_i64())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_woocommerce_new_product(var_product_id rt.PhpVal) {
	this.invalidate(rt.new_int((var_product_id).to_i64()))
	this.invalidate_products_list()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_woocommerce_update_product(var_product_id rt.PhpVal) {
	this.invalidate(rt.new_int((var_product_id).to_i64()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_woocommerce_before_delete_product(var_product_id rt.PhpVal) {
	this.invalidate(rt.new_int((var_product_id).to_i64()))
	this.invalidate_products_list()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_woocommerce_trash_product(var_product_id rt.PhpVal) {
	this.invalidate(rt.new_int((var_product_id).to_i64()))
	this.invalidate_products_list()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_woocommerce_before_delete_product_variation(var_variation_id rt.PhpVal) {
	mut var_variation_id_mutated := var_variation_id
	var_variation_id_mutated = rt.new_int((var_variation_id_mutated).to_i64())
	mut var_parent_id := rt.new_int(this.get_variation_parent_id((var_variation_id_mutated).to_i64()))
	this.invalidate_variation_and_parent((var_variation_id_mutated).to_i64(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Caches_?int](var_parent_id))
	this.invalidate_variations_list(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Caches_?int](var_parent_id))
	this.invalidate_variation_parent_cache((var_variation_id_mutated).to_i64())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_woocommerce_trash_product_variation(var_variation_id rt.PhpVal) {
	mut var_variation_id_mutated := var_variation_id
	var_variation_id_mutated = rt.new_int((var_variation_id_mutated).to_i64())
	mut var_parent_id := rt.new_int(this.get_variation_parent_id((var_variation_id_mutated).to_i64()))
	this.invalidate_variation_and_parent((var_variation_id_mutated).to_i64(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Caches_?int](var_parent_id))
	this.invalidate_variations_list(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Caches_?int](var_parent_id))
	this.invalidate_variation_parent_cache((var_variation_id_mutated).to_i64())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_woocommerce_updated_product_stock(var_product_id rt.PhpVal) {
	this.invalidate(rt.new_int((var_product_id).to_i64()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_woocommerce_updated_product_price(var_product_id rt.PhpVal) {
	this.invalidate(rt.new_int((var_product_id).to_i64()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_woocommerce_updated_product_sales(var_product_id rt.PhpVal) {
	this.invalidate(rt.new_int((var_product_id).to_i64()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_woocommerce_attribute_updated(var_id rt.PhpVal, var_data rt.PhpVal) {
	if !(var_data.clone().is_array()) || !(var_data.array_isset(rt.new_string('attribute_name'))) {
		return
	}
	mut var_taxonomy := rt.call_function('wc_attribute_taxonomy_name', [var_data.array_get(rt.new_string('attribute_name'))])
	this.invalidate_products_with_attribute((var_taxonomy).str())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_woocommerce_attribute_deleted(var_id rt.PhpVal, var_name rt.PhpVal, var_taxonomy rt.PhpVal) {
	mut var_taxonomy_mutated := var_taxonomy
	if !(var_taxonomy_mutated.clone().is_string()) || rt.is_true(rt.identical(rt.new_string(''), var_taxonomy_mutated)) {
		return
	}
	this.invalidate_products_with_attribute((var_taxonomy_mutated).str())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_woocommerce_updated_product_attribute_summary(var_variation_id rt.PhpVal) {
	mut var_variation_id_mutated := var_variation_id
	this.invalidate_variation_and_parent(rt.new_int((var_variation_id_mutated).to_i64()), rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) handle_edited_term(var_term_id rt.PhpVal, var_tt_id rt.PhpVal, var_taxonomy rt.PhpVal) {
	mut var_taxonomy_mutated := var_taxonomy
	if !(var_taxonomy_mutated.clone().is_string()) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_taxonomy_mutated.clone(), rt.new_string('pa_')]))))) {
		return
	}
	this.invalidate_products_with_term(rt.new_int((var_tt_id).to_i64()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) get_variation_parent_id(variation_id i64) i64 {
	mut variation_id_mutated := variation_id
	mut var_cache_key := rt.new_string("wc_variation_parent_${var_variation_id.to_string()}")
	mut var_cached := rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.new_string('woocommerce')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cached)))) {
		return (if rt.is_true(var_cached) { var_cached } else { rt.new_null() }).to_i64()
	}
	if this.is_using_cpt_data_store() {
	mut var_parent_id := rt.call_function('wp_get_post_parent_id', [rt.new_int(variation_id_mutated).clone()])
	var_parent_id = if rt.is_true(var_parent_id) { rt.new_int((var_parent_id).to_i64()) } else { rt.new_null() }
	} else {
	mut var_variation := rt.call_function('wc_get_product', [rt.new_int(variation_id_mutated).clone()])
	var_parent_id = if rt.is_true(var_variation) { rt.new_int((rt.call_method(var_variation, 'get_parent_id', []rt.PhpVal{})).to_i64()) } else { rt.new_null() }
	var_parent_id = if rt.is_true(var_parent_id) { var_parent_id } else { rt.new_null() }
	}
	rt.call_function('wp_cache_set', [var_cache_key.clone(), if !(var_parent_id).is_null() { var_parent_id } else { rt.new_int(0) }, rt.new_string('woocommerce'), rt.get_constant('HOUR_IN_SECONDS')])
	return (var_parent_id).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) invalidate_variation_parent_cache(variation_id i64) {
	mut variation_id_mutated := variation_id
	rt.call_function('wp_cache_delete', [rt.new_string("wc_variation_parent_${var_variation_id.to_string()}"), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) invalidate_variation_and_parent(variation_id i64, mut var_parent_id Class_Automattic_WooCommerce_Internal_Caches_?int) {
	mut variation_id_mutated := variation_id
	mut var_parent_id_mutated := var_parent_id
	this.invalidate(variation_id_mutated)
	if rt.is_true(rt.new_bool(var_parent_id_mutated.is_null())) {
	var_parent_id_mutated = rt.new_int(this.get_variation_parent_id(variation_id_mutated))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parent_id_mutated)))) {
		return
	}
	this.invalidate(var_parent_id_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) invalidate_products_with_term(tt_id i64) {
	mut var_wpdb := rt.new_null()
	mut var_cache_key := rt.new_string('wc_cache_inv_term_' + tt_id.str())
	mut var_entity_ids := rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.new_string('woocommerce')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_entity_ids)) {
		var_entity_ids = rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT tr.object_id\n\t\t\t\t\tFROM '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' tr\n\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' p ON tr.object_id = p.ID\n\t\t\t\t\tWHERE tr.term_taxonomy_id = %d\n\t\t\t\t\tAND p.post_type IN (\'product\', \'product_variation\')')), rt.new_int(tt_id)])])
		mut var_ttl := rt.call_function('apply_filters', [rt.new_string('woocommerce_version_string_invalidator_taxonomy_lookup_ttl'), Class_Automattic_WooCommerce_Internal_Caches_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator.default_taxonomy_lookup_cache_ttl(), rt.new_string('product')])
		rt.call_function('wp_cache_set', [var_cache_key.clone(), var_entity_ids.clone(), rt.new_string('woocommerce'), var_ttl.clone()])
	}
	mut iter_1 := var_entity_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_entity_id := item_1.val
		mut var_post_type := rt.call_function('get_post_type', [rt.new_int((var_entity_id).to_i64())])
		if rt.is_true(rt.identical(rt.new_string('product_variation'), var_post_type)) {
			this.invalidate_variation_and_parent(rt.new_int((var_entity_id).to_i64()), rt.new_null())
		} else {
			this.invalidate(rt.new_int((var_entity_id).to_i64()))
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) invalidate_products_with_attribute(taxonomy string) {
	mut var_wpdb := rt.new_null()
	mut taxonomy_mutated := taxonomy
	mut var_cache_key := rt.new_string('wc_cache_inv_attr_' + taxonomy_mutated)
	mut var_cached := rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.new_string('woocommerce')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_cached)) {
		mut var_product_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT DISTINCT post_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('\n\t\t\t\t\tWHERE meta_key = \'_product_attributes\'\n\t\t\t\t\tAND meta_value LIKE %s')), rt.new_string('%' + (rt.call_method(var_wpdb, 'esc_like', [rt.new_string('s:' + taxonomy_mutated.len.str() + ':"' + taxonomy_mutated + '"')])).str() + '%')])])
		mut var_variation_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT DISTINCT post_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('\n\t\t\t\t\tWHERE meta_key = %s')), rt.new_string('attribute_' + taxonomy_mutated)])])
		var_cached = rt.create_array([rt.ArrayItem{ key: 'product_ids', val: var_product_ids }, rt.ArrayItem{ key: 'variation_ids', val: var_variation_ids }])
		mut var_ttl := rt.call_function('apply_filters', [rt.new_string('woocommerce_version_string_invalidator_taxonomy_lookup_ttl'), Class_Automattic_WooCommerce_Internal_Caches_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator.default_taxonomy_lookup_cache_ttl(), rt.new_string('product')])
		rt.call_function('wp_cache_set', [var_cache_key.clone(), var_cached.clone(), rt.new_string('woocommerce'), var_ttl.clone()])
	}
	mut iter_2 := var_cached.array_get(rt.new_string('product_ids')).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_product_id := item_2.val
		this.invalidate(rt.new_int((var_product_id).to_i64()))
	}
	mut iter_3 := var_cached.array_get(rt.new_string('variation_ids')).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_variation_id := item_3.val
		this.invalidate_variation_and_parent(rt.new_int((var_variation_id).to_i64()), rt.new_null())
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) invalidate(product_id i64) {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator.class()]), 'delete_version', [rt.new_string("product_${var_product_id.str()}")])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) invalidate_products_list() {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator.class()]), 'delete_version', [rt.new_string('list_products')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) invalidate_variations_list(mut var_product_id Class_Automattic_WooCommerce_Internal_Caches_?int) {
	if rt.is_true(var_product_id) {
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator.class()]), 'delete_version', [rt.new_string("list_product_variations_${var_product_id.to_string()}")])
	}
}

struct Class_Automattic_WooCommerce_Internal_Caches_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_caches_productversionstringinvalidator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator {
	mut obj := &Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_caches_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Caches_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Internal_Caches_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'register_hooks' {
			this.register_hooks()
			return rt.new_null()
		}
		'is_using_cpt_data_store' {
			return rt.new_bool(this.is_using_cpt_data_store())
		}
		'handle_save_post_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_save_post_product(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_delete_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.handle_delete_post(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_trashed_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_trashed_post(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_untrashed_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_untrashed_post(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_transition_post_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.handle_transition_post_status(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'handle_trashed_or_untrashed_post' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.handle_trashed_or_untrashed_post(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_woocommerce_new_product_variation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.handle_woocommerce_new_product_variation(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_woocommerce_update_product_variation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.handle_woocommerce_update_product_variation(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_woocommerce_new_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_woocommerce_new_product(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_woocommerce_update_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_woocommerce_update_product(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_woocommerce_before_delete_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_woocommerce_before_delete_product(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_woocommerce_trash_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_woocommerce_trash_product(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_woocommerce_before_delete_product_variation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_woocommerce_before_delete_product_variation(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_woocommerce_trash_product_variation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_woocommerce_trash_product_variation(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_woocommerce_updated_product_stock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_woocommerce_updated_product_stock(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_woocommerce_updated_product_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_woocommerce_updated_product_price(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_woocommerce_updated_product_sales' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_woocommerce_updated_product_sales(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_woocommerce_attribute_updated' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.handle_woocommerce_attribute_updated(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_woocommerce_attribute_deleted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.handle_woocommerce_attribute_deleted(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'handle_woocommerce_updated_product_attribute_summary' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_woocommerce_updated_product_attribute_summary(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_edited_term' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.handle_edited_term(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_variation_parent_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_int(this.get_variation_parent_id(dispatch_arg_0))
		}
		'invalidate_variation_parent_cache' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.invalidate_variation_parent_cache(dispatch_arg_0)
			return rt.new_null()
		}
		'invalidate_variation_and_parent' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Caches_?int](if args.len > 1 { args[1] } else { rt.new_null() })
			this.invalidate_variation_and_parent(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'invalidate_products_with_term' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.invalidate_products_with_term(dispatch_arg_0)
			return rt.new_null()
		}
		'invalidate_products_with_attribute' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.invalidate_products_with_attribute(dispatch_arg_0)
			return rt.new_null()
		}
		'invalidate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.invalidate(dispatch_arg_0)
			return rt.new_null()
		}
		'invalidate_products_list' {
			this.invalidate_products_list()
			return rt.new_null()
		}
		'invalidate_variations_list' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Caches_?int](if args.len > 0 { args[0] } else { rt.new_null() })
			this.invalidate_variations_list(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductVersionStringInvalidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Caches_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Caches_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
