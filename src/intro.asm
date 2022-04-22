
music=	1

	if music
EXTRN	stmik_asm:far
	endif

no_stars=	170

screen_xorg	equ 160
screen_yorg	equ 100
xmax		equ 320
ymax		equ 200
xorg		equ 0
yorg		equ 0
zorg		equ 600h
dist		equ -160h

deltaA		equ 063h
deltaB		equ 021h
deltaC		equ 043h

speed=		5

endlist		equ 08fffh

yspacing=	10
res=		320/4

;********************************************************************
	.model	huge
	.stack	0400h

	if music
MODULE	segment para
	include music.mod
MODULE	ends
	endif

	.386
	.code

wait_page=	300
pheight=	154

text1:
	db '~4----------------------------------------@@'
	db '~2       -+= R A Z O R  1 9 1 1 =+-       @@'
	db '~2          IS PROUD TO PRESENT           @@@'
	db '~3          -> SPACE QUEST 5 <-           @@@'
	db '~2         CRACKED BY:~1 ELDAR            @@'
	db '~2         ORIGINAL:  ~1 BLUELIGHT        @@'
	db '~4----------------------------------------'
	db '\'
	db '~2     CALL A FINE RAZOR BOARD TODAY!@'
	db '~4SUBURBIA                    ~3214-XXX-XXXX@'
	db '~4TERRODOME                   ~3416-XXX-XXXX@'
	db '~4APOCALYPSE                  ~3703-XXX-XXXX@'
	db '~4KINDERGARDEN                ~3+47-7-525156@'
	db '@'
	db '~4AGENTS OF FORTUNE           ~3409-786-3767@'
	db '~4BONERS DOMAIN               ~3XXX-XXX-XXXX@'
	db '~4THE DARK PALACE             ~3XXX-XXX-XXXX@'
	db '~4DIGITAL EXPRESS             ~3+55273250791@'
	db '~4THE FLIP SIDE               ~3602-341-0483@'
	db '~4MIDPOINT VOID               ~3XXX-XXX-XXXX@'
	db '~4SO-KRATES                   ~3310-578-7226@'
	db '~4SPYRITS CRYPT               ~3802-879-1136@'
	db '~4UNKNOWN ORIGIN              ~3204-442-5021@'
	db '\'
	db '~4ASCII EXPRESS               ~3617-631-3064@'
	db '~4BORDERLINE                  ~3813-922-4125@'
	db '~4CAMELOT                     ~3606-258-2821@'
	db '~4FATAL FUTURE                ~3+46-31932845@'
	db '~4FIFO-LIFO                   ~3305-XXX-XXXX@'
	db '~4FILE CABINET                ~3815-399-8978@'
	db '~4HELL                        ~3313-XXX-XXXX@'
	db '~4HIGH VOLTAGE                ~3908-231-0252@'
	db '~4THE JUNGLE                  ~3615-885-9792@'
	db '~4METAL WORKS                 ~3318-XXX-XXXX@'
	db '~4MODE 101                    ~3206-486-2546@'
	db '~4STREET SPYDRS               ~3713-XXX-XXXX@'
	db '~4THE TEXAS MADHOUSE          ~3XXX-XXX-XXXX@'
	db '~4VIOLENT PLAYGROUND          ~3+46-40456649@'
	db '~4WARES FOR THE MASSES        ~3302-836-6175@'
	db '\'
	db '@@@@@'
	db '~2        RAZOR SENDS REGARDS TO:@@'
	db '~1            THE DREAM TEAM@'
	db '~3              FAIRLIGHT!@'
	db '~4              PYRADICALS\'	
	DB 0
	;DB 2000 DUP (0)

switch	dw 0
hardtext:
	db '@~2      CREDITS FOR THIS QUICK INTRO:@'
	DB '@'
	db '       ~4CODE:       ~3JARRE / RAZOR@'
	db '       ~4LOGO:       ~3PAL / RAZOR@'
	db '       ~4FONT:       ~3POISE / RAZOR@'
	db '       ~4SFX:        ~3MEKKANIK@'
	db '@@'
	db '~2          JARRE GREETS:@@'
	DB '~4PHANTASIA - PRIME EVIL - NEVA - LUCIFER@'
	DB '   GANGSTA - GINNIE - POISE - PHIBER@'
	DB '    RED DEVIL - CLAIRVOYANT - MORPH@'
	DB '\'
	db 0

