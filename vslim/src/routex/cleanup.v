module routex

pub fn release_owned_routes(mut routes []VSlimRoute) {
	for mut route in routes {
		route.release_owned_refs()
	}
}
