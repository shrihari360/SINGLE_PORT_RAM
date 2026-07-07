class ram_transaction_write extends ram_transaction;
  constraint wr_rd_constraint { {write_enb, read_enb} == 2'b10; }
  constraint addr_range_c     { address inside {[0:7]}; }
  virtual function ram_transaction copy();
    ram_transaction_write copy1;
    copy1 = new();
    copy1.data_in   = this.data_in;
    copy1.write_enb = this.write_enb;
    copy1.read_enb  = this.read_enb;
    copy1.address   = this.address;
    return copy1;
  endfunction
endclass
