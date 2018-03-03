$ErrorActionPreference = "Stop"

Clear

Remove-Item ".\*.nupkg"

Get-ChildItem ".\" -Recurse -Include *.nuspec | `

Foreach-Object {
    Write-Host "Building NuGet package '$($_.Name)'"

    & ".\nuget.exe" pack $_.FullName -BasePath "$($_.DirectoryName)" -OutputDirectory ".\"

    if ($LASTEXITCODE -ne 0)
    {
        Write-Error "Error generating nupkg for '$($_.Name)'"
        break
    }
}
