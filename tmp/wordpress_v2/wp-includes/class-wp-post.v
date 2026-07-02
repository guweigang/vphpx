import rt

struct Class_WP_Post {
	rt.PhpObjectBase
pub mut:
	ID                    rt.PhpVal = rt.new_null()
	post_author           rt.PhpVal = rt.new_string('0')
	post_date             rt.PhpVal = rt.new_string('0000-00-00 00:00:00')
	post_date_gmt         rt.PhpVal = rt.new_string('0000-00-00 00:00:00')
	post_content          rt.PhpVal = rt.new_string('')
	post_title            rt.PhpVal = rt.new_string('')
	post_excerpt          rt.PhpVal = rt.new_string('')
	post_status           rt.PhpVal = rt.new_string('publish')
	comment_status        rt.PhpVal = rt.new_string('open')
	ping_status           rt.PhpVal = rt.new_string('open')
	post_password         rt.PhpVal = rt.new_string('')
	post_name             rt.PhpVal = rt.new_string('')
	to_ping               rt.PhpVal = rt.new_string('')
	pinged                rt.PhpVal = rt.new_string('')
	post_modified         rt.PhpVal = rt.new_string('0000-00-00 00:00:00')
	post_modified_gmt     rt.PhpVal = rt.new_string('0000-00-00 00:00:00')
	post_content_filtered rt.PhpVal = rt.new_string('')
	post_parent           rt.PhpVal = rt.new_int(0)
	guid                  rt.PhpVal = rt.new_string('')
	menu_order            rt.PhpVal = rt.new_int(0)
	post_type             rt.PhpVal = rt.new_string('post')
	post_mime_type        rt.PhpVal = rt.new_string('')
	comment_count         rt.PhpVal = rt.new_string('0')
	filter                rt.PhpVal = rt.new_null()
}

fn Class_WP_Post.get_instance(var_post_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_post_id_mutated := var_post_id
	var_post_id_mutated = rt.new_int(var_post_id_mutated.to_i64())
	if rt.is_true(rt.less_equal(var_post_id_mutated, rt.new_int(0))) {
		return false
	}
	mut var__post := rt.call_function('wp_cache_get', [var_post_id_mutated.clone(),
		rt.new_string('posts')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var__post)))) {
		var__post = rt.call_method(var_wpdb, 'get_row', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
					'posts')), rt.new_string(' WHERE ID = %d LIMIT 1')),
				var_post_id_mutated.clone(),
			]),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var__post)))) {
			return false
		}
		var__post = rt.call_function('sanitize_post', [var__post.clone(),
			rt.new_string('raw')])
		rt.call_function('wp_cache_add', [rt.get_property(var__post, 'ID'),
			var__post.clone(), rt.new_string('posts')])
	} else if !rt.is_true(rt.get_property(var__post, 'filter'))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('raw'), rt.get_property(var__post, 'filter'))))) {
		var__post = rt.call_function('sanitize_post', [var__post.clone(),
			rt.new_string('raw')])
	}
	return (create_wp_post(var__post.clone())).to_bool()
}

fn (mut this Class_WP_Post) construct(var_post rt.PhpVal) {
	mut var_post_mutated := var_post
	mut iter_1 := rt.call_function('get_object_vars', [var_post_mutated.clone()]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":267,"name":"key"}',
			var_value.clone())
	}
}

fn (mut this Class_WP_Post) magic_isset(var_key rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_string('ancestors'), var_key)) {
		return true
	}
	if rt.is_true(rt.identical(rt.new_string('page_template'), var_key)) {
		return true
	}
	if rt.is_true(rt.identical(rt.new_string('post_category'), var_key)) {
		return true
	}
	if rt.is_true(rt.identical(rt.new_string('tags_input'), var_key)) {
		return true
	}
	return (rt.call_function('metadata_exists', [rt.new_string('post'), this.ID, var_key.clone()])).to_bool()
}

fn (mut this Class_WP_Post) magic_get(var_key rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('page_template'), var_key))
		&& this.magic_isset(var_key.clone()) {
		return rt.call_function('get_post_meta', [this.ID, rt.new_string('_wp_page_template'),
			rt.new_bool(true)])
	}
	if rt.is_true(rt.identical(rt.new_string('post_category'), var_key)) {
		if rt.is_true(rt.call_function('is_object_in_taxonomy', [this.post_type,
			rt.new_string('category')]))
		{
			mut var_terms := rt.call_function('get_the_terms', [
				rt.new_object('WP_Post', []string{}, &this),
				rt.new_string('category'),
			])
		}
		if !rt.is_true(var_terms) {
			return rt.new_array()
		}
		return rt.call_function('wp_list_pluck', [var_terms.clone(),
			rt.new_string('term_id')])
	}
	if rt.is_true(rt.identical(rt.new_string('tags_input'), var_key)) {
		if rt.is_true(rt.call_function('is_object_in_taxonomy', [this.post_type,
			rt.new_string('post_tag')]))
		{
			var_terms = rt.call_function('get_the_terms', [
				rt.new_object('WP_Post', []string{}, &this),
				rt.new_string('post_tag'),
			])
		}
		if !rt.is_true(var_terms) {
			return rt.new_array()
		}
		return rt.call_function('wp_list_pluck', [var_terms.clone(),
			rt.new_string('name')])
	}
	if rt.is_true(rt.identical(rt.new_string('ancestors'), var_key)) {
		mut var_value := rt.call_function('get_post_ancestors', [
			rt.new_object('WP_Post', []string{}, &this),
		])
	} else {
		var_value = rt.call_function('get_post_meta', [this.ID, var_key.clone(),
			rt.new_bool(true)])
	}
	if rt.is_true(this.filter) {
		var_value = rt.call_function('sanitize_post_field', [
			var_key.clone(), var_value.clone(), this.ID, this.filter])
	}
	return var_value.clone()
}

