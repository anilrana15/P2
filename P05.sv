//count word occurrences in a text file

//TODO: correct the word count logic to match output of 'wc -w <filename>'

 

`ifndef P05__SV

`define P05__SV

program P_05;

 

 

   function void get_my_word(integer q[$]);

     foreach (q[i]) begin

       $write("%c",q[i]);

     end

   endfunction

 

   initial begin

      integer fh;

      string file_for_read;

      integer c, gotword;

      int unsigned word;

      integer store_word[$];

 

      if (!$value$plusargs("file=%0s", file_for_read)) begin

         file_for_read = "P05.sv";

      end

      fh = $fopen(file_for_read, "r");

      if (fh != 0) begin

         $display("opened file %0s for reading", file_for_read);

      end else begin

         $display("Error opening file %0s for reading", file_for_read);

         $finish;

      end

    

      //read the file each character

      c = 0;

      gotword = 0;

      word = 0;

      while ( c !=  -1) begin //check EOF character

         c = $fgetc(fh);

         if (c != " ") begin

           gotword = 1'b1 ;

           store_word.push_back(c);

         end else begin

           if (gotword == 1) begin

              word++; //count total number of words

              get_my_word(store_word);

           end

           store_word.delete(); //empty the store;

           gotword = 1'b0;

           $write("%c", c); //print the character

         end

//         $write("%c", c); //print the character

      end

 

      $display("\nTotal number of words in file %0s is  = %0d",file_for_read,  word);

   end

endprogram

 

`endif // P05__SV
