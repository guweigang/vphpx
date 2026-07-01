import rt

fn block_core_comment_template_render_comments(var_comments rt.PhpVal, var_block rt.PhpVal) string {
	// unsupported statement: Stmt_Global
	mut var_thread_comments := rt.call_function('get_option', [
		rt.new_string('thread_comments'),
	])
	mut var_thread_comments_depth := rt.call_function('get_option', [
		rt.new_string('thread_comments_depth'),
	])
	if var_comment_depth == 0 {
		mut var_comment_depth := 1
	}
	mut var_content := ''
	{
		mut iter_1 := var_comments.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_comment := item_1.val
			mut var_comment_id := rt.get_property(var_comment, 'comment_ID')
			closure_1_fn := fn [var_comment_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_context := if args.len > 0 { args[0].dup() } else { rt.new_null() }
				var_context.array_set('commentId', var_comment_id.dup())
				return var_context.str()
			}
			mut var_filter_block_context := rt.new_closure(closure_1_fn)
			rt.call_function('add_filter', [rt.new_string('render_block_context'),
				var_filter_block_context.dup(), rt.new_int(1)])
			mut var_block_content := rt.call_method(create_wp_block(rt.get_property(var_block,
				'parsed_block')), 'render', [
				rt.create_array([rt.ArrayItem{ key: 'dynamic', val: false }]),
			])
			rt.call_function('remove_filter', [rt.new_string('render_block_context'),
				var_filter_block_context.dup(), rt.new_int(1)])
			mut var_children := rt.call_method(var_comment, 'get_children', []rt.PhpVal{})
			mut var_comment_classes := rt.call_function('comment_class', [
				rt.new_string(''),
				rt.get_property(var_comment, 'comment_ID'),
				rt.get_property(var_comment, 'comment_post_ID'),
				rt.new_bool(false),
			])
			if !(!rt.is_true(var_children)) && !(!rt.is_true(var_thread_comments)) {
				if rt.is_true(rt.less(rt.new_int(var_comment_depth), var_thread_comments_depth)) {
					var_comment_depth += 1
					mut var_inner_content := rt.new_string(rt.new_string(block_core_comment_template_render_comments(var_children.dup(),
						var_block.dup())))
					// unsupported expression: Expr_AssignOp_Concat
					var_comment_depth -= 1
				} else {
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return var_content
}

fn render_block_core_comment_template(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !rt.is_true(rt.get_property(var_block, 'context').array_get('postId')) {
		return ''
	}
	if rt.is_true(rt.call_function('post_password_required', [
		rt.get_property(var_block, 'context').array_get('postId')]))
	{
		return ''
	}
	mut var_comment_query := create_wp_comment_query(rt.call_function('build_comment_query_vars_from_block', [
		var_block.dup(),
	]))
	mut var_comments := var_comment_query.get_comments()
	if var_comments.dup().array_count() == 0 {
		return ''
	}
	mut var_comment_order := rt.call_function('get_option', [
		rt.new_string('comment_order'),
	])
	if rt.is_true(rt.identical(rt.new_string('desc'), var_comment_order)) {
		var_comments = rt.call_function('array_reverse', [var_comments.dup()])
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	return (rt.call_function('sprintf', [rt.new_string('<ol %1$s>%2$s</ol>'),
		var_wrapper_attributes.dup(),
		rt.new_string(block_core_comment_template_render_comments(var_comments.dup(),
			var_block.dup()))])).str()
}

fn register_block_core_comment_template() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/comment-template',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_comment_template' },
			rt.ArrayItem{ key: 'skip_inner_blocks', val: true },
		])])
}

struct Class_WP_Block {
	rt.PhpObjectBase
}

struct Class_WP_Comment_Query {
	rt.PhpObjectBase
}

fn create_wp_block() &Class_WP_Block {
	mut obj := &Class_WP_Block{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_comment_query() &Class_WP_Comment_Query {
	mut obj := &Class_WP_Comment_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Comment_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Comment_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Comment_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_blocks_comment_template_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_comment_template')])
}
