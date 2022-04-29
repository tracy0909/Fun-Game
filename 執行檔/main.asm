INCLUDE Irvine32.inc

.data

;首頁data
 ;fun world 排版字樣
  funWorld1 BYTE "                 *****    *     *     *      *        *       *       *  ******  *******  *       ***** *     ", 0   
  funWorld2 BYTE "                 *        *     *     * *    *         *     * *     *   *    *  *     *  *       *       *   ", 0
  funWorld3 BYTE "                 ***      *     *     *   *  *          *   *   *   *    *    *  *******  *       *       *   ", 0
  funWorld4 BYTE "                 *        *     *     *    * *           * *     * *     *    *  * *      *       *      *    ", 0
  funWorld5 BYTE "                 *        *******     *      *            *       *      ******  *    *   ******  ***** *     ", 0
  HomeWelcome BYTE "Welcome to the FUN World!", 0                    ;首頁一開始的歡迎字串
  introduce BYTE "Here are two games you can chose to play~", 0      ;遊戲介紹字串
  game1Sentence BYTE "   A.Guess Number", 0                              ;game1選項
  game2Sentence BYTE "    B.SnakeGame", 0                                ;game2選項
  chose BYTE "Please press A to enter GAME1, and press B to enter GAME2.",0   ;告訴使用者如何選擇訊息

;Game1 data宣告
  game1Welcome BYTE "Welcome to guess number!", 0                     ;game1一開始的歡迎字串
  sentence1 BYTE "You can enter the number between 1-100", 0          ;告知使用者可輸入數字範圍訊息
  getNumber BYTE "Please enter your guess number:", 0                 ;請使用者輸入數字訊息
  tryAgain BYTE "Try again!", 0                                       ;try again訊息
  pressKeyToReplay BYTE "You can press R to replay.", 0               ;按R可以回到首頁重新選擇訊息

  tooHigh BYTE "Your number is too large!", 0            ;數字太大訊息字串
  tooLow BYTE "Your number is too small!", 0             ;數字太小訊息字串
  rightSentence BYTE "You got it!!! ", 0                 ;成功訊息字串
  invalidInput BYTE "Your input is invalid!", 0          ;玩家input不合理字串

  currentMin BYTE "Current Min:", 0                      ;現在可猜數字範圍下限的訊息字串
  currentMax BYTE "Current Max:", 0                      ;現在可猜數字範圍上限的訊息字串

  randomNum BYTE ?              ;隨機亂數-數字答案
  userGuess BYTE ?              ;玩家猜的數字     

  minNumber BYTE 1              ;下限數值，初始化1
  maxNumber BYTE 100            ;上限數值，初始化100
 

;Game2 data 宣告
	game2Welcome BYTE "Welcome to the SNAKE GAME !", 0                     ;game2一開始的歡迎字串
	snakeWord1 BYTE "          ###### ",0
	snakeWord2 BYTE "         ##########             ##########           ##########             ##########           ##########", 0 ;蛇圖形狀  
	snakeWord3 BYTE "       #()######()#	######### ########## ########## ################### ########## ########## ##########", 0
	snakeWord4 BYTE "	###0##0###    ##########           ##########         ##########           ##########         ##########", 0
	snakeWord5 BYTE "	  ##$##", 0
	snakeWord6 BYTE "	   $ ", 0
	snakeWord7 BYTE "	  $ ", 0
	Word1		BYTE "                START THE SNAKE GAME               ",0    ;遊戲標題
	Word2		BYTE "Your Score is: ",0				   	      ;分數顯示
	Word3		BYTE "GAME OVER! Do you want to replay?_(R/N)",0				;結束遊戲
	Word4		BYTE "GOAL:",0									  ;遊戲提示
	Word5		BYTE "Eat $,",0  	
	Word6		BYTE "to get grade",0 
	Word7		BYTE "HINT:",0  					
	Word8		BYTE "Do not touch",0  					
	Word9		BYTE "the wall",0  					
	frontOfSnakex 		BYTE ?								;蛇的前段部分x
	frontOfSnakey 		BYTE ?								;蛇的前段部分y
	front 		BYTE 2					
	star 		BYTE "*"							
	coinOfx		BYTE ?										;錢幣x軸
	coinOfy		BYTE ?										;錢幣y軸
	eatCoin	BYTE 0											;吃錢幣		
	orient 	BYTE 0  							
	previousOrient 	BYTE 0								
	myWall1 	BYTE "---------------------------------------------------",0      ;周圍四邊牆
	myWall2 	BYTE "|						 	|",0
	coin		BYTE "$"									;錢幣	
	backOfSnakex		BYTE ?								;蛇的尾巴部分x
	backOfSnakey		byte ?								;蛇的尾巴部分y
	StarOfx		BYTE 735 DUP(0)	
	StarOfy		BYTE 735 DUP(0)	
	StarNumber	DWORD 0										;蛇擁有的*數
	grade		DWORD 0								
	rate		WORD 0