XYZcords:
	dd no_stars dup (0,0,0)
	dd endlist

act_page	db 0
addpage		dw 0
cur_clearlist	dw 0
masklist1	dw 00102h,00202h,00402h,00802h
masklist2	dw 00004h,00104h,00204h,00304h

XYZfinal:
	dw no_stars+3 dup (0,0,0)
clearlist1:
	dw no_stars dup (0,0)
clearlist2:
	dw no_stars dup (0,0)
sinelist:	include sine.dat
temp:
		dd 8 dup (0)

txpos		dw 0
typos		dw 0
textp		dw text1
twait		dw 100
tcol		dw 0

angleA		dw 0
angleB		dw 01000h
angleC		dw 0

Con1		dw 1
Con2		dw 1
Con3		dw 1
Con4		dw 1
Con5		dw 1
Con6		dw 1
Con7		dw 1
Con8		dw 1
Con9		dw 1

cosA		dw 0
sinA		dw 0
cosB		dw 0
sinB		dw 0
cosC		dw 0
sinC		dw 0

blackpal:
	db 256 dup (0,0,0)
lmres		dw res
old_mode	db 0
line		db 320 dup (0)
font1:		include font2.dat
fontdata:
	db 320*32 dup (0)
logo1:		include razbot1.dat
logopal:	include razbot1.pal
fontpal:
	db 3ch,3ch,24h
	db 36h,36h,20h
	db 32h,32h,18h
	db 2ch,2ch,10h
	db 28h,28h,08h
	db 20h,20h,02h
	db 16h,16h,00h
	db 0ch,0ch,00h

	db 3ch,24h,24h
	db 36h,20h,20h
	db 32h,1ch,1ch
	db 2ch,16h,16h
	db 28h,12h,12h
	db 20h,0dh,0dh
	db 16h,08h,08h
	db 0ch,03h,03h

	db 24h,3ch,24h
	db 20h,36h,20h
	db 1ch,32h,1ch
	db 16h,2ch,16h
	db 12h,28h,12h
	db 0dh,20h,0dh
	db 08h,16h,08h
	db 03h,0ch,03h

	db 24h,24h,3ch
	db 20h,20h,36h
	db 1ch,1ch,32h
	db 16h,16h,2ch
	db 12h,12h,28h
	db 0dh,0dh,20h
	db 08h,08h,16h
	db 03h,03h,0ch

star_palette:
	db 000h,000h,000h
	db 03fh,03fh,03fh
	db 03bh,03bh,03bh
	db 037h,037h,037h
	db 033h,033h,033h
	db 02fh,02fh,02fh
	db 02dh,02dh,02dh
	db 02bh,02bh,02bh
	db 029h,029h,029h
	db 027h,027h,027h
	db 025h,025h,025h
	db 023h,023h,023h
	db 021h,021h,021h
	db 01fh,01fh,01fh
	db 01dh,01dh,01dh
	db 01bh,01bh,01bh
	db 019h,019h,019h
	db 017h,017h,017h
	db 015h,015h,015h
	db 013h,013h,013h
	db 011h,011h,011h
	db 00fh,00fh,00fh
	db 00dh,00dh,00dh
	db 00bh,00bh,00bh
	db 009h,009h,009h
	db 007h,007h,007h
	db 005h,005h,005h
	db 003h,003h,003h
	db 001h,001h,001h

SB_port		dw 0
SB_irq		db 0
SB_mask		db 0

;****************************************************************************
Start:
        mov     ax,cs
        mov     ds,ax
        call    setup

	mov	al,01111111b	; Mask off all unneccesary interrupts.
	out	021h,al
	mov	al,00000000b
	out	0a1h,al

	if	music
	call	SB_getport
	call	SB_getirq

	mov	ax,0		; init STMIK
	mov	bl,1		; SB is output device
	mov	bh,SB_irq	; IRQ
	mov	cx,SB_port	; Port
	mov	dx,20000	; mix speed
	call	stmik
	cmp	ax,0
	je	no_STMIKerror

	mov	cs:[sb_port],-1
