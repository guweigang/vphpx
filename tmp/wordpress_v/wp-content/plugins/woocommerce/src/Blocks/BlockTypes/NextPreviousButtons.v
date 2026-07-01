import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_NextPreviousButtons {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-gallery-large-image-next-previous')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_NextPreviousButtons) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_iapi_provider := if !(rt.get_property(var_block, 'context').array_get('iapi/provider')).is_null() {
		rt.get_property(var_block, 'context').array_get('iapi/provider')
	} else {
		rt.new_null()
	}
	if !rt.is_true(var_iapi_provider) {
		return ''
	}
	mut var_classes_and_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		return temp.get_classes_and_styles_by_attributes(arg_0, arg_1, arg_2)
	}(var_attributes.dup(), rt.new_array(), rt.create_array([
		rt.ArrayItem{ key: none, val: 'align' },
	]))
	mut var_vertical_alignment := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		return temp.get_align_class_and_style(arg_0)
	}(var_attributes.dup())
	mut var_left_arrow_path :=
		rt.new_string(rt.new_string('M6.445 12.005.986 6 6.445-.005l1.11 1.01L3.014 6l4.54 4.995-1.109 1.01Z'))
	mut var_right_arrow_path :=
		rt.new_string(rt.new_string('M1.555-.004 7.014 6l-5.459 6.005-1.11-1.01L4.986 6 .446 1.005l1.109-1.01Z'))
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_vertical_alignment.array_get('class')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_iapi_provider.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_classes_and_styles.array_get('classes')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_classes_and_styles.array_get('styles')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { rt.call_function('esc_attr', [
			var_right_arrow_path.dup(),
		]) } else { rt.call_function('esc_attr', [var_left_arrow_path.dup()]) })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_classes_and_styles.array_get('classes')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_classes_and_styles.array_get('styles')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { rt.call_function('esc_attr', [
			var_left_arrow_path.dup(),
		]) } else { rt.call_function('esc_attr', [var_right_arrow_path.dup()]) })
	// unsupported statement: Stmt_InlineHTML
	mut var_template := rt.call_function('ob_get_clean', []rt.PhpVal{})
	return var_template.str()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_nextpreviousbuttons() &Class_Automattic_WooCommerce_Blocks_BlockTypes_NextPreviousButtons {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_NextPreviousButtons{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-gallery-large-image-next-previous')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils() &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_NextPreviousButtons) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_NextPreviousButtons) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_NextPreviousButtons) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_nextpreviousbuttons_php() {
	// unsupported statement: Stmt_Declare
}
