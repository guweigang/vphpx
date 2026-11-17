module serverx

import os
import embedx
import net.http
import time
import veb

fn test_dispatch_leaves_http_input_parsing_to_php() {
	root := os.join_path(os.temp_dir(), 'vslim_server_raw_input_${os.getpid()}')
	os.mkdir(root) or { panic(err) }
	defer {
		os.rmdir_all(root) or {}
	}
	entry := os.join_path(root, 'index.php')
	os.write_file(entry, '<?php echo implode("|", [$_GET["name"], implode(",", $_GET["tag"]), $_POST["profile"]["role"], $_COOKIE["token"], file_get_contents("php://input")]);') or {
		panic(err)
	}
	mut engine := embedx.new_engine() or { panic(err) }
	defer {
		engine.shutdown()
	}
	mut app := App{
		engine: engine
		config: Config{
			routes: [
				RouteRule{
					match_pattern: '/*'
					mode:          'embed_php'
					root:          root
					entry:         entry
				},
			]
		}
	}
	body := 'profile%5Brole%5D=site%2Badmin'
	mut request := http.Request{
		method: .post
		url:    '/inputs?name=hello+php&tag%5B%5D=a&tag%5B%5D=b'
		data:   body
	}
	request.header.set(.content_type, 'application/x-www-form-urlencoded')
	request.header.set(.cookie, 'token=test%2Bvalue')
	response := veb.render_request[App, Context](mut app, request) or { panic(err) }
	assert response.res.status_code == 200
	assert response.res.body == 'hello php|a,b|site+admin|test+value|${body}'
}

fn test_embed_engine_isolates_consecutive_requests() {
	script := os.norm_path(os.join_path(os.dir(@FILE), '..', '..', 'tests', 'fixtures', 'request.php'))
	mut engine := embedx.new_engine() or { panic(err) }
	defer {
		engine.shutdown()
	}

	first := engine.execute(embedx.Request{
		script_path: script
		method: 'POST'
		uri: '/first?name=one'
		query_string: 'name=one'
		get: {
			'name': 'one'
		}
		server: {
			'REQUEST_METHOD': 'POST'
		}
	}) or { panic(err) }
	assert first.status_code == 202
	assert first.body == 'POST|one'

	second := engine.execute(embedx.Request{
		script_path: script
		method: 'GET'
		uri: '/second?name=two'
		query_string: 'name=two'
		get: {
			'name': 'two'
		}
		server: {
			'REQUEST_METHOD': 'GET'
		}
	}) or { panic(err) }
	assert second.status_code == 202
	assert second.body == 'GET|two'
}

fn test_embed_engine_uses_classic_php_input_parsing_and_header_operations() {
	script := fixture_path('classic.php')
	mut engine := embedx.new_engine() or { panic(err) }
	defer {
		engine.shutdown()
	}
	body := 'profile%5Brole%5D=admin'
	response := engine.execute(embedx.Request{
		script_path: script
		method: 'POST'
		uri: '/classic?user%5Bname%5D=Ada&tags%5B%5D=a&tags%5B%5D=b'
		query_string: 'user%5Bname%5D=Ada&tags%5B%5D=a&tags%5B%5D=b'
		body: body
		content_type: 'application/x-www-form-urlencoded'
		cookie: 'token=abc123'
		server: {
			'VPHP_TEST_VALUE': 'server-value'
		}
	}) or { panic(err) }

	assert response.status_code == 207
	assert response.body == 'Ada|a,b|admin|abc123|server-value|${body.bytes().hex()}'
	assert header_values(response, 'X-Replace') == ['second']
	assert header_values(response, 'X-Multi') == ['one', 'two']
	assert header_values(response, 'X-Remove').len == 0
}

fn test_embed_engine_preserves_binary_request_body() {
	body := 'before\x00after'
	mut engine := embedx.new_engine() or { panic(err) }
	defer {
		engine.shutdown()
	}
	response := engine.execute(embedx.Request{
		script_path: fixture_path('binary.php')
		method: 'POST'
		uri: '/binary'
		body: body
		content_type: 'application/octet-stream'
	}) or { panic(err) }
	assert response.body == body.bytes().hex()
}

fn test_embed_engine_recovers_after_fatal_request() {
	script := fixture_path('fatal.php')
	mut engine := embedx.new_engine() or { panic(err) }
	defer {
		engine.shutdown()
	}

	fatal_response := engine.execute(embedx.Request{
		script_path: script
		uri: '/fatal?mode=fatal'
		query_string: 'mode=fatal'
	}) or { panic(err) }
	assert fatal_response.status_code == 500

	response := engine.execute(embedx.Request{
		script_path: script
		uri: '/healthy'
	}) or { panic(err) }
	assert response.status_code == 200
	assert response.body == 'healthy'
}

fn fixture_path(name string) string {
	return os.norm_path(os.join_path(os.dir(@FILE), '..', '..', 'tests', 'fixtures', name))
}

fn header_values(response embedx.Response, name string) []string {
	mut values := []string{}
	for header in response.headers {
		if header.name.to_lower() == name.to_lower() {
			values << header.value
		}
	}
	return values
}

fn execute_sleep_request(engine &embedx.Engine, script string, done chan bool) {
	response := engine.execute(embedx.Request{
		script_path: script
		uri: '/sleep'
	}) or {
		done <- false
		return
	}
	done <- (response.body == 'done')
}

fn test_embed_engine_executes_requests_across_multiple_lanes() {
	mut engine := embedx.new_engine_with_lanes(4) or { panic(err) }
	defer {
		engine.shutdown()
	}
	done := chan bool{ cap: 4 }
	watch := time.new_stopwatch()
	for _ in 0 .. 4 {
		spawn execute_sleep_request(engine, fixture_path('sleep.php'), done)
	}
	for _ in 0 .. 4 {
		assert <-done
	}
	assert watch.elapsed() < 600 * time.millisecond
}
