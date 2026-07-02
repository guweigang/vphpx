import rt

struct Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalPluginResourceStorage {
	rt.PhpObjectBase
pub mut:
	paths  rt.PhpVal = rt.new_array()
	suffix rt.PhpVal = rt.new_string('plugins')
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalPluginResourceStorage) construct(var_path rt.PhpVal) {
	this.paths.array_push(var_path.clone())
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalPluginResourceStorage) download(var_slug rt.PhpVal) string {
	mut iter_1 := this.paths.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_path := item_1.val
		mut var_full_path := rt.new_string(var_path.str() +
			rt.concat(rt.concat(rt.new_string('/'), this.suffix), rt.new_string('/')) +
			var_slug.str() + '.zip')
		if rt.is_true(rt.call_function('is_file', [var_full_path.clone()])) {
			return var_full_path.str()
		}
	}
	return (rt.new_null()).str()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalPluginResourceStorage) get_supported_resource() string {
	return 'self/plugins'
}

fn create_automattic_woocommerce_blueprint_resourcestorages_localpluginresourcestorage(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalPluginResourceStorage {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalPluginResourceStorage{
		PhpObjectBase: rt.PhpObjectBase{}
		paths:         rt.new_array()
		suffix:        rt.new_string('plugins')
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalPluginResourceStorage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'download' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.download(dispatch_arg_0))
		}
		'get_supported_resource' {
			return rt.new_string(this.get_supported_resource())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalPluginResourceStorage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'paths' { return this.paths }
		'suffix' { return this.suffix }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResourceStorages_LocalPluginResourceStorage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'paths' {
			this.paths = val
			return true
		}
		'suffix' {
			this.suffix = val
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