;其他data
   pressAnyKey BYTE "Please press any key to continue...", 0          ;按任意鍵繼續訊息


.code
main PROC

Home:
  ;遊戲歡迎介面

  ;排版
    call crlf                  ;換行
	call crlf                  ;換行
	call crlf                  ;換行

  ;印出fun world 字樣
	mov edx, offset funWorld1 
	call WriteString 
	call crlf                  ;換行
	mov edx, offset funWorld2 
	call WriteString 
    call crlf                  ;換行
	mov edx, offset funWorld3 
	call WriteString 
	call crlf                  ;換行
	mov edx, offset funWorld4 
	call WriteString 
	call crlf                  ;換行
	mov edx, offset funWorld5
	call WriteString 
    call crlf                  ;換行
   
   ;印出讓使用者按下任一鍵繼續訊息
    mov dh, 20               ;控制y座標(row)
    mov dl, 40               ;控制x座標(column)
    call Gotoxy              ;內建控制游標函式
	mov edx, offset pressAnyKey
    call WriteString  

  ;按任意鍵-直接讀一個字元，讀完後不做任何處理
    call ReadChar                       ;讀入字元(讓使用者按鍵盤)

	jmp clearToChosePage                ;讀完任意鍵後跳至選單頁面(先做清屏處理)
    
clearToChosePage:
    call clrscr                         ;清屏
	jmp ChosePage                

ChosePage:     
  ;選單頁面
    mov dh, 6                ;控制y座標(row)
    mov dl, 48               ;控制x座標(column)
    call Gotoxy              ;內建控制游標函式
    mov edx, offset HomeWelcome       ;印出歡迎字
    call WriteString   
    call crlf                ;換行

  ;介紹
    mov dh, 8                ;控制y座標(row)
    mov dl, 40               ;控制x座標(column)
    call Gotoxy              ;內建控制游標函式
    mov edx, offset introduce       ;印出介紹字
    call WriteString   
    call crlf                ;換行    

  ;印出遊戲選擇列
    mov dh, 12                          ;控制y座標(row)
    mov dl, 50                          ;控制x座標(column)
    call Gotoxy                         ;內建控制游標函式
    mov edx, offset game1Sentence       ;印出game1選項
    call WriteString   
    call crlf                           ;換行  
    mov dh, 14                          ;控制y座標(row)
    mov dl, 50                          ;控制x座標(column)
    call Gotoxy                         ;內建控制游標函式
    mov edx, offset game2Sentence       ;印出game2選項
    call WriteString   
    call crlf                           ;換行 

  ;印出請使用者選擇訊息
    mov dh, 25               ;控制y座標(row)
    mov dl, 33               ;控制x座標(column)
    call Gotoxy              ;內建控制游標函式
    mov edx, offset chose    ;印出告訴使用者如何選擇字串
    call WriteString    

  ;判斷使用者按下何者
  Read:
    call ReadChar                       ;讀入字元(讓使用者按鍵盤)
    cmp al, 'A'                         ;讀入值會在al裡,判斷讀入是否=A(***大小寫都算)
    je ClearToGame1                     ;是則跳至ClearToGame1準備進入game1      
    cmp al, 'a'                         ;判斷小寫a
    je ClearToGame1                     ;一樣是則跳至ClearToGame1準備進入game1  
    cmp al, 'B'                         ;判斷讀入是否=B(***大小寫都算)
    je ClearToGame2                     ;是則跳至ClearToGame1準備進入game1 
    cmp al, 'b'                         ;判斷小寫b
    je ClearToGame2                     ;一樣是則跳至ClearToGame1準備進入game1 
    jmp Read                            ;不是則繼續讀

  ClearToGame1:
   call clrscr                ;清屏
   jmp Game1                  ;跳到Game1頭進入遊戲1 
   
  ClearToGame2:
   call clrscr                ;清屏
   jmp Game2                  ;跳到Game2頭進入遊戲2     


