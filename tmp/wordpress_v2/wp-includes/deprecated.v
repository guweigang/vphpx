import rt
import crypto.md5

fn get_postdata(var_postid rt.PhpVal) rt.PhpVal {
	mut var_post := rt.new_null()
	mut var_postdata := map[string]rt.PhpVal{}
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('1.5.1'), rt.new_string('get_post()')])
	var_post = rt.call_function('get_post', [var_postid.clone()])
	var_postdata = {
		'ID':             rt.get_property(var_post, 'ID')
		'Author_ID':      rt.get_property(var_post, 'post_author')
		'Date':           rt.get_property(var_post, 'post_date')
		'Content':        rt.get_property(var_post, 'post_content')
		'Excerpt':        rt.get_property(var_post, 'post_excerpt')
		'Title':          rt.get_property(var_post, 'post_title')
		'Category':       rt.get_property(var_post, 'post_category')
		'post_status':    rt.get_property(var_post, 'post_status')
		'comment_status': rt.get_property(var_post, 'comment_status')
		'ping_status':    rt.get_property(var_post, 'ping_status')
		'post_password':  rt.get_property(var_post, 'post_password')
		'to_ping':        rt.get_property(var_post, 'to_ping')
		'pinged':         rt.get_property(var_post, 'pinged')
		'post_type':      rt.get_property(var_post, 'post_type')
		'post_name':      rt.get_property(var_post, 'post_name')
	}
	return var_postdata.clone()
}

fn start_wp() {
	mut var_wp_query := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('1.5.0'), rt.call_function('__', [
			rt.new_string('new WordPress Loop'),
		])])
	rt.call_method(var_wp_query, 'next_post', []rt.PhpVal{})
	rt.call_function('setup_postdata', [rt.call_function('get_post', []rt.PhpVal{})])
}

fn the_category_id(display bool) rt.PhpVal {
	mut var_display := display
	mut var_categories := rt.new_null()
	mut var_cat := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('0.71'), rt.new_string('get_the_category()')])
	var_categories = rt.call_function('get_the_category', []rt.PhpVal{})
	var_cat = rt.get_property(var_categories.array_get(rt.new_int(0)), 'term_id')
	if var_display {
		rt.echo_val(var_cat)
	}
	return var_cat.clone()
}

fn the_category_head(before string, after string) {
	mut var_before := before
	mut var_after := after
	mut var_categories := rt.new_null()
	mut var_currentcat := rt.new_null()
	mut var_previouscat := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('0.71'), rt.new_string('get_the_category_by_ID()')])
	var_categories = rt.call_function('get_the_category', []rt.PhpVal{})
	var_currentcat = rt.get_property(var_categories.array_get(rt.new_int(0)), 'category_id')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_currentcat, var_previouscat)))) {
		print(var_before)
		rt.echo_val(rt.call_function('get_the_category_by_ID', [
			var_currentcat.clone()]))
		print(var_after)
		var_previouscat = var_currentcat.clone()
	}
}

fn previous_post(format string, previous string, title string, in_same_cat string, limitprev i64, excluded_categories string) {
	mut var_format := format
	mut var_previous := previous
	mut var_title := title
	mut var_in_same_cat := in_same_cat
	mut var_limitprev := limitprev
	mut var_excluded_categories := excluded_categories
	mut var_post := rt.new_null()
	mut var_string := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.0.0'), rt.new_string('previous_post_link()')])
	if var_in_same_cat == ''
		|| rt.is_true(rt.equal(rt.new_string('no'), rt.new_string(var_in_same_cat.str()))) {
		var_in_same_cat = false
	} else {
		var_in_same_cat = true
	}
	var_post = rt.call_function('get_previous_post', [
		rt.new_string(var_in_same_cat.str()),
		rt.new_string(excluded_categories),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return
	}
	var_string = rt.new_string('<a href="' +
		(rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')])).str() + '">' +
		previous)
	if rt.is_true(rt.equal(rt.new_string('yes'), rt.new_string(title))) {
		var_string = rt.concat(var_string, rt.call_function('apply_filters', [
			rt.new_string('the_title'),
			rt.get_property(var_post, 'post_title'),
			rt.get_property(var_post, 'ID'),
		]))
	}
	var_string = rt.concat(var_string, rt.new_string('</a>'))
	var_format = (rt.call_function('str_replace', [rt.new_string('%'),
		var_string.clone(), rt.new_string(var_format.str())])).str()
	print(var_format)
}

fn next_post(format string, next string, title string, in_same_cat string, limitnext i64, excluded_categories string) {
	mut var_format := format
	mut var_next := next
	mut var_title := title
	mut var_in_same_cat := in_same_cat
	mut var_limitnext := limitnext
	mut var_excluded_categories := excluded_categories
	mut var_post := rt.new_null()
	mut var_string := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.0.0'), rt.new_string('next_post_link()')])
	if var_in_same_cat == ''
		|| rt.is_true(rt.equal(rt.new_string('no'), rt.new_string(var_in_same_cat.str()))) {
		var_in_same_cat = false
	} else {
		var_in_same_cat = true
	}
	var_post = rt.call_function('get_next_post', [rt.new_string(var_in_same_cat.str()),
		rt.new_string(excluded_categories)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return
	}
	var_string = rt.new_string('<a href="' +
		(rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')])).str() + '">' + next)
	if rt.is_true(rt.equal(rt.new_string('yes'), rt.new_string(title))) {
		var_string = rt.concat(var_string, rt.call_function('apply_filters', [
			rt.new_string('the_title'),
			rt.get_property(var_post, 'post_title'),
			rt.get_property(var_post, 'ID'),
		]))
	}
	var_string = rt.concat(var_string, rt.new_string('</a>'))
	var_format = (rt.call_function('str_replace', [rt.new_string('%'),
		var_string.clone(), rt.new_string(var_format.str())])).str()
	print(var_format)
}

fn user_can_create_post(var_user_id rt.PhpVal, blog_id i64, category_id string) rt.PhpVal {
	mut var_blog_id := blog_id
	mut var_category_id := category_id
	mut var_author_data := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.0.0'), rt.new_string('current_user_can()')])
	var_author_data = rt.call_function('get_userdata', [var_user_id.clone()])
	return rt.greater(rt.get_property(var_author_data, 'user_level'), rt.new_int(1))
}

fn user_can_create_draft(var_user_id rt.PhpVal, blog_id i64, category_id string) rt.PhpVal {
	mut var_blog_id := blog_id
	mut var_category_id := category_id
	mut var_author_data := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.0.0'), rt.new_string('current_user_can()')])
	var_author_data = rt.call_function('get_userdata', [var_user_id.clone()])
	return rt.greater_equal(rt.get_property(var_author_data, 'user_level'), rt.new_int(1))
}

fn user_can_edit_post(var_user_id rt.PhpVal, var_post_id rt.PhpVal, blog_id i64) bool {
	mut var_blog_id := blog_id
	mut var_author_data := rt.new_null()
	mut var_post := rt.new_null()
	mut var_post_author_data := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.0.0'), rt.new_string('current_user_can()')])
	var_author_data = rt.call_function('get_userdata', [var_user_id.clone()])
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	var_post_author_data = rt.call_function('get_userdata', [
		rt.get_property(var_post, 'post_author'),
	])
	if ((rt.is_true(rt.equal(var_user_id, rt.get_property(var_post_author_data, 'ID')))
		&& !(rt.is_true(rt.equal(rt.get_property(var_post, 'post_status'), rt.new_string('publish')))
		&& rt.is_true(rt.less(rt.get_property(var_author_data, 'user_level'), rt.new_int(2)))))
		|| rt.is_true(rt.greater(rt.get_property(var_author_data, 'user_level'), rt.get_property(var_post_author_data, 'user_level'))))
		|| rt.is_true(rt.greater_equal(rt.get_property(var_author_data, 'user_level'), rt.new_int(10))) {
		return true
	} else {
		return false
	}
	return false
}

fn user_can_delete_post(var_user_id rt.PhpVal, var_post_id rt.PhpVal, blog_id i64) bool {
	mut var_blog_id := blog_id
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.0.0'), rt.new_string('current_user_can()')])
	return user_can_edit_post(var_user_id.clone(), var_post_id.clone(), blog_id)
}

fn user_can_set_post_date(var_user_id rt.PhpVal, blog_id i64, category_id string) bool {
	mut var_blog_id := blog_id
	mut var_category_id := category_id
	mut var_author_data := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.0.0'), rt.new_string('current_user_can()')])
	var_author_data = rt.call_function('get_userdata', [var_user_id.clone()])
	return rt.is_true(rt.greater(rt.get_property(var_author_data, 'user_level'), rt.new_int(4)))
		&& rt.is_true(user_can_create_post(var_user_id.clone(), blog_id, category_id))
}

fn user_can_edit_post_date(var_user_id rt.PhpVal, var_post_id rt.PhpVal, blog_id i64) bool {
	mut var_blog_id := blog_id
	mut var_author_data := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.0.0'), rt.new_string('current_user_can()')])
	var_author_data = rt.call_function('get_userdata', [var_user_id.clone()])
	return rt.is_true(rt.greater(rt.get_property(var_author_data, 'user_level'), rt.new_int(4)))
		&& user_can_edit_post(var_user_id.clone(), var_post_id.clone(), blog_id)
}

fn user_can_edit_post_comments(var_user_id rt.PhpVal, var_post_id rt.PhpVal, blog_id i64) bool {
	mut var_blog_id := blog_id
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.0.0'), rt.new_string('current_user_can()')])
	return user_can_edit_post(var_user_id.clone(), var_post_id.clone(), blog_id)
}

fn user_can_delete_post_comments(var_user_id rt.PhpVal, var_post_id rt.PhpVal, blog_id i64) bool {
	mut var_blog_id := blog_id
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.0.0'), rt.new_string('current_user_can()')])
	return user_can_edit_post_comments(var_user_id.clone(), var_post_id.clone(), blog_id)
}

fn user_can_edit_user(var_user_id rt.PhpVal, var_other_user rt.PhpVal) bool {
	mut var_user := rt.new_null()
	mut var_other := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.0.0'), rt.new_string('current_user_can()')])
	var_user = rt.call_function('get_userdata', [var_user_id.clone()])
	var_other = rt.call_function('get_userdata', [var_other_user.clone()])
	if rt.is_true(rt.greater(rt.get_property(var_user, 'user_level'), rt.get_property(var_other, 'user_level')))
		|| rt.is_true(rt.greater(rt.get_property(var_user, 'user_level'), rt.new_int(8)))
		|| rt.is_true(rt.equal(rt.get_property(var_user, 'ID'), rt.get_property(var_other, 'ID'))) {
		return true
	} else {
		return false
	}
	return false
}

fn get_linksbyname(cat_name string, before string, after string, between string, show_images bool, orderby string, show_description bool, show_rating bool, var_limit rt.PhpVal, show_updated i64) {
	mut var_cat_name := cat_name
	mut var_before := before
	mut var_after := after
	mut var_between := between
	mut var_show_images := show_images
	mut var_orderby := orderby
	mut var_show_description := show_description
	mut var_show_rating := show_rating
	mut var_show_updated := show_updated
	mut var_cat_id := rt.new_null()
	mut var_cat := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('get_bookmarks()')])
	var_cat_id = rt.new_int(-1)
	var_cat = rt.call_function('get_term_by', [rt.new_string('name'),
		rt.new_string(cat_name), rt.new_string('link_category')])
	if rt.is_true(var_cat) {
		var_cat_id = rt.get_property(var_cat, 'term_id')
	}
	rt.new_string(get_links(var_cat_id.clone(), before, after, between, show_images, orderby,
		show_description, show_rating, var_limit.clone(), show_updated, false))
}

fn wp_get_linksbyname(var_category rt.PhpVal, args string) rt.PhpVal {
	mut var_args := args
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_parsed_args := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('wp_list_bookmarks()')])
	var_defaults = {
		'after':            rt.new_string('<br />')
		'before':           rt.new_string('')
		'categorize':       rt.new_int(0)
		'category_after':   rt.new_string('')
		'category_before':  rt.new_string('')
		'category_name':    var_category
		'show_description': rt.new_int(1)
		'title_li':         rt.new_string('')
	}
	var_parsed_args = rt.call_function('wp_parse_args', [rt.new_string(args),
		rt.create_array_from_native_map(var_defaults)])
	return rt.call_function('wp_list_bookmarks', [var_parsed_args.clone()])
}

fn get_linkobjectsbyname(cat_name string, orderby string, var_limit rt.PhpVal) rt.PhpVal {
	mut var_cat_name := cat_name
	mut var_orderby := orderby
	mut var_cat_id := rt.new_null()
	mut var_cat := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('get_bookmarks()')])
	var_cat_id = rt.new_int(-1)
	var_cat = rt.call_function('get_term_by', [rt.new_string('name'),
		rt.new_string(cat_name), rt.new_string('link_category')])
	if rt.is_true(var_cat) {
		var_cat_id = rt.get_property(var_cat, 'term_id')
	}
	return get_linkobjects(var_cat_id.clone(), orderby, var_limit.clone())
}

fn get_linkobjects(category i64, orderby string, limit i64) rt.PhpVal {
	mut var_category := category
	mut var_orderby := orderby
	mut var_limit := limit
	mut var_links := rt.new_null()
	mut var_links_array := []rt.PhpVal{}
	mut var_link := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('get_bookmarks()')])
	var_links = rt.call_function('get_bookmarks', [
		rt.create_array([rt.ArrayItem{ key: 'category', val: category },
			rt.ArrayItem{ key: 'orderby', val: orderby }, rt.ArrayItem{ key: 'limit', val: limit }]),
	])
	var_links_array = []rt.PhpVal{}
	mut iter_1 := var_links.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_link_shadow := item_1.val
		var_links_array << var_link_shadow.clone()
	}
	return var_links_array.clone()
}

fn get_linksbyname_withrating(cat_name string, before string, after string, between string, show_images bool, orderby string, show_description bool, var_limit rt.PhpVal, show_updated i64) {
	mut var_cat_name := cat_name
	mut var_before := before
	mut var_after := after
	mut var_between := between
	mut var_show_images := show_images
	mut var_orderby := orderby
	mut var_show_description := show_description
	mut var_show_updated := show_updated
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('get_bookmarks()')])
	get_linksbyname(cat_name, before, after, between, show_images, orderby, show_description, true,
		var_limit.clone(), show_updated)
}

fn get_links_withrating(var_category rt.PhpVal, before string, after string, between string, show_images bool, orderby string, show_description bool, var_limit rt.PhpVal, show_updated i64) {
	mut var_before := before
	mut var_after := after
	mut var_between := between
	mut var_show_images := show_images
	mut var_orderby := orderby
	mut var_show_description := show_description
	mut var_show_updated := show_updated
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('get_bookmarks()')])
	rt.new_string(get_links(var_category.clone(), before, after, between, show_images, orderby,
		show_description, true, var_limit.clone(), show_updated, false))
}

fn get_autotoggle(id i64) i64 {
	mut var_id := id
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0')])
	return 0
}

fn list_cats(optionall i64, all string, sort_column string, sort_order string, file string, list bool, optiondates i64, optioncount i64, hide_empty i64, use_desc_for_title i64, children bool, child_of i64, categories i64, recurse i64, feed string, feed_image string, exclude string, hierarchical bool) rt.PhpVal {
	mut var_optionall := optionall
	mut var_all := all
	mut var_sort_column := sort_column
	mut var_sort_order := sort_order
	mut var_file := file
	mut var_list := list
	mut var_optiondates := optiondates
	mut var_optioncount := optioncount
	mut var_hide_empty := hide_empty
	mut var_use_desc_for_title := use_desc_for_title
	mut var_children := children
	mut var_child_of := child_of
	mut var_categories := categories
	mut var_recurse := recurse
	mut var_feed := feed
	mut var_feed_image := feed_image
	mut var_exclude := exclude
	mut var_hierarchical := hierarchical
	mut var_query := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('wp_list_categories()')])
	var_query = rt.call_function('compact', [rt.new_string('optionall'),
		rt.new_string('all'), rt.new_string('sort_column'), rt.new_string('sort_order'),
		rt.new_string('file'), rt.new_string('list'), rt.new_string('optiondates'),
		rt.new_string('optioncount'), rt.new_string('hide_empty'),
		rt.new_string('use_desc_for_title'), rt.new_string('children'),
		rt.new_string('child_of'), rt.new_string('categories'),
		rt.new_string('recurse'), rt.new_string('feed'), rt.new_string('feed_image'),
		rt.new_string('exclude'), rt.new_string('hierarchical')])
	return wp_list_cats(var_query.clone())
}

fn wp_list_cats(args string) rt.PhpVal {
	mut var_args := args
	mut var_parsed_args := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('wp_list_categories()')])
	var_parsed_args = rt.call_function('wp_parse_args', [rt.new_string(args)])
	if var_parsed_args.array_isset(rt.new_string('optionall'))
		&& var_parsed_args.array_isset(rt.new_string('all')) {
		var_parsed_args.array_set('show_option_all',
			var_parsed_args.array_get(rt.new_string('all')))
	}
	if var_parsed_args.array_isset(rt.new_string('sort_column')) {
		var_parsed_args.array_set('orderby',
			var_parsed_args.array_get(rt.new_string('sort_column')))
	}
	if var_parsed_args.array_isset(rt.new_string('sort_order')) {
		var_parsed_args.array_set('order', var_parsed_args.array_get(rt.new_string('sort_order')))
	}
	if var_parsed_args.array_isset(rt.new_string('optiondates')) {
		var_parsed_args.array_set('show_last_update',
			var_parsed_args.array_get(rt.new_string('optiondates')))
	}
	if var_parsed_args.array_isset(rt.new_string('optioncount')) {
		var_parsed_args.array_set('show_count',
			var_parsed_args.array_get(rt.new_string('optioncount')))
	}
	if var_parsed_args.array_isset(rt.new_string('list')) {
		var_parsed_args.array_set('style', if rt.is_true(var_parsed_args.array_get(rt.new_string('list'))) {
			'list'
		} else {
			'break'
		})
	}
	var_parsed_args.array_set('title_li', '')
	return rt.call_function('wp_list_categories', [var_parsed_args.clone()])
}

fn dropdown_cats(optionall i64, all string, orderby string, order string, show_last_update i64, show_count i64, hide_empty i64, optionnone bool, selected i64, exclude i64) rt.PhpVal {
	mut var_optionall := optionall
	mut var_all := all
	mut var_orderby := orderby
	mut var_order := order
	mut var_show_last_update := show_last_update
	mut var_show_count := show_count
	mut var_hide_empty := hide_empty
	mut var_optionnone := optionnone
	mut var_selected := selected
	mut var_exclude := exclude
	mut var_show_option_all := ''
	mut var_show_option_none := rt.new_null()
	mut var_vars := rt.new_null()
	mut var_query := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('wp_dropdown_categories()')])
	var_show_option_all = ''
	if var_optionall != 0 {
		var_show_option_all = all
	}
	var_show_option_none = rt.new_string('')
	if var_optionnone {
		var_show_option_none = rt.call_function('_x', [rt.new_string('None'),
			rt.new_string('Categories dropdown (show_option_none parameter)')])
	}
	var_vars = rt.call_function('compact', [rt.new_string('show_option_all'),
		rt.new_string('show_option_none'), rt.new_string('orderby'),
		rt.new_string('order'), rt.new_string('show_last_update'),
		rt.new_string('show_count'), rt.new_string('hide_empty'),
		rt.new_string('selected'), rt.new_string('exclude')])
	var_query = rt.call_function('add_query_arg', [var_vars.clone(),
		rt.new_string('')])
	return rt.call_function('wp_dropdown_categories', [var_query.clone()])
}

fn list_authors(optioncount bool, exclude_admin bool, show_fullname bool, hide_empty bool, feed string, feed_image string) rt.PhpVal {
	mut var_optioncount := optioncount
	mut var_exclude_admin := exclude_admin
	mut var_show_fullname := show_fullname
	mut var_hide_empty := hide_empty
	mut var_feed := feed
	mut var_feed_image := feed_image
	mut var_args := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('wp_list_authors()')])
	var_args = rt.call_function('compact', [rt.new_string('optioncount'),
		rt.new_string('exclude_admin'), rt.new_string('show_fullname'),
		rt.new_string('hide_empty'), rt.new_string('feed'), rt.new_string('feed_image')])
	return rt.call_function('wp_list_authors', [var_args.clone()])
}

fn wp_get_post_cats(blogid string, post_id i64) rt.PhpVal {
	mut var_blogid := blogid
	mut var_post_id := post_id
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('wp_get_post_categories()')])
	return rt.call_function('wp_get_post_categories', [rt.new_int(post_id)])
}

fn wp_set_post_cats(blogid string, post_id i64, var_post_categories rt.PhpVal) rt.PhpVal {
	mut var_blogid := blogid
	mut var_post_id := post_id
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('wp_set_post_categories()')])
	return rt.call_function('wp_set_post_categories', [rt.new_int(post_id),
		var_post_categories.clone()])
}

fn get_archives(type string, limit string, format string, before string, after string, show_post_count bool) rt.PhpVal {
	mut var_type := type
	mut var_limit := limit
	mut var_format := format
	mut var_before := before
	mut var_after := after
	mut var_show_post_count := show_post_count
	mut var_args := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('wp_get_archives()')])
	var_args = rt.call_function('compact', [rt.new_string('type'),
		rt.new_string('limit'), rt.new_string('format'), rt.new_string('before'),
		rt.new_string('after'), rt.new_string('show_post_count')])
	return rt.call_function('wp_get_archives', [var_args.clone()])
}

fn get_author_link(var_display rt.PhpVal, var_author_id rt.PhpVal, author_nicename string) rt.PhpVal {
	mut var_author_nicename := author_nicename
	mut var_link := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('get_author_posts_url()')])
	var_link = rt.call_function('get_author_posts_url', [var_author_id.clone(),
		rt.new_string(author_nicename)])
	if rt.is_true(var_display) {
		rt.echo_val(var_link)
	}
	return var_link.clone()
}

fn link_pages(before string, after string, next_or_number string, nextpagelink string, previouspagelink string, pagelink string, more_file string) rt.PhpVal {
	mut var_before := before
	mut var_after := after
	mut var_next_or_number := next_or_number
	mut var_nextpagelink := nextpagelink
	mut var_previouspagelink := previouspagelink
	mut var_pagelink := pagelink
	mut var_more_file := more_file
	mut var_args := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('wp_link_pages()')])
	var_args = rt.call_function('compact', [rt.new_string('before'),
		rt.new_string('after'), rt.new_string('next_or_number'),
		rt.new_string('nextpagelink'), rt.new_string('previouspagelink'),
		rt.new_string('pagelink'), rt.new_string('more_file')])
	return rt.call_function('wp_link_pages', [var_args.clone()])
}

fn get_settings(var_option rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('get_option()')])
	return rt.call_function('get_option', [var_option.clone()])
}

fn permalink_link() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('1.2.0'), rt.new_string('the_permalink()')])
	rt.call_function('the_permalink', []rt.PhpVal{})
}

fn permalink_single_rss(deprecated string) {
	mut var_deprecated := deprecated
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.3.0'), rt.new_string('the_permalink_rss()')])
	rt.call_function('the_permalink_rss', []rt.PhpVal{})
}

fn wp_get_links(args string) rt.PhpVal {
	mut var_args := args
	mut var_cat_id := ''
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_parsed_args := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('wp_list_bookmarks()')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
		rt.new_string(var_args.str()),
		rt.new_string('='),
	])))))
	{
		var_cat_id = var_args
		var_args = (rt.call_function('add_query_arg', [rt.new_string('category'),
			rt.new_string(var_cat_id.str()).clone(), rt.new_string(var_args.str())])).str()
	}
	var_defaults = {
		'after':            rt.new_string('<br />')
		'before':           rt.new_string('')
		'between':          rt.new_string(' ')
		'categorize':       rt.new_int(0)
		'category':         rt.new_string('')
		'echo':             rt.new_bool(true)
		'limit':            -1
		'orderby':          rt.new_string('name')
		'show_description': rt.new_bool(true)
		'show_images':      rt.new_bool(true)
		'show_rating':      rt.new_bool(false)
		'show_updated':     rt.new_bool(true)
		'title_li':         rt.new_string('')
	}
	var_parsed_args = rt.call_function('wp_parse_args', [rt.new_string(var_args.str()),
		rt.create_array_from_native_map(var_defaults)])
	return rt.call_function('wp_list_bookmarks', [var_parsed_args.clone()])
}

