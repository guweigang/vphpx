import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypesController {
	rt.PhpObjectBase
pub mut:
		asset_api rt.PhpVal = rt.new_null()
		asset_data_registry rt.PhpVal = rt.new_null()
		registered_blocks_with_woocommerce_parents rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) construct(mut var_asset_api Class_Automattic_WooCommerce_Blocks_Assets_Api, mut var_asset_data_registry Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) {
	this.asset_api = var_asset_api
	this.asset_data_registry = var_asset_data_registry
	this.init()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) init() {
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_blocks' }])])
	rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_block_patterns' }])])
	rt.call_function('add_filter', [rt.new_string('block_categories_all'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_block_categories' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('render_block'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_data_attributes' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_login_form_end'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'redirect_to_field' }])])
	rt.call_function('add_filter', [rt.new_string('widget_types_to_hide_from_legacy_widget_block'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'hide_legacy_widgets_with_block_equivalent' }])])
	rt.call_function('add_filter', [rt.new_string('register_block_type_args'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enqueue_block_style_for_classic_themes' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('block_core_breadcrumbs_post_type_settings'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'set_product_breadcrumbs_preferred_taxonomy' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('block_core_breadcrumbs_items'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'apply_woocommerce_breadcrumb_filters' }]), rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) get_registered_blocks_with_woocommerce_parent() rt.PhpVal {
	if rt.is_true(rt.call_function('did_action', [rt.new_string('init')])) && !(!rt.is_true(this.registered_blocks_with_woocommerce_parents)) {
		return this.registered_blocks_with_woocommerce_parents
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_WP_Block_Type_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	mut var_registered_blocks := rt.call_method(iife_result_0, 'get_all_registered', []rt.PhpVal{})
	if !(var_registered_blocks.clone().is_array()) {
		return rt.new_array()
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_block := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !rt.is_true(rt.get_property(var_block, 'parent')) {
			return rt.new_bool(false)
		}
		if !(rt.get_property(var_block, 'parent').is_array()) {
			rt.set_property(var_block, 'parent', rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_block, 'parent') }]))
		}
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_parent_block_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.identical(rt.new_string('woocommerce'), rt.call_function('strtok', [var_parent_block_name.clone(), rt.new_string('/')]))
			}
		mut var_woocommerce_blocks := rt.call_function('array_filter', [rt.get_property(var_block, 'parent'), rt.new_closure(closure_3_fn)])
		return rt.new_bool(!(!rt.is_true(var_woocommerce_blocks)))
		}
	this.registered_blocks_with_woocommerce_parents = rt.call_function('array_filter', [var_registered_blocks.clone(), rt.new_closure(closure_3_fn)])
	return this.registered_blocks_with_woocommerce_parents
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) register_blocks() {
	this.register_block_metadata()
	mut var_block_types := this.get_block_types()
	mut iter_1 := var_block_types.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_block_type := item_1.val
		mut var_block_type_class := rt.new_string('Automattic\\WooCommerce\\Blocks' + '\\BlockTypes\\' + (var_block_type).str())
		rt.create_object_dynamically(var_block_type_class, [this.asset_api, this.asset_data_registry, create_automattic_woocommerce_blocks_integrations_integrationregistry()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) register_block_metadata() {
	mut var_meta_file_path := rt.new_string((rt.get_constant('WC_ABSPATH')).str() + 'assets/client/blocks/blocks-json.php')
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_register_block_metadata_collection')])) && rt.is_true(rt.call_function('file_exists', [var_meta_file_path.clone()])) {
		rt.call_function('add_filter', [rt.new_string('doing_it_wrong_trigger_error'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'bypass_block_metadata_doing_it_wrong' }]), rt.new_int(10), rt.new_int(4)])
		rt.call_function('wp_register_block_metadata_collection', [rt.new_string((rt.get_constant('WC_ABSPATH')).str() + 'assets/client/blocks/'), var_meta_file_path.clone()])
		rt.call_function('remove_filter', [rt.new_string('doing_it_wrong_trigger_error'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'bypass_block_metadata_doing_it_wrong' }]), rt.new_int(10)])
	}
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypesController.bypass_block_metadata_doing_it_wrong(var_trigger rt.PhpVal, var_function rt.PhpVal, var_message rt.PhpVal, var_version rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_string('WP_Block_Metadata_Registry::register_collection'), var_function)) {
		return false
	}
	return (var_trigger).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) register_block_patterns() {
	rt.call_function('register_block_pattern', [rt.new_string('woocommerce/order-confirmation-totals-heading'), rt.create_array([rt.ArrayItem{ key: 'title', val: '' }, rt.ArrayItem{ key: 'inserter', val: false }, rt.ArrayItem{ key: 'content', val: '<!-- wp:heading {"level":2,"style":{"typography":{"fontSize":"24px"}}} --><h2 class="wp-block-heading" style="font-size:24px">' + (rt.call_function('esc_html__', [rt.new_string('Order details'), rt.new_string('woocommerce')])).str() + '</h2><!-- /wp:heading -->' }])])
	rt.call_function('register_block_pattern', [rt.new_string('woocommerce/order-confirmation-downloads-heading'), rt.create_array([rt.ArrayItem{ key: 'title', val: '' }, rt.ArrayItem{ key: 'inserter', val: false }, rt.ArrayItem{ key: 'content', val: '<!-- wp:heading {"level":2,"style":{"typography":{"fontSize":"24px"}}} --><h2 class="wp-block-heading" style="font-size:24px">' + (rt.call_function('esc_html__', [rt.new_string('Downloads'), rt.new_string('woocommerce')])).str() + '</h2><!-- /wp:heading -->' }])])
	rt.call_function('register_block_pattern', [rt.new_string('woocommerce/order-confirmation-shipping-heading'), rt.create_array([rt.ArrayItem{ key: 'title', val: '' }, rt.ArrayItem{ key: 'inserter', val: false }, rt.ArrayItem{ key: 'content', val: '<!-- wp:heading {"level":2,"style":{"typography":{"fontSize":"24px"}}} --><h2 class="wp-block-heading" style="font-size:24px">' + (rt.call_function('esc_html__', [rt.new_string('Shipping address'), rt.new_string('woocommerce')])).str() + '</h2><!-- /wp:heading -->' }])])
	rt.call_function('register_block_pattern', [rt.new_string('woocommerce/order-confirmation-billing-heading'), rt.create_array([rt.ArrayItem{ key: 'title', val: '' }, rt.ArrayItem{ key: 'inserter', val: false }, rt.ArrayItem{ key: 'content', val: '<!-- wp:heading {"level":2,"style":{"typography":{"fontSize":"24px"}}} --><h2 class="wp-block-heading" style="font-size:24px">' + (rt.call_function('esc_html__', [rt.new_string('Billing address'), rt.new_string('woocommerce')])).str() + '</h2><!-- /wp:heading -->' }])])
	rt.call_function('register_block_pattern', [rt.new_string('woocommerce/order-confirmation-additional-fields-heading'), rt.create_array([rt.ArrayItem{ key: 'title', val: '' }, rt.ArrayItem{ key: 'inserter', val: false }, rt.ArrayItem{ key: 'content', val: '<!-- wp:heading {"level":2,"style":{"typography":{"fontSize":"24px"}}} --><h2 class="wp-block-heading" style="font-size:24px">' + (rt.call_function('esc_html__', [rt.new_string('Additional information'), rt.new_string('woocommerce')])).str() + '</h2><!-- /wp:heading -->' }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) register_block_categories(var_categories rt.PhpVal) rt.PhpVal {
	mut var_woocommerce_block_categories := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'woocommerce' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('WooCommerce'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'woocommerce-product-elements' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('WooCommerce Product Elements'), rt.new_string('woocommerce')]) }]) }])
	return rt.call_function('array_merge', [var_categories.clone(), var_woocommerce_block_categories.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) block_should_have_data_attributes(var_block_name rt.PhpVal) bool {
	mut var_block_namespace := rt.call_function('strtok', [if !(var_block_name).is_null() { var_block_name } else { rt.new_string('') }, rt.new_string('/')])
	mut var_allowed_namespaces := rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce' }, rt.ArrayItem{ key: none, val: 'woocommerce-checkout' }]), rt.cast_array(rt.call_function('apply_filters', [rt.new_string('__experimental_woocommerce_blocks_add_data_attributes_to_namespace'), rt.new_array()]))])
	mut var_allowed_blocks := rt.cast_array(rt.call_function('apply_filters', [rt.new_string('__experimental_woocommerce_blocks_add_data_attributes_to_block'), rt.new_array()]))
	mut var_blocks_with_woo_parents := this.get_registered_blocks_with_woocommerce_parent()
	mut var_block_has_woo_parent := rt.call_function('in_array', [var_block_name.clone(), rt.func_array_keys(var_blocks_with_woo_parents.clone()), rt.new_bool(true)])
	mut var_in_allowed_namespace_list := rt.call_function('in_array', [var_block_namespace.clone(), var_allowed_namespaces.clone(), rt.new_bool(true)])
	mut var_in_allowed_block_list := rt.call_function('in_array', [var_block_name.clone(), var_allowed_blocks.clone(), rt.new_bool(true)])
	return rt.is_true(var_block_has_woo_parent) || rt.is_true(var_in_allowed_block_list) || rt.is_true(var_in_allowed_namespace_list)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) add_data_attributes(var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	if !(var_content.clone().is_string()) || !(this.block_should_have_data_attributes(var_block.array_get(rt.new_string('blockName')))) {
		return var_content.clone()
	}
	mut var_attributes := rt.cast_array(var_block.array_get(rt.new_string('attrs')))
	mut var_exclude_attributes := rt.create_array([rt.ArrayItem{ key: none, val: 'className' }, rt.ArrayItem{ key: none, val: 'align' }])
	mut var_processor := create_automattic_woocommerce_blocks_wp_html_tag_processor(var_content.clone())
	if rt.is_true(rt.identical(rt.new_bool(false), var_processor.next_tag())) || rt.is_true(var_processor.is_tag_closer()) {
		return var_content.clone()
	}
	mut iter_2 := var_attributes.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_key := item_2.key
		if !(var_key.clone().is_string()) || rt.is_true(rt.call_function('in_array', [var_key.clone(), var_exclude_attributes.clone(), rt.new_bool(true)])) {
			continue
		}
		if rt.is_true(rt.new_bool(var_value.clone().is_bool())) {
		var_value = rt.new_string((if rt.is_true(var_value) { 'true' } else { 'false' }).str())
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_value.clone()]))))) {
		var_value = rt.call_function('wp_json_encode', [var_value.clone()])
		}
		var_key = rt.new_string(rt.call_function('preg_replace', [rt.new_string('/(?<!^|\\ )[A-Z]/'), rt.new_string('-$0'), var_key.clone()]).to_string().to_lower())
		var_processor.set_attribute(rt.new_string("data-${var_key.to_string()}"), var_value.clone())
	}
	var_processor.set_attribute(rt.new_string('data-block-name'), var_block.array_get(rt.new_string('blockName')))
	return var_processor.get_updated_html()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) redirect_to_field() {
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('redirect_to'))) {
		return
	}
	print('<input type="hidden" name="redirect" value="' + (rt.call_function('esc_attr', [rt.call_function('esc_url_raw', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('redirect_to'))])])])).str() + '" />')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) hide_legacy_widgets_with_block_equivalent(var_widget_types rt.PhpVal) rt.PhpVal {
	var_widget_types.clone().array_push(rt.new_string('woocommerce_product_search'))
	return var_widget_types.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) delete_product_transients() {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD), rt.new_string('10.6.0')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) get_widget_area_block_types() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'AllReviews' }, rt.ArrayItem{ key: none, val: 'Breadcrumbs' }, rt.ArrayItem{ key: none, val: 'CartLink' }, rt.ArrayItem{ key: none, val: 'CatalogSorting' }, rt.ArrayItem{ key: none, val: 'ClassicShortcode' }, rt.ArrayItem{ key: none, val: 'CustomerAccount' }, rt.ArrayItem{ key: none, val: 'FeaturedCategory' }, rt.ArrayItem{ key: none, val: 'FeaturedProduct' }, rt.ArrayItem{ key: none, val: 'MiniCart' }, rt.ArrayItem{ key: none, val: 'ProductCategories' }, rt.ArrayItem{ key: none, val: 'ProductResultsCount' }, rt.ArrayItem{ key: none, val: 'ProductSearch' }, rt.ArrayItem{ key: none, val: 'ReviewsByCategory' }, rt.ArrayItem{ key: none, val: 'ReviewsByProduct' }, rt.ArrayItem{ key: none, val: 'ProductFilters' }, rt.ArrayItem{ key: none, val: 'ProductFilterStatus' }, rt.ArrayItem{ key: none, val: 'ProductFilterPrice' }, rt.ArrayItem{ key: none, val: 'ProductFilterPriceSlider' }, rt.ArrayItem{ key: none, val: 'ProductFilterAttribute' }, rt.ArrayItem{ key: none, val: 'ProductFilterRating' }, rt.ArrayItem{ key: none, val: 'ProductFilterActive' }, rt.ArrayItem{ key: none, val: 'ProductFilterRemovableChips' }, rt.ArrayItem{ key: none, val: 'ProductFilterClearButton' }, rt.ArrayItem{ key: none, val: 'ProductFilterCheckboxList' }, rt.ArrayItem{ key: none, val: 'ProductFilterChips' }, rt.ArrayItem{ key: none, val: 'ProductFilterTaxonomy' }, rt.ArrayItem{ key: none, val: 'ActiveFilters' }, rt.ArrayItem{ key: none, val: 'AttributeFilter' }, rt.ArrayItem{ key: none, val: 'FilterWrapper' }, rt.ArrayItem{ key: none, val: 'PriceFilter' }, rt.ArrayItem{ key: none, val: 'RatingFilter' }, rt.ArrayItem{ key: none, val: 'StockFilter' }, rt.ArrayItem{ key: none, val: 'HandpickedProducts' }, rt.ArrayItem{ key: none, val: 'ProductBestSellers' }, rt.ArrayItem{ key: none, val: 'ProductNew' }, rt.ArrayItem{ key: none, val: 'ProductOnSale' }, rt.ArrayItem{ key: none, val: 'ProductTopRated' }, rt.ArrayItem{ key: none, val: 'ProductsByAttribute' }, rt.ArrayItem{ key: none, val: 'ProductCategory' }, rt.ArrayItem{ key: none, val: 'ProductTag' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) get_block_types() rt.PhpVal {
	mut var_pagenow := rt.new_null()
	mut var_block_types := rt.create_array([rt.ArrayItem{ key: none, val: 'ActiveFilters' }, rt.ArrayItem{ key: none, val: 'AddToCartForm' }, rt.ArrayItem{ key: none, val: 'AllProducts' }, rt.ArrayItem{ key: none, val: 'AllReviews' }, rt.ArrayItem{ key: none, val: 'AttributeFilter' }, rt.ArrayItem{ key: none, val: 'Breadcrumbs' }, rt.ArrayItem{ key: none, val: 'CartLink' }, rt.ArrayItem{ key: none, val: 'CatalogSorting' }, rt.ArrayItem{ key: none, val: 'CategoryTitle' }, rt.ArrayItem{ key: none, val: 'CategoryDescription' }, rt.ArrayItem{ key: none, val: 'ClassicTemplate' }, rt.ArrayItem{ key: none, val: 'ClassicShortcode' }, rt.ArrayItem{ key: none, val: 'ComingSoon' }, rt.ArrayItem{ key: none, val: 'CouponCode' }, rt.ArrayItem{ key: none, val: 'CustomerAccount' }, rt.ArrayItem{ key: none, val: 'EmailContent' }, rt.ArrayItem{ key: none, val: 'FeaturedCategory' }, rt.ArrayItem{ key: none, val: 'FeaturedProduct' }, rt.ArrayItem{ key: none, val: 'FilterWrapper' }, rt.ArrayItem{ key: none, val: 'HandpickedProducts' }, rt.ArrayItem{ key: none, val: 'MiniCart' }, rt.ArrayItem{ key: none, val: 'NextPreviousButtons' }, rt.ArrayItem{ key: none, val: 'StoreNotices' }, rt.ArrayItem{ key: none, val: 'PaymentMethodIcons' }, rt.ArrayItem{ key: none, val: 'PriceFilter' }, rt.ArrayItem{ key: none, val: 'ProductBestSellers' }, rt.ArrayItem{ key: none, val: 'ProductButton' }, rt.ArrayItem{ key: none, val: 'ProductCategories' }, rt.ArrayItem{ key: none, val: 'ProductCategory' }, rt.ArrayItem{ key: none, val: 'ProductCollection\\Controller' }, rt.ArrayItem{ key: none, val: 'ProductCollection\\NoResults' }, rt.ArrayItem{ key: none, val: 'ProductFilters' }, rt.ArrayItem{ key: none, val: 'ProductFilterStatus' }, rt.ArrayItem{ key: none, val: 'ProductFilterPrice' }, rt.ArrayItem{ key: none, val: 'ProductFilterPriceSlider' }, rt.ArrayItem{ key: none, val: 'ProductFilterAttribute' }, rt.ArrayItem{ key: none, val: 'ProductFilterRating' }, rt.ArrayItem{ key: none, val: 'ProductFilterActive' }, rt.ArrayItem{ key: none, val: 'ProductFilterRemovableChips' }, rt.ArrayItem{ key: none, val: 'ProductFilterClearButton' }, rt.ArrayItem{ key: none, val: 'ProductFilterCheckboxList' }, rt.ArrayItem{ key: none, val: 'ProductFilterChips' }, rt.ArrayItem{ key: none, val: 'ProductFilterTaxonomy' }, rt.ArrayItem{ key: none, val: 'ProductGallery' }, rt.ArrayItem{ key: none, val: 'ProductGalleryLargeImage' }, rt.ArrayItem{ key: none, val: 'ProductGalleryThumbnails' }, rt.ArrayItem{ key: none, val: 'ProductImage' }, rt.ArrayItem{ key: none, val: 'ProductImageGallery' }, rt.ArrayItem{ key: none, val: 'ProductMeta' }, rt.ArrayItem{ key: none, val: 'ProductNew' }, rt.ArrayItem{ key: none, val: 'ProductOnSale' }, rt.ArrayItem{ key: none, val: 'ProductPrice' }, rt.ArrayItem{ key: none, val: 'ProductTemplate' }, rt.ArrayItem{ key: none, val: 'ProductQuery' }, rt.ArrayItem{ key: none, val: 'ProductAverageRating' }, rt.ArrayItem{ key: none, val: 'ProductRating' }, rt.ArrayItem{ key: none, val: 'ProductRatingCounter' }, rt.ArrayItem{ key: none, val: 'ProductRatingStars' }, rt.ArrayItem{ key: none, val: 'ProductResultsCount' }, rt.ArrayItem{ key: none, val: 'ProductSaleBadge' }, rt.ArrayItem{ key: none, val: 'ProductSearch' }, rt.ArrayItem{ key: none, val: 'ProductSKU' }, rt.ArrayItem{ key: none, val: 'ProductStockIndicator' }, rt.ArrayItem{ key: none, val: 'ProductSummary' }, rt.ArrayItem{ key: none, val: 'ProductTag' }, rt.ArrayItem{ key: none, val: 'ProductTitle' }, rt.ArrayItem{ key: none, val: 'ProductTopRated' }, rt.ArrayItem{ key: none, val: 'ProductsByAttribute' }, rt.ArrayItem{ key: none, val: 'RatingFilter' }, rt.ArrayItem{ key: none, val: 'ReviewsByCategory' }, rt.ArrayItem{ key: none, val: 'ReviewsByProduct' }, rt.ArrayItem{ key: none, val: 'RelatedProducts' }, rt.ArrayItem{ key: none, val: 'SingleProduct' }, rt.ArrayItem{ key: none, val: 'StockFilter' }, rt.ArrayItem{ key: none, val: 'PageContentWrapper' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\Status' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\Summary' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\Totals' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\TotalsWrapper' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\Downloads' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\DownloadsWrapper' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\BillingAddress' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\ShippingAddress' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\BillingWrapper' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\ShippingWrapper' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\AdditionalInformation' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\AdditionalFieldsWrapper' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\AdditionalFields' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\CreateAccount' }, rt.ArrayItem{ key: none, val: 'ProductDetails' }, rt.ArrayItem{ key: none, val: 'ProductDescription' }, rt.ArrayItem{ key: none, val: 'ProductSpecifications' }, rt.ArrayItem{ key: none, val: 'Accordion\\AccordionGroup' }, rt.ArrayItem{ key: none, val: 'Accordion\\AccordionItem' }, rt.ArrayItem{ key: none, val: 'Accordion\\AccordionPanel' }, rt.ArrayItem{ key: none, val: 'Accordion\\AccordionHeader' }, rt.ArrayItem{ key: none, val: 'Reviews\\ProductReviews' }, rt.ArrayItem{ key: none, val: 'Reviews\\ProductReviewRating' }, rt.ArrayItem{ key: none, val: 'Reviews\\ProductReviewsTitle' }, rt.ArrayItem{ key: none, val: 'Reviews\\ProductReviewForm' }, rt.ArrayItem{ key: none, val: 'Reviews\\ProductReviewDate' }, rt.ArrayItem{ key: none, val: 'Reviews\\ProductReviewContent' }, rt.ArrayItem{ key: none, val: 'Reviews\\ProductReviewAuthorName' }, rt.ArrayItem{ key: none, val: 'Reviews\\ProductReviewsPagination' }, rt.ArrayItem{ key: none, val: 'Reviews\\ProductReviewsPaginationNext' }, rt.ArrayItem{ key: none, val: 'Reviews\\ProductReviewsPaginationPrevious' }, rt.ArrayItem{ key: none, val: 'Reviews\\ProductReviewsPaginationNumbers' }, rt.ArrayItem{ key: none, val: 'Reviews\\ProductReviewTemplate' }])
	mut iife_temp_3 := Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart{}
	mut iife_result_3 := iife_temp_3.get_cart_block_types()
	mut iife_temp_4 := Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout{}
	mut iife_result_4 := iife_temp_4.get_checkout_block_types()
	mut iife_temp_5 := Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents{}
	mut iife_result_5 := iife_temp_5.get_mini_cart_block_types()
	var_block_types = rt.call_function('array_merge', [var_block_types.clone(), iife_result_3, iife_result_4, iife_result_5])
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		var_block_types.array_push('AddToCartWithOptions\\AddToCartWithOptions')
		var_block_types.array_push('AddToCartWithOptions\\QuantitySelector')
		var_block_types.array_push('AddToCartWithOptions\\VariationDescription')
		var_block_types.array_push('AddToCartWithOptions\\VariationSelector')
		var_block_types.array_push('AddToCartWithOptions\\VariationSelectorAttribute')
		var_block_types.array_push('AddToCartWithOptions\\VariationSelectorAttributeName')
		var_block_types.array_push('AddToCartWithOptions\\VariationSelectorAttributeOptions')
		var_block_types.array_push('AddToCartWithOptions\\GroupedProductSelector')
		var_block_types.array_push('AddToCartWithOptions\\GroupedProductItem')
		var_block_types.array_push('AddToCartWithOptions\\GroupedProductItemSelector')
		var_block_types.array_push('AddToCartWithOptions\\GroupedProductItemLabel')
	}
	if rt.is_true(rt.call_function('in_array', [var_pagenow.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'widgets.php' }, rt.ArrayItem{ key: none, val: 'themes.php' }, rt.ArrayItem{ key: none, val: 'customize.php' }]), rt.new_bool(true)])) && !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('page'))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('gutenberg-edit-site'), rt.get_superglobal('_GET').array_get(rt.new_string('page')))))) {
	var_block_types = rt.call_function('array_intersect', [var_block_types.clone(), this.get_widget_area_block_types()])
	}
	if rt.is_true(rt.call_function('in_array', [var_pagenow.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'post.php' }, rt.ArrayItem{ key: none, val: 'post-new.php' }]), rt.new_bool(true)])) {
	var_block_types = rt.call_function('array_diff', [var_block_types.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'Breadcrumbs' }, rt.ArrayItem{ key: none, val: 'CatalogSorting' }, rt.ArrayItem{ key: none, val: 'ClassicTemplate' }, rt.ArrayItem{ key: none, val: 'ProductResultsCount' }, rt.ArrayItem{ key: none, val: 'ProductReviews' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\Status' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\Summary' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\Totals' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\TotalsWrapper' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\Downloads' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\DownloadsWrapper' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\BillingAddress' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\ShippingAddress' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\BillingWrapper' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\ShippingWrapper' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\AdditionalInformation' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\AdditionalFieldsWrapper' }, rt.ArrayItem{ key: none, val: 'OrderConfirmation\\AdditionalFields' }])])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_block_types'), var_block_types.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) enqueue_block_style_for_classic_themes(var_args rt.PhpVal, var_block_name rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_should_enqueue_block_style_for_classic_themes := rt.new_null()
	if rt.is_true(rt.identical(rt.new_null(), var_should_enqueue_block_style_for_classic_themes)) {
	var_should_enqueue_block_style_for_classic_themes = rt.new_bool(!((rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) || rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) || (rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_should_load_block_assets_on_demand')])) && rt.is_true(rt.call_function('wp_should_load_block_assets_on_demand', []rt.PhpVal{})))) || rt.is_true(rt.call_function('wp_should_load_separate_core_block_assets', []rt.PhpVal{}))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_should_enqueue_block_style_for_classic_themes)))) {
		rt.call_function('remove_filter', [rt.new_string('register_block_type_args'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enqueue_block_style_for_classic_themes' }]), rt.new_int(10)])
		return var_args_mutated.clone()
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_block_name.clone(), rt.new_string('woocommerce/')]))) || (!rt.is_true(var_args_mutated.array_get(rt.new_string('style_handles'))) && !rt.is_true(var_args_mutated.array_get(rt.new_string('style')))) {
		return var_args_mutated.clone()
	}
	mut var_style_handlers := if !(var_args_mutated.array_get(rt.new_string('style_handles'))).is_null() { var_args_mutated.array_get(rt.new_string('style_handles')) } else { var_args_mutated.array_get(rt.new_string('style')) }
	closure_7_fn := fn [var_style_handlers] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_html := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		rt.call_function('array_map', [rt.new_string('wp_enqueue_style'), var_style_handlers.clone()])
		return var_html.clone()
		}
	rt.call_function('add_filter', [rt.new_string('render_block_' + (var_block_name).str()), rt.new_closure(closure_7_fn), rt.new_int(10)])
	var_args_mutated.array_set('style_handles', rt.new_array())
	var_args_mutated.array_set('style', rt.new_array())
	return var_args_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) set_product_breadcrumbs_preferred_taxonomy(var_settings rt.PhpVal, var_post_type rt.PhpVal, post_id i64) rt.PhpVal {
	mut var_settings_mutated := var_settings
	if !(var_settings_mutated.clone().is_array()) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), var_post_type)))) {
		return var_settings_mutated.clone()
	}
	var_settings_mutated.array_set('taxonomy', 'product_cat')
	if !(post_id == 0) {
		mut var_terms := rt.call_function('wc_get_product_terms', [rt.new_int(post_id), rt.new_string('product_cat'), rt.call_function('apply_filters', [rt.new_string('woocommerce_breadcrumb_product_terms_args'), rt.create_array([rt.ArrayItem{ key: 'orderby', val: 'parent' }, rt.ArrayItem{ key: 'order', val: 'DESC' }])])])
		if !(!rt.is_true(var_terms)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_terms.clone()]))))) {
			mut var_main_term := rt.call_function('apply_filters', [rt.new_string('woocommerce_breadcrumb_main_term'), var_terms.array_get(rt.new_int(0)), var_terms.clone()])
			if rt.is_true(rt.new_bool(rt.instance_of(var_main_term, 'Automattic_WooCommerce_Blocks_WP_Term'))) {
				var_settings_mutated.array_set('term', rt.get_property(var_main_term, 'slug'))
			}
		}
	}
	return var_settings_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) apply_woocommerce_breadcrumb_filters(var_items rt.PhpVal) rt.PhpVal {
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.create_array([rt.ArrayItem{ key: none, val: if !(var_item.array_get(rt.new_string('label'))).is_null() { var_item.array_get(rt.new_string('label')) } else { rt.new_string('') } }, rt.ArrayItem{ key: none, val: if !(var_item.array_get(rt.new_string('url'))).is_null() { var_item.array_get(rt.new_string('url')) } else { rt.new_string('') } }])
		}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.create_array([rt.ArrayItem{ key: none, val: if !(var_item.array_get(rt.new_string('label'))).is_null() { var_item.array_get(rt.new_string('label')) } else { rt.new_string('') } }, rt.ArrayItem{ key: none, val: if !(var_item.array_get(rt.new_string('url'))).is_null() { var_item.array_get(rt.new_string('url')) } else { rt.new_string('') } }])
		}
	mut var_wc_crumbs := rt.call_function('array_map', [rt.new_closure(closure_8_fn), var_items.clone()])
	var_wc_crumbs = rt.call_function('apply_filters', [rt.new_string('woocommerce_get_breadcrumb'), var_wc_crumbs.clone(), rt.new_null()])
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_crumb := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.create_array([rt.ArrayItem{ key: 'label', val: if !(var_crumb.array_get(rt.new_int(0))).is_null() { var_crumb.array_get(rt.new_int(0)) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'url', val: if !(var_crumb.array_get(rt.new_int(1))).is_null() { var_crumb.array_get(rt.new_int(1)) } else { rt.new_string('') } }])
		}
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_crumb := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.create_array([rt.ArrayItem{ key: 'label', val: if !(var_crumb.array_get(rt.new_int(0))).is_null() { var_crumb.array_get(rt.new_int(0)) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'url', val: if !(var_crumb.array_get(rt.new_int(1))).is_null() { var_crumb.array_get(rt.new_int(1)) } else { rt.new_string('') } }])
		}
	return rt.call_function('array_map', [rt.new_closure(closure_10_fn), var_wc_crumbs.clone()])
}

