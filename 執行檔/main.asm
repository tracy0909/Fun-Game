INCLUDE Irvine32.inc

.data

;����data
 ;fun world �ƪ��r��
  funWorld1 BYTE "                 *****    *     *     *      *        *       *       *  ******  *******  *       ***** *     ", 0   
  funWorld2 BYTE "                 *        *     *     * *    *         *     * *     *   *    *  *     *  *       *       *   ", 0
  funWorld3 BYTE "                 ***      *     *     *   *  *          *   *   *   *    *    *  *******  *       *       *   ", 0
  funWorld4 BYTE "                 *        *     *     *    * *           * *     * *     *    *  * *      *       *      *    ", 0
  funWorld5 BYTE "                 *        *******     *      *            *       *      ******  *    *   ******  ***** *     ", 0
  HomeWelcome BYTE "Welcome to the FUN World!", 0                    ;�����@�}�l���w��r��
  introduce BYTE "Here are two games you can chose to play~", 0      ;�C�����Цr��
  game1Sentence BYTE "   A.Guess Number", 0                              ;game1�ﶵ
  game2Sentence BYTE "    B.SnakeGame", 0                                ;game2�ﶵ
  chose BYTE "Please press A to enter GAME1, and press B to enter GAME2.",0   ;�i�D�ϥΪ̦p���ܰT��

