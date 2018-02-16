$splatXml = @{
    Namespace = @{
        wpf = 'http://schemas.microsoft.com/winfx/2006/xaml/presentation'
    }
}

Describe 'Testing XAML syntax for potential issues' {
    foreach ($xamlFile in Get-ChildItem -Path .\*.xaml) {
        Context "Testing $($xamlFile.Name)" {
            It 'File contains valid XML' {
                $xml = [xml]::new()
                try {
                    $xml.Load($xamlFile.FullName)
                } catch {
                    $exception = $_.Exception
                }
                $exception.Message | Should BeNullOrEmpty
            }
            It "Given XAML file contains image, file exists" {
                Select-Xml -Path $xamlFile.FullName @splatXml -XPath "//wpf:Image" |
                    ForEach-Object { $_.Node.Source } | Should Exist 
            }
        }
    }
}