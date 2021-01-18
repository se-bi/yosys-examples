`timescale 1ns/1ps

// module reg_file_v : reg_file_v
module reg_file_v

  ( input              reset,
    input               clock,
    input       [ 2:0]        r_a_raddr_in,
    input       [(8*16) -1:0] c_in,
    output  reg [15:0] a_out
  );

  reg  [15:0] reg_val[0:7];

  reg  [15:0] reg_val_next[0:7];

  always @ (*)
  begin : p_read_reg

    a_out = reg_val[r_a_raddr_in];

  end

  always @ (*)
  begin : p_write_combin_reg

    reg_val_next = r_in;

  end

  always @ (posedge clock or posedge reset)
  begin : p_write_reg

    integer j;
    if (reset)
    begin
      for ( j = 0; j <= 7; j = j + 1)
        reg_val[j] <= 16'sh0;

    end
    else
    begin
      reg_val <= reg_val_next;
    end
  end

  always @ (*)
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


endmodule
