DECLARE
    TYPE t_numbers IS TABLE OF NUMBER;
    v_even_numbers t_numbers := t_numbers();
BEGIN
    FOR i IN 1..200 LOOP
        IF MOD(i, 2) = 0 THEN
            v_even_numbers.EXTEND;
            v_even_numbers(v_even_numbers.COUNT) := i;
        END IF;
    END LOOP;

    FOR i IN 1..v_even_numbers.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_even_numbers(i));
    END LOOP;
END;