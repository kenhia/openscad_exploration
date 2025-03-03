<#
.SYNOPSIS
    Simple script to run through CSV and print a batch of plates
#>

[CmdletBinding()]
param (
    # If set, regenerate the nameplates even if they already exist
    [Parameter()]
    [switch] $Force
)

$Script:outputDir = Join-Path -Path $PSScriptRoot -ChildPath 'Nameplate_STL'
if (-not (Test-Path -Path $outputDir -PathType Container)) {
    mkdir $outputDir | Out-Null
}
$Script:inputCsvPath = Join-Path -Path $PSScriptRoot -ChildPath 'nameplate_data.csv'
if (-not (Test-Path -Path $inputCsvPath -PathType Leaf)) {
    throw "Missing data file: $inputCsvPath"
}

function New-NameplateSTL {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string] $Name,
        [Parameter(Mandatory)]
        [string] $T1,
        [Parameter(Mandatory)]
        [string] $T2,
        [Parameter(Mandatory)]
        [string] $TSize,
        [Parameter()]
        [switch] $Force
    )
    $outpath = Join-Path -Path $Script:outputDir -ChildPath "${Name}.stl"
    if (-not $Force -and (Test-Path -Path $outpath)) {
        Write-Host "Nameplate exists: $outpath" -ForegroundColor DarkGreen
        return
    }
    Write-Host "Creating nameplate: [$T1 | $T2] ($Tsize) => $outpath"
    $text_lines = "[`"$T1`", `"$T2`"]"
    openscad -q --export-format binstl -o $outpath -D text_lines=$text_lines -D tsize=$TSize .\drawer_nameplate.scad
}

# Get the data
$data = Import-Csv -Path $Script:inputCsvPath
foreach ($npd in $data) {
    New-NameplateSTL -Name $npd.basename -T1 $npd.t1 -T2 $npd.t2 -TSize $npd.text_size
}