fn get_links(var_category_arg rt.PhpVal, before string, after string, between string, show_images bool, orderby string, show_description bool, show_rating bool, var_limit rt.PhpVal, show_updated i64, display bool) string {
	mut var_before := before
	mut var_after := after
	mut var_between := between
	mut var_show_images := show_images
	mut var_orderby := orderby
	mut var_show_description := show_description
	mut var_show_rating := show_rating
	mut var_show_updated := show_updated
	mut var_display := display
	mut var_category := var_category_arg
	mut var_order := ''
	mut var_results := rt.new_null()
	mut var_output := ''
	mut var_row := rt.new_null()
	mut var_the_link := rt.new_null()
	mut var_rel := rt.new_null()
	mut var_desc := rt.new_null()
	mut var_name := rt.new_null()
	mut var_title := rt.new_null()
	mut var_alt := rt.new_null()
	mut var_target := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('get_bookmarks()')])
	var_order = 'ASC'
	if rt.is_true(rt.call_function('str_starts_with', [
		rt.new_string(var_orderby.str()),
		rt.new_string('_'),
	]))
	{
		var_order = 'DESC'
		var_orderby = (rt.call_function('substr', [rt.new_string(var_orderby.str()),
			rt.new_int(1)])).str()
	}
	if rt.is_true(rt.equal(rt.new_string(var_category.str()), -1)) {
		var_category = ''
	}
	var_results = rt.call_function('get_bookmarks', [
		rt.create_array([rt.ArrayItem{ key: 'category', val: var_category },
			rt.ArrayItem{ key: 'orderby', val: var_orderby },
			rt.ArrayItem{ key: 'order', val: var_order }, rt.ArrayItem{
				key: 'show_updated'
				val: show_updated
			}, rt.ArrayItem{ key: 'limit', val: var_limit }]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_results)))) {
		return ''
	}
	var_output = ''
	mut iter_2 := rt.cast_array(var_results).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_row_shadow := item_2.val
		if !(!(rt.get_property(var_row_shadow, 'recently_updated')).is_null()) {
			rt.set_property(var_row_shadow, 'recently_updated', rt.new_bool(false))
		}
		var_output = var_output + before
		if var_show_updated != 0 && rt.is_true(rt.get_property(var_row_shadow, 'recently_updated')) {
			var_output = var_output +(rt.call_function('get_option', [rt.new_string('links_recently_updated_prepend')])).str()
		}
		var_the_link = rt.new_string('#')
		if !(!rt.is_true(rt.get_property(var_row_shadow, 'link_url'))) {
			var_the_link = rt.call_function('esc_url', [
				rt.get_property(var_row_shadow, 'link_url'),
			])
		}
		var_rel = rt.get_property(var_row_shadow, 'link_rel')
		if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string(''), var_rel)))) {
			var_rel = rt.new_string(' rel="' + var_rel.str() + '"')
		}
		var_desc = rt.call_function('esc_attr', [
			rt.call_function('sanitize_bookmark_field', [
				rt.new_string('link_description'),
				rt.get_property(var_row_shadow, 'link_description'),
				rt.get_property(var_row_shadow, 'link_id'),
				rt.new_string('display'),
			]),
		])
		var_name = rt.call_function('esc_attr', [
			rt.call_function('sanitize_bookmark_field', [rt.new_string('link_name'),
				rt.get_property(var_row_shadow, 'link_name'),
				rt.get_property(var_row_shadow, 'link_id'), rt.new_string('display')]),
		])
		var_title = var_desc.clone()
		if var_show_updated != 0 {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [
				rt.get_property(var_row_shadow, 'link_updated_f'),
				rt.new_string('00'),
			])))))
			{
				var_title = rt.concat(var_title, rt.new_string(
					' (' + (rt.call_function('__', [rt.new_string('Last updated')])).str() + ' ' +
					(rt.call_function('gmdate', [rt.call_function('get_option', [rt.new_string('links_updated_date_format')]), rt.add(rt.get_property(var_row_shadow, 'link_updated_f'), rt.mul(rt.call_function('get_option', [rt.new_string('gmt_offset')]), rt.get_constant('HOUR_IN_SECONDS')))])).str() +
					')'))
			}
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string(''), var_title)))) {
			var_title = rt.new_string(' title="' + var_title.str() + '"')
		}
		var_alt = rt.new_string(' alt="' + var_name.str() + '"')
		var_target = rt.get_property(var_row_shadow, 'link_target')
		if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string(''), var_target)))) {
			var_target = rt.new_string(' target="' + var_target.str() + '"')
		}
		var_output = var_output + '<a href="' + var_the_link.str() + '"' + var_rel.str() +
			var_title.str() + var_target.str() + '>'
		if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string(''), rt.get_property(var_row_shadow, 'link_image')))))
			&& var_show_images {
			if rt.is_true(rt.call_function('str_contains', [
				rt.get_property(var_row_shadow, 'link_image'),
				rt.new_string('http'),
			]))
			{
				var_output = var_output + '<img src="' +
					(rt.get_property(var_row_shadow, 'link_image')).str() + '"' + var_alt.str() +
					var_title.str() + ' />'
			} else {
				var_output = var_output + '<img src="' +
					(rt.call_function('get_option', [rt.new_string('siteurl')])).str() +
					(rt.get_property(var_row_shadow, 'link_image')).str() + '"' + var_alt.str() +
					var_title.str() + ' />'
			}
		} else {
			var_output = var_output + var_name.str()
		}
		var_output = var_output + '</a>'
		if var_show_updated != 0 && rt.is_true(rt.get_property(var_row_shadow, 'recently_updated')) {
			var_output = var_output +(rt.call_function('get_option', [rt.new_string('links_recently_updated_append')])).str()
		}
		if var_show_description
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string(''), var_desc)))) {
			var_output = var_output + between + var_desc.str()
		}
		if var_show_rating {
			var_output = var_output + between + (get_linkrating(var_row_shadow.clone())).str()
		}
		var_output = var_output + '${var_after}\n'
	}
	if !var_display {
		return var_output
	}
	print(var_output)
	return ''
}

fn get_links_list(order string) {
	mut var_order := order
	mut var_direction := ''
	mut var_cats := rt.new_null()
	mut var_cat := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('wp_list_bookmarks()')])
	var_order = var_order.to_lower()
	var_direction = 'ASC'
	if rt.is_true(rt.call_function('str_starts_with', [rt.new_string(var_order.str()),
		rt.new_string('_')]))
	{
		var_direction = 'DESC'
		var_order = (rt.call_function('substr', [rt.new_string(var_order.str()),
			rt.new_int(1)])).str()
	}
	if !(!(rt.new_string(var_direction.str())).is_null()) {
		var_direction = ''
	}
	var_cats = rt.call_function('get_categories', [
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'link' },
			rt.ArrayItem{ key: 'orderby', val: var_order }, rt.ArrayItem{
				key: 'order'
				val: var_direction
			}, rt.ArrayItem{ key: 'hierarchical', val: 0 }]),
	])
	if rt.is_true(var_cats) {
		mut iter_3 := rt.cast_array(var_cats).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_cat_shadow := item_3.val
			print('  <li id="linkcat-' + (rt.get_property(var_cat_shadow, 'term_id')).str() +
				'" class="linkcat"><h2>' +
				(rt.call_function('apply_filters', [rt.new_string('link_category'), rt.get_property(var_cat_shadow, 'name')])).str() +
				'</h2>\n\t<ul>\n')
			rt.new_string(get_links(rt.get_property(var_cat_shadow, 'term_id'), '<li>', '</li>',
				'\n', true, 'name', false, false, rt.new_null(), 0, false))
			print('\n\t</ul>\n</li>\n')
		}
	}
}

fn links_popup_script(text string, width i64, height i64, file string, count bool) {
	mut var_text := text
	mut var_width := width
	mut var_height := height
	mut var_file := file
	mut var_count := count
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0')])
}

fn get_linkrating(var_link rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('sanitize_bookmark_field()')])
	return rt.call_function('sanitize_bookmark_field', [rt.new_string('link_rating'),
		rt.get_property(var_link, 'link_rating'), rt.get_property(var_link, 'link_id'),
		rt.new_string('display')])
}

fn get_linkcatname(id i64) string {
	mut var_id := id
	mut var_cats := rt.new_null()
	mut var_cat_id := rt.new_null()
	mut var_cat := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('get_category()')])
	var_id = var_id
	if var_id == 0 {
		return ''
	}
	var_cats = rt.call_function('wp_get_link_cats', [rt.new_int(var_id)])
	if !rt.is_true(var_cats) || !(var_cats.clone().is_array()) {
		return ''
	}
	var_cat_id = rt.new_int((var_cats.array_get(rt.new_int(0))).to_i64())
	var_cat = rt.call_function('get_category', [var_cat_id.clone()])
	return (rt.get_property(var_cat, 'name')).str()
}

fn comments_rss_link(link_text string) {
	mut var_link_text := link_text
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.5.0'), rt.new_string('post_comments_feed_link()')])
	rt.call_function('post_comments_feed_link', [rt.new_string(link_text)])
}

fn get_category_rss_link(display bool, cat_id i64) rt.PhpVal {
	mut var_display := display
	mut var_cat_id := cat_id
	mut var_link := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.5.0'), rt.new_string('get_category_feed_link()')])
	var_link = rt.call_function('get_category_feed_link', [rt.new_int(cat_id),
		rt.new_string('rss2')])
	if var_display {
		rt.echo_val(var_link)
	}
	return var_link.clone()
}

fn get_author_rss_link(display bool, author_id i64) rt.PhpVal {
	mut var_display := display
	mut var_author_id := author_id
	mut var_link := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.5.0'), rt.new_string('get_author_feed_link()')])
	var_link = rt.call_function('get_author_feed_link', [rt.new_int(author_id)])
	if var_display {
		rt.echo_val(var_link)
	}
	return var_link.clone()
}

fn comments_rss() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.2.0'), rt.new_string('get_post_comments_feed_link()')])
	return rt.call_function('esc_url', [
		rt.call_function('get_post_comments_feed_link', []rt.PhpVal{}),
	])
}

fn create_user(var_username rt.PhpVal, var_password rt.PhpVal, var_email rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.0.0'), rt.new_string('wp_create_user()')])
	return rt.call_function('wp_create_user', [var_username.clone(),
		var_password.clone(), var_email.clone()])
}

fn gzip_compression() bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.5.0')])
	return false
}

fn get_commentdata(var_comment_id rt.PhpVal, no_cache i64, include_unapproved bool) rt.PhpVal {
	mut var_no_cache := no_cache
	mut var_include_unapproved := include_unapproved
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.7.0'), rt.new_string('get_comment()')])
	return rt.call_function('get_comment', [var_comment_id.clone(),
		rt.get_constant('ARRAY_A')])
}

fn get_catname(var_cat_id rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string('get_cat_name()')])
	return rt.call_function('get_cat_name', [var_cat_id.clone()])
}

fn get_category_children(var_id rt.PhpVal, before string, after string, var_visited rt.PhpVal) string {
	mut var_before := before
	mut var_after := after
	mut var_chain := ''
	mut var_cat_ids := rt.new_null()
	mut var_cat_id := rt.new_null()
	mut var_category := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string('get_term_children()')])
	if rt.is_true(rt.equal(rt.new_int(0), var_id)) {
		return ''
	}
	var_chain = ''
	var_cat_ids = get_all_category_ids()
	mut iter_4 := rt.cast_array(var_cat_ids).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_cat_id_shadow := item_4.val
		if rt.is_true(rt.equal(var_cat_id_shadow, var_id)) {
			continue
		}
		var_category = rt.call_function('get_category', [var_cat_id_shadow.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [var_category.clone()])) {
			return var_category.str()
		}
		if rt.is_true(rt.equal(rt.get_property(var_category, 'parent'), var_id))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_category, 'term_id'), rt.create_array_from_list(var_visited)]))))) {
			var_visited.array_push(rt.get_property(var_category, 'term_id'))
			var_chain = var_chain + before + (rt.get_property(var_category, 'term_id')).str() +
				after
			var_chain = var_chain +
				get_category_children(rt.get_property(var_category, 'term_id'), before, after)
		}
	}
	return var_chain
}

fn get_all_category_ids() rt.PhpVal {
	mut var_cat_ids := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.0.0'), rt.new_string('get_terms()')])
	var_cat_ids = rt.call_function('get_terms', [
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'category' },
			rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'get', val: 'all' }]),
	])
	return var_cat_ids.clone()
}

fn get_the_author_description() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("get_the_author_meta('description')")])
	return rt.call_function('get_the_author_meta', [rt.new_string('description')])
}

fn the_author_description() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("the_author_meta('description')")])
	rt.call_function('the_author_meta', [rt.new_string('description')])
}

fn get_the_author_login() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("get_the_author_meta('login')")])
	return rt.call_function('get_the_author_meta', [rt.new_string('login')])
}

fn the_author_login() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("the_author_meta('login')")])
	rt.call_function('the_author_meta', [rt.new_string('login')])
}

fn get_the_author_firstname() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("get_the_author_meta('first_name')")])
	return rt.call_function('get_the_author_meta', [rt.new_string('first_name')])
}

fn the_author_firstname() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("the_author_meta('first_name')")])
	rt.call_function('the_author_meta', [rt.new_string('first_name')])
}

fn get_the_author_lastname() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("get_the_author_meta('last_name')")])
	return rt.call_function('get_the_author_meta', [rt.new_string('last_name')])
}

fn the_author_lastname() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("the_author_meta('last_name')")])
	rt.call_function('the_author_meta', [rt.new_string('last_name')])
}

fn get_the_author_nickname() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("get_the_author_meta('nickname')")])
	return rt.call_function('get_the_author_meta', [rt.new_string('nickname')])
}

fn the_author_nickname() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("the_author_meta('nickname')")])
	rt.call_function('the_author_meta', [rt.new_string('nickname')])
}

fn get_the_author_email() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("get_the_author_meta('email')")])
	return rt.call_function('get_the_author_meta', [rt.new_string('email')])
}

fn the_author_email() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("the_author_meta('email')")])
	rt.call_function('the_author_meta', [rt.new_string('email')])
}

fn get_the_author_icq() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("get_the_author_meta('icq')")])
	return rt.call_function('get_the_author_meta', [rt.new_string('icq')])
}

fn the_author_icq() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("the_author_meta('icq')")])
	rt.call_function('the_author_meta', [rt.new_string('icq')])
}

fn get_the_author_yim() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("get_the_author_meta('yim')")])
	return rt.call_function('get_the_author_meta', [rt.new_string('yim')])
}

fn the_author_yim() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("the_author_meta('yim')")])
	rt.call_function('the_author_meta', [rt.new_string('yim')])
}

fn get_the_author_msn() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("get_the_author_meta('msn')")])
	return rt.call_function('get_the_author_meta', [rt.new_string('msn')])
}

fn the_author_msn() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("the_author_meta('msn')")])
	rt.call_function('the_author_meta', [rt.new_string('msn')])
}

fn get_the_author_aim() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("get_the_author_meta('aim')")])
	return rt.call_function('get_the_author_meta', [rt.new_string('aim')])
}

fn the_author_aim() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("the_author_meta('aim')")])
	rt.call_function('the_author_meta', [rt.new_string('aim')])
}

fn get_author_name(auth_id bool) rt.PhpVal {
	mut var_auth_id := auth_id
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("get_the_author_meta('display_name')")])
	return rt.call_function('get_the_author_meta', [rt.new_string('display_name'),
		rt.new_bool(auth_id)])
}

fn get_the_author_url() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("get_the_author_meta('url')")])
	return rt.call_function('get_the_author_meta', [rt.new_string('url')])
}

fn the_author_url() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("the_author_meta('url')")])
	rt.call_function('the_author_meta', [rt.new_string('url')])
}

fn get_the_author_id() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("get_the_author_meta('ID')")])
	return rt.call_function('get_the_author_meta', [rt.new_string('ID')])
}

fn the_author_id() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string("the_author_meta('ID')")])
	rt.call_function('the_author_meta', [rt.new_string('ID')])
}

fn the_content_rss(more_link_text string, stripteaser i64, more_file string, cut i64, encode_html i64) {
	mut var_more_link_text := more_link_text
	mut var_stripteaser := stripteaser
	mut var_more_file := more_file
	mut var_cut := cut
	mut var_encode_html := encode_html
	mut var_excerpt := rt.new_null()
	mut var_content := rt.new_null()
	mut var_blah := rt.new_null()
	mut var_k := i64(0)
	mut var_use_dotdotdot := i64(0)
	mut var_i := i64(0)
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.9.0'), rt.new_string('the_content_feed()')])
	var_content = rt.call_function('get_the_content', [rt.new_string(more_link_text),
		rt.new_int(stripteaser)])
	var_content = rt.call_function('apply_filters', [rt.new_string('the_content_rss'),
		var_content.clone()])
	if var_cut != 0 && !(var_encode_html != 0) {
		var_encode_html = 2
	}
	if 1 == var_encode_html {
		var_content = rt.call_function('esc_html', [var_content.clone()])
		var_cut = 0
	} else if 0 == var_encode_html {
		var_content = make_url_footnote(var_content.clone())
	} else if 2 == var_encode_html {
		var_content = rt.call_function('strip_tags', [var_content.clone()])
	}
	if var_cut != 0 {
		var_blah = rt.call_function('explode', [rt.new_string(' '),
			var_content.clone()])
		if var_blah.clone().array_count() > var_cut {
			var_k = var_cut
			var_use_dotdotdot = 1
		} else {
			var_k = var_blah.clone().array_count()
			var_use_dotdotdot = 0
		}
		var_i = 0
		for {
			if !(var_i < var_k) { break
			 }
			var_excerpt = rt.concat(var_excerpt, rt.new_string(
				(var_blah.array_get(rt.new_int(var_i))).str() + ' '))
			var_i += 1
		}
		var_excerpt = rt.concat(var_excerpt, if var_use_dotdotdot != 0 { '...' } else { '' })
		var_content = var_excerpt
	}
	var_content = rt.call_function('str_replace', [rt.new_string(']]>'),
		rt.new_string(']]&gt;'), var_content.clone()])
	rt.echo_val(var_content)
}

fn make_url_footnote(var_content_arg rt.PhpVal) rt.PhpVal {
	mut var_content := var_content_arg
	mut var_matches := []rt.PhpVal{}
	mut var_links_summary := ''
	mut var_link_match := rt.new_null()
	mut var_link_number := rt.new_null()
	mut var_link_url := rt.new_null()
	mut var_link_text := rt.new_null()
	mut var_i := i64(0)
	mut var_c := i64(0)
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.9.0'), rt.new_string('')])
	rt.call_function('preg_match_all', [
		rt.new_string('/<a(.+?)href=\\"(.+?)\\"(.*?)>(.+?)<\\/a>/'),
		var_content.clone(),
		rt.create_array_from_list(var_matches),
	])
	var_links_summary = '\n'
	var_i = 0
	var_c = var_matches[0].array_count()
	for {
		if !(var_i < var_c) { break
		 }
		var_link_match = var_matches[0].array_get(rt.new_int(var_i))
		var_link_number = rt.new_string('[' + var_i + 1.str() + ']')
		var_link_url = var_matches[2].array_get(rt.new_int(var_i))
		var_link_text = var_matches[4].array_get(rt.new_int(var_i))
		var_content = rt.call_function('str_replace', [var_link_match.clone(),
			rt.new_string(var_link_text.str() + ' ' + var_link_number.str()),
			var_content.clone()])
		var_link_url = if
			rt.is_true(rt.new_bool(rt.call_function('substr', [var_link_url.clone(), rt.new_int(0), rt.new_int(7)]).to_string().to_lower() != 'http://'))
			&& rt.is_true(rt.new_bool(rt.call_function('substr', [var_link_url.clone(), rt.new_int(0), rt.new_int(8)]).to_string().to_lower() != 'https://')) {
			(rt.call_function('get_option', [rt.new_string('home')])).str() + var_link_url.str()
		} else {
			var_link_url
		}
		var_links_summary = var_links_summary + '\n' + var_link_number.str() + ' ' +
			var_link_url.str()
		var_i += 1
	}
	var_content = rt.call_function('strip_tags', [var_content.clone()])
	var_content = rt.concat(var_content, rt.new_string(var_links_summary.str()))
	return var_content.clone()
}

fn _c(var_text rt.PhpVal, domain string) rt.PhpVal {
	mut var_domain := domain
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.9.0'), rt.new_string('_x()')])
	return rt.call_function('before_last_bar', [
		rt.call_function('translate', [var_text.clone(), rt.new_string(domain)]),
	])
}

fn translate_with_context(var_text rt.PhpVal, domain string) rt.PhpVal {
	mut var_domain := domain
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.9.0'), rt.new_string('_x()')])
	return rt.call_function('before_last_bar', [
		rt.call_function('translate', [var_text.clone(), rt.new_string(domain)]),
	])
}

fn _nc(var_single rt.PhpVal, var_plural rt.PhpVal, var_number rt.PhpVal, domain string) rt.PhpVal {
	mut var_domain := domain
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.9.0'), rt.new_string('_nx()')])
	return rt.call_function('before_last_bar', [
		rt.call_function('_n', [var_single.clone(), var_plural.clone(),
			var_number.clone(), rt.new_string(domain)]),
	])
}

fn __ngettext(var_args_origin ...rt.PhpVal) rt.PhpVal {
	mut var_args := rt.create_array_from_list(var_args_origin)
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string('_n()')])
	return rt.call_function('_n', [var_args.clone()])
}

fn __ngettext_noop(var_args_origin ...rt.PhpVal) rt.PhpVal {
	mut var_args := rt.create_array_from_list(var_args_origin)
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string('_n_noop()')])
	return rt.call_function('_n_noop', [var_args.clone()])
}

fn get_alloptions() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('wp_load_alloptions()')])
	return rt.call_function('wp_load_alloptions', []rt.PhpVal{})
}

fn get_the_attachment_link(id i64, fullsize bool, max_dims bool, permalink bool) string {
	mut var_id := id
	mut var_fullsize := fullsize
	mut var_max_dims := max_dims
	mut var_permalink := permalink
	mut var__post := rt.new_null()
	mut var_url := rt.new_null()
	mut var_post_title := rt.new_null()
	mut var_innerHTML := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.5.0'), rt.new_string('wp_get_attachment_link()')])
	var_id = var_id
	var__post = rt.call_function('get_post', [rt.new_int(var_id)])
	var_url = rt.call_function('wp_get_attachment_url', [
		rt.get_property(var__post, 'ID'),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string('attachment'), rt.get_property(var__post, 'post_type')))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_url)))) {
		return (rt.call_function('__', [rt.new_string('Missing Attachment')])).str()
	}
	if var_permalink {
		var_url = rt.call_function('get_attachment_link', [
			rt.get_property(var__post, 'ID'),
		])
	}
	var_post_title = rt.call_function('esc_attr', [
		rt.get_property(var__post, 'post_title'),
	])
	var_innerHTML = rt.new_bool(get_attachment_innerhtml(rt.get_property(var__post, 'ID'),
		fullsize, max_dims))
	return "<a href='${var_url.to_string()}' title='${var_post_title.to_string()}'>${var_innerHTML.to_string()}</a>"
}

fn get_attachment_icon_src(id i64, fullsize bool) rt.PhpVal {
	mut var_id := id
	mut var_fullsize := fullsize
	mut var_post := rt.new_null()
	mut var_file := rt.new_null()
	mut var_src := rt.new_null()
	mut var_src_file := rt.new_null()
	mut var_icon_dir := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.5.0'), rt.new_string('wp_get_attachment_image_src()')])
	var_id = var_id
	var_post = rt.call_function('get_post', [rt.new_int(var_id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return rt.new_bool(false)
	}
	var_file = rt.call_function('get_attached_file', [rt.get_property(var_post, 'ID')])
	var_src = rt.call_function('wp_get_attachment_thumb_url', [
		rt.get_property(var_post, 'ID'),
	])
	if !var_fullsize && rt.is_true(var_src) {
		var_src_file = rt.call_function('wp_basename', [var_src.clone()])
	} else if rt.is_true(rt.call_function('wp_attachment_is_image', [
		rt.get_property(var_post, 'ID'),
	]))
	{
		var_src = rt.call_function('wp_get_attachment_url', [
			rt.get_property(var_post, 'ID'),
		])
		var_src_file = var_file
		var_src = rt.call_function('wp_mime_type_icon', [rt.get_property(var_post, 'ID'),
			rt.new_string('.svg')])
	} else if rt.is_true(var_src) {
		var_icon_dir = rt.call_function('apply_filters', [rt.new_string('icon_dir'),
			rt.new_string((rt.call_function('get_template_directory', []rt.PhpVal{})).str() +
				'/images')])
		var_src_file = rt.new_string(var_icon_dir.str() + '/' +
			(rt.call_function('wp_basename', [var_src.clone()])).str())
	}
	if !(!var_src.is_null()) || rt.is_true(rt.new_bool(!(rt.is_true(var_src)))) {
		return rt.new_bool(false)
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: var_src },
		rt.ArrayItem{ key: none, val: var_src_file }])
}

fn get_attachment_icon(id i64, fullsize bool, max_dims bool) bool {
	mut var_id := id
	mut var_fullsize := fullsize
	mut var_max_dims := max_dims
	mut var_src_file := rt.new_null()
	mut var_post := rt.new_null()
	mut var_src := rt.new_null()
	mut var_imagesize := rt.new_null()
	mut var_actual_aspect := rt.new_null()
	mut var_desired_aspect := rt.new_null()
	mut var_height := rt.new_null()
	mut var_constraint := ''
	mut var_width := rt.new_null()
	mut var_post_title := rt.new_null()
	mut var_icon := ''
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.5.0'), rt.new_string('wp_get_attachment_image()')])
	var_id = var_id
	var_post = rt.call_function('get_post', [rt.new_int(var_id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	var_src = get_attachment_icon_src(rt.get_property(var_post, 'ID'), fullsize)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_src)))) {
		return false
	}
	mut list_tmp_1 := var_src
	var_src = list_tmp_1.array_get(0)
	var_src_file = list_tmp_1.array_get(1)
	var_max_dims = (rt.call_function('apply_filters', [
		rt.new_string('attachment_max_dims'),
		rt.new_bool(var_max_dims),
	])).to_bool()
	if rt.is_true(var_max_dims)
		&& rt.is_true(rt.call_function('file_exists', [var_src_file.clone()])) {
		var_imagesize = rt.call_function('wp_getimagesize', [
			var_src_file.clone()])
		if rt.is_true(rt.greater(var_imagesize.array_get(rt.new_int(0)), rt.new_bool(var_max_dims).array_get(rt.new_int(0))))
			|| rt.is_true(rt.greater(var_imagesize.array_get(rt.new_int(1)), rt.new_bool(var_max_dims).array_get(rt.new_int(1)))) {
			var_actual_aspect = rt.div(var_imagesize.array_get(rt.new_int(0)),
				var_imagesize.array_get(rt.new_int(1)))
			var_desired_aspect = rt.div(rt.new_bool(var_max_dims).array_get(rt.new_int(0)),
				rt.new_bool(var_max_dims).array_get(rt.new_int(1)))
			if rt.is_true(rt.greater_equal(var_actual_aspect, var_desired_aspect)) {
				var_height = rt.mul(var_actual_aspect,
					rt.new_bool(var_max_dims).array_get(rt.new_int(0)))
				var_constraint = rt.concat(rt.concat(rt.new_string("width='"),
					rt.new_bool(var_max_dims).array_get(rt.new_int(0))), rt.new_string("' "))
				rt.set_property(var_post, 'iconsize', rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_bool(var_max_dims).array_get(rt.new_int(0)) },
					rt.ArrayItem{ key: none, val: var_height },
				]))
			} else {
				var_width = rt.div(rt.new_bool(var_max_dims).array_get(rt.new_int(1)),
					var_actual_aspect)
				var_constraint = rt.concat(rt.concat(rt.new_string("height='"),
					rt.new_bool(var_max_dims).array_get(rt.new_int(1))), rt.new_string("' "))
				rt.set_property(var_post, 'iconsize', rt.create_array([
					rt.ArrayItem{ key: none, val: var_width },
					rt.ArrayItem{ key: none, val: rt.new_bool(var_max_dims).array_get(rt.new_int(1)) },
				]))
			}
		} else {
			rt.set_property(var_post, 'iconsize', rt.create_array([
				rt.ArrayItem{ key: none, val: var_imagesize.array_get(rt.new_int(0)) },
				rt.ArrayItem{ key: none, val: var_imagesize.array_get(rt.new_int(1)) },
			]))
			var_constraint = ''
		}
	} else {
		var_constraint = ''
	}
	var_post_title = rt.call_function('esc_attr', [
		rt.get_property(var_post, 'post_title'),
	])
	var_icon = "<img src='${var_src.to_string()}' title='${var_post_title.to_string()}' alt='${var_post_title.to_string()}' ${var_constraint}/>"
	return (rt.call_function('apply_filters', [rt.new_string('attachment_icon'),
		rt.new_string(var_icon.str()).clone(), rt.get_property(var_post, 'ID')])).to_bool()
}

