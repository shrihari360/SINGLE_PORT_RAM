`include "defines.svh"

class ram_reference_model;
  ram_transaction ref_trans;
  mailbox #(ram_transaction) mbx_rs;
  mailbox #(ram_transaction) mbx_dr;
  virtual ram_if.REF_SB vif;
  reg [`DATA_WIDTH-1:0] MEM [`DATA_DEPTH-1:0];

  function new(mailbox #(ram_transaction) mbx_dr,
               mailbox #(ram_transaction) mbx_rs,
               virtual ram_if.REF_SB vif);
    this.mbx_dr = mbx_dr;
    this.mbx_rs = mbx_rs;
    this.vif    = vif;
  endfunction

task start();
  for (int i = 0; i < `num_transactions; i++)
  begin
    ref_trans = new();
    mbx_dr.get(ref_trans);
    repeat(1) @(vif.ref_cb)
    begin
      if (vif.ref_cb.reset == 0) begin
        MEM[ref_trans.address] = 8'bz;
        ref_trans.data_out = 8'bz;
      end
      else if (ref_trans.write_enb && !ref_trans.read_enb) begin
        MEM[ref_trans.address] = ref_trans.data_in;
        ref_trans.data_out = 8'bz;   
      end
      else if (ref_trans.read_enb && !ref_trans.write_enb) begin
        ref_trans.data_out = MEM[ref_trans.address];
      end
      else begin
        ref_trans.data_out = 8'bz;
      end
      $display("REFERENCE MODEL DATA IN MEMORY MEM[%0h]=%0h", ref_trans.address, MEM[ref_trans.address], $time);
      $display("REFERENCE MODEL DATA OUT FROM MEMORY data_out=%0h", ref_trans.data_out, $time);
    end
    mbx_rs.put(ref_trans);
  end
endtask
endclass