;Game1 data�ŧi
  game1Welcome BYTE "Welcome to guess number!", 0                     ;game1�@�}�l���w��r��
  sentence1 BYTE "You can enter the number between 1-100", 0          ;�i���ϥΪ̥i��J�Ʀr�d��T��
  getNumber BYTE "Please enter your guess number:", 0                 ;�ШϥΪ̿�J�Ʀr�T��
  tryAgain BYTE "Try again!", 0                                       ;try again�T��
  pressKeyToReplay BYTE "You can press R to replay.", 0               ;��R�i�H�^�쭺�����s��ܰT��

  tooHigh BYTE "Your number is too large!", 0            ;�Ʀr�Ӥj�T���r��
  tooLow BYTE "Your number is too small!", 0             ;�Ʀr�Ӥp�T���r��
  rightSentence BYTE "You got it!!! ", 0                 ;���\�T���r��
  invalidInput BYTE "Your input is invalid!", 0          ;���ainput���X�z�r��

  currentMin BYTE "Current Min:", 0                      ;�{�b�i�q�Ʀr�d��U�����T���r��
  currentMax BYTE "Current Max:", 0                      ;�{�b�i�q�Ʀr�d��W�����T���r��

  randomNum BYTE ?              ;�H���ü�-�Ʀr����
  userGuess BYTE ?              ;���a�q���Ʀr     

  minNumber BYTE 1              ;�U���ƭȡA��l��1
  maxNumber BYTE 100            ;�W���ƭȡA��l��100
 

;Game2 data �ŧi
	game2Welcome BYTE "Welcome to the SNAKE GAME !", 0                     ;game2�@�}�l���w��r��
	snakeWord1 BYTE "          ###### ",0
	snakeWord2 BYTE "         ##########             ##########           ##########             ##########           ##########", 0 ;�D�ϧΪ�  
	snakeWord3 BYTE "       #()######()#	######### ########## ########## ################### ########## ########## ##########", 0
	snakeWord4 BYTE "	###0##0###    ##########           ##########         ##########           ##########         ##########", 0
	snakeWord5 BYTE "	  ##$##", 0
	snakeWord6 BYTE "	   $ ", 0
	snakeWord7 BYTE "	  $ ", 0
	Word1		BYTE "                START THE SNAKE GAME               ",0    ;�C�����D
	Word2		BYTE "Your Score is: ",0				   	      ;�������
	Word3		BYTE "GAME OVER! Do you want to replay?_(R/N)",0				;�����C��
	Word4		BYTE "GOAL:",0									  ;�C������
	Word5		BYTE "Eat $,",0  	
	Word6		BYTE "to get grade",0 
	Word7		BYTE "HINT:",0  					
	Word8		BYTE "Do not touch",0  					
	Word9		BYTE "the wall",0  					
	frontOfSnakex 		BYTE ?								;�D���e�q����x
	frontOfSnakey 		BYTE ?								;�D���e�q����y
	front 		BYTE 2					
	star 		BYTE "*"							
	coinOfx		BYTE ?										;����x�b
	coinOfy		BYTE ?										;����y�b
	eatCoin	BYTE 0											;�Y����		
	orient 	BYTE 0  							
	previousOrient 	BYTE 0								
	myWall1 	BYTE "---------------------------------------------------",0      ;�P��|����
	myWall2 	BYTE "|						 	|",0
	coin		BYTE "$"									;����	
	backOfSnakex		BYTE ?								;�D�����ڳ���x
	backOfSnakey		byte ?								;�D�����ڳ���y
	StarOfx		BYTE 735 DUP(0)	
	StarOfy		BYTE 735 DUP(0)	
	StarNumber	DWORD 0										;�D�֦���*��
	grade		DWORD 0								
	rate		WORD 0

;��Ldata
   pressAnyKey BYTE "Please press any key to continue...", 0          ;�����N���~��T��


.code
main PROC

Home:
  ;�C���w�虜��

  ;�ƪ�
    call crlf                  ;����
	call crlf                  ;����
	call crlf                  ;����

  ;�L�Xfun world �r��
	mov edx, offset funWorld1 
	call WriteString 
	call crlf                  ;����
	mov edx, offset funWorld2 
	call WriteString 
    call crlf                  ;����
	mov edx, offset funWorld3 
	call WriteString 
	call crlf                  ;����
	mov edx, offset funWorld4 
	call WriteString 
	call crlf                  ;����
	mov edx, offset funWorld5
	call WriteString 
    call crlf                  ;����
   
   ;�L�X���ϥΪ̫��U���@���~��T��
    mov dh, 20               ;����y�y��(row)
    mov dl, 40               ;����x�y��(column)
    call Gotoxy              ;���ر����Ш禡
	mov edx, offset pressAnyKey
    call WriteString  

  ;�����N��-����Ū�@�Ӧr���AŪ���ᤣ������B�z
    call ReadChar                       ;Ū�J�r��(���ϥΪ̫���L)

	jmp clearToChosePage                ;Ū�����N�����ܿ�歶��(�����M�̳B�z)
    
clearToChosePage:
    call clrscr                         ;�M��
	jmp ChosePage                

ChosePage:     
  ;��歶��
    mov dh, 6                ;����y�y��(row)
    mov dl, 48               ;����x�y��(column)
    call Gotoxy              ;���ر����Ш禡
    mov edx, offset HomeWelcome       ;�L�X�w��r
    call WriteString   
    call crlf                ;����

  ;����
    mov dh, 8                ;����y�y��(row)
    mov dl, 40               ;����x�y��(column)
    call Gotoxy              ;���ر����Ш禡
    mov edx, offset introduce       ;�L�X���Цr
    call WriteString   
    call crlf                ;����    

  ;�L�X�C����ܦC
    mov dh, 12                          ;����y�y��(row)
    mov dl, 50                          ;����x�y��(column)
    call Gotoxy                         ;���ر����Ш禡
    mov edx, offset game1Sentence       ;�L�Xgame1�ﶵ
    call WriteString   
    call crlf                           ;����  
    mov dh, 14                          ;����y�y��(row)
    mov dl, 50                          ;����x�y��(column)
    call Gotoxy                         ;���ر����Ш禡
    mov edx, offset game2Sentence       ;�L�Xgame2�ﶵ
    call WriteString   
    call crlf                           ;���� 

  ;�L�X�ШϥΪ̿�ܰT��
    mov dh, 25               ;����y�y��(row)
    mov dl, 33               ;����x�y��(column)
    call Gotoxy              ;���ر����Ш禡
    mov edx, offset chose    ;�L�X�i�D�ϥΪ̦p���ܦr��
    call WriteString    

  ;�P�_�ϥΪ̫��U���
  Read:
    call ReadChar                       ;Ū�J�r��(���ϥΪ̫���L)
    cmp al, 'A'                         ;Ū�J�ȷ|�bal��,�P�_Ū�J�O�_=A(***�j�p�g����)
    je ClearToGame1                     ;�O�h����ClearToGame1�ǳƶi�Jgame1      
    cmp al, 'a'                         ;�P�_�p�ga
    je ClearToGame1                     ;�@�ˬO�h����ClearToGame1�ǳƶi�Jgame1  
    cmp al, 'B'                         ;�P�_Ū�J�O�_=B(***�j�p�g����)
    je ClearToGame2                     ;�O�h����ClearToGame1�ǳƶi�Jgame1 
    cmp al, 'b'                         ;�P�_�p�gb
    je ClearToGame2                     ;�@�ˬO�h����ClearToGame1�ǳƶi�Jgame1 
    jmp Read                            ;���O�h�~��Ū

  ClearToGame1:
   call clrscr                ;�M��
   jmp Game1                  ;����Game1�Y�i�J�C��1 
   
  ClearToGame2:
   call clrscr                ;�M��
   jmp Game2                  ;����Game2�Y�i�J�C��2     


Game1:
  ;�L�X�w��r��
    mov dh, 6                ;����y�y��(row)
    mov dl, 45               ;����x�y��(column)
    call Gotoxy              ;���ر����Ш禡
    mov edx, offset game1Welcome
    call WriteString   
    call crlf                ;����

  ;�L�X���ܨϥΪ̫����N��r��
    mov dh, 15               ;����y�y��(row)
    mov dl, 40               ;����x�y��(column)
    call Gotoxy              ;���ر����Ш禡
    mov edx, offset pressAnyKey
    call WriteString   

  ;�����N��-����Ū�@�Ӧr���AŪ���ᤣ������B�z
    call ReadChar                       ;Ū�J�r��(���ϥΪ̫���L)

  ;ClearScreenToStartGame
    call clrscr   
    jmp StartGame
  
  StartGame:

    Generate:       ;�����H���ü�
   
      call Randomize        ;�I�sasm���ضüƨ禡,���ͷs���@�նü�(�C�����|���P)
      mov eax, 99           ;�Neax�̦s99�A�ǳƩI�srandomrange�禡
      call RandomRange      ;�|����0-99�d�򪺶ü�
      inc eax               ;�Neax+1�϶üƽd�򸨦b1-100
      mov randomNum, al     ;�N���o���H���üƦs�i�ܼƸ�

	;�i���ϥΪ̥i��J�Ʀr�d��
      mov dh, 10                   ;����y�y��(row)
      mov dl, 40                   ;����x�y��(column)
      call Gotoxy                  ;���ر����Ш禡
      mov edx, offset sentence1    ;�ǳƦL�X�����Ʀr�d��r��
      call WriteString
      call crlf                    ;����
 

    L1:               ;���a��J

	;�L�X�{�b�i�q�Ʀr�d��r��
	 ;�U��-�L�b�e������
      mov dh, 8                   ;����y�y��(row)
      mov dl, 10                  ;����x�y��(column)
      call Gotoxy                 ;���ر����Ш禡	  
      mov edx, offset currentMin  ;�L�X�i�q�Ʀr�U���r��
	  call WriteString

	  mov al, minNumber           ;��minNumber�h�ial�Ȧs�����ǳƦL�X
	  call WriteDec


	;�W��-�L�b�e���k��
      mov dh, 8                   ;����y�y��(row)
      mov dl, 95                  ;����x�y��(column)
      call Gotoxy                 ;���ر����Ш禡	  
      mov edx, offset currentMax  ;�L�X�i�q�Ʀr�W���r��	
	  call WriteString

	  mov al, maxNumber           ;��maxNumber�h�ial�Ȧs�����ǳƦL�X
	  call WriteDec

	  

    ;�ШϥΪ̿�J�Ʀr
      mov dh, 13                  ;����y�y��(row)
      mov dl, 43                  ;����x�y��(column)
      call Gotoxy                 ;���ر����Ш禡
      mov edx, offset getNumber   ;�L�X�ШϥΪ̿�J���r��
      call WriteString
      call readDec                ;Ū�J���a�q���Ʀr(unsigned integer)
      mov userGuess, al           ;�s�J�ܼ�
      jne ClearScreenToNext       ;Ū���ƭȫ����ClearScreenToNext�M�̤����e��



    ClearScreenToNext:
      call clrscr
      jmp Compare                 ;����compare����Ʀr�P�_


    TooBig:                   ;���ӼƭȬ��U�@�����W���ȨæL�X�Ʀr�L�j����
	 ;���{�b���W����
	  mov al, userGuess           ;����ϥΪ̲q���ƭȦs�J�Ȧs��
	  mov maxNumber, al           ;�A��ӭȷh�imaxNumber�ܼƸ�	  

	 ;�L�X�Ʀr�L�j����
      mov dh, 15                  ;����y�y��(row)
      mov dl, 45                  ;����x�y��(column)
      call Gotoxy                 ;���ر����Ш禡
      mov edx, offset tooHigh     ;�ǳƦL�X�ƭȹL�j�r��
      call WriteString 
      call crlf                   ;����
      call DisplayTryAgain        ;�I�s�禡�L�X�r��Ъ��a���s��J
      jmp L1                      ;���s�@����J

    TooSmall:                ;���ӼƭȬ��U�@�����U���ȨæL�X�Ʀr�L�p����
	 ;���{�b���U����
	  mov al, userGuess           ;����ϥΪ̲q���ƭȦs�J�Ȧs��
	  mov minNumber, al           ;�A��ӭȷh�iminNumber�ܼƸ�
     
	 ;�L�X�Ʀr�L�p����
      mov dh, 15                  ;����y�y��(row)
      mov dl, 45                  ;����x�y��(column)
      call Gotoxy                 ;���ر����Ш禡
      mov edx, offset tooLow      ;�ǳƦL�X�ƭȹL�p�r��
      call WriteString 
      call crlf                   ;����
      call DisplayTryAgain        ;�I�s�禡�L�X�r��Ъ��a���s��J
      jmp L1                      ;���s�@����J

	InvalidGuess:           ;�L�X��J���X�z����
      mov dh, 15                  ;����y�y��(row)
      mov dl, 48                  ;����x�y��(column)
      call Gotoxy                 ;���ر����Ш禡
      mov edx, offset invalidInput     
      call WriteString 
      call crlf                   ;����
      call DisplayTryAgain        ;�I�s�禡�L�X�r��Ъ��a���s��J
      jmp L1                      ;���s�@����J	  

    Bingo:                   ;�L�X���\�r��
      mov dh, 10                  ;����y�y��(row)
      mov dl, 48                  ;����x�y��(column)
      call Gotoxy                 ;���ر����Ш禡
      mov edx, offset rightSentence
      call WriteString
      jmp TheEnd
	  

  
    Compare:           ;�P�_���a�q���Ʀr�O�_���T(�ϥ�cmp)

      mov bl, userGuess         ;�⪱�a�q���Ʀr�s�ibl�Ȧs����
	  cmp bl, 1                 ;�⪱�a�q���Ʀr�M1�����
	  jb InvalidGuess           ;�p��h���ܤ��X�z��J���B�z
	  cmp bl, 100               ;�⪱�a�q���Ʀr�M100�����
	  ja InvalidGuess           ;�j��h���ܤ��X�z��J���B�z

      cmp bl,randomNum          ;���ۤ�����a�q���Ʀr�P���e���ͪ����׼Ʀr
      ja TooBig                 ;���a�q���Ʀr>����
      jb TooSmall               ;���a�q���Ʀr<����
      je Bingo                  ;���a�q���Ʀr=���� 

	  jmp InvalidGuess          ;�W�z�����ŦX�h�]�O���X�z��J-���ܸӳB���B�z
    
    TheEnd:
      mov dh, 20                  ;����y�y��(row)
      mov dl, 42                  ;����x�y��(column)
      call Gotoxy                 ;���ر����Ш禡
      mov edx, offset pressKeyToReplay
      call WriteString
      ReadR:
        call ReadChar                       ;Ū�J�r��(���ϥΪ̫���L)
        cmp al, 'R'                         ;Ū�J�ȷ|�bal��,�P�_�O�_=R(***�j�p�g����)
        je ClearToReplay                    ;����N����ClearToReplay�ǳƭ��s�}�l
        cmp al, 'r'                         ;����p�gr
        je ClearToReplay                    ;�@�˵���N����ClearToReplay�ǳƭ��s�}�l
        jmp ReadR                           ;�����۵��N�~��Ū


     ClearToReplay:
      call clrscr                ;�M��
      jmp Game1                  ;�^��Game1�Y

    DisplayTryAgain PROC    ;�L�X�Ъ��a���s��J���禡
      mov dh, 16                  ;����y�y��(row)
      mov dl, 52                  ;����x�y��(column)
      call Gotoxy                 ;���ر����Ш禡
      mov edx, offset tryAgain
      call WriteString
      call crlf                    ;����
      ret
    DisplayTryAgain ENDP 

Game2:
;�L�X�w��r�ˤγD�Ϯ�
    call crlf						;����
    call crlf						;����
    mov dh, 4						;����y�y��(row)
    mov dl, 45						;����x�y��(column)
    call Gotoxy						;���ر����Ш禡
	mov eax, lightgray+(magenta*16)	;�]�w���D��r
	call SetTextColor				;���D��r�C��
    mov edx, offset game2Welcome
    call WriteString   
    call crlf						;����
    call crlf						;����
	call crlf						;����
	call crlf						;����
  	mov eax, green		;�]�w���D��r
	call SetTextColor				;���D��r�C��
	mov edx, offset snakeWord1 
	call WriteString 
	call crlf                  ;����
	mov edx, offset snakeWord2 
	call WriteString 
    call crlf                  ;����
	mov edx, offset snakeWord3 
	call WriteString 
	call crlf                  ;����
	mov edx, offset snakeWord4 
	call WriteString 
	call crlf                  ;����
	mov edx, offset snakeWord5
	call WriteString 
    call crlf                  ;����
   	mov eax, red		;�]�w���D��r
	call SetTextColor				;���D��r�C��
	mov edx, offset snakeWord6
	call WriteString 
    call crlf                  ;����
	mov edx, offset snakeWord7
	call WriteString 
    call crlf                  ;����
   	mov eax, lightgray		;�]�w���D��r
	call SetTextColor				;���D��r�C��
  ;�L�X���ܨϥΪ̫����N��r��
    mov dh, 20               ;����y�y��(row)
    mov dl, 40               ;����x�y��(column)
    call Gotoxy              ;���ر����Ш禡
    mov edx, offset pressAnyKey
    call WriteString   

  ;�����N��-����Ū�@�Ӧr���AŪ���ᤣ������B�z
    call ReadChar                       ;Ū�J�r��(���ϥΪ̫���L)

  ;ClearScreenToStartGame
    call clrscr   
    jmp startSnakeGame
