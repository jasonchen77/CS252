		.ORIG x3000
		LD	R1, COMMAND
		LD	R2, RESULT
;Main loop
;
START		LD	R5, SUBSET
		LDR	R3, R1, #0	; load the value of command in R3
		ADD	R4, R3, #-4	; check if the command is 4
		BRz	QUIT		; if 4, quit the loop and halt
		ADD	R1, R1, #1	; increment R1 to get the start index
		LDR	R0, R1, #0	; load start index to R0
		ADD	R1, R1, #1	; increment R1 to get the end index
		LDR	R6, R1, #0	; load end index to R6
CHECK1		ADD	R4, R3, #-1	; check if the command is 1
		BRnp	CHECK2		; if 1, do the ADDNUM subroutine
		JSR	ADD_SUBSET_NUM	; jump to ADDNUM subroutine
CHECK2		ADD	R4, R3, #-2	; check if the command is 2
		BRnp	CHECK3		; if 2, do the ORNUM subroutine
		JSR	OR_SUBSET_NUM	; jump to ORNUM subroutine
CHECK3		ADD	R4, R3, #-3	; check if the command is 3
		BRnp	CHECK4		; if 3, do the COUNT POSITIVE subroutine
		JSR	COUNT_SUBSET_POS; jump to COUNTPOS subroutine
CHECK4		ADD	R1, R1, #1	; increment R1 to get next command
		BRnzp	START		; iteraton, back to START
;
QUIT		HALT
SUBSET		.FILL x3200
COMMAND		.FILL x3300
RESULT		.FILL x3400
;
; ADD_SUBSET_NUM: add the numbers in the subset
ADD_SUBSET_NUM
		ST	R1, ASN1	; save register value
		ST	R3, ASN2	; save register value
		ST	R4, ASN3	; save register value
		ST	R5, ASN4	; save register value
		ADD	R1, R0, R5	; get starting index address
		ADD	R3, R0, #0	; copy starting index to R3
		NOT	R3, R3		; NOT R3
		ADD	R3, R3, #1	; get negative R3
		ADD	R3, R6, R3	; make R3 the counter
		AND	R5, R5, #0	; clear R5 to 0
; Add loop
;
ADDSTART	LDR	R4, R1, #0	; load value at index to R4
		ADD	R1, R1, #1	; increment index
		ADD	R5, R5, R4	; add value at index to R5
		ADD	R3, R3, #-1	; decrement count by 1
		BRzp	ADDSTART	; iterative, back to ADDSTART
;
		STR	R5, R2, #0	; store ADD result in result memory locations
		ADD	R2, R2, #1	; increment RESULT address
		LD	R1, ASN1	; restore register	
		LD	R3, ASN2	; restore register
		LD	R4, ASN3	; restore register
		LD	R5, ASN4	; restore register
		RET			; return
ASN1		.FILL	x0000
ASN2		.FILL	x0000
ASN3		.FILL	x0000
ASN4		.FILL	x0000
;
; OR_SUBSET_NUM
OR_SUBSET_NUM
		ST	R1, OSN1	; save register value
		ST	R3, OSN2	; save register value
		ST	R4, OSN3	; save register value
		ST	R5, OSN4	; save register value
		ADD	R1, R0, R5	; get starting index address
		ADD	R3, R0, #0	; copy starting index to R3
		NOT	R3, R3		; NOT R3
		ADD	R3, R3, #1	; get negative R3
		ADD	R3, R6, R3	; make R3 the counter
		AND	R5, R5, #0	; clear R5 to 0
; Or loop
;
ORSTART		LDR	R4, R1, #0	; load value at index to R4
		ADD	R1, R1, #1	; increment index
; OR operation
;		
		NOT	R4, R4		; NOT R4
		NOT	R5, R5		; NOT R5
		AND	R5, R5, R4	; AND R4 R5 store in R5
		NOT	R5, R5		; NOT R5 to get OR
;
		ADD	R3, R3, #-1	; decrement count by 1
		BRzp	ORSTART		; iterative, back to ORSTART
;
		STR	R5, R2, #0	; store OR result in result memory locations
		ADD	R2, R2, #1	; increment RESULT address
		LD	R1, OSN1	; restore register	
		LD	R3, OSN2	; restore register
		LD	R4, OSN3	; restore register
		LD	R5, OSN4	; restore register
		RET			; return
OSN1		.FILL	x0000
OSN2		.FILL	x0000
OSN3		.FILL	x0000
OSN4		.FILL	x0000
;
; COUNT_SUBSET_POS
COUNT_SUBSET_POS
		ST	R1, CSP1	; save register value
		ST	R3, CSP2	; save register value
		ST	R4, CSP3	; save register value
		ST	R5, CSP4	; save register value
		ADD	R1, R0, R5	; get starting index address
		ADD	R3, R0, #0	; copy starting index to R3
		NOT	R3, R3		; NOT R3
		ADD	R3, R3, #1	; get negative R3
		ADD	R3, R6, R3	; make R3 the counter
		AND	R5, R5, #0	; clear R5 to 0
; COUNT loop
;
COUNTSTART	LDR	R4, R1, #0	; load value at index to R4
		BRnz	SKIP		; if not positive, branch to SKIP
		ADD	R5, R5, #1	; increment # positive count
SKIP		ADD	R1, R1, #1	; increment index
		ADD	R3, R3, #-1	; decrement count by 1
		BRzp	COUNTSTART	; iterative, back to COUNTSTART
;
		STR	R5, R2, #0	; store COUNT result in result memory locations
		ADD	R2, R2, #1	; increment RESULT address
		LD	R1, CSP1	; restore register	
		LD	R3, CSP2	; restore register
		LD	R4, CSP3	; restore register
		LD	R5, CSP4	; restore register
		RET			; return
CSP1		.FILL	x0000
CSP2		.FILL	x0000
CSP3		.FILL	x0000
CSP4		.FILL	x0000
;
		.END