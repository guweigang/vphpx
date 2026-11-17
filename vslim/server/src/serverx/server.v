module serverx

import os
import veb
import embedx

pub struct Context {
	veb.Context
}

pub struct App {
pub:
	config Config
	engine &embedx.Engine
}

pub fn start(config_path string) ! {
	config := load_config(config_path)!
	if config.server.extension_path != '' {
		os.setenv('VSLIM_EXTENSION_PATH', config.server.extension_path, true)
	}
	mut engine := embedx.new_engine_with_lanes(config.server.php_lanes)!
	defer {
		engine.shutdown()
	}
	mut app := &App{
		config: config
		engine: engine
	}
	eprintln('[vslim] serving on http://${config.server.host}:${config.server.port} with ${config.server.php_lanes} PHP lane(s)')
	veb.run_at[App, Context](mut app,
		host: config.server.host
		port: config.server.port
		family: .ip
		nr_workers: config.server.workers
	)!
}

pub fn (mut app App) not_found(mut ctx Context) veb.Result {
	return app.dispatch(mut ctx)
}

@['/:path...'; delete; get; head; options; patch; post; put]
pub fn (mut app App) index(mut ctx Context, path string) veb.Result {
	return app.dispatch(mut ctx)
}

fn (mut app App) dispatch(mut ctx Context) veb.Result {
	request_uri := ctx.req.url
	request_path := request_uri.all_before('?')
	target := resolve_target(app.config, request_path) or {
		if err.msg() == 'forbidden' || err.msg() == 'directory listing is disabled' {
			ctx.res.status_code = 403
			return ctx.text('Forbidden')
		}
		ctx.res.status_code = 404
		return ctx.text('Not Found')
	}
	if target.kind == .static_file {
		return serve_static(mut ctx, target.path)
	}

	query_string := if request_uri.contains('?') { request_uri.all_after('?') } else { '' }
	content_type := ctx.req.header.get(.content_type) or { '' }
	cookie := ctx.req.header.get(.cookie) or { '' }
	mut server := build_server_vars(ctx, target, request_uri, query_string)
	server['CONTENT_TYPE'] = content_type
	server['CONTENT_LENGTH'] = ctx.req.data.len.str()
	response := app.engine.execute(embedx.Request{
		script_path: target.path
		method: ctx.req.method.str()
		uri: request_uri
		query_string: query_string
		body: ctx.req.data
		content_type: content_type
		cookie: cookie
		server: server
	}) or {
		eprintln('[vslim] PHP request failed: ${err}')
		ctx.res.status_code = 500
		return ctx.text('Internal Server Error')
	}

	ctx.res.status_code = response.status_code
	for header in response.headers {
		apply_response_header(mut ctx, header)
	}
	return ctx.text(response.body)
}

fn build_server_vars(ctx Context, target Target, request_uri string, query_string string) map[string]string {
	mut server := map[string]string{}
	server['REQUEST_METHOD'] = ctx.req.method.str()
	server['REQUEST_URI'] = request_uri
	server['QUERY_STRING'] = query_string
	server['SCRIPT_FILENAME'] = target.path
	server['SCRIPT_NAME'] = target.script_name
	server['PHP_SELF'] = target.script_name
	server['DOCUMENT_ROOT'] = target.document_root
	server['SERVER_PROTOCOL'] = 'HTTP/1.1'
	server['REMOTE_ADDR'] = ctx.ip()
	if host := ctx.req.header.get(.host) {
		server['HTTP_HOST'] = host
		server['SERVER_NAME'] = host.all_before(':')
		server['SERVER_PORT'] = if host.contains(':') { host.all_after_last(':') } else { '80' }
	}
	for key in ctx.req.header.keys() {
		if value := ctx.req.header.get_custom(key) {
			server['HTTP_' + key.replace('-', '_').to_upper()] = value
		}
	}
	return server
}

fn apply_response_header(mut ctx Context, header embedx.Header) {
	name := header.name.to_lower()
	match name {
		'content-type' {
			ctx.res.header.set_custom('Content-Type', header.value) or {}
		}
		'set-cookie' {
			ctx.res.header.add_custom('Set-Cookie', header.value) or {}
		}
		'location' {
			ctx.res.header.set(.location, header.value)
		}
		else {
			ctx.res.header.set_custom(header.name, header.value) or {}
		}
	}
}

fn serve_static(mut ctx Context, path string) veb.Result {
	extension := os.file_ext(path).to_lower()
	content_type := veb.mime_types[extension] or { 'application/octet-stream' }
	ctx.set_content_type(content_type)
	return ctx.file(path)
}
