#### Shell Script ?  
* Shell script can take input from user, file and output them on screen  
* Automating system administration task
* To automate some task of day-to-day life
* Save lots of times
* Userfule to create own/custom commands
#### Creating Code Snippets
##### Creating abbreviations in .vimrc  
Abbreviations allow for a shortcut string to be used in place of longer string.Just open ~./vimrc and type a shortcut code you want.  
**Syntax**
```html  
abbr <shortcut><string>
```  
**Example**  
```html  
abbr _sh #!/bin/bash  
# Using this abbreviations, we just need type **_sh**  while in edit mode. On pressing the ENTER key after shortcut code, the full text for shebang is printed.

```  
It's easy let enjoy it !  
##### Bringing color to the terminal  
**Example**
We create variables for some colors below : 
```html  
RED="\033[31m"
GREEN="\033[32m"
BLUE="\033[34m"
RESET="\033[0m"
```  
We create file hello.sh, which makes use of these colors


#### Loop Control  
##### while loop  
```html  
#!/bin/sh

a=12

until [ $a -lt 10 ]
do
   echo $a
   a=expr $a + 1'
done
```  
##### The break Statement  
The following **break** statement is used to come out of a loop  
```html  
#!/bin/sh

a=0

while [ $a -lt 10 ]
do
   echo $a
   if [ $a -eq 5 ]
   then
      break
   fi
   a='expr $a + 1'
done  
```  
Result is :  
```html  
0
1
2
3
4
5
```  

```html  
break n  
```  
Here n specifies the nth enclosing loop to the exit from.  
#### dev/null to send unwanted output program  
**Exmaple:**  
```html  
$ls > dev/null  

```  
Output of above command is not shown on screen its send to this special file.  

#### Regular Expressions with SED  
SED stands for stream editor.  
**The sed General Syntax**  
```html  
/pattern/action  
```  
**patten** is a regular expression and **action** is one of these command following.  
```html  
p: prints the line  
d: delete the line  
s/pattern1/parttern2/ : Substitutes the first occurrence of pattern1 with pattern2  
```  
For details you can reference 

