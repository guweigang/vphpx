module streamx

import vphp

import configx

#include "php_bridge.h"

__global C.vslim__stream__response_ce &C.zend_class_entry
__global C.vslim__stream__ndjsondecoder_ce &C.zend_class_entry
__global C.vslim__stream__sseencoder_ce &C.zend_class_entry
__global C.vslim__stream__ollamaclient_ce &C.zend_class_entry
__global C.vslim__stream__factory_ce &C.zend_class_entry

@[export: 'vslim_stream_response_new_raw']
pub fn vslim_stream_response_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimStreamResponse]()
}
@[export: 'vslim_stream_response_free_raw']
pub fn vslim_stream_response_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimStreamResponse](ptr)
}
@[export: 'vslim_stream_response_cleanup_raw']
pub fn vslim_stream_response_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimStreamResponse(ptr)
        obj.free()
    }
}
@[export: 'vslim_stream_response_get_prop']
pub fn vslim_stream_response_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VSlimStreamResponse(ptr)
        if name == 'streamType' {
            ret.v[string](obj.stream_type)
            return
        }
        if name == 'status' {
            ret.v[i64](i64(obj.status))
            return
        }
        if name == 'contentType' {
            ret.v[string](obj.content_type)
            return
        }
    }
}
@[export: 'vslim_stream_response_set_prop']
pub fn vslim_stream_response_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VSlimStreamResponse(ptr)
        if name == 'streamType' {
            obj.stream_type = arg.get_string()
            return
        }
        if name == 'status' {
            obj.status = int(arg.get_int())
            return
        }
        if name == 'contentType' {
            obj.content_type = arg.get_string()
            return
        }
    }
}
@[export: 'vslim_stream_response_sync_props']
pub fn vslim_stream_response_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimStreamResponse(ptr)
        out.add_property_string('streamType', obj.stream_type)
        out.add_property_long('status', i64(obj.status))
        out.add_property_string('contentType', obj.content_type)
    }
}
@[export: 'vphp_wrap_vslim_stream_response_construct']
pub fn vphp_wrap_vslim_stream_response_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'streamType', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'chunks', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'status', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'contentType', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'headers', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'streamType').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'chunks').value
    arg_2 := php_args.at_named_or_index(2, 'status').as_v[int]()
    arg_3 := php_args.at_named_or_index(3, 'contentType').as_v[string]()
    arg_4 := php_args.at_named_or_index(4, 'headers').value
    res := recv.construct(arg_0, arg_1, arg_2, arg_3, arg_4)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_stream_response_text']
