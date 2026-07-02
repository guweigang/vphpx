import rt
import crypto.md5

fn _wp_get_presets_class_name(var_block rt.PhpVal) string {
	return 'wp-settings-' +
		md5.hexhash(rt.call_function('serialize', [rt.create_array_from_native_map(var_block)]).to_string())
}

fn _wp_add_block_level_presets_class(var_block_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_block_type := rt.new_null()
	mut var_block_settings := rt.new_null()
	mut var_tags := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_block_content)))) {
		return var_block_content.clone()
	}
	mut iife_temp_0 := Class_WP_Block_Type_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	var_block_type = rt.call_method(iife_result_0, 'get_registered', [
		var_block.array_get(rt.new_string('blockName')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('block_has_support', [
		var_block_type.clone(),
		rt.new_string('__experimentalSettings'),
		rt.new_bool(false),
	])))))
	{
		return var_block_content.clone()
	}
	var_block_settings = if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('settings'))).is_null() {
		var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('settings'))
	} else {
		rt.new_null()
	}
	if !rt.is_true(var_block_settings) {
		return var_block_content.clone()
	}
	var_tags = create_wp_html_tag_processor(var_block_content.clone())
	if rt.is_true(var_tags.next_tag()) {
		var_tags.add_class(rt.new_string(_wp_get_presets_class_name(rt.create_array_from_native_map(var_block))))
	}
	return var_tags.get_updated_html()
}

fn _wp_add_block_level_preset_styles(var_pre_render rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_block_type := rt.new_null()
	mut var_block_settings := rt.new_null()
	mut var_class_name := rt.new_null()
	mut var_variables_root_selector := rt.new_null()
	mut var_registry := rt.new_null()
	mut var_blocks := rt.new_null()
	mut var_has_custom_selector := false
	mut var_theme_json_shape := rt.new_null()
	mut var_theme_json_object := rt.new_null()
	mut var_styles := ''
	mut iife_temp_1 := Class_WP_Block_Type_Registry{}
	mut iife_result_1 := iife_temp_1.get_instance()
	var_block_type = rt.call_method(iife_result_1, 'get_registered', [
		var_block.array_get(rt.new_string('blockName')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('block_has_support', [
		var_block_type.clone(),
		rt.new_string('__experimentalSettings'),
		rt.new_bool(false),
	])))))
	{
		return rt.new_null()
	}
	var_block_settings = if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('settings'))).is_null() {
		var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('settings'))
	} else {
		rt.new_null()
	}
	if !rt.is_true(var_block_settings) {
		return rt.new_null()
	}
	var_class_name = rt.new_string('.' +
		_wp_get_presets_class_name(rt.create_array_from_native_map(var_block)))
	var_variables_root_selector = rt.new_string('*,[class*="wp-block"]')
	mut iife_temp_2 := Class_WP_Block_Type_Registry{}
	mut iife_result_2 := iife_temp_2.get_instance()
	var_registry = iife_result_2
	var_blocks = rt.call_method(var_registry, 'get_all_registered', []rt.PhpVal{})
	mut iter_1 := var_blocks.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_block_type_shadow := item_1.val
		var_has_custom_selector =
			rt.get_property(var_block_type_shadow, 'supports').array_isset(rt.new_string('__experimentalSelector'))
			&& rt.get_property(var_block_type_shadow, 'supports').array_get(rt.new_string('__experimentalSelector')).is_string()
			|| rt.get_property(var_block_type_shadow, 'selectors').array_isset(rt.new_string('root'))
			&& rt.get_property(var_block_type_shadow, 'selectors').array_get(rt.new_string('root')).is_string()
		if var_has_custom_selector {
			var_variables_root_selector = rt.concat(var_variables_root_selector, rt.new_string(
				',' +(rt.call_function('wp_get_block_css_selector', [var_block_type_shadow.clone()])).str()))
		}
	}
	mut iife_temp_3 := Class_WP_Theme_JSON{}
	mut iife_result_3 := iife_temp_3.scope_selector(var_class_name.clone(),
		var_variables_root_selector.clone())
	var_variables_root_selector = iife_result_3
	mut iife_temp_4 := Class_WP_Theme_JSON{}
	mut iife_result_4 := iife_temp_4.remove_insecure_properties(rt.create_array([
		rt.ArrayItem{ key: 'version', val: Class_WP_Theme_JSON.latest_schema() },
		rt.ArrayItem{ key: 'settings', val: var_block_settings },
	]))
	var_theme_json_shape = iife_result_4
	var_theme_json_object = create_wp_theme_json(var_theme_json_shape.clone())
	var_styles = ''
	var_styles = var_styles + (var_theme_json_object.get_stylesheet(rt.create_array([rt.ArrayItem{
		key: none
		val: 'variables'
	}]), rt.new_null(), rt.create_array([rt.ArrayItem{
		key: 'root_selector'
		val: var_variables_root_selector
	}, rt.ArrayItem{ key: 'scope', val: var_class_name }]))).str()
	var_styles = var_styles + (var_theme_json_object.get_stylesheet(rt.create_array([rt.ArrayItem{
		key: none
		val: 'presets'
	}]), rt.new_null(), rt.create_array([rt.ArrayItem{
		key: 'root_selector'
		val: var_class_name.str() + ',' + var_class_name.str() + ' *'
	}, rt.ArrayItem{ key: 'scope', val: var_class_name }]))).str()
	if !(var_styles == '') {
		rt.call_function('wp_enqueue_block_support_styles', [
			rt.new_string(var_styles.str()).clone()])
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

fn create_wp_block_type_registry(_args ...rt.PhpVal) &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_tag_processor(_args ...rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme_json(_args ...rt.PhpVal) &Class_WP_Theme_JSON {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_filter', [rt.new_string('render_block'),
		rt.new_string('_wp_add_block_level_presets_class'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('pre_render_block'),
		rt.new_string('_wp_add_block_level_preset_styles'), rt.new_int(10),
		rt.new_int(2)])
}
