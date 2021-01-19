library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file_vhd is
  port (
    reset         : in  std_logic;
    clock         : in  std_logic;
    r_d_wen_in    : in  std_logic;
    r_d_waddr_in  : in  std_logic;
    d_in          : in  std_logic;
    a_out         : out std_logic_vector(1 downto 0)
  );
end reg_file_vhd;


architecture rtl of reg_file_vhd is



  signal reg_val        : std_logic_vector(1 downto 0);
  signal reg_val_next   : std_logic_vector(1 downto 0);
  signal reg_write_enab : std_logic_vector(1 downto 0);
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

  p_read_reg : process(reg_val)
    variable t : integer;
  begin
    --
    for i in 0 to 1 loop
      a_out(i) <= reg_val(i);
    end loop;  -- i
    --

  end process p_read_reg;

  p_write_combin_reg : process(r_d_wen_in,
                                 r_d_waddr_in,
                                 d_in)
    variable t : integer;
  begin
    reg_write_enab <= (others => '0');
    reg_val_next   <=  (others => '0');

    if r_d_wen_in = '1' then
      reg_write_enab( to_integer(  r_d_waddr_in ) ) <= '1';
        for i in 0 to 1 loop
            if i = to_integer(  r_d_waddr_in )
            then
                reg_val_next(i) <= d_in;
            end if;
        end loop;  -- i

    end if;

  end process p_write_combin_reg;

  p_write_reg : process(clock, reset)
  variable t : integer;
  begin
    if reset = '1' then   -- async reset high
      reg_val <= (others => '0');
    elsif rising_edge(clock) then
      for g in 0 to 1 loop
        if reg_write_enab(g) = '1' then
          reg_val(g) <= reg_val_next(g);
        end if;
      end loop;
    end if;
  end process p_write_reg;

end rtl;
