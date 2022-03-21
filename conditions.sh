if [ 1 -eq 1 ]
then
echo "hello world"
fi
a=abc
if [ "$a"=="abc" ];then
echo "both are equal"
fi
if [ -z "$a" ];then
  echo "variable is not empty"
fi
  if [ -z "$b" ];then
  echo "variable is empty"
  fi