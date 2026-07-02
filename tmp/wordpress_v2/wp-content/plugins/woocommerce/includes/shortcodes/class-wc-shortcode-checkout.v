import rt

struct Class_WC_Shortcode_Checkout {
	rt.PhpObjectBase
}

fn Class_WC_Shortcode_Checkout.get(var_atts rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_WC_Shortcodes{}
	mut iife_result_0 := iife_temp_0.shortcode_wrapper(rt.create_array([
		rt.ArrayItem{ key: none, val: @STRUCT },
		rt.ArrayItem{ key: none, val: 'output' },
	]), var_atts.clone())
	return iife_result_0
}

fn Class_WC_Shortcode_Checkout.output(var_atts rt.PhpVal) {
	mut var_wp := rt.new_null()
	if rt.is_true(rt.new_bool(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart').is_null())) {
		return
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('order'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('key')) {
		rt.call_function('wc_deprecated_argument', [rt.new_string(@STRUCT + '->' + @FN),
			rt.new_string('2.1'),
			rt.new_string('"order" is no longer used to pass an order ID. Use the order-pay or order-received endpoint instead.')])
		mut var_order_id := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('order')),
		])
		mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
		if rt.is_true(var_order)
			&& rt.is_true(rt.call_method(var_order, 'has_status', [Class_Automattic_WooCommerce_Enums_OrderStatus.pending()])) {
			rt.get_property(var_wp, 'query_vars').array_set('order-pay', rt.call_function('absint', [
				rt.get_superglobal('_GET').array_get(rt.new_string('order')),
			]))
		} else {
			rt.get_property(var_wp, 'query_vars').array_set('order-received', rt.call_function('absint', [
				rt.get_superglobal('_GET').array_get(rt.new_string('order')),
			]))
		}
	}
	if !(!rt.is_true(rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('order-pay')))) {
		Class_WC_Shortcode_Checkout.order_pay(rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('order-pay')))
	} else if rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('order-received')) {
		Class_WC_Shortcode_Checkout.order_received((rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('order-received'))).to_i64())
	} else {
		Class_WC_Shortcode_Checkout.checkout()
	}
}

