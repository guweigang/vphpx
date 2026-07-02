import rt

pub fn Class_WC_SmoothGenerator_Generator_Generator.max_batch_size() i64 {
	return 100
}

pub fn Class_WC_SmoothGenerator_Generator_Generator.image_size() i64 {
	return 700
}

struct Class_WC_SmoothGenerator_Generator_Generator {
	rt.PhpObjectBase
}

fn init_static_wc_smoothgenerator_generator_generator() {
	rt.init_static_prop('WC_SmoothGenerator_Generator_Generator', 'ready', rt.new_bool(false))
	rt.init_static_prop('WC_SmoothGenerator_Generator_Generator', 'faker', rt.new_null())
	rt.init_static_prop('WC_SmoothGenerator_Generator_Generator', 'term_ids', rt.new_null())
	rt.init_static_prop('WC_SmoothGenerator_Generator_Generator', 'images', rt.new_array())
}

fn Class_WC_SmoothGenerator_Generator_Generator.generate(save bool) {
}

fn Class_WC_SmoothGenerator_Generator_Generator.maybe_initialize_generators() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), rt.get_static_prop('WC_SmoothGenerator_Generator_Generator',
		'ready')))))
	{
		Class_WC_SmoothGenerator_Generator_Generator.init_faker()
		Class_WC_SmoothGenerator_Generator_Generator.disable_emails()
		if !(rt.get_superglobal('_SERVER').array_isset(rt.new_string('SERVER_NAME'))) {
			rt.get_superglobal('_SERVER').array_set('SERVER_NAME', 'localhost')
		}
	}
	rt.set_static_prop('WC_SmoothGenerator_Generator_Generator', 'ready', rt.new_bool(true))
}

fn Class_WC_SmoothGenerator_Generator_Generator.init_faker() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('WC_SmoothGenerator_Generator_Generator',
		'faker')))))
	{
		mut iife_temp_0 := Class_WC_SmoothGenerator_Generator_Faker_Factory{}
		mut iife_result_0 := iife_temp_0.create(rt.new_string('en_US'))
		rt.set_static_prop('WC_SmoothGenerator_Generator_Generator', 'faker', iife_result_0)
		rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Generator', 'faker'),
			'addProvider', [
			create_wc_smoothgenerator_generator_bezhanov_faker_provider_commerce(rt.get_static_prop('WC_SmoothGenerator_Generator_Generator',
				'faker')),
		])
	}
}

fn Class_WC_SmoothGenerator_Generator_Generator.disable_emails() {
	mut var_email_actions := rt.create_array([
		rt.ArrayItem{ key: none, val: 'woocommerce_new_customer_note' },
		rt.ArrayItem{ key: none, val: 'woocommerce_created_customer' },
		rt.ArrayItem{ key: none, val: 'woocommerce_order_status_pending_to_processing' },
		rt.ArrayItem{ key: none, val: 'woocommerce_order_status_pending_to_completed' },
		rt.ArrayItem{ key: none, val: 'woocommerce_order_status_processing_to_cancelled' },
		rt.ArrayItem{ key: none, val: 'woocommerce_order_status_pending_to_failed' },
		rt.ArrayItem{ key: none, val: 'woocommerce_order_status_pending_to_on-hold' },
		rt.ArrayItem{ key: none, val: 'woocommerce_order_status_failed_to_processing' },
		rt.ArrayItem{ key: none, val: 'woocommerce_order_status_failed_to_completed' },
		rt.ArrayItem{ key: none, val: 'woocommerce_order_status_failed_to_on-hold' },
		rt.ArrayItem{ key: none, val: 'woocommerce_order_status_cancelled_to_processing' },
		rt.ArrayItem{ key: none, val: 'woocommerce_order_status_cancelled_to_completed' },
		rt.ArrayItem{ key: none, val: 'woocommerce_order_status_cancelled_to_on-hold' },
		rt.ArrayItem{ key: none, val: 'woocommerce_order_status_on-hold_to_processing' },
		rt.ArrayItem{ key: none, val: 'woocommerce_order_status_on-hold_to_cancelled' },
		rt.ArrayItem{ key: none, val: 'woocommerce_order_status_on-hold_to_failed' },
		rt.ArrayItem{ key: none, val: 'woocommerce_order_status_completed' },
		rt.ArrayItem{ key: none, val: 'woocommerce_order_status_failed' },
		rt.ArrayItem{ key: none, val: 'woocommerce_order_fully_refunded' },
		rt.ArrayItem{ key: none, val: 'woocommerce_order_partially_refunded' },
		rt.ArrayItem{ key: none, val: 'woocommerce_low_stock' },
		rt.ArrayItem{ key: none, val: 'woocommerce_no_stock' },
		rt.ArrayItem{ key: none, val: 'woocommerce_product_on_backorder' },
	])
	mut iter_1 := var_email_actions.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_action := item_1.val
		rt.call_function('remove_action', [var_action.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Emails' },
				rt.ArrayItem{ key: none, val: 'send_transactional_email' }])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [
		rt.new_string('woocommerce_allow_send_queued_transactional_email'),
		rt.new_string('__return_false'),
	])))))
	{
		rt.call_function('add_action', [
			rt.new_string('woocommerce_allow_send_queued_transactional_email'),
			rt.new_string('__return_false'),
		])
	}
}

