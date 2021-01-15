
`timescale 1ns/1ps

module reg_v

  ( input          reset,
    input          clock,
    input          r_en_in,
    input   [15:0] r_in,
    output  [15:0] r_out
  );

  reg [15:0] reg_val;

  reg [15:0] reg_val_next;

  reg        reg_write_enab;

  always @ (*)
  begin : p_read_reg

    r_out = reg_val;

  end

  always @ (*)
  begin : p_write_combin_reg

    reg_write_enab  = 1'h0;
    reg_val_next    = 16'h0;

    if ( r_en_in )
    begin
      reg_write_enab  = 1'b1;
      reg_val_next    = r_in;
    end

  end

  always @ (posedge clock or posedge reset)
  begin : p_write_reg

    if (reset)
    begin
      reg_val <= 16'h0;
    end
    else
    begin
      if (reg_write_enab)
        reg_val <= reg_val_next;
    end
  end

endmodule
