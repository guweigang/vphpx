import rt

struct Class_ActionScheduler_wpPostStore_TaxonomyRegistrar {
	rt.PhpObjectBase
}

fn (mut this Class_ActionScheduler_wpPostStore_TaxonomyRegistrar) register() {
	rt.call_function('register_taxonomy', [
		Class_ActionScheduler_wpPostStore.group_taxonomy(),
		Class_ActionScheduler_wpPostStore.post_type(),
		this.taxonomy_args(),
	])
}

fn (mut this Class_ActionScheduler_wpPostStore_TaxonomyRegistrar) taxonomy_args() rt.PhpVal {
	mut var_args := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Action Group'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'public', val: false },
		rt.ArrayItem{ key: 'hierarchical', val: false },
		rt.ArrayItem{ key: 'show_admin_column', val: true },
		rt.ArrayItem{ key: 'query_var', val: false },
		rt.ArrayItem{ key: 'rewrite', val: false },
	])
	var_args = rt.call_function('apply_filters', [
		rt.new_string('action_scheduler_taxonomy_args'),
		var_args.clone(),
	])
	return var_args.clone()
}

fn create_actionscheduler_wppoststore_taxonomyregistrar(_args ...rt.PhpVal) &Class_ActionScheduler_wpPostStore_TaxonomyRegistrar {
	mut obj := &Class_ActionScheduler_wpPostStore_TaxonomyRegistrar{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_wpPostStore_TaxonomyRegistrar) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'taxonomy_args' {
			return this.taxonomy_args()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_wpPostStore_TaxonomyRegistrar) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_wpPostStore_TaxonomyRegistrar) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
