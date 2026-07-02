import rt

struct Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_blocks_utils_cartcheckoututils() {
		rt.init_static_prop('Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils', 'is_cart_page', rt.new_null())
		rt.init_static_prop('Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils', 'is_checkout_page', rt.new_null())
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_page_type(page_type string) bool {
	mut var_post := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('wp')]))))) {
		return (rt.new_null()).to_bool()
	}
	mut var_page_id := rt.call_function('wc_get_page_id', [rt.new_string(page_type)])
	if rt.is_true(var_page_id) && rt.is_true(rt.call_function('is_page', [var_page_id.clone()])) {
		return true
	}
	if rt.is_true(rt.identical(rt.new_null(), var_post)) {
		return (rt.new_null()).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_Blocks_Utils_WP_Post'))) {
		return rt.is_true(rt.call_function('wc_post_content_has_shortcode', [rt.new_string((if rt.is_true(rt.identical(rt.new_string('cart'), rt.new_string(page_type))) { 'woocommerce_cart' } else { 'woocommerce_checkout' }).str())])) || rt.is_true(Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.has_block_variation(rt.new_string('woocommerce/classic-shortcode'), rt.new_string('shortcode'), rt.new_string(page_type), rt.get_property(var_post, 'post_content')))
	}
	return false
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_cart_page() bool {
	if rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils', 'is_cart_page'))) {
		rt.set_static_prop('Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils', 'is_cart_page', Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_page_type('cart'))
	}
	return (rt.identical(rt.new_bool(true), rt.get_static_prop('Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils', 'is_cart_page'))).to_bool()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_checkout_page() bool {
	if rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils', 'is_checkout_page'))) {
		rt.set_static_prop('Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils', 'is_checkout_page', Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_page_type('checkout'))
	}
	return (rt.identical(rt.new_bool(true), rt.get_static_prop('Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils', 'is_checkout_page'))).to_bool()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.shipping_methods_exist() rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_method := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!(rt.get_property(var_method, 'enabled')).is_null() && rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(var_method, 'enabled'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_method, 'supports', [rt.new_string('shipping-zones')]))))) && rt.is_true(rt.call_method(var_method, 'supports', [rt.new_string('local-pickup')])))
		}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_method := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!(rt.get_property(var_method, 'enabled')).is_null() && rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(var_method, 'enabled'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_method, 'supports', [rt.new_string('shipping-zones')]))))) && rt.is_true(rt.call_method(var_method, 'supports', [rt.new_string('local-pickup')])))
		}
	mut var_local_pickup_count := rt.new_int(rt.call_function('array_filter', [rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'get_shipping_methods', []rt.PhpVal{}), rt.new_closure(closure_1_fn)]).array_count())
	mut var_shipping_methods_count := rt.sub(rt.call_function('wc_get_shipping_method_count', [rt.new_bool(true), rt.new_bool(true)]), var_local_pickup_count)
	return rt.greater(var_shipping_methods_count, rt.new_int(0))
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.has_block_variation(var_block_id rt.PhpVal, var_attribute rt.PhpVal, var_value rt.PhpVal, var_post_content rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_content)))) {
		return false
	}
	mut iife_temp_2 := Class_Automattic_Block_Scanner{}
	mut iife_result_2 := iife_temp_2.create(var_post_content.clone())
	mut var_scanner := iife_result_2
	if rt.is_true(rt.new_bool(!(rt.is_true(var_scanner)))) {
		return false
	}
	for rt.is_true(rt.call_method(var_scanner, 'next_delimiter', []rt.PhpVal{})) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_scanner, 'opens_block', [var_block_id.clone()]))))) {
			continue
		}
		mut var_attrs := rt.call_method(var_scanner, 'allocate_and_return_parsed_attributes', []rt.PhpVal{})
		if var_attrs.array_isset(var_attribute) && rt.is_true(rt.identical(var_value, var_attrs.array_get(var_attribute))) {
			return true
		}
		if rt.is_true(rt.identical(rt.new_string('woocommerce/classic-shortcode'), var_block_id)) && rt.is_true(rt.identical(rt.new_string('shortcode'), var_attribute)) && rt.is_true(rt.identical(rt.new_string('cart'), var_value)) && !(var_attrs.array_isset(rt.new_string('shortcode'))) {
			return true
		}
	}
	return false
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_cart_block_default() bool {
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		mut iife_temp_3 := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}
		mut iife_result_3 := iife_temp_3.get_block_templates_from_db(rt.create_array([rt.ArrayItem{ key: none, val: 'cart' }]), rt.new_string('wp_template'))
		mut var_templates_from_db := iife_result_3
		mut iter_1 := var_templates_from_db.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_template := item_1.val
			if rt.is_true(rt.call_function('has_block', [rt.new_string('woocommerce/cart'), rt.get_property(var_template, 'content')])) {
				return true
			}
		}
	}
	mut var_cart_page_id := rt.call_function('wc_get_page_id', [rt.new_string('cart')])
	return rt.is_true(var_cart_page_id) && rt.is_true(rt.call_function('has_block', [rt.new_string('woocommerce/cart'), var_cart_page_id.clone()]))
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_checkout_block_default() bool {
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		mut iife_temp_4 := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}
		mut iife_result_4 := iife_temp_4.get_block_templates_from_db(rt.create_array([rt.ArrayItem{ key: none, val: 'checkout' }]), rt.new_string('wp_template'))
		mut var_templates_from_db := iife_result_4
		mut iter_2 := var_templates_from_db.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_template := item_2.val
			if rt.is_true(rt.call_function('has_block', [rt.new_string('woocommerce/checkout'), rt.get_property(var_template, 'content')])) {
				return true
			}
		}
	}
	mut var_checkout_page_id := rt.call_function('wc_get_page_id', [rt.new_string('checkout')])
	return rt.is_true(var_checkout_page_id) && rt.is_true(rt.call_function('has_block', [rt.new_string('woocommerce/checkout'), var_checkout_page_id.clone()]))
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.migrate_checkout_block_field_visibility_attributes() {
	rt.call_function('update_option', [rt.new_string('woocommerce_checkout_phone_field'), rt.new_string('optional')])
	rt.call_function('update_option', [rt.new_string('woocommerce_checkout_company_field'), rt.new_string('hidden')])
	rt.call_function('update_option', [rt.new_string('woocommerce_checkout_address_2_field'), rt.new_string('optional')])
	mut iife_temp_5 := Class_Automattic_WooCommerce_Blocks_Utils_WC_Blocks_Utils{}
	mut iife_result_5 := iife_temp_5.get_blocks_from_page(rt.new_string('woocommerce/checkout'), rt.new_string('checkout'))
	mut var_checkout_blocks := iife_result_5
	if !rt.is_true(var_checkout_blocks) || !(var_checkout_blocks.array_get(rt.new_int(0)).array_isset(rt.new_string('attrs'))) {
		return
	}
	mut var_block_attributes := rt.call_function('wp_parse_args', [var_checkout_blocks.array_get(rt.new_int(0)).array_get(rt.new_string('attrs')), rt.create_array([rt.ArrayItem{ key: 'showPhoneField', val: true }, rt.ArrayItem{ key: 'requirePhoneField', val: false }, rt.ArrayItem{ key: 'showCompanyField', val: false }, rt.ArrayItem{ key: 'requireCompanyField', val: false }, rt.ArrayItem{ key: 'showApartmentField', val: true }, rt.ArrayItem{ key: 'requireApartmentField', val: false }])])
	if rt.is_true(var_block_attributes.array_get(rt.new_string('showPhoneField'))) {
		rt.call_function('update_option', [rt.new_string('woocommerce_checkout_phone_field'), rt.new_string((if rt.is_true(var_block_attributes.array_get(rt.new_string('requirePhoneField'))) { 'required' } else { 'optional' }).str())])
	} else {
		rt.call_function('update_option', [rt.new_string('woocommerce_checkout_phone_field'), rt.new_string('hidden')])
	}
	if rt.is_true(var_block_attributes.array_get(rt.new_string('showCompanyField'))) {
		rt.call_function('update_option', [rt.new_string('woocommerce_checkout_company_field'), rt.new_string((if rt.is_true(var_block_attributes.array_get(rt.new_string('requireCompanyField'))) { 'required' } else { 'optional' }).str())])
	} else {
		rt.call_function('update_option', [rt.new_string('woocommerce_checkout_company_field'), rt.new_string('hidden')])
	}
	if rt.is_true(var_block_attributes.array_get(rt.new_string('showApartmentField'))) {
		rt.call_function('update_option', [rt.new_string('woocommerce_checkout_address_2_field'), rt.new_string((if rt.is_true(var_block_attributes.array_get(rt.new_string('requireApartmentField'))) { 'required' } else { 'optional' }).str())])
	} else {
		rt.call_function('update_option', [rt.new_string('woocommerce_checkout_address_2_field'), rt.new_string('hidden')])
	}
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.get_company_field_visibility() string {
	mut var_option_value := rt.call_function('get_option', [rt.new_string('woocommerce_checkout_company_field')])
	if rt.is_true(var_option_value) {
		return (var_option_value).str()
	}
	if rt.is_true(Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_checkout_block_default()) {
		Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.migrate_checkout_block_field_visibility_attributes()
		return (rt.call_function('get_option', [rt.new_string('woocommerce_checkout_company_field'), rt.new_string('hidden')])).str()
	}
	return 'optional'
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.get_address_2_field_visibility() string {
	mut var_option_value := rt.call_function('get_option', [rt.new_string('woocommerce_checkout_address_2_field')])
	if rt.is_true(var_option_value) {
		return (var_option_value).str()
	}
	if rt.is_true(Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_checkout_block_default()) {
		Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.migrate_checkout_block_field_visibility_attributes()
		return (rt.call_function('get_option', [rt.new_string('woocommerce_checkout_address_2_field'), rt.new_string('optional')])).str()
	}
	return 'optional'
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.get_phone_field_visibility() string {
	mut var_option_value := rt.call_function('get_option', [rt.new_string('woocommerce_checkout_phone_field')])
	if rt.is_true(var_option_value) {
		return (var_option_value).str()
	}
	if rt.is_true(Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_checkout_block_default()) {
		Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.migrate_checkout_block_field_visibility_attributes()
		return (rt.call_function('get_option', [rt.new_string('woocommerce_checkout_phone_field'), rt.new_string('optional')])).str()
	}
	return 'required'
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_overriden_by_custom_template_content(block string) bool {
	mut block_mutated := block
	block_mutated = (rt.call_function('str_replace', [rt.new_string('woocommerce/'), rt.new_string(''), rt.new_string(block_mutated).clone()])).str()
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		mut iife_temp_6 := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}
		mut iife_result_6 := iife_temp_6.get_block_templates_from_db(rt.create_array([rt.ArrayItem{ key: none, val: 'page-' + block_mutated }]))
		mut var_templates_from_db := iife_result_6
		mut iter_3 := var_templates_from_db.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_template := item_3.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_block', [rt.new_string('woocommerce/page-content-wrapper'), rt.get_property(var_template, 'content')]))))) {
				return true
			}
		}
	}
	return false
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.get_country_data() rt.PhpVal {
	mut var_billing_countries := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_allowed_countries', []rt.PhpVal{})
	mut var_shipping_countries := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_shipping_countries', []rt.PhpVal{})
	mut var_country_states := rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'countries'), 'get_states', []rt.PhpVal{})
	mut var_all_countries := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.deep_sort_with_accents(rt.call_function('array_unique', [rt.call_function('array_merge', [var_billing_countries.clone(), var_shipping_countries.clone()])]))
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_locale := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iter_4 := var_locale.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_field_data := item_4.val
			mut var_field := item_4.key
			if var_field_data.array_isset(rt.new_string('priority')) {
				var_locale.array_get_mut(var_field).array_set('index', var_field_data.array_get(rt.new_string('priority')))
				var_locale.array_get(var_field).array_unset(rt.new_string('priority'))
			}
			if var_field_data.array_isset(rt.new_string('class')) {
				var_locale.array_get(var_field).array_unset(rt.new_string('class'))
			}
		}
		return var_locale.clone()
		}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_locale := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iter_5 := var_locale.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_field_data := item_5.val
			mut var_field := item_5.key
			if var_field_data.array_isset(rt.new_string('priority')) {
				var_locale.array_get_mut(var_field).array_set('index', var_field_data.array_get(rt.new_string('priority')))
				var_locale.array_get(var_field).array_unset(rt.new_string('priority'))
			}
			if var_field_data.array_isset(rt.new_string('class')) {
				var_locale.array_get(var_field).array_unset(rt.new_string('class'))
			}
		}
		return var_locale.clone()
		}
	mut var_country_locales := rt.call_function('array_map', [rt.new_closure(closure_8_fn), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_country_locale', []rt.PhpVal{})])
	mut var_country_data := rt.new_array()
	mut iter_6 := rt.func_array_keys(var_all_countries.clone()).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_country_code := item_6.val
		var_country_data.array_set(var_country_code, rt.create_array([rt.ArrayItem{ key: 'allowBilling', val: rt.new_bool(var_billing_countries.array_isset(var_country_code)) }, rt.ArrayItem{ key: 'allowShipping', val: rt.new_bool(var_shipping_countries.array_isset(var_country_code)) }, rt.ArrayItem{ key: 'states', val: if !(var_country_states.array_get(var_country_code)).is_null() { var_country_states.array_get(var_country_code) } else { rt.new_array() } }, rt.ArrayItem{ key: 'locale', val: if !(var_country_locales.array_get(var_country_code)).is_null() { var_country_locales.array_get(var_country_code) } else { rt.new_array() } }]))
	}
	return var_country_data.clone()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.deep_sort_with_accents(var_sort_array rt.PhpVal) rt.PhpVal {
	if !(var_sort_array.clone().is_array()) || !rt.is_true(var_sort_array) {
		return var_sort_array.clone()
	}
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return if var_value.clone().is_array() { Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.deep_sort_with_accents(var_value.clone()) } else { rt.call_function('remove_accents', [rt.call_function('wc_strtolower', [rt.call_function('html_entity_decode', [var_value.clone()])])]) }
		}
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return if var_value.clone().is_array() { Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.deep_sort_with_accents(var_value.clone()) } else { rt.call_function('remove_accents', [rt.call_function('wc_strtolower', [rt.call_function('html_entity_decode', [var_value.clone()])])]) }
		}
	mut var_array_without_accents := rt.call_function('array_map', [rt.new_closure(closure_10_fn), var_sort_array.clone()])
	rt.call_function('asort', [var_array_without_accents.clone()])
	return rt.call_function('array_replace', [var_array_without_accents.clone(), var_sort_array.clone()])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.get_shipping_zones() rt.PhpVal {
	mut iife_temp_11 := Class_Automattic_WooCommerce_Blocks_Utils_WC_Shipping_Zones{}
	mut iife_result_11 := iife_temp_11.get_zones()
	mut var_shipping_zones := iife_result_11
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_acc := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_zone := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		var_acc.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: var_zone.array_get(rt.new_string('id')) }, rt.ArrayItem{ key: 'title', val: var_zone.array_get(rt.new_string('zone_name')) }, rt.ArrayItem{ key: 'description', val: var_zone.array_get(rt.new_string('formatted_zone_location')) }]))
		return var_acc.clone()
		}
	mut var_formatted_shipping_zones := rt.call_function('array_reduce', [var_shipping_zones.clone(), rt.new_closure(closure_13_fn), rt.new_array()])
	var_formatted_shipping_zones.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: 0 }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('International'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Locations outside all other zones'), rt.new_string('woocommerce')]) }]))
	return var_formatted_shipping_zones.clone()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.find_express_checkout_attributes_in_parsed_blocks(var_blocks rt.PhpVal, var_cart_or_checkout rt.PhpVal) rt.PhpVal {
	mut var_express_block_name := rt.new_string('woocommerce/' + (var_cart_or_checkout).str() + '-express-payment-block')
	mut iter_7 := var_blocks.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_block := item_7.val
		if !(!rt.is_true(var_block.array_get(rt.new_string('blockName')))) && rt.is_true(rt.identical(var_express_block_name, var_block.array_get(rt.new_string('blockName')))) && !(!rt.is_true(var_block.array_get(rt.new_string('attrs')))) {
			return var_block.array_get(rt.new_string('attrs'))
		}
		if !(!rt.is_true(var_block.array_get(rt.new_string('innerBlocks')))) {
			mut var_answer := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.find_express_checkout_attributes_in_parsed_blocks(var_block.array_get(rt.new_string('innerBlocks')), var_cart_or_checkout.clone())
			if rt.is_true(var_answer) {
				return var_answer.clone()
			}
		}
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.find_express_checkout_attributes(var_post_content rt.PhpVal, var_cart_or_checkout rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_post_content.clone().is_array())) {
		rt.call_function('wc_deprecated_argument', [rt.new_string('post_content'), rt.new_string('10.3.0'), rt.new_string('Passing parsed blocks as an array in $post_content is deprecated. Please pass the post content as a string.')])
		return Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.find_express_checkout_attributes_in_parsed_blocks(var_post_content.clone(), var_cart_or_checkout.clone())
	}
	mut var_express_block_name := rt.new_string('woocommerce/' + (var_cart_or_checkout).str() + '-express-payment-block')
	mut iife_temp_13 := Class_Automattic_Block_Scanner{}
	mut iife_result_13 := iife_temp_13.create(var_post_content.clone())
	mut var_scanner := iife_result_13
	for rt.is_true(rt.call_method(var_scanner, 'next_delimiter', []rt.PhpVal{})) {
		if rt.is_true(rt.call_method(var_scanner, 'opens_block', [var_express_block_name.clone()])) {
			return rt.call_method(var_scanner, 'allocate_and_return_parsed_attributes', []rt.PhpVal{})
		}
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.update_blocks_with_new_attrs(var_blocks rt.PhpVal, var_cart_or_checkout rt.PhpVal, var_updated_attrs rt.PhpVal) {
	mut var_express_block_name := rt.new_string('woocommerce/' + (var_cart_or_checkout).str() + '-express-payment-block')
	mut iter_8 := var_blocks.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_block := item_8.val
		mut var_key := item_8.key
		if !(!rt.is_true(var_block.array_get(rt.new_string('blockName')))) && rt.is_true(rt.identical(var_express_block_name, var_block.array_get(rt.new_string('blockName')))) {
			var_blocks.array_get_mut(var_key).array_set('attrs', var_updated_attrs.clone())
		}
		if !(!rt.is_true(var_block.array_get(rt.new_string('innerBlocks')))) {
			Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.update_blocks_with_new_attrs(var_block.array_get(rt.new_string('innerBlocks')), var_cart_or_checkout.clone(), var_updated_attrs.clone())
		}
	}
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.has_cart_page() bool {
	return rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wc_get_page_permalink', [rt.new_string('cart'), rt.new_int(-1)]), -1)))
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.get_cart_product_ids_for_user(mut var_user_id Class_Automattic_WooCommerce_Blocks_Utils_?int, mut var_user_email Class_Automattic_WooCommerce_Blocks_Utils_?string) rt.PhpVal {
	mut var_user_id_mutated := var_user_id
	if !rt.is_true(var_user_id_mutated) && !(!rt.is_true(var_user_email)) {
		mut var_user := rt.call_function('get_user_by', [rt.new_string('email'), var_user_email])
		if rt.is_true(var_user) {
		var_user_id_mutated = rt.get_property(var_user, 'ID')
		}
	}
	if !rt.is_true(var_user_id_mutated) {
		return rt.new_array()
	}
	mut var_cart_meta := rt.call_function('get_user_meta', [var_user_id_mutated, rt.new_string('_woocommerce_persistent_cart_' + (rt.call_function('get_current_blog_id', []rt.PhpVal{})).str()), rt.new_bool(true)])
	if !rt.is_true(var_cart_meta) || !(var_cart_meta.clone().is_array()) || !rt.is_true(var_cart_meta.array_get(rt.new_string('cart'))) {
		return rt.new_array()
	}
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_cart_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int(if var_cart_item.array_isset(rt.new_string('product_id')) { var_cart_item.array_get(rt.new_string('product_id')).to_i64() } else { 0 })
		}
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_cart_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int(if var_cart_item.array_isset(rt.new_string('product_id')) { var_cart_item.array_get(rt.new_string('product_id')).to_i64() } else { 0 })
		}
	closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_cart_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int(if var_cart_item.array_isset(rt.new_string('product_id')) { var_cart_item.array_get(rt.new_string('product_id')).to_i64() } else { 0 })
		}
	closure_18_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_cart_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int(if var_cart_item.array_isset(rt.new_string('product_id')) { var_cart_item.array_get(rt.new_string('product_id')).to_i64() } else { 0 })
		}
	closure_19_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_cart_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int(if var_cart_item.array_isset(rt.new_string('product_id')) { var_cart_item.array_get(rt.new_string('product_id')).to_i64() } else { 0 })
		}
	closure_20_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_cart_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int(if var_cart_item.array_isset(rt.new_string('product_id')) { var_cart_item.array_get(rt.new_string('product_id')).to_i64() } else { 0 })
		}
	closure_21_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_cart_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int(if var_cart_item.array_isset(rt.new_string('product_id')) { var_cart_item.array_get(rt.new_string('product_id')).to_i64() } else { 0 })
		}
	closure_22_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_cart_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int(if var_cart_item.array_isset(rt.new_string('product_id')) { var_cart_item.array_get(rt.new_string('product_id')).to_i64() } else { 0 })
		}
	closure_23_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_cart_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int(if var_cart_item.array_isset(rt.new_string('product_id')) { var_cart_item.array_get(rt.new_string('product_id')).to_i64() } else { 0 })
		}
	closure_24_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_cart_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int(if var_cart_item.array_isset(rt.new_string('product_id')) { var_cart_item.array_get(rt.new_string('product_id')).to_i64() } else { 0 })
		}
	closure_25_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_cart_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int(if var_cart_item.array_isset(rt.new_string('product_id')) { var_cart_item.array_get(rt.new_string('product_id')).to_i64() } else { 0 })
		}
	closure_26_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_cart_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int(if var_cart_item.array_isset(rt.new_string('product_id')) { var_cart_item.array_get(rt.new_string('product_id')).to_i64() } else { 0 })
		}
	closure_27_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_cart_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int(if var_cart_item.array_isset(rt.new_string('product_id')) { var_cart_item.array_get(rt.new_string('product_id')).to_i64() } else { 0 })
		}
	closure_28_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_cart_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int(if var_cart_item.array_isset(rt.new_string('product_id')) { var_cart_item.array_get(rt.new_string('product_id')).to_i64() } else { 0 })
		}
	closure_29_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_cart_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int(if var_cart_item.array_isset(rt.new_string('product_id')) { var_cart_item.array_get(rt.new_string('product_id')).to_i64() } else { 0 })
		}
	closure_30_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_cart_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int(if var_cart_item.array_isset(rt.new_string('product_id')) { var_cart_item.array_get(rt.new_string('product_id')).to_i64() } else { 0 })
		}
	return rt.call_function('array_values', [rt.call_function('array_unique', [rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_closure(closure_15_fn), var_cart_meta.array_get(rt.new_string('cart'))])])])])
}

