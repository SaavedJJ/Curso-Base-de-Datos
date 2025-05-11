
INSERT ALL
    INTO distribuidoras (idDistribuidor, Distribuidor) VALUES (2, 'SONY PICTURES')
    INTO distribuidoras (idDistribuidor, Distribuidor) VALUES (3, 'BUENA VISTA INTERNACIONAL')
    INTO distribuidoras (idDistribuidor, Distribuidor) VALUES (4, 'LAUREN FILMS')
    INTO distribuidoras (idDistribuidor, Distribuidor) VALUES (5, 'TRIPICTURES')
    INTO distribuidoras (idDistribuidor, Distribuidor) VALUES (6, 'WARNER BROS')
SELECT * FROM dual;

CREATE PROCEDURE getDistribuidoras (p_idDistribuidor distribuidoras.idDistribuidor%TYPE)
AS
    v_distribuidor distribuidoras.Distribuidor%TYPE;
BEGIN
    SELECT Distribuidor INTO v_distribuidor FROM distribuidoras WHERE idDistribuidor = p_idDistribuidor;
    CASE 
        WHEN v_distribuidor = 'SONY PICTURES' THEN DBMS_OUTPUT.PUT_LINE('SP');
        WHEN v_distribuidor = 'BUENA VISTA INTERNACIONAL' THEN DBMS_OUTPUT.PUT_LINE('BVI');
        WHEN v_distribuidor = 'LAUREN FILMS' THEN DBMS_OUTPUT.PUT_LINE('LF');
        WHEN v_distribuidor = 'TRIPICTURES' THEN DBMS_OUTPUT.PUT_LINE('TP');
        WHEN v_distribuidor = 'WARNER BROS' THEN DBMS_OUTPUT.PUT_LINE('WB');
        ELSE DBMS_OUTPUT.PUT_LINE(v_distribuidor);
    END CASE;
END;

EXEC getDistribuidoras(1);