no_STMIKerror:
	mov	ax,3		; poll mode - make stmik do it all
	mov	bx,1		; by itself
	call	stmik

	mov	ax,1		; begin to play song
	mov	bx,module
	call	stmik

	mov	ax,cs
	mov	ds,ax
	Mov	Al,SB_mask	; Mask off all unneccesary interrupts.
	Out	21h,Al
	endif
main:
        call    waitraster
	if music
	mov	ax,4		; uncomment this if manually polling
	call	stmik
	endif

;	call	red
	call	pageflip
	call	changetext
	call	stars
	call	black

        in      al,60h
        cmp     al,01h
        jne     main

	if music
	mov	ax,2		; stmik off (Shuddup!)
	call	stmik
	endif

	mov	al,0		;Let the interrupts come again...
	out	021h,Al
	mov	al,00000000b
	out	0a1h,al

        mov     ah,00h
        mov     al,old_mode
        int     10h
	mov	ax,04c00h
	int	21h

;********************************************************************
setup:
        mov     ah,0fh
        int     10h
        mov     old_mode,al

        mov     ax,00013h
        int     10h

	mov     ax,cs
	mov     ds,ax
	lea     si,blackpal
	mov     al,0
	mov     cx,256*3
	call	setpalette

	mov	dx,03c4h
	mov	ax,00604h
	out	dx,ax

	mov	dx,03d4h
	mov	ax,00014h
	out	dx,ax

	mov	dx,03d4h
	mov	ax,0e317h
	out	dx,ax

	mov	dx,03ceh
	mov	ax,0ff08h
	out	dx,ax

	mov	dx,03ceh
	mov	al,5
	out	dx,al
	inc	dx
	in	al,dx
	and	al,0fch			;write mode 2
	out	dx,al

	mov	dx,03c4h
	mov	ax,00f02h
	out	dx,ax

	call	setup_stars

	lea	si,logo1
	mov	di,0
	mov	ax,cs
	mov	ds,ax
	mov	ax,0a000h
	mov	es,ax
	mov	ax,0
	call	iff

	lea	si,font1
	lea	di,fontdata
	mov	ax,cs
	mov	ds,ax
	mov	es,ax
	mov	ax,1
	call	iff

	mov     ax,cs
	mov     ds,ax
	lea     si,fontpal
	mov     al,32
	mov     cx,32*3
	call	setpalette

	mov     ax,cs
	mov     ds,ax
	lea     si,star_palette
	mov     al,128
	mov     cx,32*3
	call	setpalette

	mov     ax,cs
	mov     ds,ax
	lea     si,logopal
	mov     al,0
	mov     cx,32*3
	call	setpalette
        ret

;********************************************************************
charpl	dw 40
muline	dw 320*8

changetext:
	mov	ax,cs
	mov	ds,ax
	mov	ax,0a000h
	mov	es,ax

	test	word ptr twait,0ffffh
	jz	sagain

	dec	word ptr twait
	cmp	word ptr twait,40
	jae	nodoclear

	mov	dx,03c4h
	mov	ax,00f02h
	out	dx,ax

	mov	ax,twait
	add	ax,ax
	mov	di,ax
	mov	cx,pheight
	mov	eax,0
	mov	bx,res-2
wellsir:
	mov	es:04000h[di],ax
	stosw
	add	di,bx
	loop	wellsir
	ret

nodoclear:
	ret

sagain:
	mov	bx,textp
	add	word ptr textp,1
	mov	ax,0
	mov	al,[bx]
	cmp	al,10
	je	sagain
	cmp	al,13
	je	sagain

	cmp	al,'@'
	jne	no_return

	cmp	word ptr typos,14
	je	nomore_ret
	add	word ptr typos,1
nomore_ret:
	mov	word ptr txpos,0
	jmp	sagain
no_return:
	cmp	al,'~'
	jne	no_colchange

	mov	al,1[bx]
	add	word ptr textp,1
	sub	al,'1'
	mov	ah,0
	mov	tcol,ax
	jmp	sagain
