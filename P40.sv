//Tic Tac Toe

`ifndef P40__SV

`define P40__SV

 

program P_40;

   class TicTacToe;

      typedef enum {X,O,U} mark;

      rand mark matrix[3][3];

      bit [3:0] cellAvailable[$];

      bit [3:0] whichCell;

      int unsigned i,j;

      int idx[$];

 

      function void printMe();

        foreach(matrix[i,]) begin

          foreach(matrix[j]) begin

             $write(" %0s ", matrix[i][j].name);

          end

             $display();

        end

      endfunction

 

      constraint c_default {

         foreach (matrix[i,j]) {

            matrix[i][j] == mark'(U);

         }

      }

 

      function new();

         cellAvailable = '{0,1,2,3,4,5,6,7,8};

      endfunction

 

      function bit isMatch(mark m);

          bit match;

          match  = 0;

          //col/row checks

          foreach (matrix[i,]) begin

             match =  (matrix[i][0] ==  matrix[i][1]);

             match &= (matrix[i][1] ==  matrix[i][2]);

             match &= (matrix[i][0] ==  m);

            if (match) return match;

          end

          foreach (matrix[,j]) begin

            match =  (matrix[0][j] ==  matrix[1][j]);

            match &= (matrix[1][j] ==  matrix[2][j]);

            match &= (matrix[0][j] ==  m);

            if (match) return match;

          end

          //diagnoal checks

          begin

             match =  (matrix[0][0] ==  matrix[1][1]);

             match &= (matrix[1][1] ==  matrix[2][2]);

             match &= (matrix[0][0] ==  m);

             if (match) return match;

          end

 

          begin

             match =  (matrix[0][2] ==  matrix[1][1]);

             match &= (matrix[1][1] ==  matrix[2][0]);

             match &= (matrix[0][2] ==  m);

             if (match) return match;

          end

            return match;

      endfunction

 

      function void markMe(int unsigned i, int unsigned j, mark m);

         matrix[i][j] = mark'(m);

      endfunction

 

      function void play(mark m);

            //search for empty cell in TicTacToe, and randomize the cells

            cellAvailable.shuffle();

            whichCell = cellAvailable.pop_front();

            returnCellNum(i,j);

            //randomly mark any cell

            markMe(i,j,m);

      endfunction

 

      function bit areWeDone();

          areWeDone = ( cellAvailable.size() == 0 );

          if (areWeDone)

             $display("debug:%0d, Stalemate !",`__LINE__);

      endfunction

 

      function void  returnCellNum(output int unsigned i, output int unsigned j);

         case (whichCell)

           0: begin i = 0; j=0; end

           1: begin i = 0; j=1; end

           2: begin i = 0; j=2; end

           3: begin i = 1; j=0; end

           4: begin i = 1; j=1; end

           5: begin i = 1; j=2; end

           6: begin i = 2; j=0; end

           7: begin i = 2; j=1; end

           8: begin i = 2; j=2; end

         endcase

      endfunction

 

   endclass

 

   class Player;

      TicTacToe ticTacToe;

      string whoami;

      TicTacToe::mark m;

      semaphore sem;

 

      function new(TicTacToe ticTacToe, int unsigned num);

         $sformat(whoami, "player_%0d",num);

         this.ticTacToe = ticTacToe;

      endfunction

 

      function void set_my_board(TicTacToe ticTacToe);

         this.ticTacToe = ticTacToe;

      endfunction

 

      function void set_semaphore(semaphore sem);

         this.sem = sem;

      endfunction

 

      function void set_mark(m);

         this.m =  TicTacToe::mark'(m);

         $display("debug:%0d, %0s's mark is %0s",`__LINE__,whoami, this.m.name());

      endfunction

 

      task play(output bit won);

         sem.get(1);

         $display("debug:%0d, %0s's turn ",`__LINE__, whoami);

         ticTacToe.play(this.m);

         //check if I won

         if (ticTacToe.isMatch(this.m)) begin

            $display("debug:%0d, Game Over! %0s won",`__LINE__, whoami);

            won = 1;

         end

         sem.put(1);

      endtask

 

   endclass

 

   class Game;

     Player player_1, player_2;

     bit whoIsFirst;

     TicTacToe ticTacToe;

     semaphore sem;

 

     function new();

        ticTacToe = new();

        assert(ticTacToe.randomize());

        player_1 = new(ticTacToe, 1);

        player_2 = new(ticTacToe, 2);

        player_1.set_mark(TicTacToe::O);

        player_2.set_mark(TicTacToe::X);

        sem = new(1);

        player_1.set_semaphore(sem);

        player_2.set_semaphore(sem);

     endfunction

 

 

     task playGame();

       bit win1, win2;

       bit newGame;

 

       int unsigned howManyGames;

       if (!($value$plusargs("games=%0d",howManyGames))) begin

          howManyGames = 3;

       end

 

       for (int i=0; i<howManyGames; i++) begin

          $display("debug:%0d, New Tic-Tac-Toe Game: %0d",`__LINE__,i);

          ticTacToe = new();

          assert(ticTacToe.randomize()); //for empty slate

          player_1.set_my_board(ticTacToe);

          player_2.set_my_board(ticTacToe);

          while (1) begin

               player_1.play(win1);

               if (win1) begin newGame=1; printMe(); break;  end

               printMe();

               player_2.play(win2);

               if (win2) begin newGame=1; printMe(); break;  end

               printMe();

               newGame = ticTacToe.areWeDone();

               if (newGame) begin

                  printMe();

                  $display("debug:%0d, Starting new game",`__LINE__);

                  break; //go to new game

               end

          end

       end

     endtask

 

     function void printMe();

        ticTacToe.printMe();

     endfunction

 

   endclass

 

   //test it..

   initial begin

      Game game;

      game = new();

      game.playGame();

   end

 

endprogram

 

`endif //P40__SV
