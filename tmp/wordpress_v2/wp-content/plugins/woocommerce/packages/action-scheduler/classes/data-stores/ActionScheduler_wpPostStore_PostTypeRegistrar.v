import rt

struct Class_ActionScheduler_wpPostStore_PostTypeRegistrar {
	rt.PhpObjectBase
}

fn (mut this Class_ActionScheduler_wpPostStore_PostTypeRegistrar) register() {
	rt.call_function('register_post_type', [
		Class_ActionScheduler_wpPostStore.post_type(),
		this.post_type_args(),
	])
}

fn (mut this Class_ActionScheduler_wpPostStore_PostTypeRegistrar) post_type_args() rt.PhpVal {
	mut var_args := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Scheduled Actions'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Scheduled actions are hooks triggered on a certain date and time.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'public', val: false },
		rt.ArrayItem{ key: 'map_meta_cap', val: true },
		rt.ArrayItem{ key: 'hierarchical', val: false },
		rt.ArrayItem{ key: 'supports', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'title' },
			rt.ArrayItem{ key: none, val: 'editor' },
			rt.ArrayItem{ key: none, val: 'comments' },
		]) },
		rt.ArrayItem{ key: 'rewrite', val: false },
		rt.ArrayItem{ key: 'query_var', val: false },
		rt.ArrayItem{ key: 'can_export', val: true },
		rt.ArrayItem{ key: 'ep_mask', val: rt.get_constant('EP_NONE') },
		rt.ArrayItem{ key: 'labels', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Scheduled Actions'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [
				rt.new_string('Scheduled Action'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'menu_name', val: rt.call_function('_x', [
				rt.new_string('Scheduled Actions'),
				rt.new_string('Admin menu name'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'add_new', val: rt.call_function('__', [
				rt.new_string('Add'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'add_new_item', val: rt.call_function('__', [
				rt.new_string('Add New Scheduled Action'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'edit', val: rt.call_function('__', [
				rt.new_string('Edit'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'edit_item', val: rt.call_function('__', [
				rt.new_string('Edit Scheduled Action'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'new_item', val: rt.call_function('__', [
				rt.new_string('New Scheduled Action'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'view', val: rt.call_function('__', [
				rt.new_string('View Action'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'view_item', val: rt.call_function('__', [
				rt.new_string('View Action'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'search_items', val: rt.call_function('__', [
				rt.new_string('Search Scheduled Actions'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'not_found', val: rt.call_function('__', [
				rt.new_string('No actions found'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'not_found_in_trash', val: rt.call_function('__', [
				rt.new_string('No actions found in trash'),
				rt.new_string('woocommerce'),
			]) },
		]) },
	])
	var_args = rt.call_function('apply_filters', [
		rt.new_string('action_scheduler_post_type_args'),
		var_args.clone(),
	])
	return var_args.clone()
}

fn create_actionscheduler_wppoststore_posttyperegistrar(_args ...rt.PhpVal) &Class_ActionScheduler_wpPostStore_PostTypeRegistrar {
	mut obj := &Class_ActionScheduler_wpPostStore_PostTypeRegistrar{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_wpPostStore_PostTypeRegistrar) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'post_type_args' {
			return this.post_type_args()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_wpPostStore_PostTypeRegistrar) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_wpPostStore_PostTypeRegistrar) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
