import rt
import crypto.sha1

pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.case_a() string {
	return 'A'
}
pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.case_b() string {
	return 'B'
}
pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.case_c() string {
	return 'C'
}
pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.backfill_complete_action() string {
	return 'woocommerce_email_template_sync_backfill_complete'
}
struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wcemailtemplatesyncbackfill() {
		rt.init_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill', 'is_backfilling', rt.new_bool(false))
		rt.init_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill', 'logger', rt.new_null())
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.run() bool {
	mut var_eligible := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.fetch_eligible_posts()
	if !rt.is_true(var_eligible) {
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.finalize()
		return false
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry{}
	mut iife_result_0 := iife_temp_0.get_sync_enabled_emails()
	mut var_registry := iife_result_0
	if !rt.is_true(var_registry) {
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.finalize()
		return false
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{}
	mut iife_result_1 := iife_temp_1.get_instance()
	mut var_posts_manager := iife_result_1
	mut var_emails_by_id := rt.call_method(var_posts_manager, 'get_emails_by_id', []rt.PhpVal{})
	mut iter_1 := var_eligible.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_row := item_1.val
		mut var_post_id := rt.new_int((rt.get_property(var_row, 'ID')).to_i64())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		mut var_email_id := rt.new_string((rt.call_method(var_posts_manager, 'get_email_type_from_post_id', [var_post_id.clone()])).str())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.identical(rt.new_string(''), var_email_id)) || !(var_registry.array_isset(var_email_id)) {
			continue
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		mut var_email := if !(var_emails_by_id.array_get(var_email_id)).is_null() { var_emails_by_id.array_get(var_email_id) } else { rt.new_null() }
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_email, 'Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Email')))))) {
			continue
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator{}
		mut iife_result_2 := iife_temp_2.compute_canonical_post_content(var_email.clone())
		mut var_canonical_post_content := iife_result_2
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		mut var_current_core_hash := rt.new_string(sha1.hexhash(var_canonical_post_content.clone().to_string()))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		mut var_case_id := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.classify(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_stdClass](var_row), (var_current_core_hash).str())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.apply_case_to_post((var_post_id).to_i64(), (var_case_id).str(), (var_canonical_post_content).str(), (var_current_core_hash).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Email](var_email))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Throwable') {
			mut var_e := var_e_1.clone()
			rt.call_method(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.get_logger(), 'error', [rt.call_function('sprintf', [rt.new_string('Email template sync backfill failed for post %d: %s'), rt.new_int((rt.get_property(var_row, 'ID')).to_i64()), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'post_id', val: rt.new_int((rt.get_property(var_row, 'ID')).to_i64()) }, rt.ArrayItem{ key: 'context', val: 'email_template_sync_backfill' }])])
			continue
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
	}
	Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.finalize()
	return false
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.is_backfilling() bool {
	return (rt.get_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill', 'is_backfilling')).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.set_logger(mut var_logger Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_?Email_Editor_Logger_Interface) {
	rt.set_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill', 'logger', var_logger)
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.classify(mut var_row Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_stdClass, current_core_hash string) string {
	mut current_core_hash_mutated := current_core_hash
	mut var_current_post_hash := rt.new_string(sha1.hexhash((if !(rt.get_property(var_row, 'post_content')).is_null() { rt.get_property(var_row, 'post_content') } else { rt.new_string('') }).str()))
	if rt.is_true(rt.identical(var_current_post_hash, rt.new_string(current_core_hash_mutated))) {
		return (Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.case_a()).str()
	}
	return (if rt.is_true(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.was_never_edited(mut var_row)) { Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.case_b() } else { Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.case_c() }).str()
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.was_never_edited(mut var_row Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_stdClass) bool {
	mut var_post_date_gmt := rt.new_string((if !(rt.get_property(var_row, 'post_date_gmt')).is_null() { rt.get_property(var_row, 'post_date_gmt') } else { rt.new_string('') }).str())
	mut var_post_modified_gmt := rt.new_string((if !(rt.get_property(var_row, 'post_modified_gmt')).is_null() { rt.get_property(var_row, 'post_modified_gmt') } else { rt.new_string('') }).str())
	mut var_post_date := rt.new_string((if !(rt.get_property(var_row, 'post_date')).is_null() { rt.get_property(var_row, 'post_date') } else { rt.new_string('') }).str())
	mut var_post_modified := rt.new_string((if !(rt.get_property(var_row, 'post_modified')).is_null() { rt.get_property(var_row, 'post_modified') } else { rt.new_string('') }).str())
	return rt.is_true(rt.identical(var_post_date_gmt, var_post_modified_gmt)) || rt.is_true(rt.identical(var_post_date, var_post_modified))
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.apply_case_to_post(post_id i64, case_id string, canonical_post_content string, current_core_hash string, mut var_email Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Email) {
	mut post_id_mutated := post_id
	mut case_id_mutated := case_id
	mut canonical_post_content_mutated := canonical_post_content
	mut current_core_hash_mutated := current_core_hash
	mut var_email_mutated := var_email
	mut var_version := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.resolve_version_for_email(mut var_email_mutated)
	mut var_status_for_stamp := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.status_for_case(case_id_mutated)
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.case_b(), rt.new_string(case_id_mutated))) {
		rt.set_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill', 'is_backfilling', rt.new_bool(true))
		mut var_updated := rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: post_id_mutated }, rt.ArrayItem{ key: 'post_content', val: canonical_post_content_mutated }]), rt.new_bool(true)])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		unsafe { goto finally_label_2 }

catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()

finally_label_2:
		rt.set_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill', 'is_backfilling', rt.new_bool(false))
		if rt.has_exception() { return }

end_label_2:
		if rt.is_true(rt.call_function('is_wp_error', [var_updated.clone()])) {
			var_status_for_stamp = Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_core_updated_customized()
			rt.call_method(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.get_logger(), 'warning', [rt.call_function('sprintf', [rt.new_string('Email template sync backfill: Case B content rewrite failed for post %d (%s); stamping as core_updated_customized so the post surfaces for merchant review.'), rt.new_int(post_id_mutated).clone(), rt.call_method(var_updated, 'get_error_message', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'post_id', val: post_id_mutated }, rt.ArrayItem{ key: 'context', val: 'email_template_sync_backfill' }])])
		}
	}
	rt.call_function('update_post_meta', [rt.new_int(post_id_mutated).clone(), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.version_meta_key(), var_version.clone()])
	rt.call_function('update_post_meta', [rt.new_int(post_id_mutated).clone(), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.source_hash_meta_key(), rt.new_string(current_core_hash_mutated).clone()])
	rt.call_function('update_post_meta', [rt.new_int(post_id_mutated).clone(), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.last_synced_at_meta_key(), rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s')])])
	rt.call_function('update_post_meta', [rt.new_int(post_id_mutated).clone(), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_meta_key(), var_status_for_stamp.clone()])
	rt.call_function('update_post_meta', [rt.new_int(post_id_mutated).clone(), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.last_core_render_meta_key(), rt.new_string(canonical_post_content_mutated).clone()])
	rt.call_function('update_post_meta', [rt.new_int(post_id_mutated).clone(), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.backfilled_meta_key(), rt.new_bool(true)])
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.status_for_case(case_id string) string {
	mut case_id_mutated := case_id
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.case_c(), rt.new_string(case_id_mutated))) {
		return (Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_core_updated_customized()).str()
	}
	return (Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_in_sync()).str()
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.resolve_version_for_email(mut var_email Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Email) string {
	mut var_email_mutated := var_email
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry{}
	mut iife_result_3 := iife_temp_3.get_email_sync_config(rt.new_string((rt.get_property(var_email_mutated, 'id')).str()))
	mut var_sync_config := iife_result_3
	if var_sync_config.clone().is_array() && var_sync_config.array_isset(rt.new_string('template_path')) {
		mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry{}
		mut iife_result_4 := iife_temp_4.parse_version_header(rt.new_string((var_sync_config.array_get(rt.new_string('template_path'))).str()))
		mut var_parsed := iife_result_4
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_parsed)))) {
			return (var_parsed).str()
		}
		return (if !(var_sync_config.array_get(rt.new_string('version'))).is_null() { var_sync_config.array_get(rt.new_string('version')) } else { rt.new_string('') }).str()
	}
	return ''
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.fetch_eligible_posts() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_rows := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT ID, post_content, post_date, post_modified, post_date_gmt, post_modified_gmt\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string('\n\t\t\t\tWHERE post_type = %s\n\t\t\t\t\tAND post_status <> \'trash\'\n\t\t\t\t\tAND NOT EXISTS (\n\t\t\t\t\t\tSELECT 1 FROM ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' pm\n\t\t\t\t\t\tWHERE pm.post_id = ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID\n\t\t\t\t\t\t\tAND pm.meta_key = %s\n\t\t\t\t\t)\n\t\t\t\tORDER BY ID ASC')), Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type(), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.source_hash_meta_key()])])
	return if var_rows.clone().is_array() { var_rows } else { rt.new_array() }
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.finalize() {
	rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.backfill_complete_option(), rt.new_string('yes')])
	rt.call_function('do_action', [Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.backfill_complete_action()])
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.get_logger() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill', 'logger'))) {
		rt.set_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill', 'logger', rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_Logger', []string{}, create_automattic_woocommerce_internal_emaileditor_logger(rt.call_function('wc_get_logger', []rt.PhpVal{}))))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill', 'logger')
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_Logger {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wcemailtemplatesyncbackfill(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wcemailtemplatesyncregistry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsmanager(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsgenerator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_logger(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_Logger {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_Logger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'run' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.run())
		}
		'is_backfilling' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.is_backfilling())
		}
		'set_logger' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_?Email_Editor_Logger_Interface](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.set_logger(mut dispatch_arg_0)
			return rt.new_null()
		}
		'classify' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_stdClass](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.classify(mut dispatch_arg_0, dispatch_arg_1))
		}
		'was_never_edited' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_stdClass](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.was_never_edited(mut dispatch_arg_0))
		}
		'apply_case_to_post' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Email](if args.len > 4 { args[4] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.apply_case_to_post(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4)
			return rt.new_null()
		}
		'status_for_case' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.status_for_case(dispatch_arg_0))
		}
		'resolve_version_for_email' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Email](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.resolve_version_for_email(mut dispatch_arg_0))
		}
		'fetch_eligible_posts' {
			return Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.fetch_eligible_posts()
		}
		'finalize' {
			Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.finalize()
			return rt.new_null()
		}
		'get_logger' {
			return Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.get_logger()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
