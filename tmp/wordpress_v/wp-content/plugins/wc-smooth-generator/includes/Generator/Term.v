import rt

struct Class_WC_SmoothGenerator_Generator_Term {
	rt.PhpObjectBase
}

fn Class_WC_SmoothGenerator_Generator_Term.generate(save bool, taxonomy string, parent i64) rt.PhpVal {
	mut var_taxonomy_obj := rt.call_function('get_taxonomy', [rt.new_string(taxonomy)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_taxonomy_obj)))) {
		return create_wc_smoothgenerator_generator_wp_error(rt.new_string('smoothgenerator_invalid_taxonomy'), rt.new_string('The specified taxonomy is invalid.'))
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return create_wc_smoothgenerator_generator_wp_error(rt.new_string('smoothgenerator_invalid_term_hierarchy'), rt.new_string('The specified taxonomy does not support parent terms.'))
	}
	this.Class_WC_SmoothGenerator_Generator_Generator.maybe_initialize_generators()
	if rt.is_true(rt.identical(rt.new_string('product_brand'), rt.new_string(taxonomy))) {
		mut var_term_name := rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'company', []rt.PhpVal{})
	} else if rt.is_true(rt.get_property(var_taxonomy_obj, 'hierarchical')) {
		var_term_name = rt.call_function('ucwords', [rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'department', [rt.new_int(3)])])
	} else {
		var_term_name = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_Term{}; return temp.random_weighted_element(arg_0) }(rt.create_array([rt.ArrayItem{ key: rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'lastName', []rt.PhpVal{}), val: 45 }, rt.ArrayItem{ key: rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'colorName', []rt.PhpVal{}), val: 35 }, rt.ArrayItem{ key: rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'words', [rt.new_int(3), rt.new_bool(true)]), val: 20 }]))
		var_term_name = rt.new_string(rt.new_string(var_term_name.dup().to_string().to_lower()))
	}
	mut var_description_size := rt.call_function('wp_rand', [rt.new_int(20), rt.new_int(260)])
	mut var_term_args := rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'realTextBetween', [var_description_size.dup(), rt.add(var_description_size, rt.new_int(40)), rt.new_int(4)]) }])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_term_args.array_set('parent', parent)
	}
	mut var_result := rt.call_function('wp_insert_term', [var_term_name.dup(), rt.new_string(taxonomy), var_term_args.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		return var_result.dup()
	}
	mut var_term := rt.call_function('get_term', [var_result.array_get('term_id')])
	rt.call_function('do_action', [rt.new_string('smoothgenerator_term_generated'), var_term.dup()])
	return var_term.dup()
}

fn Class_WC_SmoothGenerator_Generator_Term.batch(var_amount rt.PhpVal, var_taxonomy rt.PhpVal, mut var_args Class_WC_SmoothGenerator_Generator_array) rt.PhpVal {
	mut var_amount_mutated := var_amount
	var_amount_mutated = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_Term{}; return temp.validate_batch_amount(arg_0) }(var_amount_mutated.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_amount_mutated.dup()])) {
		return var_amount_mutated.dup()
	}
	mut var_taxonomy_obj := rt.call_function('get_taxonomy', [var_taxonomy.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_taxonomy_obj)))) {
		return create_wc_smoothgenerator_generator_wp_error(rt.new_string('smoothgenerator_term_batch_invalid_taxonomy'), rt.new_string('The specified taxonomy is invalid.'))
	}
	if rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(var_taxonomy_obj, 'hierarchical'))) {
		return Class_WC_SmoothGenerator_Generator_Term.batch_hierarchical((var_amount_mutated).to_i64(), (var_taxonomy).str(), mut var_args)
	}
	mut var_term_ids := rt.new_array()
	{
		mut var_i := rt.new_int(rt.new_int(1))
		for {
			if !(rt.is_true(rt.less_equal(var_i, var_amount_mutated))) { break }
			mut var_term := Class_WC_SmoothGenerator_Generator_Term.generate(true, (var_taxonomy).str())
			if rt.is_true(rt.call_function('is_wp_error', [var_term.dup()])) {
				if rt.is_true(rt.identical(rt.new_string('term_exists'), rt.call_method(var_term, 'get_error_code', []rt.PhpVal{}))) {
					rt.pre_dec(var_i)
					continue
				}
				return var_term.dup()
			}
			var_term_ids.array_push(rt.get_property(var_term, 'term_id'))
			rt.post_inc(var_i)
		}
	}
	return var_term_ids.dup()
}

