import rt

fn register_block_bindings_source(source_name string, var_source_properties rt.PhpVal) rt.PhpVal {
	return rt.call_method(fn () rt.PhpVal {
		mut temp := Class_WP_Block_Bindings_Registry{}
		return temp.get_instance()
	}(), 'register', [rt.new_string(source_name), var_source_properties.dup()])
}

fn unregister_block_bindings_source(source_name string) rt.PhpVal {
	return rt.call_method(fn () rt.PhpVal {
		mut temp := Class_WP_Block_Bindings_Registry{}
		return temp.get_instance()
	}(), 'unregister', [rt.new_string(source_name)])
}

fn get_all_registered_block_bindings_sources() rt.PhpVal {
	return rt.call_method(fn () rt.PhpVal {
		mut temp := Class_WP_Block_Bindings_Registry{}
		return temp.get_instance()
	}(), 'get_all_registered', []rt.PhpVal{})
}

fn get_block_bindings_source(source_name string) rt.PhpVal {
	return rt.call_method(fn () rt.PhpVal {
		mut temp := Class_WP_Block_Bindings_Registry{}
		return temp.get_instance()
	}(), 'get_registered', [rt.new_string(source_name)])
}

fn get_block_bindings_supported_attributes(var_block_type rt.PhpVal) rt.PhpVal {
	mut var_block_bindings_supported_attributes := {
		'core/paragraph':          map[string]rt.PhpVal{}
		'core/heading':            map[string]rt.PhpVal{}
		'core/image':              map[string]rt.PhpVal{}
		'core/button':             map[string]rt.PhpVal{}
		'core/post-date':          map[string]rt.PhpVal{}
		'core/navigation-link':    map[string]rt.PhpVal{}
		'core/navigation-submenu': map[string]rt.PhpVal{}
	}
	mut var_supported_block_attributes := if !var_block_type.is_null()
		&& var_block_bindings_supported_attributes.array_isset(var_block_type) {
		var_block_bindings_supported_attributes.array_get(var_block_type)
	} else {
		rt.new_array()
	}
	var_supported_block_attributes = rt.call_function('apply_filters', [
		rt.new_string('block_bindings_supported_attributes'),
		var_supported_block_attributes.dup(),
		var_block_type.dup(),
	])
	var_supported_block_attributes = rt.call_function('apply_filters', [
		rt.new_string('block_bindings_supported_attributes_${var_block_type.to_string()}'),
		var_supported_block_attributes.dup(),
	])
	return var_supported_block_attributes.dup()
}

struct Class_WP_Block_Bindings_Registry {
	rt.PhpObjectBase
}

fn create_wp_block_bindings_registry() &Class_WP_Block_Bindings_Registry {
	mut obj := &Class_WP_Block_Bindings_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Bindings_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Bindings_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Bindings_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_block_bindings_php() {
}
