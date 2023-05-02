library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_receiver is
end tb_receiver;

architecture Behavioral of tb_receiver is
    signal clk: std_logic := '0';
    signal DIN: std_logic := '1';
    signal DOUT: std_logic_vector(1 downto 0);
    signal lenght_out : std_logic_vector(1 downto 0) := "00";    
begin

    DUT: entity work.receiver
        port map (
            clk => clk,
            DIN => DIN,
            DOUT => DOUT,
            lenght_out => lenght_out
        );

    -- Clock generation
  clk_process : process
  begin
    while now < 25000 us loop
      clk <= '0';
      wait for 250 us;
      clk <= '1';
      wait for 250 us;
    end loop;
    wait;
  end process clk_process;
    -- Stimulus process
    
    stim_proc: process
  begin

    -- Test input 1: single one
    din <= '1';
    wait for 500 us;

    -- Test input 2: two ones
    din <= '0';
    wait for 500 us;


    -- Test input 3: three zeros
    din <= '1';
    wait for 500 us;


    -- Test input 4: four zeros
    din <= '0';
    wait for 500 us;


    -- Test input 5: single one again
    din <= '1';
    wait for 1500 us;
    
        din <= '0';
    wait for 1500 us;


    -- End of testbench
    wait;
  end process;
end Behavioral;
