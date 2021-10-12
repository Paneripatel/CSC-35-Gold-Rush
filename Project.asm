#Paneri Patel
#Project
#CSC35

.intel_syntax noprefix
.data

Art:
	.ascii "             ___                  \n"
        .ascii "            /___\\                 \n"                                
        .ascii "           (|0 0|)                \n"                                    
        .ascii "         __/{\\U/}\\_ ___/vvv       \n"                                         
        .ascii "        / \\  {~}   / _|_||        \n"                                         
        .ascii "        | /\\  ~   /_/   ||        \n"                                         
        .ascii "        |_| (____)      ||        \n"               
        .ascii "        \\_]/______\\  /\\_||_/\\     \n"  
        .ascii "           _\\_||_/_ |] _||_ [|    \n"        
        .ascii "          (_,_||_,_) \\/ [] \\/     \n\0"

Title:
	.ascii "          ===========\n"
	.ascii "           GOLD RUSH \n"
	.ascii "          ===========\n\0"

Rule:
	.ascii "Rules: \n"
	.ascii "1. 25 Weeks (6 Months)!\n"
	.ascii "2. Working a claim earns you a random amount remaining of the gold.\n"
	.ascii "   The more you remove, the less remains.\n"
	.ascii "3. The claim will run out, so you can change claims.\n"
	.ascii "   It take a week to relocate.\n"
	.ascii "4. Food and supplies cost 10-20 dollars.\n\n"
	.ascii "You have just arrived in Coloma!\n"
	.ascii "What section of the river do you want to claim? (Choose from 1 - 20)\n\0"

Week:
	.ascii "\nWeek \0"

Claim:
	.ascii "\nWorking on claim \0"

Cost:
	.ascii "You cost \0"

Food:
	.ascii " for food and supplies.\0"

Plan:
	.ascii "\nPlanning for gold yields $\0"

Have:
	.ascii "You have \0"

Sunday:
	.ascii "It's Sunday! Do you want to (1) Move to a new claim? OR (2) Keep working OR (3) Go to the Bar and Relax?\n\0"
	
WelcomeToBar:
	.ascii "Welcome to the Bar, your Health level is goning to go up as many times as you visit here.\0"
	
HealthUp:
	.ascii "\nDuring this visit your Health level went up by \0"
	
DrinksOrFood:
	.ascii "\nWould you like (1) Drinks OR (2) Food tonight?\n\0"
	
CostDownDrinks:
	.ascii "\Tonight your charges for drinks were $\0"
	
CostDownFood:
	.ascii "\Tonight your charges for food were $\0"
	
NewClaim:
	.ascii "What claim do you want to move to? (Choose from 1 - 20)\n\0"

Took:
	.ascii "It took a week to move to the new claim.\n\0"

EndLine:
	.ascii "\n\nYou ended the 25 weeks with $\0"
	
HealthIsOut:
	.ascii "\nYour Health level is 0. You are almost dead, go home. BYE!!\0"

LockDown:
	.ascii "\nPresident has announced nationwide lockdown, due to COVID-19 pandemic! Go Home, BYE!!!\0"
	
Line:
	.ascii " \n\0"
	 
Health:
	.ascii "\nCurrent Health level is \0"

Art2:
	.ascii " {_}                              \n"
	.ascii " |(|                              \n"
	.ascii " |=|                              \n"
	.ascii "/   \\    Cheers to class CSC35    \n"
	.ascii "|.--|                             \n"
	.ascii "||  |                             \n"
	.ascii "||  |     .    ' .                \n"
	.ascii "|'--|   '     \\~~~/               \n"
	.ascii "'-=-'  \\~~~/  \\_/                \n"
	.ascii "        \\_/     Y                 \n"  
	.ascii "          Y     _|_                \n"
	.ascii "         _|_                       \n\0"

Dollar:
	.ascii "$\0"

Reference:
	.ascii "Reference for Professor: For extra credit I have included health level,\n" 
	.ascii "when it hit zero a message will pop up saying your health level is zero,\n"
	.ascii "you are almost dead go home. In the similar way I added a fun twist to \n"
	.ascii "go to bar and increase health level by having food and drinks, where\n"
	.ascii "drinks cost more than food. And I have also included a random event which\n"
	.ascii "says go home due to covid19 pandemic lockdown. FYI this event pops up before\n"
	.ascii "25th week ends, so to play the game till 25th week, manually you will have to remove\n"
	.ascii "this event. And lastly I have done MotherLoad which is randomly selected on\n"
	.ascii "different claim in each new game. For this game it is claim number #\0"

