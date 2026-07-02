import rt

struct Class_ActionScheduler_Schedule_Deprecated {
	rt.PhpObjectBase
}

fn (mut this Class_ActionScheduler_Schedule_Deprecated) next(mut var_after Class_?DateTime) rt.PhpVal {
	if !rt.is_true(var_after) {
	mut var_return_value := this.get_date()
	mut var_replacement_method := rt.new_string('get_date()')
	} else {
	var_return_value = this.get_next(rt.new_object('?DateTime', []string{}, var_after))
	var_replacement_method = rt.new_string('get_next( $after )')
	}
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('3.0.0'), rt.new_string(@STRUCT + '::' + (var_replacement_method).str())])
	return var_return_value.clone()
}

fn create_actionscheduler_schedule_deprecated(_args ...rt.PhpVal) &Class_ActionScheduler_Schedule_Deprecated {
	mut obj := &Class_ActionScheduler_Schedule_Deprecated{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_Schedule_Deprecated) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'next' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?DateTime](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.next(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_Schedule_Deprecated) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Schedule_Deprecated) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
