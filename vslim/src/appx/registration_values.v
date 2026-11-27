module appx

import vphp

enum RegistrationValues {
	routes
	resource_missing
	websockets
	before
	middleware
	after
	group_before
	group_middle
	group_after
}

fn (bucket RegistrationValues) state_key(index int) string {
	return 'registration:${bucket}:${index}'
}

fn (app &VSlimApp) registration_value(bucket RegistrationValues, index int, fallback vphp.PhpValue) vphp.PhpValue {
	if state := vphp.owned_object_php_state(app) {
		if value := state.find(bucket.state_key(index)) {
			return value
		}
	}
	return fallback
}

fn (app &VSlimApp) store_registration_value(bucket RegistrationValues, index int, value vphp.PhpValue) vphp.PhpValue {
	if state := vphp.owned_object_php_state(app) {
		state.set_value(bucket.state_key(index), value)
		return vphp.PhpValue.invalid()
	}
	return value.retain()
}

fn move_registration_values(state vphp.PhpArray, bucket RegistrationValues, mut values []vphp.PhpValue) {
	for index, mut value in values {
		if value.is_valid() {
			state.set_value(bucket.state_key(index), value)
			value.release()
		}
	}
}

fn remove_registration_values(state vphp.PhpArray, removed vphp.PhpArray, bucket RegistrationValues, start int, end int) {
	for index in start .. end {
		key := bucket.state_key(index)
		if value := state.find(key) {
			removed.push(value)
			state.remove(key)
		}
	}
}