pub fn vphp_wrap_vslim_stream_response_text(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'chunks', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'chunks').value
    res := VSlimStreamResponse.text(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_stream_response_text_with']
pub fn vphp_wrap_vslim_stream_response_text_with(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'chunks', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'status', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'contentType', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'headers', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'chunks').value
    arg_1 := php_args.at_named_or_index(1, 'status').as_v[int]()
    arg_2 := php_args.at_named_or_index(2, 'contentType').as_v[string]()
    arg_3 := php_args.at_named_or_index(3, 'headers').value
    res := VSlimStreamResponse.text_with(arg_0, arg_1, arg_2, arg_3)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_stream_response_sse']
pub fn vphp_wrap_vslim_stream_response_sse(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'events', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'events').value
    res := VSlimStreamResponse.sse(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_stream_response_sse_with']
pub fn vphp_wrap_vslim_stream_response_sse_with(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'events', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'status', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'headers', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'events').value
    arg_1 := php_args.at_named_or_index(1, 'status').as_v[int]()
    arg_2 := php_args.at_named_or_index(2, 'headers').value
    res := VSlimStreamResponse.sse_with(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_stream_response_header']
pub fn vphp_wrap_vslim_stream_response_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.header(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_stream_response_headers']
pub fn vphp_wrap_vslim_stream_response_headers(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.headers()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_vslim_stream_response_stream_type_value']
pub fn vphp_wrap_vslim_stream_response_stream_type_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.stream_type_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_stream_response_content_type_value']
pub fn vphp_wrap_vslim_stream_response_content_type_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.content_type_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_stream_response_has_header']
pub fn vphp_wrap_vslim_stream_response_has_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.has_header(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_stream_response_set_header']
pub fn vphp_wrap_vslim_stream_response_set_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'value').as_v[string]()
    res := recv.set_header(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_stream_response_set_status']
pub fn vphp_wrap_vslim_stream_response_set_status(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'status', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'status').as_v[int]()
    res := recv.set_status(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_stream_response_set_content_type']
pub fn vphp_wrap_vslim_stream_response_set_content_type(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'contentType', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'contentType').as_v[string]()
    res := recv.set_content_type(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_stream_response_set_chunks']
pub fn vphp_wrap_vslim_stream_response_set_chunks(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'chunks', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'chunks').value
    res := recv.set_chunks(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_stream_response_chunks']
pub fn vphp_wrap_vslim_stream_response_chunks(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.chunks()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vslim_stream_response_handlers']
pub fn vslim_stream_response_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_stream_response_get_prop),
        write_handler: voidptr(vslim_stream_response_set_prop),
        sync_handler: voidptr(vslim_stream_response_sync_props),
        new_raw: voidptr(vslim_stream_response_new_raw),
        cleanup_raw: voidptr(vslim_stream_response_cleanup_raw),
        free_raw: voidptr(vslim_stream_response_free_raw)
    )
}
pub fn VSlimStreamResponse.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__stream__response_ce)
}

pub fn VSlimStreamResponse.php_object_handlers() voidptr {
    return vslim_stream_response_handlers()
}

pub fn VSlimStreamResponse.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimStreamResponse](v_ptr, ownership)
}

pub fn (obj &VSlimStreamResponse) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimStreamResponse](obj)
}

pub fn (obj &VSlimStreamResponse) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimStreamResponse](obj)
}

pub fn (obj &VSlimStreamResponse) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimStreamResponse](obj)
}

pub fn (obj &VSlimStreamResponse) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimStreamResponse](obj)
}

pub fn (val VSlimStreamResponse) php_class_name() string {
    return 'VSlim\\Stream\\Response'
}

@[export: 'vslim_stream_ndjson_decoder_new_raw']
pub fn vslim_stream_ndjson_decoder_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimStreamNdjsonDecoder]()
}
@[export: 'vslim_stream_ndjson_decoder_free_raw']
pub fn vslim_stream_ndjson_decoder_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimStreamNdjsonDecoder](ptr)
}
@[export: 'vslim_stream_ndjson_decoder_cleanup_raw']
pub fn vslim_stream_ndjson_decoder_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_stream_ndjson_decoder_get_prop']
pub fn vslim_stream_ndjson_decoder_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_stream_ndjson_decoder_set_prop']
pub fn vslim_stream_ndjson_decoder_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_stream_ndjson_decoder_sync_props']
pub fn vslim_stream_ndjson_decoder_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_stream_ndjson_decoder_decode']
pub fn vphp_wrap_vslim_stream_ndjson_decoder_decode(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'stream', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'stream').value
    res := VSlimStreamNdjsonDecoder.decode(arg_0)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vslim_stream_ndjson_decoder_handlers']
pub fn vslim_stream_ndjson_decoder_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_stream_ndjson_decoder_get_prop),
        write_handler: voidptr(vslim_stream_ndjson_decoder_set_prop),
        sync_handler: voidptr(vslim_stream_ndjson_decoder_sync_props),
        new_raw: voidptr(vslim_stream_ndjson_decoder_new_raw),
        cleanup_raw: voidptr(vslim_stream_ndjson_decoder_cleanup_raw),
        free_raw: voidptr(vslim_stream_ndjson_decoder_free_raw)
    )
}
pub fn VSlimStreamNdjsonDecoder.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__stream__ndjsondecoder_ce)
}

pub fn VSlimStreamNdjsonDecoder.php_object_handlers() voidptr {
    return vslim_stream_ndjson_decoder_handlers()
}

pub fn VSlimStreamNdjsonDecoder.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimStreamNdjsonDecoder](v_ptr, ownership)
}