.text
.global _start

_start:
	mov r11, 100			#Storing health as 100 in the start of the game

	lea rdx, Reference              #Prints reference block for professor's knowledge about my game
	call PrintCString
	mov rdx, 20			#Selecting a random MotherLoad Claim
	call Random
	add rdx, 1
	mov r12, rdx			#Storing the MotherLoad claim number for future refernce
	call PrintInt

	lea rdx, Line
	call PrintCString               #Printing ascii art	
	mov rdx, 2
	call SetForeColor
	lea rdx, Art
	call PrintCString
	
	mov rdx, 3
	call SetForeColor               #Printing title of the game
	lea rdx, Title
	call PrintCString

	mov rdx, 7
	call SetForeColor               #Setting color

	mov r9, 100                 
	mov rsi, 0                      #rsi will print week number and in r9 money will be stored statring with inital 100$
	mov r13, 100

ClaimBack:
	lea rdx, Line
	call PrintCString               #Newline	

	mov rdx, 1
	call SetForeColor
	lea rdx, Rule                   #Printing rules for the game
	call PrintCString

	mov rdx, 7
	call SetForeColor               #Setting color
	
	mov rdx, 1
	call ScanInt                    #Scanning the claim number in which gamer wants to play
	mov rax, rdx
	
ClaimTwo:
	mov rdx, 4
	call SetForeColor
	add rsi, 1                      #Setting color, printing week and week number
	lea rdx, Week
	call PrintCString
	mov rdx, 7
	call SetForeColor
	mov rdx, rsi
	call PrintInt	
	lea rdx, Line
	Call PrintCString

	mov rdx, 10       		#Generating random health to subtract
	call Random
	add rdx, 1
	sub r11, rdx			#Subtracting randomly generated health from existing health
	lea rdx, Health
	call PrintCString		#Printing health message
	mov rdx, r11
	call PrintInt			#Printing remaining health
	
	lea rdx, Line
	call PrintCString               #Newline
	
	mov rdx, 5
	call SetForeColor	
	lea rdx, Claim                  #Setting color, printing claim line
	call PrintCString
	
	mov rdx, 7
	call SetForeColor               #Setting color

	mov rdx, rax 
	call PrintInt                   #Printing claim number and new line
	lea rdx, Line
	call PrintCString
	
	mov rdx, 11
	call Random                     #Ranomly calculating cost for food and supplies
	mov r8, rdx           
	add r8, 10                        
	mov rdx, 6
	call SetForeColor
	lea rdx, Cost
	call PrintCString
	mov rdx, 7                      #Printing cost for food and supplies and setting color
	call SetForeColor
	lea rdx, Dollar
	call PrintCString
	mov rdx, r8
	call PrintInt

	mov rdx, 6
	call SetForeColor               #Printing food line
	lea rdx, Food
	call PrintCString
	
	mov rdx, 7
	call SetForeColor               #Setting color

	lea rdx, Plan
	call PrintCString               #Printing planning for gold line

	mov rdx, 1000
	call Random
	                                #Randomly calling a number that will be the amount you are left with and stored in r10 for right now                
	mov r10, rdx
	
	cmp rax, r12
	je MotherLoad                   #Comparing a randomly generated number in r12 with rax to jump to mother load

	jmp ClaimThree

MotherLoad:
	mov rdx, 2000
	add rdx, 1001
	call Random
	                                #Setting the amount from 1000 to 3000 and then jumping back to weekly claim
	mov r10, rdx
	
	jmp ClaimThree
	
ClaimThree:
	call PrintInt                   #Printing the money for gold yields
	
	lea rdx, Line
	call PrintCString               #New Line

	mov rdx, 6
	call SetForeColor
	lea rdx, Have
	call PrintCString

	mov rdx, 7
	call SetForeColor
	lea rdx, Dollar
	call PrintCString
	add r9, r10
	sub r9, r8                     #Printing the money you are left with
	mov rdx, r9
	call PrintInt
	lea rdx, Line
	call PrintCString
	cmp rsi, 25                    #If week 25 jump to end
	jge End
	
	cmp r11, 0
	jle HealthOut                  #If health level is 0 then jump to end
	
	mov rdx, 25
	call Random
	cmp rdx, 15                    #Randomly taking one week to end game with corona virus lockdown reason
	je Corona

	jmp NextDecision

