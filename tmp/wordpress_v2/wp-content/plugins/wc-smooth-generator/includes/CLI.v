import rt

struct Class_WC_SmoothGenerator_CLI {
	rt.PhpObjectBase
}

fn Class_WC_SmoothGenerator_CLI.products(var_args rt.PhpVal, var_assoc_args rt.PhpVal) {
	mut list_tmp_1 := var_args
	mut var_amount := (list_tmp_1).array_get(0)
	var_amount = rt.call_function('absint', [var_amount.clone()])
	mut var_time_start := rt.call_function('microtime', [rt.new_bool(true)])
	mut iife_temp_0 := Class_WP_CLI{}
	mut iife_result_0 := iife_temp_0.line(rt.new_string('Initializing...'))
	mut iife_temp_1 := Class_WC_SmoothGenerator_Generator_Product{}
	mut iife_result_1 := iife_temp_1.seed_images(rt.call_function('min', [rt.add(var_amount, rt.new_int(19)), rt.new_int(100)]))
	mut var_progress := rt.call_function('WP_CLI\Utils\make_progress_bar', [rt.new_string('Generating products'), var_amount.clone()])
	closure_3_fn := fn [var_progress] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		rt.call_method(var_progress, 'tick', []rt.PhpVal{})
		return rt.new_null()
		}
	rt.call_function('add_action', [rt.new_string('smoothgenerator_product_generated'), rt.new_closure(closure_3_fn)])
	mut var_remaining_amount := var_amount.clone()
	mut var_generated := rt.new_int(0)
	for rt.is_true(rt.greater(var_remaining_amount, rt.new_int(0))) {
		mut var_batch := rt.call_function('min', [var_remaining_amount.clone(), Class_WC_SmoothGenerator_Generator_Product.max_batch_size()])
		mut iife_temp_3 := Class_WC_SmoothGenerator_Generator_Product{}
		mut iife_result_3 := iife_temp_3.batch(var_batch.clone(), var_assoc_args.clone())
		mut var_result := iife_result_3
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		mut iife_temp_4 := Class_WP_CLI{}
		mut iife_result_4 := iife_temp_4.error(var_result.clone())
		}
		var_generated = rt.add(var_generated, rt.new_int(var_result.clone().array_count()))
		var_remaining_amount = rt.sub(var_remaining_amount, var_batch)
	}
	rt.call_method(var_progress, 'finish', []rt.PhpVal{})
mut var_time_end := rt.call_function('microtime', [rt.new_bool(true)])
mut var_execution_time := rt.call_function('round', [rt.sub(var_time_end, var_time_start), rt.new_int(2)])
mut var_display_time := if rt.is_true(rt.less(var_execution_time, rt.new_int(60))) { (var_execution_time).str() + ' seconds' } else { rt.call_function('human_time_diff', [var_time_start.clone(), var_time_end.clone()]) }
mut iife_temp_5 := Class_WP_CLI{}
mut iife_result_5 := iife_temp_5.success(rt.new_string((var_generated).str() + ' products generated in ' + (var_display_time).str()))
}

