 #!/bin/bash
if [ $# -eq 0 ]
then
echo "How to use : ./subFinder <domain>"
echo "Example : ./subFinder test.com"
else
wget www.$1 2> /dev/null && less index.html | grep "href=" | cut -d ":" -f 2 | cut -d "/" -f 3 | grep $1  | cut -d '"' -f 1 | sort | uniq >sub.txt

for sub in $(cat sub.txt)
do
if [[ $(ping -c 1 $sub) ]]
then
echo "$sub +++++++++ ping"
echo $sub >> valid_sub.txt
else
echo "$sub ------------ error"
fi
done

for subd in $(cat valid_sub.txt)
do
host $subd
host $subd | cut -d " " -f 4 | sort | uniq >> ips.txt
done 
echo "DONE ........" 
fi

