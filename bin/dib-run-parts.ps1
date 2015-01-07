Param(
  [switch]$list
)

$name = $myInvocation.MyCommand.Name
$scriptDir = $Args[0]

function usage(){
	echo "Usage: $name [OPTION] scripts_directory"
    echo "Option:"
    echo "      -list  print names of all valid files"
    echo ""
    echo "Examples:"
    echo "      $name -list C:\tripleo\os-config-refresh\configure.d\"
    echo "      $name C:\tripleo\os-config-refresh\configure.d\"
    exit 1
}

$scriptDirExists = Test-Path $scriptDir
if ($scriptDirExists -eq $false){
	echo "Target dir does not exist"
	exit 1
}

$targets = (ls $scriptDir).FullName -match ".ps1$|.cmd$|.exe$|.bat$"

if ($list -eq $true){
	$targets
	exit 0
}

$envDir = "$scriptDir\..\environment.d\"
$envDirExists = Test-Path $envDir

if ($envDirExists -eq $true) {
	$files = (ls $envDir).FullName -match ".ps1$"
	foreach ($i in $files){
		. $i
	}
}

foreach ($i in $targets){
	echo "Running $i"
	& $i
}