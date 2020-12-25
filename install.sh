#/ /bin/bash

Name="$1" # patch name == branch name
Path="$2" # path to the patch
# get fresh clean of master to other branches
make clean && rm -f config.h && git reset --hard origin/master
git branch "$Name"
git checkout "$Name"
#git apply "$Path" && echo "applied ok !"
patch < "$Path" 