fn get_attachment_innerhtml(id i64, fullsize bool, max_dims bool) bool {
	mut var_id := id
	mut var_fullsize := fullsize
	mut var_max_dims := max_dims
	mut var_post := rt.new_null()
	mut var_innerHTML := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.5.0'), rt.new_string('wp_get_attachment_image()')])
	var_id = var_id
	var_post = rt.call_function('get_post', [rt.new_int(var_id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	var_innerHTML = rt.new_bool(get_attachment_icon(rt.get_property(var_post, 'ID'), fullsize,
		var_max_dims))
	if rt.is_true(var_innerHTML) {
		return var_innerHTML.to_bool()
	}
	var_innerHTML = rt.call_function('esc_attr', [
		rt.get_property(var_post, 'post_title'),
	])
	return (rt.call_function('apply_filters', [rt.new_string('attachment_innerHTML'),
		var_innerHTML.clone(), rt.get_property(var_post, 'ID')])).to_bool()
}

fn get_link(var_bookmark_id rt.PhpVal, var_output rt.PhpVal, filter string) rt.PhpVal {
	mut var_filter := filter
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('get_bookmark()')])
	return rt.call_function('get_bookmark', [var_bookmark_id.clone(),
		var_output.clone(), rt.new_string(filter)])
}

fn clean_url(var_url rt.PhpVal, var_protocols rt.PhpVal, context string) rt.PhpVal {
	mut var_context := context
	if rt.is_true(rt.equal(rt.new_string(context), rt.new_string('db'))) {
		rt.call_function('_deprecated_function', [
			rt.new_string("clean_url( $context = 'db' )"),
			rt.new_string('3.0.0'),
			rt.new_string('sanitize_url()'),
		])
	} else {
		rt.call_function('_deprecated_function', [rt.new_string(@FN),
			rt.new_string('3.0.0'), rt.new_string('esc_url()')])
	}
	return rt.call_function('esc_url', [var_url.clone(), var_protocols.clone(),
		rt.new_string(context)])
}

fn js_escape(var_text rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string('esc_js()')])
	return rt.call_function('esc_js', [var_text.clone()])
}

fn wp_specialchars(var_text rt.PhpVal, var_quote_style rt.PhpVal, charset bool, double_encode bool) rt.PhpVal {
	mut var_charset := charset
	mut var_double_encode := double_encode
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string('esc_html()')])
	if rt.is_true(rt.greater(rt.call_function('func_num_args', []rt.PhpVal{}), rt.new_int(1))) {
		return rt.call_function('_wp_specialchars', [var_text.clone(),
			var_quote_style.clone(), rt.new_bool(charset), rt.new_bool(double_encode)])
	} else {
		return rt.call_function('esc_html', [var_text.clone()])
	}
	return rt.new_null()
}

fn attribute_escape(var_text rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string('esc_attr()')])
	return rt.call_function('esc_attr', [var_text.clone()])
}

fn register_sidebar_widget(var_name_arg rt.PhpVal, var_output_callback rt.PhpVal, classname string, var_params_origin ...rt.PhpVal) {
	mut var_params := rt.create_array_from_list(var_params_origin)
	mut var_classname := classname
	mut var_name := var_name_arg
	mut var_id := rt.new_null()
	mut var_options := map[string]rt.PhpVal{}
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string('wp_register_sidebar_widget()')])
	if rt.is_true(rt.new_bool(var_name.clone().is_array())) {
		if var_name.clone().array_count() == 3 {
			var_name = rt.call_function('sprintf', [var_name.array_get(rt.new_int(0)),
				var_name.array_get(rt.new_int(2))])
		} else {
			var_name = var_name.array_get(rt.new_int(0))
		}
	}
	var_id = rt.call_function('sanitize_title', [var_name.clone()])
	var_options = []rt.PhpVal{}
	if !(classname == '') && rt.new_string(classname).is_string() {
		var_options['classname'] = rt.new_string(classname)
	}
	rt.call_function('wp_register_sidebar_widget', [var_id.clone(),
		var_name.clone(), var_output_callback.clone(), rt.create_array_from_native_map(var_options),
		var_params.clone()])
}

fn unregister_sidebar_widget(var_id rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string('wp_unregister_sidebar_widget()')])
	return rt.call_function('wp_unregister_sidebar_widget', [
		var_id.clone()])
}

fn register_widget_control(var_name_arg rt.PhpVal, var_control_callback rt.PhpVal, width string, height string, var_params_origin ...rt.PhpVal) {
	mut var_params := rt.create_array_from_list(var_params_origin)
	mut var_width := width
	mut var_height := height
	mut var_name := var_name_arg
	mut var_id := rt.new_null()
	mut var_options := map[string]rt.PhpVal{}
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string('wp_register_widget_control()')])
	if rt.is_true(rt.new_bool(var_name.clone().is_array())) {
		if var_name.clone().array_count() == 3 {
			var_name = rt.call_function('sprintf', [var_name.array_get(rt.new_int(0)),
				var_name.array_get(rt.new_int(2))])
		} else {
			var_name = var_name.array_get(rt.new_int(0))
		}
	}
	var_id = rt.call_function('sanitize_title', [var_name.clone()])
	var_options = []rt.PhpVal{}
	if !(width == '') {
		var_options['width'] = rt.new_string(width)
	}
	if !(height == '') {
		var_options['height'] = rt.new_string(height)
	}
	rt.call_function('wp_register_widget_control', [var_id.clone(),
		var_name.clone(), var_control_callback.clone(), rt.create_array_from_native_map(var_options),
		var_params.clone()])
}

fn unregister_widget_control(var_id rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.8.0'), rt.new_string('wp_unregister_widget_control()')])
	return rt.call_function('wp_unregister_widget_control', [
		var_id.clone()])
}

fn delete_usermeta(var_user_id rt.PhpVal, var_meta_key_arg rt.PhpVal, meta_value string) bool {
	mut var_meta_value := meta_value
	mut var_meta_key := var_meta_key_arg
	mut var_wpdb := rt.new_null()
	mut var_cur := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('delete_user_meta()')])
	if !(var_user_id.clone().is_long() || var_user_id.clone().is_double()) {
		return false
	}
	var_meta_key = rt.call_function('preg_replace', [rt.new_string('|[^a-z0-9_]|i'),
		rt.new_string(''), var_meta_key.clone()])
	if rt.new_string(var_meta_value.str()).is_array()
		|| rt.new_string(var_meta_value.str()).is_object() {
		var_meta_value = (rt.call_function('serialize', [
			rt.new_string(var_meta_value.str()),
		])).str()
	}
	var_meta_value = var_meta_value.trim_space()
	var_cur = rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
				'usermeta')), rt.new_string(' WHERE user_id = %d AND meta_key = %s')),
			var_user_id.clone(),
			var_meta_key.clone(),
		]),
	])
	if rt.is_true(var_cur) && rt.is_true(rt.get_property(var_cur, 'umeta_id')) {
		rt.call_function('do_action', [rt.new_string('delete_usermeta'),
			rt.get_property(var_cur, 'umeta_id'), var_user_id.clone(),
			var_meta_key.clone(), rt.new_string(var_meta_value.str())])
	}
	if !(var_meta_value == '') {
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb,
					'usermeta')),
					rt.new_string(' WHERE user_id = %d AND meta_key = %s AND meta_value = %s')),
				var_user_id.clone(),
				var_meta_key.clone(),
				rt.new_string(var_meta_value.str()),
			]),
		])
	} else {
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb,
					'usermeta')), rt.new_string(' WHERE user_id = %d AND meta_key = %s')),
				var_user_id.clone(),
				var_meta_key.clone(),
			]),
		])
	}
	rt.call_function('clean_user_cache', [var_user_id.clone()])
	rt.call_function('wp_cache_delete', [var_user_id.clone(),
		rt.new_string('user_meta')])
	if rt.is_true(var_cur) && rt.is_true(rt.get_property(var_cur, 'umeta_id')) {
		rt.call_function('do_action', [rt.new_string('deleted_usermeta'),
			rt.get_property(var_cur, 'umeta_id'), var_user_id.clone(),
			var_meta_key.clone(), rt.new_string(var_meta_value.str())])
	}
	return true
}

fn get_usermeta(var_user_id_arg rt.PhpVal, meta_key string) rt.PhpVal {
	mut var_meta_key := meta_key
	mut var_user_id := var_user_id_arg
	mut var_wpdb := rt.new_null()
	mut var_user := rt.new_null()
	mut var_metas := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('get_user_meta()')])
	var_user_id = rt.new_int(var_user_id.to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		return rt.new_bool(false)
	}
	if !(var_meta_key == '') {
		var_meta_key = (rt.call_function('preg_replace', [rt.new_string('|[^a-z0-9_]|i'),
			rt.new_string(''), rt.new_string(var_meta_key.str())])).str()
		var_user = rt.call_function('wp_cache_get', [var_user_id.clone(),
			rt.new_string('users')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_user))))
			&& !(rt.get_property(var_user, '{"nodeType":"Expr_Variable","line":2292,"name":"meta_key"}')).is_null() {
			var_metas = rt.create_array([
				rt.ArrayItem{ key: none, val: rt.get_property(var_user,
					'{"nodeType":"Expr_Variable","line":2293,"name":"meta_key"}') },
			])
		} else {
			var_metas = rt.call_method(var_wpdb, 'get_col', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('SELECT meta_value FROM '), rt.get_property(var_wpdb,
						'usermeta')), rt.new_string(' WHERE user_id = %d AND meta_key = %s')),
					var_user_id.clone(),
					rt.new_string(var_meta_key.str()),
				]),
			])
		}
	} else {
		var_metas = rt.call_method(var_wpdb, 'get_col', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT meta_value FROM '), rt.get_property(var_wpdb,
					'usermeta')), rt.new_string(' WHERE user_id = %d')),
				var_user_id.clone(),
			]),
		])
	}
	if !rt.is_true(var_metas) {
		if var_meta_key == '' {
			return []rt.PhpVal{}
		} else {
			return rt.new_string('')
		}
	}
	var_metas = rt.call_function('array_map', [rt.new_string('maybe_unserialize'),
		var_metas.clone()])
	if var_metas.clone().array_count() == 1 {
		return var_metas.array_get(rt.new_int(0))
	} else {
		return var_metas.clone()
	}
	return rt.new_null()
}

fn update_usermeta(var_user_id rt.PhpVal, var_meta_key_arg rt.PhpVal, var_meta_value_arg rt.PhpVal) bool {
	mut var_meta_key := var_meta_key_arg
	mut var_meta_value := var_meta_value_arg
	mut var_wpdb := rt.new_null()
	mut var_cur := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('update_user_meta()')])
	if !(var_user_id.clone().is_long() || var_user_id.clone().is_double()) {
		return false
	}
	var_meta_key = rt.call_function('preg_replace', [rt.new_string('|[^a-z0-9_]|i'),
		rt.new_string(''), var_meta_key.clone()])
	if rt.is_true(rt.new_bool(var_meta_value.clone().is_string())) {
		var_meta_value = rt.call_function('stripslashes', [var_meta_value.clone()])
	}
	var_meta_value = rt.call_function('maybe_serialize', [var_meta_value.clone()])
	if !rt.is_true(var_meta_value) {
		return delete_usermeta(var_user_id.clone(), var_meta_key.clone())
	}
	var_cur = rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
				'usermeta')), rt.new_string(' WHERE user_id = %d AND meta_key = %s')),
			var_user_id.clone(),
			var_meta_key.clone(),
		]),
	])
	if rt.is_true(var_cur) {
		rt.call_function('do_action', [rt.new_string('update_usermeta'),
			rt.get_property(var_cur, 'umeta_id'), var_user_id.clone(),
			var_meta_key.clone(), var_meta_value.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_cur)))) {
		rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'usermeta'),
			rt.call_function('compact', [rt.new_string('user_id'),
				rt.new_string('meta_key'), rt.new_string('meta_value')])])
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.get_property(var_cur, 'meta_value'),
		var_meta_value))))
	{
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'usermeta'),
			rt.call_function('compact', [rt.new_string('meta_value')]),
			rt.call_function('compact', [rt.new_string('user_id'),
				rt.new_string('meta_key')])])
	} else {
		return false
	}
	rt.call_function('clean_user_cache', [var_user_id.clone()])
	rt.call_function('wp_cache_delete', [var_user_id.clone(),
		rt.new_string('user_meta')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_cur)))) {
		rt.call_function('do_action', [rt.new_string('added_usermeta'),
			rt.get_property(var_wpdb, 'insert_id'), var_user_id.clone(),
			var_meta_key.clone(), var_meta_value.clone()])
	} else {
		rt.call_function('do_action', [rt.new_string('updated_usermeta'),
			rt.get_property(var_cur, 'umeta_id'), var_user_id.clone(),
			var_meta_key.clone(), var_meta_value.clone()])
	}
	return true
}

fn get_users_of_blog(id string) rt.PhpVal {
	mut var_id := id
	mut var_wpdb := rt.new_null()
	mut var_blog_prefix := rt.new_null()
	mut var_users := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.1.0'), rt.new_string('get_users()')])
	if var_id == '' {
		var_id = (rt.call_function('get_current_blog_id', []rt.PhpVal{})).str()
	}
	var_blog_prefix = rt.call_method(var_wpdb, 'get_blog_prefix', [
		rt.new_string(var_id.str()),
	])
	var_users = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT user_id, user_id AS ID, user_login, display_name, user_email, meta_value FROM '), rt.get_property(var_wpdb,
			'users')), rt.new_string(', ')), rt.get_property(var_wpdb, 'usermeta')),
			rt.new_string(' WHERE ')), rt.get_property(var_wpdb, 'users')), rt.new_string('.ID = ')), rt.get_property(var_wpdb,
			'usermeta')), rt.new_string(".user_id AND meta_key = '")), var_blog_prefix),
			rt.new_string("capabilities' ORDER BY ")), rt.get_property(var_wpdb, 'usermeta')),
			rt.new_string('.user_id')),
	])
	return var_users.clone()
}

fn automatic_feed_links(add bool) {
	mut var_add := add
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string("add_theme_support( 'automatic-feed-links' )")])
	if var_add {
		rt.call_function('add_theme_support', [rt.new_string('automatic-feed-links')])
	} else {
		rt.call_function('remove_action', [rt.new_string('wp_head'),
			rt.new_string('feed_links_extra'), rt.new_int(3)])
	}
}

fn get_profile(var_field rt.PhpVal, user bool) rt.PhpVal {
	mut var_user := user
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('get_the_author_meta()')])
	if var_user {
		var_user = (rt.call_function('get_user_by', [rt.new_string('login'),
			rt.new_bool(var_user)])).to_bool()
		var_user = (rt.get_property(rt.new_bool(var_user), 'ID')).to_bool()
	}
	return rt.call_function('get_the_author_meta', [var_field.clone(),
		rt.new_bool(var_user)])
}

fn get_usernumposts(var_userid rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('count_user_posts()')])
	return rt.call_function('count_user_posts', [var_userid.clone()])
}

fn funky_javascript_callback(var_matches rt.PhpVal) string {
	return '&#' +
		(rt.call_function('base_convert', [var_matches[1], rt.new_int(16), rt.new_int(10)])).str() +
		';'
}

fn funky_javascript_fix(var_text_arg rt.PhpVal) rt.PhpVal {
	mut var_text := var_text_arg
	mut var_is_macIE := rt.new_null()
	mut var_is_winIE := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0')])
	if rt.is_true(var_is_winIE) || rt.is_true(var_is_macIE) {
		var_text = rt.call_function('preg_replace_callback', [
			rt.new_string('/\\%u([0-9A-F]{4,4})/'),
			rt.new_string('funky_javascript_callback'),
			var_text.clone(),
		])
	}
	return var_text.clone()
}

fn is_taxonomy(var_taxonomy rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('taxonomy_exists()')])
	return rt.call_function('taxonomy_exists', [var_taxonomy.clone()])
}

fn is_term(var_term rt.PhpVal, taxonomy string, parent i64) rt.PhpVal {
	mut var_taxonomy := taxonomy
	mut var_parent := parent
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('term_exists()')])
	return rt.call_function('term_exists', [var_term.clone(),
		rt.new_string(taxonomy), rt.new_int(parent)])
}

fn is_plugin_page() bool {
	mut var_plugin_page := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.1.0')])
	if !var_plugin_page.is_null() {
		return true
	}
	return false
}

fn update_category_cache() bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.1.0')])
	return true
}

fn wp_timezone_supported() bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.2.0')])
	return true
}

fn the_editor(var_content rt.PhpVal, id string, prev_id string, media_buttons bool, tab_index i64, extended bool) {
	mut var_id := id
	mut var_prev_id := prev_id
	mut var_media_buttons := media_buttons
	mut var_tab_index := tab_index
	mut var_extended := extended
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string('wp_editor()')])
	rt.call_function('wp_editor', [var_content.clone(), rt.new_string(var_id.str()),
		rt.create_array([rt.ArrayItem{ key: 'media_buttons', val: media_buttons }])])
}

fn get_user_metavalues(var_ids_arg rt.PhpVal) rt.PhpVal {
	mut var_ids := var_ids_arg
	mut var_objects := rt.new_null()
	mut var_id := rt.new_null()
	mut var_metas := rt.new_null()
	mut var_meta := rt.new_null()
	mut var_metavalues := rt.new_null()
	mut var_key := rt.new_null()
	mut var_value := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0')])
	var_objects = []rt.PhpVal{}
	var_ids = rt.call_function('array_map', [rt.new_string('intval'),
		var_ids.clone()])
	mut iter_5 := var_ids.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_id_shadow := item_5.val
		var_objects.array_set(var_id_shadow, []rt.PhpVal{})
	}
	var_metas = rt.call_function('update_meta_cache', [rt.new_string('user'),
		var_ids.clone()])
	mut iter_6 := var_metas.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_meta_shadow := item_6.val
		mut var_id_shadow := item_6.key
		mut iter_7 := var_meta_shadow.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_metavalues_shadow := item_7.val
			mut var_key_shadow := item_7.key
			mut iter_8 := var_metavalues_shadow.iterator()
			for {
				item_8 := iter_8.next() or { break }
				mut var_value_shadow := item_8.val
				var_objects.array_get_mut(var_id_shadow).array_push(rt.array_to_object(rt.create_array([
					rt.ArrayItem{ key: 'user_id', val: var_id_shadow },
					rt.ArrayItem{ key: 'meta_key', val: var_key_shadow },
					rt.ArrayItem{ key: 'meta_value', val: var_value_shadow },
				])))
			}
		}
	}
	return var_objects.clone()
}

fn sanitize_user_object(var_user rt.PhpVal, context string) rt.PhpVal {
	mut var_context := context
	mut var_vars := rt.new_null()
	mut var_field := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0')])
	if rt.is_true(rt.new_bool(var_user.clone().is_object())) {
		if !(!(rt.get_property(var_user, 'ID')).is_null()) {
			rt.set_property(var_user, 'ID', rt.new_int(0))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User')))))) {
			var_vars = rt.call_function('get_object_vars', [var_user.clone()])
			mut iter_9 := rt.func_array_keys(var_vars.clone()).iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_field_shadow := item_9.val
				if rt.get_property(var_user, '{"nodeType":"Expr_Variable","line":2658,"name":"field"}').is_string()
					|| rt.get_property(var_user, '{"nodeType":"Expr_Variable","line":2658,"name":"field"}').is_long()
					|| rt.get_property(var_user, '{"nodeType":"Expr_Variable","line":2658,"name":"field"}').is_double() {
					rt.set_property(var_user,
						'{"nodeType":"Expr_Variable","line":2659,"name":"field"}', rt.call_function('sanitize_user_field', [
						var_field_shadow.clone(),
						rt.get_property(var_user,
							'{"nodeType":"Expr_Variable","line":2659,"name":"field"}'),
						rt.get_property(var_user, 'ID'),
						rt.new_string(context),
					]))
				}
			}
		}
		rt.set_property(var_user, 'filter', rt.new_string(context))
	} else {
		if !(var_user.array_isset(rt.new_string('ID'))) {
			var_user.array_set('ID', 0)
		}
		mut iter_10 := rt.func_array_keys(var_user.clone()).iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_field_shadow := item_10.val
			var_user.array_set(var_field_shadow, rt.call_function('sanitize_user_field', [
				var_field_shadow.clone(),
				var_user.array_get(var_field_shadow),
				var_user.array_get(rt.new_string('ID')),
				rt.new_string(context),
			]))
		}
		var_user.array_set('filter', context)
	}
	return var_user.clone()
}

fn get_boundary_post_rel_link(title string, in_same_cat bool, excluded_categories string, start bool) rt.PhpVal {
	mut var_title := title
	mut var_in_same_cat := in_same_cat
	mut var_excluded_categories := excluded_categories
	mut var_start := start
	mut var_posts := rt.new_null()
	mut var_post := rt.new_null()
	mut var_date := rt.new_null()
	mut var_link := ''
	mut var_boundary := ''
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0')])
	var_posts = rt.call_function('get_boundary_post', [rt.new_bool(var_in_same_cat),
		rt.new_string(excluded_categories), rt.new_bool(start)])
	if !rt.is_true(var_posts) {
		return rt.new_null()
	}
	var_post = var_posts.array_get(rt.new_int(0))
	if !rt.is_true(rt.get_property(var_post, 'post_title')) {
		rt.set_property(var_post, 'post_title', if var_start { rt.call_function('__', [
				rt.new_string('First Post'),
			]) } else { rt.call_function('__', [rt.new_string('Last Post')]) })
	}
	var_date = rt.call_function('mysql2date', [
		rt.call_function('get_option', [rt.new_string('date_format')]),
		rt.get_property(var_post, 'post_date'),
	])
	var_title = (rt.call_function('str_replace', [rt.new_string('%title'),
		rt.get_property(var_post, 'post_title'), rt.new_string(var_title.str())])).str()
	var_title = (rt.call_function('str_replace', [rt.new_string('%date'),
		var_date.clone(), rt.new_string(var_title.str())])).str()
	var_title = (rt.call_function('apply_filters', [rt.new_string('the_title'),
		rt.new_string(var_title.str()), rt.get_property(var_post, 'ID')])).str()
	var_link = if var_start { "<link rel='start' title='" } else { "<link rel='end' title='" }
	var_link = var_link + (rt.call_function('esc_attr', [rt.new_string(var_title.str())])).str()
	var_link = var_link + "' href='" +
		(rt.call_function('get_permalink', [var_post.clone()])).str() + "' />\n"
	var_boundary = if var_start { 'start' } else { 'end' }
	return rt.call_function('apply_filters', [
		rt.new_string('${var_boundary}_post_rel_link'),
		rt.new_string(var_link.str()).clone(),
	])
}

fn start_post_rel_link(title string, in_same_cat bool, excluded_categories string) {
	mut var_title := title
	mut var_in_same_cat := in_same_cat
	mut var_excluded_categories := excluded_categories
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0')])
	rt.echo_val(get_boundary_post_rel_link(var_title, var_in_same_cat, excluded_categories, true))
}

fn get_index_rel_link() rt.PhpVal {
	mut var_link := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0')])
	var_link = rt.new_string("<link rel='index' title='" +
		(rt.call_function('esc_attr', [rt.call_function('get_bloginfo', [rt.new_string('name'), rt.new_string('display')])])).str() +
		"' href='" +
		(rt.call_function('esc_url', [rt.call_function('user_trailingslashit', [rt.call_function('get_bloginfo', [rt.new_string('url'), rt.new_string('display')])])])).str() +
		"' />\n")
	return rt.call_function('apply_filters', [rt.new_string('index_rel_link'),
		var_link.clone()])
}

fn index_rel_link() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0')])
	rt.echo_val(get_index_rel_link())
}

