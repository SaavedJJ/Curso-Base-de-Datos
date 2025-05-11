CREATE OR REPLACE PACKAGE pk_distribuidor
AS
    TYPE t_distribuidor IS RECORD
    (
        paginaWeb         VARCHAR2(100),
        telefono          VARCHAR2(15),
        email             VARCHAR2(50)
    );
    v_distribuidor t_distribuidor;
END pk_distribuidor;