import rt

struct Class_Automattic_WooCommerce_Internal_Utilities_URL {
	rt.PhpObjectBase
pub mut:
		components rt.PhpVal = rt.new_array()
		is_absolute bool
		is_non_root_directory bool
		path_parts rt.PhpVal = rt.new_array()
		url rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_URL) construct(url string)  {
	this.url = rt.new_string(url).dup()
	this.preprocess()
	this.process_path()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_URL) preprocess()  {
	mut var_matches := rt.new_null()
	this.url = rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), this.url])
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^(file://)?([a-z]):/(?!/).*#i'), this.url, var_matches.dup()])) {
		this.components.array_set('drive', var_matches.array_get(2))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('#^[a-z]+://#i'), this.url]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('#^//(?!/)#'), this.url]))))))) {
		this.url = 'file://' + (this.url).str()
	}
	mut var_parsed_components := rt.call_function('wp_parse_url', [this.url])
	if rt.is_true(rt.identical(rt.new_bool(false), var_parsed_components)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Utilities_URLException', []string{}, create_automattic_woocommerce_internal_utilities_urlexception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s is not a valid URL.'), rt.new_string('woocommerce')]), this.url]))))
	}
	this.components = rt.call_function('array_merge', [this.components, var_parsed_components.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('file'), this.components.array_get('scheme'))) && !(!rt.is_true(this.components.array_get('host'))))) {
		if rt.is_true(rt.identical(rt.new_null(), this.components.array_get('drive'))) {
			this.components.array_set('path', (this.components.array_get('host')).str() + (if !(this.components.array_get('path')).is_null() { this.components.array_get('path') } else { rt.new_string('') }).str())
		}
		this.components.array_set('host', rt.new_null())
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_URL) process_path()  {
	mut var_segments := rt.call_function('explode', [rt.new_string('/'), this.components.array_get('path')])
	this.is_absolute = rt.is_true(rt.identical(rt.call_function('substr', [this.components.array_get('path'), rt.new_int(0), rt.new_int(1)]), rt.new_string('/'))) || !(!rt.is_true(this.components.array_get('host')))
	this.is_non_root_directory = rt.is_true(rt.identical(rt.call_function('substr', [this.components.array_get('path'), // unsupported expression: Expr_UnaryMinus, rt.new_int(1)]), rt.new_string('/'))) && this.components.array_get('path').to_string().len > 1
	mut var_resolve_traversals := rt.new_bool(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(this.is_absolute)))
	mut var_retain_traversals := rt.new_bool(rt.new_bool(false))
	{
		mut iter_1 := var_segments.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_part := item_1.val
			if rt.is_true(rt.new_bool(var_part.dup().to_string().len == 0 || rt.is_true(rt.identical(rt.new_string('.'), var_part)))) {
				continue
			}
			mut var_is_traversal := rt.identical(rt.call_function('str_ireplace', [rt.new_string('%2e'), rt.new_string('.'), var_part.dup()]), rt.new_string('..'))
			if rt.is_true(rt.new_bool(rt.is_true(var_resolve_traversals) && rt.is_true(var_is_traversal))) {
				if rt.is_true(rt.new_bool(this.path_parts.array_count() > 0 && rt.is_true(rt.new_bool(!(rt.is_true(var_retain_traversals)))))) {
					this.path_parts = rt.call_function('array_slice', [this.path_parts, rt.new_int(0), this.path_parts.array_count() - 1])
					continue
				} else if rt.is_true(this.is_absolute) {
					continue
				}
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_resolve_traversals)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.identical(rt.new_string('file'), this.components.array_get('scheme'))))) && rt.is_true(rt.new_bool(!(rt.is_true(this.is_absolute)))))) {
				var_resolve_traversals = rt.new_bool(rt.new_bool(true))
			}
			var_retain_traversals = rt.new_bool(rt.new_bool(rt.is_true(var_resolve_traversals) && rt.is_true(rt.identical(rt.new_string('..'), var_part))))
			this.path_parts.array_push(var_part.dup())
		}
	}
	if rt.is_true(rt.new_bool(this.path_parts.array_count() == 0 && rt.is_true(rt.new_bool(!(rt.is_true(this.is_absolute)))))) {
		this.path_parts = rt.create_array([rt.ArrayItem{ key: none, val: '.' }])
		this.is_non_root_directory = true
	}
	this.components.array_set('path', if rt.is_true(this.is_absolute) { '/' } else { '' } + (rt.call_function('implode', [rt.new_string('/'), this.path_parts])).str() + if rt.is_true(this.is_non_root_directory) { '/' } else { '' })
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_URL) magic_tostring() string {
	return this.get_url(rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_URL) get_all_parent_urls() rt.PhpVal {
	mut var_max_parent := rt.new_int(rt.new_int(this.path_parts.array_count()))
	mut var_parents := rt.new_array()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_max_parent, rt.new_int(0))) && rt.is_true(rt.new_bool(!(rt.is_true(this.is_absolute)))))) && rt.is_true(rt.identical(rt.new_string('..'), this.path_parts.array_get(0))))) {
		var_max_parent = rt.new_int(rt.new_int(1))
	}
	{
		mut var_level := rt.new_int(rt.new_int(1))
		for {
			if !(rt.is_true(rt.less_equal(var_level, var_max_parent))) { break }
			var_parents.array_push(this.get_parent_url((var_level).to_i64()))
			rt.post_inc(var_level)
		}
	}
	return var_parents.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_URL) get_parent_url(level i64) bool {
	mut level_mutated := level
	if level_mutated < 1 {
		level_mutated = 1
	}
	mut var_parts_count := rt.new_int(rt.new_int(this.path_parts.array_count()))
	mut var_parent_path_parts_to_keep := rt.sub(var_parts_count, rt.new_int(level_mutated))
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.less(var_parent_path_parts_to_keep, rt.new_int(0))))) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('file'), this.components.array_get('scheme'))) && rt.is_true(this.is_absolute))) && !rt.is_true(this.path_parts))) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_parts_count, rt.new_int(0))) && rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('.'), this.path_parts.array_get(0))) || rt.is_true(rt.identical(rt.new_string('..'), this.path_parts.array_get(0))))))) {
		mut var_single_dots := rt.func_array_keys(this.path_parts, rt.new_string('.'), rt.new_bool(true))
		mut var_double_dots := rt.func_array_keys(this.path_parts, rt.new_string('..'), rt.new_bool(true))
		mut var_max_dot_index := rt.call_function('max', [rt.call_function('array_merge', [var_single_dots.dup(), var_double_dots.dup()])])
		mut var_last_traversal := rt.add(var_max_dot_index, if rt.is_true(this.is_non_root_directory) { rt.new_int(1) } else { rt.new_int(0) })
		mut var_parent_path := rt.new_string(rt.concat(rt.call_function('str_repeat', [rt.new_string('../'), rt.new_int(level_mutated).dup()]), rt.call_function('join', [rt.new_string('/'), rt.call_function('array_slice', [this.path_parts, rt.new_int(0), var_last_traversal.dup()])])))
	} else if rt.is_true(rt.less(var_parent_path_parts_to_keep, rt.new_int(0))) {
		var_parent_path = rt.call_function('untrailingslashit', [rt.call_function('str_repeat', [rt.new_string('../'), rt.mul(var_parent_path_parts_to_keep, // unsupported expression: Expr_UnaryMinus)])])
	} else {
		var_parent_path = rt.call_function('implode', [rt.new_string('/'), rt.call_function('array_slice', [this.path_parts, rt.new_int(0), var_parent_path_parts_to_keep.dup()])])
	}
	if rt.is_true(rt.new_bool(this.is_relative() && rt.is_true(rt.identical(rt.new_string(''), var_parent_path)))) {
		var_parent_path = rt.new_string(rt.new_string('.'))
	}
	// unsupported expression: Expr_AssignOp_Concat
	if rt.is_true(rt.new_bool(rt.is_true(this.is_absolute) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_parent_path = rt.new_string('/' + (var_parent_path).str())
	}
	mut var_parent_url := rt.new_string(this.get_url(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](rt.create_array([rt.ArrayItem{ key: 'path', val: var_parent_path }, rt.ArrayItem{ key: 'query', val: rt.new_null() }, rt.ArrayItem{ key: 'fragment', val: rt.new_null() }]))))
	return (rt.call_method(create_automattic_woocommerce_internal_utilities_self(var_parent_url.dup()), 'get_url', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_URL) get_url(mut var_component_overrides Class_Automattic_WooCommerce_Internal_Utilities_array) string {
	mut var_components := rt.call_function('array_merge', [this.components, var_component_overrides])
	mut var_scheme := rt.new_string(if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { (var_components.array_get('scheme')).str() + '://' } else { rt.new_string('//') })
	mut var_host := if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_components.array_get('host') } else { rt.new_string('') }
	mut var_port := rt.new_string(if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { ':' + (var_components.array_get('port')).str() } else { rt.new_string('') })
	mut var_path := rt.new_string(this.get_path(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_?string](var_components.array_get('path'))))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), var_host)) && rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), var_path)) || rt.is_true(rt.identical(rt.new_string('.'), var_path)))))) {
		var_path = rt.new_string(rt.new_string('./'))
	}
	mut var_user := if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_components.array_get('user') } else { rt.new_string('') }
	mut var_pass := rt.new_string(if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { ':' + (var_components.array_get('pass')).str() } else { rt.new_string('') })
	mut var_user_pass := rt.new_string(if !(!rt.is_true(var_user)) || !(!rt.is_true(var_pass)) { (var_user).str() + (var_pass).str() + '@' } else { rt.new_string('') })
	mut var_query := rt.new_string(if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { '?' + (var_components.array_get('query')).str() } else { rt.new_string('') })
	mut var_fragment := rt.new_string(if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { '#' + (var_components.array_get('fragment')).str() } else { rt.new_string('') })
	return (var_scheme).str() + (var_user_pass).str() + (var_host).str() + (var_port).str() + (var_path).str() + (var_query).str() + (var_fragment).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_URL) get_path(mut var_path_override Class_Automattic_WooCommerce_Internal_Utilities_?string) string {
	return if rt.is_true(this.components.array_get('drive')) { (this.components.array_get('drive')).str() + ':' } else { '' } + (if !(var_path_override).is_null() { var_path_override } else { this.components.array_get('path') }).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_URL) is_absolute() bool {
	return this.is_absolute
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_URL) is_relative() bool {
	return !(rt.is_true(this.is_absolute))
}

