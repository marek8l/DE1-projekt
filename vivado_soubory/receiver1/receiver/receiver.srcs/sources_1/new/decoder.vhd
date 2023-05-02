----------------------------------------------------------------------------------
-- Company: VUT
-- Engineer: Marek IVAN
-- 
-- Create Date: 26.04.2023 15:45:38
-- Design Name: top
-- Module Name: top - Behavioral
-- Project Name: moorse code transmitter

-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder is
    Port (letter_in: in std_logic_vector(3 downto 0);
          letter_out: out std_logic_vector(6 downto 0);
          clk : in STD_LOGIC;
	      lenght_out : in std_logic_vector(1 downto 0)          
     );
end entity decoder;


architecture Behavioral of decoder is
begin
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