no_colchange:
	cmp	al,'\'
	jne	no_swait

	mov	word ptr twait,wait_page
	mov	word ptr txpos,0
	mov	word ptr typos,0
	ret
no_swait:
	cmp	al,0
	jne	no_endtext

	lea	ax,text1
	test	word ptr switch,-1
	jnz	oknohard
	lea	ax,hardtext
oknohard:
	mov	textp,ax
	xor	word ptr switch,1
	mov	word ptr txpos,0
	mov	word ptr typos,0
	jmp	sagain
no_endtext:
	push	ax
	mov	bx,txpos
	mov	ax,typos
	mov	dx,yspacing*res
	mul	dx
	add	bx,bx
	add	ax,bx
	mov	di,ax
	pop	ax
	call	putchar

	cmp	word ptr txpos,39
	je	nomore_inx
	add	word ptr txpos,1
nomore_inx:
	ret

putchar:
	sub	al, ' '
	mov	ah,0
	mov	dx,0
	div	word ptr cs:charpl
	mov	si,dx
	shl	si,3
	mul	word ptr cs:muline
	add	si,ax
	lea	ax,fontdata
	add	si,ax

	mov	bp,8
	mov	bx,tcol
	shl	bx,3
	add	bl,32
looper1:	
	mov	cx,2
aalla:
	mov	dx,03c4h
	mov	ax,00102h
	out	dx,ax

	lodsb
	test	al,0ffh
	jz	rap1
	add	al,bl
rap1:
	mov	es:[di],al
	mov	es:04000h[di],al

	mov	dx,03c4h
	mov	ax,00202h
	out	dx,ax

	lodsb
	test	al,0ffh
	jz	rap2
	add	al,bl
rap2:
	mov	es:[di],al
	mov	es:04000h[di],al

	mov	dx,03c4h
	mov	ax,00402h
	out	dx,ax

	lodsb
	test	al,0ffh
	jz	rap3
	add	al,bl
rap3:
	mov	es:[di],al
	mov	es:04000h[di],al

	mov	dx,03c4h
	mov	ax,00802h
	out	dx,ax

	lodsb
	test	al,0ffh
	jz	rap4
	add	al,bl
rap4:
	mov	es:04000h[di],al
	stosb
	loop	aalla

	add	si,320-8
	add	di,res-2
	dec	bp
	jnz	looper1
	ret

;********************************************************************
linecount	dw 0
destcount	dw 0
bytecount	dw 0
destseg		dw 0
getseg		dw 0
modeX		dw 0

; ax= write mode
;		0: write to gfx memory in modeX
;		1: direct write to memory
; ds:si= IFF PBM picture start
; es:di= Place to copy to

badpic:
	mov	ax,-1
	ret

iff:
	mov	cs:modeX,ax
	mov	cs:getseg,ds
	mov	cs:destseg,es
	mov	cs:destcount,di

	cmp	dword ptr [si], 'MROF'
	jne	badpic

	add	si,8
	mov	cx,1000
findBMHD:
	dec	cx
	jz	badpic
	add	si,2
	cmp	dword ptr [si], 'DHMB'
	jne	findBMHD

	add	si,8
	mov	ax,2h[si]
	xchg	ah,al
	mov	cs:linecount,ax

	mov	al,8[si]
	mov	ah,0
	mov	bx,10h[si]
	xchg	bh,bl
	mul	bx
	shr	ax,3
	mov	cs:bytecount,ax

	mov	cx,1000
findBODY:
	dec	cx
	jz	badpic
	add	si,2
	cmp	dword ptr [si], 'YDOB'
	jne	findBODY
	add	si,8

;************************ Uncrunching part
repeat1:
	mov	ax,cs
	mov	es,ax
	lea	di,line
	mov	bx,cs:bytecount
	mov	ax,cs:getseg
	mov	ds,ax
	mov	ax,0
mainloop:
	lodsb
	test	al,0ffh
	js	copy

	mov	cx,ax
	inc	cx
