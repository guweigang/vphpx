module httpx

import vphp

#include "php_bridge.h"

__global C.vslim__vhttpd__request_ce &C.zend_class_entry
__global C.vslim__psr7__stream_ce &C.zend_class_entry
__global C.vslim__psr7__uploadedfile_ce &C.zend_class_entry
__global C.vslim__psr7__response_ce &C.zend_class_entry
__global C.vslim__psr7__uri_ce &C.zend_class_entry
__global C.vslim__psr7__request_ce &C.zend_class_entry
__global C.vslim__psr7__serverrequest_ce &C.zend_class_entry
__global C.vslim__psr17__responsefactory_ce &C.zend_class_entry
__global C.vslim__psr17__requestfactory_ce &C.zend_class_entry
__global C.vslim__psr17__streamfactory_ce &C.zend_class_entry
__global C.vslim__psr17__uploadedfilefactory_ce &C.zend_class_entry
__global C.vslim__psr17__urifactory_ce &C.zend_class_entry
__global C.vslim__psr17__serverrequestfactory_ce &C.zend_class_entry
__global C.vslim__psr18__clientexception_ce &C.zend_class_entry
__global C.vslim__psr18__requestexception_ce &C.zend_class_entry
__global C.vslim__psr18__networkexception_ce &C.zend_class_entry
__global C.vslim__psr18__client_ce &C.zend_class_entry
__global C.vslim__psr7adapter_ce &C.zend_class_entry
__global C.vslim__vhttpd__response_ce &C.zend_class_entry

