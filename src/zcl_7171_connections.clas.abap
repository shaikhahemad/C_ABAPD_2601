CLASS zcl_7171_connections DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS get_connections
      IMPORTING i_departure          TYPE /dmo/airport_from_id
      RETURNING VALUE(r_connections) TYPE  zcert_connections.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_7171_CONNECTIONS IMPLEMENTATION.


  METHOD get_connections.
    DATA(lv_dash) = CONV /dmo/airport_from_id( '-' ).
    " Part 1: Select Direct Flights
    SELECT FROM /dmo/connection
      FIELDS carrier_id,
             airport_from_id,
             airport_to_id,
              @lv_dash AS airport_via_id
      WHERE airport_from_id = @i_departure

    UNION ALL

    " Part 2: Select One-Stop Connections (Same Airline)
    SELECT FROM /dmo/connection AS l1
      INNER JOIN /dmo/connection AS l2
        ON  l1~carrier_id     = l2~carrier_id
        AND l1~airport_to_id   = l2~airport_from_id
      FIELDS l1~carrier_id,
             l1~airport_from_id,
             l2~airport_to_id,
             l1~airport_to_id AS airport_via_id
      WHERE l1~airport_from_id = @i_departure
        AND l2~airport_to_id   <> @i_departure " Exclude return flights

    INTO TABLE @r_connections.

    " Professional touch: Sort by Carrier and Destination
    SORT r_connections BY carrier_id airport_to_id.
  ENDMETHOD.
ENDCLASS.
