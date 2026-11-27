param([Parameter(Mandatory=$true)][string]$Output)
$ErrorActionPreference = 'Stop'
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..')).Path
$scratch = Join-Path ([IO.Path]::GetTempPath()) ('vphp-package-' + [guid]::NewGuid())
New-Item -ItemType Directory -Path $scratch | Out-Null
try {
    Get-ChildItem (Join-Path $repo 'cmd\vphp') -Filter '*.v' | Where-Object { $_.Name -notlike '*_test.v' } | Copy-Item -Destination $scratch
    Copy-Item (Join-Path $repo 'cmd\vphp\v.mod') $scratch
    & python (Join-Path $PSScriptRoot 'embed-sdk.py') (Join-Path $repo 'vphp') (Join-Path $scratch 'sdk.json')
    if ($LASTEXITCODE -ne 0) { throw 'SDK packaging failed' }
    $compiler = if ($env:VPHP_V) { $env:VPHP_V } else { 'v' }
    $fullOutput = [IO.Path]::GetFullPath($Output)
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $fullOutput) | Out-Null
    & $compiler -prod -gc none -cc msvc -path "$repo;@vlib" -d vphp_bundled -o $fullOutput $scratch
    if ($LASTEXITCODE -ne 0) { throw 'VPHP CLI compilation failed' }
    Write-Host $fullOutput
} finally {
    Remove-Item -Recurse -Force $scratch
}
