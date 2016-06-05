#!/bin/bash

tar zxf homeworktype0${1}.tar.gz

mkdir kadai/src
mkdir kadai/dummy
mkdir kadai/true

num=1
numtxt=""
dummynum=1
dummynumtxt=""
picnum=1

case "$1" in
  "1" )
  per1=201505081200
  per2=201505221100 ;;
  "2" )
  per1=201508120000
  per2=201508252300 ;;
  "3" )
  per1=201512040000
  per2=201512172300 ;;
  "4" )
  per1=201602161200
  per2=201603011100 ;;
esac


#dummyファイルの分類
while [ $num -le 750 ]
#num,dummynumを0を付け足して4桁,2桁で表す
do
  if [ $num -le 9 ]
    then numtxt="000${num}"
  elif [ $num -le 99 ]
    then numtxt="00${num}"
  elif [ $num -le 750 ]
    then numtxt="0${num}"
  fi

  if [ $dummynum -le 9 ]
  then dummynumtxt="0${dummynum}"
  else dummynumtxt=$dummynum
  fi

  #txt読み込み
  while read line
  do
    txt=$line
  done < "kadai/SRC_${numtxt}.txt"

  let picnum=$txt

  if [[ $txt = 'dummy' ]]
  #左辺が空の時に警告メッセージが出るので警告が出ないようにする
  then
    cp "kadai/IMG_${numtxt}.png" "kadai/dummy/dummy_${dummynumtxt}.png"
    ((dummynum++))
  else
    if [ $picnum -ge $per1 -a $picnum -le $per2 ]
      then convert -pointsize 12 -fill black -draw "text 20,30 '$txt'" "kadai/IMG_${numtxt}.png" "kadai/true/${txt}.png"
    fi

    cp "kadai/IMG_${numtxt}.png" "kadai/src/${txt}.png"
  fi

  ((num++))
done

convert -delay 20 kadai/true/*.png kadaianim.gif
