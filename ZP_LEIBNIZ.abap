REPORT zp_leibniz.

START-OF-SELECTION.

DATA: leibniz TYPE REF TO zcl_leibniz_formula.

leibniz = new zcl_leibniz_formula( 100000000 ).

DATA(res) = leibniz->calculate_pi(  ).

WRITE: / res.