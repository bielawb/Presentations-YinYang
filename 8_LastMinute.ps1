#region DPS

throw "Hey, Dory! Forgot to use F8?"

#endregion

#region Tip part - PowerShell Workflow

(Get-Command Add-RDSessionHost).ScriptBlock.Ast.FindAll(
    { 
        param ($ast)
        $ast -is [System.Management.Automation.Language.CommandAst] -and
        $ast.CommandElements[0].Value -eq 'Invoke-Command'
    },
    $true
).CommandElements[-1].ScriptBlock.EndBlock.Extent.Text

Copy-Item -LiteralPath C:\Windows\system32\ServerManagerInternal\RDManagement\Add-RDSessionHost.xaml -Destination $PWD
F:\VS\Program\Common7\IDE\devenv.exe /edit $PWD\Add-RDSessionHost.xaml
#endregion

#region Worst practice part - ignoring the filter
Import-Module -Name C:\Windows\system32\ServerManagerInternal\RDManagement
Get-RDSHPool -Alias * | Where-Object { $_.Aliase -eq 'Foo' }
Get-ADUser -Filter * | Where-Object { $_.Department -eq 'IT' }
#endregion