pub fn (obj &VSlimStreamNdjsonDecoder) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimStreamNdjsonDecoder](obj)
}

pub fn (obj &VSlimStreamNdjsonDecoder) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimStreamNdjsonDecoder](obj)
}

pub fn (obj &VSlimStreamNdjsonDecoder) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimStreamNdjsonDecoder](obj)
}

pub fn (obj &VSlimStreamNdjsonDecoder) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimStreamNdjsonDecoder](obj)
}

pub fn (val VSlimStreamNdjsonDecoder) php_class_name() string {
    return 'VSlim\\Stream\\NdjsonDecoder'
}

@[export: 'vslim_stream_sse_encoder_new_raw']
pub fn vslim_stream_sse_encoder_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimStreamSseEncoder]()
}
@[export: 'vslim_stream_sse_encoder_free_raw']
pub fn vslim_stream_sse_encoder_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimStreamSseEncoder](ptr)
}
@[export: 'vslim_stream_sse_encoder_cleanup_raw']
pub fn vslim_stream_sse_encoder_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_stream_sse_encoder_get_prop']
pub fn vslim_stream_sse_encoder_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_stream_sse_encoder_set_prop']
pub fn vslim_stream_sse_encoder_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_stream_sse_encoder_sync_props']
pub fn vslim_stream_sse_encoder_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_stream_sse_encoder_from_ollama']
pub fn vphp_wrap_vslim_stream_sse_encoder_from_ollama(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'rows', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'model', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'rows').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    arg_1 := php_args.at_named_or_index(1, 'model').as_v[string]()
    res := VSlimStreamSseEncoder.from_ollama(arg_0, arg_1)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vslim_stream_sse_encoder_handlers']
pub fn vslim_stream_sse_encoder_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_stream_sse_encoder_get_prop),
        write_handler: voidptr(vslim_stream_sse_encoder_set_prop),
        sync_handler: voidptr(vslim_stream_sse_encoder_sync_props),
        new_raw: voidptr(vslim_stream_sse_encoder_new_raw),
        cleanup_raw: voidptr(vslim_stream_sse_encoder_cleanup_raw),
        free_raw: voidptr(vslim_stream_sse_encoder_free_raw)
    )
}
pub fn VSlimStreamSseEncoder.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__stream__sseencoder_ce)
}

pub fn VSlimStreamSseEncoder.php_object_handlers() voidptr {
    return vslim_stream_sse_encoder_handlers()
}

pub fn VSlimStreamSseEncoder.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimStreamSseEncoder](v_ptr, ownership)
}

pub fn (obj &VSlimStreamSseEncoder) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimStreamSseEncoder](obj)
}

pub fn (obj &VSlimStreamSseEncoder) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimStreamSseEncoder](obj)
}

pub fn (obj &VSlimStreamSseEncoder) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimStreamSseEncoder](obj)
}

pub fn (obj &VSlimStreamSseEncoder) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimStreamSseEncoder](obj)
}

pub fn (val VSlimStreamSseEncoder) php_class_name() string {
    return 'VSlim\\Stream\\SseEncoder'
}

