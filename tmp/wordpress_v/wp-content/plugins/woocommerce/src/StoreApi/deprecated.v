import rt

pub fn init_wp_content_plugins_woocommerce_src_storeapi_deprecated_php() {
	mut var_class_aliases := rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_RouteException.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_Domain_Services_ExtendRestApi.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_SchemaController.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_SchemaController.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_RoutesController.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_RoutesController.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Formatters.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Formatters.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult.class()
			val: Class_Automattic_WooCommerce_Blocks_Payments_PaymentResult.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Payments_PaymentContext.class()
			val: Class_Automattic_WooCommerce_Blocks_Payments_PaymentContext.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractAddressSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_AbstractAddressSchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_AbstractSchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_BillingAddressSchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartCouponSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_CartCouponSchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartExtensionsSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_CartExtensionsSchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartFeeSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_CartFeeSchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartItemSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_CartItemSchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_CartSchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_CartShippingRateSchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_CheckoutSchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ErrorSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_ErrorSchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ImageAttachmentSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_ImageAttachmentSchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderCouponSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_OrderCouponSchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductAttributeSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_ProductAttributeSchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductCategorySchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_ProductCategorySchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductCollectionDataSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_ProductCollectionDataSchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductReviewSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_ProductReviewSchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_ProductSchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ShippingAddressSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_ShippingAddressSchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_TermSchema.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Schemas_TermSchema.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_AbstractCartRoute.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_AbstractRoute.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_AbstractTermsRoute.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Batch.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_Batch.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Cart.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_Cart.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_CartAddItem.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartApplyCoupon.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_CartApplyCoupon.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCoupons.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_CartCoupons.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_CartCouponsByCode.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartExtensions.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_CartExtensions.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartItems.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_CartItems.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartItemsByKey.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_CartItemsByKey.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_CartRemoveCoupon.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveItem.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_CartRemoveItem.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartSelectShippingRate.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_CartSelectShippingRate.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_CartUpdateCustomer.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_CartUpdateItem.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_Checkout.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributes.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_ProductAttributes.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributesById.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_ProductAttributesById.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributeTerms.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_ProductAttributeTerms.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategories.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_ProductCategories.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategoriesById.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_ProductCategoriesById.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_ProductCollectionData.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_ProductReviews.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_Products.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsById.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_ProductsById.class()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductTags.class()
			val: Class_Automattic_WooCommerce_Blocks_StoreApi_Routes_ProductTags.class()
		},
	])
	{
		mut iter_1 := var_class_aliases.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_alias := item_1.val
			mut var_class := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
				var_alias.dup(),
				rt.new_bool(false),
			])))))
			{
				rt.call_function('class_alias', [var_class.dup(),
					var_alias.dup()])
			}
		}
	}
	var_class_aliases = rt.new_null()
}
