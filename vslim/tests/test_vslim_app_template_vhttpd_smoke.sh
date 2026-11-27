#!/bin/sh

unset $(env | cut -d= -f1)
export SHELL='/bin/bash'
export __CFBundleIdentifier='com.google.antigravity'
export SSH_AUTH_SOCK='deleted'
export PWD='/Users/guweigang/Source/vphpx/vslim'
export LOGNAME='guweigang'
export XDG_SESSION_TYPE='tty'
export LaunchInstanceID='FAA80698-D28E-4562-8494-2861590BDF82'
export COMMAND_MODE='unix2003'
export HOME='/home/guweigang'
export LANG='en_US.UTF-8'
export https_proxy='http://host.orb.internal:7897'
export SSH_CONNECTION='deleted'
export XDG_SESSION_CLASS='user'
export USER='guweigang'
export SHLVL='1'
export http_proxy='http://host.orb.internal:7897'
export XDG_RUNTIME_DIR='/run/user/501'
export DEBUGINFOD_URLS='https://debuginfod.ubuntu.com '
export all_proxy='socks5://host.orb.internal:7897'
export BROWSER='/opt/orbstack-guest/bin/open'
export PATH='/home/guweigang/v:/home/guweigang/v:/home/guweigang/v:/opt/orbstack-guest/bin-hiprio:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/opt/orbstack-guest/bin:/opt/orbstack-guest/data/bin/cmdlinks'
export DBUS_SESSION_BUS_ADDRESS='unix:path=/run/user/501/bus'
export OLDPWD='/Users/guweigang/Source/vphpx/vslim'
export __CF_USER_TEXT_ENCODING='0x1F5:0x19:0x34'
export _='/usr/bin/php'
export SSH_CLIENT='deleted'
export SSH_TTY='deleted'
export TEMP='/tmp'
export SKIP_ONLINE_TESTS='1'
export SKIP_IO_CAPTURE_TESTS='1'
export TEST_PHP_EXECUTABLE='/usr/bin/php8.5'
export TEST_PHP_EXECUTABLE_ESCAPED=''\''/usr/bin/php8.5'\'''
export TEST_PHP_CGI_EXECUTABLE_ESCAPED=''\'''\'''
export TEST_PHPDBG_EXECUTABLE_ESCAPED=''\'''\'''
export REDIRECT_STATUS='1'
export PATH_TRANSLATED='/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_app_template_vhttpd_smoke.php'
export SCRIPT_FILENAME='/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_app_template_vhttpd_smoke.php'
export REQUEST_METHOD='GET'
export TEST_PHP_EXTRA_ARGS='  -d "output_handler=" -d "open_basedir=" -d "disable_functions=" -d "output_buffering=Off" -d "error_reporting=30719" -d "fatal_error_backtraces=Off" -d "display_errors=1" -d "display_startup_errors=1" -d "log_errors=0" -d "html_errors=0" -d "track_errors=0" -d "report_zend_debug=0" -d "docref_root=" -d "docref_ext=.html" -d "error_prepend_string=" -d "error_append_string=" -d "auto_prepend_file=" -d "auto_append_file=" -d "ignore_repeated_errors=0" -d "precision=14" -d "serialize_precision=-1" -d "memory_limit=128M" -d "opcache.fast_shutdown=0" -d "opcache.file_update_protection=0" -d "opcache.revalidate_freq=0" -d "opcache.jit_hot_loop=1" -d "opcache.jit_hot_func=1" -d "opcache.jit_hot_return=1" -d "opcache.jit_hot_side_exit=1" -d "opcache.jit_max_root_traces=100000" -d "opcache.jit_max_side_traces=100000" -d "opcache.jit_max_exit_counters=100000" -d "opcache.protect_memory=1" -d "zend.assertions=1" -d "zend.exception_ignore_args=0" -d "zend.exception_string_param_max_len=15" -d "short_open_tag=0" -d "extension=./vslim.so" -d "session.auto_start=0" -d "zlib.output_compression=Off"'

case "$1" in
"gdb")
    gdb -ex 'unset environment LINES' -ex 'unset environment COLUMNS' --args '/usr/bin/php8.5'    -d "output_handler=" -d "open_basedir=" -d "disable_functions=" -d "output_buffering=Off" -d "error_reporting=30719" -d "fatal_error_backtraces=Off" -d "display_errors=1" -d "display_startup_errors=1" -d "log_errors=0" -d "html_errors=0" -d "track_errors=0" -d "report_zend_debug=0" -d "docref_root=" -d "docref_ext=.html" -d "error_prepend_string=" -d "error_append_string=" -d "auto_prepend_file=" -d "auto_append_file=" -d "ignore_repeated_errors=0" -d "precision=14" -d "serialize_precision=-1" -d "memory_limit=128M" -d "opcache.fast_shutdown=0" -d "opcache.file_update_protection=0" -d "opcache.revalidate_freq=0" -d "opcache.jit_hot_loop=1" -d "opcache.jit_hot_func=1" -d "opcache.jit_hot_return=1" -d "opcache.jit_hot_side_exit=1" -d "opcache.jit_max_root_traces=100000" -d "opcache.jit_max_side_traces=100000" -d "opcache.jit_max_exit_counters=100000" -d "opcache.protect_memory=1" -d "zend.assertions=1" -d "zend.exception_ignore_args=0" -d "zend.exception_string_param_max_len=15" -d "short_open_tag=0" -d "extension=./vslim.so" -d "session.auto_start=0" -d "zlib.output_compression=Off" -f "/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_app_template_vhttpd_smoke.php"  2>&1
    ;;
"lldb")
    lldb -- '/usr/bin/php8.5'    -d "output_handler=" -d "open_basedir=" -d "disable_functions=" -d "output_buffering=Off" -d "error_reporting=30719" -d "fatal_error_backtraces=Off" -d "display_errors=1" -d "display_startup_errors=1" -d "log_errors=0" -d "html_errors=0" -d "track_errors=0" -d "report_zend_debug=0" -d "docref_root=" -d "docref_ext=.html" -d "error_prepend_string=" -d "error_append_string=" -d "auto_prepend_file=" -d "auto_append_file=" -d "ignore_repeated_errors=0" -d "precision=14" -d "serialize_precision=-1" -d "memory_limit=128M" -d "opcache.fast_shutdown=0" -d "opcache.file_update_protection=0" -d "opcache.revalidate_freq=0" -d "opcache.jit_hot_loop=1" -d "opcache.jit_hot_func=1" -d "opcache.jit_hot_return=1" -d "opcache.jit_hot_side_exit=1" -d "opcache.jit_max_root_traces=100000" -d "opcache.jit_max_side_traces=100000" -d "opcache.jit_max_exit_counters=100000" -d "opcache.protect_memory=1" -d "zend.assertions=1" -d "zend.exception_ignore_args=0" -d "zend.exception_string_param_max_len=15" -d "short_open_tag=0" -d "extension=./vslim.so" -d "session.auto_start=0" -d "zlib.output_compression=Off" -f "/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_app_template_vhttpd_smoke.php"  2>&1
    ;;
"valgrind")
    USE_ZEND_ALLOC=0 valgrind $2 '/usr/bin/php8.5'    -d "output_handler=" -d "open_basedir=" -d "disable_functions=" -d "output_buffering=Off" -d "error_reporting=30719" -d "fatal_error_backtraces=Off" -d "display_errors=1" -d "display_startup_errors=1" -d "log_errors=0" -d "html_errors=0" -d "track_errors=0" -d "report_zend_debug=0" -d "docref_root=" -d "docref_ext=.html" -d "error_prepend_string=" -d "error_append_string=" -d "auto_prepend_file=" -d "auto_append_file=" -d "ignore_repeated_errors=0" -d "precision=14" -d "serialize_precision=-1" -d "memory_limit=128M" -d "opcache.fast_shutdown=0" -d "opcache.file_update_protection=0" -d "opcache.revalidate_freq=0" -d "opcache.jit_hot_loop=1" -d "opcache.jit_hot_func=1" -d "opcache.jit_hot_return=1" -d "opcache.jit_hot_side_exit=1" -d "opcache.jit_max_root_traces=100000" -d "opcache.jit_max_side_traces=100000" -d "opcache.jit_max_exit_counters=100000" -d "opcache.protect_memory=1" -d "zend.assertions=1" -d "zend.exception_ignore_args=0" -d "zend.exception_string_param_max_len=15" -d "short_open_tag=0" -d "extension=./vslim.so" -d "session.auto_start=0" -d "zlib.output_compression=Off" -f "/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_app_template_vhttpd_smoke.php"  2>&1
    ;;
"rr")
    rr record $2 '/usr/bin/php8.5'    -d "output_handler=" -d "open_basedir=" -d "disable_functions=" -d "output_buffering=Off" -d "error_reporting=30719" -d "fatal_error_backtraces=Off" -d "display_errors=1" -d "display_startup_errors=1" -d "log_errors=0" -d "html_errors=0" -d "track_errors=0" -d "report_zend_debug=0" -d "docref_root=" -d "docref_ext=.html" -d "error_prepend_string=" -d "error_append_string=" -d "auto_prepend_file=" -d "auto_append_file=" -d "ignore_repeated_errors=0" -d "precision=14" -d "serialize_precision=-1" -d "memory_limit=128M" -d "opcache.fast_shutdown=0" -d "opcache.file_update_protection=0" -d "opcache.revalidate_freq=0" -d "opcache.jit_hot_loop=1" -d "opcache.jit_hot_func=1" -d "opcache.jit_hot_return=1" -d "opcache.jit_hot_side_exit=1" -d "opcache.jit_max_root_traces=100000" -d "opcache.jit_max_side_traces=100000" -d "opcache.jit_max_exit_counters=100000" -d "opcache.protect_memory=1" -d "zend.assertions=1" -d "zend.exception_ignore_args=0" -d "zend.exception_string_param_max_len=15" -d "short_open_tag=0" -d "extension=./vslim.so" -d "session.auto_start=0" -d "zlib.output_compression=Off" -f "/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_app_template_vhttpd_smoke.php"  2>&1
    ;;
*)
    '/usr/bin/php8.5'    -d "output_handler=" -d "open_basedir=" -d "disable_functions=" -d "output_buffering=Off" -d "error_reporting=30719" -d "fatal_error_backtraces=Off" -d "display_errors=1" -d "display_startup_errors=1" -d "log_errors=0" -d "html_errors=0" -d "track_errors=0" -d "report_zend_debug=0" -d "docref_root=" -d "docref_ext=.html" -d "error_prepend_string=" -d "error_append_string=" -d "auto_prepend_file=" -d "auto_append_file=" -d "ignore_repeated_errors=0" -d "precision=14" -d "serialize_precision=-1" -d "memory_limit=128M" -d "opcache.fast_shutdown=0" -d "opcache.file_update_protection=0" -d "opcache.revalidate_freq=0" -d "opcache.jit_hot_loop=1" -d "opcache.jit_hot_func=1" -d "opcache.jit_hot_return=1" -d "opcache.jit_hot_side_exit=1" -d "opcache.jit_max_root_traces=100000" -d "opcache.jit_max_side_traces=100000" -d "opcache.jit_max_exit_counters=100000" -d "opcache.protect_memory=1" -d "zend.assertions=1" -d "zend.exception_ignore_args=0" -d "zend.exception_string_param_max_len=15" -d "short_open_tag=0" -d "extension=./vslim.so" -d "session.auto_start=0" -d "zlib.output_compression=Off" -f "/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_app_template_vhttpd_smoke.php"  2>&1
    ;;
esac