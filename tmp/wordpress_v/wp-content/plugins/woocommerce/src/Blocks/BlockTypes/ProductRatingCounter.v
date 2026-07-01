import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRatingCounter {
	rt.PhpObjectBase
pub mut:
	block_name  rt.PhpVal = rt.new_string('product-rating-counter')
	api_version rt.PhpVal = rt.new_string('3')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRatingCounter) parse_attributes(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'productId', val: 0 },
		rt.ArrayItem{ key: 'isDescendentOfQueryLoop', val: false },
		rt.ArrayItem{ key: 'textAlign', val: '' }, rt.ArrayItem{
			key: 'isDescendentOfSingleProductBlock'
			val: false
		}, rt.ArrayItem{ key: 'isDescendentOfSingleProductTemplate', val: false }])
	return rt.call_function('wp_parse_args', [var_attributes.dup(),
		var_defaults.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRatingCounter) register_block_type_assets() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRatingCounter) get_block_type_style() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRatingCounter) get_block_type_uses_context() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'query' },
		rt.ArrayItem{ key: none, val: 'queryId' }, rt.ArrayItem{ key: none, val: 'postId' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRatingCounter) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(!rt.is_true(var_content)) {
		this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.register_block_type_assets()
		this.register_chunk_translations(rt.create_array([
			rt.ArrayItem{ key: none, val: this.block_name },
		]))
		return var_content.str()
	}
	mut var_post_id := rt.get_property(var_block, 'context').array_get('postId')
	mut var_product := rt.call_function('wc_get_product', [var_post_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(var_product)
		&& rt.is_true(rt.greater(rt.call_method(var_product, 'get_review_count', []rt.PhpVal{}), rt.new_int(0)))))
	{
		mut var_product_reviews_count := rt.call_method(var_product, 'get_review_count',
			[]rt.PhpVal{})
		mut var_product_rating := rt.call_method(var_product, 'get_average_rating', []rt.PhpVal{})
		mut var_parsed_attributes := this.parse_attributes(var_attributes.dup())
		mut var_is_descendent_of_single_product_block :=
			var_parsed_attributes.array_get('isDescendentOfSingleProductBlock')
		mut var_is_descendent_of_single_product_template :=
			var_parsed_attributes.array_get('isDescendentOfSingleProductTemplate')
		mut var_styles_and_classes := fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
			return temp.get_classes_and_styles_by_attributes(arg_0)
		}(var_attributes.dup())
		mut var_text_align_styles_and_classes := fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
			return temp.get_text_align_class_and_style(arg_0)
		}(var_attributes.dup())
		closure_1_fn := fn [var_post_id, var_product_rating, var_product_reviews_count, var_is_descendent_of_single_product_block, var_is_descendent_of_single_product_template] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_html := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			mut var_rating := if args.len > 1 { args[1].dup() } else { rt.new_null() }
			mut var_count := if args.len > 2 { args[2].dup() } else { rt.new_null() }
			mut var_product_permalink := rt.call_function('get_permalink', [
				var_post_id.dup()])
			mut var_reviews_count := var_count
			mut var_average_rating := var_rating
			if rt.is_true(var_product_rating) {
				var_average_rating = var_product_rating.dup()
			}
			if rt.is_true(var_product_reviews_count) {
				var_reviews_count = var_product_reviews_count.dup()
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.less(rt.new_int(0), var_average_rating))
				|| rt.is_true(rt.identical(rt.new_bool(false), var_product_permalink))))
			{
				mut var_customer_reviews_count := rt.call_function('sprintf', [
					rt.call_function('_n', [rt.new_string('(%s customer review)'),
						rt.new_string('(%s customer reviews)'),
						var_reviews_count.dup(), rt.new_string('woocommerce')]),
					rt.call_function('esc_html', [var_reviews_count.dup()]),
				])
				if rt.is_true(var_is_descendent_of_single_product_block) {
					var_customer_reviews_count = rt.new_string('<a href="' +
						(rt.call_function('esc_url', [var_product_permalink.dup()])).str() +
						'#reviews">' + var_customer_reviews_count.str() + '</a>')
				} else if rt.is_true(var_is_descendent_of_single_product_template) {
					var_customer_reviews_count = rt.new_string(
						'<a class="woocommerce-review-link" rel="nofollow" href="#reviews">' +
						var_customer_reviews_count.str() + '</a>')
				}
				var_html = rt.call_function('sprintf', [
					rt.new_string('<div class="wc-block-components-product-rating-counter__container">\n\t\t\t\t\t\t\t<span class="wc-block-components-product-rating-counter__reviews_count">%1$s</span>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t\t'),
					var_customer_reviews_count.dup(),
				])
			} else {
				var_html = rt.new_string(rt.new_string(''))
			}
			return var_html.str()
		}
		mut var_filter_rating_html := rt.new_closure(closure_1_fn)
		rt.call_function('add_filter', [
			rt.new_string('woocommerce_product_get_rating_html'),
			var_filter_rating_html.dup(),
			rt.new_int(10),
			rt.new_int(3),
		])
		mut var_rating_html := rt.call_function('wc_get_rating_html', [
			rt.call_method(var_product, 'get_average_rating', []rt.PhpVal{}),
		])
		rt.call_function('remove_filter', [
			rt.new_string('woocommerce_product_get_rating_html'),
			var_filter_rating_html.dup(),
			rt.new_int(10),
		])
		mut var_classes := rt.call_function('implode', [rt.new_string(' '),
			rt.call_function('array_filter', [
				rt.create_array([
					rt.ArrayItem{
						key: none
						val: 'wc-block-components-product-rating-counter wc-block-grid__product-rating-counter'
					},
					rt.ArrayItem{ key: none, val: rt.call_function('esc_attr', [if !(var_text_align_styles_and_classes.array_get('class')).is_null() {
						var_text_align_styles_and_classes.array_get('class')
					} else {
						rt.new_string('')
					}]) },
					rt.ArrayItem{ key: none, val: rt.call_function('esc_attr', [
						var_styles_and_classes.array_get('classes')]) },
				]),
			])])
		mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
			rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes },
				rt.ArrayItem{ key: 'style', val: rt.call_function('esc_attr', [if !(var_styles_and_classes.array_get('styles')).is_null() {
					var_styles_and_classes.array_get('styles')
				} else {
					rt.new_string('')
				}]) }]),
		])
		return (rt.call_function('sprintf', [
			rt.new_string('<div %1$s>\n\t\t\t\t\t%2$s\n\t\t\t\t</div>'),
			var_wrapper_attributes.dup(),
			var_rating_html.dup(),
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

fn create_automattic_woocommerce_blocks_blocktypes_productratingcounter() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRatingCounter {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRatingCounter{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-rating-counter')
		api_version:   rt.new_string('3')
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRatingCounter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRatingCounter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'api_version' { return this.api_version }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductRatingCounter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productratingcounter_php() {
}