NextDecision:
	lea rdx, Sunday
	call PrintCString              #Printing sunday message, if scan int is 2 then move to claimtwo sectio, if 3 then move to party section
	call ScanInt
	cmp rdx, 2
	je ClaimTwo
	cmp rdx, 3
	je Party

	add rsi, 1
	cmp rsi, 25                
	jge End                        #If moving to new claim then one week is passed by
	
	lea rdx, NewClaim
	call PrintCString
	call ScanInt
	mov rax, rdx
	lea rdx, Took                  #Printing new claim line, and jumping back to claimtwo (Mechanism for claims)
	call PrintCString
	jmp ClaimTwo

Party:
	lea rdx, Line
	call PrintCString
	lea rdx, WelcomeToBar	
	call PrintCString		#Printing welcome bar msg
	mov rdx, 10
	call Random			#Generating random health to add to existing health
	add rdx, 1
	add r11, rdx			#Adding randonly generated health to existing health
	mov r14, rdx
	lea rdx, HealthUp
	call PrintCString
	mov rdx, r14
	call PrintInt
	lea rdx, Health
	call PrintCString		#Printing health message
	mov rdx, r11
	call PrintInt			#Printing remaining health
	
	lea rdx, DrinksOrFood
	call PrintCString
	call ScanInt                    #Asking gamer for drinks or food option at bar, if 2 then jump to food section or else jump to drinks section
	cmp rdx, 2
	je FoodFromBar
	
	jmp Drinks
	
Drinks:
	mov rdx, 200
	call Random			#Generating random charges for drinks
	add rdx, 1
	sub r9, rdx			#Subtracting randonly generated charge to existing money
	mov r14, rdx
	lea rdx, CostDownDrinks
	call PrintCString
	mov rdx, r14
	call PrintInt
	lea rdx, Line
	call PrintCString               #Printing the amount of money gamer is left with
	lea rdx, Have
	call PrintCString
	lea rdx, Dollar
	call PrintCString
	mov rdx, r9
	Call PrintInt
	lea rdx, Line
	call PrintCString
	
	jmp NextDecision               #Option to select from 3 options again

FoodFromBar:
	mov rdx, 500
	call Random		       #Generating random charges for food
	add rdx, 1
	sub r9, rdx		       #Subtracting randonly generated charge to existing money
	mov r14, rdx
	lea rdx, CostDownFood
	call PrintCString
	mov rdx, r14
	call PrintInt
	lea rdx, Line                  #Again printing the amount of moeny gamer is left with after going to bar and having food
	call PrintCString
	lea rdx, Have
	call PrintCString
	lea rdx, Dollar
	call PrintCString
	mov rdx, r9
	Call PrintInt
	lea rdx, Line
	call PrintCString
	
	jmp NextDecision
	
HealthOut:
	lea rdx, HealthIsOut
	call PrintCString
	lea rdx, Line
	call PrintCString              #Printing message when health level hits 0
	lea rdx, Have
	call PrintCString
	lea rdx, Dollar
	call PrintCString
	mov rdx, r9
	Call PrintInt
	lea rdx, Line
	call PrintCString

	call EndProgram               #Program ends here as no more health level left for gamer
	
Corona:
	lea rdx, LockDown
	call PrintCString
	lea rdx, Line
	call PrintCString
	lea rdx, Have                 #On a random week message prints about lockdown due to corona virus and so the game ends
	call PrintCString
	lea rdx, Dollar
	call PrintCString
	mov rdx, r9
	Call PrintInt
	lea rdx, Line
	call PrintCString

	call EndProgram             

End:
	lea rdx, EndLine
	call PrintCString
	mov rdx, r9
	call PrintInt                 #End section, printing end line, amount and an ascii chart
	lea rdx, Line
	call PrintCString

	lea rdx, Art2
	call PrintCString

	call EndProgram