fn Class_WC_SmoothGenerator_CLI.orders(var_args rt.PhpVal, var_assoc_args rt.PhpVal) {
	mut list_tmp_2 := var_args
	mut var_amount := (list_tmp_2).array_get(0)
	var_amount = rt.call_function('absint', [var_amount.clone()])
	mut var_time_start := rt.call_function('microtime', [rt.new_bool(true)])
	if !(!rt.is_true(var_assoc_args.array_get(rt.new_string('status')))) {
		mut var_status := var_assoc_args.array_get(rt.new_string('status'))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_order_status', [rt.new_string('wc-' + (var_status).str())]))))) {
			mut iife_temp_6 := Class_WP_CLI{}
			mut iife_result_6 := iife_temp_6.error(rt.new_string("The argument \"${var_status.to_string()}\" is not a valid order status."))
			return
		}
	}
	mut var_progress := rt.call_function('WP_CLI\Utils\make_progress_bar', [rt.new_string('Generating orders'), var_amount.clone()])
	closure_8_fn := fn [var_progress] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		rt.call_method(var_progress, 'tick', []rt.PhpVal{})
		return rt.new_null()
		}
	rt.call_function('add_action', [rt.new_string('smoothgenerator_order_generated'), rt.new_closure(closure_8_fn)])
	mut var_remaining_amount := var_amount.clone()
	mut var_generated := rt.new_int(0)
	for rt.is_true(rt.greater(var_remaining_amount, rt.new_int(0))) {
		mut var_batch := rt.call_function('min', [var_remaining_amount.clone(), Class_WC_SmoothGenerator_Generator_Order.max_batch_size()])
		mut iife_temp_8 := Class_WC_SmoothGenerator_Generator_Order{}
		mut iife_result_8 := iife_temp_8.batch(var_batch.clone(), var_assoc_args.clone())
		mut var_result := iife_result_8
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		mut iife_temp_9 := Class_WP_CLI{}
		mut iife_result_9 := iife_temp_9.error(var_result.clone())
		}
		var_generated = rt.add(var_generated, rt.new_int(var_result.clone().array_count()))
		var_remaining_amount = rt.sub(var_remaining_amount, var_batch)
	}
	rt.call_method(var_progress, 'finish', []rt.PhpVal{})
	mut var_time_end := rt.call_function('microtime', [rt.new_bool(true)])
	mut var_execution_time := rt.call_function('round', [rt.sub(var_time_end, var_time_start), rt.new_int(2)])
	mut var_display_time := if rt.is_true(rt.less(var_execution_time, rt.new_int(60))) { (var_execution_time).str() + ' seconds' } else { rt.call_function('human_time_diff', [var_time_start.clone(), var_time_end.clone()]) }
	if rt.is_true(rt.identical(var_generated, rt.new_int(0))) && rt.is_true(rt.greater(var_amount, rt.new_int(0))) {
	mut iife_temp_10 := Class_WP_CLI{}
	mut iife_result_10 := iife_temp_10.error(rt.new_string('No orders were generated. Make sure there are published products in your store.'))
	}
mut iife_temp_11 := Class_WP_CLI{}
mut iife_result_11 := iife_temp_11.success(rt.new_string((var_generated).str() + ' orders generated in ' + (var_display_time).str()))
}

fn Class_WC_SmoothGenerator_CLI.customers(var_args rt.PhpVal, var_assoc_args rt.PhpVal) {
	mut list_tmp_3 := var_args
	mut var_amount := (list_tmp_3).array_get(0)
	var_amount = rt.call_function('absint', [var_amount.clone()])
	mut var_time_start := rt.call_function('microtime', [rt.new_bool(true)])
	mut var_progress := rt.call_function('WP_CLI\Utils\make_progress_bar', [rt.new_string('Generating customers'), var_amount.clone()])
	closure_13_fn := fn [var_progress] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		rt.call_method(var_progress, 'tick', []rt.PhpVal{})
		return rt.new_null()
		}
	rt.call_function('add_action', [rt.new_string('smoothgenerator_customer_generated'), rt.new_closure(closure_13_fn)])
	mut var_remaining_amount := var_amount.clone()
	mut var_generated := rt.new_int(0)
	for rt.is_true(rt.greater(var_remaining_amount, rt.new_int(0))) {
		mut var_batch := rt.call_function('min', [var_remaining_amount.clone(), Class_WC_SmoothGenerator_Generator_Customer.max_batch_size()])
		mut iife_temp_13 := Class_WC_SmoothGenerator_Generator_Customer{}
		mut iife_result_13 := iife_temp_13.batch(var_batch.clone(), var_assoc_args.clone())
		mut var_result := iife_result_13
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		mut iife_temp_14 := Class_WP_CLI{}
		mut iife_result_14 := iife_temp_14.error(var_result.clone())
		}
		var_generated = rt.add(var_generated, rt.new_int(var_result.clone().array_count()))
		var_remaining_amount = rt.sub(var_remaining_amount, var_batch)
	}
	rt.call_method(var_progress, 'finish', []rt.PhpVal{})
mut var_time_end := rt.call_function('microtime', [rt.new_bool(true)])
mut var_execution_time := rt.call_function('round', [rt.sub(var_time_end, var_time_start), rt.new_int(2)])
mut var_display_time := if rt.is_true(rt.less(var_execution_time, rt.new_int(60))) { (var_execution_time).str() + ' seconds' } else { rt.call_function('human_time_diff', [var_time_start.clone(), var_time_end.clone()]) }
mut iife_temp_15 := Class_WP_CLI{}
mut iife_result_15 := iife_temp_15.success(rt.new_string((var_generated).str() + ' customers generated in ' + (var_display_time).str()))
}

