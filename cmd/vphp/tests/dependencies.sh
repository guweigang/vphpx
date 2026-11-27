#!/bin/sh
# Controlled package-manager doubles: never install software on the test host.
set -eu
cli=$1
tmp=$(mktemp -d "${TMPDIR:-/tmp}/vphp-dependencies.XXXXXX")
tmp=$(CDPATH='' cd "$tmp" && pwd -P)
trap 'rm -rf "$tmp"' 0
mkdir -p "$tmp/tools"
cat > "$tmp/tool" <<'SH'
#!/bin/sh
name=${0##*/}
case "$name" in
    v)
        [ -z "${VEXE:-}" ] || exit 13
        [ -e "$VPHP_TEST_INSTALLED" ] || exit 1
        if [ "${1:-}" = version ]; then
            printf 'V 0.5.2\n'
        else
            [ "${VPHP_TEST_FAIL_BUILD:-0}" != 1 ] || exit 7
            previous=
            for argument in "$@"; do
                case "$previous" in -dump-c-flags|-o) : > "$argument" ;; esac
                previous=$argument
            done
        fi
        ;;
    php|php85)
        [ -e "$VPHP_TEST_INSTALLED" ] || exit 1
        case "$*" in
            *PHP_ZTS*) printf '0:0' ;;
            *PHP_MAJOR_VERSION*) printf '85' ;;
            *extension=*)
                for argument in "$@"; do
                    case "$argument" in extension=*) test -f "${argument#extension=}" || exit 8 ;; esac
                done
                printf 'OK\n'
                ;;
            *) printf '80500' ;;
        esac
        ;;
    php-config|php-config85)
        [ -e "$VPHP_TEST_INSTALLED" ] || exit 1
        case "$1" in --includes) printf '%s' '-I/mock/php' ;; *) printf '8.5.0\n' ;; esac
        ;;
    cc)
        if [ "${1:-}" != --version ] && [ "${VPHP_TEST_BAD_ABI:-0}" = 1 ]; then
            printf 'PHP CLI and headers have different versions\n'
            exit 1
        fi
        previous=
        for argument in "$@"; do
            case "$previous" in -o) : > "$argument" ;; esac
            previous=$argument
        done
        printf 'mock C compiler\n'
        ;;
    brew|apt-get|dnf|yum|pacman|zypper|apk)
        if [ "$name" = apk ] && [ "${1:-}" = search ]; then
            exact=0
            query=
            for argument in "$@"; do
                [ "$argument" != -x ] || exact=1
                query=$argument
            done
            for package in php84 php85 php85-dev; do
                if [ "$exact" = 1 ]; then
                    [ "$package" != "$query" ] || printf '%s\n' "$package"
                else
                    case "$package" in $query) printf '%s\n' "$package" ;; esac
                fi
            done
            exit 0
        fi
        printf '%s %s\n' "$name" "$*" >> "$VPHP_TEST_INSTALL_LOG"
        [ "${VPHP_TEST_FAIL_INSTALL:-0}" != 1 ] || exit 9
        : > "$VPHP_TEST_INSTALLED"
        ;;
    sudo|doas) exec "$@" ;;
    git|make)
        printf '%s %s\n' "$name" "$*" >> "$VPHP_TEST_INSTALL_LOG"
        if [ "$name" = git ] && [ "${1:-}" = clone ]; then
            target=
            for argument in "$@"; do target=$argument; done
            "$VPHP_TEST_MKDIR" -p "$target"
            : > "$target/Makefile"
        fi
        ;;
    *) exit 2 ;;
esac
SH
for name in v php php-config cc brew apt-get dnf yum pacman zypper apk sudo doas git make; do
    cp "$tmp/tool" "$tmp/tools/$name"
    chmod +x "$tmp/tools/$name"
