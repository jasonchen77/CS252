		.ORIG x3000
		LD	R1, NHASH	; Load "-#" to R1
		LD	R3, ILOCATION	; Load input memory location
		LD	R4, OLOCATION	; Load output memory location
		LD	R5, NILOCATION	; Load negative input memory location
IAGAIN		IN			; Get input character
		ADD	R2, R0, R1	; Check for termination
		BRz	REVERSE		; Jump to RAGAIN if done
		STR	R0, R3, #0	; Store input in memory
		ADD	R3, R3, #1	; Increment memory location
		BRnzp	IAGAIN		; Iterate back to IAGAIN
REVERSE		ADD	R3, R3, #-1	; Save last input location
RAGAIN		ADD	R6, R3, R5	; Check if all characters are reversed
		BRn	NEXT		; Jump to EXIT if done
		LDR	R6, R3, #0	; Load input characters in reverse
		STR	R6, R4, #0	; Store character in output location
		ADD	R3, R3, #-1	; Decrement input location
		ADD	R4, R4, #1	; Increment output memory location
		BRnzp	RAGAIN		; Iterate back to RAGAIN
NEXT		ADD	R4, R4, #-1	; Save last output character location
		NOT	R4, R4		; Not R4
		ADD	R4, R4, #1	; Negative R4
		LD	R3, OLOCATION	; Load output memory location
DISPLAY		ADD	R2, R3, R4	; Check if all characters are displayed
		BRp	EXIT		; Exit if done
		LDR	R0, R3, #0	; Load character to R0
		OUT			; Display charater
		ADD	R3, R3, #1	; Increment output memory location
		BRnzp	DISPLAY		; Iterate back to DISPLAY
EXIT		HALT			; Halt
NHASH		.FILL	xFFDD	; Negative ASCII "#"
ILOCATION	.FILL	x4000	; Input Character Memory Location
OLOCATION	.FILL	x5000	; Output Character Memory Location
NILOCATION	.FILL	xC000	; Negative Input Memory Location
NOLOCATION	.FILL	xB000	; Negative Ouput Memory Location
		.END