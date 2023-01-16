[BITS    16]
[ORG 0x7C00]

call setup
call resetColor

setup:
                ;mode 13h
                mov ah, 0x00
                mov al, 0x13
                int 0x10

                ;0x0C function
                mov ah, 0x0C
                mov bh, 0x00

                ;setup
                xor al, al ;color
                xor cx, cx ;x
                xor dx, dx ;y
                ret
		
resetColor:
                ;mincolor
                mov al, 32 ;15 --> Grayscale

                setpixel:
                                ;next color
                                inc al

                                ;max color
                                cmp al, 55 ;32 --> Grayscale
                                je resetColor

                                ;max x
                                cmp cx, 320
                                jae nextline

                                ;last pixel done
                                cmp dx, 200
                                jae exit

                                int 0x10
                                inc cx

                                jmp setpixel
                                ret
				
nextline:
                ;go to next line
                xor cx, cx
                inc dx

                jmp resetColor			
		
exit:
                ;wait for a key
                mov ah, 0x00
                int 0x16

                ;quit the program
                mov ah, 0x4C
                int 0x21
