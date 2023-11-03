REPORT zp_fibonacci.

START-OF-SELECTION.

DATA: fib TYPE REF TO zcl_fibonacci.

fib = new zcl_fibonacci(  ).

DATA(res) = fib->recursive_noop( 30 ).

WRITE: / res->to_string(  ).