fn get_parent_post_rel_link(title string) rt.PhpVal {
	mut var_title := title
	mut var_GLOBALS := rt.new_null()
	mut var_post := rt.new_null()
	mut var_date := rt.new_null()
	mut var_link := ''
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0')])
	if !(!rt.is_true(var_GLOBALS.array_get(rt.new_string('post'))))
		&& !(!rt.is_true(rt.get_property(var_GLOBALS.array_get(rt.new_string('post')), 'post_parent'))) {
		var_post = rt.call_function('get_post', [
			rt.get_property(var_GLOBALS.array_get(rt.new_string('post')), 'post_parent'),
		])
	}
	if !rt.is_true(var_post) {
		return rt.new_null()
	}
	var_date = rt.call_function('mysql2date', [
		rt.call_function('get_option', [rt.new_string('date_format')]),
		rt.get_property(var_post, 'post_date'),
	])
	var_title = (rt.call_function('str_replace', [rt.new_string('%title'),
		rt.get_property(var_post, 'post_title'), rt.new_string(var_title.str())])).str()
	var_title = (rt.call_function('str_replace', [rt.new_string('%date'),
		var_date.clone(), rt.new_string(var_title.str())])).str()
	var_title = (rt.call_function('apply_filters', [rt.new_string('the_title'),
		rt.new_string(var_title.str()), rt.get_property(var_post, 'ID')])).str()
	var_link = "<link rel='up' title='"
	var_link = var_link + (rt.call_function('esc_attr', [rt.new_string(var_title.str())])).str()
	var_link = var_link + "' href='" +
		(rt.call_function('get_permalink', [var_post.clone()])).str() + "' />\n"
	return rt.call_function('apply_filters', [rt.new_string('parent_post_rel_link'),
		rt.new_string(var_link.str()).clone()])
}

fn parent_post_rel_link(title string) {
	mut var_title := title
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0')])
	rt.echo_val(get_parent_post_rel_link(var_title))
}

fn wp_admin_bar_dashboard_view_site_menu(var_wp_admin_bar rt.PhpVal) {
	mut var_user_id := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0')])
	var_user_id = rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_int(0), var_user_id)))) {
		if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
			rt.call_method(var_wp_admin_bar, 'add_menu', [
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'view-site' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Visit Site'),
					]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('home_url',
						[]rt.PhpVal{}) }]),
			])
		} else if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			rt.call_method(var_wp_admin_bar, 'add_menu', [
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'dashboard' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Dashboard'),
					]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('get_dashboard_url', [
						var_user_id.clone(),
					]) }]),
			])
		} else {
			rt.call_method(var_wp_admin_bar, 'add_menu', [
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'dashboard' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Dashboard'),
					]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('admin_url',
						[]rt.PhpVal{}) }]),
			])
		}
	}
}

fn is_blog_user(blog_id i64) rt.PhpVal {
	mut var_blog_id := blog_id
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string('is_user_member_of_blog()')])
	return rt.call_function('is_user_member_of_blog', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		rt.new_int(blog_id),
	])
}

fn debug_fopen(var_filename rt.PhpVal, var_mode rt.PhpVal) bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.4.0'), rt.new_string('error_log()')])
	return false
}

fn debug_fwrite(var_fp rt.PhpVal, var_message rt.PhpVal) {
	mut var_GLOBALS := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.4.0'), rt.new_string('error_log()')])
	if !(!rt.is_true(var_GLOBALS.array_get(rt.new_string('debug')))) {
		rt.call_function('error_log', [var_message.clone()])
	}
}

fn debug_fclose(var_fp rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.4.0'), rt.new_string('error_log()')])
}

fn get_themes() rt.PhpVal {
	mut var_themes := rt.new_null()
	mut var_wp_themes := rt.new_null()
	mut var_theme := rt.new_null()
	mut var_name := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.4.0'), rt.new_string('wp_get_themes()')])
	if !var_wp_themes.is_null() {
		return var_wp_themes.clone()
	}
	var_themes = rt.call_function('wp_get_themes', []rt.PhpVal{})
	var_wp_themes = []rt.PhpVal{}
	mut iter_11 := var_themes.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_theme_shadow := item_11.val
		var_name = var_theme_shadow.get(rt.new_string('Name'))
		if var_wp_themes.array_isset(var_name) {
			var_wp_themes.array_set(var_name.str() + '/' + (var_theme_shadow.get_stylesheet()).str(),
				var_theme_shadow.clone())
		} else {
			var_wp_themes.array_set(var_name, var_theme_shadow.clone())
		}
	}
	return var_wp_themes.clone()
}

fn get_theme(var_theme rt.PhpVal) rt.PhpVal {
	mut var_themes := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.4.0'), rt.new_string('wp_get_theme( $stylesheet )')])
	var_themes = get_themes()
	if var_themes.clone().is_array()
		&& rt.is_true(rt.new_bool(var_themes.clone().array_isset(var_theme))) {
		return var_themes.array_get(var_theme)
	}
	return rt.new_null()
}

fn get_current_theme() rt.PhpVal {
	mut var_theme := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.4.0'), rt.new_string('wp_get_theme()')])
	var_theme = rt.call_function('get_option', [rt.new_string('current_theme')])
	if rt.is_true(var_theme) {
		return mut var_theme
	}
	return mut rt.cast_object_ptr[Class_WP_Theme](rt.call_method(rt.call_function('wp_get_theme',
		[]rt.PhpVal{}), 'get', [rt.new_string('Name')]))
}

fn clean_pre(var_matches rt.PhpVal) rt.PhpVal {
	mut var_text := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.4.0')])
	if rt.is_true(rt.new_bool(rt.create_array_from_list(var_matches).is_array())) {
		var_text = rt.new_string((var_matches[1]).str() + (var_matches[2]).str() + '</pre>')
	} else {
		var_text = var_matches
	}
	var_text = rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: '<br />' },
			rt.ArrayItem{ key: none, val: '<br/>' }, rt.ArrayItem{ key: none, val: '<br>' }]),
		rt.create_array([rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: '' },
			rt.ArrayItem{ key: none, val: '' }]),
		var_text.clone(),
	])
	var_text = rt.call_function('str_replace', [rt.new_string('<p>'),
		rt.new_string('\n'), var_text.clone()])
	var_text = rt.call_function('str_replace', [rt.new_string('</p>'),
		rt.new_string(''), var_text.clone()])
	return var_text.clone()
}

fn add_custom_image_header(var_wp_head_callback rt.PhpVal, var_admin_head_callback rt.PhpVal, admin_preview_callback string) rt.PhpVal {
	mut var_admin_preview_callback := admin_preview_callback
	mut var_args := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.4.0'), rt.new_string("add_theme_support( 'custom-header', $args )")])
	var_args = rt.create_array([
		rt.ArrayItem{ key: 'wp-head-callback', val: var_wp_head_callback },
		rt.ArrayItem{ key: 'admin-head-callback', val: var_admin_head_callback },
	])
	if var_admin_preview_callback.len > 0 && var_admin_preview_callback != '0' {
		var_args.array_set('admin-preview-callback', admin_preview_callback)
	}
	return rt.call_function('add_theme_support', [rt.new_string('custom-header'),
		var_args.clone()])
}

fn remove_custom_image_header() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.4.0'), rt.new_string("remove_theme_support( 'custom-header' )")])
	return rt.call_function('remove_theme_support', [rt.new_string('custom-header')])
}

fn add_custom_background(wp_head_callback string, admin_head_callback string, admin_preview_callback string) rt.PhpVal {
	mut var_wp_head_callback := wp_head_callback
	mut var_admin_head_callback := admin_head_callback
	mut var_admin_preview_callback := admin_preview_callback
	mut var_args := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.4.0'), rt.new_string("add_theme_support( 'custom-background', $args )")])
	var_args = []rt.PhpVal{}
	if var_wp_head_callback.len > 0 && var_wp_head_callback != '0' {
		var_args.array_set('wp-head-callback', wp_head_callback)
	}
	if var_admin_head_callback.len > 0 && var_admin_head_callback != '0' {
		var_args.array_set('admin-head-callback', admin_head_callback)
	}
	if var_admin_preview_callback.len > 0 && var_admin_preview_callback != '0' {
		var_args.array_set('admin-preview-callback', admin_preview_callback)
	}
	return rt.call_function('add_theme_support', [rt.new_string('custom-background'),
		var_args.clone()])
}

fn remove_custom_background() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.4.0'), rt.new_string("remove_theme_support( 'custom-background' )")])
	return rt.call_function('remove_theme_support', [rt.new_string('custom-background')])
}

fn get_theme_data(var_theme_file rt.PhpVal) rt.PhpVal {
	mut var_theme := rt.new_null()
	mut var_theme_data := rt.new_null()
	mut var_extra_header := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.4.0'), rt.new_string('wp_get_theme()')])
	var_theme = create_wp_theme(rt.call_function('wp_basename', [
		rt.call_function('dirname', [var_theme_file.clone()]),
	]), rt.call_function('dirname', [
		rt.call_function('dirname', [var_theme_file.clone()]),
	]))
	var_theme_data = rt.create_array([
		rt.ArrayItem{ key: 'Name', val: var_theme.get(rt.new_string('Name')) },
		rt.ArrayItem{ key: 'URI', val: var_theme.display(rt.new_string('ThemeURI'),
			rt.new_bool(true), rt.new_bool(false)) },
		rt.ArrayItem{ key: 'Description', val: var_theme.display(rt.new_string('Description'),
			rt.new_bool(true), rt.new_bool(false)) },
		rt.ArrayItem{ key: 'Author', val: var_theme.display(rt.new_string('Author'),
			rt.new_bool(true), rt.new_bool(false)) },
		rt.ArrayItem{ key: 'AuthorURI', val: var_theme.display(rt.new_string('AuthorURI'),
			rt.new_bool(true), rt.new_bool(false)) },
		rt.ArrayItem{ key: 'Version', val: var_theme.get(rt.new_string('Version')) },
		rt.ArrayItem{ key: 'Template', val: var_theme.get(rt.new_string('Template')) },
		rt.ArrayItem{ key: 'Status', val: var_theme.get(rt.new_string('Status')) },
		rt.ArrayItem{ key: 'Tags', val: var_theme.get(rt.new_string('Tags')) },
		rt.ArrayItem{ key: 'Title', val: var_theme.get(rt.new_string('Name')) },
		rt.ArrayItem{ key: 'AuthorName', val: var_theme.get(rt.new_string('Author')) },
	])
	mut iter_12 := rt.call_function('apply_filters', [
		rt.new_string('extra_theme_headers'),
		[]rt.PhpVal{},
	]).iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_extra_header_shadow := item_12.val
		if !(var_theme_data.array_isset(var_extra_header_shadow)) {
			var_theme_data.array_set(var_extra_header_shadow,
				var_theme.get(var_extra_header_shadow.clone()))
		}
	}
	return var_theme_data.clone()
}

fn update_page_cache(var_pages rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.4.0'), rt.new_string('update_post_cache()')])
	rt.call_function('update_post_cache', [var_pages.clone()])
}

fn clean_page_cache(var_id rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.4.0'), rt.new_string('clean_post_cache()')])
	rt.call_function('clean_post_cache', [var_id.clone()])
}

fn wp_explain_nonce(var_action rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.4.1'), rt.new_string('wp_nonce_ays()')])
	return rt.call_function('__', [rt.new_string('Are you sure you want to do this?')])
}

fn sticky_class(var_post_id rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.5.0'), rt.new_string('post_class()')])
	if rt.is_true(rt.call_function('is_sticky', [var_post_id.clone()])) {
		print(' sticky')
	}
}

fn _get_post_ancestors(var_post rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.5.0')])
}

fn wp_load_image(var_file_arg rt.PhpVal) rt.PhpVal {
	mut var_file := var_file_arg
	mut var_image := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.5.0'), rt.new_string('wp_get_image_editor()')])
	if rt.is_true(rt.new_bool(var_file.clone().is_long() || var_file.clone().is_double())) {
		var_file = rt.call_function('get_attached_file', [var_file.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [
		var_file.clone()])))))
	{
		return rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('File &#8220;%s&#8221; does not exist?'),
			]),
			var_file.clone(),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('imagecreatefromstring'),
	])))))
	{
		return rt.call_function('__', [
			rt.new_string('The GD image library is not installed.'),
		])
	}
	rt.call_function('wp_raise_memory_limit', [rt.new_string('image')])
	var_image = rt.call_function('imagecreatefromstring', [
		rt.call_function('file_get_contents', [var_file.clone()]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_gd_image', [
		var_image.clone()])))))
	{
		return rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('File &#8220;%s&#8221; is not an image.'),
			]),
			var_file.clone(),
		])
	}
	return var_image.clone()
}

fn image_resize(var_file rt.PhpVal, var_max_w rt.PhpVal, var_max_h rt.PhpVal, crop bool, var_suffix rt.PhpVal, var_dest_path rt.PhpVal, jpeg_quality i64) rt.PhpVal {
	mut var_crop := crop
	mut var_jpeg_quality := jpeg_quality
	mut var_editor := rt.new_null()
	mut var_resized := rt.new_null()
	mut var_dest_file := rt.new_null()
	mut var_saved := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.5.0'), rt.new_string('wp_get_image_editor()')])
	var_editor = rt.call_function('wp_get_image_editor', [var_file.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_editor.clone()])) {
		return var_editor.clone()
	}
	rt.call_method(var_editor, 'set_quality', [rt.new_int(jpeg_quality)])
	var_resized = rt.call_method(var_editor, 'resize', [var_max_w.clone(),
		var_max_h.clone(), rt.new_bool(crop)])
	if rt.is_true(rt.call_function('is_wp_error', [var_resized.clone()])) {
		return var_resized.clone()
	}
	var_dest_file = rt.call_method(var_editor, 'generate_filename', [
		var_suffix.clone(), var_dest_path.clone()])
	var_saved = rt.call_method(var_editor, 'save', [var_dest_file.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_saved.clone()])) {
		return var_saved.clone()
	}
	return var_dest_file.clone()
}

fn wp_get_single_post(postid i64, var_mode rt.PhpVal) rt.PhpVal {
	mut var_postid := postid
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.5.0'), rt.new_string('get_post()')])
	return rt.call_function('get_post', [rt.new_int(postid), var_mode.clone()])
}

fn user_pass_ok(var_user_login rt.PhpVal, var_user_pass rt.PhpVal) bool {
	mut var_user := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.5.0'), rt.new_string('wp_authenticate()')])
	var_user = rt.call_function('wp_authenticate', [var_user_login.clone(),
		var_user_pass.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return false
	}
	return true
}

fn _save_post_hook() {
}

fn gd_edit_image_support(var_mime_type rt.PhpVal) bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.5.0'), rt.new_string('wp_image_editor_supports()')])
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('imagetypes')])) {
		mut switch_val_1 := var_mime_type
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/jpeg'))) {
			return rt.new_bool(rt.bitwise_and(rt.call_function('imagetypes', []rt.PhpVal{}),
				rt.get_constant('IMG_JPG')) != 0)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/png'))) {
			return rt.new_bool(rt.bitwise_and(rt.call_function('imagetypes', []rt.PhpVal{}),
				rt.get_constant('IMG_PNG')) != 0)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/gif'))) {
			return rt.new_bool(rt.bitwise_and(rt.call_function('imagetypes', []rt.PhpVal{}),
				rt.get_constant('IMG_GIF')) != 0)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/webp'))) {
			return rt.new_bool(rt.bitwise_and(rt.call_function('imagetypes', []rt.PhpVal{}),
				rt.get_constant('IMG_WEBP')) != 0)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image/avif'))) {
			return rt.new_bool(rt.bitwise_and(rt.call_function('imagetypes', []rt.PhpVal{}),
				rt.get_constant('IMG_AVIF')) != 0)
		}
	} else {
		mut switch_val_2 := var_mime_type
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('image/jpeg'))) {
			return (rt.call_function('function_exists', [
				rt.new_string('imagecreatefromjpeg'),
			])).to_bool()
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('image/png'))) {
			return (rt.call_function('function_exists', [
				rt.new_string('imagecreatefrompng'),
			])).to_bool()
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('image/gif'))) {
			return (rt.call_function('function_exists', [
				rt.new_string('imagecreatefromgif'),
			])).to_bool()
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('image/webp'))) {
			return (rt.call_function('function_exists', [
				rt.new_string('imagecreatefromwebp'),
			])).to_bool()
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('image/avif'))) {
			return (rt.call_function('function_exists', [
				rt.new_string('imagecreatefromavif'),
			])).to_bool()
		}
	}
	return false
}

fn wp_convert_bytes_to_hr(var_bytes rt.PhpVal) string {
	mut var_units := rt.new_null()
	mut var_log := rt.new_null()
	mut var_power := rt.new_null()
	mut var_size := rt.new_null()
	mut var_unit := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.6.0'), rt.new_string('size_format()')])
	var_units = rt.create_array([rt.ArrayItem{ key: 0, val: 'B' },
		rt.ArrayItem{ key: 1, val: 'KB' }, rt.ArrayItem{ key: 2, val: 'MB' },
		rt.ArrayItem{ key: 3, val: 'GB' }, rt.ArrayItem{ key: 4, val: 'TB' }])
	var_log = rt.call_function('log', [var_bytes.clone(), rt.get_constant('KB_IN_BYTES')])
	var_power = rt.new_int(if !(rt.call_function('is_nan', [var_log.clone()]))
		&& !(rt.call_function('is_infinite', [var_log.clone()])) {
		rt.new_int(var_log.to_i64())
	} else {
		0
	})
	var_size = rt.new_null()
	if !(rt.call_function('is_nan', [var_size.clone()]))
		&& rt.is_true(rt.new_bool(var_units.clone().array_isset(var_power.clone()))) {
		var_unit = var_units.array_get(var_power)
	} else {
		var_size = var_bytes
		var_unit = var_units.array_get(rt.new_int(0))
	}
	return var_size.str() + var_unit.str()
}

fn _search_terms_tidy(var_t rt.PhpVal) string {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.7.0')])
	return var_t.clone().to_string().trim_space()
}

fn rich_edit_exists() rt.PhpVal {
	mut var_wp_rich_edit_exists := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.9.0')])
	if !(!var_wp_rich_edit_exists.is_null()) {
		var_wp_rich_edit_exists = rt.call_function('file_exists', [
			rt.new_string(
				(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/js/tinymce/tinymce.js'),
		])
	}
	return var_wp_rich_edit_exists.clone()
}

fn default_topic_count_text(var_count rt.PhpVal) rt.PhpVal {
	return var_count.clone()
}

fn format_to_post(var_content rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.9.0')])
	return var_content.clone()
}

fn like_escape(var_text rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.0.0'), rt.new_string('wpdb::esc_like()')])
	return rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: '%' },
			rt.ArrayItem{ key: none, val: '_' }]),
		rt.create_array([rt.ArrayItem{ key: none, val: '\\%' },
			rt.ArrayItem{ key: none, val: '\\_' }]),
		var_text.clone(),
	])
}

fn url_is_accessable_via_ssl(var_url rt.PhpVal) bool {
	mut var_response := rt.new_null()
	mut var_status := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.0.0')])
	var_response = rt.call_function('wp_remote_get', [
		rt.call_function('set_url_scheme', [var_url.clone(), rt.new_string('https')]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		var_response.clone()])))))
	{
		var_status = rt.call_function('wp_remote_retrieve_response_code', [
			var_response.clone()])
		if rt.is_true(rt.equal(rt.new_int(200), var_status))
			|| rt.is_true(rt.equal(rt.new_int(401), var_status)) {
			return true
		}
	}
	return false
}

fn preview_theme() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.3.0')])
}

fn _preview_theme_template_filter() string {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.3.0')])
	return ''
}

fn _preview_theme_stylesheet_filter() string {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.3.0')])
	return ''
}

fn preview_theme_ob_filter(var_content rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.3.0')])
	return var_content.clone()
}

fn preview_theme_ob_filter_callback(var_matches rt.PhpVal) string {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.3.0')])
	return ''
}

fn wp_richedit_pre(var_text rt.PhpVal) rt.PhpVal {
	mut var_output := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.3.0'), rt.new_string('format_for_editor()')])
	if !rt.is_true(var_text) {
		return rt.call_function('apply_filters', [rt.new_string('richedit_pre'),
			rt.new_string('')])
	}
	var_output = rt.call_function('convert_chars', [var_text.clone()])
	var_output = rt.call_function('wpautop', [var_output.clone()])
	var_output = rt.call_function('htmlspecialchars', [var_output.clone(),
		rt.get_constant('ENT_NOQUOTES'), rt.call_function('get_option', [
			rt.new_string('blog_charset'),
		])])
	return rt.call_function('apply_filters', [rt.new_string('richedit_pre'),
		var_output.clone()])
}

fn wp_htmledit_pre(var_output_arg rt.PhpVal) rt.PhpVal {
	mut var_output := var_output_arg
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.3.0'), rt.new_string('format_for_editor()')])
	if !(!rt.is_true(var_output)) {
		var_output = rt.call_function('htmlspecialchars', [var_output.clone(),
			rt.get_constant('ENT_NOQUOTES'),
			rt.call_function('get_option', [
				rt.new_string('blog_charset'),
			])])
	}
	return rt.call_function('apply_filters', [rt.new_string('htmledit_pre'),
		var_output.clone()])
}

fn post_permalink(post i64) rt.PhpVal {
	mut var_post := post
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.4.0'), rt.new_string('get_permalink()')])
	return rt.call_function('get_permalink', [rt.new_int(post)])
}

fn wp_get_http(var_url rt.PhpVal, file_path bool, red i64) bool {
	mut var_file_path := file_path
	mut var_red := red
	mut var_options := map[string]rt.PhpVal{}
	mut var_response := rt.new_null()
	mut var_headers := rt.new_null()
	mut var_out_fp := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.4.0'), rt.new_string('WP_Http')])
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('set_time_limit')])) {
		rt.call_function('set_time_limit', [rt.new_int(60)])
	}
	if red > 5 {
		return false
	}
	var_options = []rt.PhpVal{}
	var_options['redirection'] = rt.new_int(5)
	if rt.is_true(rt.equal(rt.new_bool(false), rt.new_bool(file_path))) {
		var_options['method'] = rt.new_string('HEAD')
	} else {
		var_options['method'] = rt.new_string('GET')
	}
	var_response = rt.call_function('wp_safe_remote_request', [
		var_url.clone(), rt.create_array_from_native_map(var_options)])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		return false
	}
	var_headers = rt.call_function('wp_remote_retrieve_headers', [
		var_response.clone()])
	var_headers.array_set('response', rt.call_function('wp_remote_retrieve_response_code', [
		var_response.clone(),
	]))
	if rt.is_true(rt.equal(rt.new_string('HEAD'), var_options['method']))
		&& rt.is_true(rt.call_function('in_array', [var_headers.array_get(rt.new_string('response')), rt.create_array([rt.ArrayItem{
		key: none
		val: 301
	}, rt.ArrayItem{ key: none, val: 302 }])]))
		&& var_headers.array_isset(rt.new_string('location')) {
		return wp_get_http(var_headers.array_get(rt.new_string('location')), file_path,
			rt.pre_inc(rt.new_int(red)))
	}
	if rt.is_true(rt.equal(rt.new_bool(false), rt.new_bool(file_path))) {
		return var_headers.to_bool()
	}
	var_out_fp = rt.call_function('fopen', [rt.new_bool(file_path),
		rt.new_string('w')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_out_fp)))) {
		return var_headers.to_bool()
	}
	rt.call_function('fwrite', [var_out_fp.clone(),
		rt.call_function('wp_remote_retrieve_body', [var_response.clone()])])
	rt.call_function('fclose', [var_out_fp.clone()])
	rt.call_function('clearstatcache', []rt.PhpVal{})
	return var_headers.to_bool()
}

fn force_ssl_login(var_force rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.4.0'), rt.new_string('force_ssl_admin()')])
	return rt.call_function('force_ssl_admin', [var_force.clone()])
}

fn get_comments_popup_template() string {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.5.0')])
	return ''
}

fn is_comments_popup() bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.5.0')])
	return false
}

fn comments_popup_script() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.5.0')])
}

fn popuplinks(var_text_arg rt.PhpVal) rt.PhpVal {
	mut var_text := var_text_arg
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.5.0')])
	var_text = rt.call_function('preg_replace', [rt.new_string('/<a (.+?)>/i'),
		rt.new_string("<a $1 target='_blank' rel='external'>"),
		var_text.clone()])
	return var_text.clone()
}

fn wp_embed_handler_googlevideo(var_matches rt.PhpVal, var_attr rt.PhpVal, var_url rt.PhpVal, var_rawattr rt.PhpVal) string {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.6.0')])
	return ''
}

fn get_paged_template() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.7.0')])
	return rt.call_function('get_query_template', [rt.new_string('paged')])
}

fn wp_kses_js_entities(var_content rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.7.0')])
	return rt.call_function('preg_replace', [
		rt.new_string('%&\\s*\\{[^}]*(\\}\\s*;?|$)%'),
		rt.new_string(''),
		var_content.clone(),
	])
}

fn _usort_terms_by_id(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.7.0'), rt.new_string('wp_list_sort()')])
	if rt.is_true(rt.greater(rt.get_property(var_a, 'term_id'), rt.get_property(var_b, 'term_id'))) {
		return 1
	} else if rt.is_true(rt.less(rt.get_property(var_a, 'term_id'), rt.get_property(var_b,
		'term_id')))
	{
		return -1
	} else {
		return 0
	}
	return 0
}

fn _usort_terms_by_name(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.7.0'), rt.new_string('wp_list_sort()')])
	return rt.call_function('strcmp', [rt.get_property(var_a, 'name'),
		rt.get_property(var_b, 'name')])
}

