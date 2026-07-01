import rt

struct Class_WP_Block_Supports {
	rt.PhpObjectBase
}

fn create_wp_block_supports() &Class_WP_Block_Supports {
	mut obj := &Class_WP_Block_Supports{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Supports) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Supports) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Supports) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_block_supports_duotone_php() {
	rt.call_method(fn () rt.PhpVal {
		mut temp := Class_WP_Block_Supports{}
		return temp.get_instance()
	}(), 'register', [rt.new_string('duotone'),
		rt.create_array([
			rt.ArrayItem{ key: 'register_attribute', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WP_Duotone' },
				rt.ArrayItem{ key: none, val: 'register_duotone_support' },
			]) },
		])])
	rt.call_function('add_filter', [rt.new_string('render_block'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Duotone' },
			rt.ArrayItem{ key: none, val: 'render_duotone_support' }]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('render_block_core/image'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Duotone' },
			rt.ArrayItem{ key: none, val: 'restore_image_outer_container' }]),
		rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Duotone' },
			rt.ArrayItem{ key: none, val: 'output_block_styles' }]),
		rt.new_int(9)])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Duotone' },
			rt.ArrayItem{ key: none, val: 'output_global_styles' }]),
		rt.new_int(11)])
	rt.call_function('add_action', [rt.new_string('wp_footer'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Duotone' },
			rt.ArrayItem{ key: none, val: 'output_footer_assets' }]),
		rt.new_int(10)])
	rt.call_function('add_filter', [rt.new_string('block_editor_settings_all'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Duotone' },
			rt.ArrayItem{ key: none, val: 'add_editor_settings' }]),
		rt.new_int(10)])
	rt.call_function('add_filter', [rt.new_string('block_type_metadata_settings'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Duotone' },
			rt.ArrayItem{ key: none, val: 'migrate_experimental_duotone_support_flag' }]),
		rt.new_int(10), rt.new_int(2)])
}
