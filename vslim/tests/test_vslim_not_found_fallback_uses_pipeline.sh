#!/bin/sh

unset $(env | cut -d= -f1)
export AZURE_OPENAI_API_KEY="${AZURE_OPENAI_API_KEY:-}"
export CLICOLOR='1'
export CODEX_CI='1'
export CODEX_INTERNAL_ORIGINATOR_OVERRIDE='Codex Desktop'
export CODEX_SANDBOX='seatbelt'
export CODEX_SANDBOX_NETWORK_DISABLED='1'
export CODEX_SHELL='1'
export CODEX_THREAD_ID='019daf41-66a0-7c80-ba86-d3990da5ca1f'
export COMMAND_MODE='unix2003'
export DISABLE_AUTO_UPDATE='true'
export FEISHU_APP_ID="${FEISHU_APP_ID:-}"
export FEISHU_APP_SECRET="${FEISHU_APP_SECRET:-}"
export FEISHU_ENCRYPT_KEY="${FEISHU_ENCRYPT_KEY:-}"
export FEISHU_VERIFICATION_TOKEN="${FEISHU_VERIFICATION_TOKEN:-}"
export FPATH='/Users/guweigang/.config/kaku/zsh/plugins/zsh-z:/Users/guweigang/.config/kaku/zsh/plugins/zsh-completions/src:/opt/homebrew/share/zsh/site-functions:/usr/local/share/zsh/site-functions:/usr/share/zsh/site-functions:/usr/share/zsh/5.9/functions:/Applications/OrbStack.app/Contents/MacOS/../Resources/completions/zsh'
export GH_PAGER='cat'
export GIT_PAGER='cat'
export HOME='/Users/guweigang'
export HOMEBREW_CELLAR='/opt/homebrew/Cellar'
export HOMEBREW_PREFIX='/opt/homebrew'
export HOMEBREW_REPOSITORY='/opt/homebrew'
export INFOPATH='/opt/homebrew/share/info:/opt/homebrew/share/info:'
export KAKU_ZSH_DIR='/Users/guweigang/.config/kaku/zsh'
export LANG='C.UTF-8'
export LC_ALL='C.UTF-8'
export LC_CTYPE='C.UTF-8'
export LOGNAME='guweigang'
export LOG_FORMAT='json'
export LSCOLORS='gxfxcxdxbxegedabagacad'
export MallocNanoZone='0'
export NO_COLOR='1'
export OLDPWD='/Users/guweigang/Source/vphpx'
export OSLogRateLimit='64'
export PAGER='cat'
export PASEO_RELAY_ENDPOINT='paseo.bullsoft.org:443'
export PASEO_RELAY_PUBLIC_ENDPOINT='paseo.bullsoft.org:443'
export PATH='/Users/guweigang/.codex/tmp/arg0/codex-arg0lIZb9i:/Users/guweigang/.opencode/bin:/Users/guweigang/.cargo/bin:/Users/guweigang/.opencode/bin:/Users/guweigang/.config/kaku/zsh/bin:/Users/guweigang/.bun/bin:/Users/guweigang/bin:/Users/guweigang/local/v:/Users/guweigang/.local/bin:/Users/guweigang/.antigravity/antigravity/bin:/Users/guweigang/.codebuddy/bin:/opt/homebrew/opt/ruby@3.3/bin:/opt/homebrew/lib/ruby/gems/3.3.0/bin:/Users/guweigang/.cherrystudio/bin:/Users/guweigang/.comate/bin:/Applications/Postgres.app/Contents/Versions/latest/bin:/Users/guweigang/.composer/vendor/bin:/opt/homebrew/opt/mysql-client/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/opt/pkg/env/active/bin:/opt/pmk/env/global/bin:/Library/Apple/usr/bin:/usr/local/share/dotnet:~/.dotnet/tools:/Users/guweigang/Library/Application Support/JetBrains/Toolbox/scripts:/Users/guweigang/.orbstack/bin:/Applications/Obsidian.app/Contents/MacOS:/Users/guweigang/.phpkg:/Applications/Codex.app/Contents/Resources'
export PWD='/Users/guweigang/Source/vphpx'
export RUST_LOG='warn'
export SHELL='/bin/zsh'
export SHLVL='1'
export SSH_AUTH_SOCK='deleted'
export STARSHIP_SESSION_KEY='3121925696319241'
export STARSHIP_SHELL='zsh'
export TERM='dumb'
export TMPDIR='/var/folders/ck/vq9ch5jj5gj52vjg5z4kl6th0000gn/T/'
export USER='guweigang'
export VHTTPD_BRIDGE_WS_URL='ws://8.141.85.178:19884/bridge/ws'
export VHTTPD_FEISHU_TEST_CHAT_ID='oc_e89fce0f1979dbf05d0f5303fbe86084'
export VHTTPD_FEISHU_TEST_IMAGE_PATH='/Users/guweigang/Downloads/alma.png'
export VHTTPD_FEISHU_TEST_IMAGE_URL='https://img.alicdn.com/imgextra/i3/O1CN01czcUm71Zge2U79oEw_!!6000000003224-2-tps-1344-1019.png'
export XPC_FLAGS='0x0'
export XPC_SERVICE_NAME='0'
export ZSHZ_CASE='smart'
export ZSH_TMUX_AUTOSTART='false'
export ZSH_TMUX_AUTOSTARTED='true'
export __CFBundleIdentifier='com.openai.codex'
export __CF_USER_TEXT_ENCODING='0x1F5:0x19:0x34'
export all_proxy='socks5://127.0.0.1:7897'
export http_proxy='http://127.0.0.1:7897'
export https_proxy='http://127.0.0.1:7897'
export TEST_PHP_EXECUTABLE='/opt/homebrew/bin/php'
export _='/opt/homebrew/bin/php'
export SSH_CLIENT='deleted'
export SSH_TTY='deleted'
export SSH_CONNECTION='deleted'
export TEMP='/var/folders/ck/vq9ch5jj5gj52vjg5z4kl6th0000gn/T'
export NO_INTERACTION='1'
export SKIP_ONLINE_TESTS='1'
export SKIP_IO_CAPTURE_TESTS='1'
export TEST_PHP_EXECUTABLE_ESCAPED=''\''/opt/homebrew/bin/php'\'''
export TEST_PHP_CGI_EXECUTABLE='/opt/homebrew/Cellar/php/8.5.5_1/bin/php-cgi'
export TEST_PHP_CGI_EXECUTABLE_ESCAPED=''\''/opt/homebrew/Cellar/php/8.5.5_1/bin/php-cgi'\'''
export TEST_PHPDBG_EXECUTABLE='/opt/homebrew/Cellar/php/8.5.5_1/bin/phpdbg'
export TEST_PHPDBG_EXECUTABLE_ESCAPED=''\''/opt/homebrew/Cellar/php/8.5.5_1/bin/phpdbg'\'''
export REDIRECT_STATUS='1'
export PATH_TRANSLATED='/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_not_found_fallback_uses_pipeline.php'
export SCRIPT_FILENAME='/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_not_found_fallback_uses_pipeline.php'
export REQUEST_METHOD='GET'
export TEST_PHP_EXTRA_ARGS='  -d "output_handler=" -d "open_basedir=" -d "disable_functions=" -d "output_buffering=Off" -d "error_reporting=30719" -d "fatal_error_backtraces=Off" -d "display_errors=1" -d "display_startup_errors=1" -d "log_errors=0" -d "html_errors=0" -d "track_errors=0" -d "report_zend_debug=0" -d "docref_root=" -d "docref_ext=.html" -d "error_prepend_string=" -d "error_append_string=" -d "auto_prepend_file=" -d "auto_append_file=" -d "ignore_repeated_errors=0" -d "precision=14" -d "serialize_precision=-1" -d "memory_limit=128M" -d "opcache.fast_shutdown=0" -d "opcache.file_update_protection=0" -d "opcache.revalidate_freq=0" -d "opcache.jit_hot_loop=1" -d "opcache.jit_hot_func=1" -d "opcache.jit_hot_return=1" -d "opcache.jit_hot_side_exit=1" -d "opcache.jit_max_root_traces=100000" -d "opcache.jit_max_side_traces=100000" -d "opcache.jit_max_exit_counters=100000" -d "opcache.protect_memory=1" -d "zend.assertions=1" -d "zend.exception_ignore_args=0" -d "zend.exception_string_param_max_len=15" -d "short_open_tag=0" -d "extension=/Users/guweigang/Source/vphpx/vslim/vslim.so" -d "session.auto_start=0" -d "tidy.clean_output=0" -d "zlib.output_compression=Off"'

