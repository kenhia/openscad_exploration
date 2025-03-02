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
        [string] $TSize
    )
    $outpath = Join-Path -Path $Script:outputDir -ChildPath "${Name}.stl"
    Write-Host "Creating nameplate: [$T1 | $T2] ($Tsize) => $outpath"
    $t1_arg = "`"$T1`""
    $t2_arg = "`"$T2`""
    openscad -q --export-format binstl -o $outpath -D t1=$t1_arg -D t2=$t2_arg -D tsize=$TSize .\drawer_nameplate.scad
    # openscad -q --export-format binstl -o "$outputDir\np_kenhiatt.stl" -D t1=$t1_arg -D t2=$t2_arg -D tsize=$TSize .\drawer_nameplate.scad
    # openscad -q --export-format binstl -o "$outpath" -D t1=$t1_arg -D t2=$t2_arg tsize=$TSize .\drawer_nameplate.scad
}

# New-NameplateSTL -Name 'np_kenhiatt' -T1 'Ack!' -T2 'Phwwt!' -TSize 8

# Get the data
$data = Import-Csv -Path $Script:inputCsvPath
foreach ($npd in $data) {
    New-NameplateSTL -Name $npd.basename -T1 $npd.t1 -T2 $npd.t2 -TSize $npd.text_size
}