### echo 
print something in quote  
```html
echo "You're the unique persion"
```  
### Variables, Constant, Operators

#### Define a Constant
```html  
declare -r NUM=5
```  
#### Define and call a variable
```hmtl  
num=2  
echo "$num"
result is : 2
```  
#### Operators  
Examples:  
```hmtl  
#exponentiation
echo "$((5**2))  
#modulus
echo "$((5%2))"  

results are: 
25  
1  
```  
#### Icrementing values  
```html  
rand=5  
let rand+=4  
result is:  
9 

echo "rand++ = $(( rand++ ))"  
echo "$rand"  
echo "++rand = $(( ++rand ))"   
echo "rand-- = $(( rand-- ))"  
echo "--rand = $(( --rand ))"  

results are:  
rand++ = 5
6
++rand = 7
rand-- = 7
--rand = 5     
```  
#### Running python inside  
```html  
num1=2.1  
num2=1.2  
num3=$(python -c "print $num1 + $num2")  
echo $num3  

result is: 
3.3  
```  
#### Printing a text  
```html  
cat << END  
I'm a geek guy  
I'm not afraid any chanlange  
END  
```  

### Functions  
#### Functions with local Variables  

```html 
name="WinStark" 
demoLocal(){ 
    local name="cloudi" # Only avaiable inside this fucntion  
    return
}

demoLocal  

echo "$name"  

result is:  
WinStark  
```  
##### Pass attributes into functions  
```html  
getSum(){
        local num3=$1
        local num4=$2

        local sum=$(( num3+num4))
        echo $sum
}

num1=2
num2=5

sum=$(getSum num1 num2)
echo "The sum is $sum"  

result is: 
The sum is 7  
```  
### Conditionals  
#### Read and receive form user's input  
```html  
read -p "Enter your name: " name  
echo "Hello $name"  
```  
#### IF statement  
```html  
# p is Promnt
read -p "How old are u ?" age
if [ $age -ge 18 ] # the condition
then
        echo "You can drive"  
elif [ $age -eq 17 ]
then
        echo "You can drive the next year"  
else
        echo "You can't drive"  
fi # close if statement

Example result is:  
How old are u ? 18  
You can drive  
```  
**Note**  
eq : equal  
ge : greater euqal    
lt : less than  

```html    
if ((num == 12)); then  
    echo "Your number equals 12"  
fi  

if ((num > 12)); then  
    echo "It greater then 12"  
else  
    echo "It is less then 12  
fi  

if (( ((num % 2)) ==0 )); then  
    echo "It is even"  
fi  

```  
To be continuted... 
