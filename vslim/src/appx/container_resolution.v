module appx

import vphp

fn (app &VSlimApp) resolve_container_service(service_id string) !vphp.PhpValue {
	if service_id == '' {
		return error('empty service id')
	}
	unsafe {
		mut mutable_app := &VSlimApp(app)
		if mutable_app.container_ref == nil {
			return error('container is not configured')
		}
		mut container := mutable_app.container_ref
		resolved := container.resolve_or_autowire_class(service_id)!
		if resolved.created {
			app.bind_cached_target_if_supported(resolved.value)
		}
		return resolved.value
	}
}
