import rt

interface FulfillmentsDataStoreInterface {
	read_fulfillments(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_entity_type := rt.new_null()
	mut var_entity_id := rt.new_null()
}