fn _sort_nav_menu_items(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	mut var__menu_item_sort_prop := rt.new_null()
	mut var__a := rt.new_null()
	mut var__b := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.7.0'), rt.new_string('wp_list_sort()')])
	if !rt.is_true(var__menu_item_sort_prop) {
		return 0
	}
	if !(!(rt.get_property(var_a, '{"nodeType":"Expr_Variable","line":3920,"name":"_menu_item_sort_prop"}')).is_null())
		|| !(!(rt.get_property(var_b, '{"nodeType":"Expr_Variable","line":3920,"name":"_menu_item_sort_prop"}')).is_null()) {
		return 0
	}
	var__a = rt.new_int((rt.get_property(var_a,
		'{"nodeType":"Expr_Variable","line":3923,"name":"_menu_item_sort_prop"}')).to_i64())
	var__b = rt.new_int((rt.get_property(var_b,
		'{"nodeType":"Expr_Variable","line":3924,"name":"_menu_item_sort_prop"}')).to_i64())
	if rt.is_true(rt.equal(rt.get_property(var_a,
		'{"nodeType":"Expr_Variable","line":3926,"name":"_menu_item_sort_prop"}'), rt.get_property(var_b,
		'{"nodeType":"Expr_Variable","line":3926,"name":"_menu_item_sort_prop"}')))
	{
		return 0
	} else if
		rt.is_true(rt.equal(var__a, rt.get_property(var_a, '{"nodeType":"Expr_Variable","line":3928,"name":"_menu_item_sort_prop"}')))
		&& rt.is_true(rt.equal(var__b, rt.get_property(var_b, '{"nodeType":"Expr_Variable","line":3928,"name":"_menu_item_sort_prop"}'))) {
		return if rt.is_true(rt.less(var__a, var__b)) { -1 } else { 1 }
	} else {
		return (rt.call_function('strcmp', [
			rt.get_property(var_a,
				'{"nodeType":"Expr_Variable","line":3931,"name":"_menu_item_sort_prop"}'),
			rt.get_property(var_b,
				'{"nodeType":"Expr_Variable","line":3931,"name":"_menu_item_sort_prop"}'),
		])).to_i64()
	}
	return 0
}

fn get_shortcut_link() rt.PhpVal {
	mut var_link := ''
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.9.0')])
	var_link = ''
	return rt.call_function('apply_filters', [rt.new_string('shortcut_link'),
		rt.new_string(var_link.str()).clone()])
}

fn wp_ajax_press_this_save_post() {
	mut var_wp_press_this := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.9.0')])
	if rt.is_true(rt.call_function('is_plugin_active', [
		rt.new_string('press-this/press-this-plugin.php'),
	]))
	{
		rt.include_file(
			(rt.get_constant('WP_PLUGIN_DIR')).str() + '/press-this/class-wp-press-this-plugin.php',
			'1')
		var_wp_press_this = create_wp_press_this_plugin()
		var_wp_press_this.save_post()
	} else {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'errorMessage', val: rt.call_function('__', [
					rt.new_string('The Press This plugin is required.'),
				]) },
			]),
		])
	}
}

fn wp_ajax_press_this_add_category() {
	mut var_wp_press_this := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.9.0')])
	if rt.is_true(rt.call_function('is_plugin_active', [
		rt.new_string('press-this/press-this-plugin.php'),
	]))
	{
		rt.include_file(
			(rt.get_constant('WP_PLUGIN_DIR')).str() + '/press-this/class-wp-press-this-plugin.php',
			'1')
		var_wp_press_this = create_wp_press_this_plugin()
		var_wp_press_this.add_category()
	} else {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'errorMessage', val: rt.call_function('__', [
					rt.new_string('The Press This plugin is required.'),
				]) },
			]),
		])
	}
}

fn wp_get_user_request_data(var_request_id rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('5.4.0'), rt.new_string('wp_get_user_request()')])
	return rt.call_function('wp_get_user_request', [var_request_id.clone()])
}

fn wp_make_content_images_responsive(var_content rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('5.5.0'), rt.new_string('wp_filter_content_tags()')])
	return rt.call_function('wp_filter_content_tags', [var_content.clone()])
}

fn wp_unregister_globals() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('5.5.0')])
}

fn wp_blacklist_check(var_author rt.PhpVal, var_email rt.PhpVal, var_url rt.PhpVal, var_comment rt.PhpVal, var_user_ip rt.PhpVal, var_user_agent rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('5.5.0'), rt.new_string('wp_check_comment_disallowed_list()')])
	return rt.call_function('wp_check_comment_disallowed_list', [
		var_author.clone(), var_email.clone(), var_url.clone(),
		var_comment.clone(), var_user_ip.clone(), var_user_agent.clone()])
}

fn _wp_register_meta_args_whitelist(var_args rt.PhpVal, var_default_args rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('5.5.0'), rt.new_string('_wp_register_meta_args_allowed_list()')])
	return rt.call_function('_wp_register_meta_args_allowed_list', [
		var_args.clone(), var_default_args.clone()])
}

fn add_option_whitelist(var_new_options rt.PhpVal, options string) rt.PhpVal {
	mut var_options := options
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('5.5.0'), rt.new_string('add_allowed_options()')])
	return rt.call_function('add_allowed_options', [var_new_options.clone(),
		rt.new_string(options)])
}

fn remove_option_whitelist(var_del_options rt.PhpVal, options string) rt.PhpVal {
	mut var_options := options
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('5.5.0'), rt.new_string('remove_allowed_options()')])
	return rt.call_function('remove_allowed_options', [var_del_options.clone(),
		rt.new_string(options)])
}

fn wp_slash_strings_only(var_value rt.PhpVal) rt.PhpVal {
	return rt.call_function('map_deep',
		[var_value.clone(), rt.new_string('addslashes_strings_only')])
}

fn addslashes_strings_only(var_value rt.PhpVal) rt.PhpVal {
	return if var_value.clone().is_string() { rt.call_function('addslashes', [
			var_value.clone()]) } else { var_value }
}

fn noindex() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('5.7.0'), rt.new_string('wp_robots_noindex()')])
	if rt.is_true(rt.equal(rt.new_string('0'), rt.call_function('get_option', [
		rt.new_string('blog_public'),
	])))
	{
		wp_no_robots()
	}
}

fn wp_no_robots() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('5.7.0'), rt.new_string('wp_robots_no_robots()')])
	if rt.is_true(rt.call_function('get_option', [rt.new_string('blog_public')])) {
		print("<meta name='robots' content='noindex,follow' />\n")
		return
	}
	print("<meta name='robots' content='noindex,nofollow' />\n")
}

fn wp_sensitive_page_meta() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('5.7.0'), rt.new_string('wp_robots_sensitive_page()')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_strict_cross_origin_referrer', []rt.PhpVal{})
}

fn _excerpt_render_inner_columns_blocks(var_columns rt.PhpVal, var_allowed_blocks rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('5.8.0'), rt.new_string('_excerpt_render_inner_blocks()')])
	return rt.call_function('_excerpt_render_inner_blocks', [
		var_columns.clone(), var_allowed_blocks.clone()])
}

fn wp_render_duotone_filter_preset(var_preset rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('5.9.1'), rt.new_string('wp_get_duotone_filter_property()')])
	return wp_get_duotone_filter_property(var_preset.clone())
}

fn wp_skip_border_serialization(var_block_type rt.PhpVal) bool {
	mut var_border_support := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.0.0'), rt.new_string('wp_should_skip_block_supports_serialization()')])
	var_border_support = if !(rt.get_property(var_block_type, 'supports').array_get(rt.new_string('__experimentalBorder'))).is_null() {
		rt.get_property(var_block_type, 'supports').array_get(rt.new_string('__experimentalBorder'))
	} else {
		rt.new_bool(false)
	}
	return var_border_support.clone().is_array()
		&& rt.is_true(rt.new_bool(var_border_support.clone().array_isset(rt.new_string('__experimentalSkipSerialization'))))
		&& rt.is_true(var_border_support.array_get(rt.new_string('__experimentalSkipSerialization')))
}

fn wp_skip_dimensions_serialization(var_block_type rt.PhpVal) bool {
	mut var_dimensions_support := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.0.0'), rt.new_string('wp_should_skip_block_supports_serialization()')])
	var_dimensions_support = if !(rt.get_property(var_block_type, 'supports').array_get(rt.new_string('__experimentalDimensions'))).is_null() {
		rt.get_property(var_block_type, 'supports').array_get(rt.new_string('__experimentalDimensions'))
	} else {
		rt.new_bool(false)
	}
	return var_dimensions_support.clone().is_array()
		&& rt.is_true(rt.new_bool(var_dimensions_support.clone().array_isset(rt.new_string('__experimentalSkipSerialization'))))
		&& rt.is_true(var_dimensions_support.array_get(rt.new_string('__experimentalSkipSerialization')))
}

fn wp_skip_spacing_serialization(var_block_type rt.PhpVal) bool {
	mut var_spacing_support := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.0.0'), rt.new_string('wp_should_skip_block_supports_serialization()')])
	var_spacing_support = if !(rt.get_property(var_block_type, 'supports').array_get(rt.new_string('spacing'))).is_null() {
		rt.get_property(var_block_type, 'supports').array_get(rt.new_string('spacing'))
	} else {
		rt.new_bool(false)
	}
	return var_spacing_support.clone().is_array()
		&& rt.is_true(rt.new_bool(var_spacing_support.clone().array_isset(rt.new_string('__experimentalSkipSerialization'))))
		&& rt.is_true(var_spacing_support.array_get(rt.new_string('__experimentalSkipSerialization')))
}

fn wp_add_iframed_editor_assets_html() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.0.0')])
}

fn wp_get_attachment_thumb_file(post_id i64) bool {
	mut var_post_id := post_id
	mut var_post := rt.new_null()
	mut var_imagedata := rt.new_null()
	mut var_file := rt.new_null()
	mut var_thumbfile := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.1.0')])
	var_post_id = var_post_id
	var_post = rt.call_function('get_post', [rt.new_int(var_post_id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	var_imagedata = rt.call_function('wp_get_attachment_metadata', [
		rt.get_property(var_post, 'ID'),
	])
	if !(var_imagedata.clone().is_array()) {
		return false
	}
	var_file = rt.call_function('get_attached_file', [rt.get_property(var_post, 'ID')])
	if !(!rt.is_true(var_imagedata.array_get(rt.new_string('thumb')))) {
		var_thumbfile = rt.call_function('str_replace', [
			rt.call_function('wp_basename', [var_file.clone()]),
			var_imagedata.array_get(rt.new_string('thumb')),
			var_file.clone(),
		])
		if rt.is_true(rt.call_function('file_exists', [var_thumbfile.clone()])) {
			return (rt.call_function('apply_filters', [
				rt.new_string('wp_get_attachment_thumb_file'),
				var_thumbfile.clone(),
				rt.get_property(var_post, 'ID'),
			])).to_bool()
		}
	}
	return false
}

fn _get_path_to_translation(var_domain rt.PhpVal, reset bool) rt.PhpVal {
	mut var_reset := reset
	mut var_available_translations := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.1.0'), rt.new_string('WP_Textdomain_Registry')])
	if rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(reset))) {
		var_available_translations = []rt.PhpVal{}
	}
	if !(var_available_translations.array_isset(var_domain)) {
		var_available_translations.array_set(var_domain,
			_get_path_to_translation_from_lang_dir(var_domain.clone()))
	}
	return var_available_translations.array_get(var_domain)
}

fn _get_path_to_translation_from_lang_dir(var_domain rt.PhpVal) bool {
	mut var_cached_mofiles := rt.new_null()
	mut var_locations := []rt.PhpVal{}
	mut var_location := rt.new_null()
	mut var_mofiles := rt.new_null()
	mut var_locale := rt.new_null()
	mut var_mofile := ''
	mut var_path := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.1.0'), rt.new_string('WP_Textdomain_Registry')])
	if rt.is_true(rt.identical(rt.new_null(), var_cached_mofiles)) {
		var_cached_mofiles = []rt.PhpVal{}
		var_locations = [(rt.get_constant('WP_LANG_DIR')).str() + '/plugins', 
			(rt.get_constant('WP_LANG_DIR')).str() + '/themes']
		for var_location_shadow in var_locations {
			var_mofiles = rt.call_function('glob', [
				rt.new_string((rt.new_string(var_location_shadow.str())).str() + '/*.mo'),
			])
			if rt.is_true(var_mofiles) {
				var_cached_mofiles = rt.call_function('array_merge', [
					var_cached_mofiles.clone(), var_mofiles.clone()])
			}
		}
	}
	var_locale = rt.call_function('determine_locale', []rt.PhpVal{})
	var_mofile = '${var_domain.to_string()}-${var_locale.to_string()}.mo'
	var_path = rt.new_string((rt.get_constant('WP_LANG_DIR')).str() + '/plugins/' + var_mofile)
	if rt.is_true(rt.call_function('in_array', [var_path.clone(),
		var_cached_mofiles.clone(), rt.new_bool(true)]))
	{
		return var_path.to_bool()
	}
	var_path = rt.new_string((rt.get_constant('WP_LANG_DIR')).str() + '/themes/' + var_mofile)
	if rt.is_true(rt.call_function('in_array', [var_path.clone(),
		var_cached_mofiles.clone(), rt.new_bool(true)]))
	{
		return var_path.to_bool()
	}
	return false
}

fn _wp_multiple_block_styles(var_metadata rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.1.0')])
	return var_metadata.clone()
}

fn wp_typography_get_css_variable_inline_style(var_attributes rt.PhpVal, var_feature rt.PhpVal, var_css_property rt.PhpVal) rt.PhpVal {
	mut var_style_value := rt.new_null()
	mut var_index_to_splice := rt.new_null()
	mut var_slug := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.1.0'), rt.new_string('wp_style_engine_get_styles()')])
	var_style_value = rt.call_function('_wp_array_get', [var_attributes.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'style' },
			rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: var_feature }]),
		rt.new_bool(false)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_style_value)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
		var_style_value.clone(), rt.new_string('var:preset|${var_css_property.to_string()}|')])))))
	{
		return rt.call_function('sprintf', [rt.new_string('%s:%s;'),
			var_css_property.clone(), var_style_value.clone()])
	}
	var_index_to_splice = rt.add(rt.call_function('strrpos', [
		var_style_value.clone(), rt.new_string('|')]), rt.new_int(1))
	var_slug = rt.call_function('substr', [var_style_value.clone(),
		var_index_to_splice.clone()])
	return rt.call_function('sprintf', [rt.new_string('%s:var(--wp--preset--%s--%s);'),
		var_css_property.clone(), var_css_property.clone(), var_slug.clone()])
}

fn global_terms_enabled() bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.1.0')])
	return false
}

fn _filter_query_attachment_filenames(var_clauses rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.0.3'),
		rt.new_string('add_filter( "wp_allow_query_attachment_by_filename", "__return_true" )')])
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.new_string(@FN)])
	return var_clauses.clone()
}

fn get_page_by_title(var_page_title rt.PhpVal, var_output rt.PhpVal, post_type string) rt.PhpVal {
	mut var_post_type := post_type
	mut var_wpdb := rt.new_null()
	mut var_post_type_in_string := rt.new_null()
	mut var_sql := rt.new_null()
	mut var_page := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.2.0'), rt.new_string('WP_Query')])
	if rt.is_true(rt.new_bool(rt.new_string(var_post_type.str()).is_array())) {
		var_post_type = (rt.call_function('esc_sql', [
			rt.new_string(var_post_type.str()),
		])).str()
		var_post_type_in_string = rt.new_string("'" +
			(rt.call_function('implode', [rt.new_string("','"), rt.new_string(var_post_type.str())])).str() +
			"'")
		var_sql = rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT ID\n\t\t\tFROM '), rt.get_property(var_wpdb,
				'posts')), rt.new_string('\n\t\t\tWHERE post_title = %s\n\t\t\tAND post_type IN (')),
				var_post_type_in_string), rt.new_string(')')),
			var_page_title.clone(),
		])
	} else {
		var_sql = rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT ID\n\t\t\tFROM '), rt.get_property(var_wpdb,
				'posts')), rt.new_string('\n\t\t\tWHERE post_title = %s\n\t\t\tAND post_type = %s')),
			var_page_title.clone(),
			rt.new_string(var_post_type.str()),
		])
	}
	var_page = rt.call_method(var_wpdb, 'get_var', [var_sql.clone()])
	if rt.is_true(var_page) {
		return rt.call_function('get_post', [var_page.clone(),
			var_output.clone()])
	}
	return rt.new_null()
}

fn _resolve_home_block_template() rt.PhpVal {
	mut var_show_on_front := rt.new_null()
	mut var_front_page_id := rt.new_null()
	mut var_hierarchy := []rt.PhpVal{}
	mut var_template := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.2.0')])
	var_show_on_front = rt.call_function('get_option', [rt.new_string('show_on_front')])
	var_front_page_id = rt.call_function('get_option', [rt.new_string('page_on_front')])
	if rt.is_true(rt.identical(rt.new_string('page'), var_show_on_front))
		&& rt.is_true(var_front_page_id) {
		return rt.create_array([rt.ArrayItem{ key: 'postType', val: 'page' },
			rt.ArrayItem{ key: 'postId', val: var_front_page_id }])
	}
	var_hierarchy = ['front-page', 'home', 'index']
	var_template = rt.call_function('resolve_block_template', [
		rt.new_string('home'), rt.create_array_from_list(var_hierarchy),
		rt.new_string('')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template)))) {
		return rt.new_null()
	}
	return rt.create_array([rt.ArrayItem{ key: 'postType', val: 'wp_template' },
		rt.ArrayItem{ key: 'postId', val: rt.get_property(var_template, 'id') }])
}

fn wlwmanifest_link() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0')])
}

fn wp_queue_comments_for_comment_meta_lazyload(var_comments rt.PhpVal) {
	mut var_comment_ids := []rt.PhpVal{}
	mut var_comment := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0'), rt.new_string('wp_lazyload_comment_meta()')])
	var_comment_ids = []rt.PhpVal{}
	if rt.is_true(rt.new_bool(var_comments.clone().is_array())) {
		mut iter_13 := var_comments.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_comment_shadow := item_13.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_comment_shadow, 'WP_Comment'))) {
				var_comment_ids << rt.get_property(var_comment_shadow, 'comment_ID')
			}
		}
	}
	rt.call_function('wp_lazyload_comment_meta', [
		rt.create_array_from_list(var_comment_ids),
	])
}

fn wp_get_loading_attr_default(var_context rt.PhpVal) rt.PhpVal {
	mut var_wp_query := rt.new_null()
	mut var_header_area := rt.new_null()
	mut var_content_media_count := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0'), rt.new_string('wp_get_loading_optimization_attributes()')])
	if rt.is_true(rt.identical(rt.new_string('template'), var_context)) {
		return rt.new_bool(false)
	}
	var_header_area = rt.get_constant('WP_TEMPLATE_PART_AREA_HEADER')
	if rt.is_true(rt.identical(rt.new_string('template_part_${var_header_area.to_string()}'),
		var_context))
	{
		return rt.new_bool(false)
	}
	if rt.is_true(rt.identical(rt.new_string('the_post_thumbnail'), var_context))
		|| rt.is_true(rt.identical(rt.new_string('wp_get_attachment_image'), var_context)) {
		if rt.is_true(rt.call_function('doing_filter', [rt.new_string('the_content')])) {
			return rt.new_bool(false)
		}
		if rt.is_true(rt.get_property(var_wp_query, 'before_loop'))
			&& rt.is_true(rt.call_method(var_wp_query, 'is_main_query', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('did_action', [rt.new_string('get_header')]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('get_footer')]))))) {
			return rt.new_bool(false)
		}
	}
	if rt.is_true(rt.identical(rt.new_string('the_content'), var_context))
		|| rt.is_true(rt.identical(rt.new_string('the_post_thumbnail'), var_context)) {
		if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_the_loop', []rt.PhpVal{})))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_query', []rt.PhpVal{}))))) {
			return rt.new_string('lazy')
		}
		var_content_media_count = rt.call_function('wp_increase_content_media_count', []rt.PhpVal{})
		if rt.is_true(rt.less_equal(var_content_media_count, rt.call_function('wp_omit_loading_attr_threshold',
			[]rt.PhpVal{})))
		{
			return rt.new_bool(false)
		}
		return rt.new_string('lazy')
	}
	return rt.new_string('lazy')
}

fn wp_img_tag_add_loading_attr(var_image rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_value := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0'), rt.new_string('wp_img_tag_add_loading_optimization_attrs()')])
	var_value = wp_get_loading_attr_default(rt.create_array_from_native_map(var_context))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_image.clone(), rt.new_string(' src="')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_image.clone(), rt.new_string(' width="')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_image.clone(), rt.new_string(' height="')]))))) {
		return var_image.clone()
	}
	var_value = rt.call_function('apply_filters', [
		rt.new_string('wp_img_tag_add_loading_attr'),
		var_value.clone(),
		var_image.clone(),
		rt.create_array_from_native_map(var_context),
	])
	if rt.is_true(var_value) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_value.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'lazy' },
				rt.ArrayItem{ key: none, val: 'eager' }]),
			rt.new_bool(true)])))))
		{
			var_value = rt.new_string('lazy')
		}
		return rt.call_function('str_replace', [rt.new_string('<img'),
			rt.new_string('<img loading="' +
				(rt.call_function('esc_attr', [var_value.clone()])).str() + '"'),
			var_image.clone()])
	}
	return var_image.clone()
}

fn wp_tinycolor_bound01(var_n_arg rt.PhpVal, max i64) f64 {
	mut var_max := max
	mut var_n := var_n_arg
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0')])
	if rt.is_true(rt.identical(rt.new_string('string'), rt.call_function('gettype', [var_n.clone()])))
		&& rt.is_true(rt.call_function('str_contains', [var_n.clone(), rt.new_string('.')]))
		&& 1 == rt.new_float(var_n.to_f64()) {
		var_n = rt.new_string('100%')
	}
	var_n = rt.call_function('min', [rt.new_int(max),
		rt.call_function('max', [rt.new_int(0), rt.new_float(var_n.to_f64())])])
	if rt.is_true(rt.identical(rt.new_string('string'), rt.call_function('gettype', [var_n.clone()])))
		&& rt.is_true(rt.call_function('str_contains', [var_n.clone(), rt.new_string('%')])) {
		var_n = rt.new_int((rt.mul(var_n, rt.new_int(max))).to_i64()) / 100
	}
	if rt.is_true(rt.less(rt.call_function('abs', [rt.sub(var_n, rt.new_int(max))]),
		rt.new_float(1.0E-6)))
	{
		return 1
	}
	return var_n % max / f64(max)
}

fn _wp_tinycolor_bound_alpha(var_n_arg rt.PhpVal) i64 {
	mut var_n := var_n_arg
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0')])
	if rt.is_true(rt.new_bool(var_n.clone().is_long() || var_n.clone().is_double())) {
		var_n = rt.new_float(var_n.to_f64())
		if rt.is_true(rt.greater_equal(var_n, rt.new_int(0)))
			&& rt.is_true(rt.less_equal(var_n, rt.new_int(1))) {
			return var_n.to_i64()
		}
	}
	return 1
}

fn wp_tinycolor_rgb_to_rgb(var_rgb_color rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0')])
	return rt.create_array([
		rt.ArrayItem{ key: 'r', val: wp_tinycolor_bound01(var_rgb_color.array_get(rt.new_string('r')),
			255) * 255 },
		rt.ArrayItem{ key: 'g', val: wp_tinycolor_bound01(var_rgb_color.array_get(rt.new_string('g')),
			255) * 255 },
		rt.ArrayItem{ key: 'b', val: wp_tinycolor_bound01(var_rgb_color.array_get(rt.new_string('b')),
			255) * 255 },
	])
}

fn wp_tinycolor_hue_to_rgb(var_p rt.PhpVal, var_q rt.PhpVal, var_t rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0')])
	if rt.is_true(rt.less(var_t, rt.new_int(0))) {
		rt.pre_inc(var_t)
	}
	if rt.is_true(rt.greater(var_t, rt.new_int(1))) {
		rt.pre_dec(var_t)
	}
	if rt.is_true(rt.less(var_t, 1 / 6)) {
		return rt.add(var_p, rt.mul(rt.mul(rt.sub(var_q, var_p), rt.new_int(6)), var_t))
	}
	if rt.is_true(rt.less(var_t, 1 / 2)) {
		return var_q.clone()
	}
	if rt.is_true(rt.less(var_t, 2 / 3)) {
		return rt.add(var_p, rt.mul(rt.mul(rt.sub(var_q, var_p), rt.sub(2 / 3, var_t)),
			rt.new_int(6)))
	}
	return var_p.clone()
}

fn wp_tinycolor_hsl_to_rgb(var_hsl_color rt.PhpVal) rt.PhpVal {
	mut var_h := f64(0.0)
	mut var_s := f64(0.0)
	mut var_l := f64(0.0)
	mut var_r := rt.new_null()
	mut var_g := rt.new_null()
	mut var_b := rt.new_null()
	mut var_q := f64(0.0)
	mut var_p := f64(0.0)
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0')])
	var_h = wp_tinycolor_bound01(var_hsl_color.array_get(rt.new_string('h')), 360)
	var_s = wp_tinycolor_bound01(var_hsl_color.array_get(rt.new_string('s')), 100)
	var_l = wp_tinycolor_bound01(var_hsl_color.array_get(rt.new_string('l')), 100)
	if 0 == var_s {
		var_r = rt.new_float(var_l).clone()
		var_g = rt.new_float(var_l).clone()
		var_b = rt.new_float(var_l).clone()
	} else {
		var_q = if var_l < 0.5 { var_l * 1 + var_s } else { var_l + var_s - var_l * var_s }
		var_p = 2 * var_l - var_q
		var_r = wp_tinycolor_hue_to_rgb(rt.new_float(var_p).clone(), rt.new_float(var_q).clone(), rt.new_float(
			var_h + 1 / 3))
		var_g = wp_tinycolor_hue_to_rgb(rt.new_float(var_p).clone(), rt.new_float(var_q).clone(),
			rt.new_float(var_h).clone())
		var_b = wp_tinycolor_hue_to_rgb(rt.new_float(var_p).clone(), rt.new_float(var_q).clone(),
			rt.new_float(var_h - 1 / 3))
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'r', val: rt.mul(var_r, rt.new_int(255)) },
		rt.ArrayItem{ key: 'g', val: rt.mul(var_g, rt.new_int(255)) },
		rt.ArrayItem{ key: 'b', val: rt.mul(var_b, rt.new_int(255)) },
	])
}

