read -p "How old are u ?" age  
if [ $age -ge 18 ]  
then  
	echo "You can drive"  
elif [ $age -eq 17 ]
then 
	echo "You can drive the next year"  
else  
	echo "You can't drive"  
fi
