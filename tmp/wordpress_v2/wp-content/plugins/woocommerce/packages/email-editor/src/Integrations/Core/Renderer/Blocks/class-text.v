import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut block_content_mutated := block_content
	if rt.call_function('wp_strip_all_tags', [rt.new_string(block_content_mutated).clone()]).to_string().trim_space() == '' {
		return ''
	}
	block_content_mutated = this.adjuststyleattribute(block_content_mutated)
	mut var_block_attributes := rt.call_function('wp_parse_args', [if !(var_parsed_block.array_get(rt.new_string('attrs'))).is_null() {
		var_parsed_block.array_get(rt.new_string('attrs'))
	} else {
		rt.new_array()
	},
		rt.create_array([rt.ArrayItem{ key: 'textAlign', val: 'left' },
			rt.ArrayItem{ key: 'style', val: rt.new_array() }])])
	mut var_html :=
		create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(rt.new_string(block_content_mutated).clone())
	mut var_classes := rt.new_string('email-text-block')
	mut var_alignment_from_class := rt.new_null()
	if rt.is_true(var_html.next_tag()) {
		mut var_block_classes := if !(var_html.get_attribute(rt.new_string('class'))).is_null() {
			var_html.get_attribute(rt.new_string('class'))
		} else {
			rt.new_string('')
		}
		var_classes = rt.concat(var_classes, rt.new_string(' ' + var_block_classes.str()))
		mut var_class_attr := rt.new_string(var_block_classes.str())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
			var_class_attr.clone(),
			rt.new_string('has-text-align-center'),
		])))))
		{
			var_alignment_from_class = rt.new_string('center')
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
			var_class_attr.clone(),
			rt.new_string('has-text-align-right'),
		])))))
		{
			var_alignment_from_class = rt.new_string('right')
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
			var_class_attr.clone(),
			rt.new_string('has-text-align-left'),
		])))))
		{
			var_alignment_from_class = rt.new_string('left')
		}
		var_block_classes = rt.call_function('str_replace', [
			rt.new_string('has-background'),
			rt.new_string(''),
			var_block_classes.clone(),
		])
		var_block_classes = rt.call_function('preg_replace', [
			rt.new_string('/[a-z-]+-border-[a-z-]+/'),
			rt.new_string(''),
			var_block_classes.clone(),
		])
		var_html.set_attribute(rt.new_string('class'),
			rt.new_string((var_block_classes.clone().to_string().trim_space()).str()))
		block_content_mutated = (var_html.get_updated_html()).str()
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_0 := iife_temp_0.get_block_styles(var_block_attributes.clone(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context',
		[]string{}, var_rendering_context), rt.create_array([
		rt.ArrayItem{ key: none, val: 'spacing' },
		rt.ArrayItem{ key: none, val: 'border' },
		rt.ArrayItem{ key: none, val: 'background-color' },
		rt.ArrayItem{ key: none, val: 'color' },
		rt.ArrayItem{ key: none, val: 'typography' },
	]))
	mut var_block_styles := iife_result_0
	mut var_additional_styles := rt.create_array([
		rt.ArrayItem{ key: 'min-width', val: '100%' },
	])
	if !rt.is_true(var_block_styles.array_get(rt.new_string('declarations')).array_get(rt.new_string('color'))) {
		mut var_email_styles := var_rendering_context.get_theme_styles()
		var_additional_styles.array_set('color', if !(var_parsed_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('color'))).is_null() {
			var_parsed_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('color'))
		} else {
			if !(var_email_styles.array_get(rt.new_string('color')).array_get(rt.new_string('text'))).is_null() {
				var_email_styles.array_get(rt.new_string('color')).array_get(rt.new_string('text'))
			} else {
				rt.new_string('#000000')
			}
		})
	}
	var_additional_styles.array_set('text-align', 'left')
	if !(!rt.is_true(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('textAlign')))) {
		var_additional_styles.array_set('text-align',
			var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('textAlign')))
	} else if rt.is_true(rt.call_function('in_array', [if !(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('align'))).is_null() {
		var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('align'))
	} else {
		rt.new_null()
	},
		rt.create_array([rt.ArrayItem{ key: none, val: 'left' },
			rt.ArrayItem{ key: none, val: 'center' }, rt.ArrayItem{ key: none, val: 'right' }]),
		rt.new_bool(true)]))
	{
		var_additional_styles.array_set('text-align',
			var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('align')))
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(),
		var_alignment_from_class))))
	{
		var_additional_styles.array_set('text-align', var_alignment_from_class.clone())
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_1 := iife_temp_1.extend_block_styles(var_block_styles.clone(),
		var_additional_styles.clone())
	var_block_styles = iife_result_1
	mut var_table_attrs := rt.create_array([
		rt.ArrayItem{ key: 'style', val: 'border-collapse: separate;' },
		rt.ArrayItem{ key: 'width', val: '100%' },
	])
	mut var_cell_attrs := rt.create_array([
		rt.ArrayItem{ key: 'class', val: var_classes },
		rt.ArrayItem{ key: 'style', val: var_block_styles.array_get(rt.new_string('css')) },
		rt.ArrayItem{
			key: 'align'
			val: var_additional_styles.array_get(rt.new_string('text-align'))
		},
	])
	mut iife_temp_2 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_2 := iife_temp_2.render_table_wrapper(rt.new_string(block_content_mutated),
		var_table_attrs.clone(), var_cell_attrs.clone())
	return iife_result_2.str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text) adjuststyleattribute(block_content string) string {
	mut block_content_mutated := block_content
	mut var_html :=
		create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(rt.new_string(block_content_mutated).clone())
	if rt.is_true(var_html.next_tag()) {
		mut var_element_style_value := var_html.get_attribute(rt.new_string('style'))
		mut var_element_style := rt.new_string((if !var_element_style_value.is_null() {
			var_element_style_value.clone().to_string()
		} else {
			''
		}).str())
		var_element_style = rt.new_string((rt.call_function('preg_replace', [
			rt.new_string('/padding[^:]*:.?[0-9a-z-()]+;?/'),
			rt.new_string(''),
			var_element_style.clone(),
		])).str())
		var_element_style = rt.new_string((rt.call_function('preg_replace', [
			rt.new_string('/margin[^:]*:.?[0-9a-z-()]+;?/'),
			rt.new_string(''),
			var_element_style.clone(),
		])).str())
		var_element_style = rt.new_string((rt.call_function('preg_replace', [
			rt.new_string('/border[^:]*:.?[0-9a-z-()#]+;?/'),
			rt.new_string(''),
			var_element_style.clone(),
		])).str())
		var_element_style = rt.new_string((rt.call_function('preg_replace', [
			rt.new_string('/font-size:[^;]+;?/'),
			rt.new_string('font-size: inherit;'),
			var_element_style.clone(),
		])).str())
		var_html.set_attribute(rt.new_string('style'), rt.call_function('esc_attr', [
			var_element_style.clone(),
		]))
		block_content_mutated = (var_html.get_updated_html()).str()
	}
	return block_content_mutated
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_text(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_abstract_block_renderer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_html_tag_processor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_styles_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_table_wrapper_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.render_content(dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2))
		}
		'adjustStyleAttribute' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.adjuststyleattribute(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
