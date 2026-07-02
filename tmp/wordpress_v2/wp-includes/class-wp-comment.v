import rt

struct Class_WP_Comment {
	rt.PhpObjectBase
pub mut:
	comment_ID           rt.PhpVal = rt.new_null()
	comment_post_ID      rt.PhpVal = rt.new_string('0')
	comment_author       rt.PhpVal = rt.new_string('')
	comment_author_email rt.PhpVal = rt.new_string('')
	comment_author_url   rt.PhpVal = rt.new_string('')
	comment_author_IP    rt.PhpVal = rt.new_string('')
	comment_date         rt.PhpVal = rt.new_string('0000-00-00 00:00:00')
	comment_date_gmt     rt.PhpVal = rt.new_string('0000-00-00 00:00:00')
	comment_content      rt.PhpVal = rt.new_null()
	comment_karma        rt.PhpVal = rt.new_string('0')
	comment_approved     rt.PhpVal = rt.new_string('1')
	comment_agent        rt.PhpVal = rt.new_string('')
	comment_type         rt.PhpVal = rt.new_string('comment')
	comment_parent       rt.PhpVal = rt.new_string('0')
	user_id              rt.PhpVal = rt.new_string('0')
	children             rt.PhpVal = rt.new_null()
	populated_children   rt.PhpVal = rt.new_bool(false)
	post_fields          rt.PhpVal = rt.new_array()
}

fn Class_WP_Comment.get_instance(var_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_comment_id := rt.new_int(var_id.to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_comment_id)))) {
		return false
	}
	mut var__comment := rt.call_function('wp_cache_get', [var_comment_id.clone(),
		rt.new_string('comment')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var__comment)))) {
		var__comment = rt.call_method(var_wpdb, 'get_row', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
					'comments')), rt.new_string(' WHERE comment_ID = %d LIMIT 1')),
				var_comment_id.clone(),
			]),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var__comment)))) {
			return false
		}
		rt.call_function('wp_cache_add', [rt.get_property(var__comment, 'comment_ID'),
			var__comment.clone(), rt.new_string('comment')])
	}
	return (create_wp_comment(var__comment.clone())).to_bool()
}

fn (mut this Class_WP_Comment) construct(var_comment rt.PhpVal) {
	mut iter_1 := rt.call_function('get_object_vars', [var_comment.clone()]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":217,"name":"key"}',
			var_value.clone())
	}
}

fn (mut this Class_WP_Comment) to_array() rt.PhpVal {
	return rt.call_function('get_object_vars', [
		rt.new_object('WP_Comment', []string{}, &this),
	])
}

fn (mut this Class_WP_Comment) get_children(var_args rt.PhpVal) rt.PhpVal {
	mut var_defaults := {
		'format':       'tree'
		'status':       'all'
		'hierarchical': 'threaded'
		'orderby':      ''
	}
	mut var__args := rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array_from_native_map(var_defaults)])
	var__args.array_set('parent', this.comment_ID)
	if rt.is_true(rt.new_bool(this.children.is_null())) {
		if rt.is_true(this.populated_children) {
			this.children = rt.new_array()
		} else {
			this.children = rt.call_function('get_comments', [
				var__args.clone()])
		}
	}
	if rt.is_true(rt.identical(rt.new_string('flat'), var__args.array_get(rt.new_string('format')))) {
		mut var_children := rt.new_array()
		mut iter_2 := this.children.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_child := item_2.val
			mut var_child_args := var__args.clone()
			var_child_args.array_set('format', 'flat')
			var_child_args.array_unset(rt.new_string('parent'))
			var_children = rt.call_function('array_merge', [var_children.clone(),
				rt.create_array([rt.ArrayItem{ key: none, val: var_child }]),
				rt.call_method(var_child, 'get_children', [var_child_args.clone()])])
		}
	} else {
		var_children = this.children
	}
	return var_children.clone()
}

fn (mut this Class_WP_Comment) add_child(mut var_child Class_WP_Comment) {
	this.children.array_set(var_child.comment_ID, var_child)
}

fn (mut this Class_WP_Comment) get_child(var_child_id rt.PhpVal) rt.PhpVal {
	return if !(this.children.array_get(var_child_id)).is_null() {
		this.children.array_get(var_child_id)
	} else {
		rt.new_bool(false)
	}
}

fn (mut this Class_WP_Comment) populated_children(var_set rt.PhpVal) {
	this.populated_children = var_set.to_bool()
}

