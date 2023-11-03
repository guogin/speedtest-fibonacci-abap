REPORT zp_fibonacci.

START-OF-SELECTION.

DATA: fib TYPE REF TO zcl_fibonacci.

fib = new zcl_fibonacci(  ).

DATA: res TYPE REF TO cl_abap_bigint.

res = fib->recursive( 100 ).

WRITE: / res->to_string(  ).