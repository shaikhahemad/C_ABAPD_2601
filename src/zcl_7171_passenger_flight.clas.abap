CLASS zcl_7171_passenger_flight DEFINITION
  PUBLIC
  INHERITING FROM zcl_7171_flight
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_carrier TYPE /dmo/carrier_id
                iv_conn    TYPE /dmo/connection_id
                iv_plane   TYPE /dmo/plane_type_id
      RAISING   zcx_c_abapd_no_connection.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA seats_max TYPE /dmo/plane_seats_max.
ENDCLASS.



CLASS ZCL_7171_PASSENGER_FLIGHT IMPLEMENTATION.


  METHOD constructor.
    super->constructor( iv_carrier = iv_carrier iv_conn = iv_conn iv_plane = iv_plane ).
    SELECT SINGLE FROM zi_cabapd_passenger
    FIELDS MaximumSeats
      WHERE PlaneTypeId = @iv_plane
      INTO @me->seats_max.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW zcx_c_abapd_no_connection( ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