fn wp_tinycolor_string_to_rgb(var_color_str_arg rt.PhpVal) rt.PhpVal {
	mut var_color_str := var_color_str_arg
	mut var_match := []rt.PhpVal{}
	mut var_css_integer := ''
	mut var_css_number := ''
	mut var_css_unit := rt.new_null()
	mut var_permissive_match3 := rt.new_null()
	mut var_permissive_match4 := rt.new_null()
	mut var_rgb_regexp := rt.new_null()
	mut var_rgb := rt.new_null()
	mut var_rgba_regexp := rt.new_null()
	mut var_hsl_regexp := rt.new_null()
	mut var_hsla_regexp := rt.new_null()
	mut var_hex8_regexp := ''
	mut var_hex6_regexp := ''
	mut var_hex4_regexp := ''
	mut var_hex3_regexp := ''
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0')])
	var_color_str = var_color_str.trim_space().to_lower()
	var_css_integer = '[-\\+]?\\d+%?'
	var_css_number = '[-\\+]?\\d*\\.\\d+%?'
	var_css_unit = rt.new_string('(?:' + var_css_number + ')|(?:' + var_css_integer + ')')
	var_permissive_match3 = rt.new_string('[\\s|\\(]+(' + var_css_unit.str() + ')[,|\\s]+(' +
		var_css_unit.str() + ')[,|\\s]+(' + var_css_unit.str() + ')\\s*\\)?')
	var_permissive_match4 = rt.new_string('[\\s|\\(]+(' + var_css_unit.str() + ')[,|\\s]+(' +
		var_css_unit.str() + ')[,|\\s]+(' + var_css_unit.str() + ')[,|\\s]+(' + var_css_unit.str() +
		')\\s*\\)?')
	var_rgb_regexp = rt.new_string('/^rgb' + var_permissive_match3.str() + '$/')
	if rt.is_true(rt.call_function('preg_match', [var_rgb_regexp.clone(),
		rt.new_string(var_color_str.str()).clone(), rt.create_array_from_list(var_match)]))
	{
		var_rgb = wp_tinycolor_rgb_to_rgb(rt.create_array([
			rt.ArrayItem{ key: 'r', val: var_match[1] },
			rt.ArrayItem{ key: 'g', val: var_match[2] },
			rt.ArrayItem{ key: 'b', val: var_match[3] },
		]))
		var_rgb.array_set('a', 1)
		return var_rgb.clone()
	}
	var_rgba_regexp = rt.new_string('/^rgba' + var_permissive_match4.str() + '$/')
	if rt.is_true(rt.call_function('preg_match', [var_rgba_regexp.clone(),
		rt.new_string(var_color_str.str()).clone(), rt.create_array_from_list(var_match)]))
	{
		var_rgb = wp_tinycolor_rgb_to_rgb(rt.create_array([
			rt.ArrayItem{ key: 'r', val: var_match[1] },
			rt.ArrayItem{ key: 'g', val: var_match[2] },
			rt.ArrayItem{ key: 'b', val: var_match[3] },
		]))
		var_rgb.array_set('a', _wp_tinycolor_bound_alpha(var_match[4]))
		return var_rgb.clone()
	}
	var_hsl_regexp = rt.new_string('/^hsl' + var_permissive_match3.str() + '$/')
	if rt.is_true(rt.call_function('preg_match', [var_hsl_regexp.clone(),
		rt.new_string(var_color_str.str()).clone(), rt.create_array_from_list(var_match)]))
	{
		var_rgb = wp_tinycolor_hsl_to_rgb(rt.create_array([
			rt.ArrayItem{ key: 'h', val: var_match[1] },
			rt.ArrayItem{ key: 's', val: var_match[2] },
			rt.ArrayItem{ key: 'l', val: var_match[3] },
		]))
		var_rgb.array_set('a', 1)
		return var_rgb.clone()
	}
	var_hsla_regexp = rt.new_string('/^hsla' + var_permissive_match4.str() + '$/')
	if rt.is_true(rt.call_function('preg_match', [var_hsla_regexp.clone(),
		rt.new_string(var_color_str.str()).clone(), rt.create_array_from_list(var_match)]))
	{
		var_rgb = wp_tinycolor_hsl_to_rgb(rt.create_array([
			rt.ArrayItem{ key: 'h', val: var_match[1] },
			rt.ArrayItem{ key: 's', val: var_match[2] },
			rt.ArrayItem{ key: 'l', val: var_match[3] },
		]))
		var_rgb.array_set('a', _wp_tinycolor_bound_alpha(var_match[4]))
		return var_rgb.clone()
	}
	var_hex8_regexp = '/^#?([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})$/'
	if rt.is_true(rt.call_function('preg_match', [rt.new_string(var_hex8_regexp.str()).clone(),
		rt.new_string(var_color_str.str()).clone(), rt.create_array_from_list(var_match)]))
	{
		var_rgb = wp_tinycolor_rgb_to_rgb(rt.create_array([
			rt.ArrayItem{ key: 'r', val: rt.call_function('base_convert', [var_match[1],
				rt.new_int(16), rt.new_int(10)]) },
			rt.ArrayItem{ key: 'g', val: rt.call_function('base_convert', [var_match[2],
				rt.new_int(16), rt.new_int(10)]) },
			rt.ArrayItem{ key: 'b', val: rt.call_function('base_convert', [var_match[3],
				rt.new_int(16), rt.new_int(10)]) },
		]))
		var_rgb.array_set('a', _wp_tinycolor_bound_alpha(rt.div(rt.call_function('base_convert', [
			var_match[4],
			rt.new_int(16),
			rt.new_int(10),
		]), rt.new_int(255))))
		return var_rgb.clone()
	}
	var_hex6_regexp = '/^#?([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})$/'
	if rt.is_true(rt.call_function('preg_match', [rt.new_string(var_hex6_regexp.str()).clone(),
		rt.new_string(var_color_str.str()).clone(), rt.create_array_from_list(var_match)]))
	{
		var_rgb = wp_tinycolor_rgb_to_rgb(rt.create_array([
			rt.ArrayItem{ key: 'r', val: rt.call_function('base_convert', [var_match[1],
				rt.new_int(16), rt.new_int(10)]) },
			rt.ArrayItem{ key: 'g', val: rt.call_function('base_convert', [var_match[2],
				rt.new_int(16), rt.new_int(10)]) },
			rt.ArrayItem{ key: 'b', val: rt.call_function('base_convert', [var_match[3],
				rt.new_int(16), rt.new_int(10)]) },
		]))
		var_rgb.array_set('a', 1)
		return var_rgb.clone()
	}
	var_hex4_regexp = '/^#?([0-9a-fA-F]{1})([0-9a-fA-F]{1})([0-9a-fA-F]{1})([0-9a-fA-F]{1})$/'
	if rt.is_true(rt.call_function('preg_match', [rt.new_string(var_hex4_regexp.str()).clone(),
		rt.new_string(var_color_str.str()).clone(), rt.create_array_from_list(var_match)]))
	{
		var_rgb = wp_tinycolor_rgb_to_rgb(rt.create_array([
			rt.ArrayItem{ key: 'r', val: rt.call_function('base_convert', [
				rt.new_string((var_match[1]).str() + (var_match[1]).str()),
				rt.new_int(16),
				rt.new_int(10),
			]) },
			rt.ArrayItem{ key: 'g', val: rt.call_function('base_convert', [
				rt.new_string((var_match[2]).str() + (var_match[2]).str()),
				rt.new_int(16),
				rt.new_int(10),
			]) },
			rt.ArrayItem{ key: 'b', val: rt.call_function('base_convert', [
				rt.new_string((var_match[3]).str() + (var_match[3]).str()),
				rt.new_int(16),
				rt.new_int(10),
			]) },
		]))
		var_rgb.array_set('a', _wp_tinycolor_bound_alpha(rt.div(rt.call_function('base_convert', [
			rt.new_string((var_match[4]).str() + (var_match[4]).str()),
			rt.new_int(16),
			rt.new_int(10),
		]), rt.new_int(255))))
		return var_rgb.clone()
	}
	var_hex3_regexp = '/^#?([0-9a-fA-F]{1})([0-9a-fA-F]{1})([0-9a-fA-F]{1})$/'
	if rt.is_true(rt.call_function('preg_match', [rt.new_string(var_hex3_regexp.str()).clone(),
		rt.new_string(var_color_str.str()).clone(), rt.create_array_from_list(var_match)]))
	{
		var_rgb = wp_tinycolor_rgb_to_rgb(rt.create_array([
			rt.ArrayItem{ key: 'r', val: rt.call_function('base_convert', [
				rt.new_string((var_match[1]).str() + (var_match[1]).str()),
				rt.new_int(16),
				rt.new_int(10),
			]) },
			rt.ArrayItem{ key: 'g', val: rt.call_function('base_convert', [
				rt.new_string((var_match[2]).str() + (var_match[2]).str()),
				rt.new_int(16),
				rt.new_int(10),
			]) },
			rt.ArrayItem{ key: 'b', val: rt.call_function('base_convert', [
				rt.new_string((var_match[3]).str() + (var_match[3]).str()),
				rt.new_int(16),
				rt.new_int(10),
			]) },
		]))
		var_rgb.array_set('a', 1)
		return var_rgb.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('transparent'), rt.new_string(var_color_str.str()))) {
		return rt.create_array([rt.ArrayItem{ key: 'r', val: 0 },
			rt.ArrayItem{ key: 'g', val: 0 }, rt.ArrayItem{ key: 'b', val: 0 },
			rt.ArrayItem{ key: 'a', val: 0 }])
	}
	return rt.new_null()
}

fn wp_get_duotone_filter_id(var_preset rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0')])
	mut iife_temp_0 := Class_WP_Duotone{}
	mut iife_result_0 := iife_temp_0.get_filter_id_from_preset(var_preset.clone())
	return iife_result_0
}

fn wp_get_duotone_filter_property(var_preset rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0')])
	mut iife_temp_1 := Class_WP_Duotone{}
	mut iife_result_1 := iife_temp_1.get_filter_css_property_value_from_preset(var_preset.clone())
	return iife_result_1
}

fn wp_get_duotone_filter_svg(var_preset rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0'), rt.new_string('WP_Duotone::get_filter_svg_from_preset()')])
	mut iife_temp_2 := Class_WP_Duotone{}
	mut iife_result_2 := iife_temp_2.get_filter_svg_from_preset(var_preset.clone())
	return iife_result_2
}

fn wp_register_duotone_support(var_block_type rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0'), rt.new_string('WP_Duotone::register_duotone_support()')])
	mut iife_temp_3 := Class_WP_Duotone{}
	mut iife_result_3 := iife_temp_3.register_duotone_support(var_block_type.clone())
	return iife_result_3
}

fn wp_render_duotone_support(var_block_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_wp_block := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0'), rt.new_string('WP_Duotone::render_duotone_support()')])
	var_wp_block = create_wp_block(var_block.clone())
	mut iife_temp_4 := Class_WP_Duotone{}
	mut iife_result_4 := iife_temp_4.render_duotone_support(var_block_content.clone(),
		var_block.clone(), rt.new_object('WP_Block', []string{}, var_wp_block))
	return iife_result_4
}

fn wp_get_global_styles_svg_filters() rt.PhpVal {
	mut var_can_use_cached := false
	mut var_cache_group := ''
	mut var_cache_key := ''
	mut var_cached := rt.new_null()
	mut var_supports_theme_json := rt.new_null()
	mut var_origins := []rt.PhpVal{}
	mut var_tree := rt.new_null()
	mut var_svgs := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0')])
	var_can_use_cached = !(rt.is_true(rt.call_function('wp_is_development_mode', [
		rt.new_string('theme'),
	])))
	var_cache_group = 'theme_json'
	var_cache_key = 'wp_get_global_styles_svg_filters'
	if var_can_use_cached {
		var_cached = rt.call_function('wp_cache_get', [rt.new_string(var_cache_key.str()).clone(),
			rt.new_string(var_cache_group.str()).clone()])
		if rt.is_true(var_cached) {
			return var_cached.clone()
		}
	}
	var_supports_theme_json = rt.call_function('wp_theme_has_theme_json', []rt.PhpVal{})
	var_origins = ['default', 'theme', 'custom']
	if rt.is_true(rt.new_bool(!(rt.is_true(var_supports_theme_json)))) {
		var_origins = ['default']
	}
	mut iife_temp_5 := Class_WP_Theme_JSON_Resolver{}
	mut iife_result_5 := iife_temp_5.get_merged_data()
	var_tree = iife_result_5
	var_svgs = rt.call_method(var_tree, 'get_svg_filters', [
		rt.create_array_from_list(var_origins),
	])
	if var_can_use_cached {
		rt.call_function('wp_cache_set', [rt.new_string(var_cache_key.str()).clone(),
			var_svgs.clone(), rt.new_string(var_cache_group.str()).clone()])
	}
	return var_svgs.clone()
}

fn wp_global_styles_render_svg_filters() {
	mut var_filters := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0')])
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'is_block_editor', []rt.PhpVal{}))))) {
		return
	}
	var_filters = wp_get_global_styles_svg_filters()
	if !(!rt.is_true(var_filters)) {
		rt.echo_val(var_filters)
	}
}

fn block_core_navigation_submenu_build_css_colors(var_context rt.PhpVal, var_attributes rt.PhpVal, is_sub_menu bool) rt.PhpVal {
	mut var_is_sub_menu := is_sub_menu
	mut var_colors := map[string]rt.PhpVal{}
	mut var_named_text_color := rt.new_null()
	mut var_custom_text_color := rt.new_null()
	mut var_named_background_color := rt.new_null()
	mut var_custom_background_color := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.3.0')])
	var_colors = {
		'css_classes':   []rt.PhpVal{}
		'inline_styles': rt.new_string('')
	}
	var_named_text_color = rt.new_null()
	var_custom_text_color = rt.new_null()
	if var_is_sub_menu
		&& rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_context).array_isset(rt.new_string('customOverlayTextColor')))) {
		var_custom_text_color = var_context.array_get(rt.new_string('customOverlayTextColor'))
	} else if var_is_sub_menu
		&& rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_context).array_isset(rt.new_string('overlayTextColor')))) {
		var_named_text_color = var_context.array_get(rt.new_string('overlayTextColor'))
	} else if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_context).array_isset(rt.new_string('customTextColor')))) {
		var_custom_text_color = var_context.array_get(rt.new_string('customTextColor'))
	} else if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_context).array_isset(rt.new_string('textColor')))) {
		var_named_text_color = var_context.array_get(rt.new_string('textColor'))
	} else if var_context.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_isset(rt.new_string('text')) {
		var_custom_text_color =
			var_context.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('text'))
	}
	if !(var_named_text_color.clone().is_null()) {
		var_colors['css_classes'].array_push(rt.new_string('has-text-color'))
	} else if !(var_custom_text_color.clone().is_null()) {
		var_colors.array_get_mut('css_classes').array_push('has-text-color')
		var_colors['inline_styles'] = rt.concat(var_colors['inline_styles'], rt.call_function('sprintf', [
			rt.new_string('color: %s;'),
			var_custom_text_color.clone(),
		]))
	}
	var_named_background_color = rt.new_null()
	var_custom_background_color = rt.new_null()
	if var_is_sub_menu
		&& rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_context).array_isset(rt.new_string('customOverlayBackgroundColor')))) {
		var_custom_background_color =
			var_context.array_get(rt.new_string('customOverlayBackgroundColor'))
	} else if var_is_sub_menu
		&& rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_context).array_isset(rt.new_string('overlayBackgroundColor')))) {
		var_named_background_color = var_context.array_get(rt.new_string('overlayBackgroundColor'))
	} else if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_context).array_isset(rt.new_string('customBackgroundColor')))) {
		var_custom_background_color = var_context.array_get(rt.new_string('customBackgroundColor'))
	} else if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_context).array_isset(rt.new_string('backgroundColor')))) {
		var_named_background_color = var_context.array_get(rt.new_string('backgroundColor'))
	} else if var_context.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_isset(rt.new_string('background')) {
		var_custom_background_color =
			var_context.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('background'))
	}
	if !(var_named_background_color.clone().is_null()) {
		var_colors['css_classes'].array_push(rt.new_string('has-background'))
	} else if !(var_custom_background_color.clone().is_null()) {
		var_colors.array_get_mut('css_classes').array_push('has-background')
		var_colors['inline_styles'] = rt.concat(var_colors['inline_styles'], rt.call_function('sprintf', [
			rt.new_string('background-color: %s;'),
			var_custom_background_color.clone(),
		]))
	}
	return var_colors.clone()
}

fn _wp_theme_json_webfonts_handler() {
	mut var_registered_webfonts := rt.new_null()
	mut var_fn_get_webfonts_from_theme_json := rt.new_null()
	mut var_fn_transform_src_into_uri := rt.new_null()
	mut var_fn_convert_keys_to_kebab_case := rt.new_null()
	mut var_fn_validate_webfont := rt.new_null()
	mut var_fn_register_webfonts := rt.new_null()
	mut var_fn_order_src := rt.new_null()
	mut var_fn_compile_src := rt.new_null()
	mut var_fn_compile_variations := rt.new_null()
	mut var_fn_build_font_face_css := rt.new_null()
	mut var_fn_get_css := rt.new_null()
	mut var_fn_generate_and_enqueue_styles := rt.new_null()
	mut var_fn_generate_and_enqueue_editor_styles := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.4.0'), rt.new_string('wp_print_font_faces')])
	if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_theme_has_theme_json',
		[]rt.PhpVal{})))))
	{
		return
	}
	var_registered_webfonts = []rt.PhpVal{}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut iife_temp_7 := Class_WP_Theme_JSON_Resolver{}
		mut iife_result_7 := iife_temp_7.get_merged_data()
		mut var_settings := rt.call_method(iife_result_7, 'get_settings', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
			|| rt.is_true(rt.call_function('wp_is_rest_endpoint', []rt.PhpVal{})) {
			mut iife_temp_8 := Class_WP_Theme_JSON_Resolver{}
			mut iife_result_8 := iife_temp_8.get_style_variations()
			mut var_variations := iife_result_8
			mut iter_14 := var_variations.iterator()
			for {
				item_14 := iter_14.next() or { break }
				mut var_variation := item_14.val
				if !rt.is_true(var_variation.array_get(rt.new_string('settings')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontFamilies'))) {
					continue
				}
				if !rt.is_true(var_settings.array_get(rt.new_string('typography'))) {
					var_settings.array_set('typography', []rt.PhpVal{})
				}
				if !rt.is_true(var_settings.array_get(rt.new_string('typography')).array_get(rt.new_string('fontFamilies'))) {
					var_settings.array_get_mut('typography').array_set('fontFamilies',
						[]rt.PhpVal{})
				}
				if !rt.is_true(var_settings.array_get(rt.new_string('typography')).array_get(rt.new_string('fontFamilies')).array_get(rt.new_string('theme'))) {
					var_settings.array_get_mut('typography').array_get_mut('fontFamilies').array_set('theme',
						[]rt.PhpVal{})
				}
				var_settings.array_get_mut('typography').array_get_mut('fontFamilies').array_set('theme', rt.call_function('array_merge', [
					var_settings.array_get(rt.new_string('typography')).array_get(rt.new_string('fontFamilies')).array_get(rt.new_string('theme')),
					var_variation.array_get(rt.new_string('settings')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontFamilies')).array_get(rt.new_string('theme')),
				]))
				var_settings.array_get_mut('typography').array_set('fontFamilies', rt.call_function('array_unique', [
					var_settings.array_get(rt.new_string('typography')).array_get(rt.new_string('fontFamilies')),
				]))
			}
		}
		if !rt.is_true(var_settings.array_get(rt.new_string('typography')).array_get(rt.new_string('fontFamilies'))) {
			return
		}
		mut var_webfonts := []rt.PhpVal{}
		mut iter_15 :=
			var_settings.array_get(rt.new_string('typography')).array_get(rt.new_string('fontFamilies')).iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_font_families := item_15.val
			mut iter_16 := var_font_families.iterator()
			for {
				item_16 := iter_16.next() or { break }
				mut var_font_family := item_16.val
				if !rt.is_true(var_font_family.array_get(rt.new_string('fontFace'))) {
					continue
				}
				if !(var_font_family.array_get(rt.new_string('fontFace')).is_array()) {
					continue
				}
				var_webfonts = rt.call_function('array_merge', [
					var_webfonts.clone(), var_font_family.array_get(rt.new_string('fontFace'))])
			}
		}
		return
	}
	var_fn_get_webfonts_from_theme_json = rt.new_closure(closure_9_fn)
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_src := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iter_17 := var_src.iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_url := item_17.val
			mut var_key := item_17.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [
				var_url.clone(),
				rt.new_string('file:./'),
			])))))
			{
				continue
			}
			var_src.array_set(var_key, rt.call_function('get_theme_file_uri', [
				rt.call_function('str_replace', [rt.new_string('file:./'),
					rt.new_string(''), var_url.clone()]),
			]))
		}
		return
	}
	var_fn_transform_src_into_uri = rt.new_closure(closure_10_fn)
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_font_face := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iter_18 := var_font_face.iterator()
		for {
			item_18 := iter_18.next() or { break }
			mut var_value := item_18.val
			mut var_property := item_18.key
			mut var_kebab_case := rt.call_function('_wp_to_kebab_case', [
				var_property.clone()])
			var_font_face.array_set(var_kebab_case, var_value.clone())
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_kebab_case, var_property)))) {
				var_font_face.array_unset(var_property)
			}
		}
		return
	}
	var_fn_convert_keys_to_kebab_case = rt.new_closure(closure_11_fn)
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_webfont := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_webfont = rt.call_function('wp_parse_args', [var_webfont.clone(),
			rt.create_array([rt.ArrayItem{ key: 'font-family', val: '' },
				rt.ArrayItem{ key: 'font-style', val: 'normal' },
				rt.ArrayItem{ key: 'font-weight', val: '400' },
				rt.ArrayItem{ key: 'font-display', val: 'fallback' },
				rt.ArrayItem{ key: 'src', val: []rt.PhpVal{} }])])
		if !rt.is_true(var_webfont.array_get(rt.new_string('font-family')))
			|| !(var_webfont.array_get(rt.new_string('font-family')).is_string()) {
			rt.call_function('trigger_error', [
				rt.call_function('__', [
					rt.new_string('Webfont font family must be a non-empty string.'),
				]),
			])
			return
		}
		if !rt.is_true(var_webfont.array_get(rt.new_string('src')))
			|| (!(var_webfont.array_get(rt.new_string('src')).is_string())
			&& !(var_webfont.array_get(rt.new_string('src')).is_array())) {
			rt.call_function('trigger_error', [
				rt.call_function('__', [
					rt.new_string('Webfont src must be a non-empty string or an array of strings.'),
				]),
			])
			return
		}
		mut iter_19 := rt.cast_array(var_webfont.array_get(rt.new_string('src'))).iterator()
		for {
			item_19 := iter_19.next() or { break }
			mut var_src := item_19.val
			if !(var_src.clone().is_string())
				|| rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_src.clone().to_string().trim_space()))) {
				rt.call_function('trigger_error', [
					rt.call_function('__', [
						rt.new_string('Each webfont src must be a non-empty string.'),
					]),
				])
				return
			}
		}
		if !(var_webfont.array_get(rt.new_string('font-weight')).is_string())
			&& !(var_webfont.array_get(rt.new_string('font-weight')).is_long()) {
			rt.call_function('trigger_error', [
				rt.call_function('__', [
					rt.new_string('Webfont font weight must be a properly formatted string or integer.'),
				]),
			])
			return
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_webfont.array_get(rt.new_string('font-display')),
			rt.create_array([rt.ArrayItem{ key: none, val: 'auto' },
				rt.ArrayItem{ key: none, val: 'block' }, rt.ArrayItem{ key: none, val: 'fallback' },
				rt.ArrayItem{ key: none, val: 'optional' }, rt.ArrayItem{ key: none, val: 'swap' }]),
			rt.new_bool(true),
		])))))
		{
			var_webfont.array_set('font-display', 'fallback')
		}
		mut var_valid_props := rt.create_array([
			rt.ArrayItem{ key: none, val: 'ascend-override' },
			rt.ArrayItem{ key: none, val: 'descend-override' },
			rt.ArrayItem{ key: none, val: 'font-display' },
			rt.ArrayItem{ key: none, val: 'font-family' },
			rt.ArrayItem{ key: none, val: 'font-stretch' },
			rt.ArrayItem{ key: none, val: 'font-style' },
			rt.ArrayItem{ key: none, val: 'font-weight' },
			rt.ArrayItem{ key: none, val: 'font-variant' },
			rt.ArrayItem{ key: none, val: 'font-feature-settings' },
			rt.ArrayItem{ key: none, val: 'font-variation-settings' },
			rt.ArrayItem{ key: none, val: 'line-gap-override' },
			rt.ArrayItem{ key: none, val: 'size-adjust' },
			rt.ArrayItem{ key: none, val: 'src' },
			rt.ArrayItem{ key: none, val: 'unicode-range' },
		])
		mut iter_20 := var_webfont.iterator()
		for {
			item_20 := iter_20.next() or { break }
			mut var_value := item_20.val
			mut var_prop := item_20.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
				var_prop.clone(),
				var_valid_props.clone(),
				rt.new_bool(true),
			])))))
			{
				var_webfont.array_unset(var_prop)
			}
		}
		return
	}
	var_fn_validate_webfont = rt.new_closure(closure_12_fn)
	closure_13_fn := fn [mut var_registered_webfonts, var_fn_get_webfonts_from_theme_json, var_fn_convert_keys_to_kebab_case, var_fn_validate_webfont, var_fn_transform_src_into_uri] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		var_registered_webfonts = []rt.PhpVal{}
		mut iter_21 :=
			rt.call_callable(var_fn_get_webfonts_from_theme_json, []rt.PhpVal{}).iterator()
		for {
			item_21 := iter_21.next() or { break }
			mut var_webfont := item_21.val
			if !(var_webfont.clone().is_array()) {
				continue
			}
			var_webfont = rt.call_callable(var_fn_convert_keys_to_kebab_case, [
				var_webfont.clone(),
			])
			var_webfont = rt.call_callable(var_fn_validate_webfont, [
				var_webfont.clone()])
			var_webfont.array_set('src', rt.call_callable(var_fn_transform_src_into_uri, [
				rt.cast_array(var_webfont.array_get(rt.new_string('src'))),
			]))
			if !rt.is_true(var_webfont) {
				continue
			}
			var_registered_webfonts.array_push(var_webfont.clone())
		}
		return rt.new_null()
	}
	var_fn_register_webfonts = rt.new_closure(closure_13_fn)
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_webfont := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_src := []rt.PhpVal{}
		mut var_src_ordered := []rt.PhpVal{}
		mut iter_22 := var_webfont.array_get(rt.new_string('src')).iterator()
		for {
			item_22 := iter_22.next() or { break }
			mut var_url := item_22.val
			if rt.is_true(rt.call_function('str_starts_with', [
				rt.new_string(var_url.clone().to_string().trim_space()),
				rt.new_string('data:'),
			]))
			{
				var_src_ordered.array_push(rt.create_array([
					rt.ArrayItem{ key: 'url', val: var_url },
					rt.ArrayItem{ key: 'format', val: 'data' },
				]))
				continue
			}
			mut var_format := rt.call_function('pathinfo', [var_url.clone(),
				rt.get_constant('PATHINFO_EXTENSION')])
			var_src.array_set(var_format, var_url.clone())
		}
		if !(!rt.is_true(var_src.array_get(rt.new_string('woff2')))) {
			var_src_ordered.array_push(rt.create_array([
				rt.ArrayItem{ key: 'url', val: rt.call_function('sanitize_url', [
					var_src.array_get(rt.new_string('woff2')),
				]) },
				rt.ArrayItem{ key: 'format', val: 'woff2' },
			]))
		}
		if !(!rt.is_true(var_src.array_get(rt.new_string('woff')))) {
			var_src_ordered.array_push(rt.create_array([
				rt.ArrayItem{ key: 'url', val: rt.call_function('sanitize_url', [
					var_src.array_get(rt.new_string('woff')),
				]) },
				rt.ArrayItem{ key: 'format', val: 'woff' },
			]))
		}
		if !(!rt.is_true(var_src.array_get(rt.new_string('ttf')))) {
			var_src_ordered.array_push(rt.create_array([
				rt.ArrayItem{ key: 'url', val: rt.call_function('sanitize_url', [
					var_src.array_get(rt.new_string('ttf')),
				]) },
				rt.ArrayItem{ key: 'format', val: 'truetype' },
			]))
		}
		if !(!rt.is_true(var_src.array_get(rt.new_string('eot')))) {
			var_src_ordered.array_push(rt.create_array([
				rt.ArrayItem{ key: 'url', val: rt.call_function('sanitize_url', [
					var_src.array_get(rt.new_string('eot')),
				]) },
				rt.ArrayItem{ key: 'format', val: 'embedded-opentype' },
			]))
		}
		if !(!rt.is_true(var_src.array_get(rt.new_string('otf')))) {
			var_src_ordered.array_push(rt.create_array([
				rt.ArrayItem{ key: 'url', val: rt.call_function('sanitize_url', [
					var_src.array_get(rt.new_string('otf')),
				]) },
				rt.ArrayItem{ key: 'format', val: 'opentype' },
			]))
		}
		var_webfont.array_set('src', var_src_ordered.clone())
		return
	}
	var_fn_order_src = rt.new_closure(closure_14_fn)
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_font_family := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_value := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_src := rt.new_string('')
		mut iter_23 := var_value.iterator()
		for {
			item_23 := iter_23.next() or { break }
			mut var_item := item_23.val
			var_src = rt.concat(var_src, if rt.is_true(rt.identical(rt.new_string('data'),
				var_item.array_get(rt.new_string('format'))))
			{
				rt.concat(rt.concat(rt.new_string(', url('),
					var_item.array_get(rt.new_string('url'))), rt.new_string(')'))
			} else {
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(", url('"),
					var_item.array_get(rt.new_string('url'))), rt.new_string("') format('")),
					var_item.array_get(rt.new_string('format'))), rt.new_string("')"))
			})
		}
		var_src = rt.new_string(var_src.clone().to_string().trim_left(' \t\n\r'))
		return
	}
	var_fn_compile_src = rt.new_closure(closure_15_fn)
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_font_variation_settings := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_variations := rt.new_string('')
		mut iter_24 := var_font_variation_settings.iterator()
		for {
			item_24 := iter_24.next() or { break }
			mut var_value := item_24.val
			mut var_key := item_24.key
			var_variations = rt.concat(var_variations,
				rt.new_string('${var_key.to_string()} ${var_value.to_string()}'))
		}
		return
	}
	var_fn_compile_variations = rt.new_closure(closure_16_fn)
	closure_17_fn := fn [var_fn_compile_src, var_fn_compile_variations] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_webfont := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_css := rt.new_string('')
		if rt.is_true(rt.call_function('str_contains', [var_webfont.array_get(rt.new_string('font-family')), rt.new_string(' ')]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_webfont.array_get(rt.new_string('font-family')), rt.new_string('"')])))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_webfont.array_get(rt.new_string('font-family')), rt.new_string("'")]))))) {
			var_webfont.array_set('font-family', '"' +
				(var_webfont.array_get(rt.new_string('font-family'))).str() + '"')
		}
		mut iter_25 := var_webfont.iterator()
		for {
			item_25 := iter_25.next() or { break }
			mut var_value := item_25.val
			mut var_key := item_25.key
			if rt.is_true(rt.identical(rt.new_string('provider'), var_key)) {
				continue
			}
			if rt.is_true(rt.identical(rt.new_string('src'), var_key)) {
				var_value = rt.call_callable(var_fn_compile_src, [
					var_webfont.array_get(rt.new_string('font-family')),
					var_value.clone(),
				])
			}
			if rt.is_true(rt.identical(rt.new_string('font-variation-settings'), var_key))
				&& var_value.clone().is_array() {
				var_value = rt.call_callable(var_fn_compile_variations, [
					var_value.clone()])
			}
			if !(!rt.is_true(var_value)) {
				var_css = rt.concat(var_css,
					rt.new_string('${var_key.to_string()}:${var_value.to_string()};'))
			}
		}
		return
	}
	var_fn_build_font_face_css = rt.new_closure(closure_17_fn)
	closure_18_fn := fn [mut var_registered_webfonts, var_fn_order_src, var_fn_build_font_face_css] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_css := rt.new_string('')
		mut iter_26 := var_registered_webfonts.iterator()
		for {
			item_26 := iter_26.next() or { break }
			mut var_webfont := item_26.val
			var_webfont = rt.call_callable(var_fn_order_src, [
				var_webfont.clone()])
			var_css = rt.concat(var_css, rt.new_string('@font-face{' +
				(rt.call_callable(var_fn_build_font_face_css, [var_webfont.clone()])).str() + '}'))
		}
		return
	}
	var_fn_get_css = rt.new_closure(closure_18_fn)
	closure_19_fn := fn [var_fn_get_css] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_styles := rt.call_callable(var_fn_get_css, []rt.PhpVal{})
		if rt.is_true(rt.identical(rt.new_string(''), var_styles)) {
			return
		}
		rt.call_function('wp_register_style', [rt.new_string('wp-webfonts'),
			rt.new_string('')])
		rt.call_function('wp_enqueue_style', [rt.new_string('wp-webfonts')])
		rt.call_function('wp_add_inline_style', [rt.new_string('wp-webfonts'),
			var_styles.clone()])
		return rt.new_null()
	}
	var_fn_generate_and_enqueue_styles = rt.new_closure(closure_19_fn)
	closure_20_fn := fn [var_fn_get_css] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_styles := rt.call_callable(var_fn_get_css, []rt.PhpVal{})
		if rt.is_true(rt.identical(rt.new_string(''), var_styles)) {
			return
		}
		rt.call_function('wp_add_inline_style', [rt.new_string('wp-block-library'),
			var_styles.clone()])
		return rt.new_null()
	}
	var_fn_generate_and_enqueue_editor_styles = rt.new_closure(closure_20_fn)
	rt.call_function('add_action', [rt.new_string('wp_loaded'),
		var_fn_register_webfonts.clone()])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		var_fn_generate_and_enqueue_styles.clone()])
	rt.call_function('add_action', [rt.new_string('admin_init'),
		var_fn_generate_and_enqueue_editor_styles.clone()])
}

