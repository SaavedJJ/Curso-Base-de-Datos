select * from EMP where LOWER(oficio)='analista';
UPDATE EMP SET OFICIO ='analiSTA' where emp_no=7902;
--ESTAMOS PONIENDO VALORES ESTATICOS: 'analista'
--TAMBIEN PODRIAMOS INCLUIR VALORES DINAMICOS, POR LO QUE TENDRIAMOS QUE
--CONVERTIR LAS DOS COMPARACIONES
select * from EMP where UPPER(OFICIO)=UPPER('&dato');
--EN ORACLE TENEMOS LA POSIBILIDAD DE CONCATENAR TEXTOS EN UNA 
--SOLA COLUMNA (CAMPO CALCULADO)
--SE UTILIZA EL SIMBOLO || PARA CONCATENAR
--QUEREMOS MOSTRAR, EN UNA SOLA COLUMNA EL APELLIDO Y OFICIO DE LOS EMPLEADOS
select APELLIDO || ' ' || OFICIO as DESCRIPCION from EMP;
--LA FUNCION INITCAP MUESTRA CADA PALABRA DE UNA FRASE CON LA PRIMERA LETRA
--EN MAYUSCULAS
select INITCAP(OFICIO) as INITC from EMP;
select initcap(APELLIDO || ' ' || OFICIO)as DESCRIPCION from EMP;
select concat('Nuestro empleado ES...', APELLIDO) as RESULTADO from EMP;
--substr RECUPERA UNA SUBCADENA DE UN TEXTO
select SUBSTR('FLORERO', 2, 4) as DATO from DUAL;

select SUBSTR('FLORERO', 4) as DATO from DUAL;
--me gusta romper las cosas
select SUBSTR('FLORERO', 2, 40) as DATO from DUAL;
--mostrar los  empleados cuyo apellido comienza con s
select * from EMP where APELLIDO like 's%';
select substr(APELLIDO, 1, 1) as UNAletra from EMP;
select * from EMP where substr(APELLIDO, 1, 1)='s';
select LENGTH('LIBRO') as LONGITUD from DUAL;
--MOSTRAR LOS EMPLEADOS CUYO APELLIDO SEA DE 4 LETRAS
select * from EMP where APELLIDO like '____';
select * from EMP where length(APELLIDO)=4;
--INSTR BUSCA UN TEXTO Y DEVUELVE SU POSICION
select INSTR('BENITO', 'NIP') as POSICION from DUAL;
select INSTR('ORACLE MOLA', ' ') AS POSICION from DUAL;
--si deseamos validar un mail
select * from DUAL where INSTR('m@ail', '@') > 0;
select LPAD(DEPT_NO, 5, '$') from EMP;
select RPAD(DEPT_NO, 5, '$') from EMP;

--FUNCIONES MATEMATICAS
select ROUND(45.923) as REDONDEO from DUAL;
select ROUND(45.423) as REDONDEO from DUAL;
select ROUND(45.923, 2) as REDONDEO from DUAL;
select ROUND(45.929, 2) as REDONDEO from DUAL;
select ROUND(45.929, -1) as REDONDEO from DUAL;
select ROUND(456.929, -1) as REDONDEO from DUAL;
--TRUNC
select TRUNC(45.923) as TRUNCAR from DUAL;
select TRUNC(45.423) as TRUNCAR from DUAL;
select TRUNC(45.923, 2) as TRUNCAR from DUAL;
select TRUNC(45.929, 2) as TRUNCAR from DUAL;
--RESTO
--AVERIGUAR SI NUMERO ES PAR
select MOD(9, 2) as RESTO from DUAL;
select MOD(8, 2) as RESTO from DUAL;
--MOSTRAR LOS EMPLEADOS CUYO SALARIO SEA PAR
update emp set salario = salario + 1 where DEPT_NO=20;
select * from EMP where MOD(SALARIO, 2) = 0;

