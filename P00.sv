//Given an IP4 address and a subnet mask, compute the network, broadcast and first/last host address
 

`ifndef P00__SV

`define P00__SV

program P_00;

 

   class IPv4;

      rand bit [31:0] ipv4_addr;

      rand bit [31:0] ipv4_mask;

 

      task setIpv4Addr(bit [31:0] ipv4_addr);

         this.ipv4_addr = ipv4_addr;

      endtask

 

      task setIpv4Mask(bit [31:0] ipv4_mask);

         this.ipv4_mask = ipv4_mask;

      endtask

 

      function void printIpv4AddrMask();

        $display("The ipv address is %s", printme(this.ipv4_addr));

        $display("The ipv mask    is %s", printme(this.ipv4_mask));

      endfunction

 

      function void  getNetworkAddress();

         bit [31:0] ipv4_nw_addr;

         ipv4_nw_addr = (ipv4_mask & ipv4_addr);

         $display("The network address is %s", printme(ipv4_nw_addr));

      endfunction

 

      function void getHostAddress();

         bit [31:0] ipv4_host_addr;

         ipv4_host_addr = ~(ipv4_mask | ipv4_addr);

         $display("The host address is %s", printme(ipv4_host_addr));

      endfunction

 

      function void getBroadcastAddress();

         bit [31:0] ipv4_broadcast_addr;

         ipv4_broadcast_addr = (~ipv4_mask | ipv4_addr);

         $display("The broadcast address is %s", printme(ipv4_broadcast_addr));

      endfunction

 

      function string printme(bit [31:0] bit_vec);

         string s;

         $sformat(s, "%h.%h.%h.%h", bit_vec[31:24], bit_vec[23:16],bit_vec[15:8], bit_vec[7:0] );

         return s;

      endfunction

 

   endclass

 

   //test it..

   initial begin

      IPv4 ipv4;

      repeat (10) begin

        ipv4 = new;

        assert(ipv4.randomize());

        ipv4.printIpv4AddrMask();

        ipv4.getNetworkAddress();

        ipv4.getHostAddress();

        ipv4.getBroadcastAddress();

      end

      $finish;

   end

endprogram

`endif //P00__SV
