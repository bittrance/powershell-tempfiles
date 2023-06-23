# .SYNOPSIS
# Returns the full path to a uniquely named temporary file. The file is not created.
# .OUTPUTS
# [string]
# .DESCRIPTION
# This function exists because New-TemporaryFile file names can be guessed and use only a small number of characters. This function uses a GUID to generate a unique name.
# .LINK
# https://github.com/bittrance/powershell-tempfiles
function New-TemporaryPath {
    [OutputType([string])]
    [CmdletBinding()]
    param ()
    return Join-Path ([System.IO.Path]::GetTempPath()) (New-Guid).ToString()
}

# .SYNOPSIS
# Create a temporary directory and expose as psitem to the provided scriptblock.
# .DESCRIPTION
# Create a temporary directory and expose as psitem to the provided scriptblock. The directory is removed when leaving the block, even if an exception is raised. Note that current working directory is not changed.
# .EXAMPLE
# Use-TemporaryDirectory {
#    foreach ($n in 1..10) {
#        Invoke-RestMethod -Uri https://example.com/parts/$n -OutFile (Join-Path $_ "part-$n")
#    }
#    # Process the files ...
# }
# .LINK
# https://github.com/bittrance/powershell-tempfiles
function Use-TemporaryDirectory {
    [CmdletBinding(
        HelpUri = "https://github.com/bittrance/powershell-tempfiles"
    )]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = "Code workning with the temporary directory."
        )]
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
