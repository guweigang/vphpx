import rt

pub fn Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode.coupon_code_placeholder() string {
	return 'XXXX-XXXXXX-XXXX'
}

pub fn Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode.default_styles() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'font-size', val: '1.2em' },
		rt.ArrayItem{ key: 'padding', val: '12px 20px' }, rt.ArrayItem{
			key: 'display'
			val: 'inline-block'
		}, rt.ArrayItem{ key: 'border', val: '2px dashed #cccccc' },
		rt.ArrayItem{ key: 'border-radius', val: '4px' }, rt.ArrayItem{
			key: 'box-sizing'
			val: 'border-box'
		}, rt.ArrayItem{ key: 'color', val: '#000000' }, rt.ArrayItem{
			key: 'background-color'
			val: '#f5f5f5'
		}, rt.ArrayItem{ key: 'text-align', val: 'center' }, rt.ArrayItem{
			key: 'font-weight'
			val: 'bold'
		}, rt.ArrayItem{ key: 'letter-spacing', val: '1px' }])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('coupon-code')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode) get_block_type_editor_script(var_key rt.PhpVal) rt.PhpVal {
	mut var_script := rt.create_array([
		rt.ArrayItem{ key: 'handle', val: 'wc-' + (this.block_name).str() + '-block' },
		rt.ArrayItem{ key: 'path', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_CouponCode', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_api'), 'get_block_asset_build_path', [
			this.block_name,
		]) },
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-blocks' },
		]) },
	])
	return if rt.is_true(rt.identical(rt.new_null(), var_key)) {
		var_script
	} else {
		if !(var_script.array_get(var_key)).is_null() {
			var_script.array_get(var_key)
		} else {
			rt.new_null()
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode) get_block_type_style() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) {
	mut var_attributes_mutated := var_attributes
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes_mutated))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_CouponCode', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'exists', [rt.new_string('couponTypes')])))))
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_get_coupon_types')])) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_CouponCode', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_data_registry'), 'add', [rt.new_string('couponTypes'),
			rt.call_function('wc_get_coupon_types', []rt.PhpVal{})])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_attributes_mutated := var_attributes
	mut var_parsed_block := if rt.is_true(rt.new_bool(rt.instance_of(var_block, 'WP_Block'))) {
		rt.get_property(var_block, 'parsed_block')
	} else {
		rt.new_array()
	}
	var_attributes_mutated = this.get_block_attributes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](var_parsed_block),
		var_attributes_mutated.clone())
	mut var_source := if !(var_attributes_mutated.array_get(rt.new_string('source'))).is_null() {
		var_attributes_mutated.array_get(rt.new_string('source'))
	} else {
		rt.new_string('createNew')
	}
	if rt.is_true(rt.identical(rt.new_string('createNew'), var_source)) {
		mut var_coupon_code :=
			Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode.coupon_code_placeholder()
	} else {
		var_coupon_code =
			rt.new_string(this.get_coupon_code(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](var_attributes_mutated)))
	}
	if !rt.is_true(var_coupon_code) {
		return ''
	}
	mut var_rendering_context := this.get_rendering_context(var_block.clone())
	mut var_coupon_html := rt.new_string(this.build_coupon_html(var_coupon_code.str(), mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](var_attributes_mutated), mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](var_rendering_context)))
	return this.wrap_for_email(var_coupon_html.str(), mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](var_parsed_block))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode) get_block_attributes(mut var_parsed_block Class_Automattic_WooCommerce_Blocks_BlockTypes_array, var_fallback rt.PhpVal) rt.PhpVal {
	mut var_parsed_block_mutated := var_parsed_block
	mut var_attributes := if !(var_parsed_block_mutated.array_get(rt.new_string('attrs'))).is_null() {
		var_parsed_block_mutated.array_get(rt.new_string('attrs'))
	} else {
		if !var_fallback.is_null() { var_fallback } else { rt.new_array() }
	}
	return if var_attributes.clone().is_array() { var_attributes } else { rt.new_array() }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode) get_coupon_code(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) string {
	mut var_attributes_mutated := var_attributes
	mut var_coupon_code := if !(var_attributes_mutated.array_get(rt.new_string('couponCode'))).is_null() {
		var_attributes_mutated.array_get(rt.new_string('couponCode'))
	} else {
		rt.new_string('')
	}
	return (if var_coupon_code.clone().is_string() {
		var_coupon_code
	} else {
		rt.new_string('')
	}).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode) get_rendering_context(var_block rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(var_block, 'WP_Block')))
		&& rt.get_property(var_block, 'context').array_isset(rt.new_string('renderingContext'))
		&& rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(var_block, 'context').array_get(rt.new_string('renderingContext')), 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context'))) {
		return rt.get_property(var_block, 'context').array_get(rt.new_string('renderingContext'))
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container{}
	mut iife_result_0 := iife_temp_0.container()
	mut var_theme_controller := rt.call_method(iife_result_0, 'get', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller.class(),
	])
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context',
		[]string{}, create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_rendering_context(rt.call_method(var_theme_controller,
		'get_theme', []rt.PhpVal{}), rt.new_array()))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode) build_coupon_html(coupon_code string, mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut coupon_code_mutated := coupon_code
	mut var_attributes_mutated := var_attributes
	mut var_rendering_context_mutated := var_rendering_context
	mut iife_temp_1 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_1 := iife_temp_1.get_block_styles(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes_mutated), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context',
		[]string{}, var_rendering_context_mutated), rt.create_array([
		rt.ArrayItem{ key: none, val: 'border' },
		rt.ArrayItem{ key: none, val: 'background-color' },
		rt.ArrayItem{ key: none, val: 'color' },
		rt.ArrayItem{ key: none, val: 'typography' },
		rt.ArrayItem{ key: none, val: 'spacing' },
	]))
	mut var_block_styles := iife_result_1
	mut var_declarations := if !(var_block_styles.array_get(rt.new_string('declarations'))).is_null() {
		var_block_styles.array_get(rt.new_string('declarations'))
	} else {
		rt.new_array()
	}
	if !(this.has_valid_background_color(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](var_declarations))) {
		var_declarations.array_set('background-color', this.resolve_background_color(mut var_attributes_mutated, mut
			var_rendering_context_mutated))
	}
	mut var_merged_styles := rt.call_function('array_merge', [
		Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode.default_styles(),
		var_declarations.clone(),
	])
	mut iife_temp_2 := Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Style_Engine{}
	mut iife_result_2 := iife_temp_2.compile_css(var_merged_styles.clone(), rt.new_string(''))
	mut var_css := iife_result_2
	return (rt.call_function('sprintf', [
		rt.new_string('<span class="woocommerce-coupon-code" style="%s">%s</span>'),
		rt.call_function('esc_attr', [var_css.clone()]),
		rt.call_function('esc_html', [rt.new_string(coupon_code_mutated).clone()]),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode) has_valid_background_color(mut var_declarations Class_Automattic_WooCommerce_Blocks_BlockTypes_array) bool {
	mut var_declarations_mutated := var_declarations
	if !rt.is_true(var_declarations_mutated.array_get(rt.new_string('background-color'))) {
		return false
	}
	return this.is_css_color_value((var_declarations_mutated.array_get(rt.new_string('background-color'))).str())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode) resolve_background_color(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_attributes_mutated := var_attributes
	mut var_rendering_context_mutated := var_rendering_context
	if !rt.is_true(var_attributes_mutated.array_get(rt.new_string('backgroundColor'))) {
		return (Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode.default_styles().array_get(rt.new_string('background-color'))).str()
	}
	mut var_color_slug := var_attributes_mutated.array_get(rt.new_string('backgroundColor'))
	mut iife_temp_3 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_3 := iife_temp_3.get_normalized_block_styles(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes_mutated), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context',
		[]string{}, var_rendering_context_mutated))
	mut var_normalized := iife_result_3
	mut var_color := if !(var_normalized.array_get(rt.new_string('color')).array_get(rt.new_string('background'))).is_null() {
		var_normalized.array_get(rt.new_string('color')).array_get(rt.new_string('background'))
	} else {
		rt.new_string('')
	}
	if this.is_css_color_value(var_color.str()) {
		return var_color.str()
	}
	mut var_translated := rt.call_method(var_rendering_context_mutated, 'translate_slug_to_color', [
		var_color_slug.clone(),
	])
	if this.is_css_color_value(var_translated.str()) {
		return var_translated.str()
	}
	return (Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode.default_styles().array_get(rt.new_string('background-color'))).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode) is_css_color_value(value string) bool {
	return
		rt.is_true(rt.call_function('str_starts_with', [rt.new_string(value), rt.new_string('#')]))
		|| rt.is_true(rt.call_function('str_starts_with', [rt.new_string(value), rt.new_string('rgb')]))
		|| rt.is_true(rt.call_function('str_starts_with', [rt.new_string(value), rt.new_string('hsl')]))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode) wrap_for_email(coupon_html string, mut var_parsed_block Class_Automattic_WooCommerce_Blocks_BlockTypes_array) string {
	mut coupon_html_mutated := coupon_html
	mut var_parsed_block_mutated := var_parsed_block
	mut var_align := rt.new_string(this.get_alignment(mut var_parsed_block_mutated))
	mut iife_temp_4 := Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Style_Engine{}
	mut iife_result_4 := iife_temp_4.compile_css(rt.create_array([
		rt.ArrayItem{ key: 'border-collapse', val: 'collapse' },
		rt.ArrayItem{ key: 'width', val: '100%' },
	]), rt.new_string(''))
	mut var_table_attrs := rt.create_array([
		rt.ArrayItem{ key: 'style', val: iife_result_4 },
		rt.ArrayItem{ key: 'width', val: '100%' },
	])
	mut iife_temp_5 := Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Style_Engine{}
	mut iife_result_5 := iife_temp_5.compile_css(rt.create_array([
		rt.ArrayItem{ key: 'padding', val: '10px 0' },
		rt.ArrayItem{ key: 'text-align', val: var_align },
	]), rt.new_string(''))
	mut var_cell_attrs := rt.create_array([
		rt.ArrayItem{ key: 'class', val: 'email-coupon-code-cell' },
		rt.ArrayItem{ key: 'style', val: iife_result_5 },
		rt.ArrayItem{ key: 'align', val: var_align },
	])
	mut iife_temp_6 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_6 := iife_temp_6.render_table_wrapper(rt.new_string(coupon_html_mutated),
		var_table_attrs.clone(), var_cell_attrs.clone())
	return iife_result_6.str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode) get_alignment(mut var_parsed_block Class_Automattic_WooCommerce_Blocks_BlockTypes_array) string {
	mut var_parsed_block_mutated := var_parsed_block
	mut var_allowed := rt.create_array([rt.ArrayItem{ key: none, val: 'left' },
		rt.ArrayItem{ key: none, val: 'center' }, rt.ArrayItem{ key: none, val: 'right' }])
	mut var_align := if !(var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('align'))).is_null() {
		var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('align'))
	} else {
		rt.new_string('center')
	}
	if !(var_align.clone().is_string())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_align.clone(), var_allowed.clone(), rt.new_bool(true)]))))) {
		return 'center'
	}
	return var_align.str()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Style_Engine {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_couponcode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('coupon-code')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_email_editor_container(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_rendering_context(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context{
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

fn create_automattic_woocommerce_blocks_blocktypes_wp_style_engine(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Style_Engine {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Style_Engine{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_block_type_editor_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_editor_script(dispatch_arg_0)
		}
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_block_attributes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_block_attributes(mut dispatch_arg_0, dispatch_arg_1)
		}
		'get_coupon_code' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_coupon_code(mut dispatch_arg_0))
		}
		'get_rendering_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_rendering_context(dispatch_arg_0)
		}
		'build_coupon_html' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.build_coupon_html(dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2))
		}
		'has_valid_background_color' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.has_valid_background_color(mut dispatch_arg_0))
		}
		'resolve_background_color' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.resolve_background_color(mut dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'is_css_color_value' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_css_color_value(dispatch_arg_0))
		}
		'wrap_for_email' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.wrap_for_email(dispatch_arg_0, mut dispatch_arg_1))
		}
		'get_alignment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_alignment(mut dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CouponCode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Style_Engine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Style_Engine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Style_Engine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
