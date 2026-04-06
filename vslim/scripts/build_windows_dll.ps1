param(
    [string]$PhpVersion = "",
    [string]$PhpDir = "",
    [string]$OutputName = "php_vslim.dll"
)

$ErrorActionPreference = "Stop"

function Get-PhpVersion {
    if ($PhpVersion -ne "") {
        return $PhpVersion
    }
    return (& php -r "echo PHP_VERSION;").Trim()
}

function Get-PhpDir {
    if ($PhpDir -ne "") {
        return (Resolve-Path $PhpDir).Path
    }
    $phpExe = (Get-Command php).Source
    return Split-Path -Parent $phpExe
}

function Get-DevelArchiveName([string]$version) {
    $nts = (& php -r "echo PHP_ZTS ? 'ts' : 'nts';").Trim()
    if ($nts -ne "nts") {
        throw "Only NTS PHP is supported by the current Windows VSlim build script. Detected: $nts"
    }
    return "php-devel-pack-$version-$nts-Win32-vs17-x64.zip"
}

function Invoke-Cmd([string]$WorkingDirectory, [string]$CommandLine) {
    Push-Location $WorkingDirectory
    try {
        & cmd /c $CommandLine
        if ($LASTEXITCODE -ne 0) {
            throw "Command failed with exit code ${LASTEXITCODE}: $CommandLine"
        }
    } finally {
        Pop-Location
    }
}

function Assert-CommandAvailable([string]$CommandName) {
    $cmd = Get-Command $CommandName -ErrorAction SilentlyContinue
    if ($null -eq $cmd) {
        throw "Required command not found in PATH: $CommandName"
    }
    return $cmd.Source
}

function Find-FirstPath([string[]]$Candidates, [string]$ChildPath) {
    foreach ($candidate in $Candidates) {
        if ([string]::IsNullOrWhiteSpace($candidate)) {
            continue
        }
        $resolved = $candidate.Trim()
        if (!(Test-Path $resolved)) {
            continue
        }
        if ($ChildPath -eq "") {
            return (Resolve-Path $resolved).Path
        }
        $probe = Join-Path $resolved $ChildPath
        if (Test-Path $probe) {
            return (Resolve-Path $resolved).Path
        }
    }
    return ""
}

function Find-FirstFileRecursive([string]$Root, [string[]]$FileNames) {
    if ([string]::IsNullOrWhiteSpace($Root) -or !(Test-Path $Root)) {
        return ""
    }
    foreach ($fileName in $FileNames) {
        $match = Get-ChildItem -Path $Root -Filter $fileName -File -Recurse -ErrorAction SilentlyContinue |
            Select-Object -First 1
        if ($null -ne $match) {
            return (Resolve-Path $match.FullName).Path
        }
    }
    return ""
}

function Find-OpenSslRoot {
    $candidates = @(
        $env:OPENSSL_ROOT_DIR,
        $env:OPENSSL_DIR,
        "C:\Program Files\OpenSSL",
        "C:\Program Files\OpenSSL-Win64",
        "C:\OpenSSL-Win64"
    )
    return Find-FirstPath $candidates "include\openssl\ssl.h"
}

function Find-OpenSslLibDir([string]$OpenSslRoot) {
    $candidates = @(
        (Join-Path $OpenSslRoot "lib\VC\x64\MD"),
        (Join-Path $OpenSslRoot "lib\VC\static"),
        (Join-Path $OpenSslRoot "lib\VC\x64\MT"),
        (Join-Path $OpenSslRoot "lib64"),
        (Join-Path $OpenSslRoot "lib")
    )
    foreach ($candidate in $candidates) {
        if ([string]::IsNullOrWhiteSpace($candidate) -or !(Test-Path $candidate)) {
            continue
        }
        if (Get-ChildItem -Path $candidate -Filter "libssl*.lib" -File | Select-Object -First 1) {
            return (Resolve-Path $candidate).Path
        }
    }
    return ""
}

function Find-OpenSslLibName([string]$LibDir, [string]$Pattern) {
    $match = Get-ChildItem -Path $LibDir -Filter $Pattern -File | Sort-Object Name | Select-Object -First 1
    if ($null -eq $match) {
        return ""
    }
    return $match.Name
}

