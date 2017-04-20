#include <iostream>

#include <vector>    // for vector

#include <list>      // for list

#include <cstdlib>

#include <algorithm> //need for shuffle

 

//Tic Tac Toe

#ifndef P40__CC

#define P40__CC

 

 

typedef unsigned int uint;

class semaphore {

    private:

        static uint keys;

    public:

        semaphore(uint keys) {

            semaphore::keys =  keys;

        }

        void get(uint i) {

            while (semaphore::keys > 0) {

                semaphore::keys = semaphore::keys - i;

                std::cout<<"Acquired Key:"<<semaphore::keys<<std::endl;

            }

        }

        void put(uint i) {

            semaphore::keys = semaphore::keys + i;

            std::cout<<"Returned Key:"<<semaphore::keys<<std::endl;

        }

};

 

typedef struct {

    uint i;

    uint j;

}ij;

 

class TicTacToe {

   private:

   char matrix[3][3];

   std::vector<uint> cellAvailable;

   ij ij_;

   uint whichCell;

   uint i,j;

   static uint id;

   public :

      TicTacToe ()  {

          id++;

//                cellAvailable = {0,1,2,3,4,5,6,7,8};

         for (int i = 0; i <9; i++) {

                   cellAvailable.push_back(i);

               }

         for (int i = 0; i<3; i++) {

             for (int j = 0; j<3; j++) {

                 matrix[i][j] =' ';

             }

         }

         std::cout<<"id: "<<id<<std::endl;

      }

  

      void printMe()  {

          for (int i = 0; i<3; i++) {

              for (int j = 0; j<3; j++) {

                  std::cout <<matrix[i][j];

              }

              std::cout<<std::endl;

          }

      }

 

      bool isMatch(char m)  {

          bool match;

          match  = 0;

          //col/row checks

          for (int i = 0; i<9; i++) {

              match =  (matrix[i][0] ==  matrix[i][1]);

              match &= (matrix[i][1] ==  matrix[i][2]);

              match &= (matrix[i][0] ==  m);

              if (match) return match;

          }

          for (int j = 0; j<9; j++) {

              match =  (matrix[0][j] ==  matrix[1][j]);

              match &= (matrix[1][j] ==  matrix[2][j]);

              match &= (matrix[0][j] ==  m);

              if (match) return match;

          }

          //diagnoal checks

          {

              match =  (matrix[0][0] ==  matrix[1][1]);

              match &= (matrix[1][1] ==  matrix[2][2]);

              match &= (matrix[0][0] ==  m);

              if (match) return match;

          }

 

          {

              match =  (matrix[0][2] ==  matrix[1][1]);

              match &= (matrix[1][1] ==  matrix[2][0]);

              match &= (matrix[0][2] ==  m);

              if (match) return match;

          }

          return match;

      }

 

     void markMe(uint i, uint j, char m) {

        matrix[i][j] =  m;

        std::cout<<"in markMe:"<<"m "<<m<<std::endl;

        printMe();

     }

 

     void play(char  m) {

         std::srand ( unsigned ( std::time(0) ) );

         //search for empty cell in TicTacToe, and randomize the cells

         std::random_shuffle(cellAvailable.begin(), cellAvailable.end());

         whichCell = this->cellAvailable[0]; //get first element and

         cellAvailable.erase(cellAvailable.begin()); //remove it from the list

         returnCellNum(i,j);

         std::cout<<"whichCell:"<<whichCell<<std::endl;

         std::cout<<"Cell:["<<i<<"]["<<j<<"]"<<std::endl;

         std::cout<<"m:"<<m<<std::endl;

         //randomly mark any cell

         markMe(i,j,m);

     }

 

     bool areWeDone() {

         bool done;

         done = ( cellAvailable.size() == 0 );

         if (done)

            std::cout <<"debug:Stalemate !"<<std::endl;

         return done;

     }

 

     void  returnCellNum(uint &i, uint &j) {

               switch(whichCell) {

                   case 0: { i = 0; j=0; } ; break;

                   case 1: { i = 0; j=1; } ; break;

                   case 2: { i = 0; j=2; } ; break;

                   case 3: { i = 1; j=0; } ; break;

                   case 4: { i = 1; j=1; } ; break;

                   case 5: { i = 1; j=2; } ; break;

                   case 6: { i = 2; j=0; } ; break;

                   case 7: { i = 2; j=1; } ; break;

                   case 8: { i = 2; j=2; } ; break;

               }

     }

 

};

 

   uint TicTacToe::id=0;

class Player {

    private:

        TicTacToe ticTacToe;

        std::string whoami;

        char m;

        semaphore sem;

        uint player_num;

    public:

 

        Player(TicTacToe ticTacToe, uint num):ticTacToe(ticTacToe), sem(1), player_num(num) {

            if (num == 1) {

                whoami = "player_1";

            } else if ( num == 2) {

                whoami = "player_2";

            } else {

                std::cout<<"Can't figure out player: "<<num <<std::endl;

            }

            this->ticTacToe = ticTacToe;

        }

 

        void set_my_board(TicTacToe &ticTacToe) {

            this->ticTacToe = ticTacToe;

        }

 

        void set_semaphore(semaphore &sem) {

            this->sem = sem;

        }

 

        void set_mark(char m) {

            this->m =  m;

            std::cout<<"debug: "<< whoami <<"'s mark is "<<this->m<<whoami <<std::endl;

        }

 

//        void play(bool &won) {

        bool play() {

            bool won;

            won = false;

            sem.get(1);

            std::cout<<"debug: "<<whoami <<"s's turn "<<std::endl;

            ticTacToe.play(this->m);

            //check if I won

            if (ticTacToe.isMatch(this->m)) {

                std::cout<<"debug: Game Over! "<<whoami<<" won"<<std::endl;

                won = true;

            }

            sem.put(1);

            std::cout<<"debug: TicTacToe:play won:  "<<won<<std::endl;

            return won;

        }

 

};

 

uint semaphore::keys = 1; //Need definition for static member, otherwise compilation error (undefined reference semaphore::keys) class Game {

    private:

        bool whoIsFirst;

        TicTacToe ticTacToe;

        semaphore sem;

        uint howManyGames;

        Player player_1, player_2;

    public:

        Game():sem(1),player_1(ticTacToe, 1), player_2(ticTacToe, 2)  {

            player_1.set_mark('O');

            player_2.set_mark('X');

            player_1.set_semaphore(sem);

            player_2.set_semaphore(sem);

            howManyGames = 3;

        }

 

 

        void playGame() {

            bool win1, win2;

            bool newGame;

 

            for (uint i=0; i<howManyGames; i++) {

                std::cout<<"debug:, New Tic-Tac-Toe Game: "<<i<<std::endl;

                player_1.set_my_board(ticTacToe);

                player_2.set_my_board(ticTacToe);

                while (1) {

                    win1=player_1.play();

                    if (win1) { newGame=1; printMe(); break; }

                    printMe();

                    win2=player_2.play();

                    if (win2) { newGame=1; printMe(); break;  }

                    printMe();

                    newGame = ticTacToe.areWeDone();

                    if (newGame) {

                        printMe();

                        std::cout<<"debug:, Starting new game"<<std::endl;

                        break; //go to new game

                    }

                }

            }

        }

 

        void printMe() {

            ticTacToe.printMe();

        }

};

 

int main () {

   //test it..

      Game game;

      game.playGame();

      return 0;

}

 

#endif //P40__CC
