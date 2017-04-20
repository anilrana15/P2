//Conway's Game of life

//from wikipedia: https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

//1. Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.

//2. Any live cell with two or three live neighbours lives on to the next generation.

//3. Any live cell with more than three live neighbours dies, as if by overpopulation.

//4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

 

#include <iostream>

#include <cstdlib> //for rand() ..

//using namespace std; //to avoid error such as "P91.cc:24: error: string does not name a type"

//or better use std::string like now.

 

#ifndef P91__CC

#define P91__CC

 

 

typedef struct  {

   unsigned int R;

   unsigned int C;

   bool DoA;

}N;

 

class conways_game_of_life {

              private:

                 N ** matrix, ** matrix_nxt_gen; //better use container

                 std::string  initial_pattern;

                 int unsigned dim;

                 int unsigned howManyGen;

 

        public :

                 conways_game_of_life (unsigned int dim, std::string name="blinker"):dim(dim), initial_pattern(name), howManyGen(20) {

                    //rows

                    matrix = new N* [dim];

                    matrix_nxt_gen = new N* [dim];

 

                    //column

                    for (int i =0; i< dim; i++) {

                              matrix[i]         = new N [dim];

                              matrix_nxt_gen[i] = new N [dim];

                    }

 

                    //init all cells

                    for (int i =0; i< dim; i++) {

                                   for (int j =0; j< dim; j++) {

                                            matrix[i][j].DoA = false;

                                   }

                    }

 

                    set_seed(name);

                 }

 

                 ~conways_game_of_life () {

                              delete [] matrix;

                              delete [] matrix_nxt_gen;

                 }

 

                 void set_gen(unsigned int gen) {

                                howManyGen = gen;

                 }

 

                 void set_seed(std::string name) {

                                initial_pattern = name;

                 }

 

                 void print_matrix() {

                                std::cout<<"Printing matrix"<<std::endl; //new line

                    for (int i =0; i< dim; i++) {

                                   for (int j =0; j< dim; j++) {

                                               std::cout<< matrix[i][j].DoA;

                                   }

                              std::cout<<std::endl; //new line

                    }

                 }

                 void print_matrix_nxt_gen() {

                                std::cout<<"Printing matrix_nxt_gen"<<std::endl; //new line

                    for (int i =0; i< dim; i++) {

                                   for (int j =0; j< dim; j++) {

                                               std::cout<< matrix_nxt_gen[i][j].DoA;

                                   }

                              std::cout<<std::endl; //new line

                    }

                 }

 

                 void generation() {

                    unsigned int g,k,l,o,p ;

                    unsigned int live_cnt;

 

                    g=1;

                    live_cnt = 0;

                    while (g<=howManyGen) {

                              std::cout<<"This is generation:"<< g <<std::endl;

                              for (int i=0; i<dim; i++) {

                                 for (int j=0; j<dim; j++) {

                                    //discover neigbhors, from -1 to +1 in every direction ...

                                    //check for boundary conditions

                                    if (i-1>=0) k = i-1; else k = 0;

                                    if (j-1>=0) l = j-1; else l = 0;

 

                                    if (i+1 >(dim-1)) o = dim-1; else o = i+1;

                                    if (j+1 >(dim-1)) p = dim-1; else p = j+1;

 

                                    for (int m = k; m<=o; m++) {

                                       for (int n =l; n<=p; n++) {

                                           //count my neighbours lives except mine

                                           if (!(i==m && j==n)) {

                                                                if (matrix[m][n].DoA == true) live_cnt += matrix[m][n].DoA;

                                                 }

                                       }

                                    }

                                    if (matrix[i][j].DoA == true) {

                                       matrix_nxt_gen[i][j].DoA = ! ( (live_cnt < 2) || (live_cnt > 3) );

                                       matrix_nxt_gen[i][j].DoA = (live_cnt == 2 || live_cnt == 3);

                                    } else {

                                       //dead lives if live_cnt == 3

                                       matrix_nxt_gen[i][j].DoA = (live_cnt == 3);

                                    }

                                    live_cnt = 0;

                                 }

                              }

                              g++;

                              print_matrix_nxt_gen();

                              for (int i=0; i<dim; i++) {

                                 for (int j=0; j<dim; j++) {

                                            matrix[i][j] = matrix_nxt_gen[i][j];

                                 }

                              }

                              init_matrix(matrix_nxt_gen);

                    }

                 }

 

                 void init_matrix(N **n) {

                    for (int i =0; i< dim; i++) {

                                   for (int j =0; j< dim; j++) {

                                            n[i][j].R   = 0;

                                            n[i][j].C   = 0;

                                            n[i][j].DoA = false;

                                   }

                    }

                 }

 

 