@[export: 'VSlimRequest_new_raw']
pub fn vslimrequest_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimRequest]()
}
@[export: 'VSlimRequest_free_raw']
pub fn vslimrequest_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimRequest](ptr)
}
@[export: 'VSlimRequest_cleanup_raw']
pub fn vslimrequest_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimRequest(ptr)
        obj.free()
    }
}
@[export: 'VSlimRequest_get_prop']
pub fn vslimrequest_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VSlimRequest(ptr)
        if name == 'method' {
            ret.v[string](obj.method)
            return
        }
        if name == 'rawPath' {
            ret.v[string](obj.raw_path)
            return
        }
        if name == 'body' {
            ret.v[string](obj.body)
            return
        }
        if name == 'scheme' {
            ret.v[string](obj.scheme)
            return
        }
        if name == 'host' {
            ret.v[string](obj.host)
            return
        }
        if name == 'port' {
            ret.v[string](obj.port)
            return
        }
        if name == 'protocolVersion' {
            ret.v[string](obj.protocol_version)
            return
        }
        if name == 'remoteAddr' {
            ret.v[string](obj.remote_addr)
            return
        }
    }
}
@[export: 'VSlimRequest_set_prop']
pub fn vslimrequest_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VSlimRequest(ptr)
        if name == 'method' {
            obj.method = arg.get_string()
            return
        }
        if name == 'rawPath' {
            obj.raw_path = arg.get_string()
            return
        }
        if name == 'body' {
            obj.body = arg.get_string()
            return
        }
        if name == 'scheme' {
            obj.scheme = arg.get_string()
            return
        }
        if name == 'host' {
            obj.host = arg.get_string()
            return
        }
        if name == 'port' {
            obj.port = arg.get_string()
            return
        }
        if name == 'protocolVersion' {
            obj.protocol_version = arg.get_string()
            return
        }
        if name == 'remoteAddr' {
            obj.remote_addr = arg.get_string()
            return
        }
    }
}
@[export: 'VSlimRequest_sync_props']
pub fn vslimrequest_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimRequest(ptr)
        out.add_property_string('method', obj.method)
        out.add_property_string('rawPath', obj.raw_path)
        out.add_property_string('body', obj.body)
        out.add_property_string('scheme', obj.scheme)
        out.add_property_string('host', obj.host)
        out.add_property_string('port', obj.port)
        out.add_property_string('protocolVersion', obj.protocol_version)
        out.add_property_string('remoteAddr', obj.remote_addr)
    }
}
@[export: 'vphp_wrap_VSlimRequest_construct']
pub fn vphp_wrap_vslimrequest_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'method', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'rawPath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'body', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'method').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'rawPath').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'body').as_v[string]()
    res := recv.construct(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_str']
pub fn vphp_wrap_vslimrequest_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.str()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_set_query']
pub fn vphp_wrap_vslimrequest_set_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'query', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'query').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.set_query(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_method']
pub fn vphp_wrap_vslimrequest_set_method(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'method', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'method').as_v[string]()
    res := recv.set_method(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_target']
pub fn vphp_wrap_vslimrequest_set_target(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'rawPath', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'rawPath').as_v[string]()
    res := recv.set_target(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_path_value']
pub fn vphp_wrap_vslimrequest_path_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.path_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_query_string_value']
pub fn vphp_wrap_vslimrequest_query_string_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.query_string_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_set_body']
pub fn vphp_wrap_vslimrequest_set_body(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'body', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'body').as_v[string]()
    res := recv.set_body(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_scheme']
pub fn vphp_wrap_vslimrequest_set_scheme(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'scheme', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'scheme').as_v[string]()
    res := recv.set_scheme(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_host']
pub fn vphp_wrap_vslimrequest_set_host(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'host', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'host').as_v[string]()
    res := recv.set_host(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_port']
pub fn vphp_wrap_vslimrequest_set_port(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'port', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'port').as_v[string]()
    res := recv.set_port(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_protocol_version']
pub fn vphp_wrap_vslimrequest_set_protocol_version(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'protocolVersion', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'protocolVersion').as_v[string]()
    res := recv.set_protocol_version(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_remote_addr']
pub fn vphp_wrap_vslimrequest_set_remote_addr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'remoteAddr', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'remoteAddr').as_v[string]()
    res := recv.set_remote_addr(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_headers']
pub fn vphp_wrap_vslimrequest_set_headers(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'headers', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'headers').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.set_headers(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_cookies']
pub fn vphp_wrap_vslimrequest_set_cookies(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'cookies', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'cookies').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.set_cookies(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_attributes']
pub fn vphp_wrap_vslimrequest_set_attributes(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'attributes', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'attributes').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.set_attributes(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_server']
pub fn vphp_wrap_vslimrequest_set_server(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'server', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'server').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.set_server(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_uploaded_files']
pub fn vphp_wrap_vslimrequest_set_uploaded_files(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'uploadedFiles', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'uploadedFiles').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.set_uploaded_files(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_params']
pub fn vphp_wrap_vslimrequest_set_params(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'params', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'params').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.set_params(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_query']
pub fn vphp_wrap_vslimrequest_query(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    res := recv.query(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_query_params']
pub fn vphp_wrap_vslimrequest_query_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.query_params()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_has_query']
pub fn vphp_wrap_vslimrequest_has_query(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    res := recv.has_query(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_input']
pub fn vphp_wrap_vslimrequest_input(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    res := recv.input(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_input_or']
pub fn vphp_wrap_vslimrequest_input_or(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := if php_args.has_named_or_index(1, 'defaultValue') { php_args.at_named_or_index(1, 'defaultValue').as_v[string]() } else { '' }
    res := recv.input_or(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_has_input']
pub fn vphp_wrap_vslimrequest_has_input(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    res := recv.has_input(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_all_inputs']
pub fn vphp_wrap_vslimrequest_all_inputs(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.all_inputs()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_parsed_body']
pub fn vphp_wrap_vslimrequest_parsed_body(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.parsed_body()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_body_format']
pub fn vphp_wrap_vslimrequest_body_format(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.body_format()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_is_json_body']
pub fn vphp_wrap_vslimrequest_is_json_body(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.is_json_body()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_is_form_body']
pub fn vphp_wrap_vslimrequest_is_form_body(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.is_form_body()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_is_multipart_body']
pub fn vphp_wrap_vslimrequest_is_multipart_body(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.is_multipart_body()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_json_body']
pub fn vphp_wrap_vslimrequest_json_body(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.json_body()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_form_body']
pub fn vphp_wrap_vslimrequest_form_body(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.form_body()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_multipart_body']
pub fn vphp_wrap_vslimrequest_multipart_body(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.multipart_body()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_parse_error']
pub fn vphp_wrap_vslimrequest_parse_error(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.parse_error()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_query_all']
pub fn vphp_wrap_vslimrequest_query_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.query_all()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_header']
pub fn vphp_wrap_vslimrequest_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.header(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_headers']
pub fn vphp_wrap_vslimrequest_headers(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.headers()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_has_header']
pub fn vphp_wrap_vslimrequest_has_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.has_header(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_content_type']
pub fn vphp_wrap_vslimrequest_content_type(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.content_type()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_request_id']
pub fn vphp_wrap_vslimrequest_request_id(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.request_id()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_trace_id']
pub fn vphp_wrap_vslimrequest_trace_id(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.trace_id()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_cookie']
pub fn vphp_wrap_vslimrequest_cookie(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.cookie(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_cookies']
pub fn vphp_wrap_vslimrequest_cookies(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.cookies()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_has_cookie']
pub fn vphp_wrap_vslimrequest_has_cookie(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.has_cookie(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_param']
pub fn vphp_wrap_vslimrequest_param(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.param(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_route_params']
pub fn vphp_wrap_vslimrequest_route_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.route_params()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_has_param']
pub fn vphp_wrap_vslimrequest_has_param(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.has_param(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_attribute']
pub fn vphp_wrap_vslimrequest_attribute(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.attribute(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_attributes']
pub fn vphp_wrap_vslimrequest_attributes(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.attributes()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_has_attribute']
pub fn vphp_wrap_vslimrequest_has_attribute(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.has_attribute(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_server_value']
pub fn vphp_wrap_vslimrequest_server_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.server_value(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_server_params']
pub fn vphp_wrap_vslimrequest_server_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.server_params()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_has_server']
pub fn vphp_wrap_vslimrequest_has_server(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.has_server(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_uploaded_file_count']
pub fn vphp_wrap_vslimrequest_uploaded_file_count(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.uploaded_file_count()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_VSlimRequest_uploaded_files']
pub fn vphp_wrap_vslimrequest_uploaded_files(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.uploaded_files()
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_has_uploaded_files']
pub fn vphp_wrap_vslimrequest_has_uploaded_files(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.has_uploaded_files()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_is_secure']
pub fn vphp_wrap_vslimrequest_is_secure(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.is_secure()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_headers_all']
pub fn vphp_wrap_vslimrequest_headers_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.headers_all()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_cookies_all']
pub fn vphp_wrap_vslimrequest_cookies_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.cookies_all()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_params_all']
pub fn vphp_wrap_vslimrequest_params_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.params_all()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_attributes_all']
pub fn vphp_wrap_vslimrequest_attributes_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.attributes_all()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_server_all']
pub fn vphp_wrap_vslimrequest_server_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.server_all()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_uploaded_files_all']
pub fn vphp_wrap_vslimrequest_uploaded_files_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.uploaded_files_all()
    ctx.return().v[[]string](res)
}
@[export: 'VSlimRequest_handlers']
pub fn vslimrequest_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimrequest_get_prop),
        write_handler: voidptr(vslimrequest_set_prop),
        sync_handler: voidptr(vslimrequest_sync_props),
        new_raw: voidptr(vslimrequest_new_raw),
        cleanup_raw: voidptr(vslimrequest_cleanup_raw),
        free_raw: voidptr(vslimrequest_free_raw)
    )
}
pub fn VSlimRequest.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__vhttpd__request_ce)
}

pub fn VSlimRequest.php_object_handlers() voidptr {
    return vslimrequest_handlers()
}

pub fn VSlimRequest.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimRequest](v_ptr, ownership)
}

pub fn (obj &VSlimRequest) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimRequest](obj)
}

pub fn (obj &VSlimRequest) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimRequest](obj)
}

pub fn (obj &VSlimRequest) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimRequest](obj)
}

pub fn (obj &VSlimRequest) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimRequest](obj)
}

@[export: 'VSlimPsr7Stream_new_raw']
pub fn vslimpsr7stream_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr7Stream]()
}
@[export: 'VSlimPsr7Stream_free_raw']
pub fn vslimpsr7stream_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr7Stream](ptr)
}
@[export: 'VSlimPsr7Stream_cleanup_raw']
pub fn vslimpsr7stream_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr7Stream_get_prop']
pub fn vslimpsr7stream_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VSlimPsr7Stream(ptr)
        if name == 'content' {
            ret.v[string](obj.content)
            return
        }
        if name == 'position' {
            ret.v[i64](i64(obj.position))
            return
        }
        if name == 'detached' {
            ret.v[bool](obj.detached)
            return
        }
    }
}
@[export: 'VSlimPsr7Stream_set_prop']
pub fn vslimpsr7stream_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VSlimPsr7Stream(ptr)
        if name == 'content' {
            obj.content = arg.get_string()
            return
        }
        if name == 'position' {
            obj.position = int(arg.get_int())
            return
        }
        if name == 'detached' {
            obj.detached = arg.get_bool()
            return
        }
    }
}
@[export: 'VSlimPsr7Stream_sync_props']
pub fn vslimpsr7stream_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimPsr7Stream(ptr)
        out.add_property_string('content', obj.content)
        out.add_property_long('position', i64(obj.position))
        out.add_property_bool('detached', obj.detached)
    }
}
@[export: 'vphp_wrap_VSlimPsr7Stream_construct']
pub fn vphp_wrap_vslimpsr7stream_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'defaultContent', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := if php_args.has_named_or_index(0, 'defaultContent') { php_args.at_named_or_index(0, 'defaultContent').as_v[string]() } else { '' }
    res := recv.construct(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_str']
pub fn vphp_wrap_vslimpsr7stream_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.str()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_close']
pub fn vphp_wrap_vslimpsr7stream_close(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    recv.close()
}
@[export: 'vphp_wrap_VSlimPsr7Stream_detach']
pub fn vphp_wrap_vslimpsr7stream_detach(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.detach()
    ctx.return().v[vphp.PhpNull](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_get_size']
pub fn vphp_wrap_vslimpsr7stream_get_size(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    ctx.return().from_option[int](fn [recv] () ?int {
        return recv.get_size()
    })
}
@[export: 'vphp_wrap_VSlimPsr7Stream_tell']
pub fn vphp_wrap_vslimpsr7stream_tell(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.tell()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_eof']
pub fn vphp_wrap_vslimpsr7stream_eof(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.eof()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_is_seekable']
pub fn vphp_wrap_vslimpsr7stream_is_seekable(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.is_seekable()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_seek']
pub fn vphp_wrap_vslimpsr7stream_seek(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'offset', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultWhence', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'offset').value
    arg_1 := php_args.at_named_or_index(1, 'defaultWhence').value
    recv.seek(arg_0, arg_1)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_rewind']
pub fn vphp_wrap_vslimpsr7stream_rewind(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    recv.rewind()
}
@[export: 'vphp_wrap_VSlimPsr7Stream_is_writable']
pub fn vphp_wrap_vslimpsr7stream_is_writable(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.is_writable()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_write']
pub fn vphp_wrap_vslimpsr7stream_write(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'chunk', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'chunk').value
    res := recv.write(arg_0)
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_is_readable']
pub fn vphp_wrap_vslimpsr7stream_is_readable(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.is_readable()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_read']
pub fn vphp_wrap_vslimpsr7stream_read(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'length', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'length').value
    res := recv.read(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_get_contents']
pub fn vphp_wrap_vslimpsr7stream_get_contents(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_contents()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_get_metadata']
pub fn vphp_wrap_vslimpsr7stream_get_metadata(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'defaultKey', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := if php_args.has_named_or_index(0, 'defaultKey') { ?vphp.PhpValue(php_args.at_named_or_index(0, 'defaultKey').value) } else { none }
    res := recv.get_metadata(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'VSlimPsr7Stream_handlers']
pub fn vslimpsr7stream_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr7stream_get_prop),
        write_handler: voidptr(vslimpsr7stream_set_prop),
        sync_handler: voidptr(vslimpsr7stream_sync_props),
        new_raw: voidptr(vslimpsr7stream_new_raw),
        cleanup_raw: voidptr(vslimpsr7stream_cleanup_raw),
        free_raw: voidptr(vslimpsr7stream_free_raw)
    )
}
pub fn VSlimPsr7Stream.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr7__stream_ce)
}

pub fn VSlimPsr7Stream.php_object_handlers() voidptr {
    return vslimpsr7stream_handlers()
}

pub fn VSlimPsr7Stream.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr7Stream](v_ptr, ownership)
}

pub fn (obj &VSlimPsr7Stream) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr7Stream](obj)
}

pub fn (obj &VSlimPsr7Stream) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr7Stream](obj)
}

pub fn (obj &VSlimPsr7Stream) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr7Stream](obj)
}

pub fn (obj &VSlimPsr7Stream) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr7Stream](obj)
}

@[export: 'VSlimPsr7UploadedFile_new_raw']
pub fn vslimpsr7uploadedfile_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr7UploadedFile]()
}
@[export: 'VSlimPsr7UploadedFile_free_raw']
pub fn vslimpsr7uploadedfile_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr7UploadedFile](ptr)
}
@[export: 'VSlimPsr7UploadedFile_cleanup_raw']
pub fn vslimpsr7uploadedfile_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimPsr7UploadedFile(ptr)
        obj.cleanup()
    }
}
@[export: 'VSlimPsr7UploadedFile_get_prop']
pub fn vslimpsr7uploadedfile_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VSlimPsr7UploadedFile(ptr)
        if name == 'moved' {
            ret.v[bool](obj.moved)
            return
        }
    }
}
@[export: 'VSlimPsr7UploadedFile_set_prop']
pub fn vslimpsr7uploadedfile_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VSlimPsr7UploadedFile(ptr)
        if name == 'moved' {
            obj.moved = arg.get_bool()
            return
        }
    }
}
@[export: 'VSlimPsr7UploadedFile_sync_props']
pub fn vslimpsr7uploadedfile_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimPsr7UploadedFile(ptr)
        out.add_property_bool('moved', obj.moved)
    }
}
@[export: 'vphp_wrap_VSlimPsr7UploadedFile_construct']
pub fn vphp_wrap_vslimpsr7uploadedfile_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7UploadedFile(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'defaultStream', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultSize', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'defaultError', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'defaultClientFilename', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'defaultClientMediaType', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'defaultStream').value
    arg_1 := if php_args.has_named_or_index(1, 'defaultSize') { php_args.at_named_or_index(1, 'defaultSize').as_v_opt[int]() } else { none }
    arg_2 := php_args.at_named_or_index(2, 'defaultError').as_v[int]()
    arg_3 := if php_args.has_named_or_index(3, 'defaultClientFilename') { php_args.at_named_or_index(3, 'defaultClientFilename').as_v_opt[string]() } else { none }
    arg_4 := if php_args.has_named_or_index(4, 'defaultClientMediaType') { php_args.at_named_or_index(4, 'defaultClientMediaType').as_v_opt[string]() } else { none }
    res := recv.construct(arg_0, arg_1, arg_2, arg_3, arg_4)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7UploadedFile_get_stream']
pub fn vphp_wrap_vslimpsr7uploadedfile_get_stream(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7UploadedFile(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_stream()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7UploadedFile_move_to']
pub fn vphp_wrap_vslimpsr7uploadedfile_move_to(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7UploadedFile(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'targetPath', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'targetPath').value
    recv.move_to(arg_0)
}
@[export: 'vphp_wrap_VSlimPsr7UploadedFile_get_size']
pub fn vphp_wrap_vslimpsr7uploadedfile_get_size(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7UploadedFile(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    ctx.return().from_option[int](fn [recv] () ?int {
        return recv.get_size()
    })
}
@[export: 'vphp_wrap_VSlimPsr7UploadedFile_get_error']
pub fn vphp_wrap_vslimpsr7uploadedfile_get_error(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7UploadedFile(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_error()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_VSlimPsr7UploadedFile_get_client_filename']
pub fn vphp_wrap_vslimpsr7uploadedfile_get_client_filename(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7UploadedFile(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    ctx.return().from_option[string](fn [recv] () ?string {
        return recv.get_client_filename()
    })
}
@[export: 'vphp_wrap_VSlimPsr7UploadedFile_get_client_media_type']
pub fn vphp_wrap_vslimpsr7uploadedfile_get_client_media_type(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7UploadedFile(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    ctx.return().from_option[string](fn [recv] () ?string {
        return recv.get_client_media_type()
    })
}
@[export: 'vphp_wrap_VSlimPsr7UploadedFile_str']
pub fn vphp_wrap_vslimpsr7uploadedfile_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7UploadedFile(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.str()
    ctx.return().v[string](res)
}
@[export: 'VSlimPsr7UploadedFile_handlers']
pub fn vslimpsr7uploadedfile_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr7uploadedfile_get_prop),
        write_handler: voidptr(vslimpsr7uploadedfile_set_prop),
        sync_handler: voidptr(vslimpsr7uploadedfile_sync_props),
        new_raw: voidptr(vslimpsr7uploadedfile_new_raw),
        cleanup_raw: voidptr(vslimpsr7uploadedfile_cleanup_raw),
        free_raw: voidptr(vslimpsr7uploadedfile_free_raw)
    )
}
pub fn VSlimPsr7UploadedFile.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr7__uploadedfile_ce)
}

pub fn VSlimPsr7UploadedFile.php_object_handlers() voidptr {
    return vslimpsr7uploadedfile_handlers()
}

pub fn VSlimPsr7UploadedFile.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr7UploadedFile](v_ptr, ownership)
}

pub fn (obj &VSlimPsr7UploadedFile) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr7UploadedFile](obj)
}

pub fn (obj &VSlimPsr7UploadedFile) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr7UploadedFile](obj)
}

pub fn (obj &VSlimPsr7UploadedFile) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr7UploadedFile](obj)
}

pub fn (obj &VSlimPsr7UploadedFile) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr7UploadedFile](obj)
}

@[export: 'VSlimPsr7Response_new_raw']
pub fn vslimpsr7response_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr7Response]()
}
@[export: 'VSlimPsr7Response_free_raw']
pub fn vslimpsr7response_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr7Response](ptr)
}
@[export: 'VSlimPsr7Response_cleanup_raw']
pub fn vslimpsr7response_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimPsr7Response(ptr)
        obj.cleanup()
    }
}
@[export: 'VSlimPsr7Response_get_prop']
pub fn vslimpsr7response_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VSlimPsr7Response(ptr)
        if name == 'status' {
            ret.v[i64](i64(obj.status))
            return
        }
    }
}
@[export: 'VSlimPsr7Response_set_prop']
pub fn vslimpsr7response_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VSlimPsr7Response(ptr)
        if name == 'status' {
            obj.status = int(arg.get_int())
            return
        }
    }
}
@[export: 'VSlimPsr7Response_sync_props']
pub fn vslimpsr7response_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimPsr7Response(ptr)
        out.add_property_long('status', i64(obj.status))
    }
}
@[export: 'vphp_wrap_VSlimPsr7Response_construct']
pub fn vphp_wrap_vslimpsr7response_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'defaultStatus', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultReasonPhrase', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := if php_args.has_named_or_index(0, 'defaultStatus') { php_args.at_named_or_index(0, 'defaultStatus').as_v[int]() } else { 200 }
    arg_1 := if php_args.has_named_or_index(1, 'defaultReasonPhrase') { php_args.at_named_or_index(1, 'defaultReasonPhrase').as_v[string]() } else { '' }
    res := recv.construct(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_get_protocol_version']
pub fn vphp_wrap_vslimpsr7response_get_protocol_version(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_protocol_version()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_with_protocol_version']
pub fn vphp_wrap_vslimpsr7response_with_protocol_version(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'version', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'version').value
    res := recv.with_protocol_version(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_get_headers']
pub fn vphp_wrap_vslimpsr7response_get_headers(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_headers()
    ctx.return().v[map[string][]string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_has_header']
pub fn vphp_wrap_vslimpsr7response_has_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    res := recv.has_header(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_get_header']
pub fn vphp_wrap_vslimpsr7response_get_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    res := recv.get_header(arg_0)
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_get_header_line']
pub fn vphp_wrap_vslimpsr7response_get_header_line(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    res := recv.get_header_line(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_with_header']
pub fn vphp_wrap_vslimpsr7response_with_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    arg_1 := php_args.at_named_or_index(1, 'value').value
    res := recv.with_header(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_with_added_header']
pub fn vphp_wrap_vslimpsr7response_with_added_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    arg_1 := php_args.at_named_or_index(1, 'value').value
    res := recv.with_added_header(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_without_header']
pub fn vphp_wrap_vslimpsr7response_without_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    res := recv.without_header(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_get_body']
pub fn vphp_wrap_vslimpsr7response_get_body(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_body()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_with_body']
pub fn vphp_wrap_vslimpsr7response_with_body(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'body', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'body').value
    res := recv.with_body(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_get_status_code']
pub fn vphp_wrap_vslimpsr7response_get_status_code(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_status_code()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_with_status']
pub fn vphp_wrap_vslimpsr7response_with_status(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'code', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultReasonPhrase', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'code').value
    arg_1 := php_args.at_named_or_index(1, 'defaultReasonPhrase').value
    res := recv.with_status(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_get_reason_phrase']
pub fn vphp_wrap_vslimpsr7response_get_reason_phrase(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_reason_phrase()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_set_cookie_full']
pub fn vphp_wrap_vslimpsr7response_set_cookie_full(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'path', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'domain', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'maxAge', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 5, name: 'secure', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 6, name: 'httpOnly', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 7, name: 'sameSite', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'value').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'path').as_v[string]()
    arg_3 := php_args.at_named_or_index(3, 'domain').as_v[string]()
    arg_4 := php_args.at_named_or_index(4, 'maxAge').as_v[int]()
    arg_5 := php_args.at_named_or_index(5, 'secure').as_v[bool]()
    arg_6 := php_args.at_named_or_index(6, 'httpOnly').as_v[bool]()
    arg_7 := php_args.at_named_or_index(7, 'sameSite').as_v[string]()
    res := recv.set_cookie_full(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_delete_cookie']
pub fn vphp_wrap_vslimpsr7response_delete_cookie(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.delete_cookie(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_str']
pub fn vphp_wrap_vslimpsr7response_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.str()
    ctx.return().v[string](res)
}
@[export: 'VSlimPsr7Response_handlers']
pub fn vslimpsr7response_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr7response_get_prop),
        write_handler: voidptr(vslimpsr7response_set_prop),
        sync_handler: voidptr(vslimpsr7response_sync_props),
        new_raw: voidptr(vslimpsr7response_new_raw),
        cleanup_raw: voidptr(vslimpsr7response_cleanup_raw),
        free_raw: voidptr(vslimpsr7response_free_raw)
    )
}
pub fn VSlimPsr7Response.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr7__response_ce)
}

pub fn VSlimPsr7Response.php_object_handlers() voidptr {
    return vslimpsr7response_handlers()
}

pub fn VSlimPsr7Response.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr7Response](v_ptr, ownership)
}

pub fn (obj &VSlimPsr7Response) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr7Response](obj)
}

pub fn (obj &VSlimPsr7Response) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr7Response](obj)
}

pub fn (obj &VSlimPsr7Response) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr7Response](obj)
}

pub fn (obj &VSlimPsr7Response) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr7Response](obj)
}

@[export: 'VSlimPsr7Uri_new_raw']
pub fn vslimpsr7uri_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr7Uri]()
}
@[export: 'VSlimPsr7Uri_free_raw']
pub fn vslimpsr7uri_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr7Uri](ptr)
}
@[export: 'VSlimPsr7Uri_cleanup_raw']
pub fn vslimpsr7uri_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr7Uri_get_prop']
pub fn vslimpsr7uri_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VSlimPsr7Uri(ptr)
        if name == 'scheme' {
            ret.v[string](obj.scheme)
            return
        }
        if name == 'user' {
            ret.v[string](obj.user)
            return
        }
        if name == 'password' {
            ret.v[string](obj.password)
            return
        }
        if name == 'host' {
            ret.v[string](obj.host)
            return
        }
        if name == 'port' {
            ret.v[i64](i64(obj.port))
            return
        }
        if name == 'path' {
            ret.v[string](obj.path)
            return
        }
        if name == 'query' {
            ret.v[string](obj.query)
            return
        }
        if name == 'fragment' {
            ret.v[string](obj.fragment)
            return
        }
    }
}
@[export: 'VSlimPsr7Uri_set_prop']
pub fn vslimpsr7uri_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VSlimPsr7Uri(ptr)
        if name == 'scheme' {
            obj.scheme = arg.get_string()
            return
        }
        if name == 'user' {
            obj.user = arg.get_string()
            return
        }
        if name == 'password' {
            obj.password = arg.get_string()
            return
        }
        if name == 'host' {
            obj.host = arg.get_string()
            return
        }
        if name == 'port' {
            obj.port = int(arg.get_int())
            return
        }
        if name == 'path' {
            obj.path = arg.get_string()
            return
        }
        if name == 'query' {
            obj.query = arg.get_string()
            return
        }
        if name == 'fragment' {
            obj.fragment = arg.get_string()
            return
        }
    }
}
@[export: 'VSlimPsr7Uri_sync_props']
pub fn vslimpsr7uri_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimPsr7Uri(ptr)
        out.add_property_string('scheme', obj.scheme)
        out.add_property_string('user', obj.user)
        out.add_property_string('password', obj.password)
        out.add_property_string('host', obj.host)
        out.add_property_long('port', i64(obj.port))
        out.add_property_string('path', obj.path)
        out.add_property_string('query', obj.query)
        out.add_property_string('fragment', obj.fragment)
    }
}
@[export: 'vphp_wrap_VSlimPsr7Uri_construct']
pub fn vphp_wrap_vslimpsr7uri_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'defaultUri', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := if php_args.has_named_or_index(0, 'defaultUri') { php_args.at_named_or_index(0, 'defaultUri').as_v[string]() } else { '' }
    res := recv.construct(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_str']
pub fn vphp_wrap_vslimpsr7uri_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.str()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_get_scheme']
pub fn vphp_wrap_vslimpsr7uri_get_scheme(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_scheme()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_get_authority']
pub fn vphp_wrap_vslimpsr7uri_get_authority(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_authority()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_get_user_info']
pub fn vphp_wrap_vslimpsr7uri_get_user_info(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_user_info()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_get_host']
pub fn vphp_wrap_vslimpsr7uri_get_host(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_host()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_get_port']
pub fn vphp_wrap_vslimpsr7uri_get_port(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    ctx.return().from_option[int](fn [recv] () ?int {
        return recv.get_port()
    })
}
@[export: 'vphp_wrap_VSlimPsr7Uri_get_path']
pub fn vphp_wrap_vslimpsr7uri_get_path(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_path()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_get_query']
pub fn vphp_wrap_vslimpsr7uri_get_query(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_query()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_get_fragment']
pub fn vphp_wrap_vslimpsr7uri_get_fragment(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_fragment()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_with_scheme']
pub fn vphp_wrap_vslimpsr7uri_with_scheme(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'scheme', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'scheme').value
    res := recv.with_scheme(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_with_user_info']
pub fn vphp_wrap_vslimpsr7uri_with_user_info(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'user', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultPassword', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'user').value
    arg_1 := php_args.at_named_or_index(1, 'defaultPassword').value
    res := recv.with_user_info(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_with_host']
pub fn vphp_wrap_vslimpsr7uri_with_host(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'host', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'host').value
    res := recv.with_host(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_with_port']
pub fn vphp_wrap_vslimpsr7uri_with_port(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'port', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'port').value
    res := recv.with_port(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_with_path']
pub fn vphp_wrap_vslimpsr7uri_with_path(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').value
    res := recv.with_path(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_with_query']
pub fn vphp_wrap_vslimpsr7uri_with_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'query', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'query').value
    res := recv.with_query(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_with_fragment']
pub fn vphp_wrap_vslimpsr7uri_with_fragment(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'fragment', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'fragment').value
    res := recv.with_fragment(arg_0)
    return voidptr(res)
}
@[export: 'VSlimPsr7Uri_handlers']
pub fn vslimpsr7uri_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr7uri_get_prop),
        write_handler: voidptr(vslimpsr7uri_set_prop),
        sync_handler: voidptr(vslimpsr7uri_sync_props),
        new_raw: voidptr(vslimpsr7uri_new_raw),
        cleanup_raw: voidptr(vslimpsr7uri_cleanup_raw),
        free_raw: voidptr(vslimpsr7uri_free_raw)
    )
}
pub fn VSlimPsr7Uri.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr7__uri_ce)
}

pub fn VSlimPsr7Uri.php_object_handlers() voidptr {
    return vslimpsr7uri_handlers()
}

pub fn VSlimPsr7Uri.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr7Uri](v_ptr, ownership)
}

pub fn (obj &VSlimPsr7Uri) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr7Uri](obj)
}

pub fn (obj &VSlimPsr7Uri) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr7Uri](obj)
}

pub fn (obj &VSlimPsr7Uri) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr7Uri](obj)
}

pub fn (obj &VSlimPsr7Uri) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr7Uri](obj)
}

