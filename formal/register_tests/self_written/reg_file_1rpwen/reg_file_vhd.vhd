library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file_vhd is
  port (
    reset         : in  std_logic;
    clock         : in  std_logic;
    r_a_raddr_in  : in  std_logic;
    r_en_in       : in  std_logic;
    r_in          : in  std_logic_vector( 31 downto 0);
    a_out         : out std_logic_vector(      15 downto 0)
  );
end reg_file_vhd;


architecture rtl of reg_file_vhd is

  subtype data_word       is std_logic_vector(15 downto 0);
  type    data_word_array is array (natural range <>) of data_word;

  signal reg_val        : data_word_array(1 downto 0);
  signal reg_val_next   : data_word_array(1 downto 0);
  signal reg_write_enab : std_logic;

  function to_integer (constant arg : std_logic)
    return integer is
  begin
    if arg = '1' then
      return 1;
    else
      return 0;
    end if;
  end to_integer;

begin

  p_read_reg : process(reg_val,
                         r_a_raddr_in)
  begin

    a_out <= reg_val( to_integer(r_a_raddr_in) );

  end process p_read_reg;

p_comb_inv : process (r_in)
    variable t : integer;
  begin
    reg_write_enab <= '0';
    reg_val_next <= (others => (others => '0'));
    --

    --
    if r_en_in = '1' then
        for i in 0 to 1 loop
            t := 16 * i;
            reg_val_next(i) <= r_in(t + 16  -1 downto t);
        end loop;  -- i
        reg_write_enab <= '1';
    end if;
  end process p_comb_inv;

  p_write_reg : process(clock, reset)
  begin
    if reset = '1' then   -- async reset high
      reg_val <= (others => (others => '0'));
    elsif rising_edge(clock) then
	if reg_write_enab = '1' then
          reg_val <= reg_val_next;

end if;
    end if;
  end process p_write_reg;

  

end rtl;
