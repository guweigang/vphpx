import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry.generic_blocks_dir() string {
	return 'product-editor/blocks/generic'
}

pub fn Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry.product_fields_blocks_dir() string {
	return 'product-editor/blocks/product-fields'
}

pub fn Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry.generic_blocks() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce/conditional' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-checkbox-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-collapsible' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-radio-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-pricing-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-section' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-section-description' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-subsection' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-subsection-description' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-details-section-description' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-tab' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-toggle-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-taxonomy-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-text-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-text-area-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-number-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-linked-list-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-select-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-notice-field' }])
}

pub fn Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry.product_fields_blocks() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: 'woocommerce/product-catalog-visibility-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-custom-fields' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-custom-fields-toggle-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-description-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-downloads-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-images-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-inventory-email-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-sku-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-name-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-regular-price-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-sale-price-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-schedule-sale-fields' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-shipping-class-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-shipping-dimensions-fields' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-summary-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-tag-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-inventory-quantity-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-variation-items-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-password-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-list-field' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-has-variations-notice' },
		rt.ArrayItem{ key: none, val: 'woocommerce/product-single-variation-notice' },
	])
}

struct Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_features_productblockeditor_blockregistry() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry',
		'instance', rt.new_null())
}

fn Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry',
		'instance')))))
	{
		rt.set_static_prop('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry',
			'instance', rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_self',
			[]string{}, create_automattic_woocommerce_admin_features_productblockeditor_self()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry',
		'instance')
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry) construct() {
	rt.call_function('add_filter', [rt.new_string('block_categories_all'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_categories' },
		]),
		rt.new_int(10), rt.new_int(2)])
	this.register_product_blocks()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry) get_file_path(var_path rt.PhpVal, var_dir rt.PhpVal) string {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_0 := iife_temp_0.get_path(rt.new_string('js'))
	return (rt.get_constant('WC_ABSPATH')).str() + iife_result_0.str() +
		(rt.call_function('trailingslashit', [var_dir.clone()])).str() + var_path.str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry) register_product_blocks() {
	mut iter_1 :=
		Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry.product_fields_blocks().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_block_name := item_1.val
		this.register_block(var_block_name.clone(),
			Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry.product_fields_blocks_dir())
	}
	mut iter_2 :=
		Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry.generic_blocks().iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_block_name := item_2.val
		this.register_block(var_block_name.clone(),
			Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry.generic_blocks_dir())
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry) register_categories(var_block_categories rt.PhpVal, var_editor_context rt.PhpVal) rt.PhpVal {
	mut var_block_categories_mutated := var_block_categories
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_INIT.editor_context_name(), rt.get_property(var_editor_context,
		'name')))
	{
		var_block_categories_mutated.array_push(rt.create_array([
			rt.ArrayItem{ key: 'slug', val: 'woocommerce' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('WooCommerce'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'icon', val: rt.new_null() },
		]))
	}
	return var_block_categories_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry) remove_block_prefix(var_block_name rt.PhpVal) rt.PhpVal {
	mut var_block_name_mutated := var_block_name
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [
		var_block_name_mutated.clone(), rt.new_string('woocommerce/')])))
	{
		return rt.call_function('substr_replace', [var_block_name_mutated.clone(),
			rt.new_string(''), rt.new_int(0), rt.new_int('woocommerce/'.len)])
	}
	return var_block_name_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry) augment_attributes(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_wp_version := rt.new_null()
	mut var_augmented_attributes := rt.call_function('array_merge', [
		var_attributes.clone(),
		rt.create_array([
			rt.ArrayItem{ key: '_templateBlockId', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'role', val: 'content' },
			]) },
			rt.ArrayItem{ key: '_templateBlockOrder', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'role', val: 'content' },
			]) },
			rt.ArrayItem{ key: '_templateBlockHideConditions', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'role', val: 'content' },
			]) },
			rt.ArrayItem{ key: '_templateBlockDisableConditions', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'role', val: 'content' },
			]) },
			rt.ArrayItem{
				key: 'disabled'
				val: if var_attributes.array_isset(rt.new_string('disabled')) { var_attributes.array_get(rt.new_string('disabled')) } else { rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'role', val: 'content' },
					]) }
			},
		])])
	if !(this.has_role_support()) {
		mut iter_3 := var_augmented_attributes.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_attribute := item_3.val
			mut var_key := item_3.key
			if var_attribute.array_isset(rt.new_string('role')) {
				var_augmented_attributes.array_get_mut(var_key).array_set('__experimentalRole',
					var_attribute.array_get(rt.new_string('role')))
			}
		}
	}
	return var_augmented_attributes.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry) has_role_support() bool {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_Utils_Utils{}
	mut iife_result_1 := iife_temp_1.wp_version_compare(rt.new_string('6.7'), rt.new_string('>='))
	if rt.is_true(iife_result_1) {
		return true
	}
	if rt.is_true(rt.call_function('is_plugin_active', [
		rt.new_string('gutenberg/gutenberg.php'),
	]))
	{
		mut var_gutenberg_version := rt.new_string('')
		if rt.is_true(rt.call_function('defined', [rt.new_string('GUTENBERG_VERSION')])) {
			var_gutenberg_version = rt.get_constant('GUTENBERG_VERSION')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_gutenberg_version)))) {
			mut var_gutenberg_data := rt.call_function('get_file_data', [
				rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/gutenberg/gutenberg.php'),
				rt.create_array([rt.ArrayItem{ key: 'Version', val: 'Version' }]),
			])
			var_gutenberg_version = var_gutenberg_data.array_get(rt.new_string('Version'))
		}
		return (rt.call_function('version_compare', [var_gutenberg_version.clone(),
			rt.new_string('19.4'), rt.new_string('>=')])).to_bool()
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry) augment_uses_context(var_uses_context rt.PhpVal) rt.PhpVal {
	return rt.call_function('array_merge', [if !var_uses_context.is_null() {
		var_uses_context
	} else {
		rt.new_array()
	}, rt.create_array([rt.ArrayItem{ key: none, val: 'postType' }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry) register_block(var_block_name rt.PhpVal, var_block_dir rt.PhpVal) rt.PhpVal {
	mut var_block_name_mutated := var_block_name
	var_block_name_mutated = this.remove_block_prefix(var_block_name_mutated.clone())
	mut var_block_json_file := rt.new_string(this.get_file_path(rt.new_string(
		var_block_name_mutated.str() + '/block.json'), var_block_dir.clone()))
	return rt.new_bool(this.register_block_type_from_metadata(var_block_json_file.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry) is_registered(var_block_name rt.PhpVal) bool {
	mut var_block_name_mutated := var_block_name
	mut iife_temp_2 :=
		Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_WP_Block_Type_Registry{}
	mut iife_result_2 := iife_temp_2.get_instance()
	mut var_registry := iife_result_2
	return (rt.call_method(var_registry, 'is_registered', [var_block_name_mutated.clone()])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry) unregister(var_block_name rt.PhpVal) {
	mut var_block_name_mutated := var_block_name
	mut iife_temp_3 :=
		Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_WP_Block_Type_Registry{}
	mut iife_result_3 := iife_temp_3.get_instance()
	mut var_registry := iife_result_3
	if rt.is_true(rt.call_method(var_registry, 'is_registered', [
		var_block_name_mutated.clone()]))
	{
		rt.call_method(var_registry, 'unregister', [var_block_name_mutated.clone()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry) register_block_type_from_metadata(var_file_or_folder rt.PhpVal) bool {
	mut var_metadata_file := if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_ends_with', [
		var_file_or_folder.clone(),
		rt.new_string('block.json'),
	])))))
	{
		(rt.call_function('trailingslashit', [var_file_or_folder.clone()])).str() + 'block.json'
	} else {
		var_file_or_folder
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_metadata_file.clone()])))))
	{
		return false
	}
	mut var_metadata := rt.call_function('json_decode', [
		rt.call_function('file_get_contents', [var_metadata_file.clone()]),
		rt.new_bool(true),
	])
	if !(var_metadata.clone().is_array())
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_metadata.array_get(rt.new_string('name')))))) {
		return false
	}
	this.unregister(var_metadata.array_get(rt.new_string('name')))
	return (rt.call_function('register_block_type_from_metadata', [
		var_metadata_file.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'attributes', val: this.augment_attributes(if var_metadata.array_isset(rt.new_string('attributes')) {
				var_metadata.array_get(rt.new_string('attributes'))
			} else {
				rt.new_array()
			}) },
			rt.ArrayItem{ key: 'uses_context', val: this.augment_uses_context(if var_metadata.array_isset(rt.new_string('usesContext')) {
				var_metadata.array_get(rt.new_string('usesContext'))
			} else {
				rt.new_array()
			}) },
		])])).to_bool()
}

struct Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_productblockeditor_blockregistry() &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_features_productblockeditor_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_self {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminassets(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_productblockeditor_wp_block_type_registry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_WP_Block_Type_Registry {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_file_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.get_file_path(dispatch_arg_0, dispatch_arg_1))
		}
		'register_product_blocks' {
			this.register_product_blocks()
			return rt.new_null()
		}
		'register_categories' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.register_categories(dispatch_arg_0, dispatch_arg_1)
		}
		'remove_block_prefix' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.remove_block_prefix(dispatch_arg_0)
		}
		'augment_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.augment_attributes(dispatch_arg_0)
		}
		'has_role_support' {
			return rt.new_bool(this.has_role_support())
		}
		'augment_uses_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.augment_uses_context(dispatch_arg_0)
		}
		'register_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.register_block(dispatch_arg_0, dispatch_arg_1)
		}
		'is_registered' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_registered(dispatch_arg_0))
		}
		'unregister' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.unregister(dispatch_arg_0)
			return rt.new_null()
		}
		'register_block_type_from_metadata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.register_block_type_from_metadata(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