@[export: 'VSlimPsr7Request_new_raw']
pub fn vslimpsr7request_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr7Request]()
}
@[export: 'VSlimPsr7Request_free_raw']
pub fn vslimpsr7request_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr7Request](ptr)
}
@[export: 'VSlimPsr7Request_cleanup_raw']
pub fn vslimpsr7request_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimPsr7Request(ptr)
        obj.cleanup()
    }
}
@[export: 'VSlimPsr7Request_get_prop']
pub fn vslimpsr7request_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VSlimPsr7Request(ptr)
        if name == 'method' {
            ret.v[string](obj.method)
            return
        }
    }
}
@[export: 'VSlimPsr7Request_set_prop']
pub fn vslimpsr7request_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VSlimPsr7Request(ptr)
        if name == 'method' {
            obj.method = arg.get_string()
            return
        }
    }
}
@[export: 'VSlimPsr7Request_sync_props']
pub fn vslimpsr7request_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimPsr7Request(ptr)
        out.add_property_string('method', obj.method)
    }
}
@[export: 'vphp_wrap_VSlimPsr7Request_construct']
pub fn vphp_wrap_vslimpsr7request_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_get_protocol_version']
pub fn vphp_wrap_vslimpsr7request_get_protocol_version(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_protocol_version()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_with_protocol_version']
pub fn vphp_wrap_vslimpsr7request_with_protocol_version(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'version', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'version').value
    res := recv.with_protocol_version(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_get_headers']
pub fn vphp_wrap_vslimpsr7request_get_headers(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_headers()
    ctx.return().v[map[string][]string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_has_header']
pub fn vphp_wrap_vslimpsr7request_has_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    res := recv.has_header(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_get_header']
pub fn vphp_wrap_vslimpsr7request_get_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    res := recv.get_header(arg_0)
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_get_header_line']
pub fn vphp_wrap_vslimpsr7request_get_header_line(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    res := recv.get_header_line(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_with_header']
pub fn vphp_wrap_vslimpsr7request_with_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    arg_1 := php_args.at_named_or_index(1, 'value').value
    res := recv.with_header(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_with_added_header']
pub fn vphp_wrap_vslimpsr7request_with_added_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    arg_1 := php_args.at_named_or_index(1, 'value').value
    res := recv.with_added_header(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_without_header']
pub fn vphp_wrap_vslimpsr7request_without_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    res := recv.without_header(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_get_body']
pub fn vphp_wrap_vslimpsr7request_get_body(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_body()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_with_body']
pub fn vphp_wrap_vslimpsr7request_with_body(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'body', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'body').value
    res := recv.with_body(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_get_request_target']
pub fn vphp_wrap_vslimpsr7request_get_request_target(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_request_target()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_with_request_target']
pub fn vphp_wrap_vslimpsr7request_with_request_target(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'requestTarget', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'requestTarget').value
    res := recv.with_request_target(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_get_method']
pub fn vphp_wrap_vslimpsr7request_get_method(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_method()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_with_method']
pub fn vphp_wrap_vslimpsr7request_with_method(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'method', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'method').value
    res := recv.with_method(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_get_uri']
pub fn vphp_wrap_vslimpsr7request_get_uri(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_uri()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_with_uri']
pub fn vphp_wrap_vslimpsr7request_with_uri(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'uri', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'preserveHost', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'uri').value
    arg_1 := if php_args.has_named_or_index(1, 'preserveHost') { php_args.at_named_or_index(1, 'preserveHost').as_v[bool]() } else { false }
    res := recv.with_uri(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_str']
pub fn vphp_wrap_vslimpsr7request_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.str()
    ctx.return().v[string](res)
}
@[export: 'VSlimPsr7Request_handlers']
pub fn vslimpsr7request_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr7request_get_prop),
        write_handler: voidptr(vslimpsr7request_set_prop),
        sync_handler: voidptr(vslimpsr7request_sync_props),
        new_raw: voidptr(vslimpsr7request_new_raw),
        cleanup_raw: voidptr(vslimpsr7request_cleanup_raw),
        free_raw: voidptr(vslimpsr7request_free_raw)
    )
}
pub fn VSlimPsr7Request.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr7__request_ce)
}

pub fn VSlimPsr7Request.php_object_handlers() voidptr {
    return vslimpsr7request_handlers()
}

pub fn VSlimPsr7Request.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr7Request](v_ptr, ownership)
}

pub fn (obj &VSlimPsr7Request) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr7Request](obj)
}

pub fn (obj &VSlimPsr7Request) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr7Request](obj)
}

pub fn (obj &VSlimPsr7Request) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr7Request](obj)
}

pub fn (obj &VSlimPsr7Request) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr7Request](obj)
}

@[export: 'VSlimPsr7ServerRequest_new_raw']
pub fn vslimpsr7serverrequest_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr7ServerRequest]()
}
@[export: 'VSlimPsr7ServerRequest_free_raw']
pub fn vslimpsr7serverrequest_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr7ServerRequest](ptr)
}
@[export: 'VSlimPsr7ServerRequest_cleanup_raw']
pub fn vslimpsr7serverrequest_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimPsr7ServerRequest(ptr)
        obj.cleanup()
        obj.free()
    }
}
@[export: 'VSlimPsr7ServerRequest_get_prop']
pub fn vslimpsr7serverrequest_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VSlimPsr7ServerRequest(ptr)
        if name == 'method' {
            ret.v[string](obj.method)
            return
        }
    }
}
@[export: 'VSlimPsr7ServerRequest_set_prop']
pub fn vslimpsr7serverrequest_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VSlimPsr7ServerRequest(ptr)
        if name == 'method' {
            obj.method = arg.get_string()
            return
        }
    }
}
@[export: 'VSlimPsr7ServerRequest_sync_props']
pub fn vslimpsr7serverrequest_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimPsr7ServerRequest(ptr)
        out.add_property_string('method', obj.method)
    }
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_construct']
pub fn vphp_wrap_vslimpsr7serverrequest_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_protocol_version']
pub fn vphp_wrap_vslimpsr7serverrequest_get_protocol_version(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_protocol_version()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_protocol_version']
pub fn vphp_wrap_vslimpsr7serverrequest_with_protocol_version(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'version', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'version').value
    res := recv.with_protocol_version(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_headers']
pub fn vphp_wrap_vslimpsr7serverrequest_get_headers(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_headers()
    ctx.return().v[map[string][]string](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_has_header']
pub fn vphp_wrap_vslimpsr7serverrequest_has_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    res := recv.has_header(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_header']
pub fn vphp_wrap_vslimpsr7serverrequest_get_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    res := recv.get_header(arg_0)
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_header_line']
pub fn vphp_wrap_vslimpsr7serverrequest_get_header_line(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    res := recv.get_header_line(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_header']
pub fn vphp_wrap_vslimpsr7serverrequest_with_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    arg_1 := php_args.at_named_or_index(1, 'value').value
    res := recv.with_header(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_added_header']
pub fn vphp_wrap_vslimpsr7serverrequest_with_added_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    arg_1 := php_args.at_named_or_index(1, 'value').value
    res := recv.with_added_header(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_without_header']
pub fn vphp_wrap_vslimpsr7serverrequest_without_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    res := recv.without_header(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_body']
pub fn vphp_wrap_vslimpsr7serverrequest_get_body(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_body()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_body']
pub fn vphp_wrap_vslimpsr7serverrequest_with_body(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'body', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'body').value
    res := recv.with_body(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_request_target']
pub fn vphp_wrap_vslimpsr7serverrequest_get_request_target(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_request_target()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_request_target']
pub fn vphp_wrap_vslimpsr7serverrequest_with_request_target(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'requestTarget', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'requestTarget').value
    res := recv.with_request_target(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_method']
pub fn vphp_wrap_vslimpsr7serverrequest_get_method(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_method()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_method']
pub fn vphp_wrap_vslimpsr7serverrequest_with_method(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'method', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'method').value
    res := recv.with_method(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_uri']
pub fn vphp_wrap_vslimpsr7serverrequest_get_uri(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_uri()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_uri']
pub fn vphp_wrap_vslimpsr7serverrequest_with_uri(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'uri', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'preserveHost', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'uri').value
    arg_1 := if php_args.has_named_or_index(1, 'preserveHost') { php_args.at_named_or_index(1, 'preserveHost').as_v[bool]() } else { false }
    res := recv.with_uri(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_server_params']
pub fn vphp_wrap_vslimpsr7serverrequest_get_server_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_server_params()
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_cookie_params']
pub fn vphp_wrap_vslimpsr7serverrequest_get_cookie_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_cookie_params()
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_cookie_params']
pub fn vphp_wrap_vslimpsr7serverrequest_with_cookie_params(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'cookies', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'cookies').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.with_cookie_params(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_query_params']
pub fn vphp_wrap_vslimpsr7serverrequest_get_query_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_query_params()
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_query_params']
pub fn vphp_wrap_vslimpsr7serverrequest_with_query_params(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'query', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'query').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.with_query_params(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_uploaded_files']
pub fn vphp_wrap_vslimpsr7serverrequest_get_uploaded_files(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_uploaded_files()
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_uploaded_files']
pub fn vphp_wrap_vslimpsr7serverrequest_with_uploaded_files(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'uploadedFiles', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'uploadedFiles').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.with_uploaded_files(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_parsed_body']
pub fn vphp_wrap_vslimpsr7serverrequest_get_parsed_body(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_parsed_body()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_parsed_body']
pub fn vphp_wrap_vslimpsr7serverrequest_with_parsed_body(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'parsedBody', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'parsedBody').value
    res := recv.with_parsed_body(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_attributes']
pub fn vphp_wrap_vslimpsr7serverrequest_get_attributes(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_attributes()
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_attribute']
pub fn vphp_wrap_vslimpsr7serverrequest_get_attribute(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    arg_1 := if php_args.has_named_or_index(1, 'defaultValue') { ?vphp.PhpValue(php_args.at_named_or_index(1, 'defaultValue').value) } else { none }
    res := recv.get_attribute(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_attribute']
pub fn vphp_wrap_vslimpsr7serverrequest_with_attribute(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    arg_1 := php_args.at_named_or_index(1, 'value').value
    res := recv.with_attribute(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_without_attribute']
pub fn vphp_wrap_vslimpsr7serverrequest_without_attribute(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').value
    res := recv.without_attribute(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_str']
pub fn vphp_wrap_vslimpsr7serverrequest_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.str()
    ctx.return().v[string](res)
}
@[export: 'VSlimPsr7ServerRequest_handlers']
pub fn vslimpsr7serverrequest_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr7serverrequest_get_prop),
        write_handler: voidptr(vslimpsr7serverrequest_set_prop),
        sync_handler: voidptr(vslimpsr7serverrequest_sync_props),
        new_raw: voidptr(vslimpsr7serverrequest_new_raw),
        cleanup_raw: voidptr(vslimpsr7serverrequest_cleanup_raw),
        free_raw: voidptr(vslimpsr7serverrequest_free_raw)
    )
}
pub fn VSlimPsr7ServerRequest.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr7__serverrequest_ce)
}

pub fn VSlimPsr7ServerRequest.php_object_handlers() voidptr {
    return vslimpsr7serverrequest_handlers()
}

pub fn VSlimPsr7ServerRequest.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr7ServerRequest](v_ptr, ownership)
}

pub fn (obj &VSlimPsr7ServerRequest) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr7ServerRequest](obj)
}

pub fn (obj &VSlimPsr7ServerRequest) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr7ServerRequest](obj)
}

pub fn (obj &VSlimPsr7ServerRequest) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr7ServerRequest](obj)
}

pub fn (obj &VSlimPsr7ServerRequest) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr7ServerRequest](obj)
}

@[export: 'VSlimPsr17ResponseFactory_new_raw']
pub fn vslimpsr17responsefactory_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr17ResponseFactory]()
}
@[export: 'VSlimPsr17ResponseFactory_free_raw']
pub fn vslimpsr17responsefactory_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr17ResponseFactory](ptr)
}
@[export: 'VSlimPsr17ResponseFactory_cleanup_raw']
pub fn vslimpsr17responsefactory_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr17ResponseFactory_get_prop']
pub fn vslimpsr17responsefactory_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr17ResponseFactory_set_prop']
pub fn vslimpsr17responsefactory_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr17ResponseFactory_sync_props']
pub fn vslimpsr17responsefactory_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr17ResponseFactory_construct']
pub fn vphp_wrap_vslimpsr17responsefactory_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17ResponseFactory(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr17ResponseFactory_create_response']
pub fn vphp_wrap_vslimpsr17responsefactory_create_response(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17ResponseFactory(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'status', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'reasonPhrase', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_params_status := if php_args.has_named_or_index(0, 'status') { php_args.at_named_or_index(0, 'status').as_v[int]() } else { 200 }
    arg_0_params_reason_phrase := if php_args.has_named_or_index(1, 'reasonPhrase') { php_args.at_named_or_index(1, 'reasonPhrase').as_v[string]() } else { '' }
    arg_0_params := httpx.VSlimPsr17CreateResponseParams{
        status: arg_0_params_status
        reason_phrase: arg_0_params_reason_phrase
    }
    res := recv.create_response(arg_0_params)
    return voidptr(res)
}
@[export: 'VSlimPsr17ResponseFactory_handlers']
pub fn vslimpsr17responsefactory_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr17responsefactory_get_prop),
        write_handler: voidptr(vslimpsr17responsefactory_set_prop),
        sync_handler: voidptr(vslimpsr17responsefactory_sync_props),
        new_raw: voidptr(vslimpsr17responsefactory_new_raw),
        cleanup_raw: voidptr(vslimpsr17responsefactory_cleanup_raw),
        free_raw: voidptr(vslimpsr17responsefactory_free_raw)
    )
}
pub fn VSlimPsr17ResponseFactory.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr17__responsefactory_ce)
}

pub fn VSlimPsr17ResponseFactory.php_object_handlers() voidptr {
    return vslimpsr17responsefactory_handlers()
}

pub fn VSlimPsr17ResponseFactory.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr17ResponseFactory](v_ptr, ownership)
}

pub fn (obj &VSlimPsr17ResponseFactory) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr17ResponseFactory](obj)
}

pub fn (obj &VSlimPsr17ResponseFactory) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr17ResponseFactory](obj)
}

pub fn (obj &VSlimPsr17ResponseFactory) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr17ResponseFactory](obj)
}

