goBinPath=$(go env GOPATH)/bin
if [ -d $goBinPath ]; then
    export PATH=$PATH:$goBinPath
fi

