//Fibonacci sequence (at least first 100 numbers)

//NOTE: first 50 itself takes lot of time.. TODO:find alternative way to generate numbers

`ifndef P85__SV

`define P85__SV

program P_85;

  typedef int unsigned u_int;

 

  function automatic u_int fibonacci(u_int n);

    assert(n>0);

    if (n == 1 || n == 2) begin

       fibonacci = 1;

    end else begin

       fibonacci = ( fibonacci(n-1) + fibonacci(n-2));

    end

  endfunction

 

   //test it..

   initial begin

      int unsigned num_;

      int unsigned print_line;

      print_line = 0;

      if (!$value$plusargs("times=%d",num_)) begin

         num_ = 10;

      end

      $display("printing fibonacci sequence for first %0d natural numbers", num_ );

      for (int i=1; i<=num_; i++) begin

         $write("%0d ", fibonacci(i));

         print_line++;

         if ( !(print_line%10) ) $display; //new line

      end

      $display(); //new line

      $finish;

   end

endprogram

`endif //P85__SV

`endif //P85__SV
