import rt

fn render_block_core_block(var_attributes rt.PhpVal, var_content_arg rt.PhpVal, var_block_instance_arg rt.PhpVal) string {
	mut var_content := var_content_arg
	mut var_block_instance := var_block_instance_arg
	mut var_seen_refs := rt.new_null()
	mut var_wp_embed := rt.new_null()
	mut var_reusable_block := rt.new_null()
	mut var_is_debug := false
	mut var_content_data := rt.new_null()
	mut var_is_assoc_array := false
	if !rt.is_true(var_attributes.array_get(rt.new_string('ref'))) {
		return ''
	}
	var_reusable_block = rt.call_function('get_post', [var_attributes.array_get(rt.new_string('ref'))])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_reusable_block)))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wp_block'), rt.get_property(var_reusable_block, 'post_type'))))) {
		return ''
	}
	if var_seen_refs.array_isset(var_attributes.array_get(rt.new_string('ref'))) {
		var_is_debug = rt.is_true(rt.get_constant('WP_DEBUG')) && rt.is_true(rt.get_constant('WP_DEBUG_DISPLAY'))
		return (if var_is_debug { rt.call_function('__', [rt.new_string('[block rendering halted]')]) } else { rt.new_string('') }).str()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_reusable_block, 'post_status'))))) || !(!rt.is_true(rt.get_property(var_reusable_block, 'post_password'))) {
		return ''
	}
	var_seen_refs.array_set(var_attributes.array_get(rt.new_string('ref')), true)
	var_content = rt.call_method(var_wp_embed, 'run_shortcode', [rt.get_property(var_reusable_block, 'post_content')])
	var_content = rt.call_method(var_wp_embed, 'autoembed', [var_content.clone()])
	if var_attributes.array_isset(rt.new_string('content')) {
		mut iter_1 := var_attributes.array_get(rt.new_string('content')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_content_data_shadow := item_1.val
			if var_content_data_shadow.array_isset(rt.new_string('values')) {
				var_is_assoc_array = var_content_data_shadow.array_get(rt.new_string('values')).is_array() && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_numeric_array', [var_content_data_shadow.array_get(rt.new_string('values'))])))))
				if var_is_assoc_array {
				var_content_data_shadow = var_content_data_shadow.array_get(rt.new_string('values'))
				}
			}
		}
	}
	if var_attributes.array_isset(rt.new_string('overrides')) && !(var_attributes.array_isset(rt.new_string('content'))) {
		var_attributes['content'] = var_attributes.array_get(rt.new_string('overrides'))
	}
	var_content = rt.call_function('apply_block_hooks_to_content_from_post_object', [var_content.clone(), var_reusable_block.clone()])
	rt.get_property(var_block_instance, 'parsed_block').array_set('innerBlocks', rt.call_function('parse_blocks', [var_content.clone()]))
	rt.get_property(var_block_instance, 'parsed_block').array_set('innerContent', rt.call_function('array_fill', [rt.new_int(0), rt.new_int(rt.get_property(var_block_instance, 'parsed_block').array_get(rt.new_string('innerBlocks')).array_count()), rt.new_null()]))
	if rt.is_true(rt.call_function('method_exists', [var_block_instance.clone(), rt.new_string('refresh_context_dependents')])) {
		rt.call_method(var_block_instance, 'refresh_context_dependents', []rt.PhpVal{})
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_Block_Cloner')]))))) {
struct Class_WP_Block_Cloner {
	rt.PhpObjectBase
}

fn Class_WP_Block_Cloner.clone_instance(var_instance rt.PhpVal) rt.PhpVal {
	return rt.new_object('WP_Block', []string{}, create_wp_block(rt.get_property(var_instance, 'parsed_block'), rt.get_property(var_instance, 'available_context'), rt.get_property(var_instance, 'registry')))
}

fn register_block_core_block() {
	rt.call_function('register_block_type_from_metadata', [rt.new_string(@DIR + '/block'), rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_block' }])])
}

struct Class_WP_Block {
	rt.PhpObjectBase
}

fn create_wp_block_cloner(_args ...rt.PhpVal) &Class_WP_Block_Cloner {
	mut obj := &Class_WP_Block_Cloner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block(_args ...rt.PhpVal) &Class_WP_Block {
	mut obj := &Class_WP_Block{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Cloner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'clone_instance' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Block_Cloner.clone_instance(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_Block_Cloner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Cloner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

		}
	var_block_instance = Class_WP_Block_Cloner.clone_instance(var_block_instance.clone())
	}
	var_content = rt.call_method(var_block_instance, 'render', [rt.create_array([rt.ArrayItem{ key: 'dynamic', val: false }])])
	var_seen_refs.array_unset(var_attributes.array_get(rt.new_string('ref')))
	return (var_content).str()
}

	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_block')])
}
