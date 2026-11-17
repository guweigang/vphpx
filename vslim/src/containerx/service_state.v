module containerx

import registrationx
import vphp

// Include services that a callback could access through an earlier PHP reference.
pub fn (c &VSlimContainer) snapshot_services(mut scope registrationx.RegistrationScope) {
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
