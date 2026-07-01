import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPagination {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-reviews-pagination')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPagination) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if var_content.dup().to_string().trim_space() == '' {
		return ''
	}
	if rt.is_true(rt.call_function('post_password_required', []rt.PhpVal{})) {
		return ''
	}
	mut var_classes := rt.new_string(if var_attributes.array_get('style').array_get('elements').array_get('link').array_get('color').array_isset(rt.new_string('text')) {
		rt.new_string('has-link-color')
	} else {
		rt.new_string('')
	})
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes },
			rt.ArrayItem{ key: 'data-wp-interactive', val: 'woocommerce/product-reviews' }]),
	])
	mut var_p :=
		create_automattic_woocommerce_blocks_blocktypes_reviews_wp_html_tag_processor(var_content.dup())
	for rt.is_true(var_p.next_tag(rt.new_string('a'))) {
		var_p.set_attribute(rt.new_string('data-wp-on--click'), rt.new_string('actions.navigate'))
	}
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.dup(), var_p.get_updated_html()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPagination) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_reviews_productreviewspagination() &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPagination {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPagination{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-reviews-pagination')
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPagination) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPagination) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPagination) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_reviews_productreviewspagination_php() {
	// unsupported statement: Stmt_Declare
}
