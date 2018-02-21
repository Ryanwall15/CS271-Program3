TITLE Program Template     (Project3.asm)

; Author: Ryan Wallerius
; Course / Project ID  Project3/CS 271               Date: 5/7/17
; Description: I need to get the users name, and display it. I need to have them enter
; negative numbers in the range of [-100, -1] and it should keep asking for numbers
; until they enter a non-negative number. I need to take those numbers and tell the user
; how many valid numbers they have entered, display the sum and then display the average
; and finally display a parting message to the user

INCLUDE Irvine32.inc

UPPERLIMIT = -100;			;Upper limit for range given

.data
username		BYTE	33 DUP(0)			;String for user name 
introduction	BYTE	"Hello. My name is Ryan Wallerius and this is my program", 0
getUserName		BYTE	"Enter your name: ", 0
restIntro		BYTE	"Nice to meet you ", 0
restIntro_1		BYTE	" welcome to my program!", 0
instructions	BYTE	"Please enter numbers within the allowed range [-100, -1]", 0
instructions_1	BYTE	"Enter a non-negative number to stop and see the results", 0
prompt_1		BYTE	"Enter Number: ", 0
number			DWORD	?
outRange		BYTE	"The number you entered was out of range. Re Enter"
done			BYTE	"You decided to stop the program!", 0
count			DWORD	?
sum				DWORD	?
avg				DWORD	?
avg_message		BYTE	"Average: ", 0
finished_1		BYTE	"You entered: ", 0
finished_2		BYTE	" valid numbers! ", 0
sumword			BYTE	"Sum: ", 0
goodbye			BYTE	"Hopefully I impressed you ", 0
goodbye_1		BYTE	" GoodBye! ", 0
error			BYTE	"I couldn't figure out how to calculate the average", 0



.code
main PROC

mov edx, OFFSET introduction
call WriteString
call CrLf
call CrLf

mov edx, OFFSET getUserName
call WriteString
mov edx, OFFSET username
mov ecx, 32
call ReadString

call CrLf
mov edx, OFFSET restIntro
call WriteString
mov edx, OFFSET username
call WriteString
mov edx, OFFSET restIntro_1
call WriteString
call CrLf
call CrLf
mov edx, OFFSET instructions
call WriteString
call CrLf
call CrLf
mov edx, OFFSET instructions_1
call WriteString
call CrLf
mov eax, UPPERLIMIT

getData:
	mov edx, OFFSET prompt_1
	call WriteString
	call ReadInt
	cmp eax, UPPERLIMIT
	jl	invalid
	cmp eax, -1
	jg  valid
	mov number, eax
	jmp calc

invalid:
	mov edx, OFFSET outRange
	call WriteString
	call CrLf
	jmp getData

valid:
	call CrLf
	mov edx, OFFSET done
	call WriteString
	jmp updateAvg 

calc:
	inc	count
	mov ebx, count
	mov eax, number
	cmp eax, -1
	jl updatesum

updatesum:
	mov eax, sum
	add eax, number
	mov sum, eax
	jmp getData

updateAvg:
	mov ebx, count
	mov eax, sum
	div sum
	mov eax, avg


display:
	call CrLf
	mov edx, OFFSET finished_1
	call WriteString
	mov eax, count
	call WriteDec
	mov edx, OFFSET finished_2
	call WriteString
	call CrLf

	call CrLf
	mov edx, OFFSET sumword
	call WriteString
	mov eax, sum
