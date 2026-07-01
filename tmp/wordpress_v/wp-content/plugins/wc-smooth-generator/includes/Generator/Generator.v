import rt

pub fn Class_WC_SmoothGenerator_Generator_Generator.max_batch_size() i64 {
	return 100
}
pub fn Class_WC_SmoothGenerator_Generator_Generator.image_size() i64 {
	return 700
}
struct Class_WC_SmoothGenerator_Generator_Generator {
	rt.PhpObjectBase
pub mut:
		ready rt.PhpVal = rt.new_bool(false)
		faker rt.PhpVal = rt.new_null()
		term_ids rt.PhpVal = rt.new_null()
		images rt.PhpVal = rt.new_array()
}

fn Class_WC_SmoothGenerator_Generator_Generator.generate(save bool)  {
}

fn Class_WC_SmoothGenerator_Generator_Generator.maybe_initialize_generators()  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		Class_WC_SmoothGenerator_Generator_Generator.init_faker()
		Class_WC_SmoothGenerator_Generator_Generator.disable_emails()
		if !(rt.get_superglobal('_SERVER').array_isset(rt.new_string('SERVER_NAME'))) {
			rt.get_superglobal('_SERVER').array_set('SERVER_NAME', 'localhost')
		}
	}
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_WC_SmoothGenerator_Generator_Generator.init_faker()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
		rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'addProvider', [create_wc_smoothgenerator_generator_bezhanov_faker_provider_commerce(// unsupported expression: Expr_StaticPropertyFetch)])
	}
}

fn Class_WC_SmoothGenerator_Generator_Generator.disable_emails()  {
	mut var_email_actions := rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_new_customer_note' }, rt.ArrayItem{ key: none, val: 'woocommerce_created_customer' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_pending_to_processing' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_pending_to_completed' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_processing_to_cancelled' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_pending_to_failed' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_pending_to_on-hold' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_failed_to_processing' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_failed_to_completed' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_failed_to_on-hold' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_cancelled_to_processing' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_cancelled_to_completed' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_cancelled_to_on-hold' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_on-hold_to_processing' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_on-hold_to_cancelled' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_on-hold_to_failed' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_completed' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_status_failed' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_fully_refunded' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_partially_refunded' }, rt.ArrayItem{ key: none, val: 'woocommerce_low_stock' }, rt.ArrayItem{ key: none, val: 'woocommerce_no_stock' }, rt.ArrayItem{ key: none, val: 'woocommerce_product_on_backorder' }])
	{
		mut iter_1 := var_email_actions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_action := item_1.val
			rt.call_function('remove_action', [var_action.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Emails' }, rt.ArrayItem{ key: none, val: 'send_transactional_email' }])])
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [rt.new_string('woocommerce_allow_send_queued_transactional_email'), rt.new_string('__return_false')]))))) {
		rt.call_function('add_action', [rt.new_string('woocommerce_allow_send_queued_transactional_email'), rt.new_string('__return_false')])
	}
}

fn Class_WC_SmoothGenerator_Generator_Generator.validate_batch_amount(var_amount rt.PhpVal) rt.PhpVal {
	mut var_amount_mutated := var_amount
	var_amount_mutated = rt.call_function('filter_var', [var_amount_mutated.dup(), rt.get_constant('FILTER_VALIDATE_INT'), rt.create_array([rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: 'min_range', val: 1 }, rt.ArrayItem{ key: 'max_range', val: Class_WC_SmoothGenerator_Generator_static.max_batch_size() }]) }])])
	if rt.is_true(rt.identical(rt.new_bool(false), var_amount_mutated)) {
		return create_wc_smoothgenerator_generator_wp_error(rt.new_string('smoothgenerator_batch_invalid_amount'), rt.call_function('sprintf', [rt.new_string('Amount must be a number between 1 and %d.'), Class_WC_SmoothGenerator_Generator_static.max_batch_size()]))
	}
	return var_amount_mutated.dup()
}