Game1:
  ;印出歡迎字樣
    mov dh, 6                ;控制y座標(row)
    mov dl, 45               ;控制x座標(column)
    call Gotoxy              ;內建控制游標函式
    mov edx, offset game1Welcome
    call WriteString   
    call crlf                ;換行

  ;印出提示使用者按任意鍵字樣
    mov dh, 15               ;控制y座標(row)
    mov dl, 40               ;控制x座標(column)
    call Gotoxy              ;內建控制游標函式
    mov edx, offset pressAnyKey
    call WriteString   

  ;按任意鍵-直接讀一個字元，讀完後不做任何處理
    call ReadChar                       ;讀入字元(讓使用者按鍵盤)

  ;ClearScreenToStartGame
    call clrscr   
    jmp StartGame
  
  StartGame:

    Generate:       ;產生隨機亂數
   
      call Randomize        ;呼叫asm內建亂數函式,產生新的一組亂數(每次都會不同)
      mov eax, 99           ;將eax裡存99，準備呼叫randomrange函式
      call RandomRange      ;會產生0-99範圍的亂數
      inc eax               ;將eax+1使亂數範圍落在1-100
      mov randomNum, al     ;將取得的隨機亂數存進變數裡

	;告知使用者可輸入數字範圍
      mov dh, 10                   ;控制y座標(row)
      mov dl, 40                   ;控制x座標(column)
      call Gotoxy                  ;內建控制游標函式
      mov edx, offset sentence1    ;準備印出說明數字範圍字串
      call WriteString
      call crlf                    ;換行
 

    L1:               ;玩家輸入

	;印出現在可猜數字範圍字串
	 ;下限-印在畫面左邊
      mov dh, 8                   ;控制y座標(row)
      mov dl, 10                  ;控制x座標(column)
      call Gotoxy                 ;內建控制游標函式	  
      mov edx, offset currentMin  ;印出可猜數字下限字串
	  call WriteString

	  mov al, minNumber           ;把minNumber搬進al暫存器內準備印出
	  call WriteDec


	;上限-印在畫面右邊
      mov dh, 8                   ;控制y座標(row)
      mov dl, 95                  ;控制x座標(column)
      call Gotoxy                 ;內建控制游標函式	  
      mov edx, offset currentMax  ;印出可猜數字上限字串	
	  call WriteString

	  mov al, maxNumber           ;把maxNumber搬進al暫存器內準備印出
	  call WriteDec

	  

    ;請使用者輸入數字
      mov dh, 13                  ;控制y座標(row)
      mov dl, 43                  ;控制x座標(column)
      call Gotoxy                 ;內建控制游標函式
      mov edx, offset getNumber   ;印出請使用者輸入的字串
      call WriteString
      call readDec                ;讀入玩家猜的數字(unsigned integer)
      mov userGuess, al           ;存入變數
      jne ClearScreenToNext       ;讀完數值後跳至ClearScreenToNext清屏切換畫面



    ClearScreenToNext:
      call clrscr
      jmp Compare                 ;跳至compare執行數字判斷


    TooBig:                   ;更改該數值為下一次的上限值並印出數字過大提示
	 ;更改現在的上限值
	  mov al, userGuess           ;先把使用者猜的數值存入暫存器
	  mov maxNumber, al           ;再把該值搬進maxNumber變數裡	  

	 ;印出數字過大提示
      mov dh, 15                  ;控制y座標(row)
      mov dl, 45                  ;控制x座標(column)
      call Gotoxy                 ;內建控制游標函式
      mov edx, offset tooHigh     ;準備印出數值過大字串
      call WriteString 
      call crlf                   ;換行
      call DisplayTryAgain        ;呼叫函式印出字串請玩家重新輸入
      jmp L1                      ;重新一輪輸入

    TooSmall:                ;更改該數值為下一次的下限值並印出數字過小提示
	 ;更改現在的下限值
	  mov al, userGuess           ;先把使用者猜的數值存入暫存器
	  mov minNumber, al           ;再把該值搬進minNumber變數裡
     
	 ;印出數字過小提示
      mov dh, 15                  ;控制y座標(row)
      mov dl, 45                  ;控制x座標(column)
      call Gotoxy                 ;內建控制游標函式
      mov edx, offset tooLow      ;準備印出數值過小字串
      call WriteString 
      call crlf                   ;換行
      call DisplayTryAgain        ;呼叫函式印出字串請玩家重新輸入
      jmp L1                      ;重新一輪輸入

	InvalidGuess:           ;印出輸入不合理提示
      mov dh, 15                  ;控制y座標(row)
      mov dl, 48                  ;控制x座標(column)
      call Gotoxy                 ;內建控制游標函式
      mov edx, offset invalidInput     
      call WriteString 
      call crlf                   ;換行
      call DisplayTryAgain        ;呼叫函式印出字串請玩家重新輸入
      jmp L1                      ;重新一輪輸入	  

    Bingo:                   ;印出成功字樣
      mov dh, 10                  ;控制y座標(row)
      mov dl, 48                  ;控制x座標(column)
      call Gotoxy                 ;內建控制游標函式
      mov edx, offset rightSentence
      call WriteString
      jmp TheEnd
	  

  
    Compare:           ;判斷玩家猜的數字是否正確(使用cmp)

      mov bl, userGuess         ;把玩家猜測數字存進bl暫存器內
	  cmp bl, 1                 ;把玩家猜測數字和1做比較
	  jb InvalidGuess           ;小於則跳至不合理輸入做處理
	  cmp bl, 100               ;把玩家猜測數字和100做比較
	  ja InvalidGuess           ;大於則跳至不合理輸入做處理

      cmp bl,randomNum          ;接著比較玩家猜的數字與先前產生的答案數字
      ja TooBig                 ;玩家猜的數字>答案
      jb TooSmall               ;玩家猜的數字<答案
      je Bingo                  ;玩家猜的數字=答案 

	  jmp InvalidGuess          ;上述都不符合則也是不合理輸入-跳至該處做處理
    
    TheEnd:
      mov dh, 20                  ;控制y座標(row)
      mov dl, 42                  ;控制x座標(column)
      call Gotoxy                 ;內建控制游標函式
      mov edx, offset pressKeyToReplay
      call WriteString
      ReadR:
        call ReadChar                       ;讀入字元(讓使用者按鍵盤)
        cmp al, 'R'                         ;讀入值會在al裡,判斷是否=R(***大小寫都算)
        je ClearToReplay                    ;等於就跳至ClearToReplay準備重新開始
        cmp al, 'r'                         ;比較小寫r
        je ClearToReplay                    ;一樣等於就跳至ClearToReplay準備重新開始
        jmp ReadR                           ;都不相等就繼續讀


     ClearToReplay:
      call clrscr                ;清屏
      jmp Game1                  ;回到Game1頭

    DisplayTryAgain PROC    ;印出請玩家重新輸入的函式
      mov dh, 16                  ;控制y座標(row)
      mov dl, 52                  ;控制x座標(column)
      call Gotoxy                 ;內建控制游標函式
      mov edx, offset tryAgain
      call WriteString
      call crlf                    ;換行
      ret
    DisplayTryAgain ENDP 

