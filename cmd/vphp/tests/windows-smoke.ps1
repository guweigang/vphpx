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
    & $Cli check $project
    if ($LASTEXITCODE -ne 0) { throw 'check failed' }
    & $Cli build $project
    if ($LASTEXITCODE -ne 0) { throw 'build failed' }
    $extension = Join-Path $project 'build\php_demo.dll'
    if (!(Test-Path $extension)) { throw 'extension DLL missing' }
    & php -n -d "extension=$extension" (Join-Path $project 'tests\smoke.php')
    if ($LASTEXITCODE -ne 0) { throw 'extension smoke failed' }
    & $Cli stub $project
    if ($LASTEXITCODE -ne 0) { throw 'stub failed' }
    & php -n -l (Join-Path $project 'build\demo.php')
    if ($LASTEXITCODE -ne 0) { throw 'stub lint failed' }
} finally {
    Remove-Item -Recurse -Force $scratch
}
