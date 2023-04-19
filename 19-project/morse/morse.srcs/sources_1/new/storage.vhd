library ieee;
use ieee.std_logic_1164.all;
entity shift_register is
port (
  clk          : in  std_logic;
 rstb         : in  std_logic;
  char_b         : in  std_logic_vector(1 downto 0);
  char_m         : out std_logic_vector(1 downto 0));
end shift_register;
architecture rtl of shift_register is
signal r0_data         : std_logic_vector(1 downto 0);
signal r1_data         : std_logic_vector(1 downto 0);
signal r2_data         : std_logic_vector(1 downto 0);
signal r3_data         : std_logic_vector(1 downto 0);
begin
o_data  <= r3_data;
p_sreg : process(i_clk,i_rstb)
begin
  if(i_rstb='0') then
    r0_data    <= (others=>'0');
    r1_data    <= (others=>'0');
    r2_data    <= (others=>'0');
    r3_data    <= (others=>'0');
  elsif(rising_edge(i_clk)) then
    r0_data    <= i_data;
    r1_data    <= r0_data ;
    r2_data    <= r1_data ;
    r3_data    <= r2_data ;
  end if;
end process p_sreg;
end rtl;