pub fn (obj &VSlimPsr17ResponseFactory) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr17ResponseFactory](obj)
}

@[export: 'VSlimPsr17RequestFactory_new_raw']
pub fn vslimpsr17requestfactory_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr17RequestFactory]()
}
@[export: 'VSlimPsr17RequestFactory_free_raw']
pub fn vslimpsr17requestfactory_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr17RequestFactory](ptr)
}
@[export: 'VSlimPsr17RequestFactory_cleanup_raw']
pub fn vslimpsr17requestfactory_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr17RequestFactory_get_prop']
pub fn vslimpsr17requestfactory_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr17RequestFactory_set_prop']
pub fn vslimpsr17requestfactory_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr17RequestFactory_sync_props']
pub fn vslimpsr17requestfactory_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr17RequestFactory_construct']
pub fn vphp_wrap_vslimpsr17requestfactory_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17RequestFactory(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr17RequestFactory_create_request']
pub fn vphp_wrap_vslimpsr17requestfactory_create_request(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17RequestFactory(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'method', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'uri', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'method').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'uri').value
    res := recv.create_request(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'VSlimPsr17RequestFactory_handlers']
pub fn vslimpsr17requestfactory_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr17requestfactory_get_prop),
        write_handler: voidptr(vslimpsr17requestfactory_set_prop),
        sync_handler: voidptr(vslimpsr17requestfactory_sync_props),
        new_raw: voidptr(vslimpsr17requestfactory_new_raw),
        cleanup_raw: voidptr(vslimpsr17requestfactory_cleanup_raw),
        free_raw: voidptr(vslimpsr17requestfactory_free_raw)
    )
}
pub fn VSlimPsr17RequestFactory.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr17__requestfactory_ce)
}