@[export: 'vslim_stream_ollama_client_new_raw']
pub fn vslim_stream_ollama_client_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimStreamOllamaClient]()
}
@[export: 'vslim_stream_ollama_client_free_raw']
pub fn vslim_stream_ollama_client_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimStreamOllamaClient](ptr)
}
@[export: 'vslim_stream_ollama_client_cleanup_raw']
pub fn vslim_stream_ollama_client_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimStreamOllamaClient(ptr)
        obj.free()
    }
}
@[export: 'vslim_stream_ollama_client_get_prop']
pub fn vslim_stream_ollama_client_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VSlimStreamOllamaClient(ptr)
        if name == 'chatUrl' {
            ret.v[string](obj.chat_url)
            return
        }
        if name == 'defaultModel' {
            ret.v[string](obj.default_model)
            return
        }
        if name == 'apiKey' {
            ret.v[string](obj.api_key)
            return
        }
        if name == 'fixturePath' {
            ret.v[string](obj.fixture_path)
            return
        }
    }
}
@[export: 'vslim_stream_ollama_client_set_prop']
pub fn vslim_stream_ollama_client_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VSlimStreamOllamaClient(ptr)
        if name == 'chatUrl' {
            obj.chat_url = arg.get_string()
            return
        }
        if name == 'defaultModel' {
            obj.default_model = arg.get_string()
            return
        }
        if name == 'apiKey' {
            obj.api_key = arg.get_string()
            return
        }
        if name == 'fixturePath' {
            obj.fixture_path = arg.get_string()
            return
        }
    }
}
@[export: 'vslim_stream_ollama_client_sync_props']
pub fn vslim_stream_ollama_client_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimStreamOllamaClient(ptr)
        out.add_property_string('chatUrl', obj.chat_url)
        out.add_property_string('defaultModel', obj.default_model)
        out.add_property_string('apiKey', obj.api_key)
        out.add_property_string('fixturePath', obj.fixture_path)
    }
}
@[export: 'vphp_wrap_vslim_stream_ollama_client_construct']
pub fn vphp_wrap_vslim_stream_ollama_client_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'chatUrl', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultModel', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'apiKey', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'fixturePath', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'chatUrl').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'defaultModel').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'apiKey').as_v[string]()
    arg_3 := php_args.at_named_or_index(3, 'fixturePath').as_v[string]()
    res := recv.construct(arg_0, arg_1, arg_2, arg_3)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_stream_ollama_client_from_env']
pub fn vphp_wrap_vslim_stream_ollama_client_from_env(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimStreamOllamaClient.from_env()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_stream_ollama_client_from_config']
pub fn vphp_wrap_vslim_stream_ollama_client_from_config(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'config', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &configx.VSlimConfig(php_args.at_named_or_index(0, 'config').raw_obj()) }
    res := VSlimStreamOllamaClient.from_config(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_stream_ollama_client_from_app']
pub fn vphp_wrap_vslim_stream_ollama_client_from_app(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'app', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'app').value
    res := VSlimStreamOllamaClient.from_app(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_stream_ollama_client_from_options']
pub fn vphp_wrap_vslim_stream_ollama_client_from_options(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'options', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'options').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := VSlimStreamOllamaClient.from_options(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_stream_ollama_client_chat_url']
pub fn vphp_wrap_vslim_stream_ollama_client_chat_url(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.chat_url()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_stream_ollama_client_default_model']
pub fn vphp_wrap_vslim_stream_ollama_client_default_model(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.default_model()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_stream_ollama_client_api_key']
pub fn vphp_wrap_vslim_stream_ollama_client_api_key(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.api_key()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_stream_ollama_client_fixture_path']
pub fn vphp_wrap_vslim_stream_ollama_client_fixture_path(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.fixture_path()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_stream_ollama_client_text_response_from_request']
pub fn vphp_wrap_vslim_stream_ollama_client_text_response_from_request(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'requestPayload', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'requestPayload').value
    res := recv.text_response_from_request(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_stream_ollama_client_sse_response_from_request']
pub fn vphp_wrap_vslim_stream_ollama_client_sse_response_from_request(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'requestPayload', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'requestPayload').value
    res := recv.sse_response_from_request(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_stream_ollama_client_payload']
pub fn vphp_wrap_vslim_stream_ollama_client_payload(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'input', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'input').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    res := recv.payload(arg_0)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_stream_ollama_client_payload_from_request']
pub fn vphp_wrap_vslim_stream_ollama_client_payload_from_request(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'requestPayload', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'requestPayload').value
    res := recv.payload_from_request(arg_0)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_stream_ollama_client_open_stream']
pub fn vphp_wrap_vslim_stream_ollama_client_open_stream(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'payload', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'payload').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    res := recv.open_stream(arg_0)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_stream_ollama_client_upstream_plan']
pub fn vphp_wrap_vslim_stream_ollama_client_upstream_plan(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'payload', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'outputMode', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'payload').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    arg_1 := if php_args.has_named_or_index(1, 'outputMode') { php_args.at_named_or_index(1, 'outputMode').as_v[string]() } else { 'sse' }
    res := recv.upstream_plan(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_stream_ollama_client_upstream_text_plan_from_request']
pub fn vphp_wrap_vslim_stream_ollama_client_upstream_text_plan_from_request(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'requestPayload', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'requestPayload').value
    res := recv.upstream_text_plan_from_request(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_stream_ollama_client_upstream_sse_plan_from_request']
pub fn vphp_wrap_vslim_stream_ollama_client_upstream_sse_plan_from_request(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'requestPayload', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'requestPayload').value
    res := recv.upstream_sse_plan_from_request(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_stream_ollama_client_upstream_plan_from_request']
pub fn vphp_wrap_vslim_stream_ollama_client_upstream_plan_from_request(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'requestPayload', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'outputMode', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'requestPayload').value
    arg_1 := if php_args.has_named_or_index(1, 'outputMode') { php_args.at_named_or_index(1, 'outputMode').as_v[string]() } else { 'sse' }
    res := recv.upstream_plan_from_request(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vslim_stream_ollama_client_handlers']
pub fn vslim_stream_ollama_client_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_stream_ollama_client_get_prop),
        write_handler: voidptr(vslim_stream_ollama_client_set_prop),
        sync_handler: voidptr(vslim_stream_ollama_client_sync_props),
        new_raw: voidptr(vslim_stream_ollama_client_new_raw),
        cleanup_raw: voidptr(vslim_stream_ollama_client_cleanup_raw),
        free_raw: voidptr(vslim_stream_ollama_client_free_raw)
    )
}
pub fn VSlimStreamOllamaClient.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__stream__ollamaclient_ce)
}

pub fn VSlimStreamOllamaClient.php_object_handlers() voidptr {
    return vslim_stream_ollama_client_handlers()
}

pub fn VSlimStreamOllamaClient.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimStreamOllamaClient](v_ptr, ownership)
}

pub fn (obj &VSlimStreamOllamaClient) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimStreamOllamaClient](obj)
}

pub fn (obj &VSlimStreamOllamaClient) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimStreamOllamaClient](obj)
}

pub fn (obj &VSlimStreamOllamaClient) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimStreamOllamaClient](obj)
}

pub fn (obj &VSlimStreamOllamaClient) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimStreamOllamaClient](obj)
}

