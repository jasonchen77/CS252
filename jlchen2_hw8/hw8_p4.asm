		.ORIG	x3000
		LD	R1, NZERO	; Load NZERO To R1
AGAIN		IN			; Get input character
		ADD	R3, R0, R1	; Check if "0"
		BRz	EXIT		; Exit if "0"
		ADD	R2, R0, #0	; Store input in R2
		JSR	CheckCase	; Jump to CheckCase subroutine
		BRnzp	AGAIN		; Iterate back to AGAIN
EXIT		HALT			; Halt
NZERO		.FILL	xFFD0		; Negative ASCII "0" Value
;
;CheckCase
CheckCase
		ADD	R3, R7, #0	; Copy R7 to R3
CHECKUPPER	LD	R5, NUA		; Load NUA to R5
		LD	R6, NUZ		; Load NUZ to R6
		ADD	R4, R2, R5	; Check if input is less than "A"
		BRn	CHECKOTHER	; Jump to CHECKOTHER if less than "A"
		ADD	R4, R2, R6	; Check if input is greater than "Z"
		BRp	CHECKLOWER	; Jump to CHECKLOWER if greather than "Z"
		LD	R0, U		; Load "u" to R0
		OUT			; Output "u"
		BRnzp	RETURN		; Jump to RETURN
CHECKLOWER	LD	R5, NLA		; Load NLA to R5
		LD	R6, NLZ		; Load NLZ to R6
		ADD	R4, R2, R5	; Check if input is less than "a"
		BRn	CHECKOTHER	; Jump to CHECKOTHER if less than "a"
		ADD	R4, R2, R6	; Check if input is greater than "z"
		BRp	CHECKOTHER	; Jump to CHECKLOWER if greather than "z"
		LD	R0, L		; Load "l" to R0
		OUT			; Output "l"
		BRnzp	RETURN		; Jump to RETURN
CHECKOTHER	LD	R0, N		; Load "n" to R0
		OUT			; Output "n"
		BRnzp	RETURN		; Jump to RETURN
RETURN		ADD	R7, R3, #0	; Copy R3 to R7
		RET			; Return to main function
NUA		.FILL	xFFBF		; Negative ASCII "A" Value
NUZ		.FILL	xFFA6		; Negative ASCII "Z" Value
NLA		.FILL	xFF9F		; Negative ASCII "a" Value
NLZ		.FILL	xFF86		; Negative ASCII "z" Value
U		.FILL	x0075		; ASCII "u" Value
L		.FILL	x006C		; ASCII "l" Value
N		.FILL	x006E		; ASCII "n" Value
;
		.END