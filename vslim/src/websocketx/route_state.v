module websocketx

import routex
import vphp

pub enum WebSocketRouteFrameAction {
	invalid
	reject_open
	no_route
	dispatch
}

pub struct WebSocketRouteFrame {
pub:
	action  WebSocketRouteFrameAction
	event   string
	conn_id string
	index   int
}

pub fn (frame WebSocketRouteFrame) should_dispatch() bool {
	return frame.action == .dispatch && frame.index >= 0
}

pub fn (frame WebSocketRouteFrame) should_reject_open() bool {
	return frame.action == .reject_open
}

pub fn (frame WebSocketRouteFrame) should_cleanup_after_dispatch() bool {
	return frame.action == .dispatch && frame.event == 'close' && frame.conn_id != ''
}

pub fn select_route_frame(mut conn_routes map[string]int, routes []routex.VSlimRoute, frame vphp.PhpArray) WebSocketRouteFrame {
	event := frame.string_at('event', '').trim_space().to_lower()
	conn_id := frame.string_at('id', '').trim_space()
	if event == '' || conn_id == '' {
		return WebSocketRouteFrame{
			action: .invalid
			event: event
			conn_id: conn_id
			index: -1
		}
	}
	path := routex.normalize_route_path(frame.string_at('path', '/'))
	if event == 'open' {
		idx, matched := routex.route_index_for_path(routes, path)
		if !matched {
			return WebSocketRouteFrame{
				action: .reject_open
				event: event
				conn_id: conn_id
				index: -1
			}
		}
		conn_routes[conn_id] = idx
		return WebSocketRouteFrame{
			action: .dispatch
			event: event
			conn_id: conn_id
			index: idx
		}
	}
	idx := conn_routes[conn_id] or {
		return select_fallback_route_frame(mut conn_routes, routes, event, conn_id, path)
	}
	if idx < 0 || idx >= routes.len {
		conn_routes.delete(conn_id)
		return select_fallback_route_frame(mut conn_routes, routes, event, conn_id, path)
	}
	return WebSocketRouteFrame{
		action: .dispatch
		event: event
		conn_id: conn_id
		index: idx
	}
}

fn select_fallback_route_frame(mut conn_routes map[string]int, routes []routex.VSlimRoute, event string, conn_id string, path string) WebSocketRouteFrame {
	fallback_idx, matched := routex.route_index_for_path(routes, path)
	if !matched {
		return WebSocketRouteFrame{
			action: .no_route
			event: event
			conn_id: conn_id
			index: -1
		}
	}
	conn_routes[conn_id] = fallback_idx
	return WebSocketRouteFrame{
		action: .dispatch
		event: event
		conn_id: conn_id
		index: fallback_idx
	}
}

pub fn finish_route_frame(mut conn_routes map[string]int, frame WebSocketRouteFrame) {
	if frame.should_cleanup_after_dispatch() {
		conn_routes.delete(frame.conn_id)
	}
}