done
export VPHP_TEST_INSTALLED="$tmp/installed" VPHP_TEST_INSTALL_LOG="$tmp/install.log"
export XDG_DATA_HOME="$tmp/data space"
export HOMEBREW_PREFIX="$tmp/empty-brew"
export VPHP_TEST_MKDIR="$(command -v mkdir)"
unset VPHP_V VPHP_PHP VPHP_PHP_CONFIG VPHP_CC
# Repeated previews must leave the fake package manager untouched.
PATH="$tmp/tools" "$cli" setup --dry-run > "$tmp/preview.log"
PATH="$tmp/tools" "$cli" setup --dry-run > "$tmp/dry-run.log"
cmp "$tmp/preview.log" "$tmp/dry-run.log"
test ! -e "$tmp/install.log"
status=0
PATH="$tmp/tools" "$cli" doctor > "$tmp/missing.log" 2>&1 || status=$?
test "$status" = 1
# A failing package manager must stop installation and return failure.
status=0
VPHP_TEST_FAIL_INSTALL=1 PATH="$tmp/tools" "$cli" setup --yes > "$tmp/failure.log" 2>&1 || status=$?
test "$status" = 1
grep -q 'installation failed' "$tmp/failure.log"
test "$(wc -l < "$tmp/install.log" | tr -d ' ')" = 1
test ! -e "$tmp/installed"
# Success is reported only after rechecking tools and headers.
PATH="$tmp/tools" "$cli" setup > "$tmp/install.out" 2>&1
grep -q 'Setup complete' "$tmp/install.out"
PATH="$tmp/tools" "$cli" doctor > "$tmp/ready.log"
cp "$tmp/install.log" "$tmp/install-before.log"
PATH="$tmp/tools" "$cli" setup --yes > "$tmp/again.log"
cmp "$tmp/install.log" "$tmp/install-before.log"
grep -q 'nothing to install' "$tmp/again.log"
# Refuse to hide ABI problems or broken explicit overrides by installing defaults.
status=0
VPHP_TEST_BAD_ABI=1 PATH="$tmp/tools" "$cli" setup --yes > "$tmp/abi.log" 2>&1 || status=$?
test "$status" = 1
grep -q 'incompatible' "$tmp/abi.log"
status=0
VPHP_V="$tmp/nonexistent-v" PATH="$tmp/tools" "$cli" setup --yes > "$tmp/override.log" 2>&1 || status=$?
test "$status" = 1
grep -q 'explicit override' "$tmp/override.log"
cmp "$tmp/install.log" "$tmp/install-before.log"
mv "$tmp/tools/v" "$tmp/saved-v"
mkdir -p "$XDG_DATA_HOME/vphp/toolchains/v"
cp "$tmp/saved-v" "$XDG_DATA_HOME/vphp/toolchains/v/v"
PATH="$tmp/tools" "$cli" doctor > "$tmp/managed-v.log"
grep -Fq "$XDG_DATA_HOME/vphp/toolchains/v/v" "$tmp/managed-v.log"
# A broken build must not be reported as a successful setup, even if doctor passes.
status=0
VPHP_TEST_FAIL_BUILD=1 PATH="$tmp/tools" "$cli" setup > "$tmp/build-failure.log" 2>&1 || status=$?
test "$status" = 1
if grep -q 'Setup complete' "$tmp/build-failure.log"; then exit 1; fi
# Alpine-style executable names must also work on later invocations.
mv "$tmp/tools/php" "$tmp/saved-php"
mv "$tmp/tools/php-config" "$tmp/saved-php-config"
cp "$tmp/tool" "$tmp/tools/php85"
cp "$tmp/tool" "$tmp/tools/php-config85"
chmod +x "$tmp/tools/php85" "$tmp/tools/php-config85"
PATH="$tmp/tools" "$cli" doctor > "$tmp/versioned-php.log"
grep -Fq "$tmp/tools/php85" "$tmp/versioned-php.log"
grep -Fq "$tmp/tools/php-config85" "$tmp/versioned-php.log"
PATH="$tmp/tools" "$cli" setup > "$tmp/versioned-setup.log" 2>&1
grep -q 'Setup complete' "$tmp/versioned-setup.log"
printf '%s\n' 'VPHP dependency setup smoke passed'
