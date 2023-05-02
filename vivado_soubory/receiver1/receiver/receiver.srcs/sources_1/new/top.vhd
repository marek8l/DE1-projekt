----------------------------------------------------------------------------------
-- Company: VUT
-- Engineer: Marek IVAN
-- 
-- Create Date: 26.04.2023 16:33:22
-- Design Name: top
-- Module Name: top - Behavioral
-- Project Name: moorse code transmitter

-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top is
  Port ( 
         CLK : in std_logic;
         DIN : in STD_LOGIC;
         CA : out STD_LOGIC;
         CB : out STD_LOGIC;
         CC : out STD_LOGIC;
         CD : out STD_LOGIC;
         CE : out STD_LOGIC;
         CF : out STD_LOGIC;
         CG : out STD_LOGIC;
         AN : out STD_LOGIC_VECTOR (7 downto 0)
  );
end top;

architecture Behavioral of top is

signal char : std_logic;
signal space : std_logic;
signal enable : std_logic;
signal letter : std_logic_vector(3 downto 0);
signal lenght_out : std_logic_vector(1 downto 0);
signal DOUT : std_logic_vector(1 downto 0);


begin
 receiver : entity work.receiver
     port map (
        CLK => CLK,
        DIN  => DIN,
        DOUT => DOUT,
        lenght_out => lenght_out

    );

 registr : entity work.char_register
     port map (
         clk => clk,
 	 enable => enable, 
 	 DOUT => DOUT,
 	 letter_in => letter
    );
    
 decoder : entity work.decoder
     port map (
         clk => clk,
 	 letter_in => letter,
         letter_out(6) => CA,
         letter_out(5) => CB,
         letter_out(4)=> CC,
         letter_out(3) => CD,
         letter_out(2) => CE,
         letter_out(1) => CF,
         letter_out(0) => CG,
         lenght_out => lenght_out
    );

  -- Connect one common anode to 3.3V
  AN <= b"1111_1110";

end Behavioral;