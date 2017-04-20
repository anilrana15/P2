//Linked list (single, double, circular, skip list etc ..)

`ifndef P77__SV

`define P77__SV

 

program P_77;

 

  class node ;

      string whoami;

      node next_node;

      node prv_node;

 

      function new(string s="");

         whoami = s;

         next_node = null;

         prv_node  = null;

      endfunction

 

      function void printme();

         $display("whoami %0s", this.whoami);

      endfunction

 

      function string  get_data();

         return whoami;

      endfunction

 

      function void  set_data(string whoami);

         this.whoami = whoami;

      endfunction

 

      function node get_next();

         return next_node;

      endfunction

 

      function void set_next(node next_node);

         this.next_node = next_node;

      endfunction

 

      function node get_prv();

         return prv_node;

      endfunction

 

      function void set_prv(node prv_node);

         this.prv_node = prv_node;

      endfunction

 

  endclass

 

 

  class singly_ll;

     node head;

 

    function new();

      head = null;

    endfunction

 

    //first add it at head and the point head to it(latest member)

    function void add_node(node n_);

       n_.set_next(this.head);

       this.head = n_;

    endfunction

 

   //remove node. string data item is searched, as node has string as data item

    function void remove_node(node n_);

       node n, n_prv;

       string whoami;

       bit found;

 

       found   = 0;

       n      = this.head;

       n_prv  = null;

       while (!found) begin

          if (n.get_data() == n_.get_data())  begin

             found = 1;

          end else begin

             n_prv = n;

             n = n.get_next();

          end

       end

 

       if (n_prv == null) begin

          this.head = n.get_next();

       end else begin

          n_prv.set_next(n.get_next());

       end

    endfunction

 

   //if first argument is not provided insert at the beginging

    function void insert_node(node n_=null, node new_node);

       $display("Inserting %0s after %0s", new_node.whoami, n_.whoami);

       if (n_ == null) begin

          add_node(new_node);

       end else begin

          //get current next node of n_

          new_node.set_next(n_.get_next()); //next node of new_node points to n_.next

          n_.set_next(new_node);

       end

    endfunction

 

    task printList();

       node n;

       n = this.head;

       while (n != null) begin

          n.printme();

          n = n.get_next();

       end

    endtask

  endclass

 

  class doubly_ll;

     node head;

     node tail;

 

    function new();

      head = null;

      tail = null;

    endfunction

 

    //first add it at head and the point head to it(latest member)

    function void add_node(node n_);

       n_.set_next(this.head);

       this.head = n_;

    endfunction

 

   //remove node. string data item is searched, as node has string as data item

    function void remove_node(node n_);

       node n, n_prv;

       string whoami;

       bit found;

 

       found   = 0;

       n      = this.head;

       n_prv  = null;

       while (!found) begin

          if (n.get_data() == n_.get_data())  begin

             found = 1;

          end else begin

             n_prv = n;

             n = n.get_next();

          end

       end

 

       if (n_prv == null) begin

          this.head = n.get_next();

       end else begin

          n_prv.set_next(n.get_next());

       end

    endfunction

 

   //if first argument is not provided insert at the beginging

    function void insert_node_after(node n_=null, node new_node);

       node next_node_of_n_;

       next_node_of_n_ = n_.get_next();

 

       $display("Inserting %0s after %0s", new_node.whoami, n_.whoami);

       if (n_ == null) begin

          head = new_node;

          tail = new_node;

          new_node.set_next(null);

          new_node.set_prv(null);

       end else begin

          //set previous node of new node to node after which it wants to connect

          new_node.set_prv(n_);

          $display("debug:%0d, n_.whoami=%0s, new_node.whoami=%0s", `__LINE__, n_.whoami, new_node.whoami);

          //set next node of new node to next of node after which it wants to connect

          new_node.set_next(next_node_of_n_);

          $display("debug:%0d, next_node_of_n_.whoami=%0s", `__LINE__, next_node_of_n_.whoami);

          //set previous node of next node of node to new node

          next_node_of_n_.set_prv(new_node);

          //set next node of current node to new new_node

          n_.set_next(new_node);

       end

    endfunction

 

    function void insert_node_before(node n_=null, node new_node);

       node prv_node_of_n_;

       prv_node_of_n_ = n_.get_prv();

 

       $display("Inserting %0s before %0s", new_node.whoami, n_.whoami);

 

       if (n_ == null) begin

          head = new_node;

          tail = new_node;

          new_node.set_next(null);

          new_node.set_prv(null);

       end else begin

          //get current next node of n_

          new_node.set_prv(prv_node_of_n_);

          new_node.set_next(n_);

          prv_node_of_n_.set_next(new_node);

          n_.set_prv(new_node);

       end

    endfunction

 

    task printList();

       node n;

       n = this.head;

       while (n != null) begin

          n.printme();

          n = n.get_next();

       end

    endtask

 

  endclass:doubly_ll

 

  class circular_ll;

     node head;

 

    function new();

      head = null;

    endfunction

 

    //first add it at head and the point head to it(latest member)

    function void add_node(node n_);

  

       n_.set_next(n_);

       n_.set_prv(n_);

       this.head = n_;

    endfunction

 

   //remove node. string data item is searched, as node has string as data item

    function void remove_node(node n_);

       node n, n_prv;

       string whoami;

       bit found;

 

       found   = 0;

       n      = this.head;

       n_prv  = null;

       while (!found) begin

          if (n.get_data() == n_.get_data())  begin

             found = 1;

          end else begin

             n_prv = n;

             n = n.get_next();

          end

       end

 

       if (n_prv == null) begin

          this.head = n.get_next();

       end else begin

          n_prv.set_next(n.get_next());

       end

    endfunction

 

   //if first argument is not provided insert at the beginging

    function void insert_node_after(node n_=null, node new_node);

       node next_node_of_n_;

       if (n_ != null) next_node_of_n_ = n_.get_next();

 

       if (n_ != null) $display("Inserting %0s after %0s", new_node.whoami, n_.whoami);

       if (n_ == null) begin

          new_node.set_next(new_node);

          new_node.set_prv(new_node);

          head = new_node;

       end else begin

          //set previous node of new node to node after which it wants to connect

          new_node.set_next(n_.get_next);

          new_node.set_prv(n_);

          next_node_of_n_.set_prv(new_node);

          n_.set_next(new_node);

       end

    endfunction

 

    function void insert_node_before(node n_=null, node new_node);

       node prv_node_of_n_;

       prv_node_of_n_ = n_.get_prv();

 

       $display("Inserting %0s before %0s", new_node.whoami, n_.whoami);

 

       if (n_ == null) begin

          head = new_node;

          new_node.set_next(null);

          new_node.set_prv(null);

       end else begin

          //get current next node of n_

          new_node.set_prv(prv_node_of_n_);

          new_node.set_next(n_);

          prv_node_of_n_.set_next(new_node);

          n_.set_prv(new_node);

       end

    endfunction

 

    task printList();

       node n;

       n = this.head;

       do begin

           n.printme();

           n = n.get_next();

       end while (n.get_data != this.head.get_data());

 

    endtask

 

  endclass:circular_ll

 

 

   //test ..

 

   //single linked list

   task singly_ll_test;

      singly_ll sll;

      node n_, n__, n_1, n_2, n_12;

      int unsigned i;

      int unsigned numNodes;

 

      if (!($value$plusargs("numNodes=%0d",numNodes)) )  numNodes =  5;

 

      sll = new;

 

      i = 0;

      while (i<numNodes) begin

         n_ = new($sformatf("%0d_in_list",i));

         if (i == 12) n_12 = n_; //saving the 12th handle

         sll.add_node(n_);

         i++;

      end

      sll.printList();

      n__ = new("11_in_list");

      sll.remove_node(n__);

      sll.printList();

      n_1 = new("10_in_list");

      n_1 = n_12;

      n_2 = new("11_in_list");

      sll.insert_node(n_1, n_2);

      sll.printList();

   endtask

 

   //double linked list

   task doubly_ll_test;

      doubly_ll dll;

      node n_, n__, n_1, n_2, n_12;

      int unsigned i;

      int unsigned numNodes;

 

      if (!($value$plusargs("numNodes=%0d",numNodes)) )  numNodes =  5;

 

      dll = new;

 

      i = 0;

      while (i<numNodes) begin

         n_ = new($sformatf("%0d_in_list",i));

         if (i == 12) n_12 = n_; //saving the 12th handle

         dll.add_node(n_);

         i++;

      end

      dll.printList();

      n__ = new("11_in_list");

      dll.remove_node(n__);

      dll.printList();

      n_1 = new("10_in_list");

      n_1 = n_12;

      n_2 = new("11_in_list");

      dll.insert_node_after(n_1, n_2);

      dll.printList();

   endtask

 

   //circular linked list

   task circular_ll_test;

      circular_ll cll;

      node n_, n__, n_1, n_2, n_12, n_prev;

      int unsigned i;

      int unsigned numNodes;

 

      if (!($value$plusargs("numNodes=%0d",numNodes)) )  numNodes =  5;

 

      cll = new;

 

      i = 0;

      while (i<numNodes) begin

         n_prev =n_;

         n_ = new($sformatf("%0d_in_list",i));

         if (i == 12) n_12 = n_; //saving the 12th handle

//         if (i==0) cll.insert_node_after(null, n_);

         cll.insert_node_after(n_prev, n_);

         i++;

      end

      cll.printList();

      n__ = new("11_in_list");

      cll.remove_node(n__);

      cll.printList();

      n_1 = new("10_in_list");

      n_1 = n_12;

      n_2 = new("11_in_list");

      cll.insert_node_after(n_1, n_2);

      cll.printList();

   endtask

 

   initial begin

//      singly_ll_test();

//      doubly_ll_test();

      circular_ll_test();

   end

 

endprogram

 

`endif //P77__SV
