import rt

struct Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker {
	rt.PhpObjectBase
pub mut:
		product_loader rt.PhpVal = rt.new_null()
		mapper rt.PhpVal = rt.new_null()
		feed rt.PhpVal = rt.new_null()
		validator rt.PhpVal = rt.new_null()
		memory_manager rt.PhpVal = rt.new_null()
		per_page rt.PhpVal = rt.new_int(100)
		time_limit rt.PhpVal = rt.new_int(0)
		query_args rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker) construct(mut var_mapper Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductMapperInterface, mut var_validator Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_FeedValidatorInterface, mut var_feed Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_FeedInterface, mut var_product_loader Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductLoader, mut var_memory_manager Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_MemoryManager, mut var_query_args Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_array) {
	mut var_query_args_mutated := var_query_args
	this.mapper = var_mapper
	this.validator = var_validator
	this.feed = var_feed
	this.product_loader = var_product_loader
	this.memory_manager = var_memory_manager
	this.query_args = var_query_args_mutated
}

fn Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker.from_integration(mut var_integration Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_IntegrationInterface, mut var_feed Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_FeedInterface) rt.PhpVal {
	mut var_query_args := rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: none, val: 'publish' }]) }, rt.ArrayItem{ key: 'return', val: 'objects' }]), var_integration.get_product_feed_query_args()])
	var_query_args = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_feed_args'), var_query_args.clone(), var_integration])
	mut var_instance := create_automattic_woocommerce_internal_productfeed_feed_self(var_integration.get_product_mapper(), var_integration.get_feed_validator(), var_feed, rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductLoader.class()]), rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_MemoryManager.class()]), var_query_args.clone())
	return mut var_instance
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker) set_batch_size(batch_size i64) rt.PhpVal {
	mut batch_size_mutated := batch_size
	if batch_size_mutated < 1 {
	batch_size_mutated = 1
	}
	this.per_page = rt.new_int(batch_size_mutated).clone()
	return rt.new_object('Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker) add_time_limit(time_limit i64) rt.PhpVal {
	mut time_limit_mutated := time_limit
	if time_limit_mutated < 0 {
	time_limit_mutated = 0
	}
	this.time_limit = rt.new_int(time_limit_mutated).clone()
	return rt.new_object('Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker) walk(mut var_callback Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_?callable) i64 {
	mut var_progress := rt.new_null()
	rt.call_method(this.feed, 'start', []rt.PhpVal{})
	mut var_initial_available_memory := rt.call_method(this.memory_manager, 'get_available_memory', []rt.PhpVal{})
	for {
		mut var_result := this.iterate(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_array](this.query_args), (if rt.is_true(var_progress) { rt.add(rt.get_property(var_progress, 'processed_batches'), rt.new_int(1)) } else { rt.new_int(1) }).to_i64(), (this.per_page).to_i64())
		mut var_iterated := rt.new_int(rt.get_property(var_result, 'products').array_count())
		if rt.is_true(rt.new_bool(var_progress.clone().is_null())) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_WalkerProgress{}
		mut iife_result_0 := iife_temp_0.from_wc_get_products_result(var_result.clone())
		var_progress = iife_result_0
		}
		rt.get_property(var_progress, 'processed_items') = rt.add(rt.get_property(var_progress, 'processed_items'), var_iterated)
		rt.pre_inc(rt.get_property(var_progress, 'processed_batches'))
		if rt.call_function('is_callable', [var_callback]) && rt.is_true(rt.greater(var_iterated, rt.new_int(0))) {
			rt.call_callable(var_callback, [var_progress.clone()])
		}
		if rt.is_true(rt.greater(this.time_limit, rt.new_int(0))) {
			rt.call_function('set_time_limit', [this.time_limit])
		}
		mut var_current_memory := rt.call_method(this.memory_manager, 'get_available_memory', []rt.PhpVal{})
		if rt.is_true(rt.greater_equal(rt.sub(var_initial_available_memory, var_current_memory), rt.div(var_initial_available_memory, rt.new_int(2)))) {
			rt.call_method(this.memory_manager, 'flush_caches', []rt.PhpVal{})
		}
		if !(rt.is_true(rt.identical(var_iterated, this.per_page)) && rt.is_true(rt.less(rt.get_property(var_progress, 'processed_batches'), rt.get_property(var_progress, 'total_batch_count')))) {
			break
		}
	}
	rt.call_method(this.feed, 'end', []rt.PhpVal{})
	return (rt.get_property(var_progress, 'processed_items')).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker) iterate(mut var_args Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_array, page i64, limit i64) rt.PhpVal {
	mut var_result := rt.call_method(this.product_loader, 'get_products', [rt.call_function('array_merge', [var_args, rt.create_array([rt.ArrayItem{ key: 'page', val: page }, rt.ArrayItem{ key: 'limit', val: limit }, rt.ArrayItem{ key: 'paginate', val: true }])])])
	mut iter_1 := rt.get_property(var_result, 'products').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_product := item_1.val
		mut var_mapped_data := rt.call_method(this.mapper, 'map_product', [var_product.clone()])
		if !(!rt.is_true(rt.call_method(this.validator, 'validate_entry', [var_mapped_data.clone(), var_product.clone()]))) {
			continue
		}
		rt.call_method(this.feed, 'add_entry', [var_mapped_data.clone()])
	}
	return var_result.clone()
}

struct Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_WalkerProgress {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productfeed_feed_productwalker(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal, arg_5 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker{
		PhpObjectBase: rt.PhpObjectBase{}
		product_loader: rt.new_null()
		mapper: rt.new_null()
		feed: rt.new_null()
		validator: rt.new_null()
		memory_manager: rt.new_null()
		per_page: rt.new_int(100)
		time_limit: rt.new_int(0)
		query_args: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
	return obj
}

fn create_automattic_woocommerce_internal_productfeed_feed_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_self {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_productfeed_feed_walkerprogress(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_WalkerProgress {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_WalkerProgress{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductMapperInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_FeedValidatorInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_FeedInterface](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductLoader](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_MemoryManager](if args.len > 4 { args[4] } else { rt.new_null() })
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_array](if args.len > 5 { args[5] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5)
			return rt.new_null()
		}
		'from_integration' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_IntegrationInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_FeedInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker.from_integration(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'set_batch_size' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.set_batch_size(dispatch_arg_0)
		}
		'add_time_limit' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.add_time_limit(dispatch_arg_0)
		}
		'walk' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_?callable](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_int(this.walk(mut dispatch_arg_0))
		}
		'iterate' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.iterate(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'product_loader' { return this.product_loader }
		'mapper' { return this.mapper }
		'feed' { return this.feed }
		'validator' { return this.validator }
		'memory_manager' { return this.memory_manager }
		'per_page' { return this.per_page }
		'time_limit' { return this.time_limit }
		'query_args' { return this.query_args }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'product_loader' { this.product_loader = val; return true }
		'mapper' { this.mapper = val; return true }
		'feed' { this.feed = val; return true }
		'validator' { this.validator = val; return true }
		'memory_manager' { this.memory_manager = val; return true }
		'per_page' { this.per_page = val; return true }
		'time_limit' { this.time_limit = val; return true }
		'query_args' { this.query_args = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_WalkerProgress) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_WalkerProgress) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_WalkerProgress) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		exit(0)
	}
}