struct Class_Automattic_WooCommerce_Internal_Utilities_URLException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_self {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_utilities_url(url string) &Class_Automattic_WooCommerce_Internal_Utilities_URL {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_URL{
		PhpObjectBase: rt.PhpObjectBase{}
		components: rt.new_array()
		is_absolute: false
		is_non_root_directory: false
		path_parts: rt.new_array()
		url: rt.new_null()
	}
	obj.construct(url)
	return obj
}

fn create_automattic_woocommerce_internal_utilities_urlexception() &Class_Automattic_WooCommerce_Internal_Utilities_URLException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_URLException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_self() &Class_Automattic_WooCommerce_Internal_Utilities_self {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_URL) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'preprocess' {
			this.preprocess()
			return rt.new_null()
		}
		'process_path' {
			this.process_path()
			return rt.new_null()
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		'get_all_parent_urls' {
			return this.get_all_parent_urls()
		}
		'get_parent_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.get_parent_url(dispatch_arg_0))
		}
		'get_url' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_url(mut dispatch_arg_0))
		}
		'get_path' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_path(mut dispatch_arg_0))
		}
		'is_absolute' {
			return rt.new_bool(this.is_absolute())
		}
		'is_relative' {
			return rt.new_bool(this.is_relative())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_URL) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'components' { return this.components }
		'is_absolute' { return rt.new_bool(this.is_absolute) }
		'is_non_root_directory' { return rt.new_bool(this.is_non_root_directory) }
		'path_parts' { return this.path_parts }
		'url' { return this.url }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_URL) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'components' { this.components = val; return true }
		'is_absolute' { this.is_absolute = (val).to_bool(); return true }
		'is_non_root_directory' { this.is_non_root_directory = (val).to_bool(); return true }
		'path_parts' { this.path_parts = val; return true }
		'url' { this.url = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_URLException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_URLException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_URLException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_utilities_url_php() {
}
