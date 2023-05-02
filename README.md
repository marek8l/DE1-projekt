# Morse code transmitter and receiver

### Team members

* Marek IVAN 
* Petr KAPLAN 
* Miroslav TRCHALÍK 
* Vít Walach 

### Table of contents

* [Theoretical description and explanation](#theoretical)
* [Hardware description of demo application](#hardware)
* [Software description](#software)
* [Component(s) simulation](#simulation)
* [Instructions](#instructions)
* [References](#references)

<a name="#theoretical"></a>

## Theoretical description and explanation

Naším cílem bylo sestrojit přijímač a vysílač Morseovy abecedy. Při vypracovávání přijímače jsme použili tlačítko na generování Morseova kódu. Nejtěžší částí bylo vytvořit část programu, který rozeznal, jestli se jedná o čárku, tečku nebo mezeru mezi znaky či slovy. Dále bylo nutné rozhodnout, jak dlouhé bude slovo, které přijímáme. Toto slovo poté ukládáme do registru, který se resetuje s každým novým slovem. Nakonec je pomocí části zvané "decoder" převeden Morseův kód na abecedu a poté zobrazen na 7 segmentovém displeji. Při řešení přijímače byl podobný problém, jediná změna bylo zrušení tlačítka BTNC, přivedení signálu DIN a poté rozhodnoutí, o které slovo se jedná a dále jej zobrazit pomocí 7 segmentového displeje.


<a name="hardware"></a>

## Hardware description of demo application
Vysílač: Celý projekt je zabalen v hlavní bloku "top", kde jsou definovány všechny používané, jak vnější, tak vnitřní signály. Náš první blok zvaný "inputM" slouží k získání dat z tlačítka BTNC, kde posíláme jedničky a nuly. Jedno stisknutí tlačítka by mělo odpovídat tečce, což je časový interval 1 sekundy. Delší stiknutí, čas delší jak 2 sekundy, je registrován jako čárka. Dále je také rozhodnuto na základě stavů, jak dlouhé bude výsledné slovo. Následující blok "char_registr" slouží jako naše paměť, kde se na základě délce slova přizpůsobí jeho velikost a daná data se uloží. V poslední bloku nazvaném "decoder", dochází k porovnání dat z naší paměti. Na základě znaků a délce slova se přiřadí požadované písmenko, toto písmenko je poté vyvedeno na 7 segmentový displej, kde uvidíme výsledek našeho vysílaného slova po znacích.

![alt text](https://github.com/marek8l/DE1-projekt/blob/main/de1.jpg)

Přijímač: Celý projekt je opět zabalen v hlavním bloku "top", tady opět definujeme všechny používané signály. Jediný rozdíl je v našem první bloku "receiver", zde příchází jedničky a nuly signálem DIN, modul poté rozezná, jestli se jedná o tečky nebo čárky a také zjišťuje délku posílaného slova. Tyto znaky následně pošle do bloku "char_registr", který slouží jako naše paměť(shift regiter), poté přejde do modulu "decoder", kde dojde k rozpoznání písmena na základě počtu jednotlivých znaků a délce slova. Tyto slova jsou následně vyvedena na 7 segmentový displej pro zobrazení.
![alt text](https://github.com/marek8l/DE1-projekt/blob/main/Receiver.jpg)

<a name="software"></a>

## Software description
Modul  "inputM"

https://github.com/marek8l/DE1-projekt/blob/main/vivado_soubory/transmitter/transmitter_morse/transmitter_morse.srcs/sources_1/new/inputM.vhd
![alt text](https://github.com/marek8l/DE1-projekt/blob/main/inputM%20diagram.jpg)
Modul "char_register"

https://github.com/marek8l/DE1-projekt/blob/main/vivado_soubory/transmitter/transmitter_morse/transmitter_morse.srcs/sources_1/new/char_register.vhd
![alt text](https://github.com/marek8l/DE1-projekt/blob/main/image.jpg)
Modul "decoder"

https://github.com/marek8l/DE1-projekt/blob/main/vivado_soubory/transmitter/transmitter_morse/transmitter_morse.srcs/sources_1/new/decoder.vhd
![alt text](https://github.com/marek8l/DE1-projekt/blob/main/diagram_decoder.jpg)
<a name="simulation"></a>

## Component(s) simulation

Modul "inputM":
Celý modul je ovládaný pomocí náběžné hrany, program rozhoduje na základě toho, jestli je tlačítko stisknuto nebo ne. Pokud stisknuto není, počítá se počet nul v proměnné zero_cnt, na základě této hodnoty se rozhoduje, jestli se jedná o mezeru mezi písmeny nebo mezi slovy. Také se resetuje počet jedniček v proměnné one_cnt. Proces počítání nul se spustí pouze, pokud je předtím stiknuto tlačítko BTNC, čímž se nastaví enable na 1 a program začne počítat nuly. Pokud je tlačítko stisknuto, dojde k nastavení enable na hodnotu high a začne počítání jedniček. Pokud se one_cnt rovná 1, program ví, že se jedná o tečku a proměnná char je nastavena na nulu, což reprezentuje právě tečku. Nastane-li situace, že one_cnt je větší než 2, program ví, že se jedná o čárku, ta je značená v proměnné char jako 1. U všech rozhodování, zda-li se jedná o tečku, čárku nebo mezeru se přičítá hodnota k proměnné length, ta určuje délku slova.   
```vhdl
inputM_process : process (clk) is

  begin

    if (rising_edge(clk)) then
      lenght_out <= lenght;
      
      if (BTNC = '0') then    
        if (btnc_value = 0) then 
            zero_cnt  <= zero_cnt + 1;
            one_cnt <= 0;
            btnc_value <= 0;
            btnc_change <= 0;
        elsif (btnc_value = 1) then
            zero_cnt  <= zero_cnt + 1;
            one_cnt <= 0;
            btnc_value <= 0;
            btnc_change <= 1;
        end if;
            
      elsif (BTNC = '1') then
        if (btnc_value = 0) then
            one_cnt <= one_cnt + 1;
            zero_cnt <= 0;
            btnc_value <= 1;
            btnc_change <= 1;
        elsif (btnc_value = 1) then
            one_cnt <= one_cnt + 1;
            zero_cnt <= 0;
            btnc_value <= 1;
            btnc_change <= 0;
        end if;
            
      end if;
      
      if (btnc_change = 1) then
          enable <= '1'; 
          if (one_cnt = 1) then         -- dot
            char <= '0';
            space <= '0';
	           if (lenght = "11") then
		          lenght <= "00";
	           else
		          lenght <= lenght + '1';
	           end if;
          elsif (one_cnt > 2) then      -- dash
            char <= '1';
            space <= '0';
            if (lenght = "11") then
                lenght <= "00";
            else
                lenght <= lenght + '1';
            end if;
          elsif (zero_cnt = 3) then     -- short gap (between letters)
            space <= '1';
	        lenght <="00";
          elsif (zero_cnt >= 7) then     -- medium gap (between words)
            space <= '1';
	        lenght <="00";
          end if;
              
      end if;
      
    end if; -- Rising edge
end process inputM_process;


end Behavioral;
```

Simulace "inputM"
![alt text](https://github.com/marek8l/DE1-projekt/blob/main/transmitter%20inputM%20simulace.PNG)

Modul "char_registr":
Tento modul funguje jako naše paměť, je to 4-vstupý shift registr. Proces začíná náběžnou hranou, kde se pomocí proměnné enable nastaví zapnutí funkce paměti. Poté se do proměnné temp ukládají jedničky a nuly reprezentující naše čárky a tečky. Ukládání probíhá z pravé strany registru. Proměnná temp se posouvá o temp(i+1) podle délky slova. Poté dojde k uložení dat do proměnné letter_in, kde je zapsán celý znak. Ten je poslán do dalšího modulu zvaný "decoder".
```vhdl
char_register_process : process (clk) is

  begin
      if (rising_edge(clk)) then
   
         if (enable = '1') then 
            for i in 0 to 2 loop
               temp(i) <= temp(i+1);
            end loop;
            temp(3) <= char;
         end if;
         
      letter_in <= temp;
      
      end if;
         
   end process char_register_process;

end Behavioral;
```
Simulace "char_registr"
![alt text](https://github.com/marek8l/DE1-projekt/blob/main/char_register%20simulace.PNG)

Modul "decoder":
V tomto bloku programu nám přichází data ze signálu letter_in. Na základě délky signálu je rozdělen do jednoho ze čtyř částí programu. Pokud má délku 1, je mu přidělena kombinace "01", poté přejde do další podmínky, kde zjistí, jestli třetí bit vstupu je 0, pokuď ano, jedná se o písemo E, jinak se jedná o písmeno F. Pokud 2 získá kombinaci "10", tak v tomto případě opět zjistí, co se nachází na pozici 3, dále co je na pozici 2 a následně rozhodne o které z písmen se jedná. Tento proces se opakuje, jak pro písmena délky 3 tak délky 4. Po určení písmena je písmenu přiřazena binární hodnota pro zobrazení na 7 segmentovém displeji. Tuto informaci vynášíme na 7 segmentový displej pomocí výstupního signálu letter_out.

```vhdl
d_process : process (clk) is

    begin
        if (rising_edge(clk)) then
	    case lenght_out is

		when "01" => --size 1
		    if letter_in(3)='0' then --E
			letter_out <= "0110000";
		    else 		     --F
			letter_out <= "0111000";
		    end if;

		when "10" => --size 2
		    if letter_in(3)='0' then 	 -- dot ???
			if letter_in(2)='0' then --I
			    letter_out <= "1101111";
			else 			 --A
			    letter_out <= "0001000";
			end if;
		    else 			 -- dash ???
			if letter_in(2)='0' then --N
			    letter_out <= "1101010";
			else 			 --M
			    letter_out <= "0101010";
			end if;
		    end if;

		when "11" => --size 3
		    if letter_in(3)='0' then 	     -- dot ??? ???
			if letter_in(2)='0' then     -- dot dot ???
			    if letter_in(1)='0' then --S
			    	letter_out <= "0100100";
			    else 		     --U
			    	letter_out <= "1000001";
			    end if;
		        else			     -- dot dash ???
			    if letter_in(1)='0' then --R
			        letter_out <= "1111010";
			    else 		     --W
			        letter_out <= "1010100";
			    end if;
		        end if;
		    else			     -- dash ??? ???
			if letter_in(2)='0' then     -- dash dot ???
			    if letter_in(1)='0' then --D
			    	letter_out <= "1000010";
			    else 		     --K
			    	letter_out <= "0101000";
			    end if;
		        else			     -- dash dash ???
			    if letter_in(1)='0' then --G
			        letter_out <= "0100001";
			    else 		     --O
			        letter_out <= "1100010";
			    end if;
		        end if;
		    end if;

		when "00" => --size 4
		    case letter_in is
			when "1000" => --B
			    letter_out <= "1100000";
			when "1010" => --C
			    letter_out <= "0110001";
			when "0010" => --F
			    letter_out <= "0111000";
			when "0000" => --H
			    letter_out <= "1101000";
			when "0111" => --J
			    letter_out <= "1000011";
			when "0100" => --L
			    letter_out <= "1110001";
			when "0110" => --P
			    letter_out <= "0011000";
			when "1101" => --Q
			    letter_out <= "0001100";
			when "0001" => --V
			    letter_out <= "1100011";
			when "1001" => --X
			    letter_out <= "1001000";
			when "1011" => --Y
			    letter_out <= "1000100";
			when "1100" => --Z
			    letter_out <= "0010010";
			when others =>
			    letter_out <= "0000000";
		    end case;
		    
	    when others =>
	    end case; 
        end if;
        
    end process d_process;
end architecture Behavioral;
```
Simulace "decoder"
![alt text](https://github.com/marek8l/DE1-projekt/blob/main/decoder%20simulace.PNG)

Modul "top":

Modul "top" je hlavní částí celého projektu, protože jsou pod ním sloučené a definované veškeré předchozí moduly. Jako vstup máme naše tlačítko BTNC, clock a jako výstup námi vybraný 7 segment a jeho jednotlivé segmenty.
```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
  Port ( clk: in std_logic;
           BTNC : in STD_LOGIC;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0)
  );
end top;

architecture Behavioral of top is

signal char : std_logic;
signal space : std_logic;
signal enable : std_logic;
signal letter : std_logic_vector(3 downto 0);
signal lenght_out : std_logic_vector(1 downto 0);

begin
 input : entity work.inputM
     port map (
        clk => clk,
        char  => char,
        enable => enable,
        BTNC => BTNC,
        space => space
    );

 registr : entity work.char_register
     port map (
         clk => clk,
 	 enable => enable, 
 	 char => char,
 	 letter_in => letter
    );
    
 decoder : entity work.decoder
     port map (
         clk => clk,
 	 letter_in => letter,
         letter_out(6) => CA,
         letter_out(5) => CB,
         letter_out(4)=> CC,
         letter_out(3) => CD,
         letter_out(2) => CE,
         letter_out(1) => CF,
         letter_out(0) => CG,
         lenght_out => lenght_out
    );
    
  --------------------------------------------------------
  -- Other settings
  --------------------------------------------------------
  -- Connect one common anode to 3.3V
  AN <= b"1111_1110";
```


end Behavioral;

<a name="instructions"></a>

## Instructions

Pro spuštění funkce vysílače je třeba stiksnout tlačítko BTNC, podle délky stisknutí uživatele dojde k rozpoznání čárky a tečky. Pro požadovaný symbol tečky je třeba tlačítko krátce stisknout. Naopak pro čárku je třeba tlačítko držet alespoň 3 sekundy. Pro ukončení písmena je třeba nemačkat tlačítko po dobu alespoň 3 sekund a pro ukončení slova více než 7 sekund. Požadovaná písmena se budou zobrazovat následně na vybraném 7 segmentovém displeji. Pro použití funkce přijímače stačí připojit zdroj dat generující písmena. Tato písemna budou následně zobrazena na 7 segmentovém displeji.
![alt text](https://github.com/marek8l/DE1-projekt/blob/main/deska.jpg)

<a name="references"></a>

## References

1. [Wikipedie](https://en.wikipedia.org/wiki/Morse_code)
2. [Prezentace od Umair Saleem](https://www.researchgate.net/publication/305379385_Morse_code_decoder_design_in_VHDL_using_FPGA_Spartan_3E_development_kit?fbclid=IwAR3KiPaBNj1K3j-CqQdmiTTzNKr2VtFiIulZia2HUxbM795J4pD5DOYw22Y)
3. [Stack overflaw](https://stackoverflow.com/search?q=vhdl&s=04bdfc46-5652-40c6-a734-ef150c6cb1e8)