startSnakeGame::
	pushad							;������push��Ȧs��
	call Clrscr						;�M��
	mov ax,88
	mov rate,ax					;�]�w�t��
	mov eax,0
	mov grade,eax					;�]�w����
	mov eax,0
	mov StarNumber,eax				;�]�w�D���W��*
	mov al,0
	mov eatCoin,al				;�]�w�D�Y�h�֭�$
	popad							;�ۤ϶���pop�X�Ȧs��
	mov dl, 14						;����y�y��(row)
	mov dh, 2						;����x�y��(column)
	call Gotoxy						;���ر����Ш禡
	mov eax, black+(yellow*16)		;�]�w���D��r
	call SetTextColor				;���D��r�C��
	mov edx, OFFSET Word1			
	call WriteString				;�L�X���D
	mov dl, 0						;����y�y��(row)
	mov dh, 8						;����x�y��(column)
	call Gotoxy						;���ر����Ш禡
	mov eax, cyan					
	call SetTextColor				;�]�wString4�C��
	mov edx, OFFSET Word4		
	call WriteString				;�L�XString4�A���䴣�ܦr
	mov dl, 0						;����y�y��(row)
	mov dh, 9						;����x�y��(column)
	call Gotoxy						;���ر����Ш禡
	mov eax, cyan					
	call SetTextColor				;�]�wString5�C��
	mov edx, OFFSET Word5			
	call WriteString				;�L�XString5�A���䴣�ܦr
	mov dl, 0						;����y�y��(row)
	mov dh, 10						;����x�y��(column)
	call Gotoxy						;���ر����Ш禡
	mov eax, cyan					
	call SetTextColor				;�]�wString6�C��
	mov edx, OFFSET Word6	
	call WriteString				;�L�XString6�A���䴣�ܦr
	mov dl, 0						;����y�y��(row)
	mov dh, 12						;����x�y��(column)
	call Gotoxy						;���ر����Ш禡
	mov eax, cyan					
	call SetTextColor				;�]�wString7�C��
	mov edx, OFFSET Word7	
	call WriteString				;�L�XString7�A���䴣�ܦr
	mov dl, 0						;����y�y��(row)
	mov dh, 13						;����x�y��(column)
	call Gotoxy						;���ر����Ш禡
	mov eax, cyan					
	call SetTextColor				;�]�wString8�C��
	mov edx, OFFSET Word8	
	call WriteString				;�L�XString8�A���䴣�ܦr
	mov dl, 0						;����y�y��(row)
	mov dh, 14						;����x�y��(column)
	call Gotoxy						;���ر����Ш禡
	mov eax, cyan					
	call SetTextColor				;�]�wString9�C��
	mov edx, OFFSET Word9	
	call WriteString				;�L�XString9�A���䴣�ܦr
	mov dl, 14						;����y�y��(row)
	mov dh, 4						;����x�y��(column)
	call Gotoxy						;���ر����Ш禡
	mov edx, OFFSET myWall1			
	mov eax, white+(blue*16)		;�]�wbricks1�C��
	call SetTextColor	
	call WriteString				;�L�Xbricks1
	mov ah, 20
