#!/bin/sh

unset $(env | cut -d= -f1)
export OSLogRateLimit='64'
export MallocNanoZone='0'
export USER='guweigang'
export COMMAND_MODE='unix2003'
export __CFBundleIdentifier='com.google.antigravity'
export PATH='/opt/homebrew/opt/php/bin:/Users/guweigang/local/v:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin'
export LOGNAME='guweigang'
export SSH_AUTH_SOCK='deleted'
export HOME='/Users/guweigang'
export SHELL='/bin/zsh'
export TMPDIR='/var/folders/ck/vq9ch5jj5gj52vjg5z4kl6th0000gn/T/'
export __CF_USER_TEXT_ENCODING='0x1F5:0x19:0x34'
export XPC_SERVICE_NAME='application.com.google.antigravity.137612287.137612293'
export XPC_FLAGS='0x0'
export VSCODE_CWD='/'
export VSCODE_NLS_CONFIG='{"userLocale":"zh-cn","osLocale":"zh-cn","resolvedLanguage":"en","defaultMessagesFile":"/Applications/Antigravity.app/Contents/Resources/app/out/nls.messages.json","locale":"zh-cn","availableLanguages":{}}'
export VSCODE_CODE_CACHE_PATH='/Users/guweigang/Library/Application Support/Antigravity/CachedData/62335c71d47037adf0a8de54e250bb8ea6016b15'
export VSCODE_IPC_HOOK='/Users/guweigang/Library/Application Support/Antigravity/1.10-main.sock'
export VSCODE_PID='35625'
export ANTIGRAVITY_EDITOR_APP_ROOT='/Applications/Antigravity.app/Contents/Resources/app'
export PWD='/Users/guweigang/Source/vphpx/vslim'
export ANTIGRAVITY_AGENT='1'
export TERM='dumb'
export PAGER='cat'
export ANTIGRAVITY_TRAJECTORY_ID='77d0c871-3c53-4aad-826d-9d1b0e7ee559'
export SHLVL='0'
export OLDPWD='/Users/guweigang/Source/vphpx/vslim'
export LIBRARY_PATH='/opt/homebrew/lib:'
export TEST_PHP_EXECUTABLE='/opt/homebrew/opt/php/bin/php'
export _='/opt/homebrew/opt/php/bin/php'
export SSH_CLIENT='deleted'
export SSH_TTY='deleted'
export SSH_CONNECTION='deleted'
export TEMP='/var/folders/ck/vq9ch5jj5gj52vjg5z4kl6th0000gn/T'
export NO_INTERACTION='1'
export SKIP_ONLINE_TESTS='1'
export TEST_PHP_EXECUTABLE_ESCAPED=''\''/opt/homebrew/opt/php/bin/php'\'''
export TEST_PHP_CGI_EXECUTABLE='/opt/homebrew/Cellar/php/8.5.5/bin/php-cgi'
export TEST_PHP_CGI_EXECUTABLE_ESCAPED=''\''/opt/homebrew/Cellar/php/8.5.5/bin/php-cgi'\'''
export TEST_PHPDBG_EXECUTABLE='/opt/homebrew/Cellar/php/8.5.5/bin/phpdbg'
export TEST_PHPDBG_EXECUTABLE_ESCAPED=''\''/opt/homebrew/Cellar/php/8.5.5/bin/phpdbg'\'''
export REDIRECT_STATUS='1'
export PATH_TRANSLATED='/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_app_template_vhttpd_smoke.php'
export SCRIPT_FILENAME='/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_app_template_vhttpd_smoke.php'
export REQUEST_METHOD='GET'
export TEST_PHP_EXTRA_ARGS='  -d "output_handler=" -d "open_basedir=" -d "disable_functions=" -d "output_buffering=Off" -d "error_reporting=30719" -d "fatal_error_backtraces=Off" -d "display_errors=1" -d "display_startup_errors=1" -d "log_errors=0" -d "html_errors=0" -d "track_errors=0" -d "report_zend_debug=0" -d "docref_root=" -d "docref_ext=.html" -d "error_prepend_string=" -d "error_append_string=" -d "auto_prepend_file=" -d "auto_append_file=" -d "ignore_repeated_errors=0" -d "precision=14" -d "serialize_precision=-1" -d "memory_limit=128M" -d "opcache.fast_shutdown=0" -d "opcache.file_update_protection=0" -d "opcache.revalidate_freq=0" -d "opcache.jit_hot_loop=1" -d "opcache.jit_hot_func=1" -d "opcache.jit_hot_return=1" -d "opcache.jit_hot_side_exit=1" -d "opcache.jit_max_root_traces=100000" -d "opcache.jit_max_side_traces=100000" -d "opcache.jit_max_exit_counters=100000" -d "opcache.protect_memory=1" -d "zend.assertions=1" -d "zend.exception_ignore_args=0" -d "zend.exception_string_param_max_len=15" -d "short_open_tag=0" -d "extension=./vslim.so" -d "session.auto_start=0" -d "tidy.clean_output=0" -d "zlib.output_compression=Off"'

