//Tower of Hanoi

//1. Only one disk can be moved at a time.

//2. Each move consists of taking the upper disk from one of the stacks and placing it on top of another stack i.e. a disk can only be moved if it is the uppermost disk on a stack.

//3. No disk may be placed on top of a smaller disk.

// With three disks, the puzzle can be solved in seven moves. The minimum number of moves required to solve a Tower of Hanoi puzzle is 2^n-1, where n is the number of disks.

 

`ifndef P84__SV

`define P84__SV

 

program P_84;

    class TowerOfHanoi;

        int number_of_disks;

        int unsigned cnt ;

 

        function new ();

           this.number_of_disks = 3;

        endfunction

 

        task set_disk_number(int numdisk=3);

            if (!($value$plusargs("disks=%d",this.number_of_disks))) begin

               this.number_of_disks = numdisk;

            end

        endtask

 

       //using recursion

        function move(int unsigned number_of_disks, string source, string dest, string aux);

           if (number_of_disks >= 1) begin

              move(number_of_disks-1, source, aux, dest);

              printMove(source, dest);

              move(number_of_disks-1, aux, dest, source);

              cnt = cnt +1;

           end

        endfunction

 

        function void printMove(string from, string to);

          $display("moving from ", from , " to ", to);

        endfunction

 

    endclass

 

 

    //test it ..

    initial begin

       TowerOfHanoi towerOfHanoi;

       towerOfHanoi = new();

       towerOfHanoi.set_disk_number();

       towerOfHanoi.move(towerOfHanoi.number_of_disks, "S", "D", "A");

       $display ("total number of moves are %0d", towerOfHanoi.cnt);

    end

 

endprogram

 

`endif //P84__SV