--TENEMOS UNA FUNCION PARA AVERIGUAR LA FECHA ACTUAL DE HOY
--EN EL SERVIDOR: sysdate
select SYSDATE as FECHA_ACTUAL from DUAL;
select SYSDATE + 10 as fecha from DUAL;
select SYSDATE + 30 as fecha from DUAL;
select SYSDATE - 10 as fecha from DUAL;
--MOSTRAR CUANTOS MESES LLEVAN LOS EMPLEADOS DADOS DE ALTA EN 
--EN LA EMPRESA
select APELLIDO, MONTHS_BETWEEN(SYSDATE, FECHA_ALT) as MESES from EMP;
--AGREGAMOS A LA FECHA ACTUAL, 5 MESES
select add_months(SYSDATE, 5) as DENTRO5 from DUAL;
--MOSTRAR CUANDO ES EL PROXIMO LUNES
select NEXT_DAY(SYSDATE, 1) as PROXIMOLUNES from DUAL;
select NEXT_DAY(SYSDATE, 'martes') as PROXIMOMARTES from DUAL;
select NEXT_DAY(SYSDATE, 'miércoles') as PROXIMACHAMPIONS from DUAL;
select NEXT_DAY(SYSDATE, 'monday') as PROXIMACHAMPIONS from DUAL;
--LAST_DAY
select LAST_DAY(sysdate) AS FINMES from DUAL;
--EMPLEADOS REDONDEADOS LA FECHA AL MES
select APELLIDO, FECHA_ALT, ROUND(FECHA_ALT, 'MM') as ROUNDMES from EMP;
select APELLIDO, FECHA_ALT, ROUND(FECHA_ALT, 'YY') as ROUNDYEAR from EMP;
--TRUNC FECHA
select APELLIDO, FECHA_ALT, TRUNC(FECHA_ALT, 'MM') as TRUNCMES from EMP;
select APELLIDO, FECHA_ALT, TRUNC(FECHA_ALT, 'YY') as TRUNCYEAR from EMP;

select APELLIDO, FECHA_ALT, TO_CHAR(FECHA_ALT, 'MM-DD-YYYY') as FORMATO from EMP;
select APELLIDO, FECHA_ALT, TO_CHAR(FECHA_ALT, 'DD@MM@YYYY') as FORMATO from EMP;
select TO_CHAR(SYSDATE, 'MONTH') as NOMBREMES from DUAL;
select TO_CHAR(SYSDATE, 'day MONTH ww') as NOMBREMES from DUAL;
--formato a numeros
select TO_CHAR(7458, '0000L') as ZERO from DUAL;
select TO_CHAR(7458, '0000$') as ZERO from DUAL;
--hora del sistema
select TO_CHAR(SYSDATE, 'HH24:MI:SS') as HORA_SISTEMA from DUAL; 
--SI DESEAMOS INCLUIR TEXTO ENTRE TO_CHAR Y LOS FORMATOS
--SE REALIZA CON " " DENTRO DE LAS SIMPLES
select TO_CHAR(SYSDATE, '"Hoy es " DD " de " MONTH') as FORMATO from DUAL;
select TO_CHAR(SYSDATE, '"Hoy es " DD " de " MONTH'
, 'nls_date_language=FRENCH') as FORMATO from DUAL;
--FUNCIONES DE CONVERSION
select '08/04/2025' + 2 as FECHA from DUAL;
select to_date('08/04/2025') + 2 as FECHA from DUAL;
select '12' + 2  as RESULTADO from DUAL;
select to_number('12') + 2 as RESULTADO from DUAL;
--NVL SIRVE PARA EVITAR LOS NULOS Y SUSTITUIR
--SI ENCUENTRA UN NULO, LO SUSTITUYE, SINO, MUESTRA EL VALOR
select * from EMP;
--mostrar apellido, salario y comision de todos los empleados
select APELLIDO, SALARIO, COMISION from EMP;
--podemos indicar que en lugar de poner null, escriba otro valor
--el valor debe ser correspondiente al tipo de dato de la columna
select APELLIDO, SALARIO, nvl(COMISION, -1) as COMISION from EMP;
--mostrar apellido, salario + comision de todos los empleados
select APELLIDO, SALARIO + nvl(COMISION, 0) as TOTAL from EMP;
--MOSTRAR EL TURNO EN PALABRA ('MAÑANA', 'TARDE' O 'NOCHE') DE LA PLANTILLA
select APELLIDO, TURNO FROM PLANTILLA;
select APELLIDO, decode(TURNO, 'M', 'MAÑANA', 'N', 'NOCHE', 'TARDE') as TURNO 
from PLANTILLA;


--QUIERO SABER LA FECHA DEL PROXIMO MIERCOLES QUE JUEGA EL MADRID
--quiero ver la fecha completa, que no me entero
--quiero ver: El Miercoles 11 de abril juega el Madrid
select to_char(
next_day(sysdate + 2, 'miércoles'),
'"El día " day dd " juega el Madrid"') as CHAMPIONS from DUAL;





































