case "$1" in
"gdb")
    gdb -ex 'unset environment LINES' -ex 'unset environment COLUMNS' --args '/opt/homebrew/bin/php'    -d "output_handler=" -d "open_basedir=" -d "disable_functions=" -d "output_buffering=Off" -d "error_reporting=30719" -d "fatal_error_backtraces=Off" -d "display_errors=1" -d "display_startup_errors=1" -d "log_errors=0" -d "html_errors=0" -d "track_errors=0" -d "report_zend_debug=0" -d "docref_root=" -d "docref_ext=.html" -d "error_prepend_string=" -d "error_append_string=" -d "auto_prepend_file=" -d "auto_append_file=" -d "ignore_repeated_errors=0" -d "precision=14" -d "serialize_precision=-1" -d "memory_limit=128M" -d "opcache.fast_shutdown=0" -d "opcache.file_update_protection=0" -d "opcache.revalidate_freq=0" -d "opcache.jit_hot_loop=1" -d "opcache.jit_hot_func=1" -d "opcache.jit_hot_return=1" -d "opcache.jit_hot_side_exit=1" -d "opcache.jit_max_root_traces=100000" -d "opcache.jit_max_side_traces=100000" -d "opcache.jit_max_exit_counters=100000" -d "opcache.protect_memory=1" -d "zend.assertions=1" -d "zend.exception_ignore_args=0" -d "zend.exception_string_param_max_len=15" -d "short_open_tag=0" -d "extension=/Users/guweigang/Source/vphpx/vslim/vslim.so" -d "session.auto_start=0" -d "tidy.clean_output=0" -d "zlib.output_compression=Off" -f "/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_not_found_fallback_uses_pipeline.php"  2>&1
    ;;