pub fn (val VSlimStreamOllamaClient) php_class_name() string {
    return 'VSlim\\Stream\\OllamaClient'
}

@[export: 'vslim_stream_factory_new_raw']
pub fn vslim_stream_factory_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimStreamFactory]()
}
@[export: 'vslim_stream_factory_free_raw']
pub fn vslim_stream_factory_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimStreamFactory](ptr)
}
@[export: 'vslim_stream_factory_cleanup_raw']
pub fn vslim_stream_factory_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_stream_factory_get_prop']
pub fn vslim_stream_factory_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_stream_factory_set_prop']
pub fn vslim_stream_factory_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_stream_factory_sync_props']
pub fn vslim_stream_factory_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_stream_factory_text']
pub fn vphp_wrap_vslim_stream_factory_text(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'chunks', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'chunks').value
    res := VSlimStreamFactory.text(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_stream_factory_text_with']
pub fn vphp_wrap_vslim_stream_factory_text_with(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'chunks', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'status', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'contentType', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'headers', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'chunks').value
    arg_1 := php_args.at_named_or_index(1, 'status').as_v[int]()
    arg_2 := php_args.at_named_or_index(2, 'contentType').as_v[string]()
    arg_3 := php_args.at_named_or_index(3, 'headers').array() or {
        vphp.throw_exception('argument 3 must be array', 0)
        return
    }
    res := VSlimStreamFactory.text_with(arg_0, arg_1, arg_2, arg_3)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_stream_factory_sse']
pub fn vphp_wrap_vslim_stream_factory_sse(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'events', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'events').value
    res := VSlimStreamFactory.sse(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_stream_factory_sse_with']
pub fn vphp_wrap_vslim_stream_factory_sse_with(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'events', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'status', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'headers', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'events').value
    arg_1 := php_args.at_named_or_index(1, 'status').as_v[int]()
    arg_2 := php_args.at_named_or_index(2, 'headers').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return
    }
    res := VSlimStreamFactory.sse_with(arg_0, arg_1, arg_2)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_stream_factory_dispatch_sse']
pub fn vphp_wrap_vslim_stream_factory_dispatch_sse(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'events', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'status', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'headers', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'batchSize', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'delayMs', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'events').value
    arg_1 := php_args.at_named_or_index(1, 'status').as_v[int]()
    arg_2 := php_args.at_named_or_index(2, 'headers').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return
    }
    arg_3 := if php_args.has_named_or_index(3, 'batchSize') { php_args.at_named_or_index(3, 'batchSize').as_v[int]() } else { 1 }
    arg_4 := if php_args.has_named_or_index(4, 'delayMs') { php_args.at_named_or_index(4, 'delayMs').as_v[int]() } else { 0 }
    res := VSlimStreamFactory.dispatch_sse(arg_0, arg_1, arg_2, arg_3, arg_4)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_stream_factory_dispatch_response']
