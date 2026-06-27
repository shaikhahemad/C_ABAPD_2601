CLASS zcl_7171_agency_model DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS get_agency IMPORTING i_agency        TYPE /dmo/agency_id
                       RETURNING VALUE(r_agency) TYPE zc_abapd_agency
                       RAISING zcx_7171_no_agency.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_7171_AGENCY_MODEL IMPLEMENTATION.


  METHOD get_agency.
    SELECT SINGLE FROM zc_abapd_agency
    FIELDS *
    WHERE agencyId = @i_agency
    INTO @r_agency.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_7171_no_agency
        EXPORTING
          agency_id = i_agency.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