fn Class_WC_SmoothGenerator_Generator_Generator.generate_term_ids(var_limit rt.PhpVal, var_taxonomy rt.PhpVal, name string) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('1.2.2'), rt.new_string('Product::get_term_ids')])
	Class_WC_SmoothGenerator_Generator_Generator.init_faker()
	mut var_term_ids := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_limit)))) {
		return var_term_ids.dup()
	}
	mut var_words := rt.call_function('str_word_count', [rt.new_string(name), rt.new_int(1)])
	mut var_extra_terms := rt.call_function('str_word_count', [rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'department', [var_limit.dup()]), rt.new_int(1)])
	var_words = rt.call_function('array_merge', [var_words.dup(), var_extra_terms.dup()])
	if rt.is_true(rt.identical(rt.new_string('product_cat'), var_taxonomy)) {
		mut var_terms := rt.call_function('array_slice', [var_words.dup(), rt.new_int(1)])
	} else {
		var_terms = rt.call_function('array_merge', [rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'words', [var_limit.dup()]), rt.create_array([rt.ArrayItem{ key: none, val: var_words.array_get(0).to_string().to_lower() }])])
	}
	{
		mut iter_1 := var_terms.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			if // unsupported expression: Expr_StaticPropertyFetch.array_isset(var_taxonomy) && // unsupported expression: Expr_StaticPropertyFetch.array_get(var_taxonomy).array_isset(var_term) {
				mut var_term_id := // unsupported expression: Expr_StaticPropertyFetch.array_get(var_taxonomy).array_get(var_term)
				var_term_ids.array_push(var_term_id.dup())
				continue
			}
			var_term_id = rt.new_int(rt.new_int(0))
			mut var_args := rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy }, rt.ArrayItem{ key: 'name', val: var_term }])
			mut var_existing := rt.call_function('get_terms', [var_args.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_existing) && rt.is_true(rt.new_int(var_existing.dup().array_count())))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_existing.dup()]))))))) {
				var_term_id = rt.get_property(var_existing.array_get(0), 'term_id')
			} else {
				mut var_term_ob := rt.call_function('wp_insert_term', [var_term.dup(), var_taxonomy.dup(), var_args.dup()])
				if rt.is_true(rt.new_bool(rt.is_true(var_term_ob) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term_ob.dup()]))))))) {
					var_term_id = var_term_ob.array_get('term_id')
				}
			}
			if rt.is_true(var_term_id) {
				var_term_ids.array_push(var_term_id.dup())
				// unsupported expression: Expr_StaticPropertyFetch.array_get_mut(var_taxonomy).array_set(var_term, var_term_id.dup())
			}
		}
	}
	return var_term_ids.dup()
}

fn Class_WC_SmoothGenerator_Generator_Generator.seed_images(amount i64)  {
	mut amount_mutated := amount
	// unsupported assign target: Expr_StaticPropertyFetch
	mut var_found_count := rt.new_int(rt.new_int(// unsupported expression: Expr_StaticPropertyFetch.array_count()))
	{
		mut var_i := rt.new_int(rt.new_int(1))
		for {
			if !(rt.is_true(rt.less_equal(var_i, rt.sub(rt.new_int(amount_mutated), var_found_count)))) { break }
			// unsupported expression: Expr_StaticPropertyFetch.array_push(Class_WC_SmoothGenerator_Generator_Generator.generate_image())
			rt.post_inc(var_i)
		}
	}
}

fn Class_WC_SmoothGenerator_Generator_Generator.get_image() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		Class_WC_SmoothGenerator_Generator_Generator.seed_images()
	}
	return // unsupported expression: Expr_StaticPropertyFetch.array_get(rt.call_function('array_rand', [// unsupported expression: Expr_StaticPropertyFetch]))
}

fn Class_WC_SmoothGenerator_Generator_Generator.generate_image(seed string) rt.PhpVal {
	mut seed_mutated := seed
	Class_WC_SmoothGenerator_Generator_Generator.init_faker()
	mut var_attachment_id := rt.new_int(rt.new_int(0))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(seed_mutated))))) {
		seed_mutated = (rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'word', []rt.PhpVal{})).str()
	}
	seed_mutated = (rt.call_function('sanitize_key', [rt.new_string(seed_mutated).dup()])).str()
	mut var_icon := create_wc_smoothgenerator_generator_jdenticon_identicon()
	var_icon.setvalue(rt.new_string(seed_mutated))
	var_icon.setsize(Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Generator.image_size())
	mut var_image := rt.call_function('imagecreatefromstring', [var_icon.getimagedata()])
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('imagepng', [var_image.dup()])
	mut var_file := rt.call_function('ob_get_clean', []rt.PhpVal{})
	rt.call_function('imagedestroy', [var_image.dup()])
	mut var_upload := rt.call_function('wp_upload_bits', ['img-' + seed_mutated + '.png', rt.new_null(), var_file.dup()])
	if !rt.is_true(var_upload.array_get('error')) {
		var_attachment_id = // unsupported expression: Expr_Cast_Int
	}
	if rt.is_true(var_attachment_id) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_generate_attachment_metadata')]))))) {
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '2')
		}
		rt.call_function('wp_update_attachment_metadata', [var_attachment_id.dup(), rt.call_function('wp_generate_attachment_metadata', [var_attachment_id.dup(), var_upload.array_get('file')])])
	}
	return var_attachment_id.dup()
}