                 void initialize() {

                    std::string name;

                    name = initial_pattern;

                    std::cout<<"Selected "<<name <<" pattern for initial seed"<<std::endl;

 

                    if (name == "blinker") {

                              matrix[1][2].DoA = true  ;

                              matrix[2][2].DoA = true  ;

                              matrix[3][2].DoA = true  ;

                    } else if  (name == "toad") {

                              matrix[2][2].DoA = true  ;

                              matrix[2][3].DoA = true  ;

                              matrix[2][4].DoA = true  ;

                              matrix[3][1].DoA = true  ;

                              matrix[3][2].DoA = true  ;

                              matrix[3][3].DoA = true  ;

                    } else if (name == "beacon") {

                              matrix[1][1].DoA = true  ;

                              matrix[1][2].DoA = true  ;

                              matrix[2][1].DoA = true  ;

                              matrix[2][2].DoA = true  ;

                              matrix[3][3].DoA = true  ;

                              matrix[3][4].DoA = true  ;

                              matrix[4][3].DoA = true  ;

                              matrix[4][4].DoA = true  ;

                    } else if (name == "glider") {

                              matrix[0][2].DoA = true  ;

                              matrix[1][0].DoA = true  ;

                              matrix[1][2].DoA = true  ;

                              matrix[2][1].DoA = true  ;

                              matrix[2][2].DoA = true  ;

                    }

                 }

 

};

 

   //test it ..

int main(int argc, char * argv[]) {

      unsigned int  gen;

      conways_game_of_life  game_of_life(10, "glider");

      int i=0;

      std::string args;

      if ( argc > 3)  {

                    std::cout<<"More than one argument!"<<std::endl;

                    return 1;

      } else if (argc == 2) {

                    std::cout<<"The input argument is " <<argv[1] <<std::endl;

                    game_of_life.set_seed(argv[1]);

      } else if (argc == 3) {

                    std::cout<<"The input argument is " <<argv[1] <<argv[2] <<std::endl;

                    game_of_life.set_seed(argv[1]);

                    game_of_life.set_gen(atoi(argv[2]));

      }

      game_of_life.initialize();

      game_of_life.print_matrix();

      game_of_life.generation();

      return 0;

}

 

#endif //P91__CC

//Conway's Game of life

//from wikipedia: https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

//1. Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.

//2. Any live cell with two or three live neighbours lives on to the next generation.

//3. Any live cell with more than three live neighbours dies, as if by overpopulation.

//4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

 

#include <iostream>

#include <vector>

#include <cstdlib> //for rand() ..

//using namespace std; //to avoid error such as "P91.cc:24: error: string does not name a type"

//or better use std::string like now.

//TODO:

 

#ifndef P91__CC

#define P91__CC

 

 

typedef struct  {

   unsigned int R;

   unsigned int C;

   bool DoA;

}N;

 

class conways_game_of_life {

              private:

                 std::vector< std::vector<N> > matrix, matrix_nxt_gen;

                 std::string  initial_pattern;

                 int unsigned dim;

                 int unsigned howManyGen;

 

        public :

                 conways_game_of_life (unsigned int dim, std::string name="blinker"):dim(dim), initial_pattern(name), howManyGen(20) {

                    matrix.resize(dim);

                    matrix_nxt_gen.resize(dim);

 

                    //init all cells

                    for (int i =0; i< dim; i++) {

                                   for (int j =0; j< dim; j++) {

                                            matrix[i][j].DoA = false;

                                   }

                    }

 

                    set_seed(name);

                 }

 

                 ~conways_game_of_life () {

                 }

 

                 void set_gen(unsigned int gen) {

                                howManyGen = gen;

                 }

 

                 void set_seed(std::string name) {

                                initial_pattern = name;

                 }

 

                 void print_matrix() {

                                std::cout<<"Printing matrix"<<std::endl; //new line

                    for (int i =0; i< dim; i++) {

                                   for (int j =0; j< dim; j++) {

                                               std::cout<< matrix[i][j].DoA;

                                   }

                              std::cout<<std::endl; //new line

                    }

                 }

                 void print_matrix_nxt_gen() {

                                std::cout<<"Printing matrix_nxt_gen"<<std::endl; //new line

                    for (int i =0; i< dim; i++) {

                                   for (int j =0; j< dim; j++) {

                                               std::cout<< matrix_nxt_gen[i][j].DoA;

                                   }

                              std::cout<<std::endl; //new line

                    }

                 }

 

