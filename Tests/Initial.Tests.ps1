Describe 'Testing YinYang presentation' {
    foreach ($script in Get-ChildItem -Path ?_*.ps1) {
        Context "Testing $($script.Name)" {
            $syntaxErrors = $null
            $ast = [System.Management.Automation.Language.Parser]::ParseFile(
                $script.FullName,
                [ref]$null,
                [ref]$syntaxErrors
            )
            It 'Script is syntax-error free' {
                $syntaxErrors.Message -join '; ' | Should BeNullOrEmpty
            }
            
            It 'Script starts with a throw to prevent accidental F5' {
                $ast.EndBlock.Statements[0] | Should BeOfType System.Management.Automation.Language.ThrowStatementAst
            }
        }    
    }
    
    Context 'Testing other scripts used in demos' {
        It 'Given BrokenScript is called, it throws exception' {
            { .\BrokenScript.ps1 } | Should Throw
        }
    }    
}