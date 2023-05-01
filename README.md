# Morse code transmitter and receiver

### Team members

* Marek IVAN 
* Petr KAPLAN 
* Miroslav TRCHALÍK 
* Vít Walach 

### Table of contents

* [Project objectives](#objectives)
* [Hardware description](#hardware)
* [VHDL modules description and simulations](#modules)
* [TOP module description and simulations](#top)
* [Video](#video)
* [References](#references)

<a name="objectives"></a>

## Project objectives

Náším cílem bylo sestrojit přijímač a vysílač morseovy abecedy. Při vypracovávání přijímače jsme použili tlačítko na generování morseova kódu.Nejtěžší částí bylo vytvořit část programu, který rozeznal, jestli se jedná o čárku, tečku nebo mezeru mezi znaky či slovy. Dále bylo nutné rozhodnout jak dlouhé bude slovo, které přijímáme. Toto slovo poté ukládáme do registru, který se resetuje s každým novým slovem. Nakonec je pomocí naší části "decoder" převeden morseův kód na abecedu a poté zobrazen na 7 segmentovém displeji. Při řešení přijímače byl podobný problém, bylo zapotřebí navzorkovat příchozí signál a dále rozhodnout, o které slovo se jedná a dále jej zobrazit pomocí LED diody nebo 7 segmentového displeje.

<a name="hardware"></a>

## Hardware description
Celý projekt je zabalen v hlavní bloku "top", kde jsou definovány všechny používané, jak vnější tak vnitřní signály. Náš první blok zvaný "inputM", slouží k získání dat z tlačítka BTNC, kde posíláme jedničky a nuly. Jedno stisknutí tlačítka by mělo odpovídat tečce, což je časový interval 1 sekundy. Delší stiknutí, čas delší jak 2 sekundy, je registrován jako čárka. Dále je také rozhodnuto, na základě stavů, jak dlouhé bude výsledné slovo. Následující blok "char_registr" slouží jako naše paměť, kde se na základě délce slova přizpůsobí jeho velikost a daná data se uloží.V poslední bloku nazvaném "decoder", dochází k porovnání dat z naší paměti. Na základě znaků a délce slova se přiřadí požadované písmenko, toto písmenko je poté vyvedeno na 7 segmentový displej, kde uvidíme výsledek našeho vysílaného slova po znacích.


<a name="modules"></a>

## VHDL modules description and simulations

Modul "inputM"

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
<a name="top"></a>

## TOP module description and simulations

Write your text here.

<a name="video"></a>

## Video

Write your text here

<a name="references"></a>

## References

1. Write your text here.