fn Class_WC_SmoothGenerator_CLI.coupons(var_args rt.PhpVal, var_assoc_args rt.PhpVal) {
	mut list_tmp_4 := var_args
	mut var_amount := (list_tmp_4).array_get(0)
	var_amount = rt.call_function('absint', [var_amount.clone()])
	mut var_time_start := rt.call_function('microtime', [rt.new_bool(true)])
	mut var_progress := rt.call_function('WP_CLI\Utils\make_progress_bar', [rt.new_string('Generating coupons'), var_amount.clone()])
	closure_17_fn := fn [var_progress] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		rt.call_method(var_progress, 'tick', []rt.PhpVal{})
		return rt.new_null()
		}
	rt.call_function('add_action', [rt.new_string('smoothgenerator_coupon_generated'), rt.new_closure(closure_17_fn)])
	mut var_remaining_amount := var_amount.clone()
	mut var_generated := rt.new_int(0)
	for rt.is_true(rt.greater(var_remaining_amount, rt.new_int(0))) {
		mut var_batch := rt.call_function('min', [var_remaining_amount.clone(), Class_WC_SmoothGenerator_Generator_Coupon.max_batch_size()])
		mut iife_temp_17 := Class_WC_SmoothGenerator_Generator_Coupon{}
		mut iife_result_17 := iife_temp_17.batch(var_batch.clone(), var_assoc_args.clone())
		mut var_result := iife_result_17
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		mut iife_temp_18 := Class_WP_CLI{}
		mut iife_result_18 := iife_temp_18.error(var_result.clone())
		}
		var_generated = rt.add(var_generated, rt.new_int(var_result.clone().array_count()))
		var_remaining_amount = rt.sub(var_remaining_amount, var_batch)
	}
	rt.call_method(var_progress, 'finish', []rt.PhpVal{})
mut var_time_end := rt.call_function('microtime', [rt.new_bool(true)])
mut var_execution_time := rt.call_function('round', [rt.sub(var_time_end, var_time_start), rt.new_int(2)])
mut var_display_time := if rt.is_true(rt.less(var_execution_time, rt.new_int(60))) { (var_execution_time).str() + ' seconds' } else { rt.call_function('human_time_diff', [var_time_start.clone(), var_time_end.clone()]) }
mut iife_temp_19 := Class_WP_CLI{}
mut iife_result_19 := iife_temp_19.success(rt.new_string((var_generated).str() + ' coupons generated in ' + (var_display_time).str()))
}

fn Class_WC_SmoothGenerator_CLI.terms(var_args rt.PhpVal, var_assoc_args rt.PhpVal) {
	mut var_taxonomy := rt.new_null()
	mut list_tmp_5 := var_args
	var_taxonomy = (list_tmp_5).array_get(0)
	mut var_amount := (list_tmp_5).array_get(1)
	var_amount = rt.call_function('absint', [var_amount.clone()])
	mut var_time_start := rt.call_function('microtime', [rt.new_bool(true)])
	mut var_progress := rt.call_function('WP_CLI\Utils\make_progress_bar', [rt.new_string('Generating terms'), var_amount.clone()])
	closure_21_fn := fn [var_progress] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		rt.call_method(var_progress, 'tick', []rt.PhpVal{})
		return rt.new_null()
		}
	rt.call_function('add_action', [rt.new_string('smoothgenerator_term_generated'), rt.new_closure(closure_21_fn)])
	mut var_remaining_amount := var_amount.clone()
	mut var_generated := rt.new_int(0)
	for rt.is_true(rt.greater(var_remaining_amount, rt.new_int(0))) {
		mut var_batch := rt.call_function('min', [var_remaining_amount.clone(), Class_WC_SmoothGenerator_Generator_Term.max_batch_size()])
		mut iife_temp_21 := Class_WC_SmoothGenerator_Generator_Term{}
		mut iife_result_21 := iife_temp_21.batch(var_amount.clone(), var_taxonomy.clone(), var_assoc_args.clone())
		mut var_result := iife_result_21
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		mut iife_temp_22 := Class_WP_CLI{}
		mut iife_result_22 := iife_temp_22.error(var_result.clone())
		}
		var_generated = rt.add(var_generated, rt.new_int(var_result.clone().array_count()))
		var_remaining_amount = rt.sub(var_remaining_amount, var_batch)
	}
	rt.call_method(var_progress, 'finish', []rt.PhpVal{})
