import rt
import crypto.md5

fn _wp_get_presets_class_name(var_block rt.PhpVal) string {
	return 'wp-settings-' +
		md5.hexhash(rt.call_function('serialize', [var_block.dup()]).to_string())
}

fn _wp_add_block_level_presets_class(var_block_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_block_content)))) {
		return var_block_content.dup()
	}
	mut var_block_type := rt.call_method(fn () rt.PhpVal {
		mut temp := Class_WP_Block_Type_Registry{}
		return temp.get_instance()
	}(), 'get_registered', [var_block.array_get('blockName')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('block_has_support', [
		var_block_type.dup(),
		rt.new_string('__experimentalSettings'),
		rt.new_bool(false),
	])))))
	{
		return var_block_content.dup()
	}
	mut var_block_settings := if !(var_block.array_get('attrs').array_get('settings')).is_null() {
		var_block.array_get('attrs').array_get('settings')
	} else {
		rt.new_null()
	}
	if !rt.is_true(var_block_settings) {
		return var_block_content.dup()
	}
	mut var_tags := create_wp_html_tag_processor(var_block_content.dup())
	if rt.is_true(var_tags.next_tag()) {
		var_tags.add_class(rt.new_string(_wp_get_presets_class_name(var_block.dup())))
	}
	return var_tags.get_updated_html()
}

fn _wp_add_block_level_preset_styles(var_pre_render rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_block_type := rt.call_method(fn () rt.PhpVal {
		mut temp := Class_WP_Block_Type_Registry{}
		return temp.get_instance()
	}(), 'get_registered', [var_block.array_get('blockName')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('block_has_support', [
		var_block_type.dup(),
		rt.new_string('__experimentalSettings'),
		rt.new_bool(false),
	])))))
	{
		return rt.new_null()
	}
	mut var_block_settings := if !(var_block.array_get('attrs').array_get('settings')).is_null() {
		var_block.array_get('attrs').array_get('settings')
	} else {
		rt.new_null()
	}
	if !rt.is_true(var_block_settings) {
		return rt.new_null()
	}
	mut var_class_name := rt.new_string('.' + _wp_get_presets_class_name(var_block.dup()))
	mut var_variables_root_selector := rt.new_string(rt.new_string('*,[class*="wp-block"]'))
	mut var_registry := fn () rt.PhpVal {
		mut temp := Class_WP_Block_Type_Registry{}
		return temp.get_instance()
	}()
	mut var_blocks := rt.call_method(var_registry, 'get_all_registered', []rt.PhpVal{})
	{
		mut iter_1 := var_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block_type_shadow := item_1.val
			mut var_has_custom_selector :=
				rt.is_true(rt.new_bool(rt.get_property(var_block_type_shadow, 'supports').array_isset(rt.new_string('__experimentalSelector'))
				&& rt.is_true(rt.new_bool(rt.get_property(var_block_type_shadow, 'supports').array_get('__experimentalSelector').is_string()))))
				|| rt.is_true(rt.new_bool(rt.get_property(var_block_type_shadow, 'selectors').array_isset(rt.new_string('root'))
				&& rt.is_true(rt.new_bool(rt.get_property(var_block_type_shadow, 'selectors').array_get('root').is_string()))))
			if var_has_custom_selector {
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	var_variables_root_selector = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WP_Theme_JSON{}
		return temp.scope_selector(arg_0, arg_1)
	}(var_class_name.dup(), var_variables_root_selector.dup())
	mut var_theme_json_shape := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WP_Theme_JSON{}
		return temp.remove_insecure_properties(arg_0)
	}(rt.create_array([
		rt.ArrayItem{ key: 'version', val: Class_WP_Theme_JSON.latest_schema() },
		rt.ArrayItem{ key: 'settings', val: var_block_settings },
	]))
	mut var_theme_json_object := create_wp_theme_json(var_theme_json_shape.dup())
	mut var_styles := ''
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	if !(var_styles == '') {
		rt.call_function('wp_enqueue_block_support_styles', [
			rt.new_string(var_styles).dup()])
	}
	return rt.new_null()
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON {
	rt.PhpObjectBase
}

fn create_wp_block_type_registry() &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_tag_processor() &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme_json() &Class_WP_Theme_JSON {
	mut obj := &Class_WP_Theme_JSON{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Theme_JSON) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_block_supports_settings_php() {
	rt.call_function('add_filter', [rt.new_string('render_block'),
		rt.new_string('_wp_add_block_level_presets_class'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('pre_render_block'),
		rt.new_string('_wp_add_block_level_preset_styles'), rt.new_int(10),
		rt.new_int(2)])
}
