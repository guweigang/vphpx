import rt

struct Class_WC_SmoothGenerator_CLI {
	rt.PhpObjectBase
}

fn Class_WC_SmoothGenerator_CLI.products(var_args rt.PhpVal, var_assoc_args rt.PhpVal)  {
	// unsupported assign target: Expr_List
	mut var_amount := rt.call_function('absint', [var_amount.dup()])
	mut var_time_start := rt.call_function('microtime', [rt.new_bool(true)])
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.line(arg_0) }(rt.new_string('Initializing...'))
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_Product{}; return temp.seed_images(arg_0) }(rt.call_function('min', [rt.add(var_amount, rt.new_int(19)), rt.new_int(100)]))
	mut var_progress := rt.call_function('WP_CLI\Utils\make_progress_bar', [rt.new_string('Generating products'), var_amount.dup()])
	closure_1_fn := fn [var_progress] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	rt.call_method(var_progress, 'tick', []rt.PhpVal{})
	return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('smoothgenerator_product_generated'), rt.new_closure(closure_1_fn)])
	mut var_remaining_amount := var_amount.dup()
	mut var_generated := rt.new_int(rt.new_int(0))
	for rt.is_true(rt.greater(var_remaining_amount, rt.new_int(0))) {
		mut var_batch := rt.call_function('min', [var_remaining_amount.dup(), Class_WC_SmoothGenerator_Generator_Product.max_batch_size()])
		mut var_result := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_Product{}; return temp.batch(arg_0, arg_1) }(var_batch.dup(), var_assoc_args.dup())
		if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(var_result.dup())
		}
		// unsupported expression: Expr_AssignOp_Plus
		// unsupported expression: Expr_AssignOp_Minus
	}
	rt.call_method(var_progress, 'finish', []rt.PhpVal{})
	mut var_time_end := rt.call_function('microtime', [rt.new_bool(true)])
	mut var_execution_time := rt.call_function('round', [rt.sub(var_time_end, var_time_start), rt.new_int(2)])
	mut var_display_time := if rt.is_true(rt.less(var_execution_time, rt.new_int(60))) { (var_execution_time).str() + ' seconds' } else { rt.call_function('human_time_diff', [var_time_start.dup(), var_time_end.dup()]) }
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.success(arg_0) }(rt.new_string((var_generated).str() + ' products generated in ' + (var_display_time).str()))
}

fn Class_WC_SmoothGenerator_CLI.orders(var_args rt.PhpVal, var_assoc_args rt.PhpVal)  {
	// unsupported assign target: Expr_List
	mut var_amount := rt.call_function('absint', [var_amount.dup()])
	mut var_time_start := rt.call_function('microtime', [rt.new_bool(true)])
	if !(!rt.is_true(var_assoc_args.array_get('status'))) {
		mut var_status := var_assoc_args.array_get('status')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_order_status', ['wc-' + (var_status).str()]))))) {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(rt.new_string("The argument \"${var_status.to_string()}\" is not a valid order status."))
			return rt.new_null()
		}
	}
	mut var_progress := rt.call_function('WP_CLI\Utils\make_progress_bar', [rt.new_string('Generating orders'), var_amount.dup()])
	closure_2_fn := fn [var_progress] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	rt.call_method(var_progress, 'tick', []rt.PhpVal{})
	return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('smoothgenerator_order_generated'), rt.new_closure(closure_2_fn)])
	mut var_remaining_amount := var_amount.dup()
	mut var_generated := rt.new_int(rt.new_int(0))
	for rt.is_true(rt.greater(var_remaining_amount, rt.new_int(0))) {
		mut var_batch := rt.call_function('min', [var_remaining_amount.dup(), Class_WC_SmoothGenerator_Generator_Order.max_batch_size()])
		mut var_result := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_Order{}; return temp.batch(arg_0, arg_1) }(var_batch.dup(), var_assoc_args.dup())
		if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(var_result.dup())
		}
		// unsupported expression: Expr_AssignOp_Plus
		// unsupported expression: Expr_AssignOp_Minus
	}
	rt.call_method(var_progress, 'finish', []rt.PhpVal{})
	mut var_time_end := rt.call_function('microtime', [rt.new_bool(true)])
	mut var_execution_time := rt.call_function('round', [rt.sub(var_time_end, var_time_start), rt.new_int(2)])
	mut var_display_time := if rt.is_true(rt.less(var_execution_time, rt.new_int(60))) { (var_execution_time).str() + ' seconds' } else { rt.call_function('human_time_diff', [var_time_start.dup(), var_time_end.dup()]) }
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_generated, rt.new_int(0))) && rt.is_true(rt.greater(var_amount, rt.new_int(0))))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(rt.new_string('No orders were generated. Make sure there are published products in your store.'))
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.success(arg_0) }(rt.new_string((var_generated).str() + ' orders generated in ' + (var_display_time).str()))
}