Game2:
;印出歡迎字樣及蛇圖案
    call crlf						;換行
    call crlf						;換行
    mov dh, 4						;控制y座標(row)
    mov dl, 45						;控制x座標(column)
    call Gotoxy						;內建控制游標函式
	mov eax, lightgray+(magenta*16)	;設定標題文字
	call SetTextColor				;標題文字顏色
    mov edx, offset game2Welcome
    call WriteString   
    call crlf						;換行
    call crlf						;換行
	call crlf						;換行
	call crlf						;換行
  	mov eax, green		;設定標題文字
	call SetTextColor				;標題文字顏色
	mov edx, offset snakeWord1 
	call WriteString 
	call crlf                  ;換行
	mov edx, offset snakeWord2 
	call WriteString 
    call crlf                  ;換行
	mov edx, offset snakeWord3 
	call WriteString 
	call crlf                  ;換行
	mov edx, offset snakeWord4 
	call WriteString 
	call crlf                  ;換行
	mov edx, offset snakeWord5
	call WriteString 
    call crlf                  ;換行
   	mov eax, red		;設定標題文字
	call SetTextColor				;標題文字顏色
	mov edx, offset snakeWord6
	call WriteString 
    call crlf                  ;換行
	mov edx, offset snakeWord7
	call WriteString 
    call crlf                  ;換行
   	mov eax, lightgray		;設定標題文字
	call SetTextColor				;標題文字顏色
  ;印出提示使用者按任意鍵字樣
    mov dh, 20               ;控制y座標(row)
    mov dl, 40               ;控制x座標(column)
    call Gotoxy              ;內建控制游標函式
    mov edx, offset pressAnyKey
    call WriteString   

  ;按任意鍵-直接讀一個字元，讀完後不做任何處理
    call ReadChar                       ;讀入字元(讓使用者按鍵盤)

  ;ClearScreenToStartGame
    call clrscr   
    jmp startSnakeGame
