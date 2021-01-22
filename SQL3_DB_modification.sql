/*
3(i) Changes to live database 1
TDS would like to be able to easily determine the total number of times each police
officer has booked a driver for a traffic offence. Add a new attribute which will record the
number of times each officer has booked drivers.

This attribute must be initialised to the correct current number of times each officer has
booked drivers based on the data which is currently stored in the system.
*/
ALTER TABLE officer ADD (
    officer_bookqty NUMBER(5) DEFAULT 0 NOT NULL
);

COMMIT;

UPDATE officer table_for_update
SET
    officer_bookqty = (
        SELECT
            dem_code_count
        FROM
            (
                SELECT
                    offi.officer_id AS officerid,
                    COUNT(dem_code) AS dem_code_count
                FROM
                    offence   offe
                    RIGHT OUTER JOIN officer   offi ON offe.officer_id = offi.officer_id
                GROUP BY
                    offi.officer_id
            )
        WHERE
            table_for_update.officer_id = officerid
    );

COMMIT;


/*
3(ii) Changes to live database 2

The problem TDS might face with the current database is if an offence is revoked for
some valid reason, it is impossible for them to keep the offence information for the revoked
offence in the database. TDS would like to fix this problem such that they are able to keep
information about a revoked offence along with the other required information such as
when it was revoked, who revoked the offence and the reason for revocation. For quick
access, it has been decided that a column is also required to indicate Yes or No if an
offence has been revoked or not. There will always be only one reason that can be
associated with a revocation. TDS will not be able to add all the reasons for a revocation of
the offences initially and so your solution should allow them to add new reasons as and
when there is a need. At this stage, the only reasons for revocation of an offence TDS is
interested in recording are First offence exceeding the speed limit by less than 10km/h
(FOS), Faulty equipment used (FEU), Driver objection upheld (DOU), Court hearing (COH),
and Error in proceedings (EIP). Each reason code will have exactly 3 letters.

a. only around 1% of offences recorded are revoked and there can be hundreds of
thousands of offences in the offence table,

b. all existing offences, after implementing this requirement, must automatically be
recorded as not revoked,

c. appeals are made by completing a paper form and sending the completed form to
TDS either by fax or mail and, at this stage, there is no need to record unsuccessful
appeals in the database.
*/

DROP TABLE revocation CASCADE CONSTRAINTS PURGE;

DROP TABLE revocation_reason CASCADE CONSTRAINTS PURGE;

CREATE TABLE revocation_reason (
    revocation_cause_code   CHAR(3),
    revocation_cause        VARCHAR(100) NOT NULL,
    CONSTRAINT revocation_cause_pk PRIMARY KEY ( revocation_cause_code )
);

COMMIT;

INSERT INTO revocation_reason VALUES (
    'FOS',
    'First offence exceeding the speed limit by less than 10km/h'
);

COMMIT;

INSERT INTO revocation_reason VALUES (
    'FEU',
    'Faulty equipment used'
);

COMMIT;

INSERT INTO revocation_reason VALUES (
    'DOU',
    'Driver objection upheld'
);

COMMIT;

INSERT INTO revocation_reason VALUES (
    'COH',
    'Court hearing'
);

COMMIT;

INSERT INTO revocation_reason VALUES (
    'EIP',
    'Error in proceedings'
);

COMMIT;

CREATE TABLE revocation (
    revocation_datetime     DATE NOT NULL,
    officer_id              NUMBER(8) NOT NULL,
    off_no                  NUMBER(8) NOT NULL,
    revocation_cause_code   CHAR(3) NOT NULL,
    CONSTRAINT revocation_pk PRIMARY KEY ( off_no ),
    CONSTRAINT revocation_fk_off_no FOREIGN KEY ( off_no )
        REFERENCES offence ( off_no ),
    CONSTRAINT revocation_fk_officer_id FOREIGN KEY ( officer_id )
        REFERENCES officer ( officer_id ),
    CONSTRAINT revocation_fk_cause_code FOREIGN KEY ( revocation_cause_code )
        REFERENCES revocation_reason ( revocation_cause_code )
);

ALTER TABLE offence ADD (
    offence_revoked CHAR(3) DEFAULT 'No ' NOT NULL
        CONSTRAINT offence_revoked_chk CHECK ( offence_revoked IN (
            'Yes',
            'No '
        ) )
);

COMMIT;

