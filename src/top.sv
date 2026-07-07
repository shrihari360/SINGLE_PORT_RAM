`include "defines.svh"


module top();
  import ram_package::*;

  logic clk;
  logic reset;

 
  initial
  begin
    clk = 0;
    forever #10 clk = ~clk;
  end


  initial
begin
  reset = 1;           // idle / inactive
  @(posedge clk);
  reset = 0;            // asserted / active
  repeat(1) @(posedge clk);
  reset = 1;            // released
end

 
  ram_if intrf(clk, reset);


  RAM DUV(
    .data_in(intrf.data_in),
    .write_enb(intrf.write_enb),
    .read_enb(intrf.read_enb),
    .data_out(intrf.data_out),
    .address(intrf.address),
    .clk(clk),
    .reset(reset)
  );

 
  ram_test        t1 = new(intrf.DRV, intrf.MON, intrf.REF_SB);
  test_write       t2 = new(intrf.DRV, intrf.MON, intrf.REF_SB);
  test_read        t3 = new(intrf.DRV, intrf.MON, intrf.REF_SB);
  test_regression  t4 = new(intrf.DRV, intrf.MON, intrf.REF_SB);

  initial
  begin
    //t1.run();  
    //t2.run();   
    //t3.run();   
    t4.run();    
    $finish();
  end

endmodule
