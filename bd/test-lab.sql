/*
Pentru fiecare job sa se afiseze c‚ti candidati au punctajul peste medie, egal cu
media si sub medie.
*/
SELECT COUNT(CASE WHEN PUNCTAJ_CV > (SELECT AVG(PUNCTAJ_CV) FROM APLICA) THEN 1 END) AS MARE,
       COUNT(CASE WHEN PUNCTAJ_CV = (SELECT AVG(PUNCTAJ_CV) FROM APLICA) THEN 1 END) AS EGAL,
       COUNT(CASE WHEN PUNCTAJ_CV < (SELECT AVG(PUNCTAJ_CV) FROM APLICA) THEN 1 END) AS MIC
FROM APLICA;


/*
Sa se obtina lista joburilor (data_aplicare si data interviu in formatul zi/luna/an ) la
care a aplicat cel mai t‚nar candidat.
*/
SELECT COD_CANDIDAT, COD_JOB, TO_CHAR(DATA_APLICARE, 'dd/mon/yy'), TO_CHAR(DATA_INTERVIU, 'dd/mon/yy') FROM (
  SELECT * FROM APLICA
  WHERE COD_CANDIDAT=(SELECT ID_CANDIDAT
    FROM CANDIDAT
    WHERE DATA_NASTERE=(SELECT MIN(DATA_NASTERE) FROM CANDIDAT)))
NATURAL JOIN INTERVIU;


/*
Sa se adauge Ón tabelul job coloana numar_candidati. Sa se actualizeze datele
memorate in numar_candidati astfel incat sa indice numarul de candidati care au aplicat la
un anumit job.
*/
ALTER TABLE JOB
ADD (numar_candidati INT);

MERGE INTO job myjob
USING (
  SELECT cod_job, count(cod_job) "MYCOUNT"
  FROM APLICA
  NATURAL JOIN CANDIDAT
  GROUP BY COD_JOB
) MYQUERY
ON (MYQUERY.COD_JOB = MYJOB.JOB_ID)
WHEN MATCHED THEN
  UPDATE SET
    MYJOB.NUMAR_CANDIDATI = MYQUERY.MYCOUNT;

/*
Sa se afiseze denumirile joburilor, numele candidatilor programati la interviu si
data la care au fost programati. Se vor afisa si joburile pentru care nu s-a programat niciun
interviu.
trebuie modificat cu outer join :(
*/
SELECT denumire, nume, data_interviu 
FROM INTERVIU, CANDIDAT, JOB
WHERE interviu.cod_candidat = candidat.id_candidat AND interviu.cod_job = job.job_id;

SELECT job_id FROM job
WHERE job_id NOT IN
(SELECT DISTINCT cod_job
FROM INTERVIU, CANDIDAT, JOB
WHERE INTERVIU.COD_CANDIDAT = CANDIDAT.ID_CANDIDAT AND INTERVIU.COD_JOB = JOB.JOB_ID);


/*
Sa se afiseze denumirile joburilor la care au aplicat cel putin 3 candidati. Pentru
aceste joburi se va afisa numarul de candidati care au punctaj mai mare de 70.
*/

/*
PRIMA PARTE
*/
SELECT DENUMIRE, APLICATII FROM 
JOB MYJOB, (
  SELECT * FROM (
    SELECT COD_JOB, COUNT(COD_JOB) "APLICATII" FROM APLICA
    GROUP BY COD_JOB)
  WHERE APLICATII>=3) MYQUERY
WHERE MYJOB.JOB_ID = MYQUERY.COD_JOB;

/*
A DOUA PARTE CU TOTUL
*/
SELECT DENUMIRE, MYCOUNT FROM (
  SELECT COD_JOB, COUNT(COD_CANDIDAT) MYCOUNT FROM APLICA
  WHERE PUNCTAJ_CV > 70
  GROUP BY COD_JOB) QUERY1, (
  SELECT * FROM 
  JOB MYJOB, (
    SELECT * FROM (
      SELECT COD_JOB, COUNT(COD_JOB) "APLICATII" FROM APLICA
      GROUP BY COD_JOB)
    WHERE APLICATII>=3) MYQUERY
  WHERE MYJOB.JOB_ID = MYQUERY.COD_JOB) QUERY2
WHERE QUERY1.COD_JOB = QUERY2.COD_JOB;
