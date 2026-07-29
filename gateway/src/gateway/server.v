module gateway

import os
import veb
import embed

pub struct Context {
	veb.Context
}

pub struct App {
pub:
	config Config
	engine &embed.Engine
}

pub fn start(config_path string) ! {
	config := load_config(config_path)!
	mut engine := embed.new_engine_with_lanes(config.server.php_lanes)!
	defer {
		engine.shutdown()
	}
	mut app := &App{
		config: config
		engine: engine
	}
	if config.server.host != '' && config.server.host != '0.0.0.0' {
		eprintln('[gateway] warning: the current veb fasthttp backend ignores server.host; binding to 0.0.0.0')
	}
	eprintln('[gateway] listening on 0.0.0.0:${config.server.port} with ${config.server.php_lanes} PHP lanes')
	veb.run_at[App, Context](mut app,
		host:       '0.0.0.0'
		port:       config.server.port
		family:     .ip
		nr_workers: config.server.workers
	)!
}

pub fn (mut app App) not_found(mut ctx Context) veb.Result {
	return app.dispatch(mut ctx)
}

@['/:path...'; DELETE; GET; HEAD; OPTIONS; PATCH; POST; PUT]
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
	response := app.engine.execute(embed.Request{
		script_path:  target.path
		method:       ctx.req.method.str()
		uri:          request_uri
		query_string: query_string
		body:         ctx.req.data
		content_type: content_type
		cookie:       cookie
		get:          parse_urlencoded(query_string)
		post:         if content_type.starts_with('application/x-www-form-urlencoded') {
			parse_urlencoded(ctx.req.data)
		} else {
			map[string]string{}
		}
		cookies:      parse_cookies(cookie)
		server:       server
	}) or {
		eprintln('[gateway] PHP request failed: ${err}')
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

fn apply_response_header(mut ctx Context, header embed.Header) {
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
	content := os.read_file(path) or {
		ctx.res.status_code = 404
		return ctx.text('Not Found')
	}
	extension := os.file_ext(path).to_lower()
	content_type := veb.mime_types[extension] or { 'application/octet-stream' }
	ctx.res.header.set_custom('Content-Type', content_type) or {}
	return ctx.text(content)
}
