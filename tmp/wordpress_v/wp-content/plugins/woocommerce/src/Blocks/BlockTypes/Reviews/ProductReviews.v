import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviews {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-reviews')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviews) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !rt.is_true(rt.get_property(var_block, 'parsed_block').array_get('innerBlocks')) {
		return (this.render_legacy_block(var_attributes.dup(), var_content.dup(), var_block.dup())).str()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('comments_open', []rt.PhpVal{}))))) {
		return ''
	}
	mut var_p :=
		create_automattic_woocommerce_blocks_blocktypes_reviews_wp_html_tag_processor(var_content.dup())
	var_p.next_tag()
	var_p.set_attribute(rt.new_string('data-wp-interactive'), this.get_full_block_name())
	var_p.set_attribute(rt.new_string('data-wp-router-region'), this.get_full_block_name())
	return (var_p.get_updated_html()).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviews) render_legacy_block(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_singular', [
		rt.new_string('product'),
	])))))
	{
		return var_content.dup()
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('rewind_posts', []rt.PhpVal{})
	for rt.is_true(rt.call_function('have_posts', []rt.PhpVal{})) {
		rt.call_function('the_post', []rt.PhpVal{})
		rt.call_function('comments_template', []rt.PhpVal{})
	}
	mut var_reviews := rt.call_function('ob_get_clean', []rt.PhpVal{})
	return rt.call_function('sprintf', [
		rt.new_string('<div class="wp-block-woocommerce-product-reviews %1$s">\n\t\t\t\t%2$s\n\t\t\t</div>'),
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
			return temp.get_classes_by_attributes(arg_0, arg_1)
		}(var_attributes.dup(), rt.create_array([
			rt.ArrayItem{ key: none, val: 'extra_classes' },
		])),
		var_reviews.dup(),
	])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_reviews_productreviews() &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviews {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviews{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-reviews')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_reviews_wp_html_tag_processor() &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_HTML_Tag_Processor{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviews) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'render_legacy_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render_legacy_block(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviews) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviews) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_reviews_productreviews_php() {
	// unsupported statement: Stmt_Declare
}
