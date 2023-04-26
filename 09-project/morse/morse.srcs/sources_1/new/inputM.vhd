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
<<<<<<< HEAD
           char : out std_logic_vector(4 downto 0); 
           BTNC : in STD_LOGIC);
=======
           rst : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           char : out STD_LOGIC;
           btnc_change : out STD_LOGIC;
           space : out STD_LOGIC
          );
>>>>>>> 2873e3ba5a6c3e63578ffe779a7c2dba31bfd431
end inputM;

architecture Behavioral of inputM is

signal zero_cnt : natural;
signal one_cnt : natural;
<<<<<<< HEAD


begin

p_traffic_fsm : process (clk) is
=======
signal btnc_value : natural;

begin

inputM_process : process (clk) is
>>>>>>> 2873e3ba5a6c3e63578ffe779a7c2dba31bfd431

  begin
  
    if (rising_edge(clk)) then
<<<<<<< HEAD
      if (BTNC = '0') then                    -- Synchronous reset             -- Init state
        zero_cnt  <= zero_cnt + 1;
        one_cnt <= 0;
      elsif (BTNC = '1') then
        one_cnt <= zero_cnt + 1;
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
=======
        
      if (BTNC = '0') then    
        if (btnc_value = 0) then 
            zero_cnt  <= zero_cnt + 1;
            one_cnt <= 0;
            btnc_value <= 0;
            btnc_change <= '0';
        elsif (btnc_value = 1) then
            zero_cnt  <= zero_cnt + 1;
            one_cnt <= 0;
            btnc_value <= 0;
            btnc_change <= '1';
        end if;
            
      elsif (BTNC = '1') then
        if (btnc_value = 0) then
            one_cnt <= zero_cnt + 1;
            zero_cnt <= 0;
            btnc_value <= 1;
            btnc_change <= '1';
        elsif (btnc_value = 1) then
            one_cnt <= zero_cnt + 1;
            zero_cnt <= 0;
            btnc_value <= 1;
            btnc_change <= '0';
        end if;
            
      end if;
      
      if (btnc_change = '1') then
          if (one_cnt = 1) then         % dot
            char <= "0";
            space <= "0";
          elsif (one_cnt = 3) then      % dash
            char <= "1";
            space <= "0";
          elsif (zero_cnt = 3) then     % short gap (between letters)
            space <= "1";
          elsif (zero_cnt = 7) then     % medium gap (between words)
            space <= "1";
          end if;
              
      end if;
      
    end if; -- Rising edge
end process inputM_process;
>>>>>>> 2873e3ba5a6c3e63578ffe779a7c2dba31bfd431


end Behavioral;