struct Class_Automattic_Block_Scanner {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_WC_Blocks_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_WC_Shipping_Zones {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_block_scanner(_args ...rt.PhpVal) &Class_Automattic_Block_Scanner {
	mut obj := &Class_Automattic_Block_Scanner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_blocktemplateutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_wc_blocks_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_WC_Blocks_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_WC_Blocks_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_wc_shipping_zones(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_WC_Shipping_Zones {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_WC_Shipping_Zones{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_page_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_page_type(dispatch_arg_0))
		}
		'is_cart_page' {
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_cart_page())
		}
		'is_checkout_page' {
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_checkout_page())
		}
		'shipping_methods_exist' {
			return Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.shipping_methods_exist()
		}
		'has_block_variation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.has_block_variation(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'is_cart_block_default' {
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_cart_block_default())
		}
		'is_checkout_block_default' {
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_checkout_block_default())
		}
		'migrate_checkout_block_field_visibility_attributes' {
			Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.migrate_checkout_block_field_visibility_attributes()
			return rt.new_null()
		}
		'get_company_field_visibility' {
			return rt.new_string(Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.get_company_field_visibility())
		}
		'get_address_2_field_visibility' {
			return rt.new_string(Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.get_address_2_field_visibility())
		}
		'get_phone_field_visibility' {
			return rt.new_string(Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.get_phone_field_visibility())
		}
		'is_overriden_by_custom_template_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_overriden_by_custom_template_content(dispatch_arg_0))
		}
		'get_country_data' {
			return Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.get_country_data()
		}
		'deep_sort_with_accents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.deep_sort_with_accents(dispatch_arg_0)
		}
		'get_shipping_zones' {
			return Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.get_shipping_zones()
		}
		'find_express_checkout_attributes_in_parsed_blocks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.find_express_checkout_attributes_in_parsed_blocks(dispatch_arg_0, dispatch_arg_1)
		}
		'find_express_checkout_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.find_express_checkout_attributes(dispatch_arg_0, dispatch_arg_1)
		}
		'update_blocks_with_new_attrs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.update_blocks_with_new_attrs(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'has_cart_page' {
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.has_cart_page())
		}
		'get_cart_product_ids_for_user' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Utils_?int](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Utils_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.get_cart_product_ids_for_user(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Block_Scanner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Block_Scanner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Block_Scanner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_WC_Blocks_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_WC_Blocks_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_WC_Blocks_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_WC_Shipping_Zones) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_WC_Shipping_Zones) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_WC_Shipping_Zones) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
