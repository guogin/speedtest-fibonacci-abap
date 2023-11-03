CLASS zcl_leibniz_formula DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: float TYPE decfloat16.
    METHODS: constructor IMPORTING rounds TYPE int8.

    METHODS: calculate_pi RETURNING VALUE(res) TYPE float.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: m_rounds TYPE int4.
ENDCLASS.



CLASS zcl_leibniz_formula IMPLEMENTATION.
  METHOD constructor.
    m_rounds = rounds.
  ENDMETHOD.

  METHOD calculate_pi.
    DATA: pi TYPE float VALUE 1,
          x  TYPE float VALUE 1.

    DATA: cnt TYPE int8 VALUE 2.

    WHILE cnt < m_rounds + 2.
      x = x * -1.
      pi = pi + x / ( 2 * conv float( cnt ) - 1 ).
      cnt += 1.
    ENDWHILE.

    pi = pi * 4.

    res = pi.
  ENDMETHOD.

ENDCLASS.