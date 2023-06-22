function New-TemporaryPath {
    [CmdletBinding()]
    param ()
    return Join-Path ([System.IO.Path]::GetTempPath()) (New-Guid).ToString()
}

function With-TemporaryDirectory {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [scriptblock]
        $ScriptBlock
    )

    $Path = New-TemporaryPath
    try {
        New-Item -Path $Path -ItemType "directory"
        ForEach-Object -InputObject $Path -Process $ScriptBlock
    }
    finally {
        Remove-Item -Path $Path -Recurse
    }
}