fn Class_WC_Shortcode_Checkout.order_pay(var_order_id rt.PhpVal) {
	mut var_order_id_mutated := var_order_id
	rt.call_function('do_action', [rt.new_string('before_woocommerce_pay')])
	var_order_id_mutated = rt.call_function('absint', [var_order_id_mutated.clone()])
	if rt.get_superglobal('_GET').array_isset(rt.new_string('pay_for_order'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('key'))
		&& rt.is_true(var_order_id_mutated) {
		mut var_order_key := if rt.get_superglobal('_GET').array_isset(rt.new_string('key')) { rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('key'))]),
			]) } else { rt.new_string('') }
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		mut var_order := rt.call_function('wc_get_order', [var_order_id_mutated.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_order))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_order, 'get_id', []rt.PhpVal{}), var_order_id_mutated))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}), var_order_key.clone()]))))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
				rt.new_string('Sorry, this order is invalid and cannot be paid for.'),
				rt.new_string('woocommerce'),
			]))))
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
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('pay_for_order'), var_order_id_mutated.clone()])))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
			rt.call_function('wc_print_notice', [
				rt.call_function('esc_html__', [
					rt.new_string('Please log in to your account below to continue to the payment form.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('notice'),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			rt.call_function('woocommerce_login_form', [
				rt.create_array([
					rt.ArrayItem{ key: 'redirect', val: rt.call_method(var_order,
						'get_checkout_payment_url', []rt.PhpVal{}) },
				]),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			return
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'get_user_id', []rt.PhpVal{})))))
			&& rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_order,
				'get_billing_email', []rt.PhpVal{}), rt.get_property(rt.call_function('wp_get_current_user',
				[]rt.PhpVal{}), 'user_email')))))
			{
				rt.call_function('wc_print_notice', [
					rt.call_function('__', [
						rt.new_string('You are paying for a guest order. Please continue with payment only if you recognize this order.'),
						rt.new_string('woocommerce'),
					]),
					rt.new_string('error'),
				])
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
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('pay_for_order'),
			var_order_id_mutated.clone(),
		])))))
		{
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
				rt.new_string('This order cannot be paid for. Please contact us if you need assistance.'),
				rt.new_string('woocommerce'),
			]))))
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
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'needs_payment',
			[]rt.PhpVal{})))))
		{
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('This order&rsquo;s status is &ldquo;%s&rdquo;&mdash;it cannot be paid for. Please contact us if you need assistance.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('wc_get_order_status_name', [
					rt.call_method(var_order, 'get_status', []rt.PhpVal{}),
				]),
			]))))
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
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'has_status', [
			rt.call_function('wc_get_is_pending_statuses', []rt.PhpVal{}),
		])))))
		{
			mut var_quantities := rt.new_array()
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			mut iter_1 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_item := item_1.val
				mut var_item_key := item_1.key
				if rt.is_true(var_item)
					&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
					key: none
					val: var_item
				}, rt.ArrayItem{ key: none, val: 'get_product' }])]) {
					mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
					if rt.has_exception() {
						unsafe {
							goto catch_label_1
						}
					}
					if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
						continue
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
					var_quantities.array_set(rt.call_method(var_product, 'get_stock_managed_by_id',
						[]rt.PhpVal{}), if var_quantities.array_isset(rt.call_method(var_product,
						'get_stock_managed_by_id', []rt.PhpVal{}))
					{
						rt.add(var_quantities.array_get(rt.call_method(var_product,
							'get_stock_managed_by_id', []rt.PhpVal{})), rt.call_method(var_item,
							'get_quantity', []rt.PhpVal{}))
					} else {
						rt.call_method(var_item, 'get_quantity', []rt.PhpVal{})
					})
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
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(var_order,
				'get_data_store', []rt.PhpVal{}), 'get_stock_reduced', [
				rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
			])))))
			{
				mut iter_2 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_item := item_2.val
					mut var_item_key := item_2.key
					if rt.is_true(var_item)
						&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
						key: none
						val: var_item
					}, rt.ArrayItem{ key: none, val: 'get_product' }])]) {
						mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
						if rt.has_exception() {
							unsafe {
								goto catch_label_1
							}
						}
						if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
							continue
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
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
							rt.new_string('woocommerce_pay_order_product_in_stock'),
							rt.call_method(var_product, 'is_in_stock', []rt.PhpVal{}),
							var_product.clone(),
							var_order.clone(),
						])))))
						{
							rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
								rt.call_function('__', [
									rt.new_string('Sorry, "%s" is no longer in stock so this order cannot be paid for. We apologize for any inconvenience caused.'),
									rt.new_string('woocommerce'),
								]),
								rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
							]))))
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
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'managing_stock', []rt.PhpVal{})))))
							|| rt.is_true(rt.call_method(var_product, 'backorders_allowed', []rt.PhpVal{})) {
							continue
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
						mut var_held_stock := rt.call_function('wc_get_held_stock_quantity', [
							var_product.clone(),
							rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
						])
						if rt.has_exception() {
							unsafe {
								goto catch_label_1
							}
						}
						mut var_required_stock := var_quantities.array_get(rt.call_method(var_product,
							'get_stock_managed_by_id', []rt.PhpVal{}))
						if rt.has_exception() {
							unsafe {
								goto catch_label_1
							}
						}
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
							rt.new_string('woocommerce_pay_order_product_has_enough_stock'),
							rt.greater_equal(rt.call_method(var_product, 'get_stock_quantity',
								[]rt.PhpVal{}), rt.add(var_held_stock, var_required_stock)),
							var_product.clone(),
							var_order.clone(),
						])))))
						{
							rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
								rt.call_function('__', [
									rt.new_string('Sorry, we do not have enough "%1$s" in stock to fulfill your order (%2$s available). We apologize for any inconvenience caused.'),
									rt.new_string('woocommerce'),
								]),
								rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
								rt.call_function('wc_format_stock_quantity_for_display', [
									rt.sub(rt.call_method(var_product, 'get_stock_quantity',
										[]rt.PhpVal{}), var_held_stock),
									var_product.clone(),
								]),
							]))))
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
					}
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
			}
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
		if rt.is_true(Class_WC_Shortcode_Checkout.guest_should_verify_email(mut rt.cast_object_ptr[Class_WC_Order](var_order),
			'order-pay'))
		{
			rt.call_function('wc_get_template', [
				rt.new_string('checkout/form-verify-email.php'),
				rt.create_array([
					rt.ArrayItem{
						key: 'failed_submission'
						val: !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('email'))))
					},
					rt.ArrayItem{ key: 'verify_url', val: rt.call_method(var_order,
						'get_checkout_payment_url', []rt.PhpVal{}) },
				]),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			return
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'),
			'set_props', [
			rt.create_array([
				rt.ArrayItem{
					key: 'billing_country'
					val: if rt.is_true(rt.call_method(var_order, 'get_billing_country',
						[]rt.PhpVal{}))
					{
						rt.call_method(var_order, 'get_billing_country', []rt.PhpVal{})
					} else {
						rt.new_null()
					}
				},
				rt.ArrayItem{
					key: 'billing_state'
					val: if rt.is_true(rt.call_method(var_order, 'get_billing_state', []rt.PhpVal{})) {
						rt.call_method(var_order, 'get_billing_state', []rt.PhpVal{})
					} else {
						rt.new_null()
					}
				},
				rt.ArrayItem{
					key: 'billing_postcode'
					val: if rt.is_true(rt.call_method(var_order, 'get_billing_postcode',
						[]rt.PhpVal{}))
					{
						rt.call_method(var_order, 'get_billing_postcode', []rt.PhpVal{})
					} else {
						rt.new_null()
					}
				},
			]),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'save',
			[]rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		mut var_available_gateways := rt.call_method(rt.call_method(rt.call_function('WC',
			[]rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{}), 'get_available_payment_gateways',
			[]rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways',
			[]rt.PhpVal{}), 'set_current_gateway', [var_available_gateways.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		mut var_order_button_text := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_pay_order_button_text'),
			rt.call_function('__', [rt.new_string('Pay for order'),
				rt.new_string('woocommerce')]),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.call_function('do_action', [rt.new_string('before_woocommerce_pay_form'),
			var_order.clone(), var_order_button_text.clone(),
			var_available_gateways.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.call_function('wc_get_template', [rt.new_string('checkout/form-pay.php'),
			rt.create_array([rt.ArrayItem{ key: 'order', val: var_order },
				rt.ArrayItem{ key: 'available_gateways', val: var_available_gateways },
				rt.ArrayItem{ key: 'order_button_text', val: var_order_button_text }])])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		unsafe {
			goto end_label_1
		}
		catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_e := var_e_1.clone()
			rt.call_function('wc_print_notice', [
				rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
				rt.new_string('error'),
			])
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
	} else if rt.is_true(var_order_id_mutated) {
		var_order_key = if rt.get_superglobal('_GET').array_isset(rt.new_string('key')) { rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('key'))]),
			]) } else { rt.new_string('') }
		var_order = rt.call_function('wc_get_order', [var_order_id_mutated.clone()])
		if rt.is_true(var_order)
			&& rt.is_true(rt.identical(rt.call_method(var_order, 'get_id', []rt.PhpVal{}), var_order_id_mutated))
			&& rt.is_true(rt.call_function('hash_equals', [rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}), var_order_key.clone()])) {
			if rt.is_true(rt.call_method(var_order, 'needs_payment', []rt.PhpVal{})) {
				rt.call_function('wc_get_template', [
					rt.new_string('checkout/order-receipt.php'),
					rt.create_array([rt.ArrayItem{ key: 'order', val: var_order }]),
				])
			} else {
				rt.call_function('wc_print_notice', [
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('This order&rsquo;s status is &ldquo;%s&rdquo;&mdash;it cannot be paid for. Please contact us if you need assistance.'),
							rt.new_string('woocommerce'),
						]),
						rt.call_function('wc_get_order_status_name', [
							rt.call_method(var_order, 'get_status', []rt.PhpVal{}),
						]),
					]),
					rt.new_string('error'),
				])
			}
		} else {
			rt.call_function('wc_print_notice', [
				rt.call_function('__', [
					rt.new_string('Sorry, this order is invalid and cannot be paid for.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('error'),
			])
		}
	} else {
		rt.call_function('wc_print_notice', [
			rt.call_function('__', [rt.new_string('Invalid order.'),
				rt.new_string('woocommerce')]),
			rt.new_string('error'),
		])
	}
	rt.call_function('do_action', [rt.new_string('after_woocommerce_pay')])
}

fn Class_WC_Shortcode_Checkout.order_received(order_id i64) {
	mut order_id_mutated := order_id
	mut var_order := rt.new_bool(false)
	order_id_mutated = (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_thankyou_order_id'),
		rt.call_function('absint', [rt.new_int(order_id_mutated).clone()]),
	])).to_i64()
	mut var_order_key := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_thankyou_order_key'),
		if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('key'))) { rt.new_string('') } else { rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('key'))]),
			]) },
	])
	if order_id_mutated > 0 {
		var_order = rt.call_function('wc_get_order', [rt.new_int(order_id_mutated).clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}), var_order_key.clone()]))))) {
			var_order = rt.new_bool(false)
		}
	}
	rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'),
		'order_awaiting_payment') = rt.new_null()
	if rt.is_true(var_order)
		&& rt.is_true(rt.call_method(var_order, 'is_created_via', [rt.new_string('admin')])) {
		mut iife_temp_1 := Class_WC_Geolocation{}
		mut iife_result_1 := iife_temp_1.get_ip_address()
		rt.call_method(var_order, 'set_customer_ip_address', [iife_result_1])
		rt.call_method(var_order, 'save', []rt.PhpVal{})
	}
	rt.call_function('wc_empty_cart', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		rt.call_function('wc_get_template', [rt.new_string('checkout/thankyou.php'),
			rt.create_array([rt.ArrayItem{ key: 'order', val: false }])])
		return
	}
	mut var_verify_known_shoppers := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_order_received_verify_known_shoppers'),
		rt.new_bool(true),
	])
	mut var_order_customer_id := rt.call_method(var_order, 'get_customer_id', []rt.PhpVal{})
	if rt.is_true(var_verify_known_shoppers) && rt.is_true(var_order_customer_id)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), var_order_customer_id)))) {
		rt.call_function('wc_get_template', [
			rt.new_string('checkout/order-received.php'),
			rt.create_array([rt.ArrayItem{ key: 'order', val: false }]),
		])
		rt.call_function('wc_print_notice', [
			rt.call_function('esc_html__', [
				rt.new_string('Please log in to your account to view this order.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('notice'),
		])
		rt.call_function('woocommerce_login_form', [
			rt.create_array([
				rt.ArrayItem{ key: 'redirect', val: rt.call_method(var_order,
					'get_checkout_order_received_url', []rt.PhpVal{}) },
			]),
		])
		return
	}
	if rt.is_true(Class_WC_Shortcode_Checkout.guest_should_verify_email(mut rt.cast_object_ptr[Class_WC_Order](var_order),
		'order-received'))
	{
		rt.call_function('wc_get_template', [
			rt.new_string('checkout/order-received.php'),
			rt.create_array([rt.ArrayItem{ key: 'order', val: false }]),
		])
		rt.call_function('wc_get_template', [
			rt.new_string('checkout/form-verify-email.php'),
			rt.create_array([
				rt.ArrayItem{
					key: 'failed_submission'
					val: !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('email'))))
				},
				rt.ArrayItem{ key: 'verify_url', val: rt.call_method(var_order,
					'get_checkout_order_received_url', []rt.PhpVal{}) },
			]),
		])
		return
	}
	rt.call_function('wc_get_template', [rt.new_string('checkout/thankyou.php'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: var_order }])])
}

