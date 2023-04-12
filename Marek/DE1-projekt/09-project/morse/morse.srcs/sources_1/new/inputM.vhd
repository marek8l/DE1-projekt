----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2023 01:23:43 PM
-- Design Name: 
-- Module Name: inputM - Behavioral
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

entity inputM is
    Port ( clk : in STD_LOGIC;
           char : out std_logic_vector(4 downto 0); 
           BTNC : in STD_LOGIC);
end inputM;

architecture Behavioral of inputM is

signal zero_cnt : natural;
signal one_cnt : natural;


begin

p_traffic_fsm : process (clk) is

  begin
  
    if (rising_edge(clk)) then
      if (BTNC = '0') then                    -- Synchronous reset             -- Init state
        zero_cnt  <= zero_cnt + 1;
        one_cnt <= 0;
      elsif (BTNC = '1') then
        one_cnt <= one_cnt + 1;
        zero_cnt <= 0;
      end if;
      
      if (one_cnt = 1) then
        char <= "00001";
      elsif (one_cnt = 3) then
        char <= "00111";
      elsif (zero_cnt = 1) then
        char <= "11110";
      elsif (zero_cnt = 3) then
        char <= "11000";
      elsif (zero_cnt = 5) then
        char <= "00000";
      end if;
      
    end if; -- Rising edge
end process p_traffic_fsm;


end Behavioral;
