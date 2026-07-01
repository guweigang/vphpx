import rt

pub fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor.typography_styles() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'color' },
		rt.ArrayItem{ key: none, val: 'font-size' }, rt.ArrayItem{ key: none, val: 'text-decoration' }])
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor {
	rt.PhpObjectBase
pub mut:
	settings_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor) construct(mut var_settings_controller Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller) {
	this.settings_controller = var_settings_controller.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor) preprocess(mut var_parsed_blocks Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_layout Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_styles Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array) rt.PhpVal {
	mut var_parsed_blocks_mutated := var_parsed_blocks
	{
		mut iter_1 := var_parsed_blocks_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			mut var_key := item_1.key
			var_block =
				this.preprocess_parent(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_block))
			var_block =
				this.set_defaults_from_theme(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_block))
			var_block.array_set('innerBlocks', this.copy_typography_from_parent(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_block.array_get('innerBlocks')), mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_block)))
			var_parsed_blocks_mutated.array_set(var_key, var_block.dup())
		}
	}
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array',
		[]string{}, var_parsed_blocks_mutated)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor) copy_typography_from_parent(mut var_children Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array, mut var_parent_block Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array) rt.PhpVal {
	mut var_children_mutated := var_children
	{
		mut iter_1 := var_children_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_child := item_1.val
			mut var_key := item_1.key
			var_child =
				this.preprocess_parent(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_child))
			var_child.array_set('email_attrs', rt.call_function('array_merge', [
				this.filterstyles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_parent_block.array_get('email_attrs'))),
				var_child.array_get('email_attrs'),
			]))
			var_child.array_set('innerBlocks', this.copy_typography_from_parent(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if !(var_child.array_get('innerBlocks')).is_null() {
				var_child.array_get('innerBlocks')
			} else {
				rt.new_array()
			}), mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](var_child)))
			var_children_mutated.array_set(var_key, var_child.dup())
		}
	}
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array',
		[]string{}, var_children_mutated)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor) preprocess_parent(mut var_block Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array) rt.PhpVal {
	mut var_block_mutated := var_block
	mut var_email_attrs := rt.new_array()
	if var_block_mutated.array_get('attrs').array_get('style').array_get('color').array_isset(rt.new_string('text')) {
		var_email_attrs.array_set('color',
			var_block_mutated.array_get('attrs').array_get('style').array_get('color').array_get('text'))
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(var_block_mutated.array_get('attrs').array_isset(rt.new_string('textColor'))
		&& rt.is_true(rt.new_bool(var_block_mutated.array_get('attrs').array_get('textColor').is_string()))))
		&& !(var_email_attrs.array_isset(rt.new_string('color')))))
	{
		var_email_attrs.array_set('color', rt.call_method(this.settings_controller,
			'translate_slug_to_color',
			[var_block_mutated.array_get('attrs').array_get('textColor')]))
	}
	if rt.is_true(rt.new_bool(
		var_block_mutated.array_get('attrs').array_isset(rt.new_string('fontSize'))
		&& rt.is_true(rt.new_bool(var_block_mutated.array_get('attrs').array_get('fontSize').is_string()))))
	{
		var_block_mutated.array_get_mut('attrs').array_get_mut('style').array_get_mut('typography').array_set('fontSize', rt.call_method(this.settings_controller,
			'translate_slug_to_font_size',
			[var_block_mutated.array_get('attrs').array_get('fontSize')]))
	}
	if var_block_mutated.array_get('attrs').array_get('style').array_get('typography').array_isset(rt.new_string('fontSize')) {
		var_email_attrs.array_set('font-size',
			var_block_mutated.array_get('attrs').array_get('style').array_get('typography').array_get('fontSize'))
	}
	if var_block_mutated.array_get('attrs').array_get('style').array_get('typography').array_isset(rt.new_string('textDecoration')) {
		var_email_attrs.array_set('text-decoration',
			var_block_mutated.array_get('attrs').array_get('style').array_get('typography').array_get('textDecoration'))
	}
	var_block_mutated.array_set('email_attrs', rt.call_function('array_merge', [
		var_email_attrs.dup(), if !(var_block_mutated.array_get('email_attrs')).is_null() {
			var_block_mutated.array_get('email_attrs')
		} else {
			rt.new_array()
		}]))
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array',
		[]string{}, var_block_mutated)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor) filterstyles(mut var_styles Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array) rt.PhpVal {
	return rt.call_function('array_intersect_key', [var_styles,
		rt.call_function('array_flip', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor.typography_styles(),
		])])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor) set_defaults_from_theme(mut var_block Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array) rt.PhpVal {
	mut var_block_mutated := var_block
	mut var_theme_data := rt.call_method(rt.call_method(this.settings_controller, 'get_theme',
		[]rt.PhpVal{}), 'get_data', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(if !(var_block_mutated.array_get('email_attrs').array_get('color')).is_null() {
		var_block_mutated.array_get('email_attrs').array_get('color')
	} else {
		rt.new_string('')
	}))))
	{
		var_block_mutated.array_get_mut('email_attrs').array_set('color', if !(var_theme_data.array_get('styles').array_get('color').array_get('text')).is_null() {
			var_theme_data.array_get('styles').array_get('color').array_get('text')
		} else {
			rt.new_null()
		})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(if !(var_block_mutated.array_get('email_attrs').array_get('font-size')).is_null() {
		var_block_mutated.array_get('email_attrs').array_get('font-size')
	} else {
		rt.new_string('')
	}))))
	{
		var_block_mutated.array_get_mut('email_attrs').array_set('font-size',
			var_theme_data.array_get('styles').array_get('typography').array_get('fontSize'))
	}
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array',
		[]string{}, var_block_mutated)
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preprocessors_typography_preprocessor(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor{
		PhpObjectBase:       rt.PhpObjectBase{}
		settings_controller: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'preprocess' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.preprocess(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'copy_typography_from_parent' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.copy_typography_from_parent(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'preprocess_parent' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.preprocess_parent(mut dispatch_arg_0)
		}
		'filterStyles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.filterstyles(mut dispatch_arg_0)
		}
		'set_defaults_from_theme' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.set_defaults_from_theme(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'settings_controller' { return this.settings_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'settings_controller' {
			this.settings_controller = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_renderer_contentrenderer_preprocessors_class_typography_preprocessor_php() {
	// unsupported statement: Stmt_Declare
}
