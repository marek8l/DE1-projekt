library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity inputM_tb is
end inputM_tb;

architecture Behavioral of inputM_tb is

  component inputM
    Port (
      clk : in STD_LOGIC;
      BTNC : in STD_LOGIC;
      char : out STD_LOGIC;
      space : out STD_LOGIC;
      enable : out STD_LOGIC;
      lenght_out : out STD_LOGIC_VECTOR(1 downto 0)
    );
  end component;

 
  signal clk : STD_LOGIC := '0';
  signal BTNC : STD_LOGIC := '0';
  signal char : STD_LOGIC;
  signal space : STD_LOGIC;
  signal enable : STD_LOGIC;
  signal lenght_out : STD_LOGIC_VECTOR(1 downto 0);

begin

  
  uut : inputM port map (
    clk => clk,
    BTNC => BTNC,
    char => char,
    space => space,
    enable => enable,
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

  
  stimulus : process
  begin
    wait for 10 us;
    BTNC <= '1'; -- send a dash
    wait for 50 us;
    BTNC <= '0';
    wait for 20 us;
    BTNC <= '1'; -- send a dot
    wait for 60 us;
    BTNC <= '0';
    wait for 20 us;
    BTNC <= '1'; -- send a dot
    wait for 20 us;
    BTNC <= '0';
    wait for 20 us;


    wait;
  end process stimulus;

end Behavioral;