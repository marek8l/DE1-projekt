----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.03.2023 13:27:27
-- Design Name: 
-- Module Name: char_register - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity char_register is

   port(clk: in std_logic;
 	     enable: in std_logic; 
 	     char: in std_logic; -- new data to shift in
 	     word: out std_logic_vector(4 downto 0);
 	     Input: in std_logic_vector(4 downto 0));
   
   port map (
        clk => clk,
        char  => char,
        enable => btnc_change
    );

end char_register;

architecture Behavioral of char_register is

variable temp: std_logic_vector(4 downto 0);

begin

char_register_process : process (clk) is

  begin
      if (rising_edge(clk)) then
   
         if (enable = 0) then 
            for i in 0 to 3 loop
               temp(i) <= temp(i+1);
            end loop;
            temp(4) <= w;
         end if;
         
      word <= temp;
         
   end process char_register_process;

end Behavioral;
