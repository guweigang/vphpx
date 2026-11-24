module testingx

import vphp
import vphp.object

import containerx
import httpx

#include "php_bridge.h"

__global C.vslim__testing__harness_ce &C.zend_class_entry

@[export: 'vslim_testing_harness_new_raw']
pub fn vslim_testing_harness_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimTestingHarness]()
}
@[export: 'vslim_testing_harness_free_raw']
pub fn vslim_testing_harness_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimTestingHarness](ptr)
}
@[export: 'vslim_testing_harness_cleanup_raw']
pub fn vslim_testing_harness_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_testing_harness_get_prop']
pub fn vslim_testing_harness_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_testing_harness_set_prop']
pub fn vslim_testing_harness_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_testing_harness_sync_props']
pub fn vslim_testing_harness_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_testing_harness_construct']
pub fn vphp_wrap_vslim_testing_harness_construct(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    ctx.return().return_v_object[VSlimTestingHarness](res, .borrowed)
}
@[export: 'vphp_wrap_vslim_testing_harness_set_app']
pub fn vphp_wrap_vslim_testing_harness_set_app(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'app' },
    ])
    arg_0 := php_args.at(0).object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return unsafe { nil }
    }
    res := recv.set_app(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_app']
pub fn vphp_wrap_vslim_testing_harness_app(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.app()
    ctx.return().v[vphp.PhpObject](res)
}
@[export: 'vphp_wrap_vslim_testing_harness_container']
pub fn vphp_wrap_vslim_testing_harness_container(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.container()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_with_service']
pub fn vphp_wrap_vslim_testing_harness_with_service(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'id' },
        vphp.PhpArgMeta{ index: 1, name: 'value' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).value
    res := recv.with_service(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_with_factory']
pub fn vphp_wrap_vslim_testing_harness_with_factory(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'id' },
        vphp.PhpArgMeta{ index: 1, name: 'callable' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).callable() or {
        vphp.throw_exception('argument 1 must be callable', 0)
        return unsafe { nil }
    }
    res := recv.with_factory(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_with_config']
pub fn vphp_wrap_vslim_testing_harness_with_config(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    res := recv.with_config(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_with_config_text']
pub fn vphp_wrap_vslim_testing_harness_with_config_text(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'text' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    res := recv.with_config_text(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_with_cookie']
pub fn vphp_wrap_vslim_testing_harness_with_cookie(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name' },
        vphp.PhpArgMeta{ index: 1, name: 'value' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    res := recv.with_cookie(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_without_cookie']
pub fn vphp_wrap_vslim_testing_harness_without_cookie(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    res := recv.without_cookie(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_clear_cookies']
pub fn vphp_wrap_vslim_testing_harness_clear_cookies(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear_cookies()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_cookies']
pub fn vphp_wrap_vslim_testing_harness_cookies(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.cookies()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_vslim_testing_harness_with_session']
pub fn vphp_wrap_vslim_testing_harness_with_session(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'values' },
    ])
    arg_0 := php_args.at(0).value
    res := recv.with_session(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_acting_as']
pub fn vphp_wrap_vslim_testing_harness_acting_as(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'userId' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    res := recv.acting_as(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_request']
pub fn vphp_wrap_vslim_testing_harness_request(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'method' },
        vphp.PhpArgMeta{ index: 1, name: 'uri' },
        vphp.PhpArgMeta{ index: 2, name: 'body', use_php_default: true },
    ]) or {
        return unsafe { nil }
    }
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    arg_2 := php_args.at(2).as_v[string]()
    res := recv.request(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_json_request']
pub fn vphp_wrap_vslim_testing_harness_json_request(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'method' },
        vphp.PhpArgMeta{ index: 1, name: 'uri' },
        vphp.PhpArgMeta{ index: 2, name: 'payload' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    arg_2 := php_args.at(2).value
    res := recv.json_request(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_export_handle']
pub fn vphp_wrap_vslim_testing_harness_export_handle(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request' },
    ])
    arg_0 := php_args.at(0).zval().to_v[httpx.PsrServerRequest]() or {
        vphp.PhpException.raise_class('TypeError', err.msg(), 0)
        return unsafe { nil }
    }
    res := recv.export_handle(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_handle_request']
pub fn vphp_wrap_vslim_testing_harness_handle_request(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'method' },
        vphp.PhpArgMeta{ index: 1, name: 'uri' },
        vphp.PhpArgMeta{ index: 2, name: 'body', use_php_default: true },
    ]) or {
        return unsafe { nil }
    }
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    arg_2 := php_args.at(2).as_v[string]()
    res := recv.handle_request(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_handle_json']
pub fn vphp_wrap_vslim_testing_harness_handle_json(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'method' },
        vphp.PhpArgMeta{ index: 1, name: 'uri' },
        vphp.PhpArgMeta{ index: 2, name: 'payload' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    arg_2 := php_args.at(2).value
    res := recv.handle_json(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_dispatch_json']
pub fn vphp_wrap_vslim_testing_harness_dispatch_json(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'method' },
        vphp.PhpArgMeta{ index: 1, name: 'uri' },
        vphp.PhpArgMeta{ index: 2, name: 'payload' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    arg_2 := php_args.at(2).value
    res := recv.dispatch_json(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_response_status']
pub fn vphp_wrap_vslim_testing_harness_response_status(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'response' },
    ])
    arg_0 := php_args.at(0).value
    res := recv.response_status(arg_0)
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_testing_harness_response_header']
pub fn vphp_wrap_vslim_testing_harness_response_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'response' },
        vphp.PhpArgMeta{ index: 1, name: 'name' },
    ])
    arg_0 := php_args.at(0).value
    arg_1 := php_args.at(1).as_v[string]()
    res := recv.response_header(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_testing_harness_response_body']
pub fn vphp_wrap_vslim_testing_harness_response_body(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'response' },
    ])
    arg_0 := php_args.at(0).value
    res := recv.response_body(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_testing_harness_response_json']
pub fn vphp_wrap_vslim_testing_harness_response_json(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'response' },
    ])
    arg_0 := php_args.at(0).value
    res := recv.response_json(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_testing_harness_assert_status']
pub fn vphp_wrap_vslim_testing_harness_assert_status(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'response' },
        vphp.PhpArgMeta{ index: 1, name: 'expected' },
    ])
    arg_0 := php_args.at(0).value
    arg_1 := php_args.at(1).as_v[int]()
    res := recv.assert_status(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_assert_header']
pub fn vphp_wrap_vslim_testing_harness_assert_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'response' },
        vphp.PhpArgMeta{ index: 1, name: 'name' },
        vphp.PhpArgMeta{ index: 2, name: 'expected' },
    ])
    arg_0 := php_args.at(0).value
    arg_1 := php_args.at(1).as_v[string]()
    arg_2 := php_args.at(2).as_v[string]()
    res := recv.assert_header(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_assert_body_contains']
pub fn vphp_wrap_vslim_testing_harness_assert_body_contains(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'response' },
        vphp.PhpArgMeta{ index: 1, name: 'needle' },
    ])
    arg_0 := php_args.at(0).value
    arg_1 := php_args.at(1).as_v[string]()
    res := recv.assert_body_contains(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_dispatch']
pub fn vphp_wrap_vslim_testing_harness_dispatch(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'method' },
        vphp.PhpArgMeta{ index: 1, name: 'uri' },
        vphp.PhpArgMeta{ index: 2, name: 'body', use_php_default: true },
    ]) or {
        return unsafe { nil }
    }
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    arg_2 := php_args.at(2).as_v[string]()
    res := recv.dispatch(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_get']
pub fn vphp_wrap_vslim_testing_harness_get(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'uri' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    res := recv.get(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_get_json']
pub fn vphp_wrap_vslim_testing_harness_get_json(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'uri' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    res := recv.get_json(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_post']
pub fn vphp_wrap_vslim_testing_harness_post(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'uri' },
        vphp.PhpArgMeta{ index: 1, name: 'body', use_php_default: true },
    ]) or {
        return unsafe { nil }
    }
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    res := recv.post(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_post_json']
pub fn vphp_wrap_vslim_testing_harness_post_json(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'uri' },
        vphp.PhpArgMeta{ index: 1, name: 'payload' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).value
    res := recv.post_json(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_put']
pub fn vphp_wrap_vslim_testing_harness_put(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'uri' },
        vphp.PhpArgMeta{ index: 1, name: 'body', use_php_default: true },
    ]) or {
        return unsafe { nil }
    }
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    res := recv.put(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_put_json']
pub fn vphp_wrap_vslim_testing_harness_put_json(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'uri' },
        vphp.PhpArgMeta{ index: 1, name: 'payload' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).value
    res := recv.put_json(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_patch']
pub fn vphp_wrap_vslim_testing_harness_patch(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'uri' },
        vphp.PhpArgMeta{ index: 1, name: 'body', use_php_default: true },
    ]) or {
        return unsafe { nil }
    }
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    res := recv.patch(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_patch_json']
pub fn vphp_wrap_vslim_testing_harness_patch_json(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'uri' },
        vphp.PhpArgMeta{ index: 1, name: 'payload' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).value
    res := recv.patch_json(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_delete']
pub fn vphp_wrap_vslim_testing_harness_delete(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'uri' },
        vphp.PhpArgMeta{ index: 1, name: 'body', use_php_default: true },
    ]) or {
        return unsafe { nil }
    }
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    res := recv.delete(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_testing_harness_delete_json']
pub fn vphp_wrap_vslim_testing_harness_delete_json(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimTestingHarness(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'uri' },
        vphp.PhpArgMeta{ index: 1, name: 'payload' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).value
    res := recv.delete_json(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vslim_testing_harness_handlers']
pub fn vslim_testing_harness_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vslim_testing_harness_get_prop,
        write_handler: vslim_testing_harness_set_prop,
        sync_handler: vslim_testing_harness_sync_props,
        new_raw: vslim_testing_harness_new_raw,
        cleanup_raw: vslim_testing_harness_cleanup_raw,
        free_raw: vslim_testing_harness_free_raw
    )
}
pub fn VSlimTestingHarness.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__testing__harness_ce)
}

pub fn VSlimTestingHarness.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_testing_harness_handlers())
}

pub fn VSlimTestingHarness.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimTestingHarness](v_ptr, ownership)
}

pub fn (obj &VSlimTestingHarness) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimTestingHarness](obj)
}

pub fn (obj &VSlimTestingHarness) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimTestingHarness](obj)
}

pub fn (obj &VSlimTestingHarness) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimTestingHarness](obj)
}

pub fn (obj &VSlimTestingHarness) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimTestingHarness](obj)
}

pub fn (val VSlimTestingHarness) php_class_name() string {
    return 'VSlim\\Testing\\Harness'
}

