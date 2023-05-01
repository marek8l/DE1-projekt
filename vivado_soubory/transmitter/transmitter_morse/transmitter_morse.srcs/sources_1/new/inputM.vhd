----------------------------------------------------------------------------------
-- Company: VUT
-- Engineer: Marek IVAN
-- 
-- Create Date: 12.04.2023 13:23:43
-- Design Name: inputM
-- Module Name: inputM - Behavioral
-- Project Name: moorse code transmitter

-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity inputM is
    Port ( clk : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           char : out STD_LOGIC;
           space : out STD_LOGIC;
           enable : out STD_LOGIC :='1';
	   lenght_out : out STD_LOGIC_vector(1 downto 0)
          );
end inputM;

architecture Behavioral of inputM is

signal zero_cnt : natural;
signal one_cnt : natural;
signal btnc_value : natural;
signal btnc_change : natural;
signal lenght : std_logic_vector(1 downto 0) := "00";

begin



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
      
    end if;
end process inputM_process;


end Behavioral;