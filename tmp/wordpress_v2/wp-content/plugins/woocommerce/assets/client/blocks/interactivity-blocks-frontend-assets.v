import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([
		rt.ArrayItem{ key: 'woocommerce/product-button.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@woocommerce/stores/woocommerce/cart' },
				rt.ArrayItem{ key: none, val: '@woocommerce/stores/woocommerce/products' },
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: '1ced8ea5bb9f2b4dbf13' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/accordion-group.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: '31ee50b44114553de17e' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/add-to-cart-form.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: 'dcf179e72164a8ccb158' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/add-to-cart-with-options.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@woocommerce/stores/store-notices' },
				rt.ArrayItem{ key: none, val: '@woocommerce/stores/woocommerce/cart' },
				rt.ArrayItem{ key: none, val: '@woocommerce/stores/woocommerce/products' },
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: 'fd3e43ffa8edf3835ff7' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/add-to-cart-with-options-grouped-product-selector.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@woocommerce/stores/woocommerce/cart' },
				rt.ArrayItem{ key: none, val: '@woocommerce/stores/woocommerce/products' },
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: 'b3e040ce04faef3dcbe7' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/add-to-cart-with-options-quantity-selector.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: '73d7ea95a57449478d1a' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/add-to-cart-with-options-variation-selector.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@woocommerce/stores/woocommerce/products' },
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: '80cbb50db0e1382d31a5' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/customer-account.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: '4d4c517c6dc2b50c4b86' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-collection.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity-router' },
					rt.ArrayItem{ key: 'import', val: 'dynamic' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: '1c3af84f16844ee28c41' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-filters.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity-router' },
					rt.ArrayItem{ key: 'import', val: 'dynamic' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: '5dd60d0b601ae36f6583' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-filter-active.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: 'ffc033fe231a76d977c5' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-filter-checkbox-list.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: '4f56c4bf1d5c25daf8c8' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-filter-chips.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: '2ea788b5a6bf173d3047' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-filter-price.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: 'f55bbbbfdd3060dde468' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-filter-price-slider.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: 'a098a8093a212aa340bb' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-gallery.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@woocommerce/stores/woocommerce/products' },
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: 'a8988f88e203da326a07' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-gallery-large-image.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: '431217a206ce8f5ce48f' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-reviews.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity-router' },
					rt.ArrayItem{ key: 'import', val: 'dynamic' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: 'a429b25efb7ed01a1dea' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-review-form.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: '2908bd9dae82c5e100c6' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-button-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: 'ec13cd00a2425c496d00' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-stock-indicator-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: 'c02ecf7925f4dc193800' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/accordion-group-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: 'c085ba9f6f5f2c9b79cd' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/add-to-cart-form-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '2e3c2551557826d82041' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/add-to-cart-with-options-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: 'c728e3489098d3720257' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/add-to-cart-with-options-grouped-product-item-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '6a1af2aefc798b713967' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{
			key: 'woocommerce/add-to-cart-with-options-grouped-product-item-selector-style.js'
			val: rt.create_array([
				rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
				rt.ArrayItem{ key: 'version', val: '394f867ecd6700d30edf' },
				rt.ArrayItem{ key: 'type', val: 'module' },
			])
		},
		rt.ArrayItem{
			key: 'woocommerce/add-to-cart-with-options-variation-selector-attribute-name-style.js'
			val: rt.create_array([
				rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
				rt.ArrayItem{ key: 'version', val: 'd26aaea0abb571c2ce66' },
				rt.ArrayItem{ key: 'type', val: 'module' },
			])
		},
		rt.ArrayItem{
			key: 'woocommerce/add-to-cart-with-options-variation-selector-attribute-options-style.js'
			val: rt.create_array([
				rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
				rt.ArrayItem{ key: 'version', val: 'd02fdbdf0326dae54ae0' },
				rt.ArrayItem{ key: 'type', val: 'module' },
			])
		},
		rt.ArrayItem{ key: 'woocommerce/customer-account-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '9ce288c819111562bf89' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-gallery-large-image-next-previous-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '9b21a96e194aa7123d3c' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-collection-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '13ea14a32409df9628c3' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-filters-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: 'd4fc97f4c4733d6de92b' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-filter-attribute-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '9a111aa0faa19a176251' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-filter-checkbox-list-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: 'fea5f1921b9d98909bff' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-filter-chips-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '77f20ead02208288bd09' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-filter-clear-button-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: 'bf43ff2291205e869a00' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-filter-price-slider-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: 'a8ed4f32592deccb0515' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-filter-removable-chips-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '52f4344f25108089a210' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-filter-status-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: 'c512882316c5bfe15758' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-gallery-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '7138d3ff5d67a53fe518' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-review-form-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '4bb5a47ed1e934f3f45d' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-template-style.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '4a55b0f128eb880c582b' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/add-to-cart-form-editor.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '553dd1afa6f9abc3cfa9' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/add-to-cart-with-options-editor.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: 'd91524b7e4a357ca2581' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/customer-account-editor.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: 'c5e309c3058764ac0d97' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/mini-cart-footer-block-editor.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '6e952c4b124637e2a1a0' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-gallery-large-image-next-previous-editor.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '611628de17c076d9c153' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-collection-editor.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: 'cf63363ff8028ae0d288' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-filters-editor.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '4c82bcb732d8a8af9224' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-filter-checkbox-list-editor.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '9831a20f33eafd98381d' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-filter-chips-editor.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '2fe4af4f72b0e3be8f2e' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-gallery-large-image-editor.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: 'c263fe769e5ee74513fb' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-gallery-thumbnails-editor.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '467b728834aa8ff7ac74' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-review-form-editor.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '2e97c0f437091b231576' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-template-editor.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: 'c5fcefab480ba94ae42a' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/mini-cart.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@woocommerce/stores/store-notices' },
				rt.ArrayItem{ key: none, val: '@woocommerce/stores/woocommerce/cart' },
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: 'ec65730555df720c19aa' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: 'woocommerce/product-elements.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@woocommerce/stores/woocommerce/products' },
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: 'e1239db65deb4d90ecb4' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: '@woocommerce/stores/woocommerce/cart.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@woocommerce/stores/store-notices' },
				rt.ArrayItem{ key: none, val: '@woocommerce/stores/woocommerce/products' },
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/a11y' },
					rt.ArrayItem{ key: 'import', val: 'dynamic' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: '6ef41e00d2939992b95c' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: '@woocommerce/stores/store-notices.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: 'c1eae8d5e518e3fbcf40' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: '@woocommerce/stores/woocommerce/products.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
			]) },
			rt.ArrayItem{ key: 'version', val: 'd2328963c7e9ed84708e' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
	])
}