fn (mut this Class_WP_Post) filter(var_filter rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(this.filter, var_filter)) {
		return rt.new_object('WP_Post', []string{}, this)
	}
	if rt.is_true(rt.identical(rt.new_string('raw'), var_filter)) {
		return Class_WP_Post.get_instance(this.ID)
	}
	return rt.call_function('sanitize_post', [
		rt.new_object('WP_Post', []string{}, &this),
		var_filter.clone(),
	])
}

fn (mut this Class_WP_Post) to_array() rt.PhpVal {
	mut var_post := rt.call_function('get_object_vars', [
		rt.new_object('WP_Post', []string{}, &this),
	])
	mut iter_2 := rt.create_array([rt.ArrayItem{ key: none, val: 'ancestors' },
		rt.ArrayItem{ key: none, val: 'page_template' }, rt.ArrayItem{
			key: none
			val: 'post_category'
		}, rt.ArrayItem{ key: none, val: 'tags_input' }]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_key := item_2.val
		if this.magic_isset(var_key.clone()) {
			var_post.array_set(var_key, this.magic_get(var_key.clone()))
		}
	}
	return var_post.clone()
}

fn create_wp_post(arg_0 rt.PhpVal) &Class_WP_Post {
	mut obj := &Class_WP_Post{
		PhpObjectBase:         rt.PhpObjectBase{}
		ID:                    rt.new_null()
		post_author:           rt.new_string('0')
		post_date:             rt.new_string('0000-00-00 00:00:00')
		post_date_gmt:         rt.new_string('0000-00-00 00:00:00')
		post_content:          rt.new_string('')
		post_title:            rt.new_string('')
		post_excerpt:          rt.new_string('')
		post_status:           rt.new_string('publish')
		comment_status:        rt.new_string('open')
		ping_status:           rt.new_string('open')
		post_password:         rt.new_string('')
		post_name:             rt.new_string('')
		to_ping:               rt.new_string('')
		pinged:                rt.new_string('')
		post_modified:         rt.new_string('0000-00-00 00:00:00')
		post_modified_gmt:     rt.new_string('0000-00-00 00:00:00')
		post_content_filtered: rt.new_string('')
		post_parent:           rt.new_int(0)
		guid:                  rt.new_string('')
		menu_order:            rt.new_int(0)
		post_type:             rt.new_string('post')
		post_mime_type:        rt.new_string('')
		comment_count:         rt.new_string('0')
		filter:                rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WP_Post) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Post.get_instance(dispatch_arg_0))
		}
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.magic_isset(dispatch_arg_0))
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter(dispatch_arg_0)
		}
		'to_array' {
			return this.to_array()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Post) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'ID' { return this.ID }
		'post_author' { return this.post_author }
		'post_date' { return this.post_date }
		'post_date_gmt' { return this.post_date_gmt }
		'post_content' { return this.post_content }
		'post_title' { return this.post_title }
		'post_excerpt' { return this.post_excerpt }
		'post_status' { return this.post_status }
		'comment_status' { return this.comment_status }
		'ping_status' { return this.ping_status }
		'post_password' { return this.post_password }
		'post_name' { return this.post_name }
		'to_ping' { return this.to_ping }
		'pinged' { return this.pinged }
		'post_modified' { return this.post_modified }
		'post_modified_gmt' { return this.post_modified_gmt }
		'post_content_filtered' { return this.post_content_filtered }
		'post_parent' { return this.post_parent }
		'guid' { return this.guid }
		'menu_order' { return this.menu_order }
		'post_type' { return this.post_type }
		'post_mime_type' { return this.post_mime_type }
		'comment_count' { return this.comment_count }
		'filter' { return this.filter }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Post) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'ID' {
			this.ID = val
			return true
		}
		'post_author' {
			this.post_author = val
			return true
		}
		'post_date' {
			this.post_date = val
			return true
		}
		'post_date_gmt' {
			this.post_date_gmt = val
			return true
		}
		'post_content' {
			this.post_content = val
			return true
		}
		'post_title' {
			this.post_title = val
			return true
		}
		'post_excerpt' {
			this.post_excerpt = val
			return true
		}
		'post_status' {
			this.post_status = val
			return true
		}
		'comment_status' {
			this.comment_status = val
			return true
		}
		'ping_status' {
			this.ping_status = val
			return true
		}
		'post_password' {
			this.post_password = val
			return true
		}
		'post_name' {
			this.post_name = val
			return true
		}
		'to_ping' {
			this.to_ping = val
			return true
		}
		'pinged' {
			this.pinged = val
			return true
		}
		'post_modified' {
			this.post_modified = val
			return true
		}
		'post_modified_gmt' {
			this.post_modified_gmt = val
			return true
		}
		'post_content_filtered' {
			this.post_content_filtered = val
			return true
		}
		'post_parent' {
			this.post_parent = val
			return true
		}
		'guid' {
			this.guid = val
			return true
		}
		'menu_order' {
			this.menu_order = val
			return true
		}
		'post_type' {
			this.post_type = val
			return true
		}
		'post_mime_type' {
			this.post_mime_type = val
			return true
		}
		'comment_count' {
			this.comment_count = val
			return true
		}
		'filter' {
			this.filter = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
