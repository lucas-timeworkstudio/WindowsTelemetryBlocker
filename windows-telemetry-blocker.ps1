param(
    [switch]$all,
    [string[]]$modules
)

$moduleList = @('telemetry', 'services', 'apps', 'misc')

if ($all) {
    $toRun = $moduleList
} elseif ($modules) {
    $toRun = $modules
} else {
    Write-Host "Specify -all or -modules <list>"
    exit 1
}

foreach ($mod in $toRun) {
    . "$PSScriptRoot\modules\$mod.ps1"
} 