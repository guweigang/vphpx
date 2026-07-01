import rt

struct Class_WP_Privacy_Policy_Content {
	rt.PhpObjectBase
pub mut:
		policy_content rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Privacy_Policy_Content) construct()  {
}

fn Class_WP_Privacy_Policy_Content.add(var_plugin_name rt.PhpVal, var_policy_text rt.PhpVal)  {
	mut var_plugin_name_mutated := var_plugin_name
	if !rt.is_true(var_plugin_name_mutated) || !rt.is_true(var_policy_text) {
		return rt.new_null()
	}
	mut var_data := { 'plugin_name': var_plugin_name_mutated, 'policy_text': var_policy_text }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_data.dup(), // unsupported expression: Expr_StaticPropertyFetch, rt.new_bool(true)]))))) {
		// unsupported expression: Expr_StaticPropertyFetch.array_push(var_data.dup())
	}
}

fn Class_WP_Privacy_Policy_Content.text_change_check() bool {
	mut var_policy_page_id := // unsupported expression: Expr_Cast_Int
	if !rt.is_true(var_policy_page_id) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_policy_page_id.dup()]))))) {
		return false
	}
	mut var_old := rt.cast_array(rt.call_function('get_post_meta', [var_policy_page_id.dup(), rt.new_string('_wp_suggested_privacy_policy_content')]))
	if !rt.is_true(var_old) {
		return false
	}
	mut var_cached := rt.call_function('get_option', [rt.new_string('_wp_suggested_policy_text_has_changed')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('admin_init')]))))) {
		return (rt.identical(rt.new_string('changed'), var_cached)).to_bool()
	}
	mut var_new := // unsupported expression: Expr_StaticPropertyFetch
	{
		mut iter_1 := var_old.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data.dup().is_array()))))) || !(!rt.is_true(var_data.array_get('removed'))))) {
				var_old.array_unset(var_key)
				continue
			}
			var_old.array_set(var_key, rt.create_array([rt.ArrayItem{ key: 'plugin_name', val: var_data.array_get('plugin_name') }, rt.ArrayItem{ key: 'policy_text', val: var_data.array_get('policy_text') }]))
		}
	}
	rt.call_function('sort', [var_old.dup()])
	rt.call_function('sort', [var_new.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Privacy_Policy_Content' }, rt.ArrayItem{ key: none, val: 'policy_text_changed_notice' }])])
		mut var_state := rt.new_string(rt.new_string('changed'))
	} else {
		var_state = rt.new_string(rt.new_string('not-changed'))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('update_option', [rt.new_string('_wp_suggested_policy_text_has_changed'), var_state.dup(), rt.new_bool(false)])
	}
	return (rt.identical(rt.new_string('changed'), var_state)).to_bool()
}

fn Class_WP_Privacy_Policy_Content.policy_text_changed_notice()  {
	mut var_screen := rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id')
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	mut var_privacy_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The suggested privacy policy text has changed. Please <a href="%s">review the guide</a> and update your privacy policy.')]), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('privacy-policy-guide.php?tab=policyguide')])])])
	rt.call_function('wp_admin_notice', [var_privacy_message.dup(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'policy-text-updated' }]) }, rt.ArrayItem{ key: 'dismissible', val: true }])])
}

fn Class_WP_Privacy_Policy_Content._policy_page_updated(var_post_id rt.PhpVal)  {
	mut var_policy_page_id := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_policy_page_id)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_old := rt.cast_array(rt.call_function('get_post_meta', [var_policy_page_id.dup(), rt.new_string('_wp_suggested_privacy_policy_content')]))
	mut var_done := []rt.PhpVal{}
	mut var_update_cache := rt.new_bool(rt.new_bool(false))
	{
		mut iter_1 := var_old.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_old_data := item_1.val
			mut var_old_key := item_1.key
			if !(!rt.is_true(var_old_data.array_get('removed'))) {
				var_update_cache = rt.new_bool(rt.new_bool(true))
				continue
			}
			if !(!rt.is_true(var_old_data.array_get('updated'))) {
				var_done << rt.create_array([rt.ArrayItem{ key: 'plugin_name', val: var_old_data.array_get('plugin_name') }, rt.ArrayItem{ key: 'policy_text', val: var_old_data.array_get('policy_text') }, rt.ArrayItem{ key: 'added', val: var_old_data.array_get('updated') }])
				var_update_cache = rt.new_bool(rt.new_bool(true))
			} else {
				var_done << var_old_data.dup()
			}
		}
	}
	if rt.is_true(var_update_cache) {
		rt.call_function('delete_post_meta', [var_policy_page_id.dup(), rt.new_string('_wp_suggested_privacy_policy_content')])
		for var_data in var_done {
			rt.call_function('add_post_meta', [var_policy_page_id.dup(), rt.new_string('_wp_suggested_privacy_policy_content'), var_data.dup()])
		}
	}
}

