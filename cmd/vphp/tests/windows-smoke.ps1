param([Parameter(Mandatory=$true)][string]$Cli)
$ErrorActionPreference = 'Stop'
$scratch = Join-Path $env:RUNNER_TEMP ('vphp-windows-smoke-' + [guid]::NewGuid())
New-Item -ItemType Directory -Path $scratch | Out-Null
try {
    $project = Join-Path $scratch 'demo'
    & $Cli doctor
    if ($LASTEXITCODE -ne 0) { throw 'doctor failed' }
    & $Cli new $project
    if ($LASTEXITCODE -ne 0) { throw 'new failed' }
    if (!(Test-Path (Join-Path $project 'src/config.toml'))) { throw 'config.toml missing' }
    Add-Content -Encoding utf8 (Join-Path $project 'src/config.v') "`nconst ext_config = vphp.ExtensionConfig{ name: 'demo', version: '0.1.0' }"
    @'
[extension]
name = "demo"
version = "0.1.0"

[ini."demo.answer"]
default = "42"
access = "system"
'@ | Set-Content -Encoding utf8 (Join-Path $project 'src/config.toml')
    & $Cli check $project
    if ($LASTEXITCODE -ne 0) { throw 'check failed' }
    & $Cli build $project
    if ($LASTEXITCODE -ne 0) { throw 'build failed' }
    $extension = Join-Path $project 'build\php_demo.dll'
    if (!(Test-Path $extension)) { throw 'extension DLL missing' }
    & php -n -d "extension=$extension" (Join-Path $project 'tests\smoke.php')
    if ($LASTEXITCODE -ne 0) { throw 'extension smoke failed' }
    & php -n -d "extension=$extension" -r 'if (ini_get($argv[1]) !== $argv[2] || ini_set($argv[1], $argv[3]) !== false) exit(1);' demo.answer 42 1
    if ($LASTEXITCODE -ne 0) { throw 'TOML INI smoke failed' }
    & $Cli stub $project
    if ($LASTEXITCODE -ne 0) { throw 'stub failed' }
    & php -n -l (Join-Path $project 'build\demo.php')
    if ($LASTEXITCODE -ne 0) { throw 'stub lint failed' }
} finally {
    Remove-Item -Recurse -Force $scratch
}
