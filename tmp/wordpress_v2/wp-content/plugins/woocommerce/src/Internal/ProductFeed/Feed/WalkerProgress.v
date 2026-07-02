import rt

struct Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_WalkerProgress {
	rt.PhpObjectBase
pub mut:
	total_count       rt.PhpVal = rt.new_null()
	total_batch_count rt.PhpVal = rt.new_null()
	processed_items   rt.PhpVal = rt.new_int(0)
	processed_batches rt.PhpVal = rt.new_int(0)
}

fn Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_WalkerProgress.from_wc_get_products_result(mut var_result Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_stdClass) rt.PhpVal {
	mut var_progress := create_automattic_woocommerce_internal_productfeed_feed_self()
	rt.set_property(var_progress, 'total_count', rt.get_property(var_result, 'total'))
	rt.set_property(var_progress, 'total_batch_count', rt.get_property(var_result, 'max_num_pages'))
	rt.set_property(var_progress, 'processed_items', rt.new_int(0))
	rt.set_property(var_progress, 'processed_batches', rt.new_int(0))
	return mut var_progress
}

struct Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_self {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productfeed_feed_walkerprogress(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_WalkerProgress {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_WalkerProgress{
		PhpObjectBase:     rt.PhpObjectBase{}
		total_count:       rt.new_null()
		total_batch_count: rt.new_null()
		processed_items:   rt.new_int(0)
		processed_batches: rt.new_int(0)
	}
	return obj
}

fn create_automattic_woocommerce_internal_productfeed_feed_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_self {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_WalkerProgress) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'from_wc_get_products_result' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_stdClass](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_WalkerProgress.from_wc_get_products_result(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_WalkerProgress) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'total_count' { return this.total_count }
		'total_batch_count' { return this.total_batch_count }
		'processed_items' { return this.processed_items }
		'processed_batches' { return this.processed_batches }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_WalkerProgress) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'total_count' {
			this.total_count = val
			return true
		}
		'total_batch_count' {
			this.total_batch_count = val
			return true
		}
		'processed_items' {
			this.processed_items = val
			return true
		}
		'processed_batches' {
			this.processed_batches = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
