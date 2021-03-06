`timescale 1ns/1ps

// module reg_file_v : reg_file_v
module reg_file_v

  ( input              reset,
    input              clock,
    input              r_d_wen_in,
    input              r_a_raddr_in,
    input              r_d_waddr_in,
    input       [15:0] d_in,
    output  reg [15:0] a_out
  );

  reg  [15:0] reg_val[0:1];

  reg  [15:0] reg_val_next[0:1];

  reg  [1:0] reg_write_enab;

  always @ (*)
  begin : p_read_reg

    a_out = reg_val[r_a_raddr_in];

  end

  always @ (*)
  begin : p_write_combin_reg

    integer j;

    reg_write_enab = 2'b0;
    for ( j = 0; j <= 1; j = j + 1)
      reg_val_next[j] = 16'b0;

    if (r_d_wen_in)
    begin
      reg_write_enab[ r_d_waddr_in ] = 1'b1;
      reg_val_next[   r_d_waddr_in ] = d_in;
    end

  end

  always @ (posedge clock or posedge reset)
  begin : p_write_reg

    integer j;
    if (reset)
    begin
      for ( j = 0; j <= 1; j = j + 1)
        reg_val[j] <= 16'b0;

    end
    else
    begin
      for ( j = 0; j <= 1; j = j + 1)
      begin
        if (reg_write_enab[j])
        begin
          reg_val[j] <= reg_val_next[j];
        end
      end
    end
  end

endmodule
