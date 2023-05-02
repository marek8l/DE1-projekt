library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity decoder_tb is
end entity decoder_tb;

architecture Behavioral of decoder_tb is


  component decoder
    Port (letter_in: in std_logic_vector(3 downto 0);
          letter_out: out std_logic_vector(6 downto 0);
          clk : in STD_LOGIC;
	  lenght_out : in std_logic_vector(1 downto 0)
         );
  end component;


  signal letter_in : std_logic_vector(3 downto 0) := (others => '0');
  signal clk : std_logic := '0';
  signal lenght_out : std_logic_vector(1 downto 0) := "00";
  signal letter_out : std_logic_vector(6 downto 0);


  constant clk_period : time := 10 us;

begin

  
  uut: decoder port map (
    letter_in => letter_in,
    letter_out => letter_out,
    clk => clk,
    lenght_out => lenght_out
  );

  
  clk_process : process
  begin
    while now < 250 us loop
      clk <= '0';
      wait for 10 us;
      clk <= '1';
      wait for 10 us;
    end loop;
    wait;
  end process clk_process;

  
  stim_proc: process
  begin
    -- test for the letter 'E'
    letter_in <= "0100";  -- Dot-Dash-Dash-Dot
    lenght_out <= "01";
    wait for clk_period*10;
    assert (letter_out = "0110000") report "Letter E not correctly decoded" severity error;

    

    wait;
  end process stim_proc;

end architecture Behavioral;
