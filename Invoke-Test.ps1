Describe 'Testing YinYang presentation' {
    It 'Given BrokenScript is called, it throws exception' {
        { .\BrokenScript.ps1 } | Should Throw
    }

    It 'Given I have broken test, build fails' {
        0 | Should Be 1
    }
}