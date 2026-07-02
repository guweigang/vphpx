import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_taxonomy := rt.new_null()
	mut var_messages := rt.new_array()
	var_messages.array_set('_item', rt.create_array([rt.ArrayItem{ key: 0, val: '' },
		rt.ArrayItem{ key: 1, val: rt.call_function('__', [rt.new_string('Item added.')]) },
		rt.ArrayItem{ key: 2, val: rt.call_function('__', [rt.new_string('Item deleted.')]) },
		rt.ArrayItem{ key: 3, val: rt.call_function('__', [rt.new_string('Item updated.')]) },
		rt.ArrayItem{ key: 4, val: rt.call_function('__', [rt.new_string('Item not added.')]) },
		rt.ArrayItem{ key: 5, val: rt.call_function('__', [rt.new_string('Item not updated.')]) },
		rt.ArrayItem{ key: 6, val: rt.call_function('__', [rt.new_string('Items deleted.')]) }]))
	var_messages.array_set('category', rt.create_array([rt.ArrayItem{ key: 0, val: '' },
		rt.ArrayItem{ key: 1, val: rt.call_function('__', [
			rt.new_string('Category added.'),
		]) }, rt.ArrayItem{ key: 2, val: rt.call_function('__', [
			rt.new_string('Category deleted.'),
		]) }, rt.ArrayItem{ key: 3, val: rt.call_function('__', [
			rt.new_string('Category updated.'),
		]) }, rt.ArrayItem{ key: 4, val: rt.call_function('__', [
			rt.new_string('Category not added.'),
		]) }, rt.ArrayItem{ key: 5, val: rt.call_function('__', [
			rt.new_string('Category not updated.'),
		]) }, rt.ArrayItem{ key: 6, val: rt.call_function('__', [
			rt.new_string('Categories deleted.'),
		]) }]))
	var_messages.array_set('post_tag', rt.create_array([rt.ArrayItem{ key: 0, val: '' },
		rt.ArrayItem{ key: 1, val: rt.call_function('__', [rt.new_string('Tag added.')]) },
		rt.ArrayItem{ key: 2, val: rt.call_function('__', [rt.new_string('Tag deleted.')]) },
		rt.ArrayItem{ key: 3, val: rt.call_function('__', [rt.new_string('Tag updated.')]) },
		rt.ArrayItem{ key: 4, val: rt.call_function('__', [rt.new_string('Tag not added.')]) },
		rt.ArrayItem{ key: 5, val: rt.call_function('__', [rt.new_string('Tag not updated.')]) },
		rt.ArrayItem{ key: 6, val: rt.call_function('__', [rt.new_string('Tags deleted.')]) }]))
	var_messages = rt.call_function('apply_filters', [
		rt.new_string('term_updated_messages'),
		var_messages.clone(),
	])
	mut var_message := rt.new_bool(false)
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('message'))
		&& rt.is_true(rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('message'))).to_i64())) {
		mut var_msg :=
			rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('message'))).to_i64())
		if var_messages.array_get(var_taxonomy).array_isset(var_msg) {
			var_message = var_messages.array_get(var_taxonomy).array_get(var_msg)
		} else if !(var_messages.array_isset(var_taxonomy))
			&& var_messages.array_get(rt.new_string('_item')).array_isset(var_msg) {
			var_message = var_messages.array_get(rt.new_string('_item')).array_get(var_msg)
		}
	}
}