startSnakeGame::
	pushad							;按順序push到暫存器
	call Clrscr						;清屏
	mov ax,88
	mov rate,ax					;設定速度
	mov eax,0
	mov grade,eax					;設定分數
	mov eax,0
	mov StarNumber,eax				;設定蛇身上的*
	mov al,0
	mov eatCoin,al				;設定蛇吃多少個$
	popad							;相反順序pop出暫存器
	mov dl, 14						;控制y座標(row)
	mov dh, 2						;控制x座標(column)
	call Gotoxy						;內建控制游標函式
	mov eax, black+(yellow*16)		;設定標題文字
	call SetTextColor				;標題文字顏色
	mov edx, OFFSET Word1			
	call WriteString				;印出標題
	mov dl, 0						;控制y座標(row)
	mov dh, 8						;控制x座標(column)
	call Gotoxy						;內建控制游標函式
	mov eax, cyan					
	call SetTextColor				;設定String4顏色
	mov edx, OFFSET Word4		
	call WriteString				;印出String4，旁邊提示字
	mov dl, 0						;控制y座標(row)
	mov dh, 9						;控制x座標(column)
	call Gotoxy						;內建控制游標函式
	mov eax, cyan					
	call SetTextColor				;設定String5顏色
	mov edx, OFFSET Word5			
	call WriteString				;印出String5，旁邊提示字
	mov dl, 0						;控制y座標(row)
	mov dh, 10						;控制x座標(column)
	call Gotoxy						;內建控制游標函式
	mov eax, cyan					
	call SetTextColor				;設定String6顏色
	mov edx, OFFSET Word6	
	call WriteString				;印出String6，旁邊提示字
	mov dl, 0						;控制y座標(row)
	mov dh, 12						;控制x座標(column)
	call Gotoxy						;內建控制游標函式
	mov eax, cyan					
	call SetTextColor				;設定String7顏色
	mov edx, OFFSET Word7	
	call WriteString				;印出String7，旁邊提示字
	mov dl, 0						;控制y座標(row)
	mov dh, 13						;控制x座標(column)
	call Gotoxy						;內建控制游標函式
	mov eax, cyan					
	call SetTextColor				;設定String8顏色
	mov edx, OFFSET Word8	
	call WriteString				;印出String8，旁邊提示字
	mov dl, 0						;控制y座標(row)
	mov dh, 14						;控制x座標(column)
	call Gotoxy						;內建控制游標函式
	mov eax, cyan					
	call SetTextColor				;設定String9顏色
	mov edx, OFFSET Word9	
	call WriteString				;印出String9，旁邊提示字
	mov dl, 14						;控制y座標(row)
	mov dh, 4						;控制x座標(column)
	call Gotoxy						;內建控制游標函式
	mov edx, OFFSET myWall1			
	mov eax, white+(blue*16)		;設定bricks1顏色
	call SetTextColor	
	call WriteString				;印出bricks1
	mov ah, 20