pub fn VSlimPsr17RequestFactory.php_object_handlers() voidptr {
    return vslimpsr17requestfactory_handlers()
}

pub fn VSlimPsr17RequestFactory.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr17RequestFactory](v_ptr, ownership)
}

pub fn (obj &VSlimPsr17RequestFactory) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr17RequestFactory](obj)
}

pub fn (obj &VSlimPsr17RequestFactory) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr17RequestFactory](obj)
}

pub fn (obj &VSlimPsr17RequestFactory) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr17RequestFactory](obj)
}

pub fn (obj &VSlimPsr17RequestFactory) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr17RequestFactory](obj)
}

@[export: 'VSlimPsr17StreamFactory_new_raw']
pub fn vslimpsr17streamfactory_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr17StreamFactory]()
}
@[export: 'VSlimPsr17StreamFactory_free_raw']
pub fn vslimpsr17streamfactory_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr17StreamFactory](ptr)
}
@[export: 'VSlimPsr17StreamFactory_cleanup_raw']
pub fn vslimpsr17streamfactory_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr17StreamFactory_get_prop']
pub fn vslimpsr17streamfactory_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr17StreamFactory_set_prop']
pub fn vslimpsr17streamfactory_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr17StreamFactory_sync_props']
pub fn vslimpsr17streamfactory_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr17StreamFactory_construct']
pub fn vphp_wrap_vslimpsr17streamfactory_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17StreamFactory(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr17StreamFactory_create_stream']
pub fn vphp_wrap_vslimpsr17streamfactory_create_stream(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17StreamFactory(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'content', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_params_content := if php_args.has_named_or_index(0, 'content') { php_args.at_named_or_index(0, 'content').as_v[string]() } else { '' }
    arg_0_params := httpx.VSlimPsr17CreateStreamParams{
        content: arg_0_params_content
    }
    res := recv.create_stream(arg_0_params)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr17StreamFactory_create_stream_from_file']
pub fn vphp_wrap_vslimpsr17streamfactory_create_stream_from_file(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17StreamFactory(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'filename', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'mode', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'filename').as_v[string]()
    arg_1_params_mode := if php_args.has_named_or_index(1, 'mode') { php_args.at_named_or_index(1, 'mode').as_v[string]() } else { 'r' }
    arg_1_params := httpx.VSlimPsr17CreateStreamFromFileParams{
        mode: arg_1_params_mode
    }
    res := recv.create_stream_from_file(arg_0, arg_1_params)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr17StreamFactory_create_stream_from_resource']
pub fn vphp_wrap_vslimpsr17streamfactory_create_stream_from_resource(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17StreamFactory(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'resource', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'resource').resource() or {
        vphp.throw_exception('argument 0 must be resource', 0)
        return unsafe { nil }
    }
    res := recv.create_stream_from_resource(arg_0)
    return voidptr(res)
}
@[export: 'VSlimPsr17StreamFactory_handlers']
pub fn vslimpsr17streamfactory_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr17streamfactory_get_prop),
        write_handler: voidptr(vslimpsr17streamfactory_set_prop),
        sync_handler: voidptr(vslimpsr17streamfactory_sync_props),
        new_raw: voidptr(vslimpsr17streamfactory_new_raw),
        cleanup_raw: voidptr(vslimpsr17streamfactory_cleanup_raw),
        free_raw: voidptr(vslimpsr17streamfactory_free_raw)
    )
}
pub fn VSlimPsr17StreamFactory.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr17__streamfactory_ce)
}

