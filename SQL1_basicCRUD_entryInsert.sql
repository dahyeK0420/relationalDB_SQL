SET SERVEROUTPUT ON;

/*
1(a) Load selected tables with your own additional test data
- 20 offences
- 3 suspensions
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE

insert into offence values(
048, to_date('1-Jan-2016 04:30 AM', 'dd-Mon-yyyy hh:mi AM'), '1450 North Road, Clayton VIC 3168', 131, 10000011, '100011', 'KL8CL6S07FC705544');
commit;

insert into offence values(
049, to_date('4-Feb-2016 09:30 AM', 'dd-Mon-yyyy hh:mi AM'), 'Mountain Hwy', 131, 10000011, '100011', 'KL8CL6S07FC705544');
commit;

insert into offence values(
050, to_date('12-Mar-2016 04:30 AM', 'dd-Mon-yyyy hh:mi AM'), 'Prince Hwy', 99, 10000009, '100381', '1B3BP68J8MN518050');
commit;

insert into offence values(
051, to_date('18-Jun-2016 09:09 PM', 'dd-Mon-yyyy hh:mi AM'), '14 Old Dandenong Rd, Oakleigh South VIC 3167', 129, 10000007, '100062', '5TEVL52N11Z773452');
commit;

insert into offence values(
052, to_date('30-Jun-2016 06:20 AM', 'dd-Mon-yyyy hh:mi AM'), 'West Gate Fwy',  99,  10000008, '100353', 'JACUBS26G17100401');
commit;

insert into offence values(
053, to_date('1-Jul-2016 01:41 PM', 'dd-Mon-yyyy hh:mi AM'), 'Eastern Fwy', 105, 10000013, '100086', 'JHEFY1EUPA0010911');
commit;

insert into offence values(
054, to_date('18-Jul-2016 03:19 PM', 'dd-Mon-yyyy hh:mi AM'), '565 South Rd, Bentleigh VIC 3204', 122, 10000020, '100058', '4F2CZ06193KU35269');
commit;

insert into offence values(
055, to_date('28-Aug-2016 11:21 AM', 'dd-Mon-yyyy hh:mi AM'), '501 Williamstown Rd, Port Melbourne VIC 3207',  119, 10000011, '100381', '1B3BP68J8MN518050');
commit;

insert into offence values(
056, to_date('10-Dec-2016 02:49 PM', 'dd-Mon-yyyy hh:mi AM'), 'Nepean Hwy', 127, 10000010, '100208', 'JA4NW51S93J601384');
commit;

insert into offence values(
057, to_date('28-Jan-2017 04:03 PM', 'dd-Mon-yyyy hh:mi AM'), '566 Bridge Rd, RichMond VIC 3121', 122,  10000017, '100086', 'JHEFY1EUPA0010911');
commit;

insert into offence values(
058, to_date('10-Feb-2017 10:08 AM', 'dd-Mon-yyyy hh:mi AM'), '36 Brewer Rd, Bentleigh VIC 3204', 120, 10000007, '100353', 'JACUBS26G17100401');
commit;

insert into offence values(
059, to_date('19-May-2017 08:59 AM', 'dd-Mon-yyyy hh:mi AM'), '30 Dendy St, Brighton VIC 3186', 107, 10000006, '100116', 'ZHWES4ZF8KLA12259');
commit;

insert into offence values(
060, to_date('02-Jun-2017 07:19 AM', 'dd-Mon-yyyy hh:mi AM'), '452 New St, Brighton VIC 3186', 109, 10000010, '100145', 'ZHWGE6BZ3DLA12625');
commit;

insert into offence values(
061, to_date('31-Jul-2017 10:43 AM', 'dd-Mon-yyyy hh:mi AM'), '239 Glenferrie Rd, Malvern VIC 3144', 102, 10000016, '100047', 'WAUZZZF1XKD037356');
commit;

insert into offence values(
062, to_date('4-Sep-2017 01:31 AM', 'dd-Mon-yyyy hh:mi AM'), 'Monash Fwy', 100, 10000002, '100047', 'WAUZZZF1XKD037356');
commit;

insert into offence values(
063, to_date('20-Dec-2017 08:20 PM', 'dd-Mon-yyyy hh:mi AM'), '62 Hudsons Rd, Spotswood VIC 3015',  123, 10000007, '100047', 'WAUZZZF1XKD037356');
commit;

insert into offence values(
064, to_date('2-Feb-2018 07:37 PM', 'dd-Mon-yyyy hh:mi AM'), '83 Leura Grove, Hawthorn East VIC 3123', 125, 10000019, '100353', 'JACUBS26G17100401');
commit;

insert into offence values(
065, to_date('20-Apr-2018 07:48 PM', 'dd-Mon-yyyy hh:mi AM'), '305 Camberwell Rd, Camberwell VIC 3124', 115, 10000014, '100086', 'JHEFY1EUPA0010911');
commit;

insert into offence values(
066, to_date('28-May-2018 02:54 AM', 'dd-Mon-yyyy hh:mi AM'), '904 Doncaster Rd, Doncaster East VIC 3109', 130, 10000014, '100095', 'WDDGF4HB8CR234192');
commit;

insert into offence values(
067, to_date('5-Jun-2018 02:06 PM', 'dd-Mon-yyyy hh:mi AM'), '24 Whitehorse Rd, Balwyn VIC 3103',  103, 10000003, '100116', 'ZHWES4ZF8KLA12259');
commit;

insert into offence values(
068, to_date('30-Jul-2018 11:54 PM', 'dd-Mon-yyyy hh:mi AM'), '1050 Burke Rd, Balwyn VIC 3103',  100, 10000015, '100116', 'ZHWES4ZF8KLA12259');
commit;

insert into offence values(
069, to_date('02-Sep-2018 12:12 AM', 'dd-Mon-yyyy hh:mi AM'), 'Mountain Hwy', 99, 10000015, '100258', 'JH2SC3302WM200321');
commit;

insert into offence values(
070, to_date('8-Oct-2018 05:32 AM', 'dd-Mon-yyyy hh:mi AM'), 'Eastern Fwy', 114, 10000001, '100086', 'JHEFY1EUPA0010911');

insert into suspension values(
'100086', to_date('8-Oct-2018', 'dd-Mon-yyyy'), to_date((select add_months('8-Mar-2019', 6) from dual), 'dd-Mon-yyyy'));
commit;

insert into offence values(
071,to_date( '11-Nov-2018 11:02 AM', 'dd-Mon-yyyy hh:mi AM'), 'Hume Fwy', 131, 10000010, '100116', 'ZHWES4ZF8KLA12259');

insert into suspension values(
'100116', to_date('11-Nov-2018',  'dd-Mon-yyyy'), to_date((select add_months('11-Nov-2018', 6) from dual), 'dd-Mon-yyyy'));

commit;

insert into offence values(
072, to_date('10-Dec-2018 01:29 AM', 'dd-Mon-yyyy hh:mi AM'), 'Hume Fwy', 100, 10000009, '100381', '1B3BP68J8MN518050');
commit;

insert into offence values(
073, to_date('17-Dec-2018 05:18 PM', 'dd-Mon-yyyy hh:mi AM'), '101 Ravenhill Blvd, Roxburgh Park VIC 3064', 124, 10000004, '100199', 'JTHCF1D20F123EV93');
commit;

insert into offence values(
074, to_date('10-Jan-2019 06:08 PM', 'dd-Mon-yyyy hh:mi AM'), 'Calder Fwy',  120, 10000007, '100353', 'JACUBS26G17100401');

insert into suspension values(
'100353', to_date('10-Jan-2019', 'dd-Mon-yyyy'), to_date((select add_months('10-Jan-2019', 6) from dual), 'dd-Mon-yyyy'));
commit;

insert into offence values(
075, to_date('12-Feb-2019 10:49 PM', 'dd-Mon-yyyy hh:mi AM'), '108 Clayton St, Ballarat Central VIC 3350',  111, 10000016, '100163', 'KMHDU45D19U618647');
commit;

insert into offence values(
076, to_date('23-Mar-2019 01:51 PM', 'dd-Mon-yyyy hh:mi AM'), '344 Belmore Rd, Balwyn VIC 3103',  123, 10000003, '100381', '1B3BP68J8MN518050');
commit;

insert into offence values(
077, to_date('2-Apr-2019 09:24 AM', 'dd-Mon-yyyy hh:mi AM'), 'Victoria Ave &, Britannia Mall, Mitcham VIC 3132', 109, 10000005, '100258', 'JH2SC3302WM200321');
commit;

insert into offence values(
078, to_date('4-Apr-2019 04:05 PM', 'dd-Mon-yyyy hh:mi AM'), '549 Geelong Rd, Brooklyn VIC 3012',  102, 10000010, '100095', 'WDDGF4HB8CR234192');
commit;

insert into offence values(
079, to_date('20-May-2019 05:22 PM', 'dd-Mon-yyyy hh:mi AM'), '62 Hudsons Rd, Spotswood VIC 3015',  113, 10000016, '100047', 'WAUZZZF1XKD037356');

insert into suspension values(
'100047', to_date('20-May-2019', 'dd-Mon-yyyy'), to_date((select add_months('20-May-2019',6) from dual), 'dd-Mon-yyyy'));
commit;

insert into offence values(
080, to_date('30-May-2019 02:52 PM', 'dd-Mon-yyyy hh:mi AM'), '62 Cook St, Port Melbourne VIC 3207',  108, 10000021, '100058', '4F2CZ06193KU35269');
commit;
