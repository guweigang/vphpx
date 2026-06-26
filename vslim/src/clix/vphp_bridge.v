module clix

import vphp
import vphp.object

#include "php_bridge.h"

__global C.vslim__cli__app_ce &C.zend_class_entry

@[export: 'vslim_cli_app_new_raw']
pub fn vslim_cli_app_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimCliApp]()
}
@[export: 'vslim_cli_app_free_raw']
pub fn vslim_cli_app_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimCliApp](ptr)
}
@[export: 'vslim_cli_app_cleanup_raw']
pub fn vslim_cli_app_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimCliApp(ptr)
        obj.cleanup()
    }
}
@[export: 'vslim_cli_app_get_prop']
pub fn vslim_cli_app_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_cli_app_set_prop']
pub fn vslim_cli_app_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_cli_app_sync_props']
pub fn vslim_cli_app_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_cli_app_help_text']
pub fn vphp_wrap_vslim_cli_app_help_text(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.help_text()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_cli_app_command_help']
pub fn vphp_wrap_vslim_cli_app_command_help(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'commandName', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'commandName').as_v[string]()
    res := recv.command_help(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_cli_app_run_argv']
pub fn vphp_wrap_vslim_cli_app_run_argv(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'argv', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'argv').iterable() or {
        vphp.throw_exception('argument 0 must be iterable', 0)
        return
    }
    res := recv.run_argv(arg_0)
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_cli_app_construct']
pub fn vphp_wrap_vslim_cli_app_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_cli_app_app']
pub fn vphp_wrap_vslim_cli_app_app(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.app()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_cli_app_project_root_value']
pub fn vphp_wrap_vslim_cli_app_project_root_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.project_root_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_cli_app_debug_bridge_path']
pub fn vphp_wrap_vslim_cli_app_debug_bridge_path(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    res := recv.debug_bridge_path(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_cli_app_command']
pub fn vphp_wrap_vslim_cli_app_command(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.command(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_cli_app_command_many']
pub fn vphp_wrap_vslim_cli_app_command_many(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'commands', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'commands').iterable() or {
        vphp.throw_exception('argument 0 must be iterable', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.command_many(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_cli_app_command_names']
pub fn vphp_wrap_vslim_cli_app_command_names(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.command_names()
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_vslim_cli_app_has_command']
pub fn vphp_wrap_vslim_cli_app_has_command(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.has_command(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_cli_app_command_name']
pub fn vphp_wrap_vslim_cli_app_command_name(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.command_name()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_cli_app_raw_args']
pub fn vphp_wrap_vslim_cli_app_raw_args(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.raw_args()
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_vslim_cli_app_input_parsed']
pub fn vphp_wrap_vslim_cli_app_input_parsed(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.input_parsed()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_cli_app_has_option']
pub fn vphp_wrap_vslim_cli_app_has_option(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.has_option(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_cli_app_warnings']
pub fn vphp_wrap_vslim_cli_app_warnings(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.warnings()
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_vslim_cli_app_options']
pub fn vphp_wrap_vslim_cli_app_options(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.options()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_cli_app_arguments']
pub fn vphp_wrap_vslim_cli_app_arguments(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.arguments()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_cli_app_option']
pub fn vphp_wrap_vslim_cli_app_option(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := if php_args.has_named_or_index(1, 'defaultValue') { ?vphp.PhpValue(php_args.at_named_or_index(1, 'defaultValue').value) } else { none }
    res := recv.option(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_cli_app_argument']
pub fn vphp_wrap_vslim_cli_app_argument(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := if php_args.has_named_or_index(1, 'defaultValue') { ?vphp.PhpValue(php_args.at_named_or_index(1, 'defaultValue').value) } else { none }
    res := recv.argument(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_cli_app_run']
pub fn vphp_wrap_vslim_cli_app_run(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'args', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'args').iterable() or {
        vphp.throw_exception('argument 1 must be iterable', 0)
        return
    }
    res := recv.run(arg_0, arg_1)
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_cli_app_bootstrap_file']
pub fn vphp_wrap_vslim_cli_app_bootstrap_file(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    res := recv.bootstrap_file(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_cli_app_bootstrap_dir']
pub fn vphp_wrap_vslim_cli_app_bootstrap_dir(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    res := recv.bootstrap_dir(arg_0)
    return voidptr(res)
}
@[export: 'vslim_cli_app_handlers']
pub fn vslim_cli_app_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_cli_app_get_prop),
        write_handler: voidptr(vslim_cli_app_set_prop),
        sync_handler: voidptr(vslim_cli_app_sync_props),
        new_raw: voidptr(vslim_cli_app_new_raw),
        cleanup_raw: voidptr(vslim_cli_app_cleanup_raw),
        free_raw: voidptr(vslim_cli_app_free_raw)
    )
}
pub fn VSlimCliApp.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__cli__app_ce)
}

pub fn VSlimCliApp.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_cli_app_handlers())
}

pub fn VSlimCliApp.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimCliApp](v_ptr, ownership)
}

pub fn (obj &VSlimCliApp) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimCliApp](obj)
}

pub fn (obj &VSlimCliApp) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimCliApp](obj)
}

pub fn (obj &VSlimCliApp) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimCliApp](obj)
}

pub fn (obj &VSlimCliApp) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimCliApp](obj)
}

pub fn (val VSlimCliApp) php_class_name() string {
    return 'VSlim\\Cli\\App'
}

