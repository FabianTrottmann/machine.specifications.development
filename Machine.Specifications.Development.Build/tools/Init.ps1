param($installPath, $toolsPath, $package, $project)
	Copy-Item $installPath\* -Destination . -Recurse -Force -Exclude Init.ps1,*.nuspec,*.nupkg
	Copy-Item .\Gemfile.template .\Gemfile -Force
	Remove-Item .\Gemfile.template