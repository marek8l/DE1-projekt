----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2023 17:22:19
-- Design Name: 
-- Module Name: decoder - Behavioral
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

entity decoder is
    Port (letter_in: in std_logic_vector(3 downto 0);
          letter_out: out std_logic_vector(6 downto 0);
          clk : in STD_LOGIC            
     );
end entity decoder;


architecture Behavioral of decoder is
begin
d_process : process (clk) is

    begin
        if (rising_edge(clk)) then
            case letter_in is
                when "01" => --A
                    letter_out <="0001000"; 

                when "1000" => --B
                    letter_out <="1100000";

                when "1010" => --C
                    letter_out <="0110001";

                when "100" => --D
                    letter_out <="1000010";                    

                when "0010" => --E
                    letter_out <="0110000";

                when "0010" => --F
                    letter_out <="0111000";                    

                when "110" => --G
                    letter_out <="0100001";

                when "1111" => --H
                    letter_out <="1101000";                    

                when "00" => --I
                    letter_out <="1101111";

                when "0111" => --J
                    letter_out <="1000011";                    

                when "101" => --K
                    letter_out <="0101000";

                when "0100" => --L
                    letter_out <="1110001";                    

                when "11" => --M
                    letter_out <="0101010";

                when "10" => --N
                    letter_out <="1101010";                    
                when "111" => --O
                    letter_out <="1100010";

                when "1101" => --Q
                    letter_out <="0001100";                    

                when "010" => --R
                    letter_out <="1111010";

                when "000" => --S
                    letter_out <="0100100";                    

                when "1" => --T
                    letter_out <="1110000";

                when "001" => --U
                    letter_out <="1000001"; 
                                        
                when "0001" => --V
                    letter_out <="1100011";

                when "011" => --W
                    letter_out <="1010100";                    

                when "1001" => --X
                    letter_out <="1001000";

                when "1011" => --Y
                    letter_out <="1000100";   
                                  
                when "1100" =>--Z
                    letter_out <= "0010010";
                    
                when others =>-- neurèitá stav
                    letter_out <= "0000000";
                
            end case;
        end if;
    end process d_process;
end architecture Behavioral;
