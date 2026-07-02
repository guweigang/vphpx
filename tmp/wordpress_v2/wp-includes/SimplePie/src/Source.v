import rt
import crypto.md5

struct Class_SimplePie_Source {
	rt.PhpObjectBase
pub mut:
	item     rt.PhpVal = rt.new_null()
	data     rt.PhpVal = rt.new_array()
	registry rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Source) construct(mut var_item Class_SimplePie_Item, mut var_data Class_SimplePie_array) {
	this.item = var_item
	this.data = var_data
}

fn (mut this Class_SimplePie_Source) set_registry(mut var_registry Class_SimplePie_SimplePie_Registry) {
	this.registry = var_registry
}

fn (mut this Class_SimplePie_Source) magic_tostring() string {
	return md5.hexhash(rt.call_function('serialize', [this.data]).to_string())
}

fn (mut this Class_SimplePie_Source) get_source_tags(namespace string, tag string) rt.PhpVal {
	if this.data.array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_isset(rt.new_string(tag)) {
		return this.data.array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_get(rt.new_string(tag))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_base(mut var_element Class_SimplePie_array) rt.PhpVal {
	return rt.call_method(this.item, 'get_base', [var_element])
}

fn (mut this Class_SimplePie_Source) sanitize(data string, var_type rt.PhpVal, base string) rt.PhpVal {
	return rt.call_method(this.item, 'sanitize', [rt.new_string(data),
		var_type.clone(), rt.new_string(base)])
}

fn (mut this Class_SimplePie_Source) get_item() rt.PhpVal {
	return this.item
}

fn (mut this Class_SimplePie_Source) get_title() rt.PhpVal {
	mut var_return := this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(),
		'title')
	if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), rt.call_method(this.registry,
			'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_10_construct_type'),
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: var_return.array_get(rt.new_int(0)).array_get(rt.new_string('attribs'))
				},
			])]),
			(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str())
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(),
			'title')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), rt.call_method(this.registry,
			'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_03_construct_type'),
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: var_return.array_get(rt.new_int(0)).array_get(rt.new_string('attribs'))
				},
			])]),
			(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str())
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).str(),
			'title')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_maybe_html(),
			(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str())
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).str(),
			'title')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_maybe_html(),
			(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str())
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(),
			'title')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_maybe_html(),
			(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str())
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(),
			'title')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(),
			'title')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_category(key i64) rt.PhpVal {
	mut key_mutated := key
	mut var_categories := this.get_categories()
	if var_categories.array_isset(rt.new_int(key_mutated)) {
		return var_categories.array_get(rt.new_int(key_mutated))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_categories() rt.PhpVal {
	mut var_categories := rt.new_array()
	mut iter_1 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(),
		'category')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_category := item_1.val
		mut var_term := rt.new_null()
		mut var_scheme := rt.new_null()
		mut var_label := rt.new_null()
		if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('term')) {
			var_term = this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('term'))).str(),
				Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		}
		if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('scheme')) {
			var_scheme = this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('scheme'))).str(),
				Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		}
		if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('label')) {
			var_label = this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('label'))).str(),
				Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		}
		var_categories.array_push(rt.call_method(this.registry, 'create', [
			Class_SimplePie_Category.class(),
			rt.create_array([rt.ArrayItem{ key: none, val: var_term },
				rt.ArrayItem{ key: none, val: var_scheme }, rt.ArrayItem{ key: none, val: var_label }]),
		]))
	}
	mut iter_2 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(),
		'category')).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_category := item_2.val
		mut var_term := this.sanitize((var_category.array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('domain')) {
			mut var_scheme := this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('domain'))).str(),
				Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		} else {
			var_scheme = rt.new_null()
		}
		var_categories.array_push(rt.call_method(this.registry, 'create', [
			Class_SimplePie_Category.class(),
			rt.create_array([rt.ArrayItem{ key: none, val: var_term },
				rt.ArrayItem{ key: none, val: var_scheme }, rt.ArrayItem{
					key: none
					val: rt.new_null()
				}]),
		]))
	}
	mut iter_3 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(),
		'subject')).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_category := item_3.val
		var_categories.array_push(rt.call_method(this.registry, 'create', [
			Class_SimplePie_Category.class(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: this.sanitize((var_category.array_get(rt.new_string('data'))).str(),
					Class_SimplePie_SimplePie_SimplePie.construct_text(), '') },
				rt.ArrayItem{ key: none, val: rt.new_null() },
				rt.ArrayItem{ key: none, val: rt.new_null() },
			]),
		]))
	}
	mut iter_4 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(),
		'subject')).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_category := item_4.val
		var_categories.array_push(rt.call_method(this.registry, 'create', [
			Class_SimplePie_Category.class(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: this.sanitize((var_category.array_get(rt.new_string('data'))).str(),
					Class_SimplePie_SimplePie_SimplePie.construct_text(), '') },
				rt.ArrayItem{ key: none, val: rt.new_null() },
				rt.ArrayItem{ key: none, val: rt.new_null() },
			]),
		]))
	}
	if !(!rt.is_true(var_categories)) {
		return rt.call_function('array_unique', [var_categories.clone()])
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_author(key i64) rt.PhpVal {
	mut key_mutated := key
	mut var_authors := this.get_authors()
	if var_authors.array_isset(rt.new_int(key_mutated)) {
		return var_authors.array_get(rt.new_int(key_mutated))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_authors() rt.PhpVal {
	mut var_authors := rt.new_array()
	mut iter_5 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(),
		'author')).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_author := item_5.val
		mut var_name := rt.new_null()
		mut var_uri := rt.new_null()
		mut var_email := rt.new_null()
		if var_author.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
			var_name = this.sanitize((var_author.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
				Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		}
		if var_author.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('uri')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
			var_uri =
				var_author.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('uri')).array_get(rt.new_int(0))
			var_uri = this.sanitize((var_uri.array_get(rt.new_string('data'))).str(),
				Class_SimplePie_SimplePie_SimplePie.construct_iri(),
				(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_uri))).str())
		}
		if var_author.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
			var_email = this.sanitize((var_author.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
				Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_name, rt.new_null()))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_email, rt.new_null()))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_uri, rt.new_null())))) {
			var_authors.array_push(rt.call_method(this.registry, 'create', [
				Class_SimplePie_Author.class(),
				rt.create_array([rt.ArrayItem{ key: none, val: var_name },
					rt.ArrayItem{ key: none, val: var_uri }, rt.ArrayItem{ key: none, val: var_email }]),
			]))
		}
	}
	mut var_author := this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(),
		'author')
	if rt.is_true(var_author) {
		mut var_name := rt.new_null()
		mut var_url := rt.new_null()
		mut var_email := rt.new_null()
		if var_author.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
			var_name = this.sanitize((var_author.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
				Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		}
		if var_author.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('url')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
			var_url =
				var_author.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('url')).array_get(rt.new_int(0))
			var_url = this.sanitize((var_url.array_get(rt.new_string('data'))).str(),
				Class_SimplePie_SimplePie_SimplePie.construct_iri(),
				(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_url))).str())
		}
		if var_author.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
			var_email = this.sanitize((var_author.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
				Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_name, rt.new_null()))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_email, rt.new_null()))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_url, rt.new_null())))) {
			var_authors.array_push(rt.call_method(this.registry, 'create', [
				Class_SimplePie_Author.class(),
				rt.create_array([rt.ArrayItem{ key: none, val: var_name },
					rt.ArrayItem{ key: none, val: var_url }, rt.ArrayItem{ key: none, val: var_email }]),
			]))
		}
	}
	mut iter_6 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(),
		'creator')).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_author_shadow := item_6.val
		var_authors.array_push(rt.call_method(this.registry, 'create', [
			Class_SimplePie_Author.class(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: this.sanitize((var_author_shadow.array_get(rt.new_string('data'))).str(),
					Class_SimplePie_SimplePie_SimplePie.construct_text(), '') },
				rt.ArrayItem{ key: none, val: rt.new_null() },
				rt.ArrayItem{ key: none, val: rt.new_null() },
			]),
		]))
	}
	mut iter_7 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(),
		'creator')).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_author_shadow := item_7.val
		var_authors.array_push(rt.call_method(this.registry, 'create', [
			Class_SimplePie_Author.class(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: this.sanitize((var_author_shadow.array_get(rt.new_string('data'))).str(),
					Class_SimplePie_SimplePie_SimplePie.construct_text(), '') },
				rt.ArrayItem{ key: none, val: rt.new_null() },
				rt.ArrayItem{ key: none, val: rt.new_null() },
			]),
		]))
	}
	mut iter_8 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).str(),
		'author')).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_author_shadow := item_8.val
		var_authors.array_push(rt.call_method(this.registry, 'create', [
			Class_SimplePie_Author.class(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: this.sanitize((var_author_shadow.array_get(rt.new_string('data'))).str(),
					Class_SimplePie_SimplePie_SimplePie.construct_text(), '') },
				rt.ArrayItem{ key: none, val: rt.new_null() },
				rt.ArrayItem{ key: none, val: rt.new_null() },
			]),
		]))
	}
	if !(!rt.is_true(var_authors)) {
		return rt.call_function('array_unique', [var_authors.clone()])
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_contributor(key i64) rt.PhpVal {
	mut key_mutated := key
	mut var_contributors := this.get_contributors()
	if var_contributors.array_isset(rt.new_int(key_mutated)) {
		return var_contributors.array_get(rt.new_int(key_mutated))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_contributors() rt.PhpVal {
	mut var_contributors := rt.new_array()
	mut iter_9 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(),
		'contributor')).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_contributor := item_9.val
		mut var_name := rt.new_null()
		mut var_uri := rt.new_null()
		mut var_email := rt.new_null()
		if var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
			var_name = this.sanitize((var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
				Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		}
		if var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('uri')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
			var_uri =
				var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('uri')).array_get(rt.new_int(0))
			var_uri = this.sanitize((var_uri.array_get(rt.new_string('data'))).str(),
				Class_SimplePie_SimplePie_SimplePie.construct_iri(),
				(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_uri))).str())
		}
		if var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
			var_email = this.sanitize((var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
				Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_name, rt.new_null()))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_email, rt.new_null()))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_uri, rt.new_null())))) {
			var_contributors.array_push(rt.call_method(this.registry, 'create', [
				Class_SimplePie_Author.class(),
				rt.create_array([rt.ArrayItem{ key: none, val: var_name },
					rt.ArrayItem{ key: none, val: var_uri }, rt.ArrayItem{ key: none, val: var_email }]),
			]))
		}
	}
	mut iter_10 := rt.cast_array(this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(),
		'contributor')).iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_contributor := item_10.val
		mut var_name := rt.new_null()
		mut var_url := rt.new_null()
		mut var_email := rt.new_null()
		if var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
			var_name = this.sanitize((var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
				Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		}
		if var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('url')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
			var_url =
				var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('url')).array_get(rt.new_int(0))
			var_url = this.sanitize((var_url.array_get(rt.new_string('data'))).str(),
				Class_SimplePie_SimplePie_SimplePie.construct_iri(),
				(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_url))).str())
		}
		if var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
			var_email = this.sanitize((var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
				Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_name, rt.new_null()))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_email, rt.new_null()))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_url, rt.new_null())))) {
			var_contributors.array_push(rt.call_method(this.registry, 'create', [
				Class_SimplePie_Author.class(),
				rt.create_array([rt.ArrayItem{ key: none, val: var_name },
					rt.ArrayItem{ key: none, val: var_url }, rt.ArrayItem{ key: none, val: var_email }]),
			]))
		}
	}
	if !(!rt.is_true(var_contributors)) {
		return rt.call_function('array_unique', [var_contributors.clone()])
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_link(key i64, rel string) rt.PhpVal {
	mut key_mutated := key
	mut var_links := this.get_links(rel)
	if var_links.array_isset(rt.new_int(key_mutated)) {
		return var_links.array_get(rt.new_int(key_mutated))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_permalink() rt.PhpVal {
	return this.get_link(0, '')
}

fn (mut this Class_SimplePie_Source) get_links(rel string) rt.PhpVal {
	if !(this.data.array_isset(rt.new_string('links'))) {
		this.data.array_set('links', rt.new_array())
		mut var_links := this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(),
			'link')
		if rt.is_true(var_links) {
			mut iter_11 := var_links.iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_link := item_11.val
				if var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('href')) {
					mut var_link_rel := if var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('rel')) {
						var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('rel'))
					} else {
						rt.new_string('alternate')
					}
					this.data.array_get_mut('links').array_get_mut(var_link_rel).array_push(this.sanitize((var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('href'))).str(),
						Class_SimplePie_SimplePie_SimplePie.construct_iri(),
						(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_link))).str()))
				}
			}
		}
		var_links = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(),
			'link')
		if rt.is_true(var_links) {
			mut iter_12 := var_links.iterator()
			for {
				item_12 := iter_12.next() or { break }
				mut var_link := item_12.val
				if var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('href')) {
					mut var_link_rel := if var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('rel')) {
						var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('rel'))
					} else {
						rt.new_string('alternate')
					}
					this.data.array_get_mut('links').array_get_mut(var_link_rel).array_push(this.sanitize((var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('href'))).str(),
						Class_SimplePie_SimplePie_SimplePie.construct_iri(),
						(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_link))).str()))
				}
			}
		}
		var_links = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).str(),
			'link')
		if rt.is_true(var_links) {
			this.data.array_get_mut('links').array_get_mut('alternate').array_push(this.sanitize((var_links.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
				Class_SimplePie_SimplePie_SimplePie.construct_iri(),
				(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_links.array_get(rt.new_int(0))))).str()))
		}
		var_links = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).str(),
			'link')
		if rt.is_true(var_links) {
			this.data.array_get_mut('links').array_get_mut('alternate').array_push(this.sanitize((var_links.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
				Class_SimplePie_SimplePie_SimplePie.construct_iri(),
				(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_links.array_get(rt.new_int(0))))).str()))
		}
		var_links = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(),
			'link')
		if rt.is_true(var_links) {
			this.data.array_get_mut('links').array_get_mut('alternate').array_push(this.sanitize((var_links.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
				Class_SimplePie_SimplePie_SimplePie.construct_iri(),
				(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_links.array_get(rt.new_int(0))))).str()))
		}
		mut var_keys := rt.func_array_keys(this.data.array_get(rt.new_string('links')))
		mut iter_13 := var_keys.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_key := item_13.val
			var_key = rt.new_string(var_key.str())
			if rt.is_true(rt.call_method(this.registry, 'call', [
				Class_SimplePie_Misc.class(),
				rt.new_string('is_isegment_nz_nc'),
				rt.create_array([rt.ArrayItem{ key: none, val: var_key }]),
			]))
			{
				if this.data.array_get(rt.new_string('links')).array_isset(
					(Class_SimplePie_SimplePie_SimplePie.iana_link_relations_registry()).str() +
					var_key.str())
				{
					this.data.array_get_mut('links').array_set(
						(Class_SimplePie_SimplePie_SimplePie.iana_link_relations_registry()).str() +
						var_key.str(), rt.call_function('array_merge', [
						this.data.array_get(rt.new_string('links')).array_get(var_key),
						this.data.array_get(rt.new_string('links')).array_get(rt.new_string(
							(Class_SimplePie_SimplePie_SimplePie.iana_link_relations_registry()).str() +
							var_key.str())),
					]))
					this.data.array_get(rt.new_string('links')).array_get(var_key) = this.data.array_get(rt.new_string('links')).array_get(rt.new_string(
						(Class_SimplePie_SimplePie_SimplePie.iana_link_relations_registry()).str() +
						var_key.str()))
				} else {
					this.data.array_get(rt.new_string('links')).array_get(rt.new_string(
						(Class_SimplePie_SimplePie_SimplePie.iana_link_relations_registry()).str() +
						var_key.str())) =
						this.data.array_get(rt.new_string('links')).array_get(var_key)
				}
			} else if rt.is_true(rt.identical(rt.call_function('substr', [
				var_key.clone(), rt.new_int(0), rt.new_int(41)]),
				Class_SimplePie_SimplePie_SimplePie.iana_link_relations_registry()))
			{
				this.data.array_get(rt.new_string('links')).array_get(rt.call_function('substr', [
					var_key.clone(),
					rt.new_int(41),
				])) = this.data.array_get(rt.new_string('links')).array_get(var_key)
			}
			this.data.array_get_mut('links').array_set(var_key, rt.call_function('array_unique', [
				this.data.array_get(rt.new_string('links')).array_get(var_key),
			]))
		}
	}
	if this.data.array_get(rt.new_string('links')).array_isset(rt.new_string(rel)) {
		return this.data.array_get(rt.new_string('links')).array_get(rt.new_string(rel))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_description() rt.PhpVal {
	mut var_return := this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(),
		'subtitle')
	if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), rt.call_method(this.registry,
			'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_10_construct_type'),
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: var_return.array_get(rt.new_int(0)).array_get(rt.new_string('attribs'))
				},
			])]),
			(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str())
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(),
			'tagline')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), rt.call_method(this.registry,
			'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_03_construct_type'),
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: var_return.array_get(rt.new_int(0)).array_get(rt.new_string('attribs'))
				},
			])]),
			(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str())
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).str(),
			'description')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_maybe_html(),
			(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str())
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).str(),
			'description')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_maybe_html(),
			(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str())
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(),
			'description')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_maybe_html(),
			(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str())
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(),
			'description')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(),
			'description')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).str(),
			'summary')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_html(),
			(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str())
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).str(),
			'subtitle')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_html(),
			(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str())
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_copyright() rt.PhpVal {
	mut var_return := this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(),
		'rights')
	if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), rt.call_method(this.registry,
			'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_10_construct_type'),
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: var_return.array_get(rt.new_int(0)).array_get(rt.new_string('attribs'))
				},
			])]),
			(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str())
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(),
			'copyright')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), rt.call_method(this.registry,
			'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_03_construct_type'),
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: var_return.array_get(rt.new_int(0)).array_get(rt.new_string('attribs'))
				},
			])]),
			(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str())
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(),
			'copyright')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(),
			'rights')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(),
			'rights')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_language() rt.PhpVal {
	mut var_return := this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(),
		'language')
	if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(),
			'language')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(),
			'language')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
	} else if this.data.array_isset(rt.new_string('xml_lang')) {
		return this.sanitize((this.data.array_get(rt.new_string('xml_lang'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_text(), '')
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_latitude() rt.PhpVal {
	mut var_match := rt.new_null()
	mut var_return := this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_w3c_basic_geo()).str(),
		'lat')
	if rt.is_true(var_return) {
		return rt.new_float((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).to_f64())
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_georss()).str(),
			'point')
	} else if rt.is_true(var_return)
		&& rt.is_true(rt.call_function('preg_match', [rt.new_string('/^((?:-)?[0-9]+(?:\\.[0-9]+)) ((?:-)?[0-9]+(?:\\.[0-9]+))$/'), rt.new_string(var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data')).to_string().trim_space()), var_match.clone()])) {
		return rt.new_float((var_match.array_get(rt.new_int(1))).to_f64())
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_longitude() rt.PhpVal {
	mut var_match := rt.new_null()
	mut var_return := this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_w3c_basic_geo()).str(),
		'long')
	if rt.is_true(var_return) {
		return rt.new_float((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).to_f64())
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_w3c_basic_geo()).str(),
			'lon')
	} else if rt.is_true(var_return) {
		return rt.new_float((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).to_f64())
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_georss()).str(),
			'point')
	} else if rt.is_true(var_return)
		&& rt.is_true(rt.call_function('preg_match', [rt.new_string('/^((?:-)?[0-9]+(?:\\.[0-9]+)) ((?:-)?[0-9]+(?:\\.[0-9]+))$/'), rt.new_string(var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data')).to_string().trim_space()), var_match.clone()])) {
		return rt.new_float((var_match.array_get(rt.new_int(2))).to_f64())
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Source) get_image_url() rt.PhpVal {
	mut var_return := this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).str(),
		'image')
	if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('href'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_iri(), '')
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(),
			'logo')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_iri(),
			(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str())
		var_return = this.get_source_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(),
			'icon')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(),
			Class_SimplePie_SimplePie_SimplePie.construct_iri(),
			(this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str())
	}
	return rt.new_null()
}

fn create_simplepie_source(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_SimplePie_Source {
	mut obj := &Class_SimplePie_Source{
		PhpObjectBase: rt.PhpObjectBase{}
		item:          rt.new_null()
		data:          rt.new_array()
		registry:      rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_SimplePie_Source) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_Item](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'set_registry' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_SimplePie_Registry](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
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
		else {
			return none
		}
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
		'item' {
			this.item = val
			return true
		}
		'data' {
			this.data = val
			return true
		}
		'registry' {
			this.registry = val
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

	rt.call_function('class_alias', [rt.new_string('SimplePie\\Source'),
		rt.new_string('SimplePie_Source')])
}
