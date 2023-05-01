----------------------------------------------------------------------------------
-- Company: VUT
-- Engineer: Marek IVAN
-- 
-- Create Date: 12.04.2023 14:14:22
-- Design Name: char_register
-- Module Name: char_register - Behavioral
-- Project Name: moorse code transmitter

-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity char_register is

   port(clk: in std_logic;
 	     enable: in std_logic; 
 	     char: in std_logic; 
 	     letter_in : out std_logic_vector(3 downto 0)
 	     );

end char_register;

architecture Behavioral of char_register is

signal temp: std_logic_vector(3 downto 0);


begin

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