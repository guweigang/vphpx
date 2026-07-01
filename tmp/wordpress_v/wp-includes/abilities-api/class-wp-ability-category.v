import rt

struct Class_WP_Ability_Category {
	rt.PhpObjectBase
pub mut:
	slug        string
	label       rt.PhpVal = rt.new_null()
	description rt.PhpVal = rt.new_null()
	meta        rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Ability_Category) construct(slug string, mut var_args Class_array) {
	if slug == '' {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('__', [
			rt.new_string('The ability category slug cannot be empty.'),
		]))))
	}
	this.slug = slug
	mut var_properties := this.prepare_properties(mut var_args)
	{
		mut iter_1 := var_properties.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_property_value := item_1.val
			mut var_property_name := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('property_exists', [
				rt.new_object('WP_Ability_Category', []string{}, &this),
				var_property_name.dup(),
			])))))
			{
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Property "%1$s" is not a valid property for ability category "%2$s". Please check the %3$s class for allowed properties.'),
						]),
						'<code>' + (rt.call_function('esc_html', [var_property_name.dup()])).str() +
							'</code>',
						'<code>' + (rt.call_function('esc_html', [this.slug])).str() + '</code>',
						'<code>' + @STRUCT + '</code>',
					]),
					rt.new_string('6.9.0')])
				continue
			}
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":102,"name":"property_name"}',
				var_property_value.dup())
		}
	}
}

fn (mut this Class_WP_Ability_Category) prepare_properties(mut var_args Class_array) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(var_args.array_get('label'))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.array_get('label').is_string())))))))
	{
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('__', [
			rt.new_string('The ability category properties must contain a `label` string.'),
		]))))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_args.array_get('description'))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.array_get('description').is_string())))))))
	{
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('__', [
			rt.new_string('The ability category properties must contain a `description` string.'),
		]))))
	}
	if rt.is_true(rt.new_bool(var_args.array_isset(rt.new_string('meta'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.array_get('meta').is_array())))))))
	{
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('__', [
			rt.new_string('The ability category properties should provide a valid `meta` array.'),
		]))))
	}
	return rt.new_object('array', []string{}, var_args)
}

fn (mut this Class_WP_Ability_Category) get_slug() string {
	return this.slug
}

fn (mut this Class_WP_Ability_Category) get_label() string {
	return (this.label).str()
}

fn (mut this Class_WP_Ability_Category) get_description() string {
	return (this.description).str()
}

fn (mut this Class_WP_Ability_Category) get_meta() rt.PhpVal {
	return this.meta
}

fn (mut this Class_WP_Ability_Category) magic_wakeup() {
	rt.throw_exception(rt.new_object('LogicException', []string{}, create_logicexception(@STRUCT +
		' should never be unserialized.')))
}

fn (mut this Class_WP_Ability_Category) magic_sleep() {
	rt.throw_exception(rt.new_object('LogicException', []string{}, create_logicexception(@STRUCT +
		' should never be serialized.')))
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_LogicException {
	rt.PhpObjectBase
}

fn create_wp_ability_category(slug string, arg_1 rt.PhpVal) &Class_WP_Ability_Category {
	mut obj := &Class_WP_Ability_Category{
		PhpObjectBase: rt.PhpObjectBase{}
		slug:          ''
		label:         rt.new_null()
		description:   rt.new_null()
		meta:          rt.new_array()
	}
	obj.construct(slug, arg_1)
	return obj
}

fn create_invalidargumentexception() &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_logicexception() &Class_LogicException {
	mut obj := &Class_LogicException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Ability_Category) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'prepare_properties' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.prepare_properties(mut dispatch_arg_0)
		}
		'get_slug' {
			return rt.new_string(this.get_slug())
		}
		'get_label' {
			return rt.new_string(this.get_label())
		}
		'get_description' {
			return rt.new_string(this.get_description())
		}
		'get_meta' {
			return this.get_meta()
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		'__sleep' {
			this.magic_sleep()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Ability_Category) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'slug' { return rt.new_string(this.slug) }
		'label' { return this.label }
		'description' { return this.description }
		'meta' { return this.meta }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Ability_Category) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'slug' {
			this.slug = val.str()
			return true
		}
		'label' {
			this.label = val
			return true
		}
		'description' {
			this.description = val
			return true
		}
		'meta' {
			this.meta = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_LogicException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_LogicException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_LogicException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_abilities_api_class_wp_ability_category_php() {
	// unsupported statement: Stmt_Declare
}