fn Class_WC_SmoothGenerator_Generator_Generator.random_weighted_element(mut var_weighted_values Class_WC_SmoothGenerator_Generator_array) rt.PhpVal {
	mut var_rand := rt.call_function('wp_rand', [rt.new_int(1), // unsupported expression: Expr_Cast_Int])
	{
		mut iter_1 := var_weighted_values.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			// unsupported expression: Expr_AssignOp_Minus
			if rt.is_true(rt.less_equal(var_rand, rt.new_int(0))) {
				return var_key.dup()
			}
		}
	}
	return rt.new_null()
}

struct Class_WC_SmoothGenerator_Generator_Bezhanov_Faker_Provider_Commerce {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_Jdenticon_Identicon {
	rt.PhpObjectBase
}

fn create_wc_smoothgenerator_generator_generator() &Class_WC_SmoothGenerator_Generator_Generator {
	mut obj := &Class_WC_SmoothGenerator_Generator_Generator{
		PhpObjectBase: rt.PhpObjectBase{}
		ready: rt.new_bool(false)
		faker: rt.new_null()
		term_ids: rt.new_null()
		images: rt.new_array()
	}
	return obj
}

fn create_wc_smoothgenerator_generator_bezhanov_faker_provider_commerce() &Class_WC_SmoothGenerator_Generator_Bezhanov_Faker_Provider_Commerce {
	mut obj := &Class_WC_SmoothGenerator_Generator_Bezhanov_Faker_Provider_Commerce{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wp_error() &Class_WC_SmoothGenerator_Generator_WP_Error {
	mut obj := &Class_WC_SmoothGenerator_Generator_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_jdenticon_identicon() &Class_WC_SmoothGenerator_Generator_Jdenticon_Identicon {
	mut obj := &Class_WC_SmoothGenerator_Generator_Jdenticon_Identicon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_SmoothGenerator_Generator_Generator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'generate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			Class_WC_SmoothGenerator_Generator_Generator.generate(dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_initialize_generators' {
			Class_WC_SmoothGenerator_Generator_Generator.maybe_initialize_generators()
			return rt.new_null()
		}
		'init_faker' {
			Class_WC_SmoothGenerator_Generator_Generator.init_faker()
			return rt.new_null()
		}
		'disable_emails' {
			Class_WC_SmoothGenerator_Generator_Generator.disable_emails()
			return rt.new_null()
		}
		'validate_batch_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Generator.validate_batch_amount(dispatch_arg_0)
		}
		'generate_term_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_WC_SmoothGenerator_Generator_Generator.generate_term_ids(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'seed_images' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			Class_WC_SmoothGenerator_Generator_Generator.seed_images(dispatch_arg_0)
			return rt.new_null()
		}
		'get_image' {
			return Class_WC_SmoothGenerator_Generator_Generator.get_image()
		}
		'generate_image' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WC_SmoothGenerator_Generator_Generator.generate_image(dispatch_arg_0)
		}
		'random_weighted_element' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WC_SmoothGenerator_Generator_Generator.random_weighted_element(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_SmoothGenerator_Generator_Generator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'ready' { return this.ready }
		'faker' { return this.faker }
		'term_ids' { return this.term_ids }
		'images' { return this.images }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_SmoothGenerator_Generator_Generator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'ready' { this.ready = val; return true }
		'faker' { this.faker = val; return true }
		'term_ids' { this.term_ids = val; return true }
		'images' { this.images = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_SmoothGenerator_Generator_Bezhanov_Faker_Provider_Commerce) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_Bezhanov_Faker_Provider_Commerce) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Bezhanov_Faker_Provider_Commerce) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_Jdenticon_Identicon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_Jdenticon_Identicon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Jdenticon_Identicon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_wc_smooth_generator_includes_generator_generator_php() {
}
