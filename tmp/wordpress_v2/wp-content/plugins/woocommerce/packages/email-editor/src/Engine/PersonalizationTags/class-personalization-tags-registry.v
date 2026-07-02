import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry {
	rt.PhpObjectBase
pub mut:
	logger rt.PhpVal = rt.new_null()
	tags   rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry) construct(mut var_logger Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger) {
	this.logger = var_logger
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry) initialize() {
	rt.call_method(this.logger, 'info', [
		rt.new_string('Initializing personalization tags registry'),
	])
	rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_editor_register_personalization_tags'),
		rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry',
			[]string{}, &this),
	])
	rt.call_method(this.logger, 'info', [
		rt.new_string('Personalization tags registry initialized'),
		rt.create_array([rt.ArrayItem{ key: 'tags_count', val: this.tags.array_count() }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry) register(mut var_tag Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) {
	mut var_tag_mutated := var_tag
	if this.tags.array_isset(rt.call_method(var_tag_mutated, 'get_token', []rt.PhpVal{})) {
		rt.call_method(this.logger, 'warning', [
			rt.new_string('Personalization tag already registered'),
			rt.create_array([
				rt.ArrayItem{ key: 'token', val: rt.call_method(var_tag_mutated, 'get_token',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'name', val: rt.call_method(var_tag_mutated, 'get_name',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'category', val: rt.call_method(var_tag_mutated, 'get_category',
					[]rt.PhpVal{}) },
			]),
		])
		return
	}
	this.tags.array_set(rt.call_method(var_tag_mutated, 'get_token', []rt.PhpVal{}),
		var_tag_mutated)
	rt.call_method(this.logger, 'debug', [
		rt.new_string('Personalization tag registered'),
		rt.create_array([
			rt.ArrayItem{ key: 'token', val: rt.call_method(var_tag_mutated, 'get_token',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'name', val: rt.call_method(var_tag_mutated, 'get_name',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'category', val: rt.call_method(var_tag_mutated, 'get_category',
				[]rt.PhpVal{}) },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry) unregister(var_token_or_tag rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(var_token_or_tag,
		'Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag')))
	{
		mut var_token := rt.call_method(var_token_or_tag, 'get_token', []rt.PhpVal{})
	} else if rt.is_true(rt.new_bool(var_token_or_tag.clone().is_string())) {
		var_token = var_token_or_tag
	} else {
		rt.call_method(this.logger, 'warning', [
			rt.new_string('Invalid argument type for unregister method'),
			rt.create_array([
				rt.ArrayItem{ key: 'type', val: rt.call_function('gettype', [
					var_token_or_tag.clone()]) },
			]),
		])
		return rt.new_null()
	}
	mut var_tag := if !(this.tags.array_get(var_token)).is_null() {
		this.tags.array_get(var_token)
	} else {
		rt.new_null()
	}
	if rt.is_true(var_tag) {
		this.tags.array_unset(var_token)
		rt.call_method(this.logger, 'debug', [
			rt.new_string('Personalization tag unregistered'),
			rt.create_array([rt.ArrayItem{ key: 'token', val: var_token },
				rt.ArrayItem{ key: 'name', val: rt.call_method(var_tag, 'get_name', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'category', val: rt.call_method(var_tag, 'get_category',
					[]rt.PhpVal{}) }]),
		])
	}
	return var_tag.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry) get_by_token(token string) rt.PhpVal {
	mut token_mutated := token
	return if !(this.tags.array_get(rt.new_string(token_mutated))).is_null() {
		this.tags.array_get(rt.new_string(token_mutated))
	} else {
		rt.new_null()
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry) get_all() rt.PhpVal {
	return this.tags
}

fn create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tags_registry(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
		logger:        rt.new_null()
		tags:          rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'register' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.register(mut dispatch_arg_0)
			return rt.new_null()
		}
		'unregister' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.unregister(dispatch_arg_0)
		}
		'get_by_token' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_by_token(dispatch_arg_0)
		}
		'get_all' {
			return this.get_all()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'logger' { return this.logger }
		'tags' { return this.tags }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'logger' {
			this.logger = val
			return true
		}
		'tags' {
			this.tags = val
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
