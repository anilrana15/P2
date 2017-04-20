//Binary search_unit (integer, string, etc..)

//NOTE: works on sorted list. If list is not sorted than answer can be wrong.

 

 

/*from wikipedia : https://en.wikipedia.org/wiki/Binary_search_algorithm

Given an array A of n elements with values or records A0 ... An-1, sorted such that A0 <= ... <= An-1, and target value T, the following subroutine uses binary search to find the index of T in A 1. Set L to 0 and R to n-1.

2. If L > R, the search terminates as unsuccessful.

3. Set m (the position of the middle element) to the floor (the largest previous integer) of (L + R)/2.

4. If Am < T, set L to m + 1 and go to step 2.

5. If Am > T, set R to m - 1 and go to step 2.

6. Now Am = T, the search is done; return m.

*/

 

 

`ifndef P09__SV

`define P09__SV

 

program P_09;

   typedef bit [3:0] u_INT;

 

   class Search #(type T = int);

      function int bsearch(T value, T nel[]);

         int unsigned L, R, m;

         L = 0; 

         R = nel.size() -1;

 

 

         while (L < R) begin

            m = (L+R)/2; //floor

            $display("L=%0d, R=%0d, m=%0d", L, R, m);

            if (value > nel[m]) begin   

               L = m+1;

            end else if (value < nel[m]) begin

               R = m-1;

            end else begin

               return m; //found the element

            end

         end

         return -1;

      endfunction

   endclass

 

   initial begin

      u_INT array_of_int[], key;

      string array_of_string[], key_string;

      int found, size_of_array;

      Search #(u_INT) search_unit;

      Search #(string)  search_string;

 

      array_of_string = new[1];

      array_of_string = '{"aaaa", "bbbb", "cccc", "dddd", "eeee", "ffff", "gggg", "hhhh", "iiii", "jjjj", "kkkk"};

//      key_string      = "gggg";

      key_string      = "jjjj";

 

      repeat (2) begin

         size_of_array = $urandom_range(50, 100);

         array_of_int = new[size_of_array];

         assert(std::randomize(key));

         assert(std::randomize(array_of_int));

         $display("array_of_int %p",array_of_int);

         $display("key %h",key);

         found = search_unit.bsearch(key, array_of_int);

         if (found != -1) begin

            $display("found key %0h at %0d in array_of_int", key, found);

         end else begin

            $display("Did not find key %0h in array_of_int", key);

         end

      end

         $display("array_of_string %p",array_of_string);

         $display("key_string %0s",key_string);

         found = search_string.bsearch(key_string, array_of_string);

         if (found != -1) begin

            $display("found key_string %0s at %0d in array_of_string", key_string, found);

         end else begin

            $display("Did not find key_string %0s in array_of_string", key_string);

         end

      $finish;

   end

endprogram

 

`endif //P09__SV
