import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.note_name() string {
	return 'wc-admin-orders-milestone'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.last_order_milestone_option_key() string {
	return 'woocommerce_admin_last_orders_milestone'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.process_orders_milestone_hook() string {
	return 'wc_admin_process_orders_milestone'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones {
	rt.PhpObjectBase
pub mut:
	allowed_statuses rt.PhpVal = rt.new_array()
	orders_count     rt.PhpVal = rt.new_null()
	milestones       rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones) construct() {
	this.allowed_statuses = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_order_milestone_statuses'),
		this.allowed_statuses,
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_after_register_post_type'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'init' },
		]),
	])
	rt.call_function('register_deactivation_hook', [rt.get_constant('WC_PLUGIN_FILE'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'clear_scheduled_event' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones) init() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.process_orders_milestone_hook(),
	])))))
	{
		rt.call_function('wp_schedule_event', [rt.call_function('time', []rt.PhpVal{}),
			rt.new_string('hourly'),
			Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.process_orders_milestone_hook()])
	}
	rt.call_function('add_action', [rt.new_string('wc_admin_installed'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'backfill_last_milestone' },
		])])
	rt.call_function('add_action', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.process_orders_milestone_hook(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'possibly_add_note' },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones) clear_scheduled_event() {
	rt.call_function('wp_clear_scheduled_hook', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.process_orders_milestone_hook(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones) get_orders_count(no_cache bool) rt.PhpVal {
	if var_no_cache || this.orders_count.is_null() {
		mut var_status_counts := rt.call_function('array_map', [
			rt.new_string('wc_orders_count'),
			this.allowed_statuses,
		])
		this.orders_count = rt.call_function('array_sum', [var_status_counts.clone()])
	}
	return this.orders_count
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones) backfill_last_milestone() {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.are_milestones_enabled())))) {
		return
	}
	this.set_last_milestone(this.get_current_milestone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones) get_last_milestone() rt.PhpVal {
	return rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.last_order_milestone_option_key(),
		rt.new_int(0),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones) set_last_milestone(var_milestone rt.PhpVal) {
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.last_order_milestone_option_key(),
		var_milestone.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones) get_current_milestone() rt.PhpVal {
	mut var_milestone_reached := rt.new_int(0)
	mut var_orders_count := this.get_orders_count(false)
	mut iter_1 := this.milestones.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_milestone := item_1.val
		if rt.is_true(rt.less_equal(var_milestone, var_orders_count)) {
			var_milestone_reached = var_milestone
		}
	}
	return var_milestone_reached.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.get_note_title_for_milestone(var_milestone rt.PhpVal) string {
	mut switch_val_1 := var_milestone
	if rt.is_true(rt.equal(switch_val_1, rt.new_int(1))) {
		return (rt.call_function('__', [rt.new_string('First order received'),
			rt.new_string('woocommerce')])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(10)))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_int(100)))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_int(250)))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_int(500)))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_int(1000)))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_int(5000)))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_int(10000)))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_int(500000)))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_int(1000000))) {
		return (rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Congratulations on processing %s orders!'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('wc_format_decimal', [
				var_milestone.clone(),
			]),
		])).str()
	} else {
		return ''
	}
	return ''
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.get_note_content_for_milestone(var_milestone rt.PhpVal) string {
	mut switch_val_2 := var_milestone
	if rt.is_true(rt.equal(switch_val_2, rt.new_int(1))) {
		return (rt.call_function('__', [
			rt.new_string('Congratulations on getting your first order! Now is a great time to learn how to manage your orders.'),
			rt.new_string('woocommerce'),
		])).str()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(10))) {
		return (rt.call_function('__', [
			rt.new_string("You've hit the 10 orders milestone! Look at you go. Browse some WooCommerce success stories for inspiration."),
			rt.new_string('woocommerce'),
		])).str()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(100)))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_int(250)))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_int(500)))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_int(1000)))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_int(5000)))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_int(10000)))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_int(500000)))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_int(1000000))) {
		return (rt.call_function('__', [
			rt.new_string('Another order milestone! Take a look at your Orders Report to review your orders to date.'),
			rt.new_string('woocommerce'),
		])).str()
	} else {
		return ''
	}
	return ''
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.get_note_action_for_milestone(var_milestone rt.PhpVal) rt.PhpVal {
	mut switch_val_3 := var_milestone
	if rt.is_true(rt.equal(switch_val_3, rt.new_int(1))) {
		return rt.create_array([rt.ArrayItem{ key: 'name', val: 'learn-more' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Learn more'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{
				key: 'query'
				val: 'https://woocommerce.com/document/managing-orders/?utm_source=inbox&utm_medium=product'
			}])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_int(10))) {
		return rt.create_array([rt.ArrayItem{ key: 'name', val: 'browse' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Browse'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{
				key: 'query'
				val: 'https://woocommerce.com/success-stories/?utm_source=inbox&utm_medium=product'
			}])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_int(100)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(250)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(500)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(1000)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(5000)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(10000)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(500000)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(1000000))) {
		return rt.create_array([rt.ArrayItem{ key: 'name', val: 'review-orders' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Review your orders'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'query', val: '?page=wc-admin&path=/analytics/orders' }])
	} else {
		return rt.create_array([rt.ArrayItem{ key: 'name', val: '' },
			rt.ArrayItem{ key: 'label', val: '' }, rt.ArrayItem{ key: 'query', val: '' }])
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones) are_milestones_enabled() rt.PhpVal {
	mut var_milestone_notes_enabled := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_order_milestones_enabled'),
		rt.new_bool(true),
	])
	return var_milestone_notes_enabled.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.get_note() bool {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_0 :=
		iife_temp_0.get_note_by_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.note_name())
	mut var_note := iife_result_0
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note)))) {
		return false
	}
	mut var_content_data := rt.call_method(var_note, 'get_content_data', []rt.PhpVal{})
	if !(!(rt.get_property(var_content_data, 'current_milestone')).is_null()) {
		return false
	}
	return (Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.get_note_by_milestone(rt.get_property(var_content_data,
		'current_milestone'))).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.get_note_by_milestone(var_current_milestone rt.PhpVal) rt.PhpVal {
	mut var_current_milestone_mutated := var_current_milestone
	mut var_content_data := rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'current_milestone', val: var_current_milestone_mutated },
	]))
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	rt.call_method(var_note, 'set_title', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.get_note_title_for_milestone(var_current_milestone_mutated.clone()),
	])
	rt.call_method(var_note, 'set_content', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.get_note_content_for_milestone(var_current_milestone_mutated.clone()),
	])
	rt.call_method(var_note, 'set_content_data', [var_content_data.clone()])
	rt.call_method(var_note, 'set_type', [
		Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational(),
	])
	rt.call_method(var_note, 'set_name', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.note_name(),
	])
	rt.call_method(var_note, 'set_source', [rt.new_string('woocommerce-admin')])
	mut var_note_action :=
		Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.get_note_action_for_milestone(var_current_milestone_mutated.clone())
	rt.call_method(var_note, 'add_action', [var_note_action.array_get(rt.new_string('name')),
		var_note_action.array_get(rt.new_string('label')), var_note_action.array_get(rt.new_string('query'))])
	return var_note.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones) can_be_added() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.are_milestones_enabled())))) {
		return false
	}
	mut var_last_milestone := this.get_last_milestone()
	mut var_current_milestone := this.get_current_milestone()
	if rt.is_true(rt.less_equal(var_current_milestone, var_last_milestone)) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones) possibly_add_note() {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones{}
	mut iife_result_1 := iife_temp_1.can_be_added()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1)))) {
		return
	}
	mut var_current_milestone := this.get_current_milestone()
	this.set_last_milestone(var_current_milestone.clone())
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_2 :=
		iife_temp_2.delete_notes_with_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.note_name())
	mut var_note := this.get_note_by_milestone(var_current_milestone.clone())
	rt.call_method(var_note, 'save', []rt.PhpVal{})
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_ordermilestones() &Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones{
		PhpObjectBase:    rt.PhpObjectBase{}
		allowed_statuses: rt.new_array()
		orders_count:     rt.new_null()
		milestones:       rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_notes_notes(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_note(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Note {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Note{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'clear_scheduled_event' {
			this.clear_scheduled_event()
			return rt.new_null()
		}
		'get_orders_count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_orders_count(dispatch_arg_0)
		}
		'backfill_last_milestone' {
			this.backfill_last_milestone()
			return rt.new_null()
		}
		'get_last_milestone' {
			return this.get_last_milestone()
		}
		'set_last_milestone' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_last_milestone(dispatch_arg_0)
			return rt.new_null()
		}
		'get_current_milestone' {
			return this.get_current_milestone()
		}
		'get_note_title_for_milestone' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.get_note_title_for_milestone(dispatch_arg_0))
		}
		'get_note_content_for_milestone' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.get_note_content_for_milestone(dispatch_arg_0))
		}
		'get_note_action_for_milestone' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.get_note_action_for_milestone(dispatch_arg_0)
		}
		'are_milestones_enabled' {
			return this.are_milestones_enabled()
		}
		'get_note' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.get_note())
		}
		'get_note_by_milestone' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.get_note_by_milestone(dispatch_arg_0)
		}
		'can_be_added' {
			return rt.new_bool(this.can_be_added())
		}
		'possibly_add_note' {
			this.possibly_add_note()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'allowed_statuses' { return this.allowed_statuses }
		'orders_count' { return this.orders_count }
		'milestones' { return this.milestones }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'allowed_statuses' {
			this.allowed_statuses = val
			return true
		}
		'orders_count' {
			this.orders_count = val
			return true
		}
		'milestones' {
			this.milestones = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