Brick:								;印出牆壁
	mov dl, 14						;控制y座標(row)
	mov dh, ah						;控制x座標(column)
	call Gotoxy						;內建控制游標函式
	dec ah
	mov edx, OFFSET myWall2	
	call WriteString				;印出bricks2
	cmp ah, 4						;比較x座標
	jg Brick							;大於則跳
	mov dl, 14						;控制y座標(row)
	mov dh, 21						;控制x座標(column)
	call Gotoxy						;內建控制游標函式
	mov edx, OFFSET myWall1			
	call WriteString				;印出牆壁
NumberOfX:
	mov eax,36
	mov frontOfSnakex, al			;邊界範圍
	mov esi, OFFSET StarOfx		
	mov [esi], al					;座標陣列
	mov dl, al					
NumberOfY:
	mov eax,12
	mov frontOfSnakey, al			;邊界範圍
	mov esi, OFFSET StarOfy
	mov [esi], al					;座標陣列
	mov dh, al						;控制x座標(column)
	call Gotoxy						;內建控制游標函式
	mov eax, white					;設定蛇的顏色
	call SetTextColor				;印出蛇的顏色
	mov al, front			
	call WriteChar					;印出蛇
SameOrient:
	mov ah, orient					
	call MoveSnake						;呼叫移動function
	call Current					;呼叫蛇尾function
	call CoinsOut					;呼叫蛇*
	jmp GameBegin
GameBegin:
	call ReadKey					;讀取鍵盤，按任一鍵
	jz SameOrient				;若沒按任何鍵，則相同方向
	cmp ah, 51H						;比較x軸座標
	jg GameBegin						;大於則跳回這個function
	cmp ah, 47H						;比較x軸座標
	jl GameBegin						;小於則跳回這個function，並移動
	call MoveSnake						;呼叫移動function
	call Current					;呼叫蛇尾function
	call CoinsOut					;呼叫蛇*
	jmp GameBegin

main ENDP
MoveSnake PROC USES eax edx
	mov orient, ah			
	call SnakeRate					;計算遊戲速度
	mov ax, rate
	movzx eax, ax					;呼叫delay function
	call Delay					
	mov dl, 0						;控制y座標(row)
	mov dh, 9						;控制x座標(column)
	call Gotoxy						;內建控制游標函式
	mov ax, rate
	movzx eax, ax
	mov dl, frontOfSnakex			;控制蛇前端y座標(row)
	mov dh, frontOfSnakey			;控制蛇前端x座標(column)
	call Gotoxy						;內建控制游標函式
	mov al, ' '
	call WriteChar		
	call CoinEat					;呼叫吃硬幣
	mov ah, orient					;設定方向於ah	
	mov al, previousOrient			;設定先前方向於al
	cmp dl, 64						;比較蛇頭的位置
	jge GameIsOver					;大於則遊戲結束
	cmp dl, 14						;比較蛇頭的位置
	jle GameIsOver					;小於則遊戲結束
	cmp dh, 21						;比較蛇頭的位置
	jge GameIsOver					;大於則遊戲結束
	cmp dh, 4						;比較蛇頭的位置
	jle GameIsOver					;小於則遊戲結束
	cmp ah, 48H						;等於這個數值，則跳轉向上的function
	je Top
	cmp ah, 50H						;等於這個數值，則跳轉向下的function
	je Below
	cmp ah, 4DH						;等於這個數值，則跳轉向右邊的function
	je OverRight
	cmp ah, 4BH						;等於這個數值，則跳轉向左邊的function
	je OverLeft
	jmp Fulfill
Top:	
	mov previousOrient, 48H			;向上的function
	cmp al, 50H
	je Below							;等於則跳轉到向下
	dec dh							;遞減x軸
	jmp HeadLocationOfUpdate				
Below:
	mov previousOrient, 50H			;向下的function
	cmp al, 48H						
	je Top							;等於則跳轉到向下
	inc dh							;遞減x軸
	jmp HeadLocationOfUpdate
