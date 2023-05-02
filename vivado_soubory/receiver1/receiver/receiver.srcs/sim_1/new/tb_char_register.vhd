library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_char_register is
end test_char_register;

architecture Behavioral of test_char_register is

  component char_register is
    port(
      clk : in  std_logic;
      enable : in  std_logic;
      char : in  std_logic;
      letter_in : out  std_logic_vector(3 downto 0)
    );
  end component;

  constant clk_period : time := 10 ns;

  signal clk : std_logic := '0';
  signal enable : std_logic := '1';
  signal char : std_logic := '0';
  signal letter_in : std_logic_vector(3 downto 0);

begin

  
  uut: char_register port map (
    clk => clk,
    enable => enable,
    char => char,
    letter_in => letter_in
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
    -- Enable
    enable <= '1';
    
    -- Shift 'A'
    char <= '1';
    wait for clk_period;
    assert letter_in = "0001" report "Test case 1 failed" severity error;
    
    -- Shift 'B'
    char <= '0';
    wait for clk_period;
    assert letter_in = "0011" report "Test case 2 failed" severity error;
    
    -- Shift 'C'
    char <= '1';
    wait for clk_period;
    assert letter_in = "0110" report "Test case 3 failed" severity error;
    
    
    -- Shift 'D'
    char <= '0';
    wait for clk_period;
    assert letter_in = "0110" report "Test case 4 failed" severity error;
    
    -- Shift 'E'
    char <= '1';
    wait for clk_period;
    assert letter_in = "0110" report "Test case 5 failed" severity error;

    wait;
  end process;

end Behavioral;
