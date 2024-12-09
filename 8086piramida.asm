Progr           segment
                assume  cs:Progr, ds:dane, ss:stosik

start:          mov     ax,dane          
                mov     ds,ax
                mov     ax,stosik        
                mov     ss,ax
                mov     sp,offset szczyt 

;///////////////////////////////////////////
;               Funkcja czyszczenia ekranu

		push	0b800h          
		pop	es		   ; Ustaw adres pamięci ekranu.
		mov	di,0               ; Wskaźnik na początek pamięci ekranu.
		mov     ax,0720h           ; Zapisz spację i wartość tła do rejestru AX.
		mov     cx,2000            ; Licznik dla instrukcji REP.
		rep     stosw              ; Wypełnij całą pamięć ekranu spacjami.

;               Rysowanie piramidy

                mov     al,'A'             ; Ustaw pierwszy znak ('A').
                mov     si,25              ; Liczba wierszy piramidy (wysokość).
petla:
		mov 	di,screen_offset   ; Wskaźnik na szczyt piramidy.
		mov	cx,counter         ; Liczba znaków do narysowania w bieżącym wierszu.
		rep 	stosw              ; Powtarzaj instrukcję zapisu znaków dla wiersza.
		add	screen_offset,9eh  ; Przesuń wskaźnik na następny wiersz piramidy.
		add 	counter,2          ; Zwiększ liczbę znaków dla następnego wiersza.
		inc	al                 ; Zwiększ wartość ASCII znaku.
		dec	si                 ; Zmniejsz liczbę pozostałych wierszy.
		jnz 	petla              ; Jeśli si > 0, kontynuuj.

;///////////////////////////////////////////
		mov	ah,0              
		int	16h                ; Czekaj na naciśnięcie klawisza.
                mov     ah,4ch           
                mov     al,0            
                int     21h                ; Zakończ program.
Progr           ends

dane            segment  
screen_offset	dw 80                      ; Zmienna przesunięcia pamięci ekranu.
counter		dw 1                       ;  Licznik znaków w wierszu piramidy.
dane            ends

stosik          segment
                dw    100h dup(0)          ; Zarezerwuj miejsce dla stosu.
szczyt          Label word                 ; Wskaźnik na szczyt stosu.
stosik          ends

end start