struct Class_Automattic_WooCommerce_Blocks_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypescontroller(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypesController {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypesController{
		PhpObjectBase: rt.PhpObjectBase{}
		asset_api: rt.new_null()
		asset_data_registry: rt.new_null()
		registered_blocks_with_woocommerce_parents: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_blocks_wp_block_type_registry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_WP_Block_Type_Registry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_integrations_integrationregistry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_wp_html_tag_processor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_Blocks_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_cart(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_checkout(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_minicartcontents(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Assets_Api](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_registered_blocks_with_woocommerce_parent' {
			return this.get_registered_blocks_with_woocommerce_parent()
		}
		'register_blocks' {
			this.register_blocks()
			return rt.new_null()
		}
		'register_block_metadata' {
			this.register_block_metadata()
			return rt.new_null()
		}
		'bypass_block_metadata_doing_it_wrong' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_BlockTypesController.bypass_block_metadata_doing_it_wrong(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'register_block_patterns' {
			this.register_block_patterns()
			return rt.new_null()
		}
		'register_block_categories' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_block_categories(dispatch_arg_0)
		}
		'block_should_have_data_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.block_should_have_data_attributes(dispatch_arg_0))
		}
		'add_data_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_data_attributes(dispatch_arg_0, dispatch_arg_1)
		}
		'redirect_to_field' {
			this.redirect_to_field()
			return rt.new_null()
		}
		'hide_legacy_widgets_with_block_equivalent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.hide_legacy_widgets_with_block_equivalent(dispatch_arg_0)
		}
		'delete_product_transients' {
			this.delete_product_transients()
			return rt.new_null()
		}
		'get_widget_area_block_types' {
			return this.get_widget_area_block_types()
		}
		'get_block_types' {
			return this.get_block_types()
		}
		'enqueue_block_style_for_classic_themes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.enqueue_block_style_for_classic_themes(dispatch_arg_0, dispatch_arg_1)
		}
		'set_product_breadcrumbs_preferred_taxonomy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.set_product_breadcrumbs_preferred_taxonomy(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'apply_woocommerce_breadcrumb_filters' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.apply_woocommerce_breadcrumb_filters(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypesController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'asset_api' { return this.asset_api }
		'asset_data_registry' { return this.asset_data_registry }
		'registered_blocks_with_woocommerce_parents' { return this.registered_blocks_with_woocommerce_parents }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypesController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'asset_api' { this.asset_api = val; return true }
		'asset_data_registry' { this.asset_data_registry = val; return true }
		'registered_blocks_with_woocommerce_parents' { this.registered_blocks_with_woocommerce_parents = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Blocks_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Blocks_BlockTypesController', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		c_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		obj := create_automattic_woocommerce_blocks_blocktypescontroller(c_arg_0, c_arg_1)
		return rt.new_object('Automattic_WooCommerce_Blocks_BlockTypesController', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Blocks_WP_Block_Type_Registry', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_blocks_wp_block_type_registry()
		return rt.new_object('Automattic_WooCommerce_Blocks_WP_Block_Type_Registry', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_blocks_integrations_integrationregistry()
		return rt.new_object('Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Blocks_WP_HTML_Tag_Processor', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_blocks_wp_html_tag_processor()
		return rt.new_object('Automattic_WooCommerce_Blocks_WP_HTML_Tag_Processor', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Blocks_BlockTypes_Cart', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_blocks_blocktypes_cart()
		return rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Cart', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_blocks_blocktypes_checkout()
		return rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_blocks_blocktypes_minicartcontents()
		return rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