fn print_embed_styles() {
	mut var_suffix := ''
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.4.0'), rt.new_string('wp_enqueue_embed_styles')])
	var_suffix = if rt.is_true(rt.get_constant('SCRIPT_DEBUG')) { '' } else { '.min' }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('file_get_contents', [
		rt.new_string(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/css/wp-embed-template${var_suffix}.css'),
	]))
	// unsupported statement: Stmt_InlineHTML
}

fn print_emoji_styles() {
	mut var_printed := false
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.4.0'), rt.new_string('wp_enqueue_emoji_styles')])
	if var_printed {
		return
	}
	var_printed = true
	// unsupported statement: Stmt_InlineHTML
}

fn wp_admin_bar_header() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.4.0'), rt.new_string('wp_enqueue_admin_bar_header_styles')])
	// unsupported statement: Stmt_InlineHTML
}

fn _admin_bar_bump_cb() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.4.0'), rt.new_string('wp_enqueue_admin_bar_bump_styles')])
	// unsupported statement: Stmt_InlineHTML
}

fn wp_update_https_detection_errors() {
	mut var_support_errors := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.4.0')])
	var_support_errors = rt.call_function('apply_filters', [
		rt.new_string('pre_wp_update_https_detection_errors'),
		rt.new_null(),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_support_errors.clone()])) {
		rt.call_function('update_option', [rt.new_string('https_detection_errors'),
			rt.get_property(var_support_errors, 'errors'), rt.new_bool(false)])
		return
	}
	var_support_errors = rt.call_function('wp_get_https_detection_errors', []rt.PhpVal{})
	rt.call_function('update_option', [rt.new_string('https_detection_errors'),
		var_support_errors.clone()])
}

fn wp_img_tag_add_decoding_attr(var_image_arg rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_image := var_image_arg
	mut var_value := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.4.0'), rt.new_string('wp_img_tag_add_loading_optimization_attrs()')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
		var_image.clone(), rt.new_string(' src="')])))))
	{
		return var_image.clone()
	}
	var_value = rt.call_function('apply_filters', [
		rt.new_string('wp_img_tag_add_decoding_attr'),
		rt.new_string('async'),
		var_image.clone(),
		rt.create_array_from_native_map(var_context),
	])
	if rt.is_true(rt.call_function('in_array', [var_value.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'async' },
			rt.ArrayItem{ key: none, val: 'sync' }, rt.ArrayItem{ key: none, val: 'auto' }]),
		rt.new_bool(true)]))
	{
		var_image = rt.call_function('str_replace', [rt.new_string('<img '),
			rt.new_string('<img decoding="' +
				(rt.call_function('esc_attr', [var_value.clone()])).str() + '" '),
			var_image.clone()])
	}
	return var_image.clone()
}

fn _inject_theme_attribute_in_block_template_content(var_template_content rt.PhpVal) string {
	mut var_has_updated_content := false
	mut var_new_content := ''
	mut var_template_blocks := rt.new_null()
	mut var_blocks := rt.new_null()
	mut var_block := map[string]rt.PhpVal{}
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.4.0'),
		rt.new_string('traverse_and_serialize_blocks( parse_blocks( $template_content ), "_inject_theme_attribute_in_template_part_block" )')])
	var_has_updated_content = false
	var_new_content = ''
	var_template_blocks = rt.call_function('parse_blocks', [var_template_content.clone()])
	var_blocks = rt.call_function('_flatten_blocks', [var_template_blocks.clone()])
	mut iter_27 := var_blocks.iterator()
	for {
		item_27 := iter_27.next() or { break }
		mut var_block_shadow := item_27.val
		if rt.is_true(rt.identical(rt.new_string('core/template-part'), var_block_shadow['blockName']))
			&& !(var_block_shadow['attrs'].array_isset(rt.new_string('theme'))) {
			var_block_shadow.array_get_mut('attrs').array_set('theme', rt.call_function('get_stylesheet',
				[]rt.PhpVal{}))
			var_has_updated_content = true
		}
	}
	if var_has_updated_content {
		mut iter_28 := var_template_blocks.iterator()
		for {
			item_28 := iter_28.next() or { break }
			mut var_block_shadow := item_28.val
			var_new_content = var_new_content +
				(rt.call_function('serialize_block', [var_block_shadow.clone()])).str()
		}
		return var_new_content
	}
	return var_template_content.str()
}

fn _remove_theme_attribute_in_block_template_content(var_template_content rt.PhpVal) string {
	mut var_has_updated_content := false
	mut var_new_content := ''
	mut var_template_blocks := rt.new_null()
	mut var_blocks := rt.new_null()
	mut var_block := map[string]rt.PhpVal{}
	mut var_key := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.4.0'),
		rt.new_string('traverse_and_serialize_blocks( parse_blocks( $template_content ), "_remove_theme_attribute_from_template_part_block" )')])
	var_has_updated_content = false
	var_new_content = ''
	var_template_blocks = rt.call_function('parse_blocks', [var_template_content.clone()])
	var_blocks = rt.call_function('_flatten_blocks', [var_template_blocks.clone()])
	mut iter_29 := var_blocks.iterator()
	for {
		item_29 := iter_29.next() or { break }
		mut var_block_shadow := item_29.val
		mut var_key_shadow := item_29.key
		if rt.is_true(rt.identical(rt.new_string('core/template-part'), var_block_shadow['blockName']))
			&& var_block_shadow['attrs'].array_isset(rt.new_string('theme')) {
			var_blocks.array_get(var_key_shadow).array_get(rt.new_string('attrs')).array_unset(rt.new_string('theme'))
			var_has_updated_content = true
		}
	}
	if !var_has_updated_content {
		return var_template_content.str()
	}
	mut iter_30 := var_template_blocks.iterator()
	for {
		item_30 := iter_30.next() or { break }
		mut var_block_shadow := item_30.val
		var_new_content = var_new_content +
			(rt.call_function('serialize_block', [var_block_shadow.clone()])).str()
	}
	return var_new_content
}

fn the_block_template_skip_link() {
	mut var__wp_current_template_content := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.4.0'), rt.new_string('wp_enqueue_block_template_skip_link()')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('block-templates'),
	])))))
	{
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var__wp_current_template_content)))) {
		return
	}
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Skip to content')])
	// unsupported statement: Stmt_InlineHTML
}

fn block_core_query_ensure_interactivity_dependency() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.5.0'), rt.new_string('wp_register_script_module')])
}

fn block_core_file_ensure_interactivity_dependency() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.5.0'), rt.new_string('wp_register_script_module')])
}

fn block_core_image_ensure_interactivity_dependency() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.5.0'), rt.new_string('wp_register_script_module')])
}

fn wp_render_elements_support(var_block_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.6.0'), rt.new_string('wp_render_elements_class_name')])
	return var_block_content.clone()
}

fn wp_interactivity_process_directives_of_interactive_blocks(var_parsed_block rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.6.0')])
	return var_parsed_block.clone()
}

fn wp_get_global_styles_custom_css() string {
	mut var_can_use_cached := false
	mut var_cache_key := ''
	mut var_cache_group := ''
	mut var_cached := rt.new_null()
	mut var_tree := rt.new_null()
	mut var_stylesheet := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.7.0'), rt.new_string('wp_get_global_stylesheet')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_theme_has_theme_json',
		[]rt.PhpVal{})))))
	{
		return ''
	}
	var_can_use_cached = !(rt.is_true(rt.call_function('wp_is_development_mode', [
		rt.new_string('theme'),
	])))
	var_cache_key = 'wp_get_global_styles_custom_css'
	var_cache_group = 'theme_json'
	if var_can_use_cached {
		var_cached = rt.call_function('wp_cache_get', [rt.new_string(var_cache_key.str()).clone(),
			rt.new_string(var_cache_group.str()).clone()])
		if rt.is_true(var_cached) {
			return var_cached.str()
		}
	}
	mut iife_temp_20 := Class_WP_Theme_JSON_Resolver{}
	mut iife_result_20 := iife_temp_20.get_merged_data()
	var_tree = iife_result_20
	var_stylesheet = rt.call_method(var_tree, 'get_custom_css', []rt.PhpVal{})
	if var_can_use_cached {
		rt.call_function('wp_cache_set', [rt.new_string(var_cache_key.str()).clone(),
			var_stylesheet.clone(), rt.new_string(var_cache_group.str()).clone()])
	}
	return var_stylesheet.str()
}

fn wp_enqueue_global_styles_custom_css() {
	mut var_custom_css := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.7.0'), rt.new_string('wp_enqueue_global_styles')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) {
		return
	}
	rt.call_function('remove_action', [rt.new_string('wp_head'),
		rt.new_string('wp_custom_css_cb'), rt.new_int(101)])
	var_custom_css = rt.call_function('wp_get_custom_css', []rt.PhpVal{})
	var_custom_css = rt.concat(var_custom_css, rt.new_string(wp_get_global_styles_custom_css()))
	if !(!rt.is_true(var_custom_css)) {
		rt.call_function('wp_add_inline_style', [rt.new_string('global-styles'),
			var_custom_css.clone()])
	}
}

fn wp_create_block_style_variation_instance_name(var_block rt.PhpVal, var_variation rt.PhpVal) string {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.7.0'), rt.new_string('wp_unique_id')])
	return var_variation.str() + '--' +
		md5.hexhash(rt.call_function('serialize', [rt.create_array_from_native_map(var_block)]).to_string())
}

fn current_user_can_for_blog(var_blog_id rt.PhpVal, var_capability rt.PhpVal, var_args_origin ...rt.PhpVal) rt.PhpVal {
	mut var_args := rt.create_array_from_list(var_args_origin)
	return rt.call_function('current_user_can_for_site', [var_blog_id.clone(),
		var_capability.clone(), var_args.clone()])
}

fn wp_add_editor_classic_theme_styles(var_editor_settings rt.PhpVal) rt.PhpVal {
	mut var_suffix := rt.new_null()
	mut var_classic_theme_styles := rt.new_null()
	mut var_classic_theme_styles_settings := map[string]rt.PhpVal{}
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.8.0'), rt.new_string('wp_enqueue_classic_theme_styles')])
	if rt.is_true(rt.call_function('wp_theme_has_theme_json', []rt.PhpVal{})) {
		return var_editor_settings.clone()
	}
	var_suffix = rt.call_function('wp_scripts_get_suffix', []rt.PhpVal{})
	var_classic_theme_styles = rt.new_string(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/css/classic-themes${var_suffix.to_string()}.css')
	var_classic_theme_styles_settings = {
		'css':            rt.call_function('file_get_contents', [
			var_classic_theme_styles.clone()])
		'__unstableType': rt.new_string('core')
		'isGlobalStyles': rt.new_bool(false)
	}
	rt.call_function('array_unshift', [var_editor_settings.array_get(rt.new_string('styles')),
		rt.create_array_from_native_map(var_classic_theme_styles_settings)])
	return var_editor_settings.clone()
}

fn wp_print_auto_sizes_contain_css_fix() {
	mut var_add_auto_sizes := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.9.0'), rt.new_string('wp_enqueue_img_auto_sizes_contain_css_fix')])
	var_add_auto_sizes = rt.call_function('apply_filters', [
		rt.new_string('wp_img_tag_add_auto_sizes'),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_add_auto_sizes)))) {
		return
	}
	// unsupported statement: Stmt_InlineHTML
}

fn addslashes_gpc(var_gpc rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('7.0.0'), rt.new_string('wp_slash()')])
	return rt.call_function('wp_slash', [var_gpc.clone()])
}

fn wp_sanitize_script_attributes(var_attributes rt.PhpVal) string {
	mut var_attributes_string := ''
	mut var_attribute_value := rt.new_null()
	mut var_attribute_name := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('7.0.0'), rt.new_string('wp_get_script_tag() or wp_get_inline_script_tag()')])
	var_attributes_string = ''
	mut iter_31 := var_attributes.iterator()
	for {
		item_31 := iter_31.next() or { break }
		mut var_attribute_value_shadow := item_31.val
		mut var_attribute_name_shadow := item_31.key
		if rt.is_true(rt.new_bool(var_attribute_value_shadow.clone().is_bool())) {
			if rt.is_true(var_attribute_value_shadow) {
				var_attributes_string = var_attributes_string + ' ' +
					(rt.call_function('esc_attr', [var_attribute_name_shadow.clone()])).str()
			}
		} else {
			var_attributes_string = var_attributes_string +(rt.call_function('sprintf', [rt.new_string(' %1$s="%2$s"'), rt.call_function('esc_attr', [var_attribute_name_shadow.clone()]), rt.call_function('esc_attr', [var_attribute_value_shadow.clone()])])).str()
		}
	}
	return var_attributes_string
}

struct Class_WP_Theme {
	rt.PhpObjectBase
}

struct Class_WP_Press_This_Plugin {
	rt.PhpObjectBase
}

struct Class_WP_Duotone {
	rt.PhpObjectBase
}

