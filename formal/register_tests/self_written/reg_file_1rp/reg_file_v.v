`timescale 1ns/1ps

// module reg_file_v : reg_file_v
module reg_file_v

  ( input              reset,
    input               clock,
    input       [ 2:0]        r_a_raddr_in,
    input       [(2*16) -1:0] r_in,
    output  reg [15:0] a_out
  );

  reg  [15:0] reg_val[0:1];

  reg  [15:0] reg_val_next[0:1];

  always @ (*)
  begin : p_read_reg

    a_out = reg_val[r_a_raddr_in];

  end

  always @ (posedge clock or posedge reset)
  begin : p_write_reg

    integer j;
    if (reset)
    begin
      for ( j = 0; j <= 1; j = j + 1)
        reg_val[j] <= 16'sh0;

    end
    else
    begin
    for ( j = 0; j <= 1; j = j + 1)
      reg_val[j] <= reg_val_next[j];
    end
  end

  always @ (*)
  begin : p_write_combin_reg_r
  integer j;
  integer t;
    for ( j = 0; j <= 1; j = j + 1)
      reg_val_next[j] = 16'sh0;


  integer i;
    for ( i = 0; i <= 1; i = i + 1)
    begin
      t = 16 * ((2 -1) -i);
      reg_val_next[i] = r_in[t + 16  -1 :t];
    end

  end


endmodule