fn Class_WC_SmoothGenerator_Generator_Term.batch_hierarchical(amount i64, taxonomy string, mut var_args Class_WC_SmoothGenerator_Generator_array) rt.PhpVal {
	mut var_max_depth := rt.new_null()
	mut var_parent := i64(0)
	mut amount_mutated := amount
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'max-depth', val: 1 }, rt.ArrayItem{ key: 'parent', val: 0 }])
	// unsupported assign target: Expr_List
	if rt.is_true(rt.identical(rt.new_bool(false), var_max_depth)) {
		return create_wc_smoothgenerator_generator_wp_error(rt.new_string('smoothgenerator_term_batch_invalid_max_depth'), rt.new_string('Max depth must be a number between 1 and 5.'))
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_int(var_parent))) {
		return create_wc_smoothgenerator_generator_wp_error(rt.new_string('smoothgenerator_term_batch_invalid_parent'), rt.new_string('Parent must be the ID number of an existing term.'))
	}
	mut var_term_ids := rt.new_array()
	fn () rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_Term{}; return temp.init_faker() }()
	if rt.is_true(rt.new_bool(var_parent != 0 || rt.is_true(rt.identical(rt.new_int(1), var_max_depth)))) {
		{
			mut var_i := rt.new_int(rt.new_int(1))
			for {
				if !(rt.is_true(rt.less_equal(var_i, rt.new_int(amount_mutated)))) { break }
				mut var_term := Class_WC_SmoothGenerator_Generator_Term.generate(true, taxonomy, var_parent)
				if rt.is_true(rt.call_function('is_wp_error', [var_term.dup()])) {
					if rt.is_true(rt.identical(rt.new_string('term_exists'), rt.call_method(var_term, 'get_error_code', []rt.PhpVal{}))) {
						rt.pre_dec(var_i)
						continue
					}
					return var_term.dup()
				}
				var_term_ids.array_push(rt.get_property(var_term, 'term_id'))
				rt.post_inc(var_i)
			}
		}
	} else {
		mut var_remaining := rt.new_int(rt.new_int(amount_mutated)).dup()
		mut var_term_max := rt.new_int(rt.new_int(1))
		if amount_mutated > 2 {
			var_term_max = rt.call_function('floor', [rt.call_function('log', [rt.new_int(amount_mutated).dup()])])
		}
		mut var_levels := rt.call_function('array_fill', [rt.new_int(1), var_max_depth.dup(), rt.new_array()])
		{
			mut var_i := rt.new_int(rt.new_int(1))
			for {
				if !(rt.is_true(rt.less_equal(var_i, var_max_depth))) { break }
				if rt.is_true(rt.identical(rt.new_int(1), var_i)) {
					{
						mut var_j := rt.new_int(rt.new_int(1))
						for {
							if !(rt.is_true(rt.new_bool(rt.is_true(rt.less_equal(var_j, var_term_max)) && rt.is_true(rt.greater(var_remaining, rt.new_int(0)))))) { break }
							mut var_term := Class_WC_SmoothGenerator_Generator_Term.generate(true, taxonomy)
							if rt.is_true(rt.call_function('is_wp_error', [var_term.dup()])) {
								if rt.is_true(rt.identical(rt.new_string('term_exists'), rt.call_method(var_term, 'get_error_code', []rt.PhpVal{}))) {
									rt.pre_dec(var_j)
									continue
								}
								return var_term.dup()
							}
							var_term_ids.array_push(rt.get_property(var_term, 'term_id'))
							var_levels.array_get_mut(var_i).array_push(rt.get_property(var_term, 'term_id'))
							rt.pre_dec(var_remaining)
							rt.post_inc(var_j)
						}
					}
				} else {
					{
						mut iter_1 := var_levels.array_get(rt.sub(var_i, rt.new_int(1))).iterator()
						for {
							item_1 := iter_1.next() or { break }
							mut var_term_id := item_1.val
							mut var_tcount := rt.call_function('wp_rand', [rt.new_int(0), var_term_max.dup()])
							{
								mut var_j := rt.new_int(rt.new_int(1))
								for {
									if !(rt.is_true(rt.new_bool(rt.is_true(rt.less_equal(var_j, var_tcount)) && rt.is_true(rt.greater(var_remaining, rt.new_int(0)))))) { break }
									mut var_term := Class_WC_SmoothGenerator_Generator_Term.generate(true, taxonomy, (var_term_id).to_i64())
									if rt.is_true(rt.call_function('is_wp_error', [var_term.dup()])) {
										if rt.is_true(rt.identical(rt.new_string('term_exists'), rt.call_method(var_term, 'get_error_code', []rt.PhpVal{}))) {
											rt.pre_dec(var_j)
											continue
										}
										return var_term.dup()
									}
									var_term_ids.array_push(rt.get_property(var_term, 'term_id'))
									var_levels.array_get_mut(var_i).array_push(rt.get_property(var_term, 'term_id'))
									rt.pre_dec(var_remaining)
									rt.post_inc(var_j)
								}
							}
						}
					}
				}
				if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_i, var_max_depth)) && rt.is_true(rt.greater(var_remaining, rt.new_int(0))))) {
					mut var_i := rt.new_int(rt.new_int(0))
				}
				rt.post_inc(var_i)
			}
		}
	}
	return var_term_ids.dup()
}

struct Class_WC_SmoothGenerator_Generator_Generator {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_smoothgenerator_generator_term() &Class_WC_SmoothGenerator_Generator_Term {
	mut obj := &Class_WC_SmoothGenerator_Generator_Term{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_generator() &Class_WC_SmoothGenerator_Generator_Generator {
	mut obj := &Class_WC_SmoothGenerator_Generator_Generator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wp_error() &Class_WC_SmoothGenerator_Generator_WP_Error {
	mut obj := &Class_WC_SmoothGenerator_Generator_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_SmoothGenerator_Generator_Term) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'generate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return Class_WC_SmoothGenerator_Generator_Term.generate(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'batch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_WC_SmoothGenerator_Generator_Term.batch(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'batch_hierarchical' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_WC_SmoothGenerator_Generator_Term.batch_hierarchical(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_WC_SmoothGenerator_Generator_Term) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Term) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_Generator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_Generator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Generator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_wc_smooth_generator_includes_generator_term_php() {
}
