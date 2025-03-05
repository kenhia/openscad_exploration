<#
.SYNOPSIS
    Simple script to run through CSV and print a batch of plates
#>

[CmdletBinding(DefaultParameterSetName = 'path')]
param (
    [Parameter(ParameterSetName = 'path')]
    [string] $Path = (Join-Path -Path $PSScriptRoot -ChildPath 'nameplate_data.json'),

    # If set, regenerate the nameplates even if they already exist
    [Parameter()]
    [switch] $Force,

    [Parameter(Mandatory, ParameterSetName = 'text')]
    [string[]] $TextLines,
    [Parameter(ParameterSetName = 'text')]
    [float] $TextSize = 8,

    # If left as '*', auto-generate based on text
    [Parameter(ParameterSetName = 'text')]
    [string] $BaseName = '*',

    [Parameter()]
    [string] $OutputDir = (Join-Path -Path $PSScriptRoot -ChildPath 'Nameplate_STL'),

    [Parameter(ParameterSetName = 'format')]
    [string] $FormatDataFile
)

function Get-AutoBaseName {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]] $TextLines
    )
    # Translate spaces and "illegal" characters to underlines
    ($TextLines -join '_') -replace '\s|<|>|:|"|/|\\|\||\?|\*', '_'
}

function New-NameplateSTL {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string] $Name,
        [Parameter(Mandatory)]
        [string[]] $TextLines,
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
    $linesText = [System.Text.StringBuilder]::new()
    [void]$linesText.Append('[')
    foreach ($i in $TextLines) {
        [void]$linesText.Append("`"$i`",")
    }
    [void]$linesText.Remove($linesText.Length - 1, 1)
    [void]$linesText.Append(']')
    $textLinesArg = $linesText.ToString()
    Write-Host "Creating nameplate: $textLinesArg ($Tsize) => $outpath"

    $splat = @(
        '-q',
        '--export-format', 'binstl'
        '-o', $outpath
        '-D', "text_lines=$textLinesArg"
        '-D', "tsize=$TSize"
        '.\drawer_nameplate.scad'
    )
    openscad @splat
}

if ($PSCmdlet.ParameterSetName -eq 'format') {
    Write-Host "Formatting: $FormatDataFile"
    if (-not (Test-Path -Path $FormatDataFile -PathType Leaf)) {
        Write-Warning "File not found: $FormatDataFile"
        return
    }
    $d = Get-Content -Path $FormatDataFile -Raw | ConvertFrom-Json
    $sb = [System.Text.StringBuilder]::new()
    [void] $sb.AppendLine('[')
    $firstEntry = $true
    foreach ($item in $d) {
        if (-not $firstEntry) {
            [void] $sb.AppendLine(',')
        }
        $firstEntry = $false
        $jsonCompressed = $item | ConvertTo-Json -Compress
        [void] $sb.Append("    $jsonCompressed")
    }

    [void] $sb.AppendLine()
    [void] $sb.AppendLine(']')

    Set-Content -Path $FormatDataFile -Value $sb.ToString()

    return
}

if (-not (Test-Path -Path $OutputDir -PathType Container)) {
    mkdir $outputDir | Out-Null
}

if ($PSCmdlet.ParameterSetName -eq 'path') {

    if (-not (Test-Path -Path $Path -PathType Leaf)) {
        throw "Missing data file: $Path"
    }
    $data = Get-Content -Path $Path -Raw | ConvertFrom-Json
    foreach ($npd in $data) {
        $base = ($null -ne $npd.basename) ? $npd.basename : (Get-AutoBaseName -TextLines $npd.text_lines)
        $size = ($null -ne $npd.text_size) ? $npd.text_size : $TextSize
        New-NameplateSTL -Name $base -TextLines $npd.text_lines -TSize $size -Force:$Force
    }
}
else {
    $base = ($BaseName -ne '*') ? $BaseName : (Get-AutoBaseName -TextLines $TextLines)
    Write-Host "base: $base"
    New-NameplateSTL -Name $base -TextLines $TextLines -TSize $TextSize -Force:$Force
}