pub fn VSlimPsr17StreamFactory.php_object_handlers() voidptr {
    return vslimpsr17streamfactory_handlers()
}

pub fn VSlimPsr17StreamFactory.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr17StreamFactory](v_ptr, ownership)
}

pub fn (obj &VSlimPsr17StreamFactory) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr17StreamFactory](obj)
}

pub fn (obj &VSlimPsr17StreamFactory) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr17StreamFactory](obj)
}

pub fn (obj &VSlimPsr17StreamFactory) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr17StreamFactory](obj)
}

pub fn (obj &VSlimPsr17StreamFactory) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr17StreamFactory](obj)
}

@[export: 'VSlimPsr17UploadedFileFactory_new_raw']
pub fn vslimpsr17uploadedfilefactory_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr17UploadedFileFactory]()
}
@[export: 'VSlimPsr17UploadedFileFactory_free_raw']
pub fn vslimpsr17uploadedfilefactory_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr17UploadedFileFactory](ptr)
}
@[export: 'VSlimPsr17UploadedFileFactory_cleanup_raw']
pub fn vslimpsr17uploadedfilefactory_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr17UploadedFileFactory_get_prop']
pub fn vslimpsr17uploadedfilefactory_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr17UploadedFileFactory_set_prop']
pub fn vslimpsr17uploadedfilefactory_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr17UploadedFileFactory_sync_props']
pub fn vslimpsr17uploadedfilefactory_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr17UploadedFileFactory_construct']
pub fn vphp_wrap_vslimpsr17uploadedfilefactory_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17UploadedFileFactory(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr17UploadedFileFactory_create_uploaded_file']
pub fn vphp_wrap_vslimpsr17uploadedfilefactory_create_uploaded_file(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17UploadedFileFactory(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'stream', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'size', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'error', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'clientFilename', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'clientMediaType', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'stream').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return unsafe { nil }
    }
    arg_1_params_size := if php_args.has_named_or_index(1, 'size') { php_args.at_named_or_index(1, 'size').as_v_opt[int]() } else { none }
    arg_1_params_error := if php_args.has_named_or_index(2, 'error') { php_args.at_named_or_index(2, 'error').as_v[int]() } else { 0 }
    arg_1_params_client_filename := if php_args.has_named_or_index(3, 'clientFilename') { php_args.at_named_or_index(3, 'clientFilename').as_v_opt[string]() } else { none }
    arg_1_params_client_media_type := if php_args.has_named_or_index(4, 'clientMediaType') { php_args.at_named_or_index(4, 'clientMediaType').as_v_opt[string]() } else { none }
    arg_1_params := httpx.VSlimPsr17CreateUploadedFileParams{
        size: arg_1_params_size
        error: arg_1_params_error
        client_filename: arg_1_params_client_filename
        client_media_type: arg_1_params_client_media_type
    }
    res := recv.create_uploaded_file(arg_0, arg_1_params)
    return voidptr(res)
}
@[export: 'VSlimPsr17UploadedFileFactory_handlers']
pub fn vslimpsr17uploadedfilefactory_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr17uploadedfilefactory_get_prop),
        write_handler: voidptr(vslimpsr17uploadedfilefactory_set_prop),
        sync_handler: voidptr(vslimpsr17uploadedfilefactory_sync_props),
        new_raw: voidptr(vslimpsr17uploadedfilefactory_new_raw),
        cleanup_raw: voidptr(vslimpsr17uploadedfilefactory_cleanup_raw),
        free_raw: voidptr(vslimpsr17uploadedfilefactory_free_raw)
    )
}
pub fn VSlimPsr17UploadedFileFactory.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr17__uploadedfilefactory_ce)
}

pub fn VSlimPsr17UploadedFileFactory.php_object_handlers() voidptr {
    return vslimpsr17uploadedfilefactory_handlers()
}

pub fn VSlimPsr17UploadedFileFactory.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr17UploadedFileFactory](v_ptr, ownership)
}

pub fn (obj &VSlimPsr17UploadedFileFactory) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr17UploadedFileFactory](obj)
}

pub fn (obj &VSlimPsr17UploadedFileFactory) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr17UploadedFileFactory](obj)
}

pub fn (obj &VSlimPsr17UploadedFileFactory) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr17UploadedFileFactory](obj)
}

pub fn (obj &VSlimPsr17UploadedFileFactory) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr17UploadedFileFactory](obj)
}

@[export: 'VSlimPsr17UriFactory_new_raw']
pub fn vslimpsr17urifactory_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr17UriFactory]()
}
@[export: 'VSlimPsr17UriFactory_free_raw']
pub fn vslimpsr17urifactory_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr17UriFactory](ptr)
}
@[export: 'VSlimPsr17UriFactory_cleanup_raw']
pub fn vslimpsr17urifactory_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr17UriFactory_get_prop']
pub fn vslimpsr17urifactory_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr17UriFactory_set_prop']
pub fn vslimpsr17urifactory_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr17UriFactory_sync_props']
pub fn vslimpsr17urifactory_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr17UriFactory_construct']
pub fn vphp_wrap_vslimpsr17urifactory_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17UriFactory(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr17UriFactory_create_uri']
pub fn vphp_wrap_vslimpsr17urifactory_create_uri(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17UriFactory(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'uri', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_params_uri := if php_args.has_named_or_index(0, 'uri') { php_args.at_named_or_index(0, 'uri').as_v[string]() } else { '' }
    arg_0_params := httpx.VSlimPsr17CreateUriParams{
        uri: arg_0_params_uri
    }
    res := recv.create_uri(arg_0_params)
    return voidptr(res)
}
@[export: 'VSlimPsr17UriFactory_handlers']
pub fn vslimpsr17urifactory_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr17urifactory_get_prop),
        write_handler: voidptr(vslimpsr17urifactory_set_prop),
        sync_handler: voidptr(vslimpsr17urifactory_sync_props),
        new_raw: voidptr(vslimpsr17urifactory_new_raw),
        cleanup_raw: voidptr(vslimpsr17urifactory_cleanup_raw),
        free_raw: voidptr(vslimpsr17urifactory_free_raw)
    )
}
pub fn VSlimPsr17UriFactory.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr17__urifactory_ce)
}

pub fn VSlimPsr17UriFactory.php_object_handlers() voidptr {
    return vslimpsr17urifactory_handlers()
}

pub fn VSlimPsr17UriFactory.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr17UriFactory](v_ptr, ownership)
}

pub fn (obj &VSlimPsr17UriFactory) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr17UriFactory](obj)
}

pub fn (obj &VSlimPsr17UriFactory) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr17UriFactory](obj)
}

pub fn (obj &VSlimPsr17UriFactory) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr17UriFactory](obj)
}

pub fn (obj &VSlimPsr17UriFactory) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr17UriFactory](obj)
}

@[export: 'VSlimPsr17ServerRequestFactory_new_raw']
pub fn vslimpsr17serverrequestfactory_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr17ServerRequestFactory]()
}
@[export: 'VSlimPsr17ServerRequestFactory_free_raw']
pub fn vslimpsr17serverrequestfactory_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr17ServerRequestFactory](ptr)
}
@[export: 'VSlimPsr17ServerRequestFactory_cleanup_raw']
pub fn vslimpsr17serverrequestfactory_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr17ServerRequestFactory_get_prop']
pub fn vslimpsr17serverrequestfactory_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr17ServerRequestFactory_set_prop']
pub fn vslimpsr17serverrequestfactory_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr17ServerRequestFactory_sync_props']
pub fn vslimpsr17serverrequestfactory_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr17ServerRequestFactory_construct']
pub fn vphp_wrap_vslimpsr17serverrequestfactory_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17ServerRequestFactory(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr17ServerRequestFactory_create_server_request']
pub fn vphp_wrap_vslimpsr17serverrequestfactory_create_server_request(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17ServerRequestFactory(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'method', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'uri', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'serverParams', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'method').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'uri').value
    arg_2_params_server_params := if php_args.has_named_or_index(2, 'serverParams') {
        php_args.at_named_or_index(2, 'serverParams').array() or {
            vphp.throw_exception('argument 2 must be array', 0)
            return unsafe { nil }
        }
    } else {
        vphp.PhpArray.empty()
    }
    arg_2_params := httpx.VSlimPsr17CreateServerRequestParams{
        server_params: arg_2_params_server_params
    }
    res := recv.create_server_request(arg_0, arg_1, arg_2_params)
    return voidptr(res)
}
@[export: 'VSlimPsr17ServerRequestFactory_handlers']
pub fn vslimpsr17serverrequestfactory_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr17serverrequestfactory_get_prop),
        write_handler: voidptr(vslimpsr17serverrequestfactory_set_prop),
        sync_handler: voidptr(vslimpsr17serverrequestfactory_sync_props),
        new_raw: voidptr(vslimpsr17serverrequestfactory_new_raw),
        cleanup_raw: voidptr(vslimpsr17serverrequestfactory_cleanup_raw),
        free_raw: voidptr(vslimpsr17serverrequestfactory_free_raw)
    )
}
pub fn VSlimPsr17ServerRequestFactory.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr17__serverrequestfactory_ce)
}

pub fn VSlimPsr17ServerRequestFactory.php_object_handlers() voidptr {
    return vslimpsr17serverrequestfactory_handlers()
}

