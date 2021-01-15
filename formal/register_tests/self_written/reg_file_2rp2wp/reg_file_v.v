`timescale 1ns/1ps

// module reg_file_v : reg_file_v
module reg_file_v

  ( input              reset,
    input              clock,
    input              r_c_wen_in,
    input              r_d_wen_in,
    input       [ 2:0] r_a_raddr_in,
    input       [ 2:0] r_b_raddr_in,
    input       [ 2:0] r_c_waddr_in,
    input       [ 2:0] r_d_waddr_in,
    input       [15:0] c_in,
    input       [15:0] d_in,
    output  reg [15:0] a_out,
    output  reg [15:0] b_out
  );

  reg  [15:0] reg_val[0:7];

  reg  [15:0] reg_val_next[0:7];

  reg  [7:0] reg_write_enab;

  always @ (*)
  begin : p_read_reg

    a_out = reg_val[r_a_raddr_in];

    b_out = reg_val[r_b_raddr_in];

  end

  always @ (*)
  begin : p_write_combin_reg

    integer j;

    reg_write_enab = 8'h0;
    for ( j = 0; j <= 7; j = j + 1)
      reg_val_next[j] = 16'h0;


    if (r_c_wen_in)
    begin
      reg_write_enab[ r_c_waddr_in ] = 1'b1;
      reg_val_next[   r_c_waddr_in ] = c_in;
    end

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
      for ( j = 0; j <= 7; j = j + 1)
        reg_val[j] <= 16'sh0;

    end
    else
    begin
      for ( j = 0; j <= 7; j = j + 1)
      begin
        if (reg_write_enab[j])
        begin
          reg_val[j] <= reg_val_next[j];
        end
      end
    end
  end

endmodule
