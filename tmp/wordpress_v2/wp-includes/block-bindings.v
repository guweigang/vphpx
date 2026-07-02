import rt

fn register_block_bindings_source(source_name string, var_source_properties rt.PhpVal) rt.PhpVal {
	mut var_source_name := source_name
	mut iife_temp_0 := Class_WP_Block_Bindings_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	return rt.call_method(iife_result_0, 'register', [rt.new_string(source_name),
		var_source_properties.clone()])
}

fn unregister_block_bindings_source(source_name string) rt.PhpVal {
	mut var_source_name := source_name
	mut iife_temp_1 := Class_WP_Block_Bindings_Registry{}
	mut iife_result_1 := iife_temp_1.get_instance()
	return rt.call_method(iife_result_1, 'unregister', [rt.new_string(source_name)])
}

fn get_all_registered_block_bindings_sources() rt.PhpVal {
	mut iife_temp_2 := Class_WP_Block_Bindings_Registry{}
	mut iife_result_2 := iife_temp_2.get_instance()
	return rt.call_method(iife_result_2, 'get_all_registered', []rt.PhpVal{})
}

fn get_block_bindings_source(source_name string) rt.PhpVal {
	mut var_source_name := source_name
	mut iife_temp_3 := Class_WP_Block_Bindings_Registry{}
	mut iife_result_3 := iife_temp_3.get_instance()
	return rt.call_method(iife_result_3, 'get_registered', [rt.new_string(source_name)])
}

fn get_block_bindings_supported_attributes(var_block_type rt.PhpVal) rt.PhpVal {
	mut var_block_bindings_supported_attributes := map[string]rt.PhpVal{}
	mut var_supported_block_attributes := rt.new_null()
	var_block_bindings_supported_attributes = {
		'core/paragraph':          map[string]rt.PhpVal{}
		'core/heading':            map[string]rt.PhpVal{}
		'core/image':              map[string]rt.PhpVal{}
		'core/button':             map[string]rt.PhpVal{}
		'core/post-date':          map[string]rt.PhpVal{}
		'core/navigation-link':    map[string]rt.PhpVal{}
		'core/navigation-submenu': map[string]rt.PhpVal{}
	}
	var_supported_block_attributes = if !var_block_type.is_null()
		&& var_block_bindings_supported_attributes.array_isset(var_block_type) {
		var_block_bindings_supported_attributes[var_block_type]
	} else {
		rt.new_array()
	}
	var_supported_block_attributes = rt.call_function('apply_filters', [
		rt.new_string('block_bindings_supported_attributes'),
		var_supported_block_attributes.clone(),
		var_block_type.clone(),
	])
	var_supported_block_attributes = rt.call_function('apply_filters', [
		rt.new_string('block_bindings_supported_attributes_${var_block_type.to_string()}'),
		var_supported_block_attributes.clone(),
	])
	return var_supported_block_attributes.clone()
}

struct Class_WP_Block_Bindings_Registry {
	rt.PhpObjectBase
}

fn create_wp_block_bindings_registry(_args ...rt.PhpVal) &Class_WP_Block_Bindings_Registry {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
