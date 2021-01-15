
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- entity reg_vhd : reg_vhd
entity reg_vhd is

  port (
    reset   : in  std_logic;
    clock   : in  std_logic;
    r_en_in : in  std_logic;
    r_in    : in  std_logic_vector(15 downto 0);
    r_out   : out std_logic_vector(15 downto 0)
  );
end reg_vhd;


architecture rtl of reg_vhd is

  subtype data_word       is std_logic_vector(15 downto 0);

  signal reg_val        : data_word;
  signal reg_val_next   : data_word;
  signal reg_write_enab : std_logic;

begin

  r_out <= reg_val;

  p_write_combin_reg : process(r_en_in,
                                  r_in)
  begin
    reg_write_enab  <= '0';
    reg_val_next    <= (others => '0');

    if r_en_in = '1' then
      reg_write_enab  <= '1';
      reg_val_next    <= r_in;
    end if;

  end process p_write_combin_reg;

  p_write_reg : process(clock, reset)
  begin
    if reset = '1' then   -- async reset high
      reg_val <= (others => '0');
    elsif rising_edge( clock ) then
      if reg_write_enab = '1' then
        reg_val <= reg_val_next;
      end if;
    end if;
  end process p_write_reg;

end rtl;
