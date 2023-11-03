CLASS zcl_fibonacci DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS: iterative
      IMPORTING counter    TYPE i
      RETURNING VALUE(ret) TYPE REF TO cl_abap_bigint.

    METHODS: recursive
      IMPORTING counter    TYPE i
      RETURNING VALUE(ret) TYPE REF TO cl_abap_bigint.

    METHODS: recursive_noop
      IMPORTING counter    TYPE i
      RETURNING VALUE(ret) TYPE REF TO cl_abap_bigint.
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES: BEGIN OF ts_memory_item,
             index TYPE i,
             value TYPE REF TO cl_abap_bigint,
           END OF ts_memory_item.
    TYPES: tt_memory TYPE SORTED TABLE OF ts_memory_item WITH UNIQUE KEY index.

    METHODS: _recursive
      IMPORTING counter    TYPE i
      CHANGING  memo       TYPE tt_memory
      RETURNING VALUE(ret) TYPE REF TO cl_abap_bigint.
ENDCLASS.



CLASS zcl_fibonacci IMPLEMENTATION.
  METHOD iterative.
    DATA: n0  TYPE REF TO cl_abap_bigint,
          n1  TYPE REF TO cl_abap_bigint,
          num TYPE REF TO cl_abap_bigint.

    IF counter <= 2.
      ret = cl_abap_bigint=>factory_from_int4( counter ).
      RETURN.
    ENDIF.

    n0 = cl_abap_bigint=>factory_from_int4( 0 ).
    n1 = cl_abap_bigint=>factory_from_int4( 1 ).
    num = cl_abap_bigint=>factory_from_int4( 0 ).

    DATA: nc TYPE i VALUE 2.

    WHILE nc <= counter.
      num = n0->add( n1 ).

      n0 = n1.
      n1 = num.

      nc += 1.
    ENDWHILE.

    ret = num.
  ENDMETHOD.

  METHOD recursive.
    DATA: memory_area TYPE tt_memory.

    ret = _recursive(
            EXPORTING
              counter = counter
            CHANGING
              memo    = memory_area
          ).
    RETURN.
  ENDMETHOD.

  METHOD _recursive.
    IF counter < 2.
      DATA: element TYPE ts_memory_item.
      element-index = counter.
      element-value = cl_abap_bigint=>factory_from_int4( counter ).
      INSERT element INTO TABLE memo.

      ret = element-value.
      RETURN.
    ENDIF.

    READ TABLE memo WITH KEY index = counter ASSIGNING FIELD-SYMBOL(<fs_element>).
    IF sy-subrc = 0 AND <fs_element>-value IS BOUND.
      ret = <fs_element>-value.
      RETURN.
    ENDIF.

    DATA: n1 TYPE REF TO cl_abap_bigint,
          n2 TYPE REF TO cl_abap_bigint.

    n1 = me->_recursive( EXPORTING counter = counter - 1 CHANGING memo = memo )->clone(  ).
    n2 = me->_recursive( EXPORTING counter = counter - 2 CHANGING memo = memo )->clone(  ).

    CLEAR: element.
    element-index = counter.
    element-value = n1->add( n2 ).
    INSERT element INTO TABLE memo.

    ret = element-value.
    RETURN.
  ENDMETHOD.

  METHOD recursive_noop.
    IF counter < 2.
      ret = cl_abap_bigint=>factory_from_int4( counter ).
      RETURN.
    ENDIF.

    DATA: n1 TYPE REF TO cl_abap_bigint,
          n2 TYPE REF TO cl_abap_bigint.

    n1 = me->recursive_noop( counter - 1 )->clone(  ).
    n2 = me->recursive_noop( counter - 2 )->clone(  ).

    ret = n1->add( n2 ).
    RETURN.
  ENDMETHOD.

ENDCLASS.