fn Class_WC_Shortcode_Checkout.checkout() {
	rt.call_function('do_action', [
		rt.new_string('woocommerce_before_checkout_form_cart_notices'),
	])
	if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'is_empty', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_checkout_redirect_empty_cart'), rt.new_bool(true)])) {
		return
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_check_cart_items')])
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
		'calculate_totals', []rt.PhpVal{})
	mut var_checkout := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'checkout',
		[]rt.PhpVal{})
	if !rt.is_true(rt.get_superglobal('_POST'))
		&& rt.is_true(rt.greater(rt.call_function('wc_notice_count', [rt.new_string('error')]), rt.new_int(0))) {
		rt.call_function('wc_get_template', [rt.new_string('checkout/cart-errors.php'),
			rt.create_array([rt.ArrayItem{ key: 'checkout', val: var_checkout }])])
		rt.call_function('wc_clear_notices', []rt.PhpVal{})
	} else {
		mut var_non_js_checkout :=
			rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('woocommerce_checkout_update_totals')))))
		if rt.is_true(rt.identical(rt.call_function('wc_notice_count', [rt.new_string('error')]), rt.new_int(0)))
			&& rt.is_true(var_non_js_checkout) {
			rt.call_function('wc_add_notice', [
				rt.call_function('__', [
					rt.new_string('The order totals have been updated. Please confirm your order by pressing the "Place order" button at the bottom of the page.'),
					rt.new_string('woocommerce'),
				]),
			])
		}
		rt.call_function('wc_get_template', [rt.new_string('checkout/form-checkout.php'),
			rt.create_array([rt.ArrayItem{ key: 'checkout', val: var_checkout }])])
	}
}