struct Class_WP_Block {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON_Resolver {
	rt.PhpObjectBase
}

fn create_wp_theme(_args ...rt.PhpVal) &Class_WP_Theme {
	mut obj := &Class_WP_Theme{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_press_this_plugin(_args ...rt.PhpVal) &Class_WP_Press_This_Plugin {
	mut obj := &Class_WP_Press_This_Plugin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_duotone(_args ...rt.PhpVal) &Class_WP_Duotone {
	mut obj := &Class_WP_Duotone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block(_args ...rt.PhpVal) &Class_WP_Block {
	mut obj := &Class_WP_Block{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme_json_resolver(_args ...rt.PhpVal) &Class_WP_Theme_JSON_Resolver {
	mut obj := &Class_WP_Theme_JSON_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Theme) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Press_This_Plugin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Press_This_Plugin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Press_This_Plugin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Duotone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Duotone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Duotone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_func('get_postdata', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return get_postdata(arg_0)
	})
	rt.register_func('start_wp', fn (args []rt.PhpVal) rt.PhpVal {
		return start_wp()
	})
	rt.register_func('the_category_ID', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		return the_category_id(arg_0)
	})
	rt.register_func('the_category_head', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return the_category_head(arg_0, arg_1)
	})
	rt.register_func('previous_post', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
		return previous_post(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
	})
	rt.register_func('next_post', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
		return next_post(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
	})
	rt.register_func('user_can_create_post', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return user_can_create_post(arg_0, arg_1, arg_2)
	})
	rt.register_func('user_can_create_draft', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return user_can_create_draft(arg_0, arg_1, arg_2)
	})
	rt.register_func('user_can_edit_post', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return rt.new_bool(user_can_edit_post(arg_0, arg_1, arg_2))
	})
	rt.register_func('user_can_delete_post', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return rt.new_bool(user_can_delete_post(arg_0, arg_1, arg_2))
	})
	rt.register_func('user_can_set_post_date', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return rt.new_bool(user_can_set_post_date(arg_0, arg_1, arg_2))
	})
	rt.register_func('user_can_edit_post_date', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return rt.new_bool(user_can_edit_post_date(arg_0, arg_1, arg_2))
	})
	rt.register_func('user_can_edit_post_comments', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return rt.new_bool(user_can_edit_post_comments(arg_0, arg_1, arg_2))
	})
	rt.register_func('user_can_delete_post_comments', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return rt.new_bool(user_can_delete_post_comments(arg_0, arg_1, arg_2))
	})
	rt.register_func('user_can_edit_user', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(user_can_edit_user(arg_0, arg_1))
	})
	rt.register_func('get_linksbyname', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
		arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_bool()
		arg_7 := (if args.len > 7 { args[7] } else { rt.new_null() }).to_bool()
		arg_8 := if args.len > 8 { args[8] } else { rt.new_null() }
		arg_9 := (if args.len > 9 { args[9] } else { rt.new_null() }).to_i64()
		return get_linksbyname(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7, arg_8, arg_9)
	})
	rt.register_func('wp_get_linksbyname', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return wp_get_linksbyname(arg_0, arg_1)
	})
	rt.register_func('get_linkobjectsbyname', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return get_linkobjectsbyname(arg_0, arg_1, arg_2)
	})
	rt.register_func('get_linkobjects', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return get_linkobjects(arg_0, arg_1, arg_2)
	})
	rt.register_func('get_linksbyname_withrating', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
		arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_bool()
		arg_7 := if args.len > 7 { args[7] } else { rt.new_null() }
		arg_8 := (if args.len > 8 { args[8] } else { rt.new_null() }).to_i64()
		return get_linksbyname_withrating(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7,
			arg_8)
	})
	rt.register_func('get_links_withrating', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
		arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_bool()
		arg_7 := if args.len > 7 { args[7] } else { rt.new_null() }
		arg_8 := (if args.len > 8 { args[8] } else { rt.new_null() }).to_i64()
		return get_links_withrating(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7, arg_8)
	})
	rt.register_func('get_autotoggle', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		return rt.new_int(get_autotoggle(arg_0))
	})
	rt.register_func('list_cats', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_bool()
		arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_i64()
		arg_7 := (if args.len > 7 { args[7] } else { rt.new_null() }).to_i64()
		arg_8 := (if args.len > 8 { args[8] } else { rt.new_null() }).to_i64()
		arg_9 := (if args.len > 9 { args[9] } else { rt.new_null() }).to_i64()
		arg_10 := (if args.len > 10 { args[10] } else { rt.new_null() }).to_bool()
		arg_11 := (if args.len > 11 { args[11] } else { rt.new_null() }).to_i64()
		arg_12 := (if args.len > 12 { args[12] } else { rt.new_null() }).to_i64()
		arg_13 := (if args.len > 13 { args[13] } else { rt.new_null() }).to_i64()
		arg_14 := (if args.len > 14 { args[14] } else { rt.new_null() }).str()
		arg_15 := (if args.len > 15 { args[15] } else { rt.new_null() }).str()
		arg_16 := (if args.len > 16 { args[16] } else { rt.new_null() }).str()
		arg_17 := (if args.len > 17 { args[17] } else { rt.new_null() }).to_bool()
		return list_cats(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7, arg_8, arg_9,
			arg_10, arg_11, arg_12, arg_13, arg_14, arg_15, arg_16, arg_17)
	})
	rt.register_func('wp_list_cats', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return wp_list_cats(arg_0)
	})
	rt.register_func('dropdown_cats', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_i64()
		arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_i64()
		arg_7 := (if args.len > 7 { args[7] } else { rt.new_null() }).to_bool()
		arg_8 := (if args.len > 8 { args[8] } else { rt.new_null() }).to_i64()
		arg_9 := (if args.len > 9 { args[9] } else { rt.new_null() }).to_i64()
		return dropdown_cats(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7, arg_8, arg_9)
	})
	rt.register_func('list_authors', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
		return list_authors(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
	})
	rt.register_func('wp_get_post_cats', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		return wp_get_post_cats(arg_0, arg_1)
	})
	rt.register_func('wp_set_post_cats', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return wp_set_post_cats(arg_0, arg_1, arg_2)
	})
	rt.register_func('get_archives', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_bool()
		return get_archives(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
	})
	rt.register_func('get_author_link', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return get_author_link(arg_0, arg_1, arg_2)
	})
	rt.register_func('link_pages', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
		arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).str()
		return link_pages(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6)
	})
	rt.register_func('get_settings', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return get_settings(arg_0)
	})
	rt.register_func('permalink_link', fn (args []rt.PhpVal) rt.PhpVal {
		return permalink_link()
	})
	rt.register_func('permalink_single_rss', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return permalink_single_rss(arg_0)
	})
	rt.register_func('wp_get_links', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return wp_get_links(arg_0)
	})
	rt.register_func('get_links', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
		arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_bool()
		arg_7 := (if args.len > 7 { args[7] } else { rt.new_null() }).to_bool()
		arg_8 := if args.len > 8 { args[8] } else { rt.new_null() }
		arg_9 := (if args.len > 9 { args[9] } else { rt.new_null() }).to_i64()
		arg_10 := (if args.len > 10 { args[10] } else { rt.new_null() }).to_bool()
		return rt.new_string(get_links(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7,
			arg_8, arg_9, arg_10))
	})
	rt.register_func('get_links_list', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return get_links_list(arg_0)
	})
	rt.register_func('links_popup_script', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
		return links_popup_script(arg_0, arg_1, arg_2, arg_3, arg_4)
	})
	rt.register_func('get_linkrating', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return get_linkrating(arg_0)
	})
	rt.register_func('get_linkcatname', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		return rt.new_string(get_linkcatname(arg_0))
	})
	rt.register_func('comments_rss_link', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return comments_rss_link(arg_0)
	})
	rt.register_func('get_category_rss_link', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		return get_category_rss_link(arg_0, arg_1)
	})
	rt.register_func('get_author_rss_link', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		return get_author_rss_link(arg_0, arg_1)
	})
	rt.register_func('comments_rss', fn (args []rt.PhpVal) rt.PhpVal {
		return comments_rss()
	})
	rt.register_func('create_user', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return create_user(arg_0, arg_1, arg_2)
	})
	rt.register_func('gzip_compression', fn (args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(gzip_compression())
	})
	rt.register_func('get_commentdata', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return get_commentdata(arg_0, arg_1, arg_2)
	})
	rt.register_func('get_catname', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return get_catname(arg_0)
	})
	rt.register_func('get_category_children', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return rt.new_string(get_category_children(arg_0, arg_1, arg_2, arg_3))
	})
	rt.register_func('get_all_category_ids', fn (args []rt.PhpVal) rt.PhpVal {
		return get_all_category_ids()
	})
	rt.register_func('get_the_author_description', fn (args []rt.PhpVal) rt.PhpVal {
		return get_the_author_description()
	})
	rt.register_func('the_author_description', fn (args []rt.PhpVal) rt.PhpVal {
		return the_author_description()
	})
	rt.register_func('get_the_author_login', fn (args []rt.PhpVal) rt.PhpVal {
		return get_the_author_login()
	})
	rt.register_func('the_author_login', fn (args []rt.PhpVal) rt.PhpVal {
		return the_author_login()
	})
	rt.register_func('get_the_author_firstname', fn (args []rt.PhpVal) rt.PhpVal {
		return get_the_author_firstname()
	})
	rt.register_func('the_author_firstname', fn (args []rt.PhpVal) rt.PhpVal {
		return the_author_firstname()
	})
	rt.register_func('get_the_author_lastname', fn (args []rt.PhpVal) rt.PhpVal {
		return get_the_author_lastname()
	})
	rt.register_func('the_author_lastname', fn (args []rt.PhpVal) rt.PhpVal {
		return the_author_lastname()
	})
	rt.register_func('get_the_author_nickname', fn (args []rt.PhpVal) rt.PhpVal {
		return get_the_author_nickname()
	})
	rt.register_func('the_author_nickname', fn (args []rt.PhpVal) rt.PhpVal {
		return the_author_nickname()
	})
	rt.register_func('get_the_author_email', fn (args []rt.PhpVal) rt.PhpVal {
		return get_the_author_email()
	})
	rt.register_func('the_author_email', fn (args []rt.PhpVal) rt.PhpVal {
		return the_author_email()
	})
	rt.register_func('get_the_author_icq', fn (args []rt.PhpVal) rt.PhpVal {
		return get_the_author_icq()
	})
	rt.register_func('the_author_icq', fn (args []rt.PhpVal) rt.PhpVal {
		return the_author_icq()
	})
	rt.register_func('get_the_author_yim', fn (args []rt.PhpVal) rt.PhpVal {
		return get_the_author_yim()
	})
	rt.register_func('the_author_yim', fn (args []rt.PhpVal) rt.PhpVal {
		return the_author_yim()
	})
	rt.register_func('get_the_author_msn', fn (args []rt.PhpVal) rt.PhpVal {
		return get_the_author_msn()
	})
	rt.register_func('the_author_msn', fn (args []rt.PhpVal) rt.PhpVal {
		return the_author_msn()
	})
	rt.register_func('get_the_author_aim', fn (args []rt.PhpVal) rt.PhpVal {
		return get_the_author_aim()
	})
	rt.register_func('the_author_aim', fn (args []rt.PhpVal) rt.PhpVal {
		return the_author_aim()
	})
	rt.register_func('get_author_name', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		return get_author_name(arg_0)
	})
	rt.register_func('get_the_author_url', fn (args []rt.PhpVal) rt.PhpVal {
		return get_the_author_url()
	})
	rt.register_func('the_author_url', fn (args []rt.PhpVal) rt.PhpVal {
		return the_author_url()
	})
	rt.register_func('get_the_author_ID', fn (args []rt.PhpVal) rt.PhpVal {
		return get_the_author_id()
	})
	rt.register_func('the_author_ID', fn (args []rt.PhpVal) rt.PhpVal {
		return the_author_id()
	})
	rt.register_func('the_content_rss', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
		return the_content_rss(arg_0, arg_1, arg_2, arg_3, arg_4)
	})
	rt.register_func('make_url_footnote', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return make_url_footnote(arg_0)
	})
	rt.register_func('_c', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return _c(arg_0, arg_1)
	})
	rt.register_func('translate_with_context', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return translate_with_context(arg_0, arg_1)
	})
	rt.register_func('_nc', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		return _nc(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('__ngettext', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return __ngettext(arg_0)
	})
	rt.register_func('__ngettext_noop', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return __ngettext_noop(arg_0)
	})
	rt.register_func('get_alloptions', fn (args []rt.PhpVal) rt.PhpVal {
		return get_alloptions()
	})
	rt.register_func('get_the_attachment_link', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		return rt.new_string(get_the_attachment_link(arg_0, arg_1, arg_2, arg_3))
	})
	rt.register_func('get_attachment_icon_src', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return get_attachment_icon_src(arg_0, arg_1)
	})
	rt.register_func('get_attachment_icon', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return rt.new_bool(get_attachment_icon(arg_0, arg_1, arg_2))
	})
	rt.register_func('get_attachment_innerHTML', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return rt.new_bool(get_attachment_innerhtml(arg_0, arg_1, arg_2))
	})
	rt.register_func('get_link', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return get_link(arg_0, arg_1, arg_2)
	})
	rt.register_func('clean_url', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return clean_url(arg_0, arg_1, arg_2)
	})
	rt.register_func('js_escape', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return js_escape(arg_0)
	})
	rt.register_func('wp_specialchars', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		return wp_specialchars(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('attribute_escape', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return attribute_escape(arg_0)
	})
	rt.register_func('register_sidebar_widget', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return register_sidebar_widget(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('unregister_sidebar_widget', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return unregister_sidebar_widget(arg_0)
	})
	rt.register_func('register_widget_control', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
		return register_widget_control(arg_0, arg_1, arg_2, arg_3, arg_4)
	})
	rt.register_func('unregister_widget_control', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return unregister_widget_control(arg_0)
	})
	rt.register_func('delete_usermeta', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return rt.new_bool(delete_usermeta(arg_0, arg_1, arg_2))
	})
	rt.register_func('get_usermeta', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return get_usermeta(arg_0, arg_1)
	})
	rt.register_func('update_usermeta', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(update_usermeta(arg_0, arg_1, arg_2))
	})
	rt.register_func('get_users_of_blog', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return get_users_of_blog(arg_0)
	})
	rt.register_func('automatic_feed_links', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		return automatic_feed_links(arg_0)
	})
	rt.register_func('get_profile', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return get_profile(arg_0, arg_1)
	})
	rt.register_func('get_usernumposts', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return get_usernumposts(arg_0)
	})
	rt.register_func('funky_javascript_callback', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(funky_javascript_callback(arg_0))
	})
	rt.register_func('funky_javascript_fix', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return funky_javascript_fix(arg_0)
	})
	rt.register_func('is_taxonomy', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return is_taxonomy(arg_0)
	})
	rt.register_func('is_term', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return is_term(arg_0, arg_1, arg_2)
	})
	rt.register_func('is_plugin_page', fn (args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(is_plugin_page())
	})
	rt.register_func('update_category_cache', fn (args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(update_category_cache())
	})
	rt.register_func('wp_timezone_supported', fn (args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(wp_timezone_supported())
	})
	rt.register_func('the_editor', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_bool()
		return the_editor(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
	})
	rt.register_func('get_user_metavalues', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return get_user_metavalues(arg_0)
	})
	rt.register_func('sanitize_user_object', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return sanitize_user_object(arg_0, arg_1)
	})
	rt.register_func('get_boundary_post_rel_link', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		return get_boundary_post_rel_link(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('start_post_rel_link', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return start_post_rel_link(arg_0, arg_1, arg_2)
	})
	rt.register_func('get_index_rel_link', fn (args []rt.PhpVal) rt.PhpVal {
		return get_index_rel_link()
	})
	rt.register_func('index_rel_link', fn (args []rt.PhpVal) rt.PhpVal {
		return index_rel_link()
	})
	rt.register_func('get_parent_post_rel_link', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return get_parent_post_rel_link(arg_0)
	})
	rt.register_func('parent_post_rel_link', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return parent_post_rel_link(arg_0)
	})
	rt.register_func('wp_admin_bar_dashboard_view_site_menu', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_admin_bar_dashboard_view_site_menu(arg_0)
	})
	rt.register_func('is_blog_user', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		return is_blog_user(arg_0)
	})
	rt.register_func('debug_fopen', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(debug_fopen(arg_0, arg_1))
	})
	rt.register_func('debug_fwrite', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return debug_fwrite(arg_0, arg_1)
	})
	rt.register_func('debug_fclose', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return debug_fclose(arg_0)
	})
	rt.register_func('get_themes', fn (args []rt.PhpVal) rt.PhpVal {
		return get_themes()
	})
	rt.register_func('get_theme', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return get_theme(arg_0)
	})
	rt.register_func('get_current_theme', fn (args []rt.PhpVal) rt.PhpVal {
		return get_current_theme()
	})
	rt.register_func('clean_pre', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return clean_pre(arg_0)
	})
	rt.register_func('add_custom_image_header', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return add_custom_image_header(arg_0, arg_1, arg_2)
	})
	rt.register_func('remove_custom_image_header', fn (args []rt.PhpVal) rt.PhpVal {
		return remove_custom_image_header()
	})
	rt.register_func('add_custom_background', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return add_custom_background(arg_0, arg_1, arg_2)
	})
	rt.register_func('remove_custom_background', fn (args []rt.PhpVal) rt.PhpVal {
		return remove_custom_background()
	})
	rt.register_func('get_theme_data', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return get_theme_data(arg_0)
	})
	rt.register_func('update_page_cache', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return update_page_cache(arg_0)
	})
	rt.register_func('clean_page_cache', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return clean_page_cache(arg_0)
	})
	rt.register_func('wp_explain_nonce', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_explain_nonce(arg_0)
	})
	rt.register_func('sticky_class', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return sticky_class(arg_0)
	})
	rt.register_func('_get_post_ancestors', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return _get_post_ancestors(arg_0)
	})
	rt.register_func('wp_load_image', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_load_image(arg_0)
	})
	rt.register_func('image_resize', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
		arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
		arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_i64()
		return image_resize(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6)
	})
	rt.register_func('wp_get_single_post', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_get_single_post(arg_0, arg_1)
	})
	rt.register_func('user_pass_ok', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(user_pass_ok(arg_0, arg_1))
	})
	rt.register_func('_save_post_hook', fn (args []rt.PhpVal) rt.PhpVal {
		return _save_post_hook()
	})
	rt.register_func('gd_edit_image_support', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(gd_edit_image_support(arg_0))
	})
	rt.register_func('wp_convert_bytes_to_hr', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(wp_convert_bytes_to_hr(arg_0))
	})
	rt.register_func('_search_terms_tidy', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(_search_terms_tidy(arg_0))
	})
	rt.register_func('rich_edit_exists', fn (args []rt.PhpVal) rt.PhpVal {
		return rich_edit_exists()
	})
	rt.register_func('default_topic_count_text', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return default_topic_count_text(arg_0)
	})
	rt.register_func('format_to_post', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return format_to_post(arg_0)
	})
	rt.register_func('like_escape', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return like_escape(arg_0)
	})
	rt.register_func('url_is_accessable_via_ssl', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(url_is_accessable_via_ssl(arg_0))
	})
	rt.register_func('preview_theme', fn (args []rt.PhpVal) rt.PhpVal {
		return preview_theme()
	})
	rt.register_func('_preview_theme_template_filter', fn (args []rt.PhpVal) rt.PhpVal {
		return rt.new_string(_preview_theme_template_filter())
	})
	rt.register_func('_preview_theme_stylesheet_filter', fn (args []rt.PhpVal) rt.PhpVal {
		return rt.new_string(_preview_theme_stylesheet_filter())
	})
	rt.register_func('preview_theme_ob_filter', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return preview_theme_ob_filter(arg_0)
	})
	rt.register_func('preview_theme_ob_filter_callback', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(preview_theme_ob_filter_callback(arg_0))
	})
	rt.register_func('wp_richedit_pre', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_richedit_pre(arg_0)
	})
	rt.register_func('wp_htmledit_pre', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_htmledit_pre(arg_0)
	})
	rt.register_func('post_permalink', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		return post_permalink(arg_0)
	})
	rt.register_func('wp_get_http', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return rt.new_bool(wp_get_http(arg_0, arg_1, arg_2))
	})
	rt.register_func('force_ssl_login', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return force_ssl_login(arg_0)
	})
	rt.register_func('get_comments_popup_template', fn (args []rt.PhpVal) rt.PhpVal {
		return rt.new_string(get_comments_popup_template())
	})
	rt.register_func('is_comments_popup', fn (args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(is_comments_popup())
	})
	rt.register_func('comments_popup_script', fn (args []rt.PhpVal) rt.PhpVal {
		return comments_popup_script()
	})
	rt.register_func('popuplinks', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return popuplinks(arg_0)
	})
	rt.register_func('wp_embed_handler_googlevideo', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return rt.new_string(wp_embed_handler_googlevideo(arg_0, arg_1, arg_2, arg_3))
	})
	rt.register_func('get_paged_template', fn (args []rt.PhpVal) rt.PhpVal {
		return get_paged_template()
	})
	rt.register_func('wp_kses_js_entities', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_kses_js_entities(arg_0)
	})
	rt.register_func('_usort_terms_by_ID', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_int(_usort_terms_by_id(arg_0, arg_1))
	})
	rt.register_func('_usort_terms_by_name', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return _usort_terms_by_name(arg_0, arg_1)
	})
	rt.register_func('_sort_nav_menu_items', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_int(_sort_nav_menu_items(arg_0, arg_1))
	})
	rt.register_func('get_shortcut_link', fn (args []rt.PhpVal) rt.PhpVal {
		return get_shortcut_link()
	})
	rt.register_func('wp_ajax_press_this_save_post', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_press_this_save_post()
	})
	rt.register_func('wp_ajax_press_this_add_category', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_press_this_add_category()
	})
	rt.register_func('wp_get_user_request_data', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_get_user_request_data(arg_0)
	})
	rt.register_func('wp_make_content_images_responsive', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_make_content_images_responsive(arg_0)
	})
	rt.register_func('wp_unregister_GLOBALS', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_unregister_globals()
	})
	rt.register_func('wp_blacklist_check', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
		arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
		return wp_blacklist_check(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
	})
	rt.register_func('_wp_register_meta_args_whitelist', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return _wp_register_meta_args_whitelist(arg_0, arg_1)
	})
	rt.register_func('add_option_whitelist', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return add_option_whitelist(arg_0, arg_1)
	})
	rt.register_func('remove_option_whitelist', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return remove_option_whitelist(arg_0, arg_1)
	})
	rt.register_func('wp_slash_strings_only', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_slash_strings_only(arg_0)
	})
	rt.register_func('addslashes_strings_only', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return addslashes_strings_only(arg_0)
	})
	rt.register_func('noindex', fn (args []rt.PhpVal) rt.PhpVal {
		return noindex()
	})
	rt.register_func('wp_no_robots', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_no_robots()
	})
	rt.register_func('wp_sensitive_page_meta', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_sensitive_page_meta()
	})
	rt.register_func('_excerpt_render_inner_columns_blocks', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return _excerpt_render_inner_columns_blocks(arg_0, arg_1)
	})
	rt.register_func('wp_render_duotone_filter_preset', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_render_duotone_filter_preset(arg_0)
	})
	rt.register_func('wp_skip_border_serialization', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wp_skip_border_serialization(arg_0))
	})
	rt.register_func('wp_skip_dimensions_serialization', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wp_skip_dimensions_serialization(arg_0))
	})
	rt.register_func('wp_skip_spacing_serialization', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wp_skip_spacing_serialization(arg_0))
	})
	rt.register_func('wp_add_iframed_editor_assets_html', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_add_iframed_editor_assets_html()
	})
	rt.register_func('wp_get_attachment_thumb_file', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		return rt.new_bool(wp_get_attachment_thumb_file(arg_0))
	})
	rt.register_func('_get_path_to_translation', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return _get_path_to_translation(arg_0, arg_1)
	})
	rt.register_func('_get_path_to_translation_from_lang_dir', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(_get_path_to_translation_from_lang_dir(arg_0))
	})
	rt.register_func('_wp_multiple_block_styles', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return _wp_multiple_block_styles(arg_0)
	})
	rt.register_func('wp_typography_get_css_variable_inline_style', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return wp_typography_get_css_variable_inline_style(arg_0, arg_1, arg_2)
	})
	rt.register_func('global_terms_enabled', fn (args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(global_terms_enabled())
	})
	rt.register_func('_filter_query_attachment_filenames', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return _filter_query_attachment_filenames(arg_0)
	})
	rt.register_func('get_page_by_title', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return get_page_by_title(arg_0, arg_1, arg_2)
	})
	rt.register_func('_resolve_home_block_template', fn (args []rt.PhpVal) rt.PhpVal {
		return _resolve_home_block_template()
	})
	rt.register_func('wlwmanifest_link', fn (args []rt.PhpVal) rt.PhpVal {
		return wlwmanifest_link()
	})
	rt.register_func('wp_queue_comments_for_comment_meta_lazyload', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_queue_comments_for_comment_meta_lazyload(arg_0)
	})
	rt.register_func('wp_get_loading_attr_default', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_get_loading_attr_default(arg_0)
	})
	rt.register_func('wp_img_tag_add_loading_attr', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_img_tag_add_loading_attr(arg_0, arg_1)
	})
	rt.register_func('wp_tinycolor_bound01', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		return rt.new_float(wp_tinycolor_bound01(arg_0, arg_1))
	})
	rt.register_func('_wp_tinycolor_bound_alpha', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_int(_wp_tinycolor_bound_alpha(arg_0))
	})
	rt.register_func('wp_tinycolor_rgb_to_rgb', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_tinycolor_rgb_to_rgb(arg_0)
	})
	rt.register_func('wp_tinycolor_hue_to_rgb', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return wp_tinycolor_hue_to_rgb(arg_0, arg_1, arg_2)
	})
	rt.register_func('wp_tinycolor_hsl_to_rgb', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_tinycolor_hsl_to_rgb(arg_0)
	})
	rt.register_func('wp_tinycolor_string_to_rgb', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_tinycolor_string_to_rgb(arg_0)
	})
	rt.register_func('wp_get_duotone_filter_id', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_get_duotone_filter_id(arg_0)
	})
	rt.register_func('wp_get_duotone_filter_property', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_get_duotone_filter_property(arg_0)
	})
	rt.register_func('wp_get_duotone_filter_svg', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_get_duotone_filter_svg(arg_0)
	})
	rt.register_func('wp_register_duotone_support', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_register_duotone_support(arg_0)
	})
	rt.register_func('wp_render_duotone_support', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_render_duotone_support(arg_0, arg_1)
	})
	rt.register_func('wp_get_global_styles_svg_filters', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_get_global_styles_svg_filters()
	})
	rt.register_func('wp_global_styles_render_svg_filters', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_global_styles_render_svg_filters()
	})
	rt.register_func('block_core_navigation_submenu_build_css_colors', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return block_core_navigation_submenu_build_css_colors(arg_0, arg_1, arg_2)
	})
	rt.register_func('_wp_theme_json_webfonts_handler', fn (args []rt.PhpVal) rt.PhpVal {
		return _wp_theme_json_webfonts_handler()
	})
	rt.register_func('print_embed_styles', fn (args []rt.PhpVal) rt.PhpVal {
		return print_embed_styles()
	})
	rt.register_func('print_emoji_styles', fn (args []rt.PhpVal) rt.PhpVal {
		return print_emoji_styles()
	})
	rt.register_func('wp_admin_bar_header', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_admin_bar_header()
	})
	rt.register_func('_admin_bar_bump_cb', fn (args []rt.PhpVal) rt.PhpVal {
		return _admin_bar_bump_cb()
	})
	rt.register_func('wp_update_https_detection_errors', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_update_https_detection_errors()
	})
	rt.register_func('wp_img_tag_add_decoding_attr', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_img_tag_add_decoding_attr(arg_0, arg_1)
	})
	rt.register_func('_inject_theme_attribute_in_block_template_content', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(_inject_theme_attribute_in_block_template_content(arg_0))
	})
	rt.register_func('_remove_theme_attribute_in_block_template_content', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(_remove_theme_attribute_in_block_template_content(arg_0))
	})
	rt.register_func('the_block_template_skip_link', fn (args []rt.PhpVal) rt.PhpVal {
		return the_block_template_skip_link()
	})
	rt.register_func('block_core_query_ensure_interactivity_dependency', fn (args []rt.PhpVal) rt.PhpVal {
		return block_core_query_ensure_interactivity_dependency()
	})
	rt.register_func('block_core_file_ensure_interactivity_dependency', fn (args []rt.PhpVal) rt.PhpVal {
		return block_core_file_ensure_interactivity_dependency()
	})
	rt.register_func('block_core_image_ensure_interactivity_dependency', fn (args []rt.PhpVal) rt.PhpVal {
		return block_core_image_ensure_interactivity_dependency()
	})
	rt.register_func('wp_render_elements_support', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_render_elements_support(arg_0, arg_1)
	})
	rt.register_func('wp_interactivity_process_directives_of_interactive_blocks', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_interactivity_process_directives_of_interactive_blocks(arg_0)
	})
	rt.register_func('wp_get_global_styles_custom_css', fn (args []rt.PhpVal) rt.PhpVal {
		return rt.new_string(wp_get_global_styles_custom_css())
	})
	rt.register_func('wp_enqueue_global_styles_custom_css', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_enqueue_global_styles_custom_css()
	})
	rt.register_func('wp_create_block_style_variation_instance_name', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_string(wp_create_block_style_variation_instance_name(arg_0, arg_1))
	})
	rt.register_func('current_user_can_for_blog', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return current_user_can_for_blog(arg_0, arg_1, arg_2)
	})
	rt.register_func('wp_add_editor_classic_theme_styles', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_add_editor_classic_theme_styles(arg_0)
	})
	rt.register_func('wp_print_auto_sizes_contain_css_fix', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_print_auto_sizes_contain_css_fix()
	})
	rt.register_func('addslashes_gpc', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return addslashes_gpc(arg_0)
	})
	rt.register_func('wp_sanitize_script_attributes', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(wp_sanitize_script_attributes(arg_0))
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
