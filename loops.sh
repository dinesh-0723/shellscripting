i=10
while [ $i -gt 0 ]; do
echo "the value of i is $i"
i=$(($i-1))
done

for fruit in apple banana cherry ; do
echo "the fruit name is $fruit"
done
