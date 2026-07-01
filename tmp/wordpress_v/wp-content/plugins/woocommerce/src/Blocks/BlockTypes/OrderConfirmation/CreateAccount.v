import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_CreateAccount {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('order-confirmation-create-account')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_CreateAccount) initialize()  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock.initialize()
	if rt.is_true(this.is_feature_enabled()) {
		this.initialize_hooks()
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_CreateAccount) initialize_hooks()  {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_hooked_block_types := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_relative_position := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_anchor_block_type := if args.len > 2 { args[2].dup() } else { rt.new_null() }
	mut var_context := if args.len > 3 { args[3].dup() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_context, 'Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_WP_Block_Template')))))))) {
		return var_hooked_block_types.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [rt.get_property(var_context, 'content'), '<!-- wp:' + (this.get_full_block_name()).str()]))))) {
		var_hooked_block_types.array_push(this.get_full_block_name())
	}
	return var_hooked_block_types.dup()
	}
	rt.call_function('add_filter', [rt.new_string('hooked_block_types'), rt.new_closure(closure_1_fn), rt.new_int(10), rt.new_int(4)])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_parsed_hooked_block := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_hooked_block_type := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_relative_position := if args.len > 2 { args[2].dup() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(rt.new_bool(var_parsed_hooked_block.dup().is_null())))) {
		return var_parsed_hooked_block.dup()
	}
	mut var_site_title_heading := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Create an account with %s'), rt.new_string('woocommerce')]), rt.call_function('wp_specialchars_decode', [rt.call_function('get_option', [rt.new_string('blogname')]), rt.get_constant('ENT_QUOTES')])])
	var_parsed_hooked_block.array_set('innerContent', rt.create_array([rt.ArrayItem{ key: none, val: '<div class="wp-block-woocommerce-order-confirmation-create-account alignwide">\n\t\t\t\t\t<!-- wp:heading {"level":3} -->\n                    <h3 class="wp-block-heading">' + (rt.call_function('esc_html', [var_site_title_heading.dup()])).str() + '</h3>\n\t\t\t\t\t<!-- /wp:heading -->\n\t\t\t\t\t<!-- wp:list {"className":"is-style-checkmark-list"} -->\n\t\t\t\t\t<ul class="wp-block-list is-style-checkmark-list"><!-- wp:list-item -->\n                    <li>' + (rt.call_function('esc_html__', [rt.new_string('Faster future purchases'), rt.new_string('woocommerce')])).str() + '</li>\n                    <!-- /wp:list-item -->\n                    <!-- wp:list-item -->\n                    <li>' + (rt.call_function('esc_html__', [rt.new_string('Securely save payment info'), rt.new_string('woocommerce')])).str() + '</li>\n                    <!-- /wp:list-item -->\n                    <!-- wp:list-item -->\n                    <li>' + (rt.call_function('esc_html__', [rt.new_string('Track orders &amp; view shopping history'), rt.new_string('woocommerce')])).str() + '</li>\n                    <!-- /wp:list-item --></ul>\n                    <!-- /wp:list -->\n                    </div>' }]))
	return var_parsed_hooked_block.dup()
	}
	rt.call_function('add_filter', [rt.new_string('hooked_block_woocommerce/order-confirmation-create-account'), rt.new_closure(closure_2_fn), rt.new_int(10), rt.new_int(4)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_CreateAccount) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	mut var_script := rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-order-confirmation-create-account-block-frontend' }, rt.ArrayItem{ key: 'path', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_CreateAccount', ['Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock'], &this), 'asset_api'), 'get_block_asset_build_path', [rt.new_string('order-confirmation-create-account-frontend')]) }, rt.ArrayItem{ key: 'dependencies', val: rt.new_array() }])
	return if rt.is_true(var_key) { var_script.array_get(var_key) } else { var_script }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_CreateAccount) is_feature_enabled() rt.PhpVal {
	return rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_enable_delayed_account_creation'), rt.new_string('yes')]), rt.new_string('yes'))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_CreateAccount) process_form_post(var_order rt.PhpVal) i64 {
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('create-account')) && rt.get_superglobal('_POST').array_isset(rt.new_string('email')) && rt.get_superglobal('_POST').array_isset(rt.new_string('_wpnonce'))) {
		return 0
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('sanitize_key', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_POST').array_get('_wpnonce')).is_null() { rt.get_superglobal('_POST').array_get('_wpnonce') } else { rt.new_string('') }])]), rt.new_string('wc_create_account')]))))) {
		return (create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_wp_error(rt.new_string('invalid_nonce'), rt.call_function('__', [rt.new_string('Unable to create account. Please try again.'), rt.new_string('woocommerce')]))).to_i64()
	}
	mut var_user_email := rt.call_function('sanitize_email', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('email')])])
	if rt.is_true(rt.call_method(var_order, 'get_customer_id', []rt.PhpVal{})) {
		return (create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_wp_error(rt.new_string('order_already_has_user'), rt.call_function('__', [rt.new_string('This order is already linked to a user account.'), rt.new_string('woocommerce')]))).to_i64()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_wp_error(rt.new_string('email_mismatch'), rt.call_function('__', [rt.new_string('The email address provided does not match the email address on this order.'), rt.new_string('woocommerce')]))).to_i64()
	}
	mut var_generate_password := rt.call_function('filter_var', [rt.call_function('get_option', [rt.new_string('woocommerce_registration_generate_password'), rt.new_string('no')]), rt.get_constant('FILTER_VALIDATE_BOOLEAN')])
	if rt.is_true(var_generate_password) {
		mut var_password := rt.new_string(rt.new_string(''))
		// unsupported statement: Stmt_Nop
	} else {
		var_password = rt.call_function('wp_unslash', [if !(rt.get_superglobal('_POST').array_get('password')).is_null() { rt.get_superglobal('_POST').array_get('password') } else { rt.new_string('') }])
		if !rt.is_true(var_password) || var_password.dup().to_string().len < 8 {
			return (create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_wp_error(rt.new_string('password_too_short'), rt.call_function('__', [rt.new_string('Password must be at least 8 characters.'), rt.new_string('woocommerce')]))).to_i64()
		}
	}
	mut var_customer_id := rt.call_function('wc_create_new_customer', [var_user_email.dup(), rt.new_string(''), var_password.dup(), rt.create_array([rt.ArrayItem{ key: 'first_name', val: rt.call_method(var_order, 'get_billing_first_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'last_name', val: rt.call_method(var_order, 'get_billing_last_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'source', val: 'delayed-account-creation' }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_customer_id.dup()])) {
		return (var_customer_id).to_i64()
	}
	rt.call_method(var_order, 'set_customer_id', [var_customer_id.dup()])
	rt.call_method(var_order, 'save', []rt.PhpVal{})
	mut var_order_controller := create_automattic_woocommerce_storeapi_utilities_ordercontroller()
	var_order_controller.sync_customer_data_with_order(var_order.dup())
	rt.call_function('wc_set_customer_auth_cookie', [var_customer_id.dup()])
	return (var_customer_id).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_CreateAccount) render_content(var_order rt.PhpVal, permission bool, var_attributes rt.PhpVal, content string) string {
	mut content_mutated := content
	if rt.is_true(rt.new_bool(!(var_permission) || rt.is_true(rt.new_bool(!(rt.is_true(this.is_feature_enabled())))))) {
		return ''
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) || rt.is_true(rt.call_function('email_exists', [rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{})])))) {
		return ''
	}
	mut var_result := rt.new_int(this.process_form_post(var_order.dup()))
	mut var_notice := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		var_notice = rt.call_function('wc_print_notice', [rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}), rt.new_string('error'), rt.new_array(), rt.new_bool(true)])
	} else if rt.is_true(var_result) {
		return (this.render_confirmation()).str()
	}
	mut var_processor := create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_wp_html_tag_processor(content_mutated + '<div class="wc-block-order-confirmation-create-account-form-wrapper">' + (var_notice).str() + '<div class="wc-block-order-confirmation-create-account-form"></div>' + '</div>')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_processor.next_tag(rt.create_array([rt.ArrayItem{ key: 'class_name', val: 'wp-block-woocommerce-order-confirmation-create-account' }])))))) {
		return content_mutated
	}
	var_processor.set_attribute(rt.new_string('class'), rt.new_string(''))
	var_processor.set_attribute(rt.new_string('style'), rt.new_string(''))
	var_processor.add_class(rt.new_string('wc-block-order-confirmation-create-account-content'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_processor.next_tag(rt.create_array([rt.ArrayItem{ key: 'class_name', val: 'wc-block-order-confirmation-create-account-form' }])))))) {
		return content_mutated
	}
	var_processor.set_attribute(rt.new_string('data-customer-email'), rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{}))
	var_processor.set_attribute(rt.new_string('data-nonce-token'), rt.call_function('wp_create_nonce', [rt.new_string('wc_create_account')]))
	if !(!rt.is_true(var_attributes.array_get('hasDarkControls'))) {
		var_processor.add_class(rt.new_string('has-dark-controls'))
	}
	return (var_processor.get_updated_html()).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_CreateAccount) render_confirmation() rt.PhpVal {
	mut var_content := rt.new_string(rt.new_string('<div class="wc-block-order-confirmation-create-account-success" id="create-account">'))
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	return var_content.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_CreateAccount) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array)  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array', []string{}, var_attributes))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_CreateAccount', ['Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('delayedAccountCreationEnabled'), this.is_feature_enabled()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_CreateAccount', ['Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('registrationGeneratePassword'), rt.call_function('filter_var', [rt.call_function('get_option', [rt.new_string('woocommerce_registration_generate_password')]), rt.get_constant('FILTER_VALIDATE_BOOLEAN')])])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_createaccount() &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_CreateAccount {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_CreateAccount{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('order-confirmation-create-account')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_abstractorderconfirmationblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_wp_error() &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_ordercontroller() &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_wp_html_tag_processor() &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_CreateAccount) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'initialize_hooks' {
			this.initialize_hooks()
			return rt.new_null()
		}
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		'is_feature_enabled' {
			return this.is_feature_enabled()
		}
		'process_form_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.process_form_post(dispatch_arg_0))
		}
		'render_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return rt.new_string(this.render_content(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'render_confirmation' {
			return this.render_confirmation()
		}
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_CreateAccount) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_CreateAccount) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' { this.block_name = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_orderconfirmation_createaccount_php() {
	// unsupported statement: Stmt_Declare
}