function Find-MySqlRoot {
    $candidates = @(
        $env:VSLIM_MYSQL_ROOT,
        $env:MARIADB_CONNECTOR_C_ROOT,
        $env:MYSQL_ROOT,
        $env:VCPKG_INSTALLED_DIR
    )
    foreach ($candidate in $candidates) {
        if ([string]::IsNullOrWhiteSpace($candidate)) {
            continue
        }
        $resolved = $candidate.Trim()
        Write-Host "Probing MariaDB/MySQL SDK candidate: $resolved"
        if (!(Test-Path $resolved)) {
            Write-Host "  -> path missing"
            continue
        }
        $headerPath = Find-FirstFileRecursive $resolved @("mysql.h")
        $importLibPath = Find-FirstFileRecursive $resolved @("libmariadb.lib", "mysqlclient.lib")
        if ($headerPath -ne "") {
            Write-Host "  -> header: $headerPath"
        } else {
            Write-Host "  -> header: <not found>"
        }
        if ($importLibPath -ne "") {
            Write-Host "  -> import lib: $importLibPath"
        } else {
            Write-Host "  -> import lib: <not found>"
        }
        if ($headerPath -ne "" -and $importLibPath -ne "") {
            return (Resolve-Path $resolved).Path
        }
    }
    return ""
}

function Find-MySqlIncludeDir([string]$Root) {
    $headerPath = Find-FirstFileRecursive $Root @("mysql.h")
    if ($headerPath -eq "") {
        return ""
    }
    return Split-Path -Parent $headerPath
}

function Find-MySqlLibDir([string]$Root) {
    $importLibPath = Find-FirstFileRecursive $Root @("libmariadb.lib", "mysqlclient.lib")
    if ($importLibPath -eq "") {
        return ""
    }
    return Split-Path -Parent $importLibPath
}

function Find-MySqlLibName([string]$LibDir) {
    $libMaria = Get-ChildItem -Path $LibDir -Filter "libmariadb.lib" -File | Select-Object -First 1
    if ($null -ne $libMaria) {
        return $libMaria.Name
    }
    $mysqlClient = Get-ChildItem -Path $LibDir -Filter "mysqlclient.lib" -File | Select-Object -First 1
    if ($null -ne $mysqlClient) {
        return $mysqlClient.Name
    }
    return ""
}