fn Class_WC_SmoothGenerator_CLI.customers(var_args rt.PhpVal, var_assoc_args rt.PhpVal)  {
	// unsupported assign target: Expr_List
	mut var_amount := rt.call_function('absint', [var_amount.dup()])
	mut var_time_start := rt.call_function('microtime', [rt.new_bool(true)])
	mut var_progress := rt.call_function('WP_CLI\Utils\make_progress_bar', [rt.new_string('Generating customers'), var_amount.dup()])
	closure_3_fn := fn [var_progress] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	rt.call_method(var_progress, 'tick', []rt.PhpVal{})
	return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('smoothgenerator_customer_generated'), rt.new_closure(closure_3_fn)])
	mut var_remaining_amount := var_amount.dup()
	mut var_generated := rt.new_int(rt.new_int(0))
	for rt.is_true(rt.greater(var_remaining_amount, rt.new_int(0))) {
		mut var_batch := rt.call_function('min', [var_remaining_amount.dup(), Class_WC_SmoothGenerator_Generator_Customer.max_batch_size()])
		mut var_result := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_Customer{}; return temp.batch(arg_0, arg_1) }(var_batch.dup(), var_assoc_args.dup())
		if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(var_result.dup())
		}
		// unsupported expression: Expr_AssignOp_Plus
		// unsupported expression: Expr_AssignOp_Minus
	}
	rt.call_method(var_progress, 'finish', []rt.PhpVal{})
	mut var_time_end := rt.call_function('microtime', [rt.new_bool(true)])
	mut var_execution_time := rt.call_function('round', [rt.sub(var_time_end, var_time_start), rt.new_int(2)])
	mut var_display_time := if rt.is_true(rt.less(var_execution_time, rt.new_int(60))) { (var_execution_time).str() + ' seconds' } else { rt.call_function('human_time_diff', [var_time_start.dup(), var_time_end.dup()]) }
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.success(arg_0) }(rt.new_string((var_generated).str() + ' customers generated in ' + (var_display_time).str()))
}

fn Class_WC_SmoothGenerator_CLI.coupons(var_args rt.PhpVal, var_assoc_args rt.PhpVal)  {
	// unsupported assign target: Expr_List
	mut var_amount := rt.call_function('absint', [var_amount.dup()])
	mut var_time_start := rt.call_function('microtime', [rt.new_bool(true)])
	mut var_progress := rt.call_function('WP_CLI\Utils\make_progress_bar', [rt.new_string('Generating coupons'), var_amount.dup()])
	closure_4_fn := fn [var_progress] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	rt.call_method(var_progress, 'tick', []rt.PhpVal{})
	return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('smoothgenerator_coupon_generated'), rt.new_closure(closure_4_fn)])
	mut var_remaining_amount := var_amount.dup()
	mut var_generated := rt.new_int(rt.new_int(0))
	for rt.is_true(rt.greater(var_remaining_amount, rt.new_int(0))) {
		mut var_batch := rt.call_function('min', [var_remaining_amount.dup(), Class_WC_SmoothGenerator_Generator_Coupon.max_batch_size()])
		mut var_result := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_Coupon{}; return temp.batch(arg_0, arg_1) }(var_batch.dup(), var_assoc_args.dup())
		if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(var_result.dup())
		}
		// unsupported expression: Expr_AssignOp_Plus
		// unsupported expression: Expr_AssignOp_Minus
	}
	rt.call_method(var_progress, 'finish', []rt.PhpVal{})
	mut var_time_end := rt.call_function('microtime', [rt.new_bool(true)])
	mut var_execution_time := rt.call_function('round', [rt.sub(var_time_end, var_time_start), rt.new_int(2)])
	mut var_display_time := if rt.is_true(rt.less(var_execution_time, rt.new_int(60))) { (var_execution_time).str() + ' seconds' } else { rt.call_function('human_time_diff', [var_time_start.dup(), var_time_end.dup()]) }
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.success(arg_0) }(rt.new_string((var_generated).str() + ' coupons generated in ' + (var_display_time).str()))
}

fn Class_WC_SmoothGenerator_CLI.terms(var_args rt.PhpVal, var_assoc_args rt.PhpVal)  {
	mut var_taxonomy := rt.new_null()
	// unsupported assign target: Expr_List
	mut var_amount := rt.call_function('absint', [var_amount.dup()])
	mut var_time_start := rt.call_function('microtime', [rt.new_bool(true)])
	mut var_progress := rt.call_function('WP_CLI\Utils\make_progress_bar', [rt.new_string('Generating terms'), var_amount.dup()])
	closure_5_fn := fn [var_progress] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	rt.call_method(var_progress, 'tick', []rt.PhpVal{})
	return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('smoothgenerator_term_generated'), rt.new_closure(closure_5_fn)])
	mut var_remaining_amount := var_amount.dup()
	mut var_generated := rt.new_int(rt.new_int(0))
	for rt.is_true(rt.greater(var_remaining_amount, rt.new_int(0))) {
		mut var_batch := rt.call_function('min', [var_remaining_amount.dup(), Class_WC_SmoothGenerator_Generator_Term.max_batch_size()])
		mut var_result := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_Term{}; return temp.batch(arg_0, arg_1, arg_2) }(var_amount.dup(), var_taxonomy.dup(), var_assoc_args.dup())
		if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(var_result.dup())
		}
		// unsupported expression: Expr_AssignOp_Plus
		// unsupported expression: Expr_AssignOp_Minus
	}
	
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

fn create_wc_smoothgenerator_cli() &Class_WC_SmoothGenerator_CLI {
	mut obj := &Class_WC_SmoothGenerator_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli_command() &Class_WP_CLI_Command {
	mut obj := &Class_WP_CLI_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli() &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_product() &Class_WC_SmoothGenerator_Generator_Product {
	mut obj := &Class_WC_SmoothGenerator_Generator_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_order() &Class_WC_SmoothGenerator_Generator_Order {
	mut obj := &Class_WC_SmoothGenerator_Generator_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_customer() &Class_WC_SmoothGenerator_Generator_Customer {
	mut obj := &Class_WC_SmoothGenerator_Generator_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_coupon() &Class_WC_SmoothGenerator_Generator_Coupon {
	mut obj := &Class_WC_SmoothGenerator_Generator_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_term() &Class_WC_SmoothGenerator_Generator_Term {
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




pub fn init_wp_content_plugins_wc_smooth_generator_includes_cli_php() {
}
