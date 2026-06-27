CLASS lhc_zr_z7171travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Travel
        RESULT result,
      setInitialStatus FOR DETERMINE ON SAVE
        IMPORTING keys FOR Travel~setInitialStatus.
ENDCLASS.

CLASS lhc_zr_z7171travel IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD setInitialStatus.
    READ ENTITIES OF zr_z7171travel IN LOCAL MODE
      ENTITY Travel
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_travels).

    DELETE lt_travels WHERE Status IS NOT INITIAL.
    CHECK lt_travels IS NOT INITIAL.

    MODIFY ENTITIES OF zr_z7171travel IN LOCAL MODE
      ENTITY Travel
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR travel IN lt_travels ( %tky      = travel-%tky
                                                Status = 'N' ) )
      REPORTED DATA(lt_reported).

    reported = CORRESPONDING #( DEEP lt_reported ).
  ENDMETHOD.

ENDCLASS.