                 void generation() {

                    unsigned int g,k,l,o,p ;

                    unsigned int live_cnt;

 

                    g=1;

                    live_cnt = 0;

                    while (g<=howManyGen) {

                              std::cout<<"This is generation:"<< g <<std::endl;

                              for (int i=0; i<dim; i++) {

                                 for (int j=0; j<dim; j++) {

                                    //discover neigbhors, from -1 to +1 in every direction ...

                                    //check for boundary conditions

                                    if (i-1>=0) k = i-1; else k = 0;

                                    if (j-1>=0) l = j-1; else l = 0;

 

                                    if (i+1 >(dim-1)) o = dim-1; else o = i+1;

                                    if (j+1 >(dim-1)) p = dim-1; else p = j+1;

 

                                    for (int m = k; m<=o; m++) {

                                       for (int n =l; n<=p; n++) {

                                           //count my neighbours lives except mine

                                           if (!(i==m && j==n)) {

                                                                if (matrix[m][n].DoA == true) live_cnt += matrix[m][n].DoA;

                                                 }

                                       }

                                    }

                                    if (matrix[i][j].DoA == true) {

                                       matrix_nxt_gen[i][j].DoA = ! ( (live_cnt < 2) || (live_cnt > 3) );

                                       matrix_nxt_gen[i][j].DoA = (live_cnt == 2 || live_cnt == 3);

                                    } else {

                                       //dead lives if live_cnt == 3

                                       matrix_nxt_gen[i][j].DoA = (live_cnt == 3);

                                    }

                                    live_cnt = 0;

                                 }

                              }

                              g++;

                              print_matrix_nxt_gen();

//                         for (int i=0; i<matrix_nxt_gen.size(); i++) {

//                             for (int j=0; j<matrix_nxt_gen[i].size(); j++) {

//                                        matrix[i][j] = matrix_nxt_gen[i][j];

                                

                              for (int i=0; i<dim; i++) {

                                 for (int j=0; j<dim; j++) {

//                                        matrix[i][j] = matrix_nxt_gen[i][j];

                                 }

                              }

//                         init_matrix(matrix_nxt_gen);

                              init_matrix();

                    }

                 }

 

//              void init_matrix(std::vector<std::vector<N> > &mtx) {

                 void init_matrix() {

                              for (int i=0; i<dim; i++) {

                                 for (int j=0; j<dim; j++) {

//                                        matrix_nxt_gen[i][j].R = 0;

//                                        matrix_nxt_gen[i][j].C = 0;

//                                        matrix_nxt_gen[i][j].DoA = false;

                                 }

                              }

                 }

 

 

                 void initialize() {

                    std::string name;

                    name = initial_pattern;

                    std::cout<<"Selected "<<name <<" pattern for initial seed"<<std::endl;

 

                    if (name == "blinker") {

                              matrix[1][2].DoA = true  ;

                              matrix[2][2].DoA = true  ;

                              matrix[3][2].DoA = true  ;

                    } else if  (name == "toad") {

                              matrix[2][2].DoA = true  ;

                              matrix[2][3].DoA = true  ;

                              matrix[2][4].DoA = true  ;

                              matrix[3][1].DoA = true  ;

                              matrix[3][2].DoA = true  ;

                              matrix[3][3].DoA = true  ;

                    } else if (name == "beacon") {

                              matrix[1][1].DoA = true  ;

                              matrix[1][2].DoA = true  ;

                              matrix[2][1].DoA = true  ;

                              matrix[2][2].DoA = true  ;

                              matrix[3][3].DoA = true  ;

                              matrix[3][4].DoA = true  ;

                              matrix[4][3].DoA = true  ;

                              matrix[4][4].DoA = true  ;

                    } else if (name == "glider") {

                              matrix[0][2].DoA = true  ;

                              matrix[1][0].DoA = true  ;

                              matrix[1][2].DoA = true  ;

                              matrix[2][1].DoA = true  ;

                              matrix[2][2].DoA = true  ;

                    }

                 }

 

};

 

   //test it ..

int main(int argc, char * argv[]) {

      unsigned int  gen;

      conways_game_of_life  game_of_life(10, "glider");

      int i=0;

      std::string args;

      if ( argc > 3)  {

                    std::cout<<"More than one argument!"<<std::endl;

                    return 1;

      } else if (argc == 2) {

                    std::cout<<"The input argument is " <<argv[1] <<std::endl;

                    game_of_life.set_seed(argv[1]);

      } else if (argc == 3) {

                    std::cout<<"The input argument is " <<argv[1] <<argv[2] <<std::endl;

                    game_of_life.set_seed(argv[1]);

                    game_of_life.set_gen(atoi(argv[2]));

      }

      game_of_life.initialize();

      game_of_life.print_matrix();

      game_of_life.generation();

      return 0;

}

 

#endif //P91__CC