pub fn VSlimPsr17ServerRequestFactory.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr17ServerRequestFactory](v_ptr, ownership)
}

pub fn (obj &VSlimPsr17ServerRequestFactory) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr17ServerRequestFactory](obj)
}

pub fn (obj &VSlimPsr17ServerRequestFactory) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr17ServerRequestFactory](obj)
}

pub fn (obj &VSlimPsr17ServerRequestFactory) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr17ServerRequestFactory](obj)
}

pub fn (obj &VSlimPsr17ServerRequestFactory) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr17ServerRequestFactory](obj)
}

@[export: 'VSlimPsr18ClientException_new_raw']
pub fn vslimpsr18clientexception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr18ClientException]()
}
@[export: 'VSlimPsr18ClientException_free_raw']
pub fn vslimpsr18clientexception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr18ClientException](ptr)
}
@[export: 'VSlimPsr18ClientException_cleanup_raw']
pub fn vslimpsr18clientexception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslimpsr18clientexception_load_from_php(php_obj vphp.ZendObject) VSlimPsr18ClientException {
    mut recv := VSlimPsr18ClientException{}
    if !php_obj.is_valid() {
        return recv
    }
    return recv
}
fn vslimpsr18clientexception_sync_to_php(php_obj vphp.ZendObject, recv VSlimPsr18ClientException) {
    if !php_obj.is_valid() {
        return
    }
}
@[export: 'VSlimPsr18ClientException_get_prop']
pub fn vslimpsr18clientexception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr18ClientException_set_prop']
pub fn vslimpsr18clientexception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr18ClientException_sync_props']
pub fn vslimpsr18clientexception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'VSlimPsr18ClientException_handlers']
pub fn vslimpsr18clientexception_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr18clientexception_get_prop),
        write_handler: voidptr(vslimpsr18clientexception_set_prop),
        sync_handler: voidptr(vslimpsr18clientexception_sync_props),
        new_raw: voidptr(vslimpsr18clientexception_new_raw),
        cleanup_raw: voidptr(vslimpsr18clientexception_cleanup_raw),
        free_raw: voidptr(vslimpsr18clientexception_free_raw)
    )
}
pub fn VSlimPsr18ClientException.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr18__clientexception_ce)
}

pub fn VSlimPsr18ClientException.php_object_handlers() voidptr {
    return vslimpsr18clientexception_handlers()
}

pub fn VSlimPsr18ClientException.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr18ClientException](v_ptr, ownership)
}

pub fn (obj &VSlimPsr18ClientException) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr18ClientException](obj)
}

pub fn (obj &VSlimPsr18ClientException) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr18ClientException](obj)
}

pub fn (obj &VSlimPsr18ClientException) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr18ClientException](obj)
}

pub fn (obj &VSlimPsr18ClientException) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr18ClientException](obj)
}

@[export: 'VSlimPsr18RequestException_new_raw']
pub fn vslimpsr18requestexception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr18RequestException]()
}
@[export: 'VSlimPsr18RequestException_free_raw']
pub fn vslimpsr18requestexception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr18RequestException](ptr)
}
@[export: 'VSlimPsr18RequestException_cleanup_raw']
pub fn vslimpsr18requestexception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslimpsr18requestexception_load_from_php(php_obj vphp.ZendObject) VSlimPsr18RequestException {
    mut recv := VSlimPsr18RequestException{}
    if !php_obj.is_valid() {
        return recv
    }
    return recv
}
fn vslimpsr18requestexception_sync_to_php(php_obj vphp.ZendObject, recv VSlimPsr18RequestException) {
    if !php_obj.is_valid() {
        return
    }
}
@[export: 'VSlimPsr18RequestException_get_prop']
pub fn vslimpsr18requestexception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr18RequestException_set_prop']
pub fn vslimpsr18requestexception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr18RequestException_sync_props']
pub fn vslimpsr18requestexception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr18RequestException_attach_request']
pub fn vphp_wrap_vslimpsr18requestexception_attach_request(ptr voidptr, ctx vphp.Context)  {
    this_obj := vphp.ZendObject.from_ptr(ptr)
    mut recv := vslimpsr18requestexception_load_from_php(this_obj)
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    recv.attach_request(arg_0)
    vslimpsr18requestexception_sync_to_php(this_obj, recv)
}
@[export: 'vphp_wrap_VSlimPsr18RequestException_get_request']
pub fn vphp_wrap_vslimpsr18requestexception_get_request(ptr voidptr, ctx vphp.Context)  {
    this_obj := vphp.ZendObject.from_ptr(ptr)
    mut recv := vslimpsr18requestexception_load_from_php(this_obj)
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_request()
    vslimpsr18requestexception_sync_to_php(this_obj, recv)
    ctx.return().v[vphp.PhpObject](res)
}
@[export: 'VSlimPsr18RequestException_handlers']
pub fn vslimpsr18requestexception_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr18requestexception_get_prop),
        write_handler: voidptr(vslimpsr18requestexception_set_prop),
        sync_handler: voidptr(vslimpsr18requestexception_sync_props),
        new_raw: voidptr(vslimpsr18requestexception_new_raw),
        cleanup_raw: voidptr(vslimpsr18requestexception_cleanup_raw),
        free_raw: voidptr(vslimpsr18requestexception_free_raw)
    )
}
pub fn VSlimPsr18RequestException.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr18__requestexception_ce)
}

pub fn VSlimPsr18RequestException.php_object_handlers() voidptr {
    return vslimpsr18requestexception_handlers()
}

pub fn VSlimPsr18RequestException.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr18RequestException](v_ptr, ownership)
}

pub fn (obj &VSlimPsr18RequestException) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr18RequestException](obj)
}

pub fn (obj &VSlimPsr18RequestException) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr18RequestException](obj)
}

pub fn (obj &VSlimPsr18RequestException) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr18RequestException](obj)
}

pub fn (obj &VSlimPsr18RequestException) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr18RequestException](obj)
}

@[export: 'VSlimPsr18NetworkException_new_raw']
pub fn vslimpsr18networkexception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr18NetworkException]()
}
@[export: 'VSlimPsr18NetworkException_free_raw']
pub fn vslimpsr18networkexception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr18NetworkException](ptr)
}
@[export: 'VSlimPsr18NetworkException_cleanup_raw']
pub fn vslimpsr18networkexception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslimpsr18networkexception_load_from_php(php_obj vphp.ZendObject) VSlimPsr18NetworkException {
    mut recv := VSlimPsr18NetworkException{}
    if !php_obj.is_valid() {
        return recv
    }
    return recv
}
fn vslimpsr18networkexception_sync_to_php(php_obj vphp.ZendObject, recv VSlimPsr18NetworkException) {
    if !php_obj.is_valid() {
        return
    }
}
@[export: 'VSlimPsr18NetworkException_get_prop']
pub fn vslimpsr18networkexception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr18NetworkException_set_prop']
pub fn vslimpsr18networkexception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr18NetworkException_sync_props']
pub fn vslimpsr18networkexception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr18NetworkException_attach_request']
pub fn vphp_wrap_vslimpsr18networkexception_attach_request(ptr voidptr, ctx vphp.Context)  {
    this_obj := vphp.ZendObject.from_ptr(ptr)
    mut recv := vslimpsr18networkexception_load_from_php(this_obj)
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    recv.attach_request(arg_0)
    vslimpsr18networkexception_sync_to_php(this_obj, recv)
}
@[export: 'vphp_wrap_VSlimPsr18NetworkException_get_request']
pub fn vphp_wrap_vslimpsr18networkexception_get_request(ptr voidptr, ctx vphp.Context)  {
    this_obj := vphp.ZendObject.from_ptr(ptr)
    mut recv := vslimpsr18networkexception_load_from_php(this_obj)
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_request()
    vslimpsr18networkexception_sync_to_php(this_obj, recv)
    ctx.return().v[vphp.PhpObject](res)
}
@[export: 'VSlimPsr18NetworkException_handlers']
pub fn vslimpsr18networkexception_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr18networkexception_get_prop),
        write_handler: voidptr(vslimpsr18networkexception_set_prop),
        sync_handler: voidptr(vslimpsr18networkexception_sync_props),
        new_raw: voidptr(vslimpsr18networkexception_new_raw),
        cleanup_raw: voidptr(vslimpsr18networkexception_cleanup_raw),
        free_raw: voidptr(vslimpsr18networkexception_free_raw)
    )
}
pub fn VSlimPsr18NetworkException.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr18__networkexception_ce)
}

pub fn VSlimPsr18NetworkException.php_object_handlers() voidptr {
    return vslimpsr18networkexception_handlers()
}

pub fn VSlimPsr18NetworkException.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr18NetworkException](v_ptr, ownership)
}

pub fn (obj &VSlimPsr18NetworkException) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr18NetworkException](obj)
}

pub fn (obj &VSlimPsr18NetworkException) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr18NetworkException](obj)
}

pub fn (obj &VSlimPsr18NetworkException) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr18NetworkException](obj)
}

pub fn (obj &VSlimPsr18NetworkException) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr18NetworkException](obj)
}

