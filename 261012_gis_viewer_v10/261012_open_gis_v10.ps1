param([switch]$NoBrowser)
$ErrorActionPreference = 'Stop'
$viewerUrl = 'http://127.0.0.1:8773/261012_viewer_v10_urbiq.html'
$serverFile = Join-Path $PSScriptRoot '261012_serve_v10.mjs'

function Test-GisViewer {
    try {
        $response = Invoke-WebRequest -UseBasicParsing -Uri $viewerUrl -TimeoutSec 2
        if ($response.StatusCode -eq 200 -and $response.Content.Contains('261012_viewer_v10.js')) { return $true }
        throw 'Port 8773 is occupied by a different application.'
    } catch {
        return $false
    }
}

if (-not (Test-Path -LiteralPath $serverFile)) { throw 'GIS server file is missing.' }
if (-not (Test-GisViewer)) {
    $nodeCommand = Get-Command node.exe -ErrorAction SilentlyContinue
    if ($nodeCommand) { $nodePath = $nodeCommand.Source }
    else {
        $nodePath = Join-Path $env:USERPROFILE '.cache/codex-runtimes/codex-primary-runtime/dependencies/node/bin/node.exe'
        if (-not (Test-Path -LiteralPath $nodePath)) { throw 'Node.js was not found. Install Node.js or ask Codex to start the viewer.' }
    }
    $runId = Get-Date -Format 'yyMMdd_HHmmss_fff'
    $stdout = Join-Path $env:TEMP ($runId + '_urbiq_gis_v10_stdout.log')
    $stderr = Join-Path $env:TEMP ($runId + '_urbiq_gis_v10_stderr.log')
    $serverProcess = Start-Process -FilePath $nodePath -ArgumentList ('"' + $serverFile + '"') -WorkingDirectory $PSScriptRoot -WindowStyle Hidden -RedirectStandardOutput $stdout -RedirectStandardError $stderr -PassThru
    $ready = $false
    for ($attempt = 0; $attempt -lt 30; $attempt++) {
        Start-Sleep -Milliseconds 200
        if (Test-GisViewer) { $ready = $true; break }
        if ($serverProcess.HasExited) { throw ('GIS server stopped. See log: ' + $stderr) }
    }
    if (-not $ready) { throw ('GIS server did not become ready. See log: ' + $stderr) }
    Write-Output ('GIS server started in background. PID: ' + $serverProcess.Id)
} else {
    Write-Output 'GIS server is already running.'
}

Write-Output $viewerUrl
if (-not $NoBrowser) { Start-Process -FilePath $viewerUrl }