fn Class_WP_Privacy_Policy_Content.get_suggested_policy_text() rt.PhpVal {
	mut var_policy_page_id := // unsupported expression: Expr_Cast_Int
	mut var_checked := []rt.PhpVal{}
	mut var_time := rt.call_function('time', []rt.PhpVal{})
	mut var_update_cache := rt.new_bool(rt.new_bool(false))
	mut var_new := // unsupported expression: Expr_StaticPropertyFetch
	mut var_old := []rt.PhpVal{}
	if rt.is_true(var_policy_page_id) {
		var_old = rt.cast_array(rt.call_function('get_post_meta', [var_policy_page_id.dup(), rt.new_string('_wp_suggested_privacy_policy_content')]))
	}
	{
		mut iter_1 := var_new.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_new_data := item_1.val
			mut var_new_key := item_1.key
			{
				mut iter_2 := var_old.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_old_data := item_2.val
					mut var_old_key := item_2.key
					mut var_found := rt.new_bool(rt.new_bool(false))
					if rt.is_true(rt.identical(var_new_data.array_get('policy_text'), var_old_data.array_get('policy_text'))) {
						if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
							var_old_data.array_set('plugin_name', var_new_data.array_get('plugin_name'))
							var_update_cache = rt.new_bool(rt.new_bool(true))
						}
						if !(!rt.is_true(var_old_data.array_get('removed'))) {
							var_old_data.array_unset(rt.new_string('removed'))
							var_old_data.array_set('added', var_time.dup())
							var_update_cache = rt.new_bool(rt.new_bool(true))
						}
						var_checked << var_old_data.dup()
						var_found = rt.new_bool(rt.new_bool(true))
					} else if rt.is_true(rt.identical(var_new_data.array_get('plugin_name'), var_old_data.array_get('plugin_name'))) {
						var_checked << rt.create_array([rt.ArrayItem{ key: 'plugin_name', val: var_new_data.array_get('plugin_name') }, rt.ArrayItem{ key: 'policy_text', val: var_new_data.array_get('policy_text') }, rt.ArrayItem{ key: 'updated', val: var_time }])
						var_found = rt.new_bool(rt.new_bool(true))
						var_update_cache = rt.new_bool(rt.new_bool(true))
					}
					if rt.is_true(var_found) {
						var_new.array_unset(var_new_key)
						var_old.array_unset(var_old_key)
						continue
					}
				}
			}
		}
	}
	if !(!rt.is_true(var_new)) {
		{
			mut iter_1 := var_new.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_new_data := item_1.val
				if !(!rt.is_true(var_new_data.array_get('plugin_name'))) && !(!rt.is_true(var_new_data.array_get('policy_text'))) {
					var_new_data.array_set('added', var_time.dup())
					var_checked << var_new_data.dup()
				}
			}
		}
		var_update_cache = rt.new_bool(rt.new_bool(true))
	}
	if !(!rt.is_true(var_old)) {
		{
			mut iter_1 := var_old.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_old_data := item_1.val
				if !(!rt.is_true(var_old_data.array_get('plugin_name'))) && !(!rt.is_true(var_old_data.array_get('policy_text'))) {
					mut var_data := { 'plugin_name': var_old_data.array_get('plugin_name'), 'policy_text': var_old_data.array_get('policy_text'), 'removed': var_time }
					var_checked << var_data.dup()
				}
			}
		}
		var_update_cache = rt.new_bool(rt.new_bool(true))
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_update_cache) && rt.is_true(var_policy_page_id))) {
		rt.call_function('delete_post_meta', [var_policy_page_id.dup(), rt.new_string('_wp_suggested_privacy_policy_content')])
		for var_data in var_checked {
			rt.call_function('add_post_meta', [var_policy_page_id.dup(), rt.new_string('_wp_suggested_privacy_policy_content'), var_data.dup()])
		}
	}
	return var_checked.dup()
}