"lldb")
    lldb -- '/opt/homebrew/bin/php'    -d "output_handler=" -d "open_basedir=" -d "disable_functions=" -d "output_buffering=Off" -d "error_reporting=30719" -d "fatal_error_backtraces=Off" -d "display_errors=1" -d "display_startup_errors=1" -d "log_errors=0" -d "html_errors=0" -d "track_errors=0" -d "report_zend_debug=0" -d "docref_root=" -d "docref_ext=.html" -d "error_prepend_string=" -d "error_append_string=" -d "auto_prepend_file=" -d "auto_append_file=" -d "ignore_repeated_errors=0" -d "precision=14" -d "serialize_precision=-1" -d "memory_limit=128M" -d "opcache.fast_shutdown=0" -d "opcache.file_update_protection=0" -d "opcache.revalidate_freq=0" -d "opcache.jit_hot_loop=1" -d "opcache.jit_hot_func=1" -d "opcache.jit_hot_return=1" -d "opcache.jit_hot_side_exit=1" -d "opcache.jit_max_root_traces=100000" -d "opcache.jit_max_side_traces=100000" -d "opcache.jit_max_exit_counters=100000" -d "opcache.protect_memory=1" -d "zend.assertions=1" -d "zend.exception_ignore_args=0" -d "zend.exception_string_param_max_len=15" -d "short_open_tag=0" -d "extension=/Users/guweigang/Source/vphpx/vslim/vslim.so" -d "session.auto_start=0" -d "tidy.clean_output=0" -d "zlib.output_compression=Off" -f "/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_not_found_fallback_uses_pipeline.php"  2>&1
    ;;
