-- test class
class Test {
  name: String;

  init(n: String) : Test {
    name <- n;
    self;
  };

  getName(): String {
    name;
  };
};

-- testchild calss
class Testchild inherits Test {
  init(n: String) : Testchild {
    name <- n + "test";
    self; 
  };

  func(): String {
    if name = "test" then
        "isTest"
    else 
        "notTest"
    fi
  };
};

class Main {
  main() {
    (*
        This is
        main
        function
    *)
        (let i : Int <- 0 in
            while i < 10 loop
                {
                    i <- i + 1;    
                pool
        );
  };
  testcl : Testchild;
  testcl <- (new Testchild).init("Name");
  testcl.func();
};