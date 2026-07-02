import rt

pub fn Class_WP_Block_Type.global_attributes() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'lock', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
		]) },
		rt.ArrayItem{ key: 'metadata', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
		]) },
	])
}

struct Class_WP_Block_Type {
	rt.PhpObjectBase
pub mut:
	api_version            rt.PhpVal = rt.new_int(1)
	name                   rt.PhpVal = rt.new_null()
	title                  rt.PhpVal = rt.new_string('')
	category               rt.PhpVal = rt.new_null()
	parent                 rt.PhpVal = rt.new_null()
	ancestor               rt.PhpVal = rt.new_null()
	allowed_blocks         rt.PhpVal = rt.new_null()
	icon                   rt.PhpVal = rt.new_null()
	description            rt.PhpVal = rt.new_string('')
	keywords               rt.PhpVal = rt.new_array()
	textdomain             rt.PhpVal = rt.new_null()
	styles                 rt.PhpVal = rt.new_array()
	variations             rt.PhpVal = rt.new_null()
	variation_callback     rt.PhpVal = rt.new_null()
	selectors              rt.PhpVal = rt.new_array()
	supports               rt.PhpVal = rt.new_null()
	example                rt.PhpVal = rt.new_null()
	render_callback        rt.PhpVal = rt.new_null()
	attributes             rt.PhpVal = rt.new_null()
	uses_context           rt.PhpVal = rt.new_array()
	provides_context       rt.PhpVal = rt.new_null()
	block_hooks            rt.PhpVal = rt.new_array()
	editor_script_handles  rt.PhpVal = rt.new_array()
	script_handles         rt.PhpVal = rt.new_array()
	view_script_handles    rt.PhpVal = rt.new_array()
	view_script_module_ids rt.PhpVal = rt.new_array()
	editor_style_handles   rt.PhpVal = rt.new_array()
	style_handles          rt.PhpVal = rt.new_array()
	view_style_handles     rt.PhpVal = rt.new_array()
	deprecated_properties  rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Block_Type) construct(var_block_type rt.PhpVal, var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	this.name = var_block_type.clone()
	this.set_props(var_args_mutated.clone())
}

fn (mut this Class_WP_Block_Type) magic_get(var_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('variations'), var_name)) {
		return this.get_variations()
	}
	if rt.is_true(rt.identical(rt.new_string('uses_context'), var_name)) {
		return this.get_uses_context()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_name.clone(), this.deprecated_properties, rt.new_bool(true)])))))
	{
		return rt.new_null()
	}
	mut var_new_name := rt.new_string(var_name.str() + '_handles')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('property_exists', [rt.new_object('WP_Block_Type', []string{}, &this), var_new_name.clone()])))))
		|| !(rt.get_property(rt.new_object('WP_Block_Type', []string{}, &this), '{"nodeType":"Expr_Variable","line":379,"name":"new_name"}').is_array()) {
		return rt.new_null()
	}
	if rt.get_property(rt.new_object('WP_Block_Type', []string{}, &this),
		'{"nodeType":"Expr_Variable","line":383,"name":"new_name"}').array_count() > 1 {
		return rt.get_property(rt.new_object('WP_Block_Type', []string{}, &this),
			'{"nodeType":"Expr_Variable","line":384,"name":"new_name"}')
	}
	return if !(rt.get_property(rt.new_object('WP_Block_Type', []string{}, &this),
		'{"nodeType":"Expr_Variable","line":386,"name":"new_name"}').array_get(rt.new_int(0))).is_null() {
		rt.get_property(rt.new_object('WP_Block_Type', []string{}, &this),
			'{"nodeType":"Expr_Variable","line":386,"name":"new_name"}').array_get(rt.new_int(0))
	} else {
		rt.new_null()
	}
}

fn (mut this Class_WP_Block_Type) magic_isset(var_name rt.PhpVal) bool {
	if rt.is_true(rt.call_function('in_array', [var_name.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'variations' },
			rt.ArrayItem{ key: none, val: 'uses_context' }]),
		rt.new_bool(true)]))
	{
		return true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_name.clone(), this.deprecated_properties, rt.new_bool(true)])))))
	{
		return false
	}
	mut var_new_name := rt.new_string(var_name.str() + '_handles')
	return (rt.new_bool(rt.get_property(rt.new_object('WP_Block_Type', []string{}, &this),
		'{"nodeType":"Expr_Variable","line":410,"name":"new_name"}').array_isset(rt.new_int(0)))).to_bool()
}

