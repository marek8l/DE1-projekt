library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_tb is
end top_tb;

architecture Behavioral of top_tb is

  signal clk : std_logic := '0';
  signal BTNC : std_logic := '0';
  signal CA, CB, CC, CD, CE, CF, CG : std_logic;
  signal AN : std_logic_vector(7 downto 0);
  
  constant clk_period : time := 10 ns;  
  
begin

  uut : entity work.top
    port map (
      clk => clk,
      BTNC => BTNC,
      CA => CA,
      CB => CB,
      CC => CC,
      CD => CD,
      CE => CE,
      CF => CF,
      CG => CG,
      AN => AN
    );

  
  clk_gen : process
  begin
    while now < 5000 ns loop
      clk <= not clk;
      wait for clk_period/2;
    end loop;
    wait;
  end process;

  -- Test1 -  "SOS" 
  process
  begin
    BTNC <= '0';
    wait for 50 ns;
    assert (CA = '0' and CB = '1' and CC = '1' and CD = '1' and CE = '0' and CF = '1' and CG = '1')
      report "Testcase 1 failed" severity error;
    wait;
  end process;

  -- Test2 - "ALICE" 
  process
  begin
    BTNC <= '0';
    wait for 200 ns;
    assert (CA = '1' and CB = '1' and CC = '1' and CD = '0' and CE = '1' and CF = '0' and CG = '0')
      report "Testcase 2 failed" severity error;
    wait;
  end process;

  -- Test3 -  BTNC
  process
  begin
    BTNC <= '1';
    wait for 10 ns;
    assert (AN = "1111_1111")
      report "Testcase 3 failed" severity error;
    wait;
  end process;

end Behavioral;