/*
3(iii) Changes to live database 3

(iii) TDS has found that having just the vehicle's main colour in the database, in some cases, is
inadequate in helping identify a vehicle that has been involved in a traffic offence. As a
consequence, they have decided to now also record if any outer part other than the body of the
vehicle is of a different colour. At this stage, the only other parts TDS is interested in recording the
colour of are the Spoiler (SP), Bumper (BM) and Grilles (GR) but this may change if the need
arises and so it should be able to be changed easily. Each outer part code will have exactly 2
letters. Where the colour of grilles, spoiler (if any) or Bumper is the same as that of the body
colour, there is no need to record anything in the database.

TDS is also intending to find a solution such that new colours can be easily introduced when a
manufacturer releases a new colour. Each colour must be identified by a unique colour number
(which is auto-generated by the system)

This data must be collected from the current state of the vehicle table via SQL only (you cannot
assume the presence of any particular colour). Subsequent colours will be added directly to this
collection via INSERT statements.
*/

DROP SEQUENCE colour_code;

CREATE SEQUENCE colour_code MINVALUE 50 INCREMENT BY 1;

COMMIT;

DROP TABLE colour CASCADE CONSTRAINTS PURGE;

CREATE TABLE colour (
    colour_code          NUMBER(3),
    colour_description   VARCHAR(50) unique NOT NULL,
    CONSTRAINT colour_pk PRIMARY KEY ( colour_code )
);

COMMIT;

INSERT INTO colour
    ( SELECT
        colour_code.NEXTVAL,
        veh_maincolor
    FROM
        (
            SELECT DISTINCT
                veh_maincolor
            FROM
                vehicle
        )
    );

COMMIT;

DROP TABLE vehicle_part CASCADE CONSTRAINTS PURGE;

CREATE TABLE vehicle_part (
    vehicle_part_code   CHAR(2),
    part_description    VARCHAR(50) NOT NULL,
    CONSTRAINT part_pk PRIMARY KEY ( vehicle_part_code )
);

COMMIT;

INSERT INTO vehicle_part VALUES (
    'SP',
    'Spoiler'
);

COMMIT;

INSERT INTO vehicle_part VALUES (
    'BM',
    'Bumper'
);

COMMIT;

INSERT INTO vehicle_part VALUES (
    'GR',
    'Grilles'
);

COMMIT;

DROP TABLE vehicle_partcolour CASCADE CONSTRAINTS PURGE;

CREATE TABLE vehicle_partcolour (
    veh_vin               CHAR(17),
    vehicle_part_code     CHAR(2),
    vehicle_part_colour   NUMBER(3) not null,
    CONSTRAINT vehicle_partcolour_pk PRIMARY KEY ( veh_vin,
                                                   vehicle_part_code ),
    CONSTRAINT vehicle_partcolour_fk FOREIGN KEY ( veh_vin )
        REFERENCES vehicle ( veh_vin ),
    CONSTRAINT vehicle_partcolour_fk_colour FOREIGN KEY ( vehicle_part_colour )
        REFERENCES colour ( colour_code ),
    CONSTRAINT vehicle_partcolour_fk_part FOREIGN KEY ( vehicle_part_code )
        REFERENCES vehicle_part ( vehicle_part_code )
);

COMMIT;

INSERT INTO vehicle_partcolour VALUES (
    upper('zhwes4zf8kla12259'),
    (select vehicle_part_code from vehicle_part where upper(part_description) = upper('spoiler')),
    (
        SELECT
            colour_code
        FROM
            colour
        WHERE
            upper(colour_description) = upper('yellow')
    )
);

COMMIT;

INSERT INTO vehicle_partcolour VALUES (
    upper('zhwes4zf8kla12259'),
    (select vehicle_part_code from vehicle_part where upper(part_description) = upper('bumper')),
    (
        SELECT
            colour_code
        FROM
            colour
        WHERE
            upper(colour_description) = upper('blue')
    )
);

COMMIT;

INSERT INTO vehicle_partcolour VALUES (
    upper('zhwef4zf2lla13803'),
    (select vehicle_part_code from vehicle_part where upper(part_description) = upper('spoiler')),
    (
        SELECT
            colour_code
        FROM
            colour
        WHERE
            upper(colour_description) = upper('black')
    )
);

COMMIT;

INSERT INTO colour VALUES (
    colour_code.NEXTVAL,
    'Magenta'
);

COMMIT;

INSERT INTO vehicle_partcolour VALUES (
    upper('zhwef4zf2lla13803'),
    (select vehicle_part_code from vehicle_part where upper(part_description) = upper('grilles')),
    (
        SELECT
            colour_code
        FROM
            colour
        WHERE
            upper(colour_description) = upper('magenta')
    )
);

COMMIT;
