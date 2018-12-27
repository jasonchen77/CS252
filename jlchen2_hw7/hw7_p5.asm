		.ORIG x3000
		AND	R6, R6, #0	; clear R6
		LD	R5, AHEX	; load 'a' hex value to R5
		NOT	R5, R5		; NOT R5
		ADD	R5, R5, #1	; get negative 'a' hex value
		LD	R1, STRING	; load starting string address
;
; Sequence detection loop
;
START		LDR	R2, R1, #0	; load character at address to R2 
		BRz	STORER		; jump to STORER if end is reached
		LDR	R3, R1, #1	; load character at address + 1 to R3
		BRz	STORER		; jump to STORER if end is reached
		LDR	R4, R1, #2	; load character at address + 2 to R4
		BRz	STORER		; jump to STORER if end is reached
		ADD	R2, R2, R5	; check if character is 'a'
		BRnp	INCREMENT	; if not 'a', jump to INCREMENT
		ADD	R3, R3, R5	; check if character is 'a'
		BRnp	INCREMENT	; if not 'a', jump to INCREMENT
		ADD	R4, R4, R5	; check if character is 'a'
		BRnp	INCREMENT	; if not 'a', jump to INCREMENT
		ADD	R6, R6, #1	; if 'aaa' detected, set R6 to 1
		BRnzp	STORER		; jump to STORER
;
; Increment address
;
INCREMENT	ADD	R1, R1, #1	; increment address
		BRnzp	START		; back to START
;
; Store Result
;	
STORER		LD	R0, RESULT	; load RESULT address to R0
		STR	R6, R0, #0	; store result at x5000
		HALT			; HALT
STRING		.FILL x4000
RESULT		.FILL x5000
AHEX		.FILL x61
		.END