moveloop:
	lodsb
	stosb
	dec	bx
	jz	finline
	loop	moveloop
	jmp	mainloop

copy:
	neg	al
	mov	cx,ax
	lodsb
	inc	cx
copyloop:
	stosb
	dec	bx
	jz	finline
	loop	copyloop
	jmp	mainloop

;************************
finline:
	push	si
	mov	di,cs:destcount
	mov	es,cs:destseg
	lea	si,line
	mov	ax,cs
	mov	ds,ax

	cmp	word ptr modeX,1
	je	finline2

	mov	dx,03c4h
	mov	ax,00102h
	out	dx,ax
	mov	cx,320/4
funny1:
	lodsb
	mov	es:04000h[di],al
	stosb
	add	si,3
	loop	funny1

	lea	si,line+1
	mov	di,cs:destcount
	mov	ax,00202h
	out	dx,ax
	mov	cx,320/4
funny2:
	lodsb
	mov	es:04000h[di],al
	stosb
	add	si,3
	loop	funny2

	lea	si,line+2
	mov	di,cs:destcount
	mov	ax,00402h
	out	dx,ax
	mov	cx,320/4
funny3:
	lodsb
	mov	es:04000h[di],al
	stosb
	add	si,3
	loop	funny3

	lea	si,line+3
	mov	di,cs:destcount
	mov	ax,00802h
	out	dx,ax
	mov	cx,320/4
funny4:
	lodsb
	mov	es:04000h[di],al
	stosb
	add	si,3
	loop	funny4

	add	cs:destcount,320/4
	jmp	iff_endcheck


finline2:
	mov	cx,320
	rep	movsb

	add	cs:destcount,320
iff_endcheck:
	pop	si
	dec	word ptr cs:linecount
	jnz	repeat1
	ret

;********************************************************************
;********************************************************************
pageflip:
        xor     act_page,1

        mov     bh,000h
        mov     ah,000h
	mov	cx,0h
	lea	dx,clearlist1
        cmp     act_page,1
        jne     dopage44
        mov     ah,040h
	mov	cx,04000h
	lea	dx,clearlist2
dopage44:
	mov	cur_clearlist,dx
	mov	addpage,cx
        mov     dx,03d4h
        mov     al,0ch
        out     dx,ax
        inc     al
        mov     ah,bh
        out     dx,ax
        ret

;********************************************************************
and1=	03ffh
sub1=	0200h

setup_stars:
	lea	di,clearlist1
	mov	word ptr [di],0
	mov	word ptr 2[di],00f02h
	mov	word ptr 4[di],-1

	lea	di,clearlist2
	mov	word ptr [di],0
	mov	word ptr 2[di],00f02h
	mov	word ptr 4[di],-1

        lea     di,XYZcords
        mov     eax,0367a2892h
        mov     ecx,no_stars
loop1:
	mov	bx,ax
	and	ebx,and1
        mov     [di],ebx
        rol     eax,6
        xor     eax,01f49d75ah
        sub     eax,0fe93d19ah
	mov	bx,ax
	and	ebx,and1
        mov     4[di],ebx
        rol     eax,6
        xor     eax,01f49d75ah
        sub     eax,0fe93d19ah
	mov	bx,ax
	and	ebx,and1
        mov     8[di],ebx
        add     di,12
        rol     eax,6
        xor     eax,01f49d75ah
        sub     eax,0fe93d19ah
        loop    loop1
	ret

stars:
	lea	si,XYZcords
	mov	cx,no_stars
lalw:
	add	dword ptr [si],speed
	and	dword ptr [si],and1
	add	si,12
	loop	lalw

	mov	si,cur_clearlist
        mov     ax,0a000h
        mov     es,ax
        mov     cl,0h
loaps:
        lodsw
        mov     bx,ax
        lodsw
	mov	bp,ax
	mov	word ptr ax,masklist1[bp]
	mov	dx,03c4h
	out	dx,ax
	mov	word ptr ax,masklist2[bp]
	mov	dx,03ceh
	out	dx,ax

	test	es:[bx],byte ptr 0ffh
	jns	donno
        mov     es:[bx],cl
