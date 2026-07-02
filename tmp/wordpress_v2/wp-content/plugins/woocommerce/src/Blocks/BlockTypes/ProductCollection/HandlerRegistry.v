import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_HandlerRegistry {
	rt.PhpObjectBase
pub mut:
	collection_handler_store rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_HandlerRegistry) register_collection_handlers(var_collection_name rt.PhpVal, var_build_query rt.PhpVal, var_frontend_args rt.PhpVal, var_editor_args rt.PhpVal, var_preview_query rt.PhpVal) rt.PhpVal {
	if this.collection_handler_store.array_isset(var_collection_name) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(
			'Collection handlers already registered for ' +
			(rt.call_function('esc_html', [var_collection_name.clone()])).str())))
	}
	this.collection_handler_store.array_set(var_collection_name, rt.create_array([
		rt.ArrayItem{ key: 'build_query', val: var_build_query },
		rt.ArrayItem{ key: 'frontend_args', val: var_frontend_args },
		rt.ArrayItem{ key: 'editor_args', val: var_editor_args },
		rt.ArrayItem{ key: 'preview_query', val: var_preview_query },
	]))
	return this.collection_handler_store.array_get(var_collection_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_HandlerRegistry) register_core_collections() rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_collection_args := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_common_query_values := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_query := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		if !rt.is_true(var_query.array_get(rt.new_string('handpicked_products'))) {
			return rt.create_array([
				rt.ArrayItem{ key: 'post__in', val: rt.create_array([
					rt.ArrayItem{ key: none, val: -1 },
				]) },
			])
		}
		return rt.new_null()
	}
	this.register_collection_handlers(rt.new_string('woocommerce/product-collection/hand-picked'),
		rt.new_closure(closure_1_fn), rt.new_null(), rt.new_null(), rt.new_null())
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_collection_args := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_common_query_values := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_query := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		if !rt.is_true(var_query.array_get(rt.new_string('taxonomies_query'))) {
			return rt.create_array([
				rt.ArrayItem{ key: 'post__in', val: rt.create_array([
					rt.ArrayItem{ key: none, val: -1 },
				]) },
			])
		}
		return rt.new_null()
	}
	this.register_collection_handlers(rt.new_string('woocommerce/product-collection/by-category'),
		rt.new_closure(closure_2_fn), rt.new_null(), rt.new_null(), rt.new_null())
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_collection_args := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_common_query_values := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_query := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		if !rt.is_true(var_query.array_get(rt.new_string('taxonomies_query'))) {
			return rt.create_array([
				rt.ArrayItem{ key: 'post__in', val: rt.create_array([
					rt.ArrayItem{ key: none, val: -1 },
				]) },
			])
		}
		return rt.new_null()
	}
	this.register_collection_handlers(rt.new_string('woocommerce/product-collection/by-tag'),
		rt.new_closure(closure_3_fn), rt.new_null(), rt.new_null(), rt.new_null())
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_collection_args := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_common_query_values := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_query := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		if !rt.is_true(var_query.array_get(rt.new_string('taxonomies_query'))) {
			return rt.create_array([
				rt.ArrayItem{ key: 'post__in', val: rt.create_array([
					rt.ArrayItem{ key: none, val: -1 },
				]) },
			])
		}
		return rt.new_null()
	}
	this.register_collection_handlers(rt.new_string('woocommerce/product-collection/by-brand'),
		rt.new_closure(closure_4_fn), rt.new_null(), rt.new_null(), rt.new_null())
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_collection_args := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !rt.is_true(var_collection_args.array_get(rt.new_string('relatedProductReference'))) {
			return rt.create_array([
				rt.ArrayItem{ key: 'post__in', val: rt.create_array([
					rt.ArrayItem{ key: none, val: -1 },
				]) },
			])
		}
		closure_6_fn := fn [var_collection_args] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			return var_collection_args.array_get(rt.new_string('relatedBy')).array_get(rt.new_string('categories'))
		}
		mut var_category_callback := rt.new_closure(closure_6_fn)
		closure_7_fn := fn [var_collection_args] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			return var_collection_args.array_get(rt.new_string('relatedBy')).array_get(rt.new_string('tags'))
		}
		mut var_tag_callback := rt.new_closure(closure_7_fn)
		rt.call_function('add_filter', [
			rt.new_string('woocommerce_product_related_posts_relate_by_category'),
			var_category_callback.clone(),
			rt.get_constant('PHP_INT_MAX'),
		])
		rt.call_function('add_filter', [
			rt.new_string('woocommerce_product_related_posts_relate_by_tag'),
			var_tag_callback.clone(),
			rt.get_constant('PHP_INT_MAX'),
		])
		mut var_related_products := rt.call_function('wc_get_related_products', [
			var_collection_args.array_get(rt.new_string('relatedProductReference')),
			rt.new_int(100),
			rt.new_array(),
			var_collection_args.array_get(rt.new_string('relatedBy')),
		])
		rt.call_function('remove_filter', [
			rt.new_string('woocommerce_product_related_posts_relate_by_category'),
			var_category_callback.clone(),
			rt.get_constant('PHP_INT_MAX'),
		])
		rt.call_function('remove_filter', [
			rt.new_string('woocommerce_product_related_posts_relate_by_tag'),
			var_tag_callback.clone(),
			rt.get_constant('PHP_INT_MAX'),
		])
		if !rt.is_true(var_related_products) {
			return rt.create_array([
				rt.ArrayItem{ key: 'post__in', val: rt.create_array([
					rt.ArrayItem{ key: none, val: -1 },
				]) },
			])
		}
		return rt.create_array([
			rt.ArrayItem{ key: 'post__in', val: var_related_products },
		])
	}
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_collection_args := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_query := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_product_reference := if !(var_query.array_get(rt.new_string('productReference'))).is_null() {
			var_query.array_get(rt.new_string('productReference'))
		} else {
			rt.new_null()
		}
		if !rt.is_true(var_product_reference) {
			mut var_location :=
				var_collection_args.array_get(rt.new_string('productCollectionLocation'))
			if var_location.array_isset(rt.new_string('type'))
				&& rt.is_true(rt.identical(rt.new_string('product'), var_location.array_get(rt.new_string('type')))) {
				var_product_reference =
					var_location.array_get(rt.new_string('sourceData')).array_get(rt.new_string('productId'))
			}
		}
		var_collection_args.array_set('relatedProductReference', var_product_reference.clone())
		var_collection_args.array_set('relatedBy', if !(var_query.array_isset(rt.new_string('relatedBy'))) { rt.create_array([
				rt.ArrayItem{ key: 'categories', val: true },
				rt.ArrayItem{ key: 'tags', val: true },
			]) } else { rt.create_array([
				rt.ArrayItem{
					key: 'categories'
					val: var_query.array_get(rt.new_string('relatedBy')).array_isset(rt.new_string('categories')) && rt.is_true(rt.identical(rt.new_bool(true), var_query.array_get(rt.new_string('relatedBy')).array_get(rt.new_string('categories'))))
				},
				rt.ArrayItem{
					key: 'tags'
					val: var_query.array_get(rt.new_string('relatedBy')).array_isset(rt.new_string('tags')) && rt.is_true(rt.identical(rt.new_bool(true), var_query.array_get(rt.new_string('relatedBy')).array_get(rt.new_string('tags'))))
				},
			]) })
		return var_collection_args.clone()
	}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_collection_args := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_query := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_request := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		mut var_product_reference := rt.call_method(var_request, 'get_param', [
			rt.new_string('productReference'),
		])
		if !rt.is_true(var_product_reference) {
			mut var_location :=
				var_collection_args.array_get(rt.new_string('productCollectionLocation'))
			if var_location.array_isset(rt.new_string('type'))
				&& rt.is_true(rt.identical(rt.new_string('product'), var_location.array_get(rt.new_string('type')))) {
				var_product_reference =
					var_location.array_get(rt.new_string('sourceData')).array_get(rt.new_string('productId'))
			}
		}
		var_collection_args.array_set('relatedProductReference', var_product_reference.clone())
		mut var_related_by := rt.call_method(var_request, 'get_param', [
			rt.new_string('relatedBy'),
		])
		var_collection_args.array_set('relatedBy', if !(!var_related_by.is_null()) { rt.create_array([
				rt.ArrayItem{ key: 'categories', val: true },
				rt.ArrayItem{ key: 'tags', val: true },
			]) } else { rt.create_array([
				rt.ArrayItem{ key: 'categories', val: rt.call_function('rest_sanitize_boolean', [
					if !(var_related_by.array_get(rt.new_string('categories'))).is_null() {
						var_related_by.array_get(rt.new_string('categories'))
					} else {
						rt.new_bool(false)
					},
				]) },
				rt.ArrayItem{ key: 'tags', val: rt.call_function('rest_sanitize_boolean', [
					if !(var_related_by.array_get(rt.new_string('tags'))).is_null() {
						var_related_by.array_get(rt.new_string('tags'))
					} else {
						rt.new_bool(false)
					},
				]) },
			])
		 })
		return var_collection_args.clone()
	}
	this.register_collection_handlers(rt.new_string('woocommerce/product-collection/related'),
		rt.new_closure(closure_7_fn), rt.new_closure(closure_8_fn), rt.new_closure(closure_9_fn),
		rt.new_null())
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_collection_args := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_product_reference := if !(var_collection_args.array_get(rt.new_string('upsellsProductReferences'))).is_null() {
			var_collection_args.array_get(rt.new_string('upsellsProductReferences'))
		} else {
			rt.new_null()
		}
		if !rt.is_true(var_product_reference) {
			return rt.create_array([
				rt.ArrayItem{ key: 'post__in', val: rt.create_array([
					rt.ArrayItem{ key: none, val: -1 },
				]) },
			])
		}
		mut var_products := rt.call_function('array_map', [
			rt.new_string('wc_get_product'),
			var_product_reference.clone(),
		])
		if !rt.is_true(var_products) {
			return rt.create_array([
				rt.ArrayItem{ key: 'post__in', val: rt.create_array([
					rt.ArrayItem{ key: none, val: -1 },
				]) },
			])
		}
		closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_acc := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_product := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			return rt.call_function('array_merge', [var_acc.clone(),
				rt.call_method(var_product, 'get_upsell_ids', []rt.PhpVal{})])
		}
		mut var_all_upsells := rt.call_function('array_reduce', [
			var_products.clone(), rt.new_closure(closure_11_fn),
			rt.new_array()])
		mut var_unique_upsells := rt.call_function('array_unique', [
			var_all_upsells.clone()])
		mut var_upsells := rt.call_function('array_diff', [var_unique_upsells.clone(),
			var_product_reference.clone()])
		return rt.create_array([
			rt.ArrayItem{
				key: 'post__in'
				val: if !rt.is_true(var_upsells) { rt.create_array([
						rt.ArrayItem{ key: none, val: -1 },
					]) } else { var_upsells }
			},
		])
	}
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_collection_args := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_query := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_product_references := if var_query.array_isset(rt.new_string('productReference')) { rt.create_array([
				rt.ArrayItem{ key: none, val: var_query.array_get(rt.new_string('productReference')) },
			]) } else { rt.new_null() }
		if !rt.is_true(var_product_references) {
			mut var_location :=
				var_collection_args.array_get(rt.new_string('productCollectionLocation'))
			if var_location.array_isset(rt.new_string('type'))
				&& rt.is_true(rt.identical(rt.new_string('product'), var_location.array_get(rt.new_string('type')))) {
				var_product_references = rt.create_array([
					rt.ArrayItem{
						key: none
						val: var_location.array_get(rt.new_string('sourceData')).array_get(rt.new_string('productId'))
					},
				])
			}
			if var_location.array_isset(rt.new_string('type'))
				&& rt.is_true(rt.identical(rt.new_string('cart'), var_location.array_get(rt.new_string('type')))) {
				var_product_references =
					var_location.array_get(rt.new_string('sourceData')).array_get(rt.new_string('productIds'))
			}
			if var_location.array_isset(rt.new_string('type'))
				&& rt.is_true(rt.identical(rt.new_string('order'), var_location.array_get(rt.new_string('type')))) {
				var_product_references = this.get_product_ids_from_order(if !(var_location.array_get(rt.new_string('sourceData')).array_get(rt.new_string('orderId'))).is_null() {
					var_location.array_get(rt.new_string('sourceData')).array_get(rt.new_string('orderId'))
				} else {
					rt.new_int(0)
				})
			}
		}
		var_collection_args.array_set('upsellsProductReferences', var_product_references.clone())
		return var_collection_args.clone()
	}
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_collection_args := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_query := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_request := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		mut var_product_reference := rt.call_method(var_request, 'get_param', [
			rt.new_string('productReference'),
		])
		if !rt.is_true(var_product_reference) {
			mut var_location :=
				var_collection_args.array_get(rt.new_string('productCollectionLocation'))
			if var_location.array_isset(rt.new_string('type'))
				&& rt.is_true(rt.identical(rt.new_string('product'), var_location.array_get(rt.new_string('type')))) {
				var_product_reference =
					var_location.array_get(rt.new_string('sourceData')).array_get(rt.new_string('productId'))
			}
		}
		var_collection_args.array_set('upsellsProductReferences', rt.create_array([
			rt.ArrayItem{ key: none, val: var_product_reference },
		]))
		return var_collection_args.clone()
	}
	this.register_collection_handlers(rt.new_string('woocommerce/product-collection/upsells'),
		rt.new_closure(closure_11_fn), rt.new_closure(closure_12_fn),
		rt.new_closure(closure_13_fn), rt.new_null())
	closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_collection_args := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_product_reference := if !(var_collection_args.array_get(rt.new_string('crossSellsProductReferences'))).is_null() {
			var_collection_args.array_get(rt.new_string('crossSellsProductReferences'))
		} else {
			rt.new_null()
		}
		if !rt.is_true(var_product_reference) {
			return rt.create_array([
				rt.ArrayItem{ key: 'post__in', val: rt.create_array([
					rt.ArrayItem{ key: none, val: -1 },
				]) },
			])
		}
		mut var_products := rt.call_function('array_filter', [
			rt.call_function('array_map', [rt.new_string('wc_get_product'),
				var_product_reference.clone()]),
		])
		if !rt.is_true(var_products) {
			return rt.create_array([
				rt.ArrayItem{ key: 'post__in', val: rt.create_array([
					rt.ArrayItem{ key: none, val: -1 },
				]) },
			])
		}
		closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.call_method(var_product, 'get_id', []rt.PhpVal{})
		}
		closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.call_method(var_product, 'get_id', []rt.PhpVal{})
		}
		mut var_product_ids := rt.call_function('array_map', [
			rt.new_closure(closure_15_fn),
			var_products.clone(),
		])
		closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_acc := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_product := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			return rt.call_function('array_merge', [var_acc.clone(),
				rt.call_method(var_product, 'get_cross_sell_ids', []rt.PhpVal{})])
		}
		mut var_all_cross_sells := rt.call_function('array_reduce', [
			var_products.clone(), rt.new_closure(closure_17_fn),
			rt.new_array()])
		mut var_unique_cross_sells := rt.call_function('array_unique', [
			var_all_cross_sells.clone()])
		mut var_cross_sells := rt.call_function('array_diff', [
			var_unique_cross_sells.clone(), var_product_ids.clone()])
		return rt.create_array([
			rt.ArrayItem{
				key: 'post__in'
				val: if !rt.is_true(var_cross_sells) { rt.create_array([
						rt.ArrayItem{ key: none, val: -1 },
					]) } else { var_cross_sells }
			},
		])
	}
	closure_18_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_collection_args := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_query := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_product_references := if var_query.array_isset(rt.new_string('productReference')) { rt.create_array([
				rt.ArrayItem{ key: none, val: var_query.array_get(rt.new_string('productReference')) },
			]) } else { rt.new_null() }
		if !rt.is_true(var_product_references) {
			mut var_location :=
				var_collection_args.array_get(rt.new_string('productCollectionLocation'))
			if var_location.array_isset(rt.new_string('type'))
				&& rt.is_true(rt.identical(rt.new_string('product'), var_location.array_get(rt.new_string('type')))) {
				var_product_references = rt.create_array([
					rt.ArrayItem{
						key: none
						val: var_location.array_get(rt.new_string('sourceData')).array_get(rt.new_string('productId'))
					},
				])
			}
			if var_location.array_isset(rt.new_string('type'))
				&& rt.is_true(rt.identical(rt.new_string('cart'), var_location.array_get(rt.new_string('type')))) {
				var_product_references =
					var_location.array_get(rt.new_string('sourceData')).array_get(rt.new_string('productIds'))
			}
			if var_location.array_isset(rt.new_string('type'))
				&& rt.is_true(rt.identical(rt.new_string('order'), var_location.array_get(rt.new_string('type')))) {
				var_product_references = this.get_product_ids_from_order(if !(var_location.array_get(rt.new_string('sourceData')).array_get(rt.new_string('orderId'))).is_null() {
					var_location.array_get(rt.new_string('sourceData')).array_get(rt.new_string('orderId'))
				} else {
					rt.new_int(0)
				})
			}
		}
		var_collection_args.array_set('crossSellsProductReferences', var_product_references.clone())
		return var_collection_args.clone()
	}
	closure_19_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_collection_args := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_query := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_request := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		mut var_product_reference := rt.call_method(var_request, 'get_param', [
			rt.new_string('productReference'),
		])
		if !rt.is_true(var_product_reference) {
			mut var_location :=
				var_collection_args.array_get(rt.new_string('productCollectionLocation'))
			if var_location.array_isset(rt.new_string('type'))
				&& rt.is_true(rt.identical(rt.new_string('product'), var_location.array_get(rt.new_string('type')))) {
				var_product_reference =
					var_location.array_get(rt.new_string('sourceData')).array_get(rt.new_string('productId'))
			}
		}
		var_collection_args.array_set('crossSellsProductReferences', rt.create_array([
			rt.ArrayItem{ key: none, val: var_product_reference },
		]))
		return var_collection_args.clone()
	}
	this.register_collection_handlers(rt.new_string('woocommerce/product-collection/cross-sells'),
		rt.new_closure(closure_17_fn), rt.new_closure(closure_18_fn),
		rt.new_closure(closure_19_fn), rt.new_null())
	closure_20_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_array()
	}
	mut var_noop_build_query := rt.new_closure(closure_20_fn)
	closure_21_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.get_recent_product_ids_query()
	}
	this.register_collection_handlers(rt.new_string('woocommerce/product-collection/best-sellers'),
		var_noop_build_query.clone(), rt.new_null(), rt.new_null(), rt.new_closure(closure_21_fn))
	closure_22_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.get_recent_product_ids_query()
	}
	this.register_collection_handlers(rt.new_string('woocommerce/product-collection/new-arrivals'),
		var_noop_build_query.clone(), rt.new_null(), rt.new_null(), rt.new_closure(closure_22_fn))
	closure_23_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_collection_args := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_cart_product_ids := if !(var_collection_args.array_get(rt.new_string('cartProductIds'))).is_null() {
			var_collection_args.array_get(rt.new_string('cartProductIds'))
		} else {
			rt.new_null()
		}
		if !rt.is_true(var_cart_product_ids) {
			return rt.create_array([
				rt.ArrayItem{ key: 'post__in', val: rt.create_array([
					rt.ArrayItem{ key: none, val: -1 },
				]) },
			])
		}
		return rt.create_array([
			rt.ArrayItem{ key: 'post__in', val: var_cart_product_ids },
		])
	}
	closure_24_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_collection_args := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_query := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		var_collection_args.array_set('cartProductIds', this.get_cart_product_ids(rt.new_null()))
		return var_collection_args.clone()
	}
	closure_25_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_collection_args := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_query := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_request := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		var_collection_args.array_set('cartProductIds',
			this.get_cart_product_ids(var_request.clone()))
		return var_collection_args.clone()
	}
	this.register_collection_handlers(rt.new_string('woocommerce/product-collection/cart-contents'),
		rt.new_closure(closure_23_fn), rt.new_closure(closure_24_fn),
		rt.new_closure(closure_25_fn), rt.new_null())
	return this.collection_handler_store
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_HandlerRegistry) get_collection_handler(var_name rt.PhpVal) rt.PhpVal {
	return if !(this.collection_handler_store.array_get(var_name)).is_null() {
		this.collection_handler_store.array_get(var_name)
	} else {
		rt.new_null()
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_HandlerRegistry) unregister_collection_handlers(var_collection_name rt.PhpVal) {
	this.collection_handler_store.array_unset(var_collection_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_HandlerRegistry) get_product_ids_from_order(var_order_id rt.PhpVal) rt.PhpVal {
	mut var_product_references := rt.new_array()
	if !rt.is_true(var_order_id) {
		return var_product_references.clone()
	}
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(var_order) {
		closure_26_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.call_method(var_item, 'get_product_id', []rt.PhpVal{})
		}
		closure_27_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.call_method(var_item, 'get_product_id', []rt.PhpVal{})
		}
		closure_28_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.call_method(var_item, 'get_product_id', []rt.PhpVal{})
		}
		closure_29_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.call_method(var_item, 'get_product_id', []rt.PhpVal{})
		}
		var_product_references = rt.call_function('array_filter', [
			rt.call_function('array_map', [rt.new_closure(closure_26_fn),
				rt.call_method(var_order, 'get_items', [
					Class_Automattic_WooCommerce_Enums_OrderItemType.line_item(),
				])]),
		])
	}
	return var_product_references.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_HandlerRegistry) get_recent_product_ids_query() rt.PhpVal {
	mut var_recent_product_ids := rt.call_function('wc_get_products', [
		rt.create_array([rt.ArrayItem{ key: 'status', val: 'publish' },
			rt.ArrayItem{ key: 'orderby', val: 'date' }, rt.ArrayItem{ key: 'order', val: 'DESC' },
			rt.ArrayItem{ key: 'limit', val: 10 }, rt.ArrayItem{ key: 'return', val: 'ids' }]),
	])
	return rt.create_array([
		rt.ArrayItem{
			key: 'post__in'
			val: if !(!rt.is_true(var_recent_product_ids)) { var_recent_product_ids } else { rt.create_array([
					rt.ArrayItem{ key: none, val: -1 },
				]) }
		},
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_HandlerRegistry) get_cart_product_ids(var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(var_request) {
		mut var_recent_product_ids := rt.call_function('wc_get_products', [
			rt.create_array([rt.ArrayItem{ key: 'status', val: 'publish' },
				rt.ArrayItem{ key: 'orderby', val: 'date' }, rt.ArrayItem{ key: 'order', val: 'DESC' },
				rt.ArrayItem{ key: 'limit', val: 3 }, rt.ArrayItem{ key: 'return', val: 'ids' }]),
		])
		return if !(!rt.is_true(var_recent_product_ids)) {
			var_recent_product_ids
		} else {
			rt.new_array()
		}
	}
	return rt.new_array()
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_handlerregistry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_HandlerRegistry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_HandlerRegistry{
		PhpObjectBase:            rt.PhpObjectBase{}
		collection_handler_store: rt.new_array()
	}
	return obj
}

fn create_invalidargumentexception(_args ...rt.PhpVal) &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_HandlerRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_collection_handlers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.register_collection_handlers(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'register_core_collections' {
			return this.register_core_collections()
		}
		'get_collection_handler' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_collection_handler(dispatch_arg_0)
		}
		'unregister_collection_handlers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.unregister_collection_handlers(dispatch_arg_0)
			return rt.new_null()
		}
		'get_product_ids_from_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_ids_from_order(dispatch_arg_0)
		}
		'get_recent_product_ids_query' {
			return this.get_recent_product_ids_query()
		}
		'get_cart_product_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_cart_product_ids(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_HandlerRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'collection_handler_store' { return this.collection_handler_store }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_HandlerRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'collection_handler_store' {
			this.collection_handler_store = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
