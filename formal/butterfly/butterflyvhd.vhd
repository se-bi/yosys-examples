library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Daten: Input:        2x 8 Bit
--        Output:       2x 8 Bit

entity butterflyvhd is
  port (
    LeftValuexDI        : in  std_logic_vector(7 downto 0);
    RightValuexDI       : in  std_logic_vector(7 downto 0);
    LowerValuexDO       : out std_logic_vector(7 downto 0);
    HigherValuexDO      : out std_logic_vector(7 downto 0)
  );
end entity butterflyvhd;

architecture butt of butterflyvhd is

  begin

  -- best
  p_comb_butterfly : process (LeftValuexDI, RightValuexDI)
    variable LeftIn             : unsigned(7 downto 0);
    variable RightIn            : unsigned(7 downto 0);
    variable LowerValue         : unsigned(7 downto 0);
    variable HigherValue        : unsigned(7 downto 0);
  begin
    -- init
    LeftIn              := unsigned(LeftValuexDI);
    RightIn             := unsigned(RightValuexDI);
    LowerValue          := unsigned(LeftValuexDI);
    HigherValue         := unsigned(RightValuexDI);
    -- mux
    if LeftIn > RightIn then
      HigherValue := LeftIn;
      LowerValue  := RightIn;
    end if;
    -- out
    LowerValuexDO <=    std_logic_vector(LowerValue);
    HigherValuexDO <=   std_logic_vector(HigherValue);
  end process p_comb_butterfly;

end architecture butt;
