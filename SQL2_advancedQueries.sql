/*
2(i) Query 1
Show the demerit points and demerit description for all the demerits that either contains
the word “heavy” or “Heavy” or start with the word “Exceed” in the description. The column
headings in your output should be renamed as Demerit Points and Demerit Description.
The output must be sorted in ascending format by demerit points and where two demerits
have the same points sort them in ascending format of demerit description. Y
*/
SELECT
    dem_points        AS "Demerit Points",
    dem_description   AS "Demerit Description"
FROM
    demerit
WHERE
    dem_description LIKE '%heavy%'
    OR dem_description LIKE '%Heavy%'
    OR dem_description LIKE 'Exceed%'
ORDER BY
    dem_points ASC,
    dem_description ASC;

/*
2(ii) Query 2
For all “Range Rover” and “Range Rover Sport” models, show the main colour, VIN
and manufacture year for all the vehicles that were manufactured from 2012 to 2014. The
column headings in your output should be renamed as Main Colour, VIN and Year
Manufactured. The output must be sorted by manufacture year in descending format and
where more than one vehicle was manufactured in the same year sort them by colour in
ascending format.
*/

SELECT
    veh_maincolor   AS "Main Colour",
    veh_vin         AS vin,
    to_char(veh_yrmanuf, 'yyyy') AS "Year Manufactured"
FROM
    vehicle
WHERE
    ( upper(veh_modname) = upper('Range Rover')
      OR upper(veh_modname) = upper('Range Rover Sport') )
    AND to_char(veh_yrmanuf, 'yyyy') BETWEEN 2012 AND 2014
ORDER BY
    "Year Manufactured" DESC,
    "Main Colour" ASC;

/*
2(iii) Query 3
Show the driver licence number, full name (firstname and lastname together), date of
birth, full address (street, town and postcode together), suspension start date and
suspension end date for all the drivers who have had their licence suspended in the last 30
months. You need SQL to calculate 30 months from the day this query would be executed
by the user. The column headings in your output should be renamed as Licence No.,
Driver Fullname, DOB, Driver Address, Suspended On and Suspended Till. The output
must be sorted by licence number in ascending format and where there is one licence
number suspended more than once sort them by suspended date in descending format.
*/

SELECT
    lic_no AS "Licence No.",
    lic_fname
    || ' '
    || lic_lname AS "Driver Fullname",
    to_char(lic_dob, 'DD-Mon-YYYY') AS "DOB",
    lic_street
    || ' '
    || lic_town
    || ' '
    || lic_postcode AS "Driver Address",
    to_char(sus_date, 'dd/MON/yy') AS "Suspended On",
    to_char(sus_enddate, 'dd/MON/yy') AS "Suspended Till"
FROM
    suspension
    NATURAL JOIN driver
WHERE
    sus_date > add_months(sysdate, - 30)
ORDER BY
    lic_no asc,
    sus_date desc;

/*
2(iv)
TDS would like to find out if there is any correlation between different months of a year
and demerit codes so you have been assigned to generate a report that shows for ALL the
demerits, the code, description, total number of offences committed for the demerit code
so far in any month (of any year) and then the total of offences committed for the demerit
code in each month (of any year). The column headings in your output should be renamed
as Demerit Code, Demerit Description, Total Offences (All Months), and then the first three
letters of each month (with the first letter in uppercase). The output must be sorted by
Total Offences (All Months) column in descending format and where there is more than
one demerit code with the same total, sort them by demerit code in ascending format.
*/

SELECT
    dem_code          AS "Demerit Code",
    dem_description   AS "Demerit Description",
    COUNT(dem_code) AS "Total Offences(All Months)",
    COUNT(jan) AS "Jan",
    COUNT(feb) AS "Feb",
    COUNT(mar) AS "Mar",
    COUNT(apr) AS "Apr",
    COUNT(may) AS "May",
    COUNT(jun) AS "Jun",
    COUNT(jul) AS "Jul",
    COUNT(aug) AS "Aug",
    COUNT(sep) AS "Sep",
    COUNT(oct) AS "Oct",
    COUNT(nov) AS "Nov",
    COUNT(dec) AS "Dec"
