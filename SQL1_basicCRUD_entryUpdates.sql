SET SERVEROUTPUT ON;

/*
1b(i) Create a sequence which will allow entry of data into the OFFENCE table - the
sequence must begin at 100 and go up in steps of 1 (i.e., the first value is 100, the
next 101, etc.)
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE

DROP SEQUENCE offence_entry;

CREATE SEQUENCE offence_entry MINVALUE 100 INCREMENT BY 1;

/*
1b(ii) Lion Lawless of 72 Aberg Avenue Richmond South 3121 (Licence no.: 100389)
has been very inconsiderate of others on the road over the years and has
committed several offences that have been booked by highly vigilant TDS officers
at various different locations. Lion Lawless was riding the same motorbike, a 1994
Red Yamaha FZR600 (JYA3HHE05RA070562) at the time of committing these
offences. Lion Lawless has only committed the offences listed below. The details of
the bookings for Lion are as follows:

- 10-Aug-2019 08:04 AM booked for traffic offence “Blood alcohol charge” by
police officer Dolley Hedling (10000011)

- On 16-Oct-2019 9:00 PM booked for traffic offence “Level crossing offence”
by police officer Geoff Kilmartin (10000015)

- On 7-Jan-2020 7:07 AM booked for traffic offences “Exceeding the speed
limit by 25 km/h or more” by police officer Geoff Kilmartin (10000015)
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE

INSERT INTO offence VALUES (
    offence_entry.NEXTVAL,
    TO_DATE('10-Aug-2019 08:04 AM', 'dd-Mon-yyyy hh:mi AM'),
    '80 Aberg Ave Richmond South 3121',
    (
        SELECT
            dem_code
        FROM
            demerit
        WHERE
            upper(dem_description) = upper('Blood alcohol charge')
    ),
    10000011,
    '100389',
    'JYA3HHE05RA070562'
);

COMMIT;

INSERT INTO offence VALUES (
    offence_entry.NEXTVAL,
    TO_DATE('16-Oct-2019 09:00 PM', 'dd-Mon-yyyy hh:mi AM'),
    'Prince Hwy',
    (
        SELECT
            dem_code
        FROM
            demerit
        WHERE
            upper(dem_description) = upper('Level crossing offence')
    ),
    10000015,
    '100389',
    'JYA3HHE05RA070562'
);

COMMIT;

INSERT INTO offence VALUES (
    offence_entry.NEXTVAL,
    TO_DATE('07-Jan-2020 07:07 AM', 'dd-Mon-yyyy hh:mi AM'),
    '1457 North Road, Clayton VIC 3168',
    (
        SELECT
            dem_code
        FROM
            demerit
        WHERE
            upper(dem_description) = upper('Exceeding the speed limit by 25 km/h or more')
    ),
    10000015,
    '100389',
    'JYA3HHE05RA070562'
);

INSERT INTO suspension VALUES (
    '100389',
    to_date('07-Jan-2020'),
    to_date((select add_months('07-Jan-2020', 6) from dual), 'dd-Mon-yyyy')
);

COMMIT;

/*
1b(iii) Lion Lawless of 72 Aberg Avenue Richmond South 3121 (Licence no.: 100389)
had appealed against the “Exceeding the speed limit by 25 km/h or more” offence
he has been alleged to have committed on 07-Jan-2020 at 7:07 AM.

After careful consideration and taking into account that speed guns at times are not
very accurate, TDS has decided to lessen the offence to “Exceeding the speed limit
by 10 km/h or more but less than 25 km/h" but has strongly warned Lion Lawless to
be more careful in future. Take the necessary steps in the database to record this
change.
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE

UPDATE offence
SET
    dem_code = (
        SELECT
            dem_code
        FROM
            demerit
        WHERE
            upper(dem_description) = upper('Exceeding the speed limit by 10 km/h or more but less than 25 km/h')
    )
WHERE
    lic_no = '100389'
    AND dem_code = (
        SELECT
            dem_code
        FROM
            demerit
        WHERE
            upper(dem_description) = upper('Exceeding the speed limit by 25 km/h or more')
    )
    AND to_char(off_datetime, 'dd-Mon-yyyy hh:mi AM') = '07-Jan-2020 07:07 AM';

DELETE FROM suspension
WHERE
    lic_no = '100389'
    AND to_char(sus_date, 'dd-Mon-yyyy') = '07-Jan-2020';

COMMIT;