fn Class_WP_Privacy_Policy_Content.notice(var_post rt.PhpVal)  {
	mut var_post_mutated := var_post
	if rt.is_true(rt.new_bool(var_post_mutated.dup().is_null())) {
		// unsupported statement: Stmt_Global
	} else {
		var_post_mutated = rt.call_function('get_post', [var_post_mutated.dup()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post_mutated, 'WP_Post')))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_privacy_options')]))))) {
		return rt.new_null()
	}
	mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_policy_page_id := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_message := rt.call_function('__', [rt.new_string('Need help putting together your new Privacy Policy page? Check out the guide for recommendations on what content to include, along with policies suggested by your plugins and theme.')])
	mut var_url := rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('options-privacy.php?tab=policyguide')])])
	mut var_label := rt.call_function('__', [rt.new_string('View Privacy Policy Guide.')])
	if rt.is_true(rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'is_block_editor', []rt.PhpVal{})) {
		rt.call_function('wp_enqueue_script', [rt.new_string('wp-notices')])
		mut var_action := { 'url': var_url, 'label': var_label }
		rt.call_function('wp_add_inline_script', [rt.new_string('wp-notices'), rt.call_function('sprintf', [rt.new_string('wp.data.dispatch( "core/notices" ).createWarningNotice( "%s", { actions: [ %s ], isDismissible: false } )'), var_message.dup(), rt.call_function('wp_json_encode', [var_action.dup(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])]), rt.new_string('after')])
	} else {
		// unsupported expression: Expr_AssignOp_Concat
		rt.call_function('wp_admin_notice', [var_message.dup(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'inline' }, rt.ArrayItem{ key: none, val: 'wp-pp-notice' }]) }])])
	}
}

fn Class_WP_Privacy_Policy_Content.privacy_policy_guide()  {
	mut var_content_array := Class_WP_Privacy_Policy_Content.get_suggested_policy_text()
	mut var_date_format := rt.call_function('__', [rt.new_string('F j, Y')])
	mut var_i := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := var_content_array.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_section := item_1.val
			rt.pre_inc(var_i)
			mut var_removed := rt.new_string(rt.new_string(''))
			if !(!rt.is_true(var_section.array_get('removed'))) {
				mut var_badge_class := rt.new_string(rt.new_string(' red'))
				mut var_date := 
				
			} else if !(!rt.is_true()) {
			}
			
		}
	}
}

fn Class_WP_Privacy_Policy_Content.get_default_content(description bool, blocks bool) rt.PhpVal {
}

fn Class_WP_Privacy_Policy_Content.add_suggested_content()  {
}

fn create_wp_privacy_policy_content() &Class_WP_Privacy_Policy_Content {
	mut obj := &Class_WP_Privacy_Policy_Content{
		PhpObjectBase: rt.PhpObjectBase{}
		policy_content: rt.new_array()
	}
	obj.construct()
	return obj
}

fn (mut this Class_WP_Privacy_Policy_Content) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WP_Privacy_Policy_Content.add(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'text_change_check' {
			return rt.new_bool(Class_WP_Privacy_Policy_Content.text_change_check())
		}
		'policy_text_changed_notice' {
			Class_WP_Privacy_Policy_Content.policy_text_changed_notice()
			return rt.new_null()
		}
		'_policy_page_updated' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WP_Privacy_Policy_Content._policy_page_updated(dispatch_arg_0)
			return rt.new_null()
		}
		'get_suggested_policy_text' {
			return Class_WP_Privacy_Policy_Content.get_suggested_policy_text()
		}
		'notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WP_Privacy_Policy_Content.notice(dispatch_arg_0)
			return rt.new_null()
		}
		'privacy_policy_guide' {
			Class_WP_Privacy_Policy_Content.privacy_policy_guide()
			return rt.new_null()
		}
		'get_default_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_WP_Privacy_Policy_Content.get_default_content(dispatch_arg_0, dispatch_arg_1)
		}
		'add_suggested_content' {
			Class_WP_Privacy_Policy_Content.add_suggested_content()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Privacy_Policy_Content) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'policy_content' { return this.policy_content }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Privacy_Policy_Content) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'policy_content' { this.policy_content = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_admin_includes_class_wp_privacy_policy_content_php() {
}
