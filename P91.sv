//Conway's Game of life

//from wikipedia: https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

//1. Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.

//2. Any live cell with two or three live neighbours lives on to the next generation.

//3. Any live cell with more than three live neighbours dies, as if by overpopulation.

//4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

 

`ifndef P91__SV

`define P91__SV

 

typedef struct {

   int unsigned R;

   int unsigned C;

   bit DoA;

} N;

 

program P_91;

 

   class conways_game_of_life;

      N matrix[][], matrix_nxt_gen[][];

      string  which_pattern;

 

      function new(int unsigned dim=6, string name="");

         matrix = new[dim];

         matrix_nxt_gen = new[dim];

 

         foreach (matrix[i]) begin

            matrix[i] = new[dim];

         end

         foreach (matrix_nxt_gen[i]) begin

            matrix_nxt_gen[i] = new[dim];

         end

 

         foreach (matrix[i,j]) begin

            matrix[i][j].DoA = 1'b0;

         end

 

         this.which_pattern = name;

         initialize(which_pattern);

      endfunction

 

      function automatic void generation(int unsigned gen);

         int unsigned i,k,l ;

         int unsigned live_cnt;

 

         i=1;

         while (i<=gen) begin

            $display("This is generation %0d", i);

            foreach (matrix[i,j]) begin

               //discover neigbhors from -1 to +1 in every direction...

               //check for boundary conditions

               if (i-1>=0) k = i-1; else k = 0;

               if (j-1>=0) l = j-1; else l = 0;

               for (int m = k; m<=i+1; m++) begin

                  for (int n =l; n<=j+1; n++) begin

                      //count my neighbours lives except mine

                      if (!(i==m && j==n))  live_cnt += (matrix[m][n].DoA);

                  end

               end

               if (matrix[i][j].DoA) begin

                  matrix_nxt_gen[i][j].DoA = ! ( (live_cnt < 2) || (live_cnt > 3) );

                  matrix_nxt_gen[i][j].DoA = (live_cnt == 2 || live_cnt == 3);

               end else begin

                  //dead lives if live_cnt == 3

                  matrix_nxt_gen[i][j].DoA = (live_cnt == 3);

               end

               live_cnt = 0;

            end

            i++;

            print_matrix(matrix_nxt_gen);

            matrix = matrix_nxt_gen;

            init_matrix(matrix_nxt_gen);

         end

      endfunction

 

      function automatic void init_matrix(N n[][]);

          foreach (n[i,j]) begin

             n[i][j]     = '{0,0,0};

          end

      endfunction

 

      function automatic void print_matrix(N n[][]);

         foreach (n[i,]) begin

            foreach (n[j]) begin

               $write("%0b ", n[i][j].DoA);

            end

            $display;

         end

      endfunction

 

      function void initialize(string name="");

 

         if (name == "") begin

            if (!($value$plusargs("name=%0s", name))) begin

               name = "blinker";

            end

         end

 

         $display("Selected %0s pattern for initial seed", name);

 

         if (name == "blinker") begin

            matrix[1][2].DoA = 1'b1;  ;

            matrix[2][2].DoA = 1'b1;  ;

            matrix[3][2].DoA = 1'b1;  ;

         end else if (name == "toad") begin

            matrix[2][2].DoA = 1'b1;  ;

            matrix[2][3].DoA = 1'b1;  ;

            matrix[2][4].DoA = 1'b1;  ;

            matrix[3][1].DoA = 1'b1;  ;

            matrix[3][2].DoA = 1'b1;  ;

            matrix[3][3].DoA = 1'b1;  ;

         end else if (name == "beacon") begin

            matrix[1][1].DoA = 1'b1;  ;

            matrix[1][2].DoA = 1'b1;  ;

            matrix[2][1].DoA = 1'b1;  ;

            matrix[2][2].DoA = 1'b1;  ;

            matrix[3][3].DoA = 1'b1;  ;

            matrix[3][4].DoA = 1'b1;  ;

            matrix[4][3].DoA = 1'b1;  ;

            matrix[4][4].DoA = 1'b1;  ;

         end else if (name == "glider") begin

            matrix[0][2].DoA = 1'b1;  ;

            matrix[1][0].DoA = 1'b1;  ;

            matrix[1][2].DoA = 1'b1;  ;

            matrix[2][1].DoA = 1'b1;  ;

            matrix[2][2].DoA = 1'b1;  ;

         end

      endfunction

   endclass: conways_game_of_life

 

   //test it ..

   initial begin

      int unsigned gen;

      conways_game_of_life  game_of_life;

 

      if (!($value$plusargs("gen=%0d", gen))) begin

         gen = 3;

      end

 

      game_of_life = new(10);

      game_of_life.print_matrix(game_of_life.matrix);

      game_of_life.generation(gen);

   end

 

  

endprogram

 

`endif //P91__SV
