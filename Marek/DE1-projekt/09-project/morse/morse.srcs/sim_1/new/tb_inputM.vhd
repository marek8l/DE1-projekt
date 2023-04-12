----------------------------------------------------------
--
-- Template for traffic lights controller testbench.
-- Nexys A7-50T, xc7a50ticsg324-1L
-- TerosHDL, Vivado v2020.2, EDA Playground
--
-- Copyright (c) 2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
----------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;

----------------------------------------------------------
-- Entity declaration for testbench
----------------------------------------------------------

entity tb_inputM is
  -- Entity of testbench is always empty
end entity tb_inputM;

----------------------------------------------------------
-- Architecture body for testbench
----------------------------------------------------------

architecture testbench of tb_inputM is

  -- Local constants
  constant c_CLK_100MHZ_PERIOD : time := 1000 ms;

  -- Local signals
  signal sig_clk_100mhz : std_logic;
  signal sig_BTNC : std_logic;
  signal sig_char : std_logic_vector(4 downto 0);
  signal sig_zero_cnt : std_logic;
begin

  -- Connecting testbench signals with tlc entity
  -- (Unit Under Test)
  uut_tlc : entity work.inputM
    port map (
      clk   => sig_clk_100mhz,
      BTNC => sig_BTNC,
      char => sig_char
      
    );

  --------------------------------------------------------
  -- Clock generation process
  --------------------------------------------------------
  p_clk_gen : process is
  begin

    while now < 10000 ms loop -- 10 usec of simulation

      sig_clk_100mhz <= '0';
      wait for c_CLK_100MHZ_PERIOD / 2;
      sig_clk_100mhz <= '1';
      wait for c_CLK_100MHZ_PERIOD / 2;

    end loop;

    wait;

  end process p_clk_gen;

  --------------------------------------------------------
  -- Reset generation process
  --------------------------------------------------------
  p_reset_gen : process is
  begin

    sig_BTNC <= '0';
    wait for 2000 ms;

    -- Reset activated
    sig_BTNC <= '1';
    wait for 5000 ms;

    sig_BTNC <= '0';
    wait for 1000 ms;

    -- Reset activated
    sig_BTNC <= '1';
    wait for 1000 ms;

   sig_BTNC <= '0';
    wait for 2000 ms;

  end process p_reset_gen;

  --------------------------------------------------------
  -- Data generation process
  --------------------------------------------------------
  p_stimulus : process is
  begin

    report "Stimulus process started";
    -- No other input data is needed.
    report "Stimulus process finished";
    wait;

  end process p_stimulus;

end architecture testbench;