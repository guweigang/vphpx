import rt

fn get_bloginfo_rss(show string) rt.PhpVal {
	mut var_info := rt.call_function('strip_tags', [rt.call_function('get_bloginfo', [rt.new_string(show)])])
	return rt.call_function('apply_filters', [rt.new_string('get_bloginfo_rss'), rt.call_function('convert_chars', [var_info.dup()]), rt.new_string(show)])
}

fn bloginfo_rss(show string) {
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('bloginfo_rss'), get_bloginfo_rss(show), rt.new_string(show)]))
}

fn get_default_feed() rt.PhpVal {
	mut var_default_feed := rt.call_function('apply_filters', [rt.new_string('default_feed'), rt.new_string('rss2')])
	return if rt.is_true(rt.identical(rt.new_string('rss'), var_default_feed)) { rt.new_string('rss2') } else { var_default_feed }
}

fn get_wp_title_rss(deprecated string) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN), rt.new_string('4.4.0'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Use the %s filter instead.')]), rt.new_string('<code>document_title_separator</code>')])])
	}
	return rt.call_function('apply_filters', [rt.new_string('get_wp_title_rss'), rt.call_function('wp_get_document_title', []rt.PhpVal{}), rt.new_string(deprecated)])
}

fn wp_title_rss(deprecated string) {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN), rt.new_string('4.4.0'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Use the %s filter instead.')]), rt.new_string('<code>document_title_separator</code>')])])
	}
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('wp_title_rss'), get_wp_title_rss(''), rt.new_string(deprecated)]))
}

fn get_the_title_rss(post i64) rt.PhpVal {
	mut var_title := rt.call_function('get_the_title', [rt.new_int(post)])
	return rt.call_function('apply_filters', [rt.new_string('the_title_rss'), var_title.dup()])
}

fn the_title_rss() {
	rt.echo_val(get_the_title_rss(0))
}

fn get_the_content_feed(var_feed_type rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_feed_type)))) {
		var_feed_type = get_default_feed()
	}
	mut var_content := rt.call_function('apply_filters', [rt.new_string('the_content'), rt.call_function('get_the_content', []rt.PhpVal{})])
	var_content = rt.call_function('str_replace', [rt.new_string(']]>'), rt.new_string(']]&gt;'), var_content.dup()])
	return rt.call_function('apply_filters', [rt.new_string('the_content_feed'), var_content.dup(), var_feed_type.dup()])
}

fn the_content_feed(var_feed_type rt.PhpVal) {
	rt.echo_val(get_the_content_feed(var_feed_type.dup()))
}

fn the_excerpt_rss() {
	mut var_output := rt.call_function('get_the_excerpt', []rt.PhpVal{})
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('the_excerpt_rss'), var_output.dup()]))
}

fn the_permalink_rss() {
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('apply_filters', [rt.new_string('the_permalink_rss'), rt.call_function('get_permalink', []rt.PhpVal{})])]))
}

fn comments_link_feed() {
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('apply_filters', [rt.new_string('comments_link_feed'), rt.call_function('get_comments_link', []rt.PhpVal{})])]))
}

fn comment_guid(var_comment_id rt.PhpVal) {
	rt.echo_val(rt.call_function('esc_url', [get_comment_guid(var_comment_id.dup())]))
}

fn get_comment_guid(var_comment_id rt.PhpVal) rt.PhpVal {
	mut var_comment := rt.call_function('get_comment', [var_comment_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_comment.dup().is_object()))))) {
		return rt.new_bool(false)
	}
	return rt.new_string((rt.call_function('get_the_guid', [rt.get_property(var_comment, 'comment_post_ID')])).str() + '#comment-' + (rt.get_property(var_comment, 'comment_ID')).str())
}

fn comment_link(var_comment rt.PhpVal) {
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('apply_filters', [rt.new_string('comment_link'), rt.call_function('get_comment_link', [var_comment.dup()])])]))
}

fn get_comment_author_rss() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('comment_author_rss'), rt.call_function('get_comment_author', []rt.PhpVal{})])
}

fn comment_author_rss() {
	rt.echo_val(get_comment_author_rss())
}

fn comment_text_rss() {
	mut var_comment_text := rt.call_function('get_comment_text', []rt.PhpVal{})
	var_comment_text = rt.call_function('apply_filters', [rt.new_string('comment_text_rss'), var_comment_text.dup()])
	rt.echo_val(var_comment_text)
}

