CLASS zcl_7171_flight DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA carrier_id    TYPE /dmo/carrier_id READ-ONLY .
    DATA connection_id TYPE /dmo/connection_id READ-ONLY .
    DATA airport_from  TYPE /dmo/airport_from_id READ-ONLY .
    DATA airport_to    TYPE /dmo/airport_to_id READ-ONLY .
    METHODS constructor
      IMPORTING iv_carrier TYPE /dmo/carrier_id
                iv_conn    TYPE /dmo/connection_id
                iv_plane   TYPE /dmo/plane_type_id
      RAISING   zcx_c_abapd_no_connection.
  PROTECTED SECTION.
    DATA plane_type TYPE /dmo/plane_type_id .
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_7171_FLIGHT IMPLEMENTATION.


  METHOD constructor.
    me->carrier_id    = iv_carrier.
    me->connection_id = iv_conn.
    me->plane_type    = iv_plane.

    SELECT SINGLE FROM /dmo/connection
    FIELDS airport_from_id, airport_to_id
      WHERE carrier_id    = @iv_carrier AND connection_id = @iv_conn
      INTO (@me->airport_from, @me->airport_to).

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW zcx_c_abapd_no_connection( ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