Brick:								;�L�X���
	mov dl, 14						;����y�y��(row)
	mov dh, ah						;����x�y��(column)
	call Gotoxy						;���ر����Ш禡
	dec ah
	mov edx, OFFSET myWall2	
	call WriteString				;�L�Xbricks2
	cmp ah, 4						;���x�y��
	jg Brick							;�j��h��
	mov dl, 14						;����y�y��(row)
	mov dh, 21						;����x�y��(column)
	call Gotoxy						;���ر����Ш禡
	mov edx, OFFSET myWall1			
	call WriteString				;�L�X���
NumberOfX:
	mov eax,36
	mov frontOfSnakex, al			;��ɽd��
	mov esi, OFFSET StarOfx		
	mov [esi], al					;�y�а}�C
	mov dl, al					
NumberOfY:
	mov eax,12
	mov frontOfSnakey, al			;��ɽd��
	mov esi, OFFSET StarOfy
	mov [esi], al					;�y�а}�C
	mov dh, al						;����x�y��(column)
	call Gotoxy						;���ر����Ш禡
	mov eax, white					;�]�w�D���C��
	call SetTextColor				;�L�X�D���C��
	mov al, front			
	call WriteChar					;�L�X�D
SameOrient:
	mov ah, orient					
	call MoveSnake						;�I�s����function
	call Current					;�I�s�D��function
	call CoinsOut					;�I�s�D*
	jmp GameBegin
