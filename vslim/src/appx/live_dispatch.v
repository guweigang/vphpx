module appx

import liveviewx
import vphp

fn (mut app VSlimApp) dispatch_live_websocket_handler(handler vphp.PhpValue, event string, frame vphp.PhpArray, conn vphp.PhpObject) vphp.PhpValue {
	return liveviewx.dispatch_live_websocket_handler(mut app.live_ws_sockets, handler, event,
		frame, conn)
}

fn (mut app VSlimApp) bind_live_view(handler vphp.PhpValue) {
	liveviewx.bind_live_view(handler, app.container())
}
