for i in `git log --author=$1 --since=2015-04-27 --until=2015-08-21 --pretty=oneline | sed 's/ .*//'`
do
    git format-patch -M -C -1 $i
done | tac > series

touch changeset.diff

for i in `cat series`
do
  cat $i >> changeset.diff
done

touch README
echo "series contains the ordered list of all the patches" >> README
echo "changeset.diff contains all the diff's in order." >> README

mkdir patches
mv README patches/
mv *.patch patches/
mv series patches/
mv changeset.diff patches/

zip patches.zip patches/*
rm patches -r
