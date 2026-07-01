import rt

struct Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
pub mut:
		is_cart_page rt.PhpVal = rt.new_null()
		is_checkout_page rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_page_type(page_type string) bool {
	mut var_post := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('wp')]))))) {
		return (rt.new_null()).to_bool()
	}
	mut var_page_id := rt.call_function('wc_get_page_id', [rt.new_string(page_type)])
	if rt.is_true(rt.new_bool(rt.is_true(var_page_id) && rt.is_true(rt.call_function('is_page', [var_page_id.dup()])))) {
		return true
	}
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.identical(rt.new_null(), var_post)) {
		return (rt.new_null()).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_Blocks_Utils_WP_Post'))) {
		return rt.is_true(rt.call_function('wc_post_content_has_shortcode', [if rt.is_true(rt.identical(rt.new_string('cart'), rt.new_string(page_type))) { rt.new_string('woocommerce_cart') } else { rt.new_string('woocommerce_checkout') }])) || rt.is_true(Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.has_block_variation(rt.new_string('woocommerce/classic-shortcode'), rt.new_string('shortcode'), rt.new_string(page_type), rt.get_property(var_post, 'post_content')))
	}
	return false
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_cart_page() bool {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return (rt.identical(rt.new_bool(true), // unsupported expression: Expr_StaticPropertyFetch)).to_bool()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_checkout_page() bool {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return (rt.identical(rt.new_bool(true), // unsupported expression: Expr_StaticPropertyFetch)).to_bool()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.shipping_methods_exist() rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_method := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.get_property(var_method, 'enabled')).is_null() && rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(var_method, 'enabled'))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_method, 'supports', [rt.new_string('shipping-zones')]))))))) && rt.is_true(rt.call_method(var_method, 'supports', [rt.new_string('local-pickup')])))
	}
	mut var_method := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.get_property(var_method, 'enabled')).is_null() && rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(var_method, 'enabled'))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_method, 'supports', [rt.new_string('shipping-zones')]))))))) && rt.is_true(rt.call_method(var_method, 'supports', [rt.new_string('local-pickup')])))
	}
	mut var_local_pickup_count := rt.new_int(rt.new_int(rt.call_function('array_filter', [rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'get_shipping_methods', []rt.PhpVal{}), rt.new_closure(closure_1_fn)]).array_count()))
	mut var_shipping_methods_count := rt.sub(rt.call_function('wc_get_shipping_method_count', [rt.new_bool(true), rt.new_bool(true)]), var_local_pickup_count)
	return rt.greater(var_shipping_methods_count, rt.new_int(0))
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.has_block_variation(var_block_id rt.PhpVal, var_attribute rt.PhpVal, var_value rt.PhpVal, var_post_content rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_content)))) {
		return false
	}
	mut var_scanner := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Block_Scanner{}; return temp.create(arg_0) }(var_post_content.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_scanner)))) {
		return false
	}
	for rt.is_true(rt.call_method(var_scanner, 'next_delimiter', []rt.PhpVal{})) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_scanner, 'opens_block', [var_block_id.dup()]))))) {
			continue
		}
		mut var_attrs := rt.call_method(var_scanner, 'allocate_and_return_parsed_attributes', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(var_attrs.array_isset(var_attribute) && rt.is_true(rt.identical(var_value, var_attrs.array_get(var_attribute))))) {
			return true
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('woocommerce/classic-shortcode'), var_block_id)) && rt.is_true(rt.identical(rt.new_string('shortcode'), var_attribute)))) && rt.is_true(rt.identical(rt.new_string('cart'), var_value)))) && !(var_attrs.array_isset(rt.new_string('shortcode'))))) {
			return true
		}
	}
	return false
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_cart_block_default() bool {
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		mut var_templates_from_db := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.get_block_templates_from_db(arg_0, arg_1) }(rt.create_array([rt.ArrayItem{ key: none, val: 'cart' }]), rt.new_string('wp_template'))
		{
			mut iter_1 := var_templates_from_db.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_template := item_1.val
				if rt.is_true(rt.call_function('has_block', [rt.new_string('woocommerce/cart'), rt.get_property(var_template, 'content')])) {
					return true
				}
			}
		}
	}
	mut var_cart_page_id := rt.call_function('wc_get_page_id', [rt.new_string('cart')])
	return rt.is_true(var_cart_page_id) && rt.is_true(rt.call_function('has_block', [rt.new_string('woocommerce/cart'), var_cart_page_id.dup()]))
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.is_checkout_block_default() bool {
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		mut var_templates_from_db := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.get_block_templates_from_db(arg_0, arg_1) }(rt.create_array([rt.ArrayItem{ key: none, val: 'checkout' }]), rt.new_string('wp_template'))
		{
			mut iter_1 := var_templates_from_db.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_template := item_1.val
				if rt.is_true(rt.call_function('has_block', [rt.new_string('woocommerce/checkout'), rt.get_property(var_template, 'content')])) {
					return true
				}
			}
		}
	}
	mut var_checkout_page_id := rt.call_function('wc_get_page_id', [rt.new_string('checkout')])
	return rt.is_true(var_checkout_page_id) && rt.is_true(rt.call_function('has_block', [rt.new_string('woocommerce/checkout'), var_checkout_page_id.dup()]))
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.migrate_checkout_block_field_visibility_attributes()  {
	rt.call_function('update_option', [rt.new_string('woocommerce_checkout_phone_field'), rt.new_string('optional')])
	rt.call_function('update_option', [rt.new_string('woocommerce_checkout_company_field'), rt.new_string('hidden')])
	rt.call_function('update_option', [rt.new_string('woocommerce_checkout_address_2_field'), rt.new_string('optional')])
	mut var_checkout_blocks := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_WC_Blocks_Utils{}; return temp.get_blocks_from_page(arg_0, arg_1) }(rt.new_string('woocommerce/checkout'), rt.new_string('checkout'))
	if !rt.is_true(var_checkout_blocks) || !(var_checkout_blocks.array_get(0).array_isset(rt.new_string('attrs'))) {
		return rt.new_null()
	}
	mut var_block_attributes := rt.call_function('wp_parse_args', [var_checkout_blocks.array_get(0).array_get('attrs'), rt.create_array([rt.ArrayItem{ key: 'showPhoneField', val: true }, rt.ArrayItem{ key: 'requirePhoneField', val: false }, rt.ArrayItem{ key: 'showCompanyField', val: false }, rt.ArrayItem{ key: 'requireCompanyField', val: false }, rt.ArrayItem{ key: 'showApartmentField', val: true }, rt.ArrayItem{ key: 'requireApartmentField', val: false }])])
	if rt.is_true(var_block_attributes.array_get('showPhoneField')) {
		rt.call_function('update_option', [rt.new_string('woocommerce_checkout_phone_field'), if rt.is_true(var_block_attributes.array_get('requirePhoneField')) { rt.new_string('required') } else { rt.new_string('optional') }])
	} else {
		rt.call_function('update_option', [rt.new_string('woocommerce_checkout_phone_field'), rt.new_string('hidden')])
	}
	if rt.is_true(var_block_attributes.array_get('showCompanyField')) {
		rt.call_function('update_option', [rt.new_string('woocommerce_checkout_company_field'), if rt.is_true(var_block_attributes.array_get('requireCompanyField')) { rt.new_string('required') } else { rt.new_string('optional') }])
	} else {
		rt.call_function('update_option', [rt.new_string('woocommerce_checkout_company_field'), rt.new_string('hidden')])
	}
	if rt.is_true(var_block_attributes.array_get('showApartmentField')) {
		rt.call_function('update_option', [rt.new_string('woocommerce_checkout_address_2_field'), if rt.is_true(var_block_attributes.array_get('requireApartmentField')) { rt.new_string('required') } else { rt.new_string('optional') }])
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
	block_mutated = (rt.call_function('str_replace', [rt.new_string('woocommerce/'), rt.new_string(''), rt.new_string(block_mutated).dup()])).str()
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		mut var_templates_from_db := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.get_block_templates_from_db(arg_0) }(rt.create_array([rt.ArrayItem{ key: none, val: 'page-' + block_mutated }]))
		{
			mut iter_1 := var_templates_from_db.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_template := item_1.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_block', [rt.new_string('woocommerce/page-content-wrapper'), rt.get_property(var_template, 'content')]))))) {
					return true
				}
			}
		}
	}
	return false
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.get_country_data() rt.PhpVal {
	mut var_billing_countries := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_allowed_countries', []rt.PhpVal{})
	mut var_shipping_countries := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_shipping_countries', []rt.PhpVal{})
	mut var_country_states := rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'countries'), 'get_states', []rt.PhpVal{})
	mut var_all_countries := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.deep_sort_with_accents(rt.call_function('array_unique', [rt.call_function('array_merge', [var_billing_countries.dup(), var_shipping_countries.dup()])]))
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_locale := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	{
		mut iter_1 := var_locale.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field_data := item_1.val
			mut var_field := item_1.key
			if var_field_data.array_isset(rt.new_string('priority')) {
				var_locale.array_get_mut(var_field).array_set('index', var_field_data.array_get('priority'))
				var_locale.array_get(var_field).array_unset(rt.new_string('priority'))
			}
			if var_field_data.array_isset(rt.new_string('class')) {
				var_locale.array_get(var_field).array_unset(rt.new_string('class'))
			}
		}
	}
	return var_locale.dup()
	}
	mut var_locale := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	{
		mut iter_1 := var_locale.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field_data := item_1.val
			mut var_field := item_1.key
			if var_field_data.array_isset(rt.new_string('priority')) {
				var_locale.array_get_mut(var_field).array_set('index', var_field_data.array_get('priority'))
				var_locale.array_get(var_field).array_unset(rt.new_string('priority'))
			}
			if var_field_data.array_isset(rt.new_string('class')) {
				var_locale.array_get(var_field).array_unset(rt.new_string('class'))
			}
		}
	}
	return var_locale.dup()
	}
	mut var_country_locales := rt.call_function('array_map', [rt.new_closure(closure_3_fn), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_country_locale', []rt.PhpVal{})])
	mut var_country_data := rt.new_array()
	{
		mut iter_1 := rt.func_array_keys(var_all_countries.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_country_code := item_1.val
			var_country_data.array_set(var_country_code, rt.create_array([rt.ArrayItem{ key: 'allowBilling', val: rt.new_bool(var_billing_countries.array_isset(var_country_code)) }, rt.ArrayItem{ key: 'allowShipping', val: rt.new_bool(var_shipping_countries.array_isset(var_country_code)) }, rt.ArrayItem{ key: 'states', val: if !(var_country_states.array_get(var_country_code)).is_null() { var_country_states.array_get(var_country_code) } else { rt.new_array() } }, rt.ArrayItem{ key: 'locale', val: if !(var_country_locales.array_get(var_country_code)).is_null() { var_country_locales.array_get(var_country_code) } else { rt.new_array() } }]))
		}
	}
	return var_country_data.dup()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.deep_sort_with_accents(var_sort_array rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_sort_array.dup().is_array()))))) || !rt.is_true(var_sort_array))) {
		return var_sort_array.dup()
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return if rt.is_true(rt.new_bool(var_value.dup().is_array())) { Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.deep_sort_with_accents(var_value.dup()) } else { rt.call_function('remove_accents', [rt.call_function('wc_strtolower', [rt.call_function('html_entity_decode', [var_value.dup()])])]) }
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return if rt.is_true(rt.new_bool(var_value.dup().is_array())) { Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.deep_sort_with_accents(var_value.dup()) } else { rt.call_function('remove_accents', [rt.call_function('wc_strtolower', [rt.call_function('html_entity_decode', [.dup()])])]) }
	}
	mut var_array_without_accents := rt.call_function('array_map', [rt.new_closure(closure_5_fn), var_sort_array.dup()])
	rt.call_function('asort', [var_array_without_accents.dup()])
	return rt.call_function('array_replace', [var_array_without_accents.dup(), var_sort_array.dup()])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.get_shipping_zones() rt.PhpVal {
	mut var_shipping_zones := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_WC_Shipping_Zones{}; return temp.get_zones() }()
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_acc := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_zone := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	}
	mut var_formatted_shipping_zones := rt.call_function('array_reduce', [var_shipping_zones.dup(), rt.new_closure(closure_7_fn), rt.new_array()])
	var_formatted_shipping_zones.array_push(rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }]))
	return var_formatted_shipping_zones.dup()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.find_express_checkout_attributes_in_parsed_blocks(var_blocks rt.PhpVal, var_cart_or_checkout rt.PhpVal) rt.PhpVal {
	
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.find_express_checkout_attributes(var_post_content rt.PhpVal, var_cart_or_checkout rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.update_blocks_with_new_attrs(var_blocks rt.PhpVal, var_cart_or_checkout rt.PhpVal, var_updated_attrs rt.PhpVal)  {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.has_cart_page() rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.get_cart_product_ids_for_user(mut var_user_id Class_Automattic_WooCommerce_Blocks_Utils_?int, mut var_user_email Class_Automattic_WooCommerce_Blocks_Utils_?string) rt.PhpVal {
	mut var_user_id_mutated := var_user_id
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

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils() &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
		is_cart_page: rt.new_null()
		is_checkout_page: rt.new_null()
	}
	return obj
}

fn create_automattic_block_scanner() &Class_Automattic_Block_Scanner {
	mut obj := &Class_Automattic_Block_Scanner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_blocktemplateutils() &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_wc_blocks_utils() &Class_Automattic_WooCommerce_Blocks_Utils_WC_Blocks_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_WC_Blocks_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_wc_shipping_zones() &Class_Automattic_WooCommerce_Blocks_Utils_WC_Shipping_Zones {
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
			return Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils.has_cart_page()
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
	match prop_name {
		'is_cart_page' { return this.is_cart_page }
		'is_checkout_page' { return this.is_checkout_page }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'is_cart_page' { this.is_cart_page = val; return true }
		'is_checkout_page' { this.is_checkout_page = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_src_blocks_utils_cartcheckoututils_php() {
}
