module main

import os
import json2

// Release builds carry their matching SDK. Source runs use the checkout.
fn prepare_sdk(scratch string) !string {
	$if vphp_bundled ? {
		return unpack_sdk($embed_file('sdk.json').to_string(), scratch)
	} $else {
		runtime := os.join_path(os.dir(os.dir(os.dir(os.real_path(@FILE)))), 'vphp')
		if !os.is_file(os.join_path(runtime, 'v.mod')) {
			return error('VPHP SDK missing; use a bundled release or run bin/vphp from a checkout')
		}
		return runtime
	}
}

fn unpack_sdk(payload string, scratch string) !string {
	files := json2.decode[map[string]string](payload)!
	runtime := os.join_path(scratch, 'sdk', 'vphp')
	for path, contents in files {
		if os.is_abs_path(path) || path.split('/').contains('..') {
			return error('invalid bundled SDK path: ${path}')
		}
		target := os.join_path(runtime, path)
		os.mkdir_all(os.dir(target))!
		os.write_file(target, contents)!
	}
	return runtime
}
