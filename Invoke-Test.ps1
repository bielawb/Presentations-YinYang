Describe 'Testing YinYang presentation' {
    It 'Given BrokenScript is called, it throws exception' {
        { .\BrokenScript.ps1 } | Should Throw

    }
}