import rt

struct Class_Automattic_WooCommerce_Blueprint_ResourceStorages {
	rt.PhpObjectBase
pub mut:
	storages rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages) add_storage(mut var_downloader Class_Automattic_WooCommerce_Blueprint_ResourceStorages_ResourceStorage) {
	mut var_supported_resource := var_downloader.get_supported_resource()
	if !(this.storages.array_isset(var_supported_resource)) {
		this.storages.array_set(var_supported_resource, rt.new_array())
	}
	this.storages.array_get_mut(var_supported_resource).array_push(var_downloader)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages) is_supported_resource(var_resource_type rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.storages.array_isset(var_resource_type))
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages) download(var_slug rt.PhpVal, var_resource_type rt.PhpVal) bool {
	if !(this.storages.array_isset(var_resource_type)) {
		return false
	}
	mut var_storages := this.storages.array_get(var_resource_type)
	mut iter_1 := var_storages.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_storage := item_1.val
		mut var_found := rt.call_method(var_storage, 'download', [
			var_slug.clone()])
		if rt.is_true(var_found) {
			return var_found.to_bool()
		}
	}
	return false
}

fn create_automattic_woocommerce_blueprint_resourcestorages(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_ResourceStorages {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ResourceStorages{
		PhpObjectBase: rt.PhpObjectBase{}
		storages:      rt.new_array()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_storage' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_ResourceStorages_ResourceStorage](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.add_storage(mut dispatch_arg_0)
			return rt.new_null()
		}
		'is_supported_resource' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_supported_resource(dispatch_arg_0)
		}
		'download' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.download(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ResourceStorages) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'storages' { return this.storages }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'storages' {
			this.storages = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