fn Class_WC_Shortcode_Checkout.guest_should_verify_email(mut var_order Class_WC_Order, context string) bool {
	mut var_order_mutated := var_order
	mut var_nonce_is_valid := rt.call_function('wp_verify_nonce', [
		rt.call_function('filter_input', [rt.get_constant('INPUT_POST'),
			rt.new_string('check_submission')]),
		rt.new_string('wc_verify_email'),
	])
	mut var_supplied_email := rt.new_null()
	mut var_order_id := rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})
	if rt.is_true(var_nonce_is_valid) {
		var_supplied_email = rt.call_function('sanitize_email', [
			rt.call_function('wp_unslash', [
				rt.call_function('filter_input', [rt.get_constant('INPUT_POST'),
					rt.new_string('email')]),
			]),
		])
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_2 := iife_temp_2.should_user_verify_order_email(var_order_id.clone(),
		var_supplied_email.clone(), rt.new_string(context))
	return iife_result_2.to_bool()
}

struct Class_WC_Shortcodes {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_WC_Geolocation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_Users {
	rt.PhpObjectBase
}

fn create_wc_shortcode_checkout(_args ...rt.PhpVal) &Class_WC_Shortcode_Checkout {
	mut obj := &Class_WC_Shortcode_Checkout{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shortcodes(_args ...rt.PhpVal) &Class_WC_Shortcodes {
	mut obj := &Class_WC_Shortcodes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_geolocation(_args ...rt.PhpVal) &Class_WC_Geolocation {
	mut obj := &Class_WC_Geolocation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_users(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Shortcode_Checkout) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Shortcode_Checkout.get(dispatch_arg_0)
		}
		'output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Shortcode_Checkout.output(dispatch_arg_0)
			return rt.new_null()
		}
		'order_pay' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Shortcode_Checkout.order_pay(dispatch_arg_0)
			return rt.new_null()
		}
		'order_received' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			Class_WC_Shortcode_Checkout.order_received(dispatch_arg_0)
			return rt.new_null()
		}
		'checkout' {
			Class_WC_Shortcode_Checkout.checkout()
			return rt.new_null()
		}
		'guest_should_verify_email' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(Class_WC_Shortcode_Checkout.guest_should_verify_email(mut dispatch_arg_0,
				dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Shortcode_Checkout) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shortcode_Checkout) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Shortcodes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shortcodes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shortcodes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Geolocation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Geolocation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Geolocation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