GameBegin:
	call ReadKey					;Ū����L�A�����@��
	jz SameOrient				;�Y�S��������A�h�ۦP��V
	cmp ah, 51H						;���x�b�y��
	jg GameBegin						;�j��h���^�o��function
	cmp ah, 47H						;���x�b�y��
	jl GameBegin						;�p��h���^�o��function�A�ò���
	call MoveSnake						;�I�s����function
	call Current					;�I�s�D��function
	call CoinsOut					;�I�s�D*
	jmp GameBegin

main ENDP
MoveSnake PROC USES eax edx
	mov orient, ah			
	call SnakeRate					;�p��C���t��
	mov ax, rate
	movzx eax, ax					;�I�sdelay function
	call Delay					
	mov dl, 0						;����y�y��(row)
	mov dh, 9						;����x�y��(column)
	call Gotoxy						;���ر����Ш禡
	mov ax, rate
	movzx eax, ax
	mov dl, frontOfSnakex			;����D�e��y�y��(row)
	mov dh, frontOfSnakey			;����D�e��x�y��(column)
	call Gotoxy						;���ر����Ш禡
	mov al, ' '
	call WriteChar		
	call CoinEat					;�I�s�Y�w��
	mov ah, orient					;�]�w��V��ah	
	mov al, previousOrient			;�]�w���e��V��al
	cmp dl, 64						;����D�Y����m
	jge GameIsOver					;�j��h�C������
	cmp dl, 14						;����D�Y����m
	jle GameIsOver					;�p��h�C������
	cmp dh, 21						;����D�Y����m
	jge GameIsOver					;�j��h�C������
	cmp dh, 4						;����D�Y����m
	jle GameIsOver					;�p��h�C������
	cmp ah, 48H						;����o�ӼƭȡA�h����V�W��function
	je Top
	cmp ah, 50H						;����o�ӼƭȡA�h����V�U��function
	je Below
	cmp ah, 4DH						;����o�ӼƭȡA�h����V�k�䪺function
	je OverRight
	cmp ah, 4BH						;����o�ӼƭȡA�h����V���䪺function
	je OverLeft
	jmp Fulfill
