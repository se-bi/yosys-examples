library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.data_types.all;


entity reg is
  port (
    reset : in  std_logic;
    clock : in  std_logic;
    r_out : out data_word;
    r_in  : in  data_word);
end reg;

architecture rtl of reg is

  signal reg_val  : data_word;

begin

  p_write_seq_reg : process( clock, reset )
  begin
    if reset /= '0' then
      reg_val <= (others => '0');
    elsif rising_edge( clock ) then
      reg_val <= r_in;
    end if;
  end process p_write_seq_reg;

  r_out <= reg_val;

end rtl;
