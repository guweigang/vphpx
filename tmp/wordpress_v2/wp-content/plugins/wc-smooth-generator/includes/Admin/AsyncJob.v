import rt

struct Class_WC_SmoothGenerator_Admin_AsyncJob {
	rt.PhpObjectBase
pub mut:
	generator_slug rt.PhpVal = rt.new_string('')
	amount         rt.PhpVal = rt.new_int(0)
	args           rt.PhpVal = rt.new_array()
	processed      rt.PhpVal = rt.new_int(0)
	pending        rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_WC_SmoothGenerator_Admin_AsyncJob) construct(mut var_data Class_WC_SmoothGenerator_Admin_array) {
	mut var_data_mutated := var_data
	mut var_defaults := rt.create_array([
		rt.ArrayItem{ key: 'generator_slug', val: this.generator_slug },
		rt.ArrayItem{ key: 'amount', val: this.amount },
		rt.ArrayItem{ key: 'args', val: this.args },
		rt.ArrayItem{ key: 'processed', val: this.processed },
		rt.ArrayItem{ key: 'pending', val: this.pending },
	])
	var_data_mutated = rt.call_function('wp_parse_args', [var_data_mutated, var_defaults.clone()])
	mut list_tmp_1 := var_data_mutated
}

fn create_wc_smoothgenerator_admin_asyncjob(arg_0 rt.PhpVal) &Class_WC_SmoothGenerator_Admin_AsyncJob {
	mut obj := &Class_WC_SmoothGenerator_Admin_AsyncJob{
		PhpObjectBase:  rt.PhpObjectBase{}
		generator_slug: rt.new_string('')
		amount:         rt.new_int(0)
		args:           rt.new_array()
		processed:      rt.new_int(0)
		pending:        rt.new_int(0)
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WC_SmoothGenerator_Admin_AsyncJob) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Admin_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_SmoothGenerator_Admin_AsyncJob) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'generator_slug' { return this.generator_slug }
		'amount' { return this.amount }
		'args' { return this.args }
		'processed' { return this.processed }
		'pending' { return this.pending }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_SmoothGenerator_Admin_AsyncJob) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'generator_slug' {
			this.generator_slug = val
			return true
		}
		'amount' {
			this.amount = val
			return true
		}
		'args' {
			this.args = val
			return true
		}
		'processed' {
			this.processed = val
			return true
		}
		'pending' {
			this.pending = val
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
