//Factorial

//NOTE: works well till n=33 (33!) after that prints 0s. (why?) systemverilog data type limitations ? (TODO:)

 

`ifndef P80__SV

`define P80__SV

 

program P_80;

  typedef int unsigned u_int;

 

  function automatic u_int factorial(u_int n);

    assert(n>=0);

    if (n == 0 || n == 1) begin

       factorial = 1;

    end else begin

       factorial = ( factorial(n-1) * n );

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

      $display("printing factorial sequence for first %0d natural numbers", num_ );

      for (int i=1; i<=num_; i++) begin

         $write("%0d ", factorial(i));

         print_line++;

         if ( !(print_line%10) ) $display; //new line

      end

      $display(); //new line

      $finish;

   end

endprogram

 

 

`endif //P80__SV
