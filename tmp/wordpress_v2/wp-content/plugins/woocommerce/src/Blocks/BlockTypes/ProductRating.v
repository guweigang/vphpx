import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRating {
	rt.PhpObjectBase
pub mut:
	block_name  rt.PhpVal = rt.new_string('product-rating')
	api_version rt.PhpVal = rt.new_string('3')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRating) parse_attributes(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'productId', val: 0 },
		rt.ArrayItem{ key: 'isDescendentOfQueryLoop', val: false },
		rt.ArrayItem{ key: 'textAlign', val: '' }, rt.ArrayItem{
			key: 'isDescendentOfSingleProductBlock'
			val: false
		}, rt.ArrayItem{ key: 'isDescendentOfSingleProductTemplate', val: false }])
	return rt.call_function('wp_parse_args', [var_attributes.clone(),
		var_defaults.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRating) register_block_type_assets() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRating) get_block_type_style() rt.PhpVal {
	return rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.get_block_type_style(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wc-blocks-packages-style' }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRating) get_block_type_uses_context() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'query' },
		rt.ArrayItem{ key: none, val: 'queryId' }, rt.ArrayItem{ key: none, val: 'postId' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRating) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(!rt.is_true(var_content)) {
		this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.register_block_type_assets()
		this.register_chunk_translations(rt.create_array([
			rt.ArrayItem{ key: none, val: this.block_name },
		]))
		return var_content.str()
	}
	mut var_post_id := if rt.get_property(var_block, 'context').array_isset(rt.new_string('postId')) {
		rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))
	} else {
		rt.new_string('')
	}
	mut var_product := rt.call_function('wc_get_product', [var_post_id.clone()])
	if rt.is_true(var_product)
		&& rt.is_true(rt.greater(rt.call_method(var_product, 'get_review_count', []rt.PhpVal{}), rt.new_int(0)))
		&& rt.is_true(rt.call_method(var_product, 'get_reviews_allowed', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('wc_reviews_enabled', []rt.PhpVal{})) {
		mut var_product_reviews_count := rt.call_method(var_product, 'get_review_count',
			[]rt.PhpVal{})
		mut var_product_rating := rt.call_method(var_product, 'get_average_rating', []rt.PhpVal{})
		mut var_parsed_attributes := this.parse_attributes(var_attributes.clone())
		mut var_is_descendent_of_single_product_block :=
			var_parsed_attributes.array_get(rt.new_string('isDescendentOfSingleProductBlock'))
		mut var_is_descendent_of_single_product_template :=
			var_parsed_attributes.array_get(rt.new_string('isDescendentOfSingleProductTemplate'))
		mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		mut iife_result_0 :=
			iife_temp_0.get_classes_and_styles_by_attributes(var_attributes.clone())
		mut var_styles_and_classes := iife_result_0
		mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		mut iife_result_1 := iife_temp_1.get_text_align_class_and_style(var_attributes.clone())
		mut var_text_align_styles_and_classes := iife_result_1
		closure_3_fn := fn [var_post_id, var_product_rating, var_product_reviews_count, var_is_descendent_of_single_product_block, var_is_descendent_of_single_product_template] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_html := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_rating := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			mut var_count := if args.len > 2 { args[2].clone() } else { rt.new_null() }
			mut var_product_permalink := rt.call_function('get_permalink', [
				var_post_id.clone()])
			mut var_reviews_count := var_count
			mut var_average_rating := var_rating
			if rt.is_true(var_product_rating) {
				var_average_rating = var_product_rating.clone()
			}
			if rt.is_true(var_product_reviews_count) {
				var_reviews_count = var_product_reviews_count.clone()
			}
			if rt.is_true(rt.less(rt.new_int(0), var_average_rating))
				|| rt.is_true(rt.identical(rt.new_bool(false), var_product_permalink)) {
				mut var_label := rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Rated %s out of 5'),
						rt.new_string('woocommerce')]),
					var_average_rating.clone(),
				])
				mut var_customer_reviews_count := rt.call_function('sprintf', [
					rt.call_function('_n', [rt.new_string('(%s customer review)'),
						rt.new_string('(%s customer reviews)'),
						var_reviews_count.clone(), rt.new_string('woocommerce')]),
					rt.call_function('esc_html', [var_reviews_count.clone()]),
				])
				if rt.is_true(var_is_descendent_of_single_product_block) {
					var_customer_reviews_count = rt.new_string('<a href="' +
						(rt.call_function('esc_url', [var_product_permalink.clone()])).str() +
						'#reviews">' + var_customer_reviews_count.str() + '</a>')
				} else if rt.is_true(var_is_descendent_of_single_product_template) {
					var_customer_reviews_count = rt.new_string(
						'<a class="woocommerce-review-link" rel="nofollow" href="#reviews">' +
						var_customer_reviews_count.str() + '</a>')
				}
				mut var_reviews_count_html := rt.call_function('sprintf', [
					rt.new_string('<span class="wc-block-components-product-rating__reviews_count">%1$s</span>'),
					var_customer_reviews_count.clone(),
				])
				var_html = rt.call_function('sprintf', [
					rt.new_string('<div class="wc-block-components-product-rating__container">\n\t\t\t\t\t\t\t<div class="wc-block-components-product-rating__stars wc-block-grid__product-rating__stars" role="img" aria-label="%1$s">\n\t\t\t\t\t\t\t\t%2$s\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t%3$s\n\t\t\t\t\t\t</div>\n\t\t\t\t\t\t'),
					rt.call_function('esc_attr', [var_label.clone()]),
					rt.call_function('wc_get_star_rating_html', [
						var_average_rating.clone(), var_reviews_count.clone()]),
					if rt.is_true(var_is_descendent_of_single_product_block)
						|| rt.is_true(var_is_descendent_of_single_product_template) {
						var_reviews_count_html
					} else {
						rt.new_string('')
					},
				])
			} else {
				var_html = rt.new_string('')
			}
			return var_html.str()
		}
		mut var_filter_rating_html := rt.new_closure(closure_3_fn)
		rt.call_function('add_filter', [
			rt.new_string('woocommerce_product_get_rating_html'),
			var_filter_rating_html.clone(),
			rt.new_int(10),
			rt.new_int(3),
		])
		mut var_rating_html := rt.call_function('wc_get_rating_html', [
			rt.call_method(var_product, 'get_average_rating', []rt.PhpVal{}),
		])
		rt.call_function('remove_filter', [
			rt.new_string('woocommerce_product_get_rating_html'),
			var_filter_rating_html.clone(),
			rt.new_int(10),
		])
		mut var_classes := rt.call_function('implode', [rt.new_string(' '),
			rt.call_function('array_filter', [
				rt.create_array([
					rt.ArrayItem{
						key: none
						val: 'wc-block-components-product-rating wc-block-grid__product-rating'
					},
					rt.ArrayItem{ key: none, val: rt.call_function('esc_attr', [if !(var_text_align_styles_and_classes.array_get(rt.new_string('class'))).is_null() {
						var_text_align_styles_and_classes.array_get(rt.new_string('class'))
					} else {
						rt.new_string('')
					}]) },
					rt.ArrayItem{ key: none, val: rt.call_function('esc_attr', [
						var_styles_and_classes.array_get(rt.new_string('classes'))]) },
				]),
			])])
		mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
			rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes },
				rt.ArrayItem{ key: 'style', val: rt.call_function('esc_attr', [if !(var_styles_and_classes.array_get(rt.new_string('styles'))).is_null() {
					var_styles_and_classes.array_get(rt.new_string('styles'))
				} else {
					rt.new_string('')
				}]) }]),
		])
		return (rt.call_function('sprintf', [
			rt.new_string('<div %1$s>\n\t\t\t\t\t%2$s\n\t\t\t\t</div>'),
			var_wrapper_attributes.clone(),
			var_rating_html.clone(),
		])).str()
	}
	return ''
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productrating(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRating {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRating{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-rating')
		api_version:   rt.new_string('3')
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRating) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'parse_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_attributes(dispatch_arg_0)
		}
		'register_block_type_assets' {
			return this.register_block_type_assets()
		}
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		'get_block_type_uses_context' {
			return this.get_block_type_uses_context()
		}
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRating) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'api_version' { return this.api_version }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRating) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
			return true
		}
		'api_version' {
			this.api_version = val
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