fn (mut this Class_WP_Block_Type) magic_set(var_name rt.PhpVal, var_value rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_name.clone(), this.deprecated_properties, rt.new_bool(true)])))))
	{
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":425,"name":"name"}',
			var_value.clone())
		return
	}
	mut var_new_name := rt.new_string(var_name.str() + '_handles')
	if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
		mut var_filtered := rt.call_function('array_filter', [
			var_value.clone(), rt.new_string('is_string')])
		if rt.is_true(rt.new_bool(var_filtered.clone().array_count() != var_value.clone().array_count())) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('The %s argument must be a string or a string array.'),
					]),
					rt.new_string('<code>$value</code>'),
				]),
				rt.new_string('6.1.0')])
		}
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":446,"name":"new_name"}', rt.call_function('array_values', [
			var_filtered.clone(),
		]))
		return
	}
	if !(var_value.clone().is_string()) {
		return
	}
	this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":454,"name":"new_name"}', rt.create_array([
		rt.ArrayItem{ key: none, val: var_value },
	]))
}

fn (mut this Class_WP_Block_Type) render(var_attributes rt.PhpVal, content string) string {
	mut var_attributes_mutated := var_attributes
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_dynamic())))) {
		return ''
	}
	var_attributes_mutated = this.prepare_attributes_for_render(var_attributes_mutated.clone())
	return (rt.call_function('call_user_func', [this.render_callback, var_attributes_mutated.clone(),
		rt.new_string(content)])).str()
}

fn (mut this Class_WP_Block_Type) is_dynamic() rt.PhpVal {
	return rt.call_function('is_callable', [this.render_callback])
}

fn (mut this Class_WP_Block_Type) prepare_attributes_for_render(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	if !(!(this.attributes).is_null()) {
		return var_attributes_mutated.clone()
	}
	mut iter_1 := var_attributes_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_attribute_name := item_1.key
		if !(this.attributes.array_isset(var_attribute_name)) {
			continue
		}
		mut var_schema := this.attributes.array_get(var_attribute_name)
		mut var_is_valid := rt.call_function('rest_validate_value_from_schema', [
			var_value.clone(),
			var_schema.clone(),
			var_attribute_name.clone(),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_is_valid.clone()])) {
			var_attributes_mutated.array_unset(var_attribute_name)
		}
	}
	mut var_missing_schema_attributes := rt.call_function('array_diff_key', [
		this.attributes,
		var_attributes_mutated.clone(),
	])
	mut iter_2 := var_missing_schema_attributes.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_schema := item_2.val
		mut var_attribute_name := item_2.key
		if var_schema.array_isset(rt.new_string('default')) {
			var_attributes_mutated.array_set(var_attribute_name,
				var_schema.array_get(rt.new_string('default')))
		}
	}
	return var_attributes_mutated.clone()
}

fn (mut this Class_WP_Block_Type) set_props(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: 'render_callback', val: rt.new_null() }])])
	var_args_mutated.array_set('name', this.name)
	if !(var_args_mutated.array_isset(rt.new_string('attributes')))
		|| !(var_args_mutated.array_get(rt.new_string('attributes')).is_array()) {
		var_args_mutated.array_set('attributes', rt.new_array())
	}
	mut iter_3 := Class_static.global_attributes().iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_attr_schema := item_3.val
		mut var_attr_key := item_3.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.array_get(rt.new_string('attributes')).array_isset(var_attr_key.clone())))))) {
			var_args_mutated.array_get_mut('attributes').array_set(var_attr_key,
				var_attr_schema.clone())
		}
	}
	var_args_mutated = rt.call_function('apply_filters', [
		rt.new_string('register_block_type_args'),
		var_args_mutated.clone(),
		this.name,
	])
	mut iter_4 := var_args_mutated.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_property_value := item_4.val
		mut var_property_name := item_4.key
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":576,"name":"property_name"}',
			var_property_value.clone())
	}
}

fn (mut this Class_WP_Block_Type) get_attributes() rt.PhpVal {
	return if this.attributes.is_array() { this.attributes } else { rt.new_array() }
}

fn (mut this Class_WP_Block_Type) get_variations() rt.PhpVal {
	if !(!(this.variations).is_null()) {
		this.variations = rt.new_array()
		if rt.is_true(rt.call_function('is_callable', [this.variation_callback])) {
			this.variations = rt.call_function('call_user_func', [this.variation_callback])
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('get_block_type_variations'),
		this.variations, rt.new_object('WP_Block_Type', []string{}, &this)])
}

fn (mut this Class_WP_Block_Type) get_uses_context() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('get_block_type_uses_context'),
		this.uses_context,
		rt.new_object('WP_Block_Type', []string{}, &this),
	])
}