fn Class_WC_SmoothGenerator_Generator_Generator.validate_batch_amount(var_amount rt.PhpVal) rt.PhpVal {
	mut var_amount_mutated := var_amount
	var_amount_mutated = rt.call_function('filter_var', [var_amount_mutated.clone(),
		rt.get_constant('FILTER_VALIDATE_INT'),
		rt.create_array([
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'min_range', val: 1 },
				rt.ArrayItem{
					key: 'max_range'
					val: Class_WC_SmoothGenerator_Generator_static.max_batch_size()
				},
			]) },
		])])
	if rt.is_true(rt.identical(rt.new_bool(false), var_amount_mutated)) {
		return rt.new_object('WC_SmoothGenerator_Generator_WP_Error', []string{}, create_wc_smoothgenerator_generator_wp_error(rt.new_string('smoothgenerator_batch_invalid_amount'), rt.call_function('sprintf', [
			rt.new_string('Amount must be a number between 1 and %d.'),
			Class_WC_SmoothGenerator_Generator_static.max_batch_size(),
		])))
	}
	return var_amount_mutated.clone()
}

fn Class_WC_SmoothGenerator_Generator_Generator.generate_term_ids(var_limit rt.PhpVal, var_taxonomy rt.PhpVal, name string) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('1.2.2'), rt.new_string('Product::get_term_ids')])
	Class_WC_SmoothGenerator_Generator_Generator.init_faker()
	mut var_term_ids := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_limit)))) {
		return var_term_ids.clone()
	}
	mut var_words := rt.call_function('str_word_count', [rt.new_string(name),
		rt.new_int(1)])
	mut var_extra_terms := rt.call_function('str_word_count', [
		rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Generator', 'faker'),
			'department', [var_limit.clone()]),
		rt.new_int(1),
	])
	var_words = rt.call_function('array_merge', [var_words.clone(),
		var_extra_terms.clone()])
	if rt.is_true(rt.identical(rt.new_string('product_cat'), var_taxonomy)) {
		mut var_terms := rt.call_function('array_slice', [var_words.clone(),
			rt.new_int(1)])
	} else {
		var_terms = rt.call_function('array_merge', [
			rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Generator', 'faker'),
				'words', [var_limit.clone()]),
			rt.create_array([rt.ArrayItem{
				key: none
				val: var_words.array_get(rt.new_int(0)).to_string().to_lower()
			}]),
		])
	}
	mut iter_2 := var_terms.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_term := item_2.val
		if rt.get_static_prop('WC_SmoothGenerator_Generator_Generator', 'term_ids').array_isset(var_taxonomy)
			&& rt.get_static_prop('WC_SmoothGenerator_Generator_Generator', 'term_ids').array_get(var_taxonomy).array_isset(var_term) {
			mut var_term_id := rt.get_static_prop('WC_SmoothGenerator_Generator_Generator',
				'term_ids').array_get(var_taxonomy).array_get(var_term)
			var_term_ids.array_push(var_term_id.clone())
			continue
		}
		var_term_id = rt.new_int(0)
		mut var_args := rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
			rt.ArrayItem{ key: 'name', val: var_term },
		])
		mut var_existing := rt.call_function('get_terms', [var_args.clone()])
		if rt.is_true(var_existing) && rt.is_true(rt.new_int(var_existing.clone().array_count()))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_existing.clone()]))))) {
			var_term_id = rt.get_property(var_existing.array_get(rt.new_int(0)), 'term_id')
		} else {
			mut var_term_ob := rt.call_function('wp_insert_term', [
				var_term.clone(), var_taxonomy.clone(), var_args.clone()])
			if rt.is_true(var_term_ob)
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term_ob.clone()]))))) {
				var_term_id = var_term_ob.array_get(rt.new_string('term_id'))
			}
		}
		if rt.is_true(var_term_id) {
			var_term_ids.array_push(var_term_id.clone())
			rt.get_static_prop('WC_SmoothGenerator_Generator_Generator', 'term_ids').array_get_mut(var_taxonomy).array_set(var_term,
				var_term_id.clone())
		}
	}
	return var_term_ids.clone()
}

fn Class_WC_SmoothGenerator_Generator_Generator.seed_images(amount i64) {
	mut amount_mutated := amount
	rt.set_static_prop('WC_SmoothGenerator_Generator_Generator', 'images', rt.call_function('get_posts', [
		rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'attachment' },
			rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'parent', val: 0 },
			rt.ArrayItem{ key: 'posts_per_page', val: amount_mutated },
			rt.ArrayItem{ key: 'exclude', val: rt.call_function('get_option', [
				rt.new_string('woocommerce_placeholder_image'),
				rt.new_int(0),
			]) }]),
	]))
	mut var_found_count := rt.new_int(rt.get_static_prop('WC_SmoothGenerator_Generator_Generator',
		'images').array_count())
	mut var_i := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less_equal(var_i, rt.sub(rt.new_int(amount_mutated), var_found_count)))) { break
		 }
		rt.get_static_prop('WC_SmoothGenerator_Generator_Generator', 'images').array_push(Class_WC_SmoothGenerator_Generator_Generator.generate_image())
		rt.post_inc(var_i)
	}
}