mut var_time_end := rt.call_function('microtime', [rt.new_bool(true)])
mut var_execution_time := rt.call_function('round', [rt.sub(var_time_end, var_time_start), rt.new_int(2)])
mut var_display_time := if rt.is_true(rt.less(var_execution_time, rt.new_int(60))) { (var_execution_time).str() + ' seconds' } else { rt.call_function('human_time_diff', [var_time_start.clone(), var_time_end.clone()]) }
mut iife_temp_23 := Class_WP_CLI{}
mut iife_result_23 := iife_temp_23.success(rt.new_string((var_generated).str() + ' terms generated in ' + (var_display_time).str()))
}

struct Class_WP_CLI_Command {
	rt.PhpObjectBase
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_Product {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_Order {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_Customer {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_Coupon {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_Term {
	rt.PhpObjectBase
}

fn create_wc_smoothgenerator_cli(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_CLI {
	mut iife_temp_24 := Class_WP_CLI{}
	mut iife_result_24 := iife_temp_24.add_command(rt.new_string('wc generate products'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC\\SmoothGenerator\\CLI' }, rt.ArrayItem{ key: none, val: 'products' }]), rt.create_array([rt.ArrayItem{ key: 'shortdesc', val: 'Generate products.' }, rt.ArrayItem{ key: 'synopsis', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'amount' }, rt.ArrayItem{ key: 'type', val: 'positional' }, rt.ArrayItem{ key: 'description', val: 'The number of products to generate.' }, rt.ArrayItem{ key: 'optional', val: true }, rt.ArrayItem{ key: 'default', val: 10 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'type' }, rt.ArrayItem{ key: 'type', val: 'assoc' }, rt.ArrayItem{ key: 'description', val: 'Specify one type of product to generate. Otherwise defaults to a mix.' }, rt.ArrayItem{ key: 'optional', val: true }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: none, val: 'simple' }, rt.ArrayItem{ key: none, val: 'variable' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'use-existing-terms' }, rt.ArrayItem{ key: 'type', val: 'flag' }, rt.ArrayItem{ key: 'description', val: 'Only apply existing categories and tags to products, rather than generating new ones.' }, rt.ArrayItem{ key: 'optional', val: true }]) }]) }, rt.ArrayItem{ key: 'longdesc', val: '## EXAMPLES\n\nwc generate products 10\n\nwc generate products 20 --type=variable --use-existing-terms' }]))
	mut iife_temp_25 := Class_WP_CLI{}
	mut iife_result_25 := iife_temp_25.add_command(rt.new_string('wc generate orders'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC\\SmoothGenerator\\CLI' }, rt.ArrayItem{ key: none, val: 'orders' }]), rt.create_array([rt.ArrayItem{ key: 'shortdesc', val: 'Generate orders.' }, rt.ArrayItem{ key: 'synopsis', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'amount' }, rt.ArrayItem{ key: 'type', val: 'positional' }, rt.ArrayItem{ key: 'description', val: 'The number of orders to generate.' }, rt.ArrayItem{ key: 'optional', val: true }, rt.ArrayItem{ key: 'default', val: 10 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'date-start' }, rt.ArrayItem{ key: 'type', val: 'assoc' }, rt.ArrayItem{ key: 'description', val: 'Randomize the order date using this as the lower limit. Format as YYYY-MM-DD.' }, rt.ArrayItem{ key: 'optional', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'date-end' }, rt.ArrayItem{ key: 'type', val: 'assoc' }, rt.ArrayItem{ key: 'description', val: 'Randomize the order date using this as the upper limit. Only works in conjunction with date-start. Format as YYYY-MM-DD.' }, rt.ArrayItem{ key: 'optional', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'status' }, rt.ArrayItem{ key: 'type', val: 'assoc' }, rt.ArrayItem{ key: 'description', val: 'Specify one status for all the generated orders. Otherwise defaults to a mix.' }, rt.ArrayItem{ key: 'optional', val: true }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: none, val: 'completed' }, rt.ArrayItem{ key: none, val: 'processing' }, rt.ArrayItem{ key: none, val: 'on-hold' }, rt.ArrayItem{ key: none, val: 'failed' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'coupons' }, rt.ArrayItem{ key: 'type', val: 'flag' }, rt.ArrayItem{ key: 'description', val: 'Create and apply a coupon to each generated order. Equivalent to --coupon-ratio=1.0.' }, rt.ArrayItem{ key: 'optional', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'coupon-ratio' }, rt.ArrayItem{ key: 'type', val: 'assoc' }, rt.ArrayItem{ key: 'description', val: 'Decimal ratio (0.0-1.0) of orders that should have coupons applied. If no coupons exist, 6 will be created (3 fixed value, 3 percentage). Note: Decimal values are converted to percentages using integer rounding (e.g., 0.505 becomes 50%).' }, rt.ArrayItem{ key: 'optional', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'refund-ratio' }, rt.ArrayItem{ key: 'type', val: 'assoc' }, rt.ArrayItem{ key: 'description', val: 'Decimal ratio (0.0-1.0) of completed orders that should be refunded (wholly or partially). Note: Decimal values are converted to percentages using integer rounding (e.g., 0.505 becomes 50%).' }, rt.ArrayItem{ key: 'optional', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'skip-order-attribution' }, rt.ArrayItem{ key: 'type', val: 'flag' }, rt.ArrayItem{ key: 'description', val: 'Skip adding order attribution meta to the generated orders.' }, rt.ArrayItem{ key: 'optional', val: true }]) }]) }, rt.ArrayItem{ key: 'longdesc', val: '## EXAMPLES\n\nwc generate orders 10\n\nwc generate orders 50 --date-start=2020-01-01 --date-end=2022-12-31 --status=completed --coupons' }]))
	mut iife_temp_26 := Class_WP_CLI{}
	mut iife_result_26 := iife_temp_26.add_command(rt.new_string('wc generate customers'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC\\SmoothGenerator\\CLI' }, rt.ArrayItem{ key: none, val: 'customers' }]), rt.create_array([rt.ArrayItem{ key: 'shortdesc', val: 'Generate customers.' }, rt.ArrayItem{ key: 'synopsis', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'amount' }, rt.ArrayItem{ key: 'type', val: 'positional' }, rt.ArrayItem{ key: 'description', val: 'The number of customers to generate.' }, rt.ArrayItem{ key: 'optional', val: true }, rt.ArrayItem{ key: 'default', val: 10 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'country' }, rt.ArrayItem{ key: 'type', val: 'assoc' }, rt.ArrayItem{ key: 'description', val: 'The ISO 3166-1 alpha-2 country code to use for localizing the customer data. If none is specified, any country in the "Selling location(s)" setting may be used.' }, rt.ArrayItem{ key: 'optional', val: true }, rt.ArrayItem{ key: 'default', val: '' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'type' }, rt.ArrayItem{ key: 'type', val: 'assoc' }, rt.ArrayItem{ key: 'description', val: 'The type of customer to generate data for. If none is specified, it will be a 70% person, 30% company mix.' }, rt.ArrayItem{ key: 'optional', val: true }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: none, val: 'company' }, rt.ArrayItem{ key: none, val: 'person' }]) }]) }]) }, rt.ArrayItem{ key: 'longdesc', val: '## EXAMPLES\n\nwc generate customers 10\n\nwc generate customers --country=ES --type=company' }]))
	mut iife_temp_27 := Class_WP_CLI{}
	mut iife_result_27 := iife_temp_27.add_command(rt.new_string('wc generate coupons'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC\\SmoothGenerator\\CLI' }, rt.ArrayItem{ key: none, val: 'coupons' }]), rt.create_array([rt.ArrayItem{ key: 'shortdesc', val: 'Generate coupons.' }, rt.ArrayItem{ key: 'synopsis', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'amount' }, rt.ArrayItem{ key: 'type', val: 'positional' }, rt.ArrayItem{ key: 'description', val: 'The number of coupons to generate.' }, rt.ArrayItem{ key: 'optional', val: true }, rt.ArrayItem{ key: 'default', val: 10 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'min' }, rt.ArrayItem{ key: 'type', val: 'assoc' }, rt.ArrayItem{ key: 'description', val: 'Specify the minimum discount of each coupon, as an integer.' }, rt.ArrayItem{ key: 'optional', val: true }, rt.ArrayItem{ key: 'default', val: 5 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'max' }, rt.ArrayItem{ key: 'type', val: 'assoc' }, rt.ArrayItem{ key: 'description', val: 'Specify the maximum discount of each coupon, as an integer.' }, rt.ArrayItem{ key: 'optional', val: true }, rt.ArrayItem{ key: 'default', val: 100 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'discount_type' }, rt.ArrayItem{ key: 'type', val: 'assoc' }, rt.ArrayItem{ key: 'description', val: 'The type of discount for the coupon. If not specified, defaults to WooCommerce default (fixed_cart).' }, rt.ArrayItem{ key: 'optional', val: true }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: none, val: 'fixed_cart' }, rt.ArrayItem{ key: none, val: 'percent' }]) }]) }]) }, rt.ArrayItem{ key: 'longdesc', val: '## EXAMPLES\n\nwc generate coupons 10\n\nwc generate coupons 50 --min=1 --max=50\n\nwc generate coupons 20 --discount_type=percent --min=5 --max=25' }]))
	mut iife_temp_28 := Class_WP_CLI{}
	mut iife_result_28 := iife_temp_28.add_command(rt.new_string('wc generate terms'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC\\SmoothGenerator\\CLI' }, rt.ArrayItem{ key: none, val: 'terms' }]), rt.create_array([rt.ArrayItem{ key: 'shortdesc', val: 'Generate product categories.' }, rt.ArrayItem{ key: 'synopsis', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'taxonomy' }, rt.ArrayItem{ key: 'type', val: 'positional' }, rt.ArrayItem{ key: 'description', val: 'The taxonomy to generate the terms for.' }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: none, val: 'product_cat' }, rt.ArrayItem{ key: none, val: 'product_tag' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'amount' }, rt.ArrayItem{ key: 'type', val: 'positional' }, rt.ArrayItem{ key: 'description', val: 'The number of terms to generate.' }, rt.ArrayItem{ key: 'optional', val: true }, rt.ArrayItem{ key: 'default', val: 10 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'max-depth' }, rt.ArrayItem{ key: 'type', val: 'assoc' }, rt.ArrayItem{ key: 'description', val: 'The maximum number of hierarchy levels for the terms. A value of 1 means all categories will be top-level. Max value 5. Only applies to taxonomies that are hierarchical.' }, rt.ArrayItem{ key: 'optional', val: true }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: none, val: 1 }, rt.ArrayItem{ key: none, val: 2 }, rt.ArrayItem{ key: none, val: 3 }, rt.ArrayItem{ key: none, val: 4 }, rt.ArrayItem{ key: none, val: 5 }]) }, rt.ArrayItem{ key: 'default', val: 1 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'parent' }, rt.ArrayItem{ key: 'type', val: 'assoc' }, rt.ArrayItem{ key: 'description', val: 'Specify an existing term ID as the parent for the new terms. Only applies to taxonomies that are hierarchical.' }, rt.ArrayItem{ key: 'optional', val: true }, rt.ArrayItem{ key: 'default', val: 0 }]) }]) }, rt.ArrayItem{ key: 'longdesc', val: '## EXAMPLES\n\nwc generate terms product_tag 10\n\nwc generate terms product_cat 50 --max-depth=3' }]))
	mut obj := &Class_WC_SmoothGenerator_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli_command(_args ...rt.PhpVal) &Class_WP_CLI_Command {
	mut obj := &Class_WP_CLI_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli(_args ...rt.PhpVal) &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_product(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_Product {
	mut obj := &Class_WC_SmoothGenerator_Generator_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_order(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_Order {
	mut obj := &Class_WC_SmoothGenerator_Generator_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_customer(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_Customer {
	mut obj := &Class_WC_SmoothGenerator_Generator_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_coupon(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_Coupon {
	mut obj := &Class_WC_SmoothGenerator_Generator_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_term(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_Term {
	mut obj := &Class_WC_SmoothGenerator_Generator_Term{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_SmoothGenerator_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_SmoothGenerator_CLI.products(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_SmoothGenerator_CLI.orders(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'customers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_SmoothGenerator_CLI.customers(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'coupons' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_SmoothGenerator_CLI.coupons(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'terms' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_SmoothGenerator_CLI.terms(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_SmoothGenerator_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_CLI_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_CLI_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_CLI_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_Term) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_Term) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Term) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
