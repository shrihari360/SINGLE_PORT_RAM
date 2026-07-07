class test_regression extends ram_test;
  ram_transaction        trans;
  ram_transaction_write  trans_write;
  ram_transaction_read   trans_read;

  function new(virtual ram_if drv_vif, virtual ram_if mon_vif, virtual ram_if ref_vif);
    super.new(drv_vif, mon_vif, ref_vif);
  endfunction

  task run();
    env = new(drv_vif, mon_vif, ref_vif);
    env.build();

    trans = new();
    env.gen.blueprint = trans;
    env.start();

    trans_write = new();
    env.gen.blueprint = trans_write;
    env.start();

    trans_read = new();
    env.gen.blueprint = trans_read;
    env.start();
  endtask
endclass