fn Class_WC_SmoothGenerator_Generator_Generator.get_image() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('WC_SmoothGenerator_Generator_Generator',
		'images')))))
	{
		Class_WC_SmoothGenerator_Generator_Generator.seed_images()
	}
	return rt.get_static_prop('WC_SmoothGenerator_Generator_Generator', 'images').array_get(rt.call_function('array_rand', [
		rt.get_static_prop('WC_SmoothGenerator_Generator_Generator', 'images'),
	]))
}

fn Class_WC_SmoothGenerator_Generator_Generator.generate_image(seed string) rt.PhpVal {
	mut seed_mutated := seed
	Class_WC_SmoothGenerator_Generator_Generator.init_faker()
	mut var_attachment_id := rt.new_int(0)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(seed_mutated))))) {
		seed_mutated = (rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Generator',
			'faker'), 'word', []rt.PhpVal{})).str()
	}
	seed_mutated = (rt.call_function('sanitize_key', [rt.new_string(seed_mutated).clone()])).str()
	mut var_icon := create_wc_smoothgenerator_generator_jdenticon_identicon()
	var_icon.setvalue(rt.new_string(seed_mutated))
	var_icon.setsize(Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Generator.image_size())
	mut var_image := rt.call_function('imagecreatefromstring', [
		var_icon.getimagedata()])
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('imagepng', [var_image.clone()])
	mut var_file := rt.call_function('ob_get_clean', []rt.PhpVal{})
	rt.call_function('imagedestroy', [var_image.clone()])
	mut var_upload := rt.call_function('wp_upload_bits', [
		rt.new_string('img-' + seed_mutated + '.png'),
		rt.new_null(),
		var_file.clone(),
	])
	if !rt.is_true(var_upload.array_get(rt.new_string('error'))) {
		var_attachment_id = rt.new_int((rt.call_function('wp_insert_attachment', [
			rt.create_array([
				rt.ArrayItem{ key: 'post_title', val: 'img-' + seed_mutated + '.png' },
				rt.ArrayItem{
					key: 'post_mime_type'
					val: var_upload.array_get(rt.new_string('type'))
				},
				rt.ArrayItem{ key: 'post_status', val: 'publish' },
				rt.ArrayItem{ key: 'post_content', val: '' },
			]),
			var_upload.array_get(rt.new_string('file')),
		])).to_i64())
	}
	if rt.is_true(var_attachment_id) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
			rt.new_string('wp_generate_attachment_metadata'),
		])))))
		{
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '2')
		}
		rt.call_function('wp_update_attachment_metadata', [var_attachment_id.clone(),
			rt.call_function('wp_generate_attachment_metadata', [
				var_attachment_id.clone(), var_upload.array_get(rt.new_string('file'))])])
	}
	return var_attachment_id.clone()
}

fn Class_WC_SmoothGenerator_Generator_Generator.random_weighted_element(mut var_weighted_values Class_WC_SmoothGenerator_Generator_array) rt.PhpVal {
	mut var_rand := rt.call_function('wp_rand', [rt.new_int(1),
		rt.new_int((rt.call_function('array_sum', [var_weighted_values])).to_i64())])
	mut iter_3 := var_weighted_values.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_key := item_3.key
		var_rand = rt.sub(var_rand, var_value)
		if rt.is_true(rt.less_equal(var_rand, rt.new_int(0))) {
			return var_key.clone()
		}
	}
	return rt.new_null()
}

struct Class_WC_SmoothGenerator_Generator_Faker_Factory {
	rt.PhpObjectBase
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

fn create_wc_smoothgenerator_generator_generator(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_Generator {
	mut obj := &Class_WC_SmoothGenerator_Generator_Generator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_faker_factory(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_Faker_Factory {
	mut obj := &Class_WC_SmoothGenerator_Generator_Faker_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_bezhanov_faker_provider_commerce(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_Bezhanov_Faker_Provider_Commerce {
	mut obj := &Class_WC_SmoothGenerator_Generator_Bezhanov_Faker_Provider_Commerce{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wp_error(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_WP_Error {
	mut obj := &Class_WC_SmoothGenerator_Generator_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_jdenticon_identicon(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_Jdenticon_Identicon {
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
			return Class_WC_SmoothGenerator_Generator_Generator.generate_term_ids(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_WC_SmoothGenerator_Generator_Generator.random_weighted_element(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_SmoothGenerator_Generator_Generator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Generator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Faker_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_Faker_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Faker_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn main() {
	defer {
		rt.shutdown()
	}
}
