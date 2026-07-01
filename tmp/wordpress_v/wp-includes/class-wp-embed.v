import rt
import crypto.md5

struct Class_WP_Embed {
	rt.PhpObjectBase
pub mut:
		handlers rt.PhpVal = rt.new_array()
		post_ID rt.PhpVal = rt.new_null()
		usecache bool
		linkifunknown rt.PhpVal = rt.new_bool(true)
		last_attr rt.PhpVal = rt.new_array()
		last_url rt.PhpVal = rt.new_string('')
		return_false_on_fail rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_WP_Embed) construct()  {
	rt.call_function('add_filter', [rt.new_string('the_content'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Embed', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'run_shortcode' }]), rt.new_int(8)])
	rt.call_function('add_filter', [rt.new_string('widget_text_content'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Embed', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'run_shortcode' }]), rt.new_int(8)])
	rt.call_function('add_filter', [rt.new_string('widget_block_content'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Embed', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'run_shortcode' }]), rt.new_int(8)])
	rt.call_function('add_shortcode', [rt.new_string('embed'), rt.new_string('__return_false')])
	rt.call_function('add_filter', [rt.new_string('the_content'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Embed', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'autoembed' }]), rt.new_int(8)])
	rt.call_function('add_filter', [rt.new_string('widget_text_content'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Embed', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'autoembed' }]), rt.new_int(8)])
	rt.call_function('add_filter', [rt.new_string('widget_block_content'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Embed', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'autoembed' }]), rt.new_int(8)])
	rt.call_function('add_action', [rt.new_string('edit_form_advanced'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Embed', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_run_ajax_cache' }])])
	rt.call_function('add_action', [rt.new_string('edit_page_form'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Embed', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_run_ajax_cache' }])])
}

fn (mut this Class_WP_Embed) run_shortcode(var_content rt.PhpVal) rt.PhpVal {
	mut var_content_mutated := var_content
	// unsupported statement: Stmt_Global
	mut var_orig_shortcode_tags := var_shortcode_tags.dup()
	rt.call_function('remove_all_shortcodes', []rt.PhpVal{})
	rt.call_function('add_shortcode', [rt.new_string('embed'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Embed', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'shortcode' }])])
	var_content_mutated = rt.call_function('do_shortcode', [var_content_mutated.dup(), rt.new_bool(true)])
	mut var_shortcode_tags := var_orig_shortcode_tags.dup()
	return var_content_mutated.dup()
}

fn (mut this Class_WP_Embed) maybe_run_ajax_cache()  {
	mut var_post := rt.call_function('get_post', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) || !rt.is_true(rt.get_superglobal('_GET').array_get('message')))) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	print((rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('admin-ajax.php'), rt.new_string('relative')])])).str() + '?action=oembed-cache&post=' + (rt.get_property(var_post, 'ID')).str())
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Embed) register_handler(var_id rt.PhpVal, var_regex rt.PhpVal, var_callback rt.PhpVal, priority i64)  {
	this.handlers.array_get_mut(priority).array_set(var_id, rt.create_array([rt.ArrayItem{ key: 'regex', val: var_regex }, rt.ArrayItem{ key: 'callback', val: var_callback }]))
}

fn (mut this Class_WP_Embed) unregister_handler(var_id rt.PhpVal, priority i64)  {
	this.handlers.array_get(priority).array_unset(var_id)
}

fn (mut this Class_WP_Embed) get_embed_handler_html(var_attr rt.PhpVal, var_url rt.PhpVal) bool {
	mut var_matches := []rt.PhpVal{}
	mut var_attr_mutated := var_attr
	mut var_url_mutated := var_url
	mut var_rawattr := var_attr_mutated.dup()
	var_attr_mutated = rt.call_function('wp_parse_args', [var_attr_mutated.dup(), rt.call_function('wp_embed_defaults', [var_url_mutated.dup()])])
	rt.call_function('ksort', [this.handlers])
	{
		mut iter_1 := this.handlers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_handlers := item_1.val
			mut var_priority := item_1.key
			{
				mut iter_2 := var_handlers.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_handler := item_2.val
					mut var_id := item_2.key
					if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('preg_match', [var_handler.array_get('regex'), var_url_mutated.dup(), var_matches.dup()])) && rt.is_true(rt.call_function('is_callable', [var_handler.array_get('callback')])))) {
						mut var_return := rt.call_function('call_user_func', [var_handler.array_get('callback'), var_matches.dup(), var_attr_mutated.dup(), var_url_mutated.dup(), var_rawattr.dup()])
						if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
							return (rt.call_function('apply_filters', [rt.new_string('embed_handler_html'), var_return.dup(), var_url_mutated.dup(), var_attr_mutated.dup()])).to_bool()
						}
					}
				}
			}
		}
	}
	return false
}

fn (mut this Class_WP_Embed) shortcode(var_attr rt.PhpVal, url string) string {
	mut var_attr_mutated := var_attr
	mut url_mutated := url
	mut var_post := rt.call_function('get_post', []rt.PhpVal{})
	if url_mutated == '' && !(!rt.is_true(var_attr_mutated.array_get('src'))) {
		url_mutated = (var_attr_mutated.array_get('src')).str()
	}
	this.last_url = rt.new_string(url_mutated).dup()
	if url_mutated == '' {
		this.last_attr = var_attr_mutated.dup()
		return ''
	}
	mut var_rawattr := var_attr_mutated.dup()
	var_attr_mutated = rt.call_function('wp_parse_args', [var_attr_mutated.dup(), rt.call_function('wp_embed_defaults', [rt.new_string(url_mutated).dup()])])
	this.last_attr = var_attr_mutated.dup()
	url_mutated = (rt.call_function('str_replace', [rt.new_string('&amp;'), rt.new_string('&'), rt.new_string(url_mutated).dup()])).str()
	mut var_embed_handler_html := rt.new_bool(this.get_embed_handler_html(var_rawattr.dup(), rt.new_string(url_mutated)))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (var_embed_handler_html).str()
	}
	mut var_post_id := if !(!rt.is_true(rt.get_property(var_post, 'ID'))) { rt.get_property(var_post, 'ID') } else { rt.new_null() }
	if !(!rt.is_true(this.post_ID)) {
		var_post_id = this.post_ID
	}
	mut var_key_suffix := rt.new_string(rt.new_string(md5.hexhash(url_mutated + (rt.call_function('serialize', [var_attr_mutated.dup()])).str())))
	mut var_cachekey := rt.new_string('_oembed_' + (var_key_suffix).str())
	mut var_cachekey_time := rt.new_string('_oembed_time_' + (var_key_suffix).str())
	mut var_ttl := rt.call_function('apply_filters', [rt.new_string('oembed_ttl'), rt.get_constant('DAY_IN_SECONDS'), rt.new_string(url_mutated).dup(), var_attr_mutated.dup(), var_post_id.dup()])
	mut var_cache := rt.new_string(rt.new_string(''))
	mut var_cache_time := rt.new_int(rt.new_int(0))
	mut var_cached_post_id := this.find_oembed_post_id(var_key_suffix.dup())
	if rt.is_true(var_post_id) {
		var_cache = rt.call_function('get_post_meta', [var_post_id.dup(), var_cachekey.dup(), rt.new_bool(true)])
		var_cache_time = rt.call_function('get_post_meta', [var_post_id.dup(), var_cachekey_time.dup(), rt.new_bool(true)])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_cache_time)))) {
			var_cache_time = rt.new_int(rt.new_int(0))
		}
	} else if rt.is_true(var_cached_post_id) {
		mut var_cached_post := rt.call_function('get_post', [var_cached_post_id.dup()])
		var_cache = rt.get_property(var_cached_post, 'post_content')
		var_cache_time = rt.call_function('strtotime', [rt.get_property(var_cached_post, 'post_modified_gmt')])
	}
	mut var_cached_recently := rt.less(rt.sub(rt.call_function('time', []rt.PhpVal{}), var_cache_time), var_ttl)
	if rt.is_true(rt.new_bool(rt.is_true(this.usecache) || rt.is_true(var_cached_recently))) {
		if rt.is_true(rt.identical(rt.new_string('{{unknown}}'), var_cache)) {
			return this.maybe_make_link(rt.new_string(url_mutated))
		}
		if !(!rt.is_true(var_cache)) {
			return (rt.call_function('apply_filters', [rt.new_string('embed_oembed_html'), var_cache.dup(), rt.new_string(url_mutated).dup(), var_attr_mutated.dup(), var_post_id.dup()])).str()
		}
	}
	var_attr_mutated.array_set('discover', rt.call_function('apply_filters', [rt.new_string('embed_oembed_discover'), rt.new_bool(true)]))
	mut var_html := rt.call_function('wp_oembed_get', [rt.new_string(url_mutated).dup(), var_attr_mutated.dup()])
	if rt.is_true(var_post_id) {
		if rt.is_true(var_html) {
			rt.call_function('update_post_meta', [var_post_id.dup(), var_cachekey.dup(), var_html.dup()])
			rt.call_function('update_post_meta', [var_post_id.dup(), var_cachekey_time.dup(), rt.call_function('time', []rt.PhpVal{})])
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_cache)))) {
			rt.call_function('update_post_meta', [var_post_id.dup(), var_cachekey.dup(), rt.new_string('{{unknown}}')])
		}
	} else {
		mut var_has_kses := // unsupported expression: Expr_BinaryOp_NotIdentical
		if rt.is_true(var_has_kses) {
			rt.call_function('kses_remove_filters', []rt.PhpVal{})
		}
		mut var_insert_post_args := { 'post_name': var_key_suffix, 'post_status': rt.new_string('publish'), 'post_type': rt.new_string('oembed_cache') }
		if rt.is_true(var_html) {
			if rt.is_true(var_cached_post_id) {
				rt.call_function('wp_update_post', [rt.call_function('wp_slash', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_cached_post_id }, rt.ArrayItem{ key: 'post_content', val: var_html }])])])
			} else {
				rt.call_function('wp_insert_post', [rt.call_function('wp_slash', [rt.call_function('array_merge', [var_insert_post_args.dup(), rt.create_array([rt.ArrayItem{ key: 'post_content', val: var_html }])])])])
			}
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_cache)))) {
			rt.call_function('wp_insert_post', [rt.call_function('wp_slash', [rt.call_function('array_merge', [var_insert_post_args.dup(), rt.create_array([rt.ArrayItem{ key: 'post_content', val: '{{unknown}}' }])])])])
		}
		if rt.is_true(var_has_kses) {
			rt.call_function('kses_init_filters', []rt.PhpVal{})
		}
	}
	if rt.is_true(var_html) {
		return (rt.call_function('apply_filters', [rt.new_string('embed_oembed_html'), var_html.dup(), rt.new_string(url_mutated).dup(), var_attr_mutated.dup(), var_post_id.dup()])).str()
	}
	return this.maybe_make_link(rt.new_string(url_mutated))
}