donno:
        cmp     word ptr [si],-1
        jne     loaps

        add     angleA,deltaA
        add     angleB,deltaB
        add     angleC,deltaC

        lea     si,sinelist
        mov     bx,angleA
        shr     bx,4
        and     bx,0fffh
        add     bx,bx
        mov     ax,[si+bx]
        mov     sinA,ax
        mov     ax,800h[si+bx]
        mov     cosA,ax

        mov     bx,angleB
        shr     bx,4
        and     bx,0fffh
        add     bx,bx
        mov     ax,[si+bx]
        mov     sinB,ax
        mov     ax,800h[si+bx]
        mov     cosB,ax

        mov     bx,angleC
        shr     bx,4
        and     bx,0fffh
        add     bx,bx
        mov     ax,[si+bx]
        mov     sinC,ax
        mov     ax,800h[si+bx]
        mov     cosC,ax

        mov     ax,cs
        mov     es,ax
        lea     di,con1
;x const
        movsx   dword ptr eax,cosA
        movsx   dword ptr edx,cosC
        imul    edx
        sar     eax,14
        mov     ebx,eax
        movsx   dword ptr eax,sinA
        movsx   dword ptr edx,sinB
        imul    edx
        sar     eax,14
        movsx   dword ptr edx,sinC
        imul    edx
        sar     eax,14
        add     eax,ebx
        stosw

        movsx   dword ptr eax,cosB
        movsx   dword ptr edx,sinC
        imul    edx
        sar     eax,14
        neg     eax
        stosw

        movsx   dword ptr eax,cosA
        movsx   dword ptr edx,sinB
        imul    edx
        sar     eax,14
        movsx   dword ptr edx,sinC
        imul    edx
        sar     eax,14
        mov     ebx,eax
        movsx   dword ptr eax,sinA
        movsx   dword ptr edx,cosC
        imul    edx
        sar     eax,14
        neg     eax
        add     eax,ebx
        stosw

;y const
        movsx   eax,word ptr cosA
        movsx   edx,word ptr sinC
        imul    edx
        sar     eax,14
        mov     ebx,eax
        movsx   eax,word ptr sinA
        movsx   edx,word ptr sinB
        imul    edx
        sar     eax,14
        movsx   edx,word ptr cosC
        imul    edx
        sar     eax,14
        neg     eax
        add     eax,ebx
        stosw

        movsx   edx,word ptr cosB
        movsx   eax,word ptr cosC
        imul    edx
        sar     eax,14
        stosw

        movsx   edx,word ptr sinA
        movsx   eax,word ptr sinC
        imul    edx
        sar     eax,14
        mov     ebx,eax
        neg     ebx
        movsx   edx,word ptr cosA
        movsx   eax,word ptr sinB
        imul    edx
        sar     eax,14
        movsx   edx,word ptr cosC
        imul    edx
        sar     eax,14
        neg     eax
        add     eax,ebx
        stosw

;z const
        movsx   dword ptr eax,sinA
        movsx   dword ptr edx,cosB
        imul    edx
        sar     eax,14
        stosw

        mov     ax,sinB
        stosw

        movsx   dword ptr eax,cosA
        movsx   dword ptr edx,cosB
        imul    edx
        sar     eax,14
        stosw


        lea     si,XYZcords
        lea     di,XYZfinal
rotloop:
        mov     ebx,[si]
        mov     ecx,4[si]
        mov     ebp,8[si]
	sub	ebx,sub1
	sub	ecx,sub1
	sub	ebp,sub1

        mov     ax,con1
        imul    bx
        mov     [di],ax
        mov     2[di],dx
        mov     ax,con2
        imul    cx
        add     [di],ax
        adc     2[di],dx
        mov     ax,con3
        imul    bp
        add     ax,xorg
        add     [di],ax
        adc     2[di],dx
        mov     eax,[di]
        sar     eax,14
        mov     [di],ax

        mov     ax,con4
        imul    bx
        mov     2[di],ax
        mov     4[di],dx
        mov     ax,con5
        imul    cx
        add     2[di],ax
        adc     4[di],dx
        mov     ax,con6
        imul    bp
        add     ax,yorg
        add     2[di],ax
        adc     4[di],dx
        mov     eax,2[di]
        sar     eax,14
        mov     2[di],ax

        mov     ax,con7
        imul    bx
        mov     4[di],ax
        mov     6[di],dx
        mov     ax,con8
        imul    cx
        add     4[di],ax
        adc     6[di],dx
        mov     ax,con9
        imul    bp
        add     4[di],ax
        adc     6[di],dx
        mov     eax,4[di]
        sar     eax,14
        mov     4[di],ax

        add     di,6
        add     si,012
        cmp     dword ptr [si],endlist
        jne     rotloop

        mov     ax,endlist
        stosw

        lea     si,XYZfinal
        mov     cx,dist
	mov	di,cur_clearlist
        mov     ax,0a000h
        mov     es,ax
        mov     eax,0h
