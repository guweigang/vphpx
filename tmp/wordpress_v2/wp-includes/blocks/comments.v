import rt

fn render_block_core_comments(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_post_id := rt.new_null()
	mut var_is_legacy := false
	mut var_post_before := rt.new_null()
	mut var_post := rt.new_null()
	mut var_output := rt.new_null()
	mut var_classnames := []rt.PhpVal{}
	mut var_wrapper_attributes := rt.new_null()
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))) {
		return ''
	}
	var_post_id = rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('comments_open', [var_post_id.clone()])))))
		&& rt.new_int((rt.call_function('get_comments_number', [var_post_id.clone()])).to_i64()) == 0 {
		return ''
	}
	var_is_legacy =
		rt.is_true(rt.identical(rt.new_string('core/post-comments'), rt.get_property(var_block, 'name')))
		|| !(!rt.is_true(var_attributes.array_get(rt.new_string('legacy'))))
	if !var_is_legacy {
		return (rt.call_method(var_block, 'render', [
			rt.create_array([rt.ArrayItem{ key: 'dynamic', val: false }]),
		])).str()
	}
	var_post_before = var_post.clone()
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	rt.call_function('setup_postdata', [var_post.clone()])
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('add_filter', [rt.new_string('deprecated_file_trigger_error'),
		rt.new_string('__return_false')])
	rt.call_function('comments_template', []rt.PhpVal{})
	rt.call_function('remove_filter', [rt.new_string('deprecated_file_trigger_error'),
		rt.new_string('__return_false')])
	var_output = rt.call_function('ob_get_clean', []rt.PhpVal{})
	var_post = var_post_before.clone()
	var_classnames = []rt.PhpVal{}
	if var_attributes.array_isset(rt.new_string('legacy')) {
		var_classnames << 'wp-block-post-comments'
	}
	if var_attributes.array_isset(rt.new_string('textAlign')) {
		var_classnames << 'has-text-align-' +
			(var_attributes.array_get(rt.new_string('textAlign'))).str()
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [
				rt.new_string(' '),
				rt.create_array_from_list(var_classnames),
			]) },
		]),
	])
	rt.call_function('wp_enqueue_script', [rt.new_string('comment-reply')])
	enqueue_legacy_post_comments_block_styles(rt.get_property(var_block, 'name'))
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.clone(), var_output.clone()])).str()
}

fn register_block_core_comments() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/comments'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_comments' },
			rt.ArrayItem{ key: 'skip_inner_blocks', val: true },
		]),
	])
}

fn comments_block_form_defaults(var_fields rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		var_fields['submit_button'] =
			'<input name="%1$s" type="submit" id="%2$s" class="%3$s wp-block-button__link ' +
			(rt.call_function('wp_theme_get_element_class_name', [rt.new_string('button')])).str() +
			'" value="%4$s" />'
		var_fields['submit_field'] = '<p class="form-submit wp-block-button">%1$s %2$s</p>'
	}
	return var_fields.clone()
}

fn enqueue_legacy_post_comments_block_styles(var_block_name rt.PhpVal) {
	mut var_handles := []rt.PhpVal{}
	mut var_handle := rt.new_null()
	mut var_are_styles_enqueued := false
	if !var_are_styles_enqueued {
		var_handles = ['wp-block-post-comments', 'wp-block-buttons', 'wp-block-button']
		for var_handle_shadow in var_handles {
			rt.call_function('wp_enqueue_block_style', [var_block_name.clone(),
				rt.create_array([
					rt.ArrayItem{ key: 'handle', val: rt.new_string(var_handle_shadow.str()) },
				])])
		}
		var_are_styles_enqueued = true
	}
}

fn register_legacy_post_comments_block() {
	mut var_registry := rt.new_null()
	mut var_metadata := rt.new_null()
	mut iife_temp_0 := Class_WP_Block_Type_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	var_registry = iife_result_0
	if rt.is_true(rt.call_method(var_registry, 'is_registered', [
		rt.new_string('core/post-comments'),
	]))
	{
		rt.call_function('unregister_block_type', [rt.new_string('core/post-comments')])
	}
	var_metadata = rt.create_array([
		rt.ArrayItem{ key: 'name', val: 'core/post-comments' },
		rt.ArrayItem{ key: 'category', val: 'theme' },
		rt.ArrayItem{ key: 'attributes', val: rt.create_array([
			rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
			]) },
		]) },
		rt.ArrayItem{ key: 'uses_context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'postId' },
			rt.ArrayItem{ key: none, val: 'postType' },
		]) },
		rt.ArrayItem{ key: 'supports', val: rt.create_array([
			rt.ArrayItem{ key: 'html', val: false },
			rt.ArrayItem{ key: 'align', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wide' },
				rt.ArrayItem{ key: none, val: 'full' },
			]) },
			rt.ArrayItem{ key: 'typography', val: rt.create_array([
				rt.ArrayItem{ key: 'fontSize', val: true },
				rt.ArrayItem{ key: 'lineHeight', val: true },
				rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
				rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
				rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
				rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
				rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'color', val: rt.create_array([
				rt.ArrayItem{ key: 'gradients', val: true },
				rt.ArrayItem{ key: 'link', val: true },
				rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'text', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'inserter', val: false },
		]) },
		rt.ArrayItem{ key: 'style', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wp-block-post-comments' },
			rt.ArrayItem{ key: none, val: 'wp-block-buttons' },
			rt.ArrayItem{ key: none, val: 'wp-block-button' },
		]) },
		rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_comments' },
		rt.ArrayItem{ key: 'skip_inner_blocks', val: true },
	])
	var_metadata = rt.call_function('apply_filters', [
		rt.new_string('block_type_metadata'),
		var_metadata.clone(),
	])
	rt.call_function('register_block_type', [rt.new_string('core/post-comments'),
		var_metadata.clone()])
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

fn create_wp_block_type_registry(_args ...rt.PhpVal) &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action',
		[rt.new_string('init'), rt.new_string('register_block_core_comments')])
	rt.call_function('add_filter', [rt.new_string('comment_form_defaults'),
		rt.new_string('comments_block_form_defaults')])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_legacy_post_comments_block'),
		rt.new_int(21)])
}
