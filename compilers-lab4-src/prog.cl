-- test class
class Test {
  name: String;

  init(n: String) : Test {
    name <- n
  };

  getName(): String {
    name
  };
};

-- testchild calss
class Testchild inherits Test {
  init(n: String) : Testchild {
    name <- "test"
  };

  func(): String {
    if name = "test" then
        "isTest"
    else 
        "not\
        Test"
    fi
  };
};

class Main {
  main(): Int {
    (*
        This is
        main
        function
    *)
    while 1 loop
        4 / 2  
    pool
  };
};