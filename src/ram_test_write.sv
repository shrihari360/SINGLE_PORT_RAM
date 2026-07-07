class test_write extends ram_test;
  ram_transaction_write trans_write;

  function new(virtual ram_if drv_vif, virtual ram_if mon_vif, virtual ram_if ref_vif);
    super.new(drv_vif, mon_vif, ref_vif);
  endfunction

  task run();
    env = new(drv_vif, mon_vif, ref_vif);
    env.build;
    trans_write = new();
    env.gen.blueprint = trans_write;
    env.start;
  endtask
endclass
