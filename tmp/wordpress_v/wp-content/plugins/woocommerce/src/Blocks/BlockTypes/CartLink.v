import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_CartLink {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('cart-link')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CartLink) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_classes_and_styles := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		return temp.get_classes_and_styles_by_attributes(arg_0)
	}(var_attributes.dup())
	mut var_icon := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils{}
		return temp.get_svg_icon(arg_0)
	}(if !(var_attributes.array_get('cartIcon')).is_null() {
		var_attributes.array_get('cartIcon')
	} else {
		rt.new_string('')
	})
	mut var_text := if rt.is_true(rt.new_bool(var_attributes.dup().array_isset(rt.new_string('content')))) { rt.call_function('esc_html', [
			var_attributes.array_get('content'),
		]) } else { rt.call_function('esc_html__', [rt.new_string('Cart'),
			rt.new_string('woocommerce')]) }
	mut var_aria_label := if !rt.is_true(var_text) { rt.call_function('sprintf', [
			rt.new_string(' aria-label="%s"'),
			rt.call_function('esc_attr__', [rt.new_string('Cart'),
				rt.new_string('woocommerce')]),
		]) } else { rt.new_string('') }
	return rt.call_function('sprintf', [
		rt.new_string('<div %1$s><a class="wc-block-cart-link" href="%2$s"%5$s>%3$s<span class="wc-block-cart-link__text">%4$s</span></a></div>'),
		rt.call_function('get_block_wrapper_attributes', [
			rt.create_array([
				rt.ArrayItem{ key: 'class', val: rt.call_function('esc_attr', [
					var_classes_and_styles.array_get('classes'),
				]) },
				rt.ArrayItem{ key: 'style', val: var_classes_and_styles.array_get('styles') },
			]),
		]),
		rt.call_function('esc_url', [
			rt.call_function('wc_get_cart_url', []rt.PhpVal{}),
		]),
		var_icon.dup(),
		var_text.dup(),
		var_aria_label.dup(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CartLink) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_cartlink() &Class_Automattic_WooCommerce_Blocks_BlockTypes_CartLink {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_CartLink{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('cart-link')
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

fn create_automattic_woocommerce_blocks_utils_minicartutils() &Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CartLink) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_CartLink) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CartLink) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_cartlink_php() {
}
