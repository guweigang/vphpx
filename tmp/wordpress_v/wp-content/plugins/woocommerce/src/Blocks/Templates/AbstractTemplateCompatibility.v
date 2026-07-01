import rt

struct Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility {
	rt.PhpObjectBase
pub mut:
	hook_data rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility) init() {
	this.set_hook_data()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_parsed_block := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_source_block := if args.len > 1 { args[1].dup() } else { rt.new_null() }
		mut var_parent_block := if args.len > 2 { args[2].dup() } else { rt.new_null() }
		mut var_is_disabled_compatility_layer := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_disable_compatibility_layer'),
			rt.new_bool(false),
		])
		if rt.is_true(var_is_disabled_compatility_layer) {
			return var_parsed_block.dup()
		}
		this.update_render_block_data(var_parsed_block.dup(), var_source_block.dup(),
			var_parent_block.dup())
		return rt.new_null()
	}
	rt.call_function('add_filter', [rt.new_string('render_block_data'),
		rt.new_closure(closure_1_fn), rt.new_int(10), rt.new_int(3)])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_block_content := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_block := if args.len > 1 { args[1].dup() } else { rt.new_null() }
		mut var_is_disabled_compatibility_layer := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_disable_compatibility_layer'),
			rt.new_bool(false),
		])
		if rt.is_true(var_is_disabled_compatibility_layer) {
			return var_block_content.dup()
		}
		this.inject_hooks(var_block_content.dup(), var_block.dup())
		return rt.new_null()
	}
	rt.call_function('add_filter', [rt.new_string('render_block'),
		rt.new_closure(closure_2_fn), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility) update_render_block_data(var_parsed_block rt.PhpVal, var_source_block rt.PhpVal, var_parent_block rt.PhpVal) {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility) inject_hooks(var_block_content rt.PhpVal, var_block rt.PhpVal) {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility) set_hook_data() {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility) remove_default_hooks() {
	{
		mut iter_1 := this.hook_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			mut var_hook := item_1.key
			if !(var_data.array_isset(rt.new_string('hooked'))) {
				continue
			}
			{
				mut iter_2 := var_data.array_get('hooked').iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_priority := item_2.val
					mut var_callback := item_2.key
					rt.call_function('remove_action', [var_hook.dup(),
						var_callback.dup(), var_priority.dup()])
				}
			}
		}
	}
	mut var_class_name := rt.call_function('basename', [
		rt.call_function('str_replace', [rt.new_string('\\'),
			rt.new_string('/'),
			rt.call_function('get_class', [
				rt.new_object('Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility',
					[]string{}, &this),
			])]),
	])
	mut var_additional_hook_data := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_blocks_hook_compatibility_additional_data'),
		rt.new_array(),
		var_class_name.dup(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(var_additional_hook_data)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_additional_hook_data.dup().is_array())))))))
	{
		return rt.new_null()
	}
	{
		mut iter_1 := var_additional_hook_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			if !(var_data.array_isset(rt.new_string('hook'))
				&& var_data.array_isset(rt.new_string('function'))
				&& var_data.array_isset(rt.new_string('priority'))) {
				continue
			}
			rt.call_function('remove_action', [var_data.array_get('hook'),
				var_data.array_get('function'), var_data.array_get('priority')])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility) get_hooks_buffer(var_hooks rt.PhpVal, var_position rt.PhpVal) rt.PhpVal {
	rt.call_function('ob_start', []rt.PhpVal{})
	{
		mut iter_1 := var_hooks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			mut var_hook := item_1.key
			if rt.is_true(rt.identical(var_data.array_get('position'), var_position)) {
				rt.call_function('do_action', [var_hook.dup()])
			}
		}
	}
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn create_automattic_woocommerce_blocks_templates_abstracttemplatecompatibility() &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility{
		PhpObjectBase: rt.PhpObjectBase{}
		hook_data:     rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'update_render_block_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.update_render_block_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'inject_hooks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.inject_hooks(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_hook_data' {
			this.set_hook_data()
			return rt.new_null()
		}
		'remove_default_hooks' {
			this.remove_default_hooks()
			return rt.new_null()
		}
		'get_hooks_buffer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_hooks_buffer(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'hook_data' { return this.hook_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'hook_data' {
			this.hook_data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_templates_abstracttemplatecompatibility_php() {
}
