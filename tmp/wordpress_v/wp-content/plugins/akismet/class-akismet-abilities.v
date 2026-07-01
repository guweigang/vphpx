import rt

pub fn Class_Akismet_Abilities.category_slug() string {
	return 'akismet'
}

struct Class_Akismet_Abilities {
	rt.PhpObjectBase
}

fn Class_Akismet_Abilities.init() {
	if rt.is_true(rt.call_function('did_action', [
		rt.new_string('wp_abilities_api_categories_init'),
	]))
	{
		Class_Akismet_Abilities.register_category()
	} else {
		rt.call_function('add_action', [
			rt.new_string('wp_abilities_api_categories_init'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'register_category' }]),
		])
	}
	if rt.is_true(rt.call_function('did_action', [rt.new_string('wp_abilities_api_init')])) {
		Class_Akismet_Abilities.register_abilities()
	} else {
		rt.call_function('add_action', [rt.new_string('wp_abilities_api_init'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'register_abilities' }])])
	}
}

fn Class_Akismet_Abilities.register_category() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_register_ability_category'),
	])))))
	{
		return rt.new_null()
	}
	rt.call_function('wp_register_ability_category', [
		Class_Akismet_Abilities.category_slug(),
		rt.create_array([rt.ArrayItem{ key: 'label', val: 'Akismet' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Abilities for spam protection and comment moderation with Akismet.'),
				rt.new_string('akismet'),
			]) }]),
	])
}

fn Class_Akismet_Abilities.register_abilities() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_register_ability'),
	])))))
	{
		return rt.new_null()
	}
	mut var_abilities := [Class_Akismet_Ability_Get_Stats.class(),
		Class_Akismet_Ability_Comment_Check.class()]
	for var_ability_class in var_abilities {
		rt.create_object_dynamically(var_ability_class, []rt.PhpVal{})
	}
}

fn create_akismet_abilities() &Class_Akismet_Abilities {
	mut obj := &Class_Akismet_Abilities{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Akismet_Abilities) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Akismet_Abilities.init()
			return rt.new_null()
		}
		'register_category' {
			Class_Akismet_Abilities.register_category()
			return rt.new_null()
		}
		'register_abilities' {
			Class_Akismet_Abilities.register_abilities()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Akismet_Abilities) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_Abilities) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('Akismet_Abilities', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_akismet_abilities()
		return rt.new_object('Akismet_Abilities', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

pub fn init_wp_content_plugins_akismet_class_akismet_abilities_php() {
	// unsupported statement: Stmt_Declare
	rt.include_file(@DIR + '/abilities/interface-akismet-ability.php', '4')
	rt.include_file(@DIR + '/abilities/class-akismet-ability.php', '4')
	rt.include_file(@DIR + '/abilities/class-akismet-ability-get-stats.php', '4')
	rt.include_file(@DIR + '/abilities/class-akismet-ability-comment-check.php', '4')
}