OverRight:
	mov previousOrient, 4DH			;向右邊的function
	cmp al, 4BH
	je OverLeft							;等於則跳轉到向左邊
	inc dl							;遞增y軸
	jmp HeadLocationOfUpdate
OverLeft:
	mov previousOrient, 4BH			;向左邊的function
	cmp al, 4DH
	je OverRight						;等於則跳轉到向右邊
	dec dl							;遞減y軸
	jmp HeadLocationOfUpdate
HeadLocationOfUpdate:
	mov frontOfSnakex, dl			;更新蛇所在的位置
	mov frontOfSnakey, dh			;將位置處存在先前位置處
	call Gotoxy			
	mov al, front
	call WriteChar					;印出所在位置
Fulfill:
	ret
GameIsOver:
	mov dl, frontOfSnakex			;撞到牆壁則遊戲結束
	mov dh, frontOfSnakey
	call Gotoxy					
	mov al, front
	call WriteChar					;印出所在位置
	mov eax, 1000
	call Delay						;呼叫delay延遲後再跳出遊戲結束
	mov dl, 20						;控制y座標(row)
	mov dh, 3						;控制x座標(column)
	call Gotoxy						;內建控制游標函式
	mov eax, red+(lightgray*16)					
	call SetTextColor				;設定game over顏色
	mov edx, OFFSET Word3		
	call WriteString				;印出遊戲結束字樣
	mov dl, 20
	mov dh, 24
	mov eax, white+(black*16)		;恢復成原本字樣顏色	
	call SetTextColor
	pushad
	call readchar
	cmp al,'r'						;從鍵盤讀取是否為r，是則重新遊戲
	popad
	je startSnakeGame				;相等於r，則跳至一開始
	call Gotoxy

	exit
MoveSnake ENDP
CoinEat PROC USES eax edx
NewCoin:
	mov al, eatCoin					;吃到硬幣
	cmp al, 0
	jne NotEaten					;不等於則跳到未吃function
NumberOfX:
	mov eatCoin, 1						
	mov eax, 64
	call RandomRange				;新的硬幣呼叫隨機範圍function，出現隨機處
	cmp al, 15
	jl NumberOfX					;小於則跳到隨機x軸
	mov coinOfx, al					;設定錢幣y軸
	mov dl, al					
NumberOfY:
	mov eax, 18
	call RandomRange				;新的硬幣呼叫隨機範圍function，出現隨機處
	cmp al, 5
	jl NumberOfY					;小於則跳到隨機y軸
	mov coinOfy, al					;設定錢幣y軸
	mov dh, al
	call Gotoxy
	mov eax, white					;設錢幣顏色
	call SetTextColor
	mov al, coin
	call WriteChar					;印出新錢幣位置
	mov al, dl
NotEaten:
	mov al, frontOfSnakex			;設定蛇先前x軸位置
	mov ah, frontOfSnakey			;設定蛇先前y軸位置
	mov dl, coinOfx					;設定錢幣x軸位置
	mov dh, coinOfy					;設定錢幣y軸位置
	cmp ax, dx					
	jne Fulfill						;不相等則跳到完成function
	mov eax, StarNumber				;設定蛇身上*數字
	inc eax
	mov StarNumber, eax				;更新蛇*數字
	mov eatCoin, 0					;吃到0錢幣
	call AddCoins					;呼叫加*函式
	call ScoreOfSnake				;呼叫更新遊戲計分
	mov dl, 30						;控制y座標(row)
	mov dh, 23						;控制x座標(column)
	call Gotoxy						;內建控制游標函式
	mov eax, white					;設定計分顏色
	call SetTextColor
	mov edx, OFFSET Word2		
	call WriteString				;印出計分字母標示
	mov eax, grade	
	call WriteInt					;印出幾分數字
	jmp Fulfill
Fulfill:
	ret