Top:	
	mov previousOrient, 48H			;�V�W��function
	cmp al, 50H
	je Below							;����h�����V�U
	dec dh							;����x�b
	jmp HeadLocationOfUpdate				
Below:
	mov previousOrient, 50H			;�V�U��function
	cmp al, 48H						
	je Top							;����h�����V�U
	inc dh							;����x�b
	jmp HeadLocationOfUpdate
OverRight:
	mov previousOrient, 4DH			;�V�k�䪺function
	cmp al, 4BH
	je OverLeft							;����h�����V����
	inc dl							;���Wy�b
	jmp HeadLocationOfUpdate
OverLeft:
	mov previousOrient, 4BH			;�V���䪺function
	cmp al, 4DH
	je OverRight						;����h�����V�k��
	dec dl							;����y�b
	jmp HeadLocationOfUpdate
HeadLocationOfUpdate:
	mov frontOfSnakex, dl			;��s�D�Ҧb����m
	mov frontOfSnakey, dh			;�N��m�B�s�b���e��m�B
	call Gotoxy			
	mov al, front
	call WriteChar					;�L�X�Ҧb��m
Fulfill:
	ret
GameIsOver:
	mov dl, frontOfSnakex			;��������h�C������
	mov dh, frontOfSnakey
	call Gotoxy					
	mov al, front
	call WriteChar					;�L�X�Ҧb��m
	mov eax, 1000
	call Delay						;�I�sdelay�����A���X�C������
	mov dl, 20						;����y�y��(row)
	mov dh, 3						;����x�y��(column)
	call Gotoxy						;���ر����Ш禡
	mov eax, red+(lightgray*16)					
	call SetTextColor				;�]�wgame over�C��
	mov edx, OFFSET Word3		
	call WriteString				;�L�X�C�������r��
	mov dl, 20
	mov dh, 24
	mov eax, white+(black*16)		;��_���쥻�r���C��	
	call SetTextColor
	pushad
	call readchar
	cmp al,'r'						;�q��LŪ���O�_��r�A�O�h���s�C��
	popad
	je startSnakeGame				;�۵���r�A�h���ܤ@�}�l
	call Gotoxy

	exit
