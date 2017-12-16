#region assign result of condition to variable
$logicalCondition = $true -eq 'False'
$result = if ($logicalCondition) {
    'true'
} else {
    'false'
}
#endregion

#region multiple variables at once

$parameter = 'one'

$one, $two, $three = switch ($parameter) {
    one {
        'And one...'
        'And two...'
        'And three...'
    }
    two {
        'And two...'
        'And three...'
        'And four...'
    }
}

#endregion

#region New syntax with .Where ...
$collection = 1, 2, 3, 2, 1
$collection.Where{ $_ -gt 1 }
$collection.Where(
    { $_ -gt 1},			# Condition...	
    1						# Total count...
)

$collection.Where(
    { $_ -gt 1},			# Condition...
    'SkipUntil'				# Mode...
)

$first, $second = $collection.Where(
    { $_ -gt 1},			# Condition...
    'Split',					# Mode...
    2						# Total count...
)

"First: $first"
"Second: $second"

#endregion

#region Where-Object/Foreach-Object 

# can take wildcards... 
ls | % a*
ls | ? le* -gt 4KB

# foreach with method and parameters...
'foo' | % rep* o a
[regex]'(?<=\b)\w' | % rep* 'my awesome title' { $args[0].Value.ToUpper() }

# Why stop there... ;)
[regex]'(?<=\b)\w' | % re* 'my awesome title' { $args | % v* | % *per }

#endregion

#region First come, first serve....
if ($true -or $(Start-Sleep -Seconds 1; $true)) {
    'True!'
}

if ($(Start-Sleep -Seconds 1; $true) -or $true) {
    'False!'
}

if ($false -and $(Start-Sleep -Seconds 1; $false)) {
    'False!'
}

if ($(Start-Sleep -Seconds 1; $false) -and $false) {
    'False!'
}
#endregion

#region *Variable
Get-Date -OutVariable data2
$data2.DayOfWeek

Get-Process -Id 13 -ErrorAction SilentlyContinue -ErrorVariable myError
$myError[0].Exception.Message

Get-ChildItem -Path C:\temp -PipelineVariable filetje -File |
    Get-Acl -PipelineVariable acltje |
    ForEach-Object Access |
    Select-Object FileSystemRights, IdentityReference, @{
        Name = 'The Path'
        Expression = { $filetje.FullName }
    }, @{
        Name = 'The Owner'
        Expression = { $acltje.Owner }
    } -First 5 |
    Format-Table

#endregion