FROM
    (
        SELECT
            dem_code,
            CASE to_char(off_datetime, 'Mon')
                WHEN 'Jan' THEN
                    + 1
            END AS jan,
            CASE to_char(off_datetime, 'Mon')
                WHEN 'Feb' THEN
                    + 1
            END AS feb,
            CASE to_char(off_datetime, 'Mon')
                WHEN 'Mar' THEN
                    + 1
            END AS mar,
            CASE to_char(off_datetime, 'Mon')
                WHEN 'Apr' THEN
                    + 1
            END AS apr,
            CASE to_char(off_datetime, 'Mon')
                WHEN 'May' THEN
                    + 1
            END AS may,
            CASE to_char(off_datetime, 'Mon')
                WHEN 'Jun' THEN
                    + 1
            END AS jun,
            CASE to_char(off_datetime, 'Mon')
                WHEN 'Jul' THEN
                    + 1
            END AS jul,
            CASE to_char(off_datetime, 'Mon')
                WHEN 'Aug' THEN
                    + 1
            END AS aug,
            CASE to_char(off_datetime, 'Mon')
                WHEN 'Sep' THEN
                    + 1
            END AS sep,
            CASE to_char(off_datetime, 'Mon')
                WHEN 'Oct' THEN
                    + 1
            END AS oct,
            CASE to_char(off_datetime, 'Mon')
                WHEN 'Nov' THEN
                    + 1
            END AS nov,
            CASE to_char(off_datetime, 'Mon')
                WHEN 'Dec' THEN
                    + 1
            END AS dec
        FROM
            offence
    )
    NATURAL JOIN demerit
GROUP BY
    dem_code,
    dem_description
ORDER BY
    "Total Offences(All Months)" DESC,
    "Demerit Code" ASC;

/*
2(v) Query 5
Find out which manufacturer's vehicles are involved in the highest number of offences
which incur 2 or more demerit points. Show the manufacturer name and the total number
of offences that the manufacturer’s vehicles are involved in. The column headings in your
output should be renamed as Manufacturer Name and Total No. of Offences. The output
must be sorted by Total No. of Offences column in descending format and where there is
more than one manufacturer with the same total, sort them by manufacturer name in
ascending format.
*/
SELECT
    veh_manufname AS "Manufacturer Name",
    COUNT(veh_manufname) AS "Total No. of Offences"
FROM
    ( offence
    NATURAL JOIN vehicle )
    NATURAL JOIN demerit
WHERE
    dem_points >= 2
GROUP BY
    veh_manufname
HAVING
    COUNT(veh_manufname) = (
        SELECT
            MAX(COUNT(veh_manufname))
        FROM
            ( offence
            NATURAL JOIN vehicle )
            NATURAL JOIN demerit
        WHERE
            dem_points >= 2
        GROUP BY
            veh_manufname
    )
ORDER BY
    veh_manufname ASC;

/*
2(vi) Query 6
Find out the drivers who have been booked more than once for the same offence by
an officer with the last name as that of their last name. Show the driver licence number,
driver full name (firstname and lastname together), officer number, officer full name
(firstname and lastname together). The column headings in your output should be
renamed as Licence No., Driver Name, Officer ID, Officer Name. The output must be
sorted by driver licence number column in ascending format.
*/

SELECT
    lic_no       AS "Licence No.",
    lic_fname
    || ' '
    || lic_lname AS "Driver Name",
    officer_id   AS "Officer ID",
    officer_fname
    || ' '
    || officer_lname AS "Officer Name"
FROM
    ( offence
    NATURAL JOIN driver )
    NATURAL JOIN officer
WHERE
    lic_lname = officer.officer_lname
GROUP BY
    lic_no,
    dem_code,
    lic_fname,
    lic_lname,
    officer_id,
    officer_fname,
    officer_lname
HAVING
    COUNT(dem_code) >= 2
ORDER BY
    lic_no ASC;

--lic_fname ||' '|| lic_lname as drivername,

