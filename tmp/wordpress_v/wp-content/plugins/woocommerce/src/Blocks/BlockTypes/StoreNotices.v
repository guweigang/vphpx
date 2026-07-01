import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_StoreNotices {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('store-notices')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_StoreNotices) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_print_notices'),
	])))))
	{
		return var_content.dup()
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('woocommerce_output_all_notices', []rt.PhpVal{})
	mut var_notices := rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_notices)))) {
		return rt.new_null()
	}
	mut var_classes_and_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		return temp.get_classes_and_styles_by_attributes(arg_0, arg_1, arg_2)
	}(var_attributes.dup(), rt.new_array(), rt.create_array([
		rt.ArrayItem{ key: none, val: 'extra_classes' },
	]))
	return rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		rt.call_function('get_block_wrapper_attributes', [
			rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: 'wc-block-store-notices woocommerce ' +(rt.call_function('esc_attr', [var_classes_and_styles.array_get('classes')])).str()
				},
			]),
		]),
		rt.call_function('wc_kses_notice', [
			var_notices.dup(),
		])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_StoreNotices) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_storenotices() &Class_Automattic_WooCommerce_Blocks_BlockTypes_StoreNotices {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_StoreNotices{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('store-notices')
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_StoreNotices) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_StoreNotices) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_StoreNotices) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_storenotices_php() {
}