CoinEat ENDP
AddCoins PROC USES eax ebx ecx esi
	mov ebx, StarNumber				;增加身上*數
	cmp ebx, 1						;比較若大於等於則繼續
	jge Continue					
	mov esi, OFFSET StarOfx
	mov al, frontOfSnakex			;設定蛇先前x軸位置
	mov [esi], al					;增加蛇身上*數(透過先前位置來增加)
	mov al, [esi]
	mov esi, OFFSET StarOfy
	mov al, frontOfSnakey			;設定蛇先前y軸位置
	mov [esi], al					;增加蛇身上*數(透過先前位置來增加)
	mov al, [esi]
	jmp Fulfill
Continue:						
	mov al, eatCoin			
	movzx eax, al					
	cmp al, 0						;比較為0，則不為沒吃到，亦即有吃到錢幣
	jne NotEaten					;不等於則跳轉至沒吃到function
Eaten:
	mov ecx, StarNumber				;設定*至ecx暫存器
	inc ecx							;增加*數
NotEaten:
	call Current					;沒吃到錢幣則呼叫蛇目前身體
	call CoinsOut					;呼叫印出蛇長度
ShiftToRight:
	mov ebx, ecx					;將原始的*位置向右移動，使新加入的*能夠直接補入
	mov esi, OFFSET StarOfx			;將x軸位置傳給esi
	mov al, [esi+ebx-1]				;將新的*加入到舊*群裡
	mov [esi+ebx], al
	mov esi, OFFSET StarOfy			;將y軸位置傳給esi
	mov al, [esi+ebx-1]				;將新的*加入到舊*群裡
	mov [esi+ebx], al			
	Loop ShiftToRight					;重複循環向右移動的function
	mov esi, OFFSET StarOfx			;將x軸位置傳給esi
	mov al, coinOfx
	mov [esi], al				
	mov esi, OFFSET StarOfy			;將y軸位置傳給esi
	mov al, coinOfy
	mov [esi], al	
Fulfill:							
	ret
AddCoins ENDP
Current PROC USES eax ebx ecx esi
	mov esi, OFFSET StarOfx		
	mov al, [esi]
	mov backOfSnakex, al			;處存目前蛇尾巴x軸
	mov esi, OFFSET StarOfy
	mov al, [esi]					
	mov backOfSnakey, al			;處存目前蛇尾巴y軸
	mov ebx, 1
	mov ecx, StarNumber
	inc ecx
ShiftToLeft:
	mov esi, OFFSET StarOfx			;更新蛇的*位置，以保持蛇能夠不段移動位置，而*位置正確
	mov al, [esi+ebx]				;將x軸位置傳給esi
	mov [esi+ebx-1], al				;將新的*加入到舊*群裡
	mov esi, OFFSET StarOfy			;將y軸位置傳給esi
	mov al, [esi+ebx]			
	mov [esi+ebx-1], al				;將新的*加入到舊*群裡
	mov al, [esi]				
	inc ebx
	Loop ShiftToLeft					;重複循環向左移動的function
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
	mov dl, backOfSnakex			;設定蛇尾x軸
	mov dh, backOfSnakey			;設定蛇尾y軸
	call Gotoxy						;內建控制游標函式
	mov eax, green					;設定蛇尾巴顏色
	call SetTextColor
	mov al, ' '
	call WriteChar					;印出蛇尾巴
	mov ecx, StarNumber
	inc ecx							;增加蛇尾*數
Print:
	mov ebx, ecx
	mov esi, OFFSET StarOfx
	mov al, [esi+ebx-1]			
	mov dl, al						;控制y座標(row)
	mov esi, OFFSET StarOfy
	mov al, [esi+ebx-1]			
	mov dh, al						;控制x座標(column)
	call Gotoxy						;內建控制游標函式
	mov edx, StarNumber				;設定*數
	inc edx
	cmp ecx, edx					;比較*數
	jne CoinOut						;若不相等則印出錢幣來
	mov al, front
	jmp Printt
CoinOut:
	mov al, star
Printt:
	call WriteChar
	Loop Print						;迴圈print function
ret
CoinsOut ENDP

ScoreOfSnake PROC USES eax				
	mov eax, grade					;蛇吃到錢幣則分數加一
	add eax, 1					
	mov grade, eax				
	ret							
ScoreOfSnake ENDP					

SnakeRate PROC USES eax ebx edx
	mov edx, 0						;蛇吃到超過十個錢幣，速度增快
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





