import rt

struct Class_ActionScheduler_wpPostStore_PostStatusRegistrar {
	rt.PhpObjectBase
}

fn (mut this Class_ActionScheduler_wpPostStore_PostStatusRegistrar) register() {
	rt.call_function('register_post_status', [
		Class_ActionScheduler_Store.status_running(),
		rt.call_function('array_merge', [this.post_status_args(),
			this.post_status_running_labels()]),
	])
	rt.call_function('register_post_status', [
		Class_ActionScheduler_Store.status_failed(),
		rt.call_function('array_merge', [this.post_status_args(),
			this.post_status_failed_labels()]),
	])
}

fn (mut this Class_ActionScheduler_wpPostStore_PostStatusRegistrar) post_status_args() rt.PhpVal {
	mut var_args := {
		'public':                    false
		'exclude_from_search':       false
		'show_in_admin_all_list':    true
		'show_in_admin_status_list': true
	}
	return rt.call_function('apply_filters', [
		rt.new_string('action_scheduler_post_status_args'),
		var_args.dup(),
	])
}

fn (mut this Class_ActionScheduler_wpPostStore_PostStatusRegistrar) post_status_failed_labels() rt.PhpVal {
	mut var_labels := {
		'label':       rt.call_function('_x', [rt.new_string('Failed'),
			rt.new_string('post'), rt.new_string('woocommerce')])
		'label_count': rt.call_function('_n_noop', [
			rt.new_string('Failed <span class="count">(%s)</span>'),
			rt.new_string('Failed <span class="count">(%s)</span>'),
			rt.new_string('woocommerce'),
		])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('action_scheduler_post_status_failed_labels'),
		var_labels.dup(),
	])
}

fn (mut this Class_ActionScheduler_wpPostStore_PostStatusRegistrar) post_status_running_labels() rt.PhpVal {
	mut var_labels := {
		'label':       rt.call_function('_x', [rt.new_string('In-Progress'),
			rt.new_string('post'), rt.new_string('woocommerce')])
		'label_count': rt.call_function('_n_noop', [
			rt.new_string('In-Progress <span class="count">(%s)</span>'),
			rt.new_string('In-Progress <span class="count">(%s)</span>'),
			rt.new_string('woocommerce'),
		])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('action_scheduler_post_status_running_labels'),
		var_labels.dup(),
	])
}

fn create_actionscheduler_wppoststore_poststatusregistrar() &Class_ActionScheduler_wpPostStore_PostStatusRegistrar {
	mut obj := &Class_ActionScheduler_wpPostStore_PostStatusRegistrar{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_wpPostStore_PostStatusRegistrar) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'post_status_args' {
			return this.post_status_args()
		}
		'post_status_failed_labels' {
			return this.post_status_failed_labels()
		}
		'post_status_running_labels' {
			return this.post_status_running_labels()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_wpPostStore_PostStatusRegistrar) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_wpPostStore_PostStatusRegistrar) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_data_stores_actionscheduler_wppoststore_poststatusregistrar_php() {
}
