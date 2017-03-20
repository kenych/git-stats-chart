#!/bin/bash

commits_file=stats.txt
git_repo_dir=$1

commits=""
names=""

git -C $git_repo_dir shortlog -s -n --no-merges --author='^(?!jenkins).*$' --perl-regexp > $commits_file
repo_name=${git_repo_dir##*/}

while read commit; do
    read -ra commitArr <<< "$commit"

    if [ "${commitArr[0]}" -gt 2 ];
    then
        if [ -z "${commits}" ];
        then
            commits="$commits${commitArr[0]}"
        else
            commits="$commits,${commitArr[0]}"
        fi

        if [ -z "${names}" ];
        then
            names="$names\"${commitArr[1]}\""
        else
            names="$names,\"${commitArr[1]}\""
        fi
    fi
done < $commits_file

rm $commits_file

cp tpl.html chart.html

sed -i -e "s/var_x/${names}/g" chart.html
sed -i -e "s/var_y/${commits}/g" chart.html
sed -i -e "s/var_repo/${repo_name}/g" chart.html

open chart.html


