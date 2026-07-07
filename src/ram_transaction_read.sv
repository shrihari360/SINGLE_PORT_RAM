class ram_transaction_read extends ram_transaction;
  constraint wr_rd_constraint { {write_enb, read_enb} == 2'b01; }
  constraint addr_range_c     { address inside {[0:7]}; }
  virtual function ram_transaction copy();
    ram_transaction_read copy2;
    copy2 = new();
    copy2.data_in   = this.data_in;
    copy2.write_enb = this.write_enb;
    copy2.read_enb  = this.read_enb;
    copy2.address   = this.address;
    return copy2;
  endfunction
endclass
