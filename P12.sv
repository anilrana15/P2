//Eight queens puzzle

//wikipedia link: https://en.wikipedia.org/wiki/Eight_queens_puzzle

 

`ifndef P12__SV

`define P12__SV

 

program P_12;

//16 pieces: one king, one queen, two rooks, two knights, two bishops, and eight pawns

//    typedef enum {K=0, Q, R, k, B, P} piece;

    logic clock;

    typedef enum {o=0, Q, N} piece; //o = initial value of every cell, Q=desired position of queen, N=No go area(diagonal paths from queen)

    class EightQueensPuzzle;

       rand piece cb[8][8];

 

       task printMatrix(piece cb[][]);

          foreach (cb[i,]) begin

             foreach(cb[j]) begin

                $write("%0s ",cb[i][j].name());

             end

             $display; //new line

          end

       endtask

 

//may not give solution all the time. too tight constraints..

       function void pre_randomize();

         //1. if count <8, select random (row,col) out of [8][8] pool, increment count.

         //2. discard (row, col) and diagnoal too, for next iteration from step 1. 

         //3. got to step 1

          int unsigned cnt, r, c;

          int unsigned row[int];

          int unsigned col[int];

          piece pool[8][8];

 

          cnt = 0;

          while (cnt <8) begin

             r = $urandom_range(0,7);

             c = $urandom_range(0,7);

             if (!(row.exists(r) || col.exists(c) || isPrevQueenInDiagPath(r,c,pool) )) begin

                row[r] = 1;

                col[c] = 1;

                pool[r][c] = piece'(Q);

                cnt++;

                calculateAllDiagonalCoordinates(r, c, pool);

                $display("r=%0d, c=%0d, cnt=%0d", r,c,cnt);

             end

          end

          printMatrix(pool);

       endfunction

 

       function bit isPrevQueenInDiagPath(int unsigned r, int unsigned c, const ref piece pool[8][8]);

          foreach (pool[i,]) begin

             foreach (pool[j]) begin

                if (pool[i][j] == piece'(N)) begin

                   if (i == r && j == c) return 1'b1;

                end

             end

          end

          return 1'b0;

       endfunction

 

       function void calculateAllDiagonalCoordinates(int unsigned r, int unsigned c,  ref piece pool[8][8]);

          //1. calculate how many row or column in both direction this (r,c) can move diagnoally . 

  

          for (int i = r+1, int j = c+1; i <8 || j<8; i++, j++) begin

                if (pool[i][j] != piece'(Q)) pool[i][j] = piece'(N);

          end

          for (int i = r+1, int j = c-1; i <8 || j>=0; i++, j--) begin

                if (pool[i][j] != piece'(Q)) pool[i][j] = piece'(N);

          end

          for (int i = r-1, int j = c+1; i >=0 || j<8; i--, j++) begin

                if (pool[i][j] != piece'(Q)) pool[i][j] = piece'(N);

          end

          for (int i = r-1, int j = c-1; i >=0 || j>=0; i--, j--) begin

                if (pool[i][j] != piece'(Q)) pool[i][j] = piece'(N);

          end

          printMatrix(pool);

       endfunction

 

       function void post_randomize();

          int s;

          s = cb.sum with (item.sum with (int'(item)));

          $display("%m total sum of cb addition is %d", s);

       endfunction

    endclass

 

 

    initial begin

       EightQueensPuzzle board;

       int count;

       board = new;

       count=0;

       fork

          begin

             assert(board.randomize());

             board.printMatrix(board.cb);

          end

          begin

            while (count < 100) begin

                clk(1);

                count++;

                $display("%m count %d", count);

            end

            disable fork;

          end

       join_any

       $finish;

    end

 

    initial begin

      clock = 1'b0;

      while (1) begin

        clock = #5 ~clock;

        $display($time, "clock = %b", clock);

      end

    end

 

    task clk(int numclk=0);

      repeat(numclk) begin

         @(posedge clock);

      end

    endtask

endprogram

 

`endif //P12__SV
