`timescale 1ns/1ps

// module reg_file_v : reg_file_v
module reg_file_v

  ( input              reset,
    input              clock,
    input              r_d_wen_in,
    input              r_d_waddr_in,
    input              d_in,
    output  reg [1:0] a_out
  );

  reg  [1:0] reg_val;

  reg  [1:0] reg_val_next;

  reg  [1:0] reg_write_enab;

  always @ (*)
  begin : p_read_combin_reg_r

  integer i;
    for ( i = 0; i <= 1; i = i + 1)
    begin
      a_out[i] = reg_val[i];
    end

  end

  always @ (*)
  begin : p_write_combin_reg

    integer j;

    reg_write_enab = 2'h0;
    reg_val_next = 2'h0;


    if (r_d_wen_in)
    begin
        reg_write_enab[ r_d_waddr_in ] = 1'b1;
        for ( j = 0; j <= 1; j = j + 1)
        begin
            if(j == r_d_waddr_in)
                reg_val_next[j] = d_in;
        end
    end

  end

  always @ (posedge clock or posedge reset)
  begin : p_write_reg

    integer j;
    if (reset)
    begin
      reg_val <= 2'sh0;

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