"valgrind")
    USE_ZEND_ALLOC=0 valgrind $2 '/opt/homebrew/bin/php'    -d "output_handler=" -d "open_basedir=" -d "disable_functions=" -d "output_buffering=Off" -d "error_reporting=30719" -d "fatal_error_backtraces=Off" -d "display_errors=1" -d "display_startup_errors=1" -d "log_errors=0" -d "html_errors=0" -d "track_errors=0" -d "report_zend_debug=0" -d "docref_root=" -d "docref_ext=.html" -d "error_prepend_string=" -d "error_append_string=" -d "auto_prepend_file=" -d "auto_append_file=" -d "ignore_repeated_errors=0" -d "precision=14" -d "serialize_precision=-1" -d "memory_limit=128M" -d "opcache.fast_shutdown=0" -d "opcache.file_update_protection=0" -d "opcache.revalidate_freq=0" -d "opcache.jit_hot_loop=1" -d "opcache.jit_hot_func=1" -d "opcache.jit_hot_return=1" -d "opcache.jit_hot_side_exit=1" -d "opcache.jit_max_root_traces=100000" -d "opcache.jit_max_side_traces=100000" -d "opcache.jit_max_exit_counters=100000" -d "opcache.protect_memory=1" -d "zend.assertions=1" -d "zend.exception_ignore_args=0" -d "zend.exception_string_param_max_len=15" -d "short_open_tag=0" -d "extension=/Users/guweigang/Source/vphpx/vslim/vslim.so" -d "session.auto_start=0" -d "tidy.clean_output=0" -d "zlib.output_compression=Off" -f "/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_not_found_fallback_uses_pipeline.php"  2>&1
    ;;
"rr")
    rr record $2 '/opt/homebrew/bin/php'    -d "output_handler=" -d "open_basedir=" -d "disable_functions=" -d "output_buffering=Off" -d "error_reporting=30719" -d "fatal_error_backtraces=Off" -d "display_errors=1" -d "display_startup_errors=1" -d "log_errors=0" -d "html_errors=0" -d "track_errors=0" -d "report_zend_debug=0" -d "docref_root=" -d "docref_ext=.html" -d "error_prepend_string=" -d "error_append_string=" -d "auto_prepend_file=" -d "auto_append_file=" -d "ignore_repeated_errors=0" -d "precision=14" -d "serialize_precision=-1" -d "memory_limit=128M" -d "opcache.fast_shutdown=0" -d "opcache.file_update_protection=0" -d "opcache.revalidate_freq=0" -d "opcache.jit_hot_loop=1" -d "opcache.jit_hot_func=1" -d "opcache.jit_hot_return=1" -d "opcache.jit_hot_side_exit=1" -d "opcache.jit_max_root_traces=100000" -d "opcache.jit_max_side_traces=100000" -d "opcache.jit_max_exit_counters=100000" -d "opcache.protect_memory=1" -d "zend.assertions=1" -d "zend.exception_ignore_args=0" -d "zend.exception_string_param_max_len=15" -d "short_open_tag=0" -d "extension=/Users/guweigang/Source/vphpx/vslim/vslim.so" -d "session.auto_start=0" -d "tidy.clean_output=0" -d "zlib.output_compression=Off" -f "/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_not_found_fallback_uses_pipeline.php"  2>&1
    ;;
*)
    '/opt/homebrew/bin/php'    -d "output_handler=" -d "open_basedir=" -d "disable_functions=" -d "output_buffering=Off" -d "error_reporting=30719" -d "fatal_error_backtraces=Off" -d "display_errors=1" -d "display_startup_errors=1" -d "log_errors=0" -d "html_errors=0" -d "track_errors=0" -d "report_zend_debug=0" -d "docref_root=" -d "docref_ext=.html" -d "error_prepend_string=" -d "error_append_string=" -d "auto_prepend_file=" -d "auto_append_file=" -d "ignore_repeated_errors=0" -d "precision=14" -d "serialize_precision=-1" -d "memory_limit=128M" -d "opcache.fast_shutdown=0" -d "opcache.file_update_protection=0" -d "opcache.revalidate_freq=0" -d "opcache.jit_hot_loop=1" -d "opcache.jit_hot_func=1" -d "opcache.jit_hot_return=1" -d "opcache.jit_hot_side_exit=1" -d "opcache.jit_max_root_traces=100000" -d "opcache.jit_max_side_traces=100000" -d "opcache.jit_max_exit_counters=100000" -d "opcache.protect_memory=1" -d "zend.assertions=1" -d "zend.exception_ignore_args=0" -d "zend.exception_string_param_max_len=15" -d "short_open_tag=0" -d "extension=/Users/guweigang/Source/vphpx/vslim/vslim.so" -d "session.auto_start=0" -d "tidy.clean_output=0" -d "zlib.output_compression=Off" -f "/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_not_found_fallback_uses_pipeline.php"  2>&1
    ;;
esac
