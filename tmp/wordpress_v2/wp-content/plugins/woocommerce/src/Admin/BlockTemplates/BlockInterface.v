import rt

interface BlockInterface {
	get_name() rt.PhpVal
	get_id() rt.PhpVal
	get_order() rt.PhpVal
	set_order(rt.PhpVal) rt.PhpVal
	get_attributes() rt.PhpVal
	set_attributes(rt.PhpVal) rt.PhpVal
	set_attribute(rt.PhpVal, rt.PhpVal) rt.PhpVal
	get_parent() rt.PhpVal
	get_root_template() rt.PhpVal
	remove() rt.PhpVal
	is_detached() rt.PhpVal
	add_hide_condition(rt.PhpVal) rt.PhpVal
	remove_hide_condition(rt.PhpVal) rt.PhpVal
	get_hide_conditions() rt.PhpVal
	add_disable_condition(rt.PhpVal) rt.PhpVal
	remove_disable_condition(rt.PhpVal) rt.PhpVal
	get_disable_conditions() rt.PhpVal
	get_formatted_template() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_order := rt.new_null()
	mut var_attributes := rt.new_null()
	mut var_key := rt.new_null()
	mut var_value := rt.new_null()
	mut var_expression := rt.new_null()
}
