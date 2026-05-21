module streamx

import vphp

@[php_method]
pub fn VSlimStreamNdjsonDecoder.decode(stream vphp.PhpValue) vphp.PhpArray {
	return value_subject(stream).ndjson_rows()
}

@[php_method: 'fromOllama']
pub fn VSlimStreamSseEncoder.from_ollama(rows vphp.PhpArray, model string) vphp.PhpArray {
	return encode_ollama_sse_events(rows, model)
}

fn (subject PhpValueSubject) ndjson_rows() vphp.PhpArray {
	mut rows := vphp.PhpArray.new()
	stream_value := subject.value
	stream := stream_value.as_resource() or { return rows }
	defer {
		stream.release()
	}
	if !stream.is_stream() {
		return rows
	}
	for {
		if stream.eof() {
			break
		}
		line_raw := stream.read_line() or { '' }
		line := line_raw.trim_space()
		if line == '' {
			if line_raw == '' && stream.eof() {
				break
			}
			continue
		}
		mut row := vphp.PhpJson.decode_assoc_value(line)
		if !row.is_array() {
			row.release()
			continue
		}
		done := row.bool_at('done', false)
		rows.push_value(row)
		row.release()
		if done {
			break
		}
	}
	if stream.is_stream() {
		_ = stream.close()
	}
	return rows
}

fn encode_ollama_sse_events(rows vphp.PhpArray, model string) vphp.PhpArray {
	mut events := vphp.PhpArray.new()
	mut index := 0
	for row in rows.value_items() {
		piece := ollama_row_piece(row)
		if piece != '' {
			index++
			mut event := vphp.PhpArray.new()
			event.string('id', 'tok-${index}')
			event.string('event', 'token')
			event.int('retry', 1000)
			mut data := vphp.PhpArray.new()
			data.int('index', index)
			data.string('token', piece)
			data.string('model', model)
			event.string('data', data.to_json_with_flags(256))
			events.push(event)
			event.release()
		}
		if row.bool_at('done', false) {
			mut done_event := vphp.PhpArray.new()
			done_event.string('event', 'done')
			mut data := vphp.PhpArray.new()
			data.bool('done', true)
			data.string('model', model)
			done_event.string('data', data.to_json_with_flags(256))
			events.push(done_event)
			done_event.release()
			break
		}
	}
	return events
}

fn ollama_text_chunks(rows vphp.PhpArray) vphp.PhpArray {
	mut chunks := vphp.PhpArray.new()
	for row in rows.value_items() {
		piece := ollama_row_piece(row)
		if piece != '' {
			chunks.push_string(piece)
		}
		if row.bool_at('done', false) {
			break
		}
	}
	return chunks
}

fn ollama_row_piece(row vphp.PhpValue) string {
	message := row.value_at('message')
	content := message.raw_string_at('content', '')
	if content != '' {
		return content
	}
	return row.raw_string_at('response', '')
}
