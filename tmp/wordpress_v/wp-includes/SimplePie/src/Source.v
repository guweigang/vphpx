import rt
import crypto.md5

struct Class_SimplePie_Source {
	rt.PhpObjectBase
pub mut:
		item rt.PhpVal = rt.new_null()
		data rt.PhpVal = rt.new_array()
		registry rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Source) construct(mut var_item Class_SimplePie_Item, mut var_data Class_SimplePie_array)  {
	this.item = var_item.dup()
	this.data = var_data.dup()
}

fn (mut this Class_SimplePie_Source) set_registry(mut var_registry Class_SimplePie_SimplePie_Registry)  {
	this.registry = var_registry.dup()
}

fn (mut this Class_SimplePie_Source) magic_tostring() string {
	return md5.hexhash(rt.call_function('serialize', [this.data]).to_string())
}

fn (mut this Class_SimplePie_Source) get_source_tags(namespace string, tag string) rt.PhpVal {
	if this.data.array_get('child').array_get(namespace).array_isset(rt.new_string(tag)) {
		return this.data.array_get('child').array_get(namespace).array_get(tag)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_base(mut var_element Class_SimplePie_array) rt.PhpVal {
	return rt.call_method(this.item, 'get_base', [var_element])
}

fn (mut this Class_SimplePie_Source) sanitize(data string, var_type rt.PhpVal, base string) rt.PhpVal {
	return rt.call_method(this.item, 'sanitize', [rt.new_string(data), var_type.dup(), rt.new_string(base)])
}

fn (mut this Class_SimplePie_Source) get_item() rt.PhpVal {
	return this.item
}

fn (mut this Class_SimplePie_Source) get_title() rt.PhpVal {
	if rt.is_true(mut var_return := this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'title')) {
		return this.sanitize((var_return.array_get(0).array_get('data')).str(), rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_10_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_return.array_get(0).array_get('attribs') }])]), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(0)))).str())
	} else if rt.is_true(var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'title')) {
		return this.sanitize((var_return.array_get(0).array_get('data')).str(), rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_03_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_return.array_get(0).array_get('attribs') }])]), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(0)))).str())
	} else if rt.is_true(var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).str(), 'title')) {
		return this.sanitize((var_return.array_get(0).array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_maybe_html(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(0)))).str())
	} else if rt.is_true(var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).str(), 'title')) {
		return this.sanitize((var_return.array_get(0).array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_maybe_html(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(0)))).str())
	} else if rt.is_true(var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'title')) {
		return this.sanitize((var_return.array_get(0).array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_maybe_html(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(0)))).str())
	} else if rt.is_true(var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), 'title')) {
		return this.sanitize((var_return.array_get(0).array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
	} else if rt.is_true(var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), 'title')) {
		return this.sanitize((var_return.array_get(0).array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_category(key i64) rt.PhpVal {
	mut key_mutated := key
	mut var_categories := this.get_categories()
	if var_categories.array_isset(rt.new_int(key_mutated)) {
		return var_categories.array_get(key_mutated)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_categories() rt.PhpVal {
	mut var_categories := rt.new_array()
	{
		mut iter_1 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'category')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category := item_1.val
			mut var_term := rt.new_null()
			mut var_scheme := rt.new_null()
			mut var_label := rt.new_null()
			if var_category.array_get('attribs').array_get('').array_isset(rt.new_string('term')) {
				var_term = this.sanitize((var_category.array_get('attribs').array_get('').array_get('term')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
			}
			if var_category.array_get('attribs').array_get('').array_isset(rt.new_string('scheme')) {
				var_scheme = this.sanitize((var_category.array_get('attribs').array_get('').array_get('scheme')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
			}
			if var_category.array_get('attribs').array_get('').array_isset(rt.new_string('label')) {
				var_label = this.sanitize((var_category.array_get('attribs').array_get('').array_get('label')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
			}
			var_categories.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_term }, rt.ArrayItem{ key: none, val: var_scheme }, rt.ArrayItem{ key: none, val: var_label }])]))
		}
	}
	{
		mut iter_1 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'category')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category := item_1.val
			mut var_term := this.sanitize((var_category.array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
			if var_category.array_get('attribs').array_get('').array_isset(rt.new_string('domain')) {
				mut var_scheme := this.sanitize((var_category.array_get('attribs').array_get('').array_get('domain')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
			} else {
				var_scheme = rt.new_null()
			}
			var_categories.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_term }, rt.ArrayItem{ key: none, val: var_scheme }, rt.ArrayItem{ key: none, val: rt.new_null() }])]))
		}
	}
	{
		mut iter_1 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), 'subject')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category := item_1.val
			var_categories.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: this.sanitize((var_category.array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '') }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }])]))
		}
	}
	{
		mut iter_1 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), 'subject')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category := item_1.val
			var_categories.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: this.sanitize((var_category.array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '') }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }])]))
		}
	}
	if !(!rt.is_true(var_categories)) {
		return rt.call_function('array_unique', [var_categories.dup()])
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_author(key i64) rt.PhpVal {
	mut key_mutated := key
	mut var_authors := this.get_authors()
	if var_authors.array_isset(rt.new_int(key_mutated)) {
		return var_authors.array_get(key_mutated)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_authors() rt.PhpVal {
	mut var_authors := rt.new_array()
	{
		mut iter_1 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'author')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_author := item_1.val
			mut var_name := rt.new_null()
			mut var_uri := rt.new_null()
			mut var_email := rt.new_null()
			if var_author.array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get('name').array_get(0).array_isset(rt.new_string('data')) {
				var_name = this.sanitize((var_author.array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get('name').array_get(0).array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
			}
			if var_author.array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get('uri').array_get(0).array_isset(rt.new_string('data')) {
				var_uri = var_author.array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get('uri').array_get(0)
				var_uri = this.sanitize((var_uri.array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_iri(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_uri))).str())
			}
			if var_author.array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get('email').array_get(0).array_isset(rt.new_string('data')) {
				var_email = this.sanitize((var_author.array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get('email').array_get(0).array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_authors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_name }, rt.ArrayItem{ key: none, val: var_uri }, rt.ArrayItem{ key: none, val: var_email }])]))
			}
		}
	}
	if rt.is_true(mut var_author := this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'author')) {
		mut var_name := rt.new_null()
		mut var_url := rt.new_null()
		mut var_email := rt.new_null()
		if var_author.array_get(0).array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get('name').array_get(0).array_isset(rt.new_string('data')) {
			var_name = this.sanitize((var_author.array_get(0).array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get('name').array_get(0).array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		}
		if var_author.array_get(0).array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get('url').array_get(0).array_isset(rt.new_string('data')) {
			var_url = var_author.array_get(0).array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get('url').array_get(0)
			var_url = this.sanitize((var_url.array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_iri(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_url))).str())
		}
		if var_author.array_get(0).array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get('email').array_get(0).array_isset(rt.new_string('data')) {
			var_email = this.sanitize((var_author.array_get(0).array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get('email').array_get(0).array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			var_authors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_name }, rt.ArrayItem{ key: none, val: var_url }, rt.ArrayItem{ key: none, val: var_email }])]))
		}
	}
	{
		mut iter_1 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), 'creator')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_author_shadow := item_1.val
			var_authors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: this.sanitize((var_author_shadow.array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '') }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }])]))
		}
	}
	{
		mut iter_1 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), 'creator')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_author_shadow := item_1.val
			var_authors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: this.sanitize((var_author_shadow.array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '') }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }])]))
		}
	}
	{
		mut iter_1 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).str(), 'author')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_author_shadow := item_1.val
			var_authors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: this.sanitize((var_author_shadow.array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '') }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }])]))
		}
	}
	if !(!rt.is_true(var_authors)) {
		return rt.call_function('array_unique', [var_authors.dup()])
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_contributor(key i64) rt.PhpVal {
	mut key_mutated := key
	mut var_contributors := this.get_contributors()
	if var_contributors.array_isset(rt.new_int(key_mutated)) {
		return var_contributors.array_get(key_mutated)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_contributors() rt.PhpVal {
	mut var_contributors := rt.new_array()
	{
		mut iter_1 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'contributor')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_contributor := item_1.val
			mut var_name := rt.new_null()
			mut var_uri := rt.new_null()
			mut var_email := rt.new_null()
			if var_contributor.array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get('name').array_get(0).array_isset(rt.new_string('data')) {
				var_name = this.sanitize((var_contributor.array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get('name').array_get(0).array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
			}
			if var_contributor.array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get('uri').array_get(0).array_isset(rt.new_string('data')) {
				var_uri = var_contributor.array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get('uri').array_get(0)
				var_uri = this.sanitize((var_uri.array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_iri(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_uri))).str())
			}
			if var_contributor.array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get('email').array_get(0).array_isset(rt.new_string('data')) {
				var_email = this.sanitize((var_contributor.array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get('email').array_get(0).array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_contributors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_name }, rt.ArrayItem{ key: none, val: var_uri }, rt.ArrayItem{ key: none, val: var_email }])]))
			}
		}
	}
	{
		mut iter_1 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'contributor')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_contributor := item_1.val
			mut var_name := rt.new_null()
			mut var_url := rt.new_null()
			mut var_email := rt.new_null()
			if var_contributor.array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get('name').array_get(0).array_isset(rt.new_string('data')) {
				var_name = this.sanitize((var_contributor.array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get('name').array_get(0).array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
			}
			if var_contributor.array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get('url').array_get(0).array_isset(rt.new_string('data')) {
				var_url = var_contributor.array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get('url').array_get(0)
				var_url = this.sanitize((var_url.array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_iri(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_url))).str())
			}
			if var_contributor.array_get('child').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get('email').array_get(0).array_isset(rt.new_string('data')) {
				var_email = this.sanitize((.array_get().array_get('email').array_get(0).array_get('data')).str(), Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_contributors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_name }, rt.ArrayItem{ key: none, val: var_url }, rt.ArrayItem{ key: none, val: var_email }])]))
			}
		}
	}
	if !(!rt.is_true(var_contributors)) {
		return rt.call_function('array_unique', [var_contributors.dup()])
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_link(key i64, rel string) rt.PhpVal {
	mut key_mutated := key
	mut var_links := this.get_links(rel)
	if var_links.array_isset(rt.new_int(key_mutated)) {
		return .array_get()
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_permalink() rt.PhpVal {
	return 
}

fn (mut this Class_SimplePie_Source) get_links(rel string) rt.PhpVal {
}

fn (mut this Class_SimplePie_Source) get_description() rt.PhpVal {
}

fn (mut this Class_SimplePie_Source) get_copyright() rt.PhpVal {
}

fn (mut this Class_SimplePie_Source) get_language() rt.PhpVal {
}

fn (mut this Class_SimplePie_Source) get_latitude() rt.PhpVal {
	mut var_match := rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_longitude() rt.PhpVal {
	mut var_match := rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_image_url() rt.PhpVal {
}

fn create_simplepie_source(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_SimplePie_Source {
	mut obj := &Class_SimplePie_Source{
		PhpObjectBase: rt.PhpObjectBase{}
		item: rt.new_null()
		data: rt.new_array()
		registry: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_SimplePie_Source) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_Item](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'set_registry' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_SimplePie_Registry](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_registry(mut dispatch_arg_0)
			return rt.new_null()
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		'get_source_tags' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_source_tags(dispatch_arg_0, dispatch_arg_1)
		}
		'get_base' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_base(mut dispatch_arg_0)
		}
		'sanitize' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.sanitize(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_item' {
			return this.get_item()
		}
		'get_title' {
			return this.get_title()
		}
		'get_category' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_category(dispatch_arg_0)
		}
		'get_categories' {
			return this.get_categories()
		}
		'get_author' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_author(dispatch_arg_0)
		}
		'get_authors' {
			return this.get_authors()
		}
		'get_contributor' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_contributor(dispatch_arg_0)
		}
		'get_contributors' {
			return this.get_contributors()
		}
		'get_link' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_link(dispatch_arg_0, dispatch_arg_1)
		}
		'get_permalink' {
			return this.get_permalink()
		}
		'get_links' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_links(dispatch_arg_0)
		}
		'get_description' {
			return this.get_description()
		}
		'get_copyright' {
			return this.get_copyright()
		}
		'get_language' {
			return this.get_language()
		}
		'get_latitude' {
			return this.get_latitude()
		}
		'get_longitude' {
			return this.get_longitude()
		}
		'get_image_url' {
			return this.get_image_url()
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_Source) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'item' { return this.item }
		'data' { return this.data }
		'registry' { return this.registry }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Source) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'item' { this.item = val; return true }
		'data' { this.data = val; return true }
		'registry' { this.registry = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_simplepie_src_source_php() {
	// unsupported statement: Stmt_Declare
}