fn (mut this Class_WP_Embed) delete_oembed_caches(var_post_id rt.PhpVal)  {
	mut var_post_id_mutated := var_post_id
	mut var_post_metas := rt.call_function('get_post_custom_keys', [var_post_id_mutated.dup()])
	if !rt.is_true(var_post_metas) {
		return rt.new_null()
	}
	{
		mut iter_1 := var_post_metas.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post_meta_key := item_1.val
			if rt.is_true(rt.call_function('str_starts_with', [var_post_meta_key.dup(), rt.new_string('_oembed_')])) {
				rt.call_function('delete_post_meta', [var_post_id_mutated.dup(), var_post_meta_key.dup()])
			}
		}
	}
}

fn (mut this Class_WP_Embed) cache_oembed(var_post_id rt.PhpVal)  {
	mut var_post_id_mutated := var_post_id
	mut var_post := rt.call_function('get_post', [var_post_id_mutated.dup()])
	mut var_post_types := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_ui', val: true }])])
	mut var_cache_oembed_types := rt.call_function('apply_filters', [rt.new_string('embed_cache_oembed_types'), var_post_types.dup()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.get_property(var_post, 'ID')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_type'), var_cache_oembed_types.dup(), rt.new_bool(true)]))))))) {
		return rt.new_null()
	}
	if !(!rt.is_true(rt.get_property(var_post, 'post_content'))) {
		this.post_ID = rt.get_property(var_post, 'ID')
		this.usecache = false
		mut var_content := this.run_shortcode(rt.get_property(var_post, 'post_content'))
		this.autoembed(var_content.dup())
		this.usecache = true
	}
}

fn (mut this Class_WP_Embed) autoembed(var_content rt.PhpVal) rt.PhpVal {
	mut var_content_mutated := var_content
	var_content_mutated = rt.call_function('wp_replace_in_html_tags', [var_content_mutated.dup(), rt.create_array([rt.ArrayItem{ key: '\n', val: '<!-- wp-line-break -->' }])])
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('#(^|\\s|>)https?://#i'), var_content_mutated.dup()])) {
		var_content_mutated = rt.call_function('preg_replace_callback', [rt.new_string('|^(\\s*)(https?://[^\\s<>"]+)(\\s*)$|im'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Embed', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'autoembed_callback' }]), var_content_mutated.dup()])
		var_content_mutated = rt.call_function('preg_replace_callback', [rt.new_string('|(<p(?: [^>]*)?>\\s*)(https?://[^\\s<>"]+)(\\s*<\\/p>)|i'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Embed', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'autoembed_callback' }]), var_content_mutated.dup()])
	}
	return rt.call_function('str_replace', [rt.new_string('<!-- wp-line-break -->'), rt.new_string('\n'), var_content_mutated.dup()])
}

fn (mut this Class_WP_Embed) autoembed_callback(var_matches rt.PhpVal) string {
	mut var_oldval := this.linkifunknown
	this.linkifunknown = rt.new_bool(false)
	mut var_return := rt.new_string(this.shortcode(rt.new_array(), (var_matches.array_get(2)).str()))
	this.linkifunknown = var_oldval.dup()
	return (.array_get()).str() + (var_return).str() + (var_matches.array_get(3)).str()
}

fn (mut this Class_WP_Embed) maybe_make_link(var_url rt.PhpVal) bool {
	mut var_url_mutated := var_url
	if rt.is_true(this.return_false_on_fail) {
		return false
	}
	mut var_output := 
	return ().to_bool()
}

fn (mut this Class_WP_Embed) find_oembed_post_id(var_cache_key rt.PhpVal) rt.PhpVal {
}

fn create_wp_embed() &Class_WP_Embed {
	mut obj := &Class_WP_Embed{
		PhpObjectBase: rt.PhpObjectBase{}
		handlers: rt.new_array()
		post_ID: rt.new_null()
		usecache: false
		linkifunknown: rt.new_bool(true)
		last_attr: rt.new_array()
		last_url: rt.new_string('')
		return_false_on_fail: rt.new_bool(false)
	}
	obj.construct()
	return obj
}

fn (mut this Class_WP_Embed) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'run_shortcode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.run_shortcode(dispatch_arg_0)
		}
		'maybe_run_ajax_cache' {
			this.maybe_run_ajax_cache()
			return rt.new_null()
		}
		'register_handler' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			this.register_handler(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'unregister_handler' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.unregister_handler(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_embed_handler_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.get_embed_handler_html(dispatch_arg_0, dispatch_arg_1))
		}
		'shortcode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.shortcode(dispatch_arg_0, dispatch_arg_1))
		}
		'delete_oembed_caches' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_oembed_caches(dispatch_arg_0)
			return rt.new_null()
		}
		'cache_oembed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.cache_oembed(dispatch_arg_0)
			return rt.new_null()
		}
		'autoembed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.autoembed(dispatch_arg_0)
		}
		'autoembed_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.autoembed_callback(dispatch_arg_0))
		}
		'maybe_make_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.maybe_make_link(dispatch_arg_0))
		}
		'find_oembed_post_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.find_oembed_post_id(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_Embed) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'handlers' { return this.handlers }
		'post_ID' { return this.post_ID }
		'usecache' { return rt.new_bool(this.usecache) }
		'linkifunknown' { return this.linkifunknown }
		'last_attr' { return this.last_attr }
		'last_url' { return this.last_url }
		'return_false_on_fail' { return this.return_false_on_fail }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Embed) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'handlers' { this.handlers = val; return true }
		'post_ID' { this.post_ID = val; return true }
		'usecache' { this.usecache = (val).to_bool(); return true }
		'linkifunknown' { this.linkifunknown = val; return true }
		'last_attr' { this.last_attr = val; return true }
		'last_url' { this.last_url = val; return true }
		'return_false_on_fail' { this.return_false_on_fail = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_class_wp_embed_php() {
}
