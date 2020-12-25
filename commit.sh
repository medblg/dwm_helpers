#! /bin/bash

# will commit remotly current branch and merge all branches with master..and commit remotly

Name="$1"
git add . 
git commit -m $Name
git checkout master 

for Branch in $(git branch | sed 's/[ *]*\([a-zA-Z]*\)/\1/g'); # list all branches
    do
	if [[ "$Branch" != "master" ]];then
	    git merge $Branch -m $Branch # merge branch with master
	    git push origin $Branch # push branch
	fi
done
git push # will push successful changes to master branch

echo "now manually build dwm :"
echo "rm -f config.h && sudo make clean install" # build dwm
