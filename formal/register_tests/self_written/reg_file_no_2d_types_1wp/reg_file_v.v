`timescale 1ns/1ps

// module reg_file_v : reg_file_v
module reg_file_v

  ( input              reset,
    input              clock,
    input              r_d_wen_in,
    input              r_d_waddr_in,
    input       [15:0] d_in,
    output  reg [(16*2)-1:0] a_out
  );

  reg  [(16*2)-1:0] reg_val;

  reg  [(16*2)-1:0] reg_val_next;

  reg  [1:0] reg_write_enab;

  always @ (*)
  begin : p_read_combin_reg_r
  integer t;

  integer i;
    for ( i = 0; i <= 1; i = i + 1)
    begin
      t = 16 * ((2 -1) -i);
      a_out[t + 16  -1 :t] = reg_val[t + 16  -1 :t];
    end

  end

  always @ (*)
  begin : p_write_combin_reg

    integer j;
    integer t;

    reg_write_enab = 2'h0;
    reg_val_next = 32'h0;


    if (r_d_wen_in)
    begin
        reg_write_enab[ r_d_waddr_in ] = 1'b1;
        for ( j = 0; j <= 1; j = j + 1)
        begin
            t = 16 * ((2 -1) -j);
            if(j == r_d_waddr_in)
                reg_val_next[   t + 16  -1 :t ] = d_in;
        end
    end

  end

  always @ (posedge clock or posedge reset)
  begin : p_write_reg

    integer j;
    integer t;
    if (reset)
    begin
      reg_val <= 32'sh0;

    end
    else
    begin
      for ( j = 0; j <= 1; j = j + 1)
      begin
        t = 16 * ((2 -1) -j);
        if (reg_write_enab[j])
        begin
          reg_val[t + 16  -1 :t] <= reg_val_next[t + 16  -1 :t];
        end
      end
    end
  end

endmodule
