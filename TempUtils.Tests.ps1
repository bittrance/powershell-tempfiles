Import-Module ./TempUtils.psm1

Describe "Get-TemporaryPath" {
    It "creates unique names" {
        $Names = @{}
        foreach ($n in 1..1000) {
            $Names[$(Get-TemporaryPath)] = $true
        }
        $Names.Count | Should -Be 1000
    }

    It "creates a path which is anchored at OS temp dir" {
        Get-TemporaryPath | Should -BeLikeExactly "$([System.IO.Path]::GetTempPath())*"
    }

    It "does not create actual files" {
        Test-Path (Get-TemporaryPath) | Should -Be $false
    }

    It "is documented" {
        (Get-Help Get-TemporaryPath).Synopsis | Should -BeLike '*uniquely named*'
    }
}

Describe "Use-TemporaryDirectory" {
    It "creates a directory and exposes it as current item" {
        Use-TemporaryDirectory {
            Test-Path $_ | Should -Be $true
        }
    }

    It "removes the directory when leaving the block" {
        Use-TemporaryDirectory {
            New-Item -Path $_ -Name "test.txt" -ItemType "file"
        }
        Test-Path $_ | Should -Be $false
    }

    It "removes the directory on failure" {
        try {
            Use-TemporaryDirectory {
                throw "BOOM!"
            }
            $false | Should -Be $true # should not reach here
        }
        catch {
            Test-Path $_ | Should -Be $false
        }
    }

    It "is documented" {
        (Get-Help Use-TemporaryDirectory).Synopsis | Should -BeLike '*temporary directory*'
    }
}