fn (mut this Class_WP_Comment) magic_isset(var_name rt.PhpVal) bool {
	if rt.is_true(rt.call_function('in_array', [var_name.clone(), this.post_fields, rt.new_bool(true)]))
		&& rt.is_true(rt.new_bool(0 != rt.new_int((this.comment_post_ID).to_i64()))) {
		mut var_post := rt.call_function('get_post', [this.comment_post_ID])
		return (rt.call_function('property_exists', [var_post.clone(),
			var_name.clone()])).to_bool()
	}
	return false
}

fn (mut this Class_WP_Comment) magic_get(var_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('in_array',
		[var_name.clone(), this.post_fields, rt.new_bool(true)]))
	{
		mut var_post := rt.call_function('get_post', [this.comment_post_ID])
		return rt.get_property(var_post, '{"nodeType":"Expr_Variable","line":375,"name":"name"}')
	}
	return rt.new_null()
}

fn create_wp_comment(arg_0 rt.PhpVal) &Class_WP_Comment {
	mut obj := &Class_WP_Comment{
		PhpObjectBase:        rt.PhpObjectBase{}
		comment_ID:           rt.new_null()
		comment_post_ID:      rt.new_string('0')
		comment_author:       rt.new_string('')
		comment_author_email: rt.new_string('')
		comment_author_url:   rt.new_string('')
		comment_author_IP:    rt.new_string('')
		comment_date:         rt.new_string('0000-00-00 00:00:00')
		comment_date_gmt:     rt.new_string('0000-00-00 00:00:00')
		comment_content:      rt.new_null()
		comment_karma:        rt.new_string('0')
		comment_approved:     rt.new_string('1')
		comment_agent:        rt.new_string('')
		comment_type:         rt.new_string('comment')
		comment_parent:       rt.new_string('0')
		user_id:              rt.new_string('0')
		children:             rt.new_null()
		populated_children:   rt.new_bool(false)
		post_fields:          rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WP_Comment) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Comment.get_instance(dispatch_arg_0))
		}
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'to_array' {
			return this.to_array()
		}
		'get_children' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_children(dispatch_arg_0)
		}
		'add_child' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Comment](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.add_child(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_child' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_child(dispatch_arg_0)
		}
		'populated_children' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.populated_children(dispatch_arg_0)
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
		else {
			return none
		}
	}
}

fn (this &Class_WP_Comment) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'comment_ID' { return this.comment_ID }
		'comment_post_ID' { return this.comment_post_ID }
		'comment_author' { return this.comment_author }
		'comment_author_email' { return this.comment_author_email }
		'comment_author_url' { return this.comment_author_url }
		'comment_author_IP' { return this.comment_author_IP }
		'comment_date' { return this.comment_date }
		'comment_date_gmt' { return this.comment_date_gmt }
		'comment_content' { return this.comment_content }
		'comment_karma' { return this.comment_karma }
		'comment_approved' { return this.comment_approved }
		'comment_agent' { return this.comment_agent }
		'comment_type' { return this.comment_type }
		'comment_parent' { return this.comment_parent }
		'user_id' { return this.user_id }
		'children' { return this.children }
		'populated_children' { return this.populated_children }
		'post_fields' { return this.post_fields }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Comment) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'comment_ID' {
			this.comment_ID = val
			return true
		}
		'comment_post_ID' {
			this.comment_post_ID = val
			return true
		}
		'comment_author' {
			this.comment_author = val
			return true
		}
		'comment_author_email' {
			this.comment_author_email = val
			return true
		}
		'comment_author_url' {
			this.comment_author_url = val
			return true
		}
		'comment_author_IP' {
			this.comment_author_IP = val
			return true
		}
		'comment_date' {
			this.comment_date = val
			return true
		}
		'comment_date_gmt' {
			this.comment_date_gmt = val
			return true
		}
		'comment_content' {
			this.comment_content = val
			return true
		}
		'comment_karma' {
			this.comment_karma = val
			return true
		}
		'comment_approved' {
			this.comment_approved = val
			return true
		}
		'comment_agent' {
			this.comment_agent = val
			return true
		}
		'comment_type' {
			this.comment_type = val
			return true
		}
		'comment_parent' {
			this.comment_parent = val
			return true
		}
		'user_id' {
			this.user_id = val
			return true
		}
		'children' {
			this.children = val
			return true
		}
		'populated_children' {
			this.populated_children = val
			return true
		}
		'post_fields' {
			this.post_fields = val
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
