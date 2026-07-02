import rt

pub fn Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator.max_code_retries() i64 {
	return 5
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator) init() {
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_coupon_code_block_auto_generate'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'generate_coupon' },
		]),
		rt.new_int(10),
		rt.new_int(3),
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator) generate_coupon(coupon_code string, mut var_attrs Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	if !(coupon_code == '') {
		return coupon_code
	}
	if rt.is_true(var_rendering_context.get(rt.new_string('is_user_preview'))) {
		return (Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Coupon_Code.coupon_code_placeholder()).str()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_get_coupon_types')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Coupon')]))))) {
		return ''
	}
	mut var_coupon := create_automattic_woocommerce_emaileditor_integrations_woocommerce_wc_coupon()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_coupon.set_code(rt.new_string(this.generate_unique_code()))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_discount_type := rt.new_string(this.validate_discount_type((if !(var_attrs.array_get(rt.new_string('discountType'))).is_null() {
		var_attrs.array_get(rt.new_string('discountType'))
	} else {
		rt.new_string('percent')
	}).str()))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_coupon.set_discount_type(var_discount_type.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if var_attrs.array_isset(rt.new_string('amount')) {
		var_coupon.set_amount(rt.new_float((var_attrs.array_get(rt.new_string('amount'))).to_f64()))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if !(!rt.is_true(var_attrs.array_get(rt.new_string('expiryDay')))) {
		mut var_expiration := rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.new_int((var_attrs.array_get(rt.new_string('expiryDay'))).to_i64()),
			rt.get_constant('DAY_IN_SECONDS')))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_coupon.set_date_expires(var_expiration.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_coupon.set_free_shipping(rt.new_bool(!(!rt.is_true(var_attrs.array_get(rt.new_string('freeShipping'))))))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_coupon.set_minimum_amount(rt.new_float((if !(var_attrs.array_get(rt.new_string('minimumAmount'))).is_null() {
		var_attrs.array_get(rt.new_string('minimumAmount'))
	} else {
		rt.new_int(0)
	}).to_f64()))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_coupon.set_maximum_amount(rt.new_float((if !(var_attrs.array_get(rt.new_string('maximumAmount'))).is_null() {
		var_attrs.array_get(rt.new_string('maximumAmount'))
	} else {
		rt.new_int(0)
	}).to_f64()))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_coupon.set_individual_use(rt.new_bool(!(!rt.is_true(var_attrs.array_get(rt.new_string('individualUse'))))))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_coupon.set_exclude_sale_items(rt.new_bool(!(!rt.is_true(var_attrs.array_get(rt.new_string('excludeSaleItems'))))))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_coupon.set_product_ids(this.extract_ids(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_array](if !(var_attrs.array_get(rt.new_string('productIds'))).is_null() {
		var_attrs.array_get(rt.new_string('productIds'))
	} else {
		rt.new_array()
	})))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_coupon.set_excluded_product_ids(this.extract_ids(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_array](if !(var_attrs.array_get(rt.new_string('excludedProductIds'))).is_null() {
		var_attrs.array_get(rt.new_string('excludedProductIds'))
	} else {
		rt.new_array()
	})))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_coupon.set_product_categories(this.extract_ids(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_array](if !(var_attrs.array_get(rt.new_string('productCategoryIds'))).is_null() {
		var_attrs.array_get(rt.new_string('productCategoryIds'))
	} else {
		rt.new_array()
	})))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_coupon.set_excluded_product_categories(this.extract_ids(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_array](if !(var_attrs.array_get(rt.new_string('excludedProductCategoryIds'))).is_null() {
		var_attrs.array_get(rt.new_string('excludedProductCategoryIds'))
	} else {
		rt.new_array()
	})))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_email_restrictions := this.parse_email_restrictions(if !(var_attrs.array_get(rt.new_string('emailRestrictions'))).is_null() {
		var_attrs.array_get(rt.new_string('emailRestrictions'))
	} else {
		rt.new_string('')
	})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_recipient := var_rendering_context.get_recipient_email()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(var_recipient)
		&& rt.is_true(rt.call_function('is_email', [var_recipient.clone()])) {
		var_email_restrictions.array_push(var_recipient.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_coupon.set_email_restrictions(rt.call_function('array_unique', [
		var_email_restrictions.clone()]))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_usage_limit := if !(var_attrs.array_get(rt.new_string('usageLimit'))).is_null() {
		var_attrs.array_get(rt.new_string('usageLimit'))
	} else {
		rt.new_int(0)
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_usage_limit_per_user := if !(var_attrs.array_get(rt.new_string('usageLimitPerUser'))).is_null() {
		var_attrs.array_get(rt.new_string('usageLimitPerUser'))
	} else {
		rt.new_int(0)
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_coupon.set_usage_limit(rt.new_int(if var_usage_limit.clone().is_long()
		|| var_usage_limit.clone().is_double() {
		rt.new_int(var_usage_limit.to_i64())
	} else {
		0
	}))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_coupon.set_usage_limit_per_user(rt.new_int(if var_usage_limit_per_user.clone().is_long()
		|| var_usage_limit_per_user.clone().is_double() {
		rt.new_int(var_usage_limit_per_user.to_i64())
	} else {
		0
	}))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_coupon.set_description(rt.call_function('__', [
		rt.new_string('Auto-generated coupon by WooCommerce Email Editor'),
		rt.new_string('woocommerce'),
	]))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_coupon.save()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return (var_coupon.get_code()).str()
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1,
		'Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Exception')
	{
		mut var_e := var_e_1.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
			rt.new_string('Coupon auto-generation failed: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'source', val: 'email-editor-coupon-generator' },
			]),
		])
		return ''
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator) parse_email_restrictions(var_raw rt.PhpVal) rt.PhpVal {
	if !(var_raw.clone().is_string()) || rt.is_true(rt.identical(rt.new_string(''), var_raw)) {
		return rt.new_array()
	}
	mut var_emails := rt.call_function('array_map', [rt.new_string('trim'),
		rt.call_function('explode', [rt.new_string(','), var_raw.clone()])])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool((rt.call_function('is_email', [var_email.clone()])).to_bool())
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool((rt.call_function('is_email', [var_email.clone()])).to_bool())
	}
	return rt.call_function('array_values', [
		rt.call_function('array_filter', [var_emails.clone(),
			rt.new_closure(closure_1_fn)]),
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator) validate_discount_type(type string) string {
	mut var_valid_types :=
		rt.func_array_keys(rt.call_function('wc_get_coupon_types', []rt.PhpVal{}))
	return if rt.is_true(rt.call_function('in_array', [rt.new_string(type),
		var_valid_types.clone(), rt.new_bool(true)]))
	{ type } else { 'percent' }
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator) generate_unique_code() string {
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator.max_code_retries()))) { break
		 }
		mut var_code := rt.new_string(this.generate_random_code())
		mut var_existing := rt.call_function('wc_get_coupon_id_by_code', [
			var_code.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_existing)))) {
			return var_code.str()
		}
		rt.post_inc(var_i)
	}
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_RuntimeException',
		[]string{},
		create_automattic_woocommerce_emaileditor_integrations_woocommerce_runtimeexception(rt.new_string('Failed to generate a unique coupon code.'))))
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator) generate_random_code() string {
	mut var_characters := rt.new_string('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789')
	mut var_length := rt.new_int(var_characters.clone().to_string().len - 1)
	mut var_segment1 := rt.new_string('')
	mut var_segment2 := rt.new_string('')
	mut var_segment3 := rt.new_string('')
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(4)))) { break
		 }
		var_segment1 = rt.concat(var_segment1, var_characters.array_get(rt.call_function('random_int', [
			rt.new_int(0),
			var_length.clone(),
		])))
		rt.post_inc(var_i)
	}
	var_i = rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(6)))) { break
		 }
		var_segment2 = rt.concat(var_segment2, var_characters.array_get(rt.call_function('random_int', [
			rt.new_int(0),
			var_length.clone(),
		])))
		rt.post_inc(var_i)
	}
	var_i = rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(4)))) { break
		 }
		var_segment3 = rt.concat(var_segment3, var_characters.array_get(rt.call_function('random_int', [
			rt.new_int(0),
			var_length.clone(),
		])))
		rt.post_inc(var_i)
	}
	return var_segment1.str() + '-' + var_segment2.str() + '-' + var_segment3.str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator) extract_ids(mut var_items Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_array) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_item.clone().is_array()) {
			return rt.new_int(0)
		}
		mut var_id := if !(var_item.array_get(rt.new_string('id'))).is_null() {
			var_item.array_get(rt.new_string('id'))
		} else {
			rt.new_int(0)
		}
		return rt.new_int(if var_id.clone().is_long() || var_id.clone().is_double() {
			rt.new_int(var_id.to_i64())
		} else {
			0
		})
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_item.clone().is_array()) {
			return rt.new_int(0)
		}
		mut var_id := if !(var_item.array_get(rt.new_string('id'))).is_null() {
			var_item.array_get(rt.new_string('id'))
		} else {
			rt.new_int(0)
		}
		return rt.new_int(if var_id.clone().is_long() || var_id.clone().is_double() {
			rt.new_int(var_id.to_i64())
		} else {
			0
		})
	}
	return rt.call_function('array_map', [rt.new_closure(closure_3_fn), var_items])
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_WC_Coupon {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_RuntimeException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_coupon_code_generator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_wc_coupon(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_WC_Coupon {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_runtimeexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_RuntimeException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'generate_coupon' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.generate_coupon(dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2))
		}
		'parse_email_restrictions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_email_restrictions(dispatch_arg_0)
		}
		'validate_discount_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.validate_discount_type(dispatch_arg_0))
		}
		'generate_unique_code' {
			return rt.new_string(this.generate_unique_code())
		}
		'generate_random_code' {
			return rt.new_string(this.generate_random_code())
		}
		'extract_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.extract_ids(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Coupon_Code_Generator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
