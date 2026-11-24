module containerx

import registrationx
import vphp

// Include services that a callback could access through an earlier PHP reference.
pub fn (c &VSlimContainer) snapshot_services(mut scope registrationx.RegistrationScope) {
	if stored := c.php_registrations() {
		for values in [stored.entries, stored.resolved] {
			for key in values.key_strings() {
				scope.snapshot_service(values.value_at(key))
			}
		}
		return
	}
	for _, value in c.entries {
		scope.snapshot_service(value)
	}
	for _, value in c.resolved {
		scope.snapshot_service(value)
	}
}

fn track_service_state(value vphp.PhpValue) {
	mut scope := registrationx.current_registration_scope() or { return }
	scope.snapshot_service(value)
}
