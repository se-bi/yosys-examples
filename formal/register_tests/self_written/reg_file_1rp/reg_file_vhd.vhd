library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file_vhd is
  port (
    reset         : in  std_logic;
    clock         : in  std_logic;
    r_a_raddr_in  : in  std_logic_vector(       3  -1 downto 0);
    r_in          : in  std_logic_vector( (8 * 16) -1 downto 0);
    a_out         : out std_logic_vector(      16  -1 downto 0)
  );
end reg_file_vhd;


architecture rtl of reg_file_vhd is

  constant WL : integer := 16;
  constant L  : integer := 8;

  subtype data_word       is std_logic_vector(WL -1 downto 0);
  type    data_word_array is array (0 to L -1) of data_word;

  signal reg_val        : data_word_array;
  signal reg_val_next   : data_word_array;

begin

  p_read_reg : process(reg_val,
                         r_a_raddr_in)
  begin

    a_out <= reg_val( to_integer( unsigned( r_a_raddr_in ) ) );

  end process p_read_reg;

  p_write_reg : process(clock, reset)
  begin
    if reset = '1' then   -- async reset high
      reg_val <= (others => (others => '0'));
    elsif rising_edge(clock) then
      reg_val <= reg_val_next;
    end if;
  end process p_write_reg;

  p_comb_inv : process (r_in)
    variable r : data_word_array;
    variable t : integer;
  begin
    r := (others => (others => '0'));
    --
    for i in 0 to 8 -1 loop
      t := 16 * ((8 -1) -i);
      r(i) := r_in(t + 16  -1 downto t);
    end loop;  -- i
    --
    reg_val_next <= r;
  end process p_comb_inv;

end rtl;