loop13:
        mov     bp,4[si]
        add     bp,cx
        add     bp,zorg

        mov     ax,[si]
        imul    cx
        idiv    bp
        mov     bx,ax

        mov     ax,2[si]
        imul    cx
        idiv    bp
	neg     ax

        add     ax,screen_yorg
        add     bx,screen_xorg
        cmp     ax,ymax
        jae     bad_plot
        cmp     bx,xmax
        jb      do_plot
bad_plot:
        jmp     dont_plot
do_plot:
        mul     word ptr lmres
	mov	bp,bx
	shr	bx,2
        add     bx,ax
	add	bx,addpage

	and	bp,3
	add	bp,bp
	mov	word ptr ax,masklist1[bp]
	mov	dx,03c4h
	out	dx,ax
	mov	word ptr ax,masklist2[bp]
	mov	dx,03ceh
	out	dx,ax

	test	es:[bx],byte ptr 0ffh
	jz	plot1
	jns	dont_plot
plot1:
        mov     [di],bx
        mov     2[di],bp
        add     di,4

        mov     dx,4[si]
	add	dx,03c0h
        shr     dx,6
	add	dl,080h
        mov     byte ptr es:[bx],dl
dont_plot:
        add     si,6
        cmp     word ptr [si],endlist
        jne     loop13

        mov     word ptr [di],-1h
        ret

;********************************************************************
	IF MUSIC
stmik:
	cmp	word ptr [SB_port],-1
	je	noplay
	call	stmik_asm
noplay:
	ret

;********************************************************************
SB_getport:
	mov	bx,0210h
a270:
	mov	dx,bx
	add	dx,00ch
	mov	al,0d3h
	mov	cx,0ffffh
	mov	ah,al
a27c:
	in	al,dx
	or	al,al
	jns	a285
	loop	a27c
	jmp	a2bc
a285:
	mov	al,ah
	out	dx,al

	mov	dx,0300h
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx

	mov	dx,bx
	add	dx,06h
	mov	al,1
	out	dx,al

	mov	dx,0300h
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx
	in	al,dx

	mov	dx,bx
	add	dx,06h
	mov	al,0
	out	dx,al

	mov	cx,0010h
a2a0:
	push	cx
	mov	dx,bx
	add	dx,0eh
	mov	cx,0ffffh
a2a7:
	in	al,dx
	or	al,al
	js	a2b1
	loop	a2a7
	pop	cx
	jmp	a2bc

a2b1:
	pop	cx
	mov	dx,bx
	add	dx,0ah
	in	al,dx
	cmp	al,0aah
	jz	a2c8
	loop	a2a0
a2bc:
	add	bx,010h
	cmp	bx,00260h	
	jle	a270
	jmp	ano_SB
a2c8:
	mov	SB_port,bx
	ret

ano_SB:
	mov	word ptr SB_port,-1
	ret

;********************************************************************
saveport21	db 0
sIRQ21		dw 0
sIRQ22		dw 0
sIRQ31		dw 0
sIRQ32		dw 0
sIRQ51		dw 0
sIRQ52		dw 0
sIRQ71		dw 0
sIRQ72		dw 0