@[export: 'VSlimPsr18Client_new_raw']
pub fn vslimpsr18client_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr18Client]()
}
@[export: 'VSlimPsr18Client_free_raw']
pub fn vslimpsr18client_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr18Client](ptr)
}
@[export: 'VSlimPsr18Client_cleanup_raw']
pub fn vslimpsr18client_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr18Client_get_prop']
pub fn vslimpsr18client_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VSlimPsr18Client(ptr)
        if name == 'timeoutSeconds' {
            ret.v[i64](i64(obj.timeout_seconds))
            return
        }
    }
}
@[export: 'VSlimPsr18Client_set_prop']
pub fn vslimpsr18client_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VSlimPsr18Client(ptr)
        if name == 'timeoutSeconds' {
            obj.timeout_seconds = int(arg.get_int())
            return
        }
    }
}
@[export: 'VSlimPsr18Client_sync_props']
pub fn vslimpsr18client_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimPsr18Client(ptr)
        out.add_property_long('timeoutSeconds', i64(obj.timeout_seconds))
    }
}
@[export: 'vphp_wrap_VSlimPsr18Client_construct']
pub fn vphp_wrap_vslimpsr18client_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr18Client(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr18Client_timeout']
pub fn vphp_wrap_vslimpsr18client_timeout(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr18Client(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'seconds', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'seconds').as_v[int]()
    res := recv.timeout(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr18Client_ignore_warning']
pub fn vphp_wrap_vslimpsr18client_ignore_warning(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'errNo', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'errStr', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'errFile', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'errLine', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'errNo').as_v[int]()
    arg_1 := php_args.at_named_or_index(1, 'errStr').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'errFile').as_v[string]()
    arg_3 := php_args.at_named_or_index(3, 'errLine').as_v[int]()
    res := VSlimPsr18Client.ignore_warning(arg_0, arg_1, arg_2, arg_3)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr18Client_timeout_seconds_value']
pub fn vphp_wrap_vslimpsr18client_timeout_seconds_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr18Client(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.timeout_seconds_value()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_VSlimPsr18Client_send_request']
pub fn vphp_wrap_vslimpsr18client_send_request(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr18Client(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return unsafe { nil }
    }
    res := recv.send_request(arg_0)
    return voidptr(res)
}
@[export: 'VSlimPsr18Client_handlers']
pub fn vslimpsr18client_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr18client_get_prop),
        write_handler: voidptr(vslimpsr18client_set_prop),
        sync_handler: voidptr(vslimpsr18client_sync_props),
        new_raw: voidptr(vslimpsr18client_new_raw),
        cleanup_raw: voidptr(vslimpsr18client_cleanup_raw),
        free_raw: voidptr(vslimpsr18client_free_raw)
    )
}
pub fn VSlimPsr18Client.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr18__client_ce)
}

pub fn VSlimPsr18Client.php_object_handlers() voidptr {
    return vslimpsr18client_handlers()
}

pub fn VSlimPsr18Client.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr18Client](v_ptr, ownership)
}

pub fn (obj &VSlimPsr18Client) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr18Client](obj)
}

pub fn (obj &VSlimPsr18Client) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr18Client](obj)
}

pub fn (obj &VSlimPsr18Client) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr18Client](obj)
}

pub fn (obj &VSlimPsr18Client) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr18Client](obj)
}

@[export: 'VSlimPsr7Adapter_new_raw']
pub fn vslimpsr7adapter_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr7Adapter]()
}
@[export: 'VSlimPsr7Adapter_free_raw']
pub fn vslimpsr7adapter_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr7Adapter](ptr)
}
@[export: 'VSlimPsr7Adapter_cleanup_raw']
pub fn vslimpsr7adapter_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr7Adapter_get_prop']
pub fn vslimpsr7adapter_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr7Adapter_set_prop']
pub fn vslimpsr7adapter_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr7Adapter_sync_props']
pub fn vslimpsr7adapter_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr7Adapter_to_vslim_response']
pub fn vphp_wrap_vslimpsr7adapter_to_vslim_response(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'response', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'response').value
    res := VSlimPsr7Adapter.to_vslim_response(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Adapter_to_vslim_request']
pub fn vphp_wrap_vslimpsr7adapter_to_vslim_request(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').value
    res := VSlimPsr7Adapter.to_vslim_request(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Adapter_to_worker_envelope']
pub fn vphp_wrap_vslimpsr7adapter_to_worker_envelope(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').value
    res := VSlimPsr7Adapter.to_worker_envelope(arg_0)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'VSlimPsr7Adapter_handlers']
pub fn vslimpsr7adapter_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr7adapter_get_prop),
        write_handler: voidptr(vslimpsr7adapter_set_prop),
        sync_handler: voidptr(vslimpsr7adapter_sync_props),
        new_raw: voidptr(vslimpsr7adapter_new_raw),
        cleanup_raw: voidptr(vslimpsr7adapter_cleanup_raw),
        free_raw: voidptr(vslimpsr7adapter_free_raw)
    )
}
pub fn VSlimPsr7Adapter.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr7adapter_ce)
}

pub fn VSlimPsr7Adapter.php_object_handlers() voidptr {
    return vslimpsr7adapter_handlers()
}

pub fn VSlimPsr7Adapter.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr7Adapter](v_ptr, ownership)
}

pub fn (obj &VSlimPsr7Adapter) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr7Adapter](obj)
}

pub fn (obj &VSlimPsr7Adapter) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr7Adapter](obj)
}

pub fn (obj &VSlimPsr7Adapter) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr7Adapter](obj)
}

pub fn (obj &VSlimPsr7Adapter) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr7Adapter](obj)
}

@[export: 'VSlimResponse_new_raw']
pub fn vslimresponse_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimResponse]()
}
@[export: 'VSlimResponse_free_raw']
pub fn vslimresponse_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimResponse](ptr)
}
@[export: 'VSlimResponse_cleanup_raw']
pub fn vslimresponse_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimResponse(ptr)
        obj.free()
    }
}
@[export: 'VSlimResponse_get_prop']
pub fn vslimresponse_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VSlimResponse(ptr)
        if name == 'status' {
            ret.v[i64](i64(obj.status))
            return
        }
        if name == 'body' {
            ret.v[string](obj.body)
            return
        }
        if name == 'contentType' {
            ret.v[string](obj.content_type)
            return
        }
    }
}
@[export: 'VSlimResponse_set_prop']
pub fn vslimresponse_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VSlimResponse(ptr)
        if name == 'status' {
            obj.status = int(arg.get_int())
            return
        }
        if name == 'body' {
            obj.body = arg.get_string()
            return
        }
        if name == 'contentType' {
            obj.content_type = arg.get_string()
            return
        }
    }
}
@[export: 'VSlimResponse_sync_props']
pub fn vslimresponse_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimResponse(ptr)
        out.add_property_long('status', i64(obj.status))
        out.add_property_string('body', obj.body)
        out.add_property_string('contentType', obj.content_type)
    }
}
@[export: 'vphp_wrap_VSlimResponse_construct']
pub fn vphp_wrap_vslimresponse_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'status', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'body', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'contentType', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'status').as_v[int]()
    arg_1 := php_args.at_named_or_index(1, 'body').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'contentType').as_v[string]()
    res := recv.construct(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_header']
pub fn vphp_wrap_vslimresponse_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.header(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimResponse_headers']
pub fn vphp_wrap_vslimresponse_headers(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.headers()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimResponse_has_header']
pub fn vphp_wrap_vslimresponse_has_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.has_header(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimResponse_set_header']
pub fn vphp_wrap_vslimresponse_set_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
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
@[export: 'vphp_wrap_VSlimResponse_with_request_id']
pub fn vphp_wrap_vslimresponse_with_request_id(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'requestId', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'requestId').as_v[string]()
    res := recv.with_request_id(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_with_trace_id']
pub fn vphp_wrap_vslimresponse_with_trace_id(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'traceId', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'traceId').as_v[string]()
    res := recv.with_trace_id(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_set_content_type']
pub fn vphp_wrap_vslimresponse_set_content_type(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'contentType', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'contentType').as_v[string]()
    res := recv.set_content_type(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_cookie_header']
pub fn vphp_wrap_vslimresponse_cookie_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.cookie_header()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimResponse_set_cookie']
pub fn vphp_wrap_vslimresponse_set_cookie(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'value').as_v[string]()
    res := recv.set_cookie(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_set_cookie_opts']
pub fn vphp_wrap_vslimresponse_set_cookie_opts(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'value').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'path').as_v[string]()
    res := recv.set_cookie_opts(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_set_cookie_full']
pub fn vphp_wrap_vslimresponse_set_cookie_full(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'path', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'domain', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'maxAge', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 5, name: 'secure', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 6, name: 'httpOnly', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 7, name: 'sameSite', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'value').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'path').as_v[string]()
    arg_3 := php_args.at_named_or_index(3, 'domain').as_v[string]()
    arg_4 := php_args.at_named_or_index(4, 'maxAge').as_v[int]()
    arg_5 := php_args.at_named_or_index(5, 'secure').as_v[bool]()
    arg_6 := php_args.at_named_or_index(6, 'httpOnly').as_v[bool]()
    arg_7 := php_args.at_named_or_index(7, 'sameSite').as_v[string]()
    res := recv.set_cookie_full(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_delete_cookie']
pub fn vphp_wrap_vslimresponse_delete_cookie(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.delete_cookie(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_set_status']
pub fn vphp_wrap_vslimresponse_set_status(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'status', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'status').as_v[int]()
    res := recv.set_status(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_with_status']
pub fn vphp_wrap_vslimresponse_with_status(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'status', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'status').as_v[int]()
    res := recv.with_status(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_text']
pub fn vphp_wrap_vslimresponse_text(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'body', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'body').as_v[string]()
    res := recv.text(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_json']
pub fn vphp_wrap_vslimresponse_json(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'body', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'body').as_v[string]()
    res := recv.json(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_html']
pub fn vphp_wrap_vslimresponse_html(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'body', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'body').as_v[string]()
    res := recv.html(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_redirect']
pub fn vphp_wrap_vslimresponse_redirect(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'location', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'location').as_v[string]()
    res := recv.redirect(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_redirect_with_status']
pub fn vphp_wrap_vslimresponse_redirect_with_status(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'location', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'status', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'location').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'status').as_v[int]()
    res := recv.redirect_with_status(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_headers_all']
pub fn vphp_wrap_vslimresponse_headers_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.headers_all()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimResponse_str']
pub fn vphp_wrap_vslimresponse_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.str()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimResponse_content_length']
pub fn vphp_wrap_vslimresponse_content_length(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimResponse(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.content_length()
    ctx.return().v[int](res)
}
@[export: 'VSlimResponse_handlers']
pub fn vslimresponse_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimresponse_get_prop),
        write_handler: voidptr(vslimresponse_set_prop),
        sync_handler: voidptr(vslimresponse_sync_props),
        new_raw: voidptr(vslimresponse_new_raw),
        cleanup_raw: voidptr(vslimresponse_cleanup_raw),
        free_raw: voidptr(vslimresponse_free_raw)
    )
}
pub fn VSlimResponse.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__vhttpd__response_ce)
}

pub fn VSlimResponse.php_object_handlers() voidptr {
    return vslimresponse_handlers()
}

pub fn VSlimResponse.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimResponse](v_ptr, ownership)
}

pub fn (obj &VSlimResponse) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimResponse](obj)
}

pub fn (obj &VSlimResponse) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimResponse](obj)
}

pub fn (obj &VSlimResponse) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimResponse](obj)
}

pub fn (obj &VSlimResponse) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimResponse](obj)
}

