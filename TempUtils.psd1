@{
    ModuleVersion     = '0.1.0'
    GUID              = 'bb326e87-12bd-4e03-b829-da35fc4652c5'
    Author            = 'bittrance@gmail.com'
    CompanyName       = 'Bittrance'
    Copyright         = 'This software is released under MIT License.'
    Description       = 'Helpers for temporary files and directories.'
    FunctionsToExport = @()
    CmdletsToExport   = @('Get-TemporaryPath', 'Use-TemporaryDirectory')
    VariablesToExport = '*'
    AliasesToExport   = @()
    RootModule        = 'TempUtils.psm1'
    PrivateData       = @{
        PSData = @{
            Tags       = @('tempfile', 'tempdir', 'temporary', 'file', 'directory')
            ProjectUri = 'https://github.com/bittrance/powershell-tempfiles'
        }
    }
}