SB_getirq:
	cmp	word ptr SB_port,-1
	je	noIRQ

	mov	ax,0
	mov	es,ax
	cli
	mov	ax,es:[0028h]
	mov	dx,es:[002ah]
	mov	cs:sIRQ21,ax
	mov	cs:sIRQ22,dx

	mov	ax,es:[002ch]
	mov	dx,es:[002eh]
	mov	cs:sIRQ31,ax
	mov	cs:sIRQ32,dx

	mov	ax,es:[0034h]
	mov	dx,es:[0036h]
	mov	cs:sIRQ51,ax
	mov	cs:sIRQ52,dx

	mov	ax,es:[003ch]
	mov	dx,es:[003eh]
	mov	cs:sIRQ71,ax
	mov	cs:sIRQ72,dx

	mov	bx,cs
	mov	word ptr es:[0028h],offset TESTIRQ2
	mov	word ptr es:[002ch],offset TESTIRQ3
	mov	word ptr es:[0034h],offset TESTIRQ5
	mov	word ptr es:[003ch],offset TESTIRQ7
	mov	es:[002ah],bx
	mov	es:[002eh],bx
	mov	es:[0036h],bx
	mov	es:[003eh],bx
	sti

	in	al,021h
	mov	saveport21,al
	and	al,053h
	out	21h,al
	mov	byte ptr SB_irq,0

	mov	al,0f2h
	push	dx
	mov	dx,SB_port
	add	dx,0ch
	mov	ah,al
a47e:
	in	al,dx
	or	al,al
	jns	a485
	jmp	a47e
a485:
	mov	al,ah
	out	dx,al
	pop	dx

	mov	cx,0ffffh
a421:
	cmp	byte ptr SB_irq,0
	jne	a429
	loop	a421
ERROR:
	mov	word ptr SB_port,-1
a429:
	mov	al,saveport21
	out	21h,al

	mov	ax,0
	mov	es,ax
	cli
	mov	ax,cs:sIRQ21
	mov	dx,cs:sIRQ22
	mov	es:[0028h],ax
	mov	es:[002ah],dx

	mov	ax,cs:sIRQ31
	mov	dx,cs:sIRQ32
	mov	es:[002ch],ax
	mov	es:[002eh],dx

	mov	ax,cs:sIRQ51
	mov	dx,cs:sIRQ52
	mov	es:[0034h],ax
	mov	es:[0036h],dx

	mov	ax,cs:sIRQ71
	mov	dx,cs:sIRQ72
	mov	es:[003ch],ax
	mov	es:[003eh],dx
	sti
noIRQ:
	ret

TESTIRQ2:
	push	ds
	push	ax
	push	dx
	mov	al,2
	mov	ah,01011111b
TESTFIN:
	mov	dx,cs
	mov	ds,dx
	mov	SB_irq,al
	mov	SB_mask,ah
	mov	dx,SB_port
	in	al,dx
	mov	al,20h
	out	20h,al
	pop	dx
	pop	ax
	pop	ds
	iret

TESTIRQ3:
	push	ds
	push	ax
	push	dx
	mov	al,3
	mov	ah,01101111b
	jmp	TESTFIN

TESTIRQ5:
	push	ds
	push	ax
	push	dx
	mov	al,5
	mov	ah,01111011b
	jmp	TESTFIN

TESTIRQ7:
	push	ds
	push	ax
	push	dx
	mov	al,7
	mov	ah,01111110b
	jmp	TESTFIN

	ENDIF

setpalette:
        mov     dx,03c8h
        out     dx,al
        inc     dx
        cld
        rep     outsb
        ret

waitraster:
        mov     dx,3dah
ras1:
	in      al,dx
        test    al,8
        jnz     ras1
ras2:
        in      al,dx
        test    al,8
        jz      ras2
        ret

red:
        mov     al,0h
        mov     dx,03c8h
        out     dx,al
        inc     dx
        mov     al,0h
        out     dx,al
        mov     al,3fh
        out     dx,al
        mov     al,0h
        out     dx,al
        ret

black:
        mov     al,0h
        mov     dx,03c8h
        out     dx,al
        inc     dx
        mov     al,0h
        out     dx,al
        mov     al,0h
        out     dx,al
        mov     al,0h
        out     dx,al
        ret

;CODE    ENDS
END     start