pub fn vphp_wrap_vslim_stream_factory_dispatch_response(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'response', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'batchSize', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'delayMs', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'response').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    arg_1 := if php_args.has_named_or_index(1, 'batchSize') { php_args.at_named_or_index(1, 'batchSize').as_v[int]() } else { 1 }
    arg_2 := if php_args.has_named_or_index(2, 'delayMs') { php_args.at_named_or_index(2, 'delayMs').as_v[int]() } else { 0 }
    res := VSlimStreamFactory.dispatch_response(arg_0, arg_1, arg_2)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_stream_factory_ollama_text']
pub fn vphp_wrap_vslim_stream_factory_ollama_text(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'requestPayload', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'requestPayload').value
    res := VSlimStreamFactory.ollama_text(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_stream_factory_ollama_text_with']
pub fn vphp_wrap_vslim_stream_factory_ollama_text_with(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'requestPayload', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'options', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'requestPayload').value
    arg_1 := php_args.at_named_or_index(1, 'options').array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return
    }
    res := VSlimStreamFactory.ollama_text_with(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_stream_factory_ollama_sse']
pub fn vphp_wrap_vslim_stream_factory_ollama_sse(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'requestPayload', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'requestPayload').value
    res := VSlimStreamFactory.ollama_sse(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_stream_factory_ollama_sse_with']
pub fn vphp_wrap_vslim_stream_factory_ollama_sse_with(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'requestPayload', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'options', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'requestPayload').value
    arg_1 := php_args.at_named_or_index(1, 'options').array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return
    }
    res := VSlimStreamFactory.ollama_sse_with(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vslim_stream_factory_handlers']
pub fn vslim_stream_factory_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_stream_factory_get_prop),
        write_handler: voidptr(vslim_stream_factory_set_prop),
        sync_handler: voidptr(vslim_stream_factory_sync_props),
        new_raw: voidptr(vslim_stream_factory_new_raw),
        cleanup_raw: voidptr(vslim_stream_factory_cleanup_raw),
        free_raw: voidptr(vslim_stream_factory_free_raw)
    )
}
pub fn VSlimStreamFactory.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__stream__factory_ce)
}

pub fn VSlimStreamFactory.php_object_handlers() voidptr {
    return vslim_stream_factory_handlers()
}

pub fn VSlimStreamFactory.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimStreamFactory](v_ptr, ownership)
}

pub fn (obj &VSlimStreamFactory) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimStreamFactory](obj)
}

pub fn (obj &VSlimStreamFactory) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimStreamFactory](obj)
}

pub fn (obj &VSlimStreamFactory) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimStreamFactory](obj)
}

pub fn (obj &VSlimStreamFactory) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimStreamFactory](obj)
}

pub fn (val VSlimStreamFactory) php_class_name() string {
    return 'VSlim\\Stream\\Factory'
}