MoveSnake ENDP
CoinEat PROC USES eax edx
NewCoin:
	mov al, eatCoin					;�Y��w��
	cmp al, 0
	jne NotEaten					;������h���쥼�Yfunction
NumberOfX:
	mov eatCoin, 1						
	mov eax, 64
	call RandomRange				;�s���w���I�s�H���d��function�A�X�{�H���B
	cmp al, 15
	jl NumberOfX					;�p��h�����H��x�b
	mov coinOfx, al					;�]�w����y�b
	mov dl, al					
NumberOfY:
	mov eax, 18
	call RandomRange				;�s���w���I�s�H���d��function�A�X�{�H���B
	cmp al, 5
	jl NumberOfY					;�p��h�����H��y�b
	mov coinOfy, al					;�]�w����y�b
	mov dh, al
	call Gotoxy
	mov eax, white					;�]�����C��
	call SetTextColor
	mov al, coin
	call WriteChar					;�L�X�s������m
	mov al, dl
NotEaten:
	mov al, frontOfSnakex			;�]�w�D���ex�b��m
	mov ah, frontOfSnakey			;�]�w�D���ey�b��m
	mov dl, coinOfx					;�]�w����x�b��m
	mov dh, coinOfy					;�]�w����y�b��m
	cmp ax, dx					
	jne Fulfill						;���۵��h���짹��function
	mov eax, StarNumber				;�]�w�D���W*�Ʀr
	inc eax
	mov StarNumber, eax				;��s�D*�Ʀr
	mov eatCoin, 0					;�Y��0����
	call AddCoins					;�I�s�[*�禡
	call ScoreOfSnake				;�I�s��s�C���p��
	mov dl, 30						;����y�y��(row)
	mov dh, 23						;����x�y��(column)
	call Gotoxy						;���ر����Ш禡
	mov eax, white					;�]�w�p���C��
	call SetTextColor
	mov edx, OFFSET Word2		
	call WriteString				;�L�X�p���r���Х�
	mov eax, grade	
	call WriteInt					;�L�X�X���Ʀr
	jmp Fulfill
Fulfill:
	ret