fn create_wp_block_type(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WP_Block_Type {
	mut obj := &Class_WP_Block_Type{
		PhpObjectBase:          rt.PhpObjectBase{}
		api_version:            rt.new_int(1)
		name:                   rt.new_null()
		title:                  rt.new_string('')
		category:               rt.new_null()
		parent:                 rt.new_null()
		ancestor:               rt.new_null()
		allowed_blocks:         rt.new_null()
		icon:                   rt.new_null()
		description:            rt.new_string('')
		keywords:               rt.new_array()
		textdomain:             rt.new_null()
		styles:                 rt.new_array()
		variations:             rt.new_null()
		variation_callback:     rt.new_null()
		selectors:              rt.new_array()
		supports:               rt.new_null()
		example:                rt.new_null()
		render_callback:        rt.new_null()
		attributes:             rt.new_null()
		uses_context:           rt.new_array()
		provides_context:       rt.new_null()
		block_hooks:            rt.new_array()
		editor_script_handles:  rt.new_array()
		script_handles:         rt.new_array()
		view_script_handles:    rt.new_array()
		view_script_module_ids: rt.new_array()
		editor_style_handles:   rt.new_array()
		style_handles:          rt.new_array()
		view_style_handles:     rt.new_array()
		deprecated_properties:  rt.new_array()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_WP_Block_Type) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.magic_isset(dispatch_arg_0))
		}
		'__set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.magic_set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1))
		}
		'is_dynamic' {
			return this.is_dynamic()
		}
		'prepare_attributes_for_render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_attributes_for_render(dispatch_arg_0)
		}
		'set_props' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_props(dispatch_arg_0)
			return rt.new_null()
		}
		'get_attributes' {
			return this.get_attributes()
		}
		'get_variations' {
			return this.get_variations()
		}
		'get_uses_context' {
			return this.get_uses_context()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Block_Type) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'api_version' { return this.api_version }
		'name' { return this.name }
		'title' { return this.title }
		'category' { return this.category }
		'parent' { return this.parent }
		'ancestor' { return this.ancestor }
		'allowed_blocks' { return this.allowed_blocks }
		'icon' { return this.icon }
		'description' { return this.description }
		'keywords' { return this.keywords }
		'textdomain' { return this.textdomain }
		'styles' { return this.styles }
		'variations' { return this.variations }
		'variation_callback' { return this.variation_callback }
		'selectors' { return this.selectors }
		'supports' { return this.supports }
		'example' { return this.example }
		'render_callback' { return this.render_callback }
		'attributes' { return this.attributes }
		'uses_context' { return this.uses_context }
		'provides_context' { return this.provides_context }
		'block_hooks' { return this.block_hooks }
		'editor_script_handles' { return this.editor_script_handles }
		'script_handles' { return this.script_handles }
		'view_script_handles' { return this.view_script_handles }
		'view_script_module_ids' { return this.view_script_module_ids }
		'editor_style_handles' { return this.editor_style_handles }
		'style_handles' { return this.style_handles }
		'view_style_handles' { return this.view_style_handles }
		'deprecated_properties' { return this.deprecated_properties }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Block_Type) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'api_version' {
			this.api_version = val
			return true
		}
		'name' {
			this.name = val
			return true
		}
		'title' {
			this.title = val
			return true
		}
		'category' {
			this.category = val
			return true
		}
		'parent' {
			this.parent = val
			return true
		}
		'ancestor' {
			this.ancestor = val
			return true
		}
		'allowed_blocks' {
			this.allowed_blocks = val
			return true
		}
		'icon' {
			this.icon = val
			return true
		}
		'description' {
			this.description = val
			return true
		}
		'keywords' {
			this.keywords = val
			return true
		}
		'textdomain' {
			this.textdomain = val
			return true
		}
		'styles' {
			this.styles = val
			return true
		}
		'variations' {
			this.variations = val
			return true
		}
		'variation_callback' {
			this.variation_callback = val
			return true
		}
		'selectors' {
			this.selectors = val
			return true
		}
		'supports' {
			this.supports = val
			return true
		}
		'example' {
			this.example = val
			return true
		}
		'render_callback' {
			this.render_callback = val
			return true
		}
		'attributes' {
			this.attributes = val
			return true
		}
		'uses_context' {
			this.uses_context = val
			return true
		}
		'provides_context' {
			this.provides_context = val
			return true
		}
		'block_hooks' {
			this.block_hooks = val
			return true
		}
		'editor_script_handles' {
			this.editor_script_handles = val
			return true
		}
		'script_handles' {
			this.script_handles = val
			return true
		}
		'view_script_handles' {
			this.view_script_handles = val
			return true
		}
		'view_script_module_ids' {
			this.view_script_module_ids = val
			return true
		}
		'editor_style_handles' {
			this.editor_style_handles = val
			return true
		}
		'style_handles' {
			this.style_handles = val
			return true
		}
		'view_style_handles' {
			this.view_style_handles = val
			return true
		}
		'deprecated_properties' {
			this.deprecated_properties = val
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