/*
2(vii) Query 7
For each demerit code for which an offence has been recorded, find out the driver/s
who has/have been booked the most number of times. Show the demerit code, demerit
description, driver licence number, driver full name (firstname and lastname together) and
the total number of times the driver has been booked in the output. The column headings
in your output should be renamed as Demerit Code, Demerit Description, Licence No.,
Driver Fullname and Total Times Booked. The output must be sorted by demerit code in
ascending format and where for one demerit there is more than one driver booked the
most number of times sort them by licence number in ascending format.
*/

SELECT
    dem_code          AS "Demerit Code",
    dem_description   AS "Demerit Description",
    lic_no            AS "Licence No.",
    driver.lic_fname
    || ' '
    || driver.lic_lname AS "Driver Fullname",
    COUNT(dem_code) AS "Total Times Booked"
FROM
    ( offence
    NATURAL JOIN driver )
    NATURAL JOIN demerit
GROUP BY
    dem_code,
    dem_description,
    lic_no,
    driver.lic_fname
    || ' '
    || driver.lic_lname
ORDER BY
    dem_code,
    lic_no;

/*
2(viii) Query 8
For each region, show the number of vehicles manufactured in the region and the
percentage of vehicles manufactured in the region. The last row of the output shows the
totals - the second column which shows the total number of vehicles manufactured in all
regions (which is the total of all the individual totals in this column) and the third column of
which shows the total percentage of vehicles manufactured in all the regions (which is the
total of all the individual percentages in this column). The first character of the VIN
represents the region where the vehicle was manufactured.

The column headings in your output should be renamed as Region, Total Vehicles
Manufactured and Percentage of Vehicles Manufactured. The output must be sorted by
Total Vehicles Manufactured in ascending format and where there is more than one region
with the same total, sort them by region in ascending format.
*/

SELECT
    region AS "Region",
    COUNT(*) AS "Total Vehicles Manufactured",
    lpad(to_char(COUNT(*) /(
        SELECT
            COUNT(*)
        FROM
            vehicle
    ) * 100, 990.99)
         || '%', 28, ' ') AS "Percentage of Vehicles Manufactured"
FROM
    (
        SELECT
            CASE
                WHEN veh_vin > 'A'
                     AND veh_vin < 'D' THEN
                    'Africa'
                WHEN veh_vin > 'J'
                     AND veh_vin < 'S' THEN
                    'Asia'
                WHEN veh_vin > 'S'  THEN
                    'Europe'
                WHEN veh_vin > '1'
                     AND veh_vin < '6' THEN
                    'North America'
                WHEN veh_vin > '6'
                     AND veh_vin < '8' THEN
                    'Oceania'
                WHEN veh_vin > '8' THEN
                    'South America'
                ELSE
                    'Unknown'
            END AS region
        FROM
            vehicle
    )
GROUP BY
    region
UNION ALL
SELECT
    lpad(nvl(NULL, 'TOTAL'), 13, ' '),
    SUM(vehiclecount),
    lpad(to_char(SUM(vehiclepercentage) * 100, 990.99)
         || ''
         || '%', 28, ' ')
FROM
    (
        SELECT
            region,
            COUNT(*) AS vehiclecount,
            round(COUNT(*) /(
                SELECT
                    COUNT(*)
                FROM
                    vehicle
            ), 4) AS vehiclepercentage
        FROM
            (
                SELECT
                    CASE
                        WHEN veh_vin > 'A'
                             AND veh_vin < 'D' THEN
                            'Africa'
                        WHEN veh_vin > 'J'
                             AND veh_vin < 'S' THEN
                            'Asia'
                        WHEN veh_vin > 'S'  THEN
                            'Europe'
                        WHEN veh_vin > '1'
                             AND veh_vin < '6' THEN
                            'North America'
                        WHEN veh_vin > '6'
                             AND veh_vin < '8' THEN
                            'Oceania'
                        WHEN veh_vin > '8' THEN
                            'South America'
                        ELSE
                            'Unknown'
                    END AS region
                FROM
                    vehicle
            )
        GROUP BY
            region
    )
ORDER BY
    "Total Vehicles Manufactured",
    "Region";