case "$1" in
"gdb")
    gdb -ex 'unset environment LINES' -ex 'unset environment COLUMNS' --args '/opt/homebrew/opt/php/bin/php'    -d "output_handler=" -d "open_basedir=" -d "disable_functions=" -d "output_buffering=Off" -d "error_reporting=30719" -d "fatal_error_backtraces=Off" -d "display_errors=1" -d "display_startup_errors=1" -d "log_errors=0" -d "html_errors=0" -d "track_errors=0" -d "report_zend_debug=0" -d "docref_root=" -d "docref_ext=.html" -d "error_prepend_string=" -d "error_append_string=" -d "auto_prepend_file=" -d "auto_append_file=" -d "ignore_repeated_errors=0" -d "precision=14" -d "serialize_precision=-1" -d "memory_limit=128M" -d "opcache.fast_shutdown=0" -d "opcache.file_update_protection=0" -d "opcache.revalidate_freq=0" -d "opcache.jit_hot_loop=1" -d "opcache.jit_hot_func=1" -d "opcache.jit_hot_return=1" -d "opcache.jit_hot_side_exit=1" -d "opcache.jit_max_root_traces=100000" -d "opcache.jit_max_side_traces=100000" -d "opcache.jit_max_exit_counters=100000" -d "opcache.protect_memory=1" -d "zend.assertions=1" -d "zend.exception_ignore_args=0" -d "zend.exception_string_param_max_len=15" -d "short_open_tag=0" -d "extension=./vslim.so" -d "session.auto_start=0" -d "tidy.clean_output=0" -d "zlib.output_compression=Off" -f "/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_app_template_vhttpd_smoke.php"  2>&1
    ;;
"lldb")
    lldb -- '/opt/homebrew/opt/php/bin/php'    -d "output_handler=" -d "open_basedir=" -d "disable_functions=" -d "output_buffering=Off" -d "error_reporting=30719" -d "fatal_error_backtraces=Off" -d "display_errors=1" -d "display_startup_errors=1" -d "log_errors=0" -d "html_errors=0" -d "track_errors=0" -d "report_zend_debug=0" -d "docref_root=" -d "docref_ext=.html" -d "error_prepend_string=" -d "error_append_string=" -d "auto_prepend_file=" -d "auto_append_file=" -d "ignore_repeated_errors=0" -d "precision=14" -d "serialize_precision=-1" -d "memory_limit=128M" -d "opcache.fast_shutdown=0" -d "opcache.file_update_protection=0" -d "opcache.revalidate_freq=0" -d "opcache.jit_hot_loop=1" -d "opcache.jit_hot_func=1" -d "opcache.jit_hot_return=1" -d "opcache.jit_hot_side_exit=1" -d "opcache.jit_max_root_traces=100000" -d "opcache.jit_max_side_traces=100000" -d "opcache.jit_max_exit_counters=100000" -d "opcache.protect_memory=1" -d "zend.assertions=1" -d "zend.exception_ignore_args=0" -d "zend.exception_string_param_max_len=15" -d "short_open_tag=0" -d "extension=./vslim.so" -d "session.auto_start=0" -d "tidy.clean_output=0" -d "zlib.output_compression=Off" -f "/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_app_template_vhttpd_smoke.php"  2>&1
    ;;