function Find-MySqlRuntimeDll([string]$Root) {
    return Find-FirstFileRecursive $Root @("libmariadb.dll", "libmysql.dll")
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$vslimRoot = (Resolve-Path (Join-Path $repoRoot "vslim")).Path
$vphpRoot = (Resolve-Path (Join-Path $repoRoot "vphp")).Path
$vExe = (Get-Command v).Source
$vRoot = Split-Path -Parent $vExe
$clExe = Assert-CommandAvailable "cl.exe"
$nmakeExe = Assert-CommandAvailable "nmake.exe"
$resolvedPhpDir = Get-PhpDir
$resolvedPhpVersion = Get-PhpVersion

Write-Host "Using MSVC compiler: $clExe"
Write-Host "Using NMake: $nmakeExe"
Write-Host "Using PHP runtime: $resolvedPhpDir"
Write-Host "Using PHP version: $resolvedPhpVersion"

$archiveName = Get-DevelArchiveName $resolvedPhpVersion
$archiveUrl = "https://windows.php.net/downloads/releases/$archiveName"
$runnerTemp = if ($env:RUNNER_TEMP) { $env:RUNNER_TEMP } else { [System.IO.Path]::GetTempPath() }
$develCacheDir = Join-Path $runnerTemp "vslim-php-devel"
$archivePath = Join-Path $develCacheDir $archiveName
$extractRoot = Join-Path $develCacheDir "extract"

New-Item -ItemType Directory -Force -Path $develCacheDir | Out-Null

if (!(Test-Path $archivePath)) {
    Invoke-WebRequest -Uri $archiveUrl -OutFile $archivePath
}

if (Test-Path $extractRoot) {
    Remove-Item -Recurse -Force $extractRoot
}
Expand-Archive -Path $archivePath -DestinationPath $extractRoot -Force

$develRoot = Get-ChildItem -Path $extractRoot -Directory | Select-Object -First 1
if ($null -eq $develRoot) {
    throw "Unable to locate extracted PHP devel pack directory."
}
Write-Host "Using PHP devel pack: $($develRoot.FullName)"

$env:VSLIM_VPHP_DIR = $vphpRoot
$env:VSLIM_V_ROOT = $vRoot
$openSslRoot = Find-OpenSslRoot
if ($openSslRoot -eq "") {
    throw "Unable to locate an OpenSSL installation with headers on this runner."
}
$openSslLibDir = Find-OpenSslLibDir $openSslRoot
if ($openSslLibDir -eq "") {
    throw "Unable to locate OpenSSL import libraries under $openSslRoot"
}
$env:VSLIM_OPENSSL_INCLUDE = Join-Path $openSslRoot "include"
$env:VSLIM_OPENSSL_LIB = $openSslLibDir
$env:VSLIM_OPENSSL_SSL_LIB = Find-OpenSslLibName $openSslLibDir "libssl*.lib"
$env:VSLIM_OPENSSL_CRYPTO_LIB = Find-OpenSslLibName $openSslLibDir "libcrypto*.lib"
if ($env:VSLIM_OPENSSL_SSL_LIB -eq "") {
    throw "Unable to locate an OpenSSL SSL import library under $openSslLibDir"
}
if ($env:VSLIM_OPENSSL_CRYPTO_LIB -eq "") {
    throw "Unable to locate an OpenSSL crypto import library under $openSslLibDir"
}

$mySqlRoot = Find-MySqlRoot
if ($mySqlRoot -eq "") {
    throw "Unable to locate a MariaDB/MySQL client SDK. Set VSLIM_MYSQL_ROOT or MARIADB_CONNECTOR_C_ROOT."
}
$mySqlIncludeDir = Find-MySqlIncludeDir $mySqlRoot
if ($mySqlIncludeDir -eq "") {
    throw "Unable to locate MariaDB/MySQL headers under $mySqlRoot"
}
$mySqlLibDir = Find-MySqlLibDir $mySqlRoot
if ($mySqlLibDir -eq "") {
    throw "Unable to locate MariaDB/MySQL import libraries under $mySqlRoot"
}
$mySqlClientLib = Find-MySqlLibName $mySqlLibDir
if ($mySqlClientLib -eq "") {
    throw "Unable to locate libmariadb.lib or mysqlclient.lib under $mySqlLibDir"
}
$mySqlRuntimeDll = Find-MySqlRuntimeDll $mySqlRoot

Write-Host "Using MariaDB/MySQL SDK root: $mySqlRoot"
Write-Host "Using MariaDB/MySQL include dir: $mySqlIncludeDir"
Write-Host "Using MariaDB/MySQL lib dir: $mySqlLibDir"
Write-Host "Using MariaDB/MySQL import lib: $mySqlClientLib"
if ($mySqlRuntimeDll -ne "") {
    Write-Host "Using MariaDB/MySQL runtime DLL: $mySqlRuntimeDll"
}

$env:VSLIM_MYSQL_INCLUDE = $mySqlIncludeDir
$env:VSLIM_MYSQL_LIB = $mySqlLibDir
$env:VSLIM_MYSQL_CLIENT_LIB = $mySqlClientLib

$phpizePath = Join-Path $develRoot.FullName "phpize.bat"
if (!(Test-Path $phpizePath)) {
    throw "phpize.bat not found in devel pack: $phpizePath"
}

if (Test-Path (Join-Path $vslimRoot "configure.bat")) {
    Remove-Item -Force (Join-Path $vslimRoot "configure.bat")
}

Invoke-Cmd $vslimRoot "`"$phpizePath`""
Invoke-Cmd $vslimRoot "configure --enable-vslim=shared --with-prefix=`"$resolvedPhpDir`" --with-php-build=`"$($develRoot.FullName)`""
Invoke-Cmd $vslimRoot "nmake"

$dll = Get-ChildItem -Path $vslimRoot -Recurse -Filter $OutputName | Sort-Object FullName | Select-Object -First 1
if ($null -eq $dll) {
    throw "Unable to find built $OutputName under $vslimRoot"
}

$targetPath = Join-Path $vslimRoot $OutputName
if ($dll.FullName -ne $targetPath) {
    Copy-Item -Force $dll.FullName $targetPath
}

if ($mySqlRuntimeDll -ne "") {
    Copy-Item -Force $mySqlRuntimeDll (Join-Path $vslimRoot (Split-Path -Leaf $mySqlRuntimeDll))
    Write-Host "Copied MySQL runtime DLL: $mySqlRuntimeDll"
}

Write-Host "Built Windows DLL: $targetPath"
