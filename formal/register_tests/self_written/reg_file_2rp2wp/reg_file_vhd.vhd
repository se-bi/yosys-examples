library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file_vhd is
  port (
    reset         : in  std_logic;
    clock         : in  std_logic;
    r_c_wen_in    : in  std_logic;
    r_d_wen_in    : in  std_logic;
    r_a_raddr_in  : in  std_logic_vector( 2 downto 0);
    r_b_raddr_in  : in  std_logic_vector( 2 downto 0);
    r_c_waddr_in  : in  std_logic_vector( 2 downto 0);
    r_d_waddr_in  : in  std_logic_vector( 2 downto 0);
    c_in          : in  std_logic_vector(15 downto 0);
    d_in          : in  std_logic_vector(15 downto 0);
    a_out         : out std_logic_vector(15 downto 0);
    b_out         : out std_logic_vector(15 downto 0)
  );
end reg_file_vhd;


architecture rtl of reg_file_vhd is

  subtype data_word       is std_logic_vector(15 downto 0);
  type    data_word_array is array (natural range <>) of data_word;

  signal reg_val        : data_word_array(0 to 7);
  signal reg_val_next   : data_word_array(0 to 7);
  signal reg_write_enab : std_logic_vector(0 to 7);

begin

  p_read_reg : process(reg_val,
                         r_a_raddr_in,
                         r_b_raddr_in)
  begin

    a_out <= reg_val( to_integer( unsigned( r_a_raddr_in ) ) );

    b_out <= reg_val( to_integer( unsigned( r_b_raddr_in ) ) );

  end process p_read_reg;

  p_write_combin_reg : process(r_c_wen_in,
                                 r_d_wen_in,
                                 r_c_waddr_in,
                                 r_d_waddr_in,
                                 c_in,
                                 d_in)
  begin
    reg_write_enab <= (others => '0');
    reg_val_next   <= (others => (others => '0'));

    if r_c_wen_in = '1' then
      reg_write_enab( to_integer( unsigned( r_c_waddr_in ) ) ) <= '1';
      reg_val_next(   to_integer( unsigned( r_c_waddr_in ) ) ) <= c_in;
    end if;

    if r_d_wen_in = '1' then
      reg_write_enab( to_integer( unsigned( r_d_waddr_in ) ) ) <= '1';
      reg_val_next(   to_integer( unsigned( r_d_waddr_in ) ) ) <= d_in;
    end if;

  end process p_write_combin_reg;

  p_write_reg : process(clock, reset)
  begin
    if reset = '1' then   -- async reset high
      reg_val <= (others => (others => '0'));
    elsif rising_edge(clock) then
      for g in 0 to 7 loop
        if reg_write_enab(g) = '1' then
          reg_val(g) <= reg_val_next(g);
        end if;
      end loop;
    end if;
  end process p_write_reg;

end rtl;
