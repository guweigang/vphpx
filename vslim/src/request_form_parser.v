module main

import net.urllib

struct VslimMultipartFile {
	filename     string
	content_type string
	data         string
}

struct VslimLineSegmentIndexes {
mut:
	start int
	end   int
}

fn parse_urlencoded_form(body string) map[string]string {
	mut form := map[string]string{}
	if body.match_glob('{*}') {
		form['json'] = body
		return form
	}
	for word in body.split('&') {
		kv := word.split_nth('=', 2)
		if kv.len != 2 {
			continue
		}
		key := urllib.query_unescape(kv[0]) or { continue }
		val := urllib.query_unescape(kv[1]) or { continue }
		form[key] = val
	}
	return form
}

fn parse_multipart_form_data(body string, boundary string) (map[string]string, []VslimMultipartFile) {
	mut form := map[string]string{}
	mut files := []VslimMultipartFile{}
	sections := body.split(boundary)
	if sections.len < 3 {
		return form, files
	}
	fields := sections#[1..sections.len - 1]
	mut line_segments := []VslimLineSegmentIndexes{cap: 100}
	for field in fields {
		line_segments.clear()
		mut line_idx, mut line_start := 0, 0
		for cidx, c in field {
			if line_idx >= 6 {
				break
			}
			if c == `\n` {
				line_segments << VslimLineSegmentIndexes{line_start, cidx}
				line_start = cidx + 1
				line_idx++
			}
		}
		line_segments << VslimLineSegmentIndexes{line_start, field.len}
		if line_segments.len < 2 {
			continue
		}
		line1 := field#[line_segments[1].start..line_segments[1].end]
		line2 := if line_segments.len == 2 {
			''
		} else {
			field#[line_segments[2].start..line_segments[2].end]
		}
		disposition := parse_multipart_disposition(line1.trim_space())
		name := disposition['name'] or { continue }
		if filename := disposition['filename'] {
			if line_segments.len < 5 {
				continue
			}
			if !line2.to_lower().starts_with('content-type:') {
				continue
			}
			content_type := line2.split_nth(':', 2)[1].trim_space()
			data := field[line_segments[4].start..field.len - 4]
			files << VslimMultipartFile{
				filename:     filename
				content_type: content_type
				data:         data
			}
			continue
		}
		if line_segments.len < 4 {
			continue
		}
		form[name] = field[line_segments[3].start..field.len - 4]
	}
	return form, files
}

fn parse_multipart_disposition(line string) map[string]string {
	mut data := map[string]string{}
	for word in line.split(';') {
		kv := word.split_nth('=', 2)
		if kv.len != 2 {
			continue
		}
		key, value := kv[0].to_lower().trim_left(' \t'), kv[1]
		if value.starts_with('"') && value.ends_with('"') {
			data[key] = value[1..value.len - 1]
		} else {
			data[key] = value
		}
	}
	return data
}