fn get_the_category_rss(var_type rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_type) {
		var_type = get_default_feed()
	}
	mut var_categories := rt.call_function('get_the_category', []rt.PhpVal{})
	mut var_tags := rt.call_function('get_the_tags', []rt.PhpVal{})
	mut var_the_list := ''
	mut var_cat_names := rt.new_array()
	mut var_filter := 'rss'
	if rt.is_true(rt.identical(rt.new_string('atom'), var_type)) {
		var_filter = 'raw'
	}
	if !(!rt.is_true(var_categories)) {
		{
			mut iter_1 := rt.cast_array(var_categories).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_category := item_1.val
				var_cat_names.array_push(rt.call_function('sanitize_term_field', [rt.new_string('name'), rt.get_property(var_category, 'name'), rt.get_property(var_category, 'term_id'), rt.new_string('category'), rt.new_string(var_filter).dup()]))
			}
		}
	}
	if !(!rt.is_true(var_tags)) {
		{
			mut iter_1 := rt.cast_array(var_tags).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_tag := item_1.val
				var_cat_names.array_push(rt.call_function('sanitize_term_field', [rt.new_string('name'), rt.get_property(var_tag, 'name'), rt.get_property(var_tag, 'term_id'), rt.new_string('post_tag'), rt.new_string(var_filter).dup()]))
			}
		}
	}
	var_cat_names = rt.call_function('array_unique', [var_cat_names.dup()])
	{
		mut iter_1 := var_cat_names.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cat_name := item_1.val
			if rt.is_true(rt.identical(rt.new_string('rdf'), var_type)) {
				// unsupported expression: Expr_AssignOp_Concat
			} else if rt.is_true(rt.identical(rt.new_string('atom'), var_type)) {
				// unsupported expression: Expr_AssignOp_Concat
			} else {
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('the_category_rss'), rt.new_string(var_the_list).dup(), var_type.dup()])
}

fn the_category_rss(var_type rt.PhpVal) {
	rt.echo_val(get_the_category_rss(var_type.dup()))
}

fn html_type_rss() {
	mut var_type := rt.call_function('get_bloginfo', [rt.new_string('html_type')])
	if rt.is_true(rt.call_function('str_contains', [var_type.dup(), rt.new_string('xhtml')])) {
		var_type = rt.new_string(rt.new_string('xhtml'))
	} else {
		var_type = rt.new_string(rt.new_string('html'))
	}
	rt.echo_val(var_type)
}

fn rss_enclosure() {
	if rt.is_true(rt.call_function('post_password_required', []rt.PhpVal{})) {
		return rt.new_null()
	}
	{
		mut iter_1 := rt.cast_array(rt.call_function('get_post_custom', []rt.PhpVal{})).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_val := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.identical(rt.new_string('enclosure'), var_key)) {
				{
					mut iter_2 := rt.cast_array(var_val).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_enc := item_2.val
						mut var_enclosure := rt.call_function('explode', [rt.new_string('\n'), var_enc.dup()])
						if var_enclosure.dup().array_count() < 3 {
							continue
						}
						mut var_t := rt.call_function('preg_split', [rt.new_string('/[ \\t]/'), rt.new_string(var_enclosure.array_get(2).to_string().trim_space())])
						mut var_type := var_t.array_get(0)
						rt.echo_val(rt.call_function('apply_filters', [rt.new_string('rss_enclosure'), '<enclosure url="' + (rt.call_function('esc_url', [rt.new_string(var_enclosure.array_get(0).to_string().trim_space())])).str() + '" length="' + (rt.call_function('absint', [rt.new_string(var_enclosure.array_get(1).to_string().trim_space())])).str() + '" type="' + (rt.call_function('esc_attr', [var_type.dup()])).str() + '" />' + '\n']))
					}
				}
			}
		}
	}
}

fn atom_enclosure() {
	if rt.is_true(rt.call_function('post_password_required', []rt.PhpVal{})) {
		return rt.new_null()
	}
	{
		mut iter_1 := rt.cast_array(rt.call_function('get_post_custom', []rt.PhpVal{})).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_val := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.identical(rt.new_string('enclosure'), var_key)) {
				{
					mut iter_2 := rt.cast_array(var_val).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_enc := item_2.val
						mut var_enclosure := rt.call_function('explode', [rt.new_string('\n'), var_enc.dup()])
						mut var_url := ''
						mut var_type := ''
						mut var_length := rt.new_int(rt.new_int(0))
						mut var_mimes := rt.call_function('get_allowed_mime_types', []rt.PhpVal{})
						if rt.is_true(rt.new_bool(var_enclosure.array_isset(rt.new_int(0)) && rt.is_true(rt.new_bool(var_enclosure.array_get(0).is_string())))) {
							var_url = var_enclosure.array_get(0).to_string().trim_space()
						}
						{
							mut var_i := 1
							for {
								if !(var_i <= 2) { break }
								if var_enclosure.array_isset(rt.new_int(var_i)) {
									if rt.is_true(rt.new_bool(var_enclosure.array_get(var_i).is_long() || var_enclosure.array_get(var_i).is_double())) {
										var_length = rt.new_string(rt.new_string(.to_string().trim_space()))
									} else if rt.is_true(rt.call_function('in_array', [.array_get(), var_mimes.dup(), rt.new_bool(true)])) {
										var_type = 
									}
								}
								var_i += 1
							}
						}
						mut var_html_link_tag := rt.call_function('sprintf', [, , , ])
						rt.echo_val(rt.call_function('apply_filters', [, .dup()]))
					}
				}
			}
		}
	}
}

fn prep_atom_text_construct(var_data rt.PhpVal) rt.PhpVal {
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	
	return rt.new_null()
}



pub fn init_wp_includes_feed_php() {
}
