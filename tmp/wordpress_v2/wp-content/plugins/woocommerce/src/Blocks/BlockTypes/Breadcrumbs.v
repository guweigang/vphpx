import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Breadcrumbs {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('breadcrumbs')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Breadcrumbs) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('woocommerce_breadcrumb', []rt.PhpVal{})
	mut var_breadcrumb := rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_breadcrumb)))) {
		return rt.new_null()
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
	mut iife_result_0 := iife_temp_0.get_classes_and_styles_by_attributes(var_attributes.clone(),
		rt.new_array(), rt.create_array([rt.ArrayItem{ key: none, val: 'font_size' }]))
	mut var_classes_and_styles := iife_result_0
	mut var_font_size_classes_and_styles :=
		this.get_font_size_classes_and_styles(var_attributes.clone())
	var_classes_and_styles.array_set('classes',
		(var_classes_and_styles.array_get(rt.new_string('classes'))).str() + ' ' + (var_font_size_classes_and_styles.array_get(rt.new_string('class'))).str() + ' ')
	var_classes_and_styles.array_set('styles',
		(var_classes_and_styles.array_get(rt.new_string('styles'))).str() + ' ' + (var_font_size_classes_and_styles.array_get(rt.new_string('style'))).str() + ' ')
	return rt.call_function('sprintf', [
		rt.new_string('<div class="woocommerce wp-block-breadcrumbs wc-block-breadcrumbs %1$s" style="%2$s">%3$s</div>'),
		rt.call_function('esc_attr', [var_classes_and_styles.array_get(rt.new_string('classes'))]),
		rt.call_function('esc_attr', [var_classes_and_styles.array_get(rt.new_string('styles'))]),
		var_breadcrumb.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Breadcrumbs) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Breadcrumbs) get_font_size_classes_and_styles(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_font_size := if !(var_attributes.array_get(rt.new_string('fontSize'))).is_null() {
		var_attributes.array_get(rt.new_string('fontSize'))
	} else {
		rt.new_string('')
	}
	mut var_custom_font_size := if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontSize'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontSize'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_font_size))))
		&& rt.is_true(rt.identical(rt.new_string(''), var_custom_font_size)) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() },
			rt.ArrayItem{ key: 'style', val: rt.new_null() }])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_custom_font_size)))) {
		return rt.create_array([rt.ArrayItem{ key: 'class', val: rt.new_null() },
			rt.ArrayItem{ key: 'style', val: rt.call_function('sprintf', [
				rt.new_string('font-size: %s;'),
				var_custom_font_size.clone(),
			]) }])
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'class', val: rt.call_function('sprintf', [
			rt.new_string('has-font-size has-%s-font-size'),
			var_font_size.clone(),
		]) },
		rt.ArrayItem{ key: 'style', val: rt.new_null() },
	])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_breadcrumbs(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_Breadcrumbs {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Breadcrumbs{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('breadcrumbs')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Breadcrumbs) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		'get_font_size_classes_and_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_font_size_classes_and_styles(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Breadcrumbs) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Breadcrumbs) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
