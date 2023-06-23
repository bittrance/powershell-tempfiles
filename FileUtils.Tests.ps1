Describe "New-TemporaryPath" {
    BeforeAll {
        . $PSScriptRoot/FileUtils.ps1
    }

    It "creates unique names" {
        $Names = @{}
        foreach ($n in 1..1000) {
            $Names[$(New-TemporaryPath)] = $true
        }
        $Names.Count | Should -Be 1000
    }

    It "creates a path which is anchored at OS temp dir" {
        New-TemporaryPath | Should -BeLikeExactly "$([System.IO.Path]::GetTempPath())*"
    }

    It "does not create actual files" {
        Test-Path (New-TemporaryPath) | Should -Be $false
    }
}

Describe "Use-TemporaryDirectory" {
    BeforeAll {
        . $PSScriptRoot/FileUtils.ps1
    }

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
}