"valgrind")
    USE_ZEND_ALLOC=0 valgrind $2 '/opt/homebrew/opt/php/bin/php'    -d "output_handler=" -d "open_basedir=" -d "disable_functions=" -d "output_buffering=Off" -d "error_reporting=30719" -d "fatal_error_backtraces=Off" -d "display_errors=1" -d "display_startup_errors=1" -d "log_errors=0" -d "html_errors=0" -d "track_errors=0" -d "report_zend_debug=0" -d "docref_root=" -d "docref_ext=.html" -d "error_prepend_string=" -d "error_append_string=" -d "auto_prepend_file=" -d "auto_append_file=" -d "ignore_repeated_errors=0" -d "precision=14" -d "serialize_precision=-1" -d "memory_limit=128M" -d "opcache.fast_shutdown=0" -d "opcache.file_update_protection=0" -d "opcache.revalidate_freq=0" -d "opcache.jit_hot_loop=1" -d "opcache.jit_hot_func=1" -d "opcache.jit_hot_return=1" -d "opcache.jit_hot_side_exit=1" -d "opcache.jit_max_root_traces=100000" -d "opcache.jit_max_side_traces=100000" -d "opcache.jit_max_exit_counters=100000" -d "opcache.protect_memory=1" -d "zend.assertions=1" -d "zend.exception_ignore_args=0" -d "zend.exception_string_param_max_len=15" -d "short_open_tag=0" -d "extension=./vslim.so" -d "session.auto_start=0" -d "tidy.clean_output=0" -d "zlib.output_compression=Off" -f "/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_app_template_vhttpd_smoke.php"  2>&1
    ;;
"rr")
    rr record $2 '/opt/homebrew/opt/php/bin/php'    -d "output_handler=" -d "open_basedir=" -d "disable_functions=" -d "output_buffering=Off" -d "error_reporting=30719" -d "fatal_error_backtraces=Off" -d "display_errors=1" -d "display_startup_errors=1" -d "log_errors=0" -d "html_errors=0" -d "track_errors=0" -d "report_zend_debug=0" -d "docref_root=" -d "docref_ext=.html" -d "error_prepend_string=" -d "error_append_string=" -d "auto_prepend_file=" -d "auto_append_file=" -d "ignore_repeated_errors=0" -d "precision=14" -d "serialize_precision=-1" -d "memory_limit=128M" -d "opcache.fast_shutdown=0" -d "opcache.file_update_protection=0" -d "opcache.revalidate_freq=0" -d "opcache.jit_hot_loop=1" -d "opcache.jit_hot_func=1" -d "opcache.jit_hot_return=1" -d "opcache.jit_hot_side_exit=1" -d "opcache.jit_max_root_traces=100000" -d "opcache.jit_max_side_traces=100000" -d "opcache.jit_max_exit_counters=100000" -d "opcache.protect_memory=1" -d "zend.assertions=1" -d "zend.exception_ignore_args=0" -d "zend.exception_string_param_max_len=15" -d "short_open_tag=0" -d "extension=./vslim.so" -d "session.auto_start=0" -d "tidy.clean_output=0" -d "zlib.output_compression=Off" -f "/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_app_template_vhttpd_smoke.php"  2>&1
    ;;
*)
    '/opt/homebrew/opt/php/bin/php'    -d "output_handler=" -d "open_basedir=" -d "disable_functions=" -d "output_buffering=Off" -d "error_reporting=30719" -d "fatal_error_backtraces=Off" -d "display_errors=1" -d "display_startup_errors=1" -d "log_errors=0" -d "html_errors=0" -d "track_errors=0" -d "report_zend_debug=0" -d "docref_root=" -d "docref_ext=.html" -d "error_prepend_string=" -d "error_append_string=" -d "auto_prepend_file=" -d "auto_append_file=" -d "ignore_repeated_errors=0" -d "precision=14" -d "serialize_precision=-1" -d "memory_limit=128M" -d "opcache.fast_shutdown=0" -d "opcache.file_update_protection=0" -d "opcache.revalidate_freq=0" -d "opcache.jit_hot_loop=1" -d "opcache.jit_hot_func=1" -d "opcache.jit_hot_return=1" -d "opcache.jit_hot_side_exit=1" -d "opcache.jit_max_root_traces=100000" -d "opcache.jit_max_side_traces=100000" -d "opcache.jit_max_exit_counters=100000" -d "opcache.protect_memory=1" -d "zend.assertions=1" -d "zend.exception_ignore_args=0" -d "zend.exception_string_param_max_len=15" -d "short_open_tag=0" -d "extension=./vslim.so" -d "session.auto_start=0" -d "tidy.clean_output=0" -d "zlib.output_compression=Off" -f "/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_app_template_vhttpd_smoke.php"  2>&1
    ;;
esac