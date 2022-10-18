#!/bin/bash

for package in `apt list | awk -F '/' '{print $1}' | sort --random-sort | head -n 40`; do 
echo "downloading $package"
outp=`apt source $package 2>&1`
git_url=`echo $outp | grep -o "http[:/.a-z0-9_-]\+\\.git" | head -1`
actual_package=`echo $outp | grep -o "Picking \\(.*\\) as source package" | cut -d"'" -f2`
echo "actual_package is $actual_package"
echo "git_url is $git_url"

echo $package >> ../samples.txt
echo $actual_package >> ../samples.txt
echo $git_url >> ../samples.txt

echo "deleting files"

find -type f -iname "*.*" -and -not -iname "*.sh" -delete

find -type f -iname "* *" -delete

echo "searching for scripts"

find -type f -not -iname "*.sh" | xargs file -L 10 | grep -v "\\(Bourne-Again\\|POSIX\\) shell script" | cut -d: -f1 | xargs -L 10 rm -f

echo "deleting empty dirs"

find -type d -empty -delete

echo "moving samples"

ls >> ../samples.txt

echo ";" >> ../samples.txt

for i in *; do
if [ -d "$i" ]; then
mv $i ../samples || rm -rf $i
fi
done

done
