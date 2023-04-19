----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.04.2023 14:24:39
-- Design Name: 
-- Module Name: beforestorage - Behavioral
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

entity beforestorage is
  Port ( 
           reset_s : out STD_LOGIC;
           char_c : out STD_LOGIC;
           char_b : in std_logic_vector(1 downto 0));
end beforestorage;

architecture Behavioral of beforestorage is

begin
    if (char_b = ("00" or "11"))then
        if (char_b = "00")then
            char_c <= "0";
        elseif (char_b = "11") then
            char_c <= "1";
        end if;
    elseif (char_b = "01")then
        reset_s <= "1";
    else 
        reset_s <= "0";       
    end if;      
    
end Behavioral;