CoinEat ENDP
AddCoins PROC USES eax ebx ecx esi
	mov ebx, StarNumber				;�W�[���W*��
	cmp ebx, 1						;����Y�j�󵥩�h�~��
	jge Continue					
	mov esi, OFFSET StarOfx
	mov al, frontOfSnakex			;�]�w�D���ex�b��m
	mov [esi], al					;�W�[�D���W*��(�z�L���e��m�ӼW�[)
	mov al, [esi]
	mov esi, OFFSET StarOfy
	mov al, frontOfSnakey			;�]�w�D���ey�b��m
	mov [esi], al					;�W�[�D���W*��(�z�L���e��m�ӼW�[)
	mov al, [esi]
	jmp Fulfill
Continue:						
	mov al, eatCoin			
	movzx eax, al					
	cmp al, 0						;�����0�A�h�����S�Y��A��Y���Y�����
	jne NotEaten					;������h����ܨS�Y��function
Eaten:
	mov ecx, StarNumber				;�]�w*��ecx�Ȧs��
	inc ecx							;�W�[*��
NotEaten:
	call Current					;�S�Y������h�I�s�D�ثe����
	call CoinsOut					;�I�s�L�X�D����
ShiftToRight:
	mov ebx, ecx					;�N��l��*��m�V�k���ʡA�Ϸs�[�J��*��������ɤJ
	mov esi, OFFSET StarOfx			;�Nx�b��m�ǵ�esi
	mov al, [esi+ebx-1]				;�N�s��*�[�J����*�s��
	mov [esi+ebx], al
	mov esi, OFFSET StarOfy			;�Ny�b��m�ǵ�esi
	mov al, [esi+ebx-1]				;�N�s��*�[�J����*�s��
	mov [esi+ebx], al			
	Loop ShiftToRight					;���ƴ`���V�k���ʪ�function
	mov esi, OFFSET StarOfx			;�Nx�b��m�ǵ�esi
	mov al, coinOfx
	mov [esi], al				
	mov esi, OFFSET StarOfy			;�Ny�b��m�ǵ�esi
	mov al, coinOfy
	mov [esi], al	
Fulfill:							
	ret
AddCoins ENDP
Current PROC USES eax ebx ecx esi
	mov esi, OFFSET StarOfx		
	mov al, [esi]
	mov backOfSnakex, al			;�B�s�ثe�D����x�b
	mov esi, OFFSET StarOfy
	mov al, [esi]					
	mov backOfSnakey, al			;�B�s�ثe�D����y�b
	mov ebx, 1
	mov ecx, StarNumber
	inc ecx
ShiftToLeft:
	mov esi, OFFSET StarOfx			;��s�D��*��m�A�H�O���D������q���ʦ�m�A��*��m���T
	mov al, [esi+ebx]				;�Nx�b��m�ǵ�esi
	mov [esi+ebx-1], al				;�N�s��*�[�J����*�s��
	mov esi, OFFSET StarOfy			;�Ny�b��m�ǵ�esi
	mov al, [esi+ebx]			
	mov [esi+ebx-1], al				;�N�s��*�[�J����*�s��
	mov al, [esi]				
	inc ebx
	Loop ShiftToLeft					;���ƴ`���V�����ʪ�function
	mov ebx, StarNumber
	mov esi, OFFSET StarOfx
	mov al, frontOfSnakex
	mov [esi+ebx], al
	mov al, [esi]
	mov esi, OFFSET StarOfy
	mov al, frontOfSnakey
	mov [esi+ebx], al
ret
Current ENDP
CoinsOut PROC USES eax ebx ecx edx esi
	mov dl, backOfSnakex			;�]�w�D��x�b
	mov dh, backOfSnakey			;�]�w�D��y�b
	call Gotoxy						;���ر����Ш禡
	mov eax, green					;�]�w�D�����C��
	call SetTextColor
	mov al, ' '
	call WriteChar					;�L�X�D����
	mov ecx, StarNumber
	inc ecx							;�W�[�D��*��
Print:
	mov ebx, ecx
	mov esi, OFFSET StarOfx
	mov al, [esi+ebx-1]			
	mov dl, al						;����y�y��(row)
	mov esi, OFFSET StarOfy
	mov al, [esi+ebx-1]			
	mov dh, al						;����x�y��(column)
	call Gotoxy						;���ر����Ш禡
	mov edx, StarNumber				;�]�w*��
	inc edx
	cmp ecx, edx					;���*��
	jne CoinOut						;�Y���۵��h�L�X������
	mov al, front
	jmp Printt
CoinOut:
	mov al, star
Printt:
	call WriteChar
	Loop Print						;�j��print function
ret
CoinsOut ENDP

ScoreOfSnake PROC USES eax				
	mov eax, grade					;�D�Y������h���ƥ[�@
	add eax, 1					
	mov grade, eax				
	ret							
ScoreOfSnake ENDP					

SnakeRate PROC USES eax ebx edx
	mov edx, 0						;�D�Y��W�L�Q�ӿ����A�t�׼W��
	mov eax, grade
	mov ebx, 10	
	div ebx
	cmp edx, 1
	jne Fulfill
	mov ax, rate
	mov bx, 10
	sub ax, bx					
	mov rate, ax
	mov eax,grade			
	add eax,1
	mov grade,eax 
Fulfill:
	ret
SnakeRate ENDP
	exit

END main





