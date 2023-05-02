library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity receiver is
    port (
        CLK : in std_logic;
        DIN : in std_logic;
        DOUT : out std_logic_vector(1 downto 0);
	    lenght_out : out STD_LOGIC_vector(1 downto 0);
	    enable : out STD_LOGIC :='1'
    );
end receiver;

architecture Behavioral of receiver is
    signal count_zero : integer := 0; 
    signal count_one : integer := 0;  
    signal prev_bit : std_logic := '0'; 
    signal lenght : std_logic_vector(1 downto 0) := "00";
    signal tempA : std_logic := '0'; 
    signal tempB : std_logic := '0'; 
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
        	lenght_out <= lenght;
            -- update counter based on input bit
            if DIN = '0' then
                if prev_bit = '0' then
                    count_zero <= count_zero + 1;
                else
                    count_zero <= 1;
                    count_one <= 0;
                    prev_bit <= '0';
                end if;
            else
                if prev_bit = '1' then
                    count_one <= count_one + 1;
                else
                    count_one <= 1;
                    count_zero <= 0;
                    prev_bit <= '1';
                end if;
            end if;

            -- check conditions for DOUT
            
            
            if (count_one = 1) and (tempA = '0') then
                tempA <= '1';
                tempB <= '0';
                DOUT <= "00";
                if (lenght = "11") then
		          lenght <= "00";
	           else
		          lenght <= lenght + '1';
	           end if;
            elsif (count_one = 3)and (tempB = '0') then
                tempA <= '0';
                tempB <= '1';
                DOUT <= "01";
                if (lenght = "11") then
		          lenght <= "00";
	           else
		          lenght <= lenght + '1';
	           end if;
	        elsif count_zero = 1 then
	            tempA <= '0';
                tempB <= '0';
            elsif count_zero = 3 then
                tempA <= '0';
                tempB <= '0';
                DOUT <= "10";
                lenght <="00";
            elsif count_zero = 5 then
                tempA <= '0';
                tempB <= '0';
                DOUT <= "11";
                lenght <="00";
            end if;
        end if;
    end process;
    
    
end Behavioral;
