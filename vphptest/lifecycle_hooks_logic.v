module main

import vphp as _

__global (
	lifecycle_hook_events         []string
	lifecycle_module_startups     int
	lifecycle_request_startups    int
	lifecycle_request_shutdowns   int
	lifecycle_module_shutdowns    int
)

fn record_lifecycle_event(name string) {
	unsafe {
		lifecycle_hook_events << name
	}
}

@[export: 'vphp_ext_startup']
fn vphp_ext_startup() {
	unsafe {
		lifecycle_module_startups++
	}
	record_lifecycle_event('user_module_startup')
}

@[export: 'vphp_ext_shutdown']
fn vphp_ext_shutdown() {
	unsafe {
		lifecycle_module_shutdowns++
	}
	record_lifecycle_event('user_module_shutdown')
}

@[export: 'vphp_ext_request_startup']
fn vphp_ext_request_startup() {
	unsafe {
		lifecycle_request_startups++
	}
	record_lifecycle_event('user_request_startup')
}

@[export: 'vphp_ext_request_shutdown']
fn vphp_ext_request_shutdown() {
	unsafe {
		lifecycle_request_shutdowns++
	}
	record_lifecycle_event('user_request_shutdown')
}

@[php_function]
fn v_lifecycle_hook_state() string {
	unsafe {
		return 'module_startups=${lifecycle_module_startups};request_startups=${lifecycle_request_startups};request_shutdowns=${lifecycle_request_shutdowns};module_shutdowns=${lifecycle_module_shutdowns};events=${lifecycle_hook_events.join(",")}'
	}
}
