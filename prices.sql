--
-- File generated with SQLiteStudio v3.4.4 on Thu Jun 13 15:07:41 2024
--
-- Text encoding used: System
--

BEGIN;

-- Table: catlist
DROP TABLE IF EXISTS catlist;

CREATE TABLE IF NOT EXISTS catlist (
    id       INTEGER PRIMARY KEY AUTO_INCREMENT
                     NOT NULL,
    category TEXT
);

INSERT INTO catlist (id, category) VALUES (1, 'WATER');
INSERT INTO catlist (id, category) VALUES (2, 'SANITARY');
INSERT INTO catlist (id, category) VALUES (3, 'STORM');
INSERT INTO catlist (id, category) VALUES (4, 'ROAD');
INSERT INTO catlist (id, category) VALUES (5, 'SWPPP');
INSERT INTO catlist (id, category) VALUES (6, 'ELECTRICAL');
INSERT INTO catlist (id, category) VALUES (17, 'SITE');
INSERT INTO catlist (id, category) VALUES (21, 'SITE');
INSERT INTO catlist (id, category) VALUES (22, 'ROAD');
INSERT INTO catlist (id, category) VALUES (23, 'STORM');
INSERT INTO catlist (id, category) VALUES (24, 'WATER');

-- Table: estlist
DROP TABLE IF EXISTS estlist;

CREATE TABLE IF NOT EXISTS estlist (
    id          INTEGER PRIMARY KEY AUTO_INCREMENT
                        NOT NULL,
    estname     TEXT,
    description TEXT,
    unit        TEXT,
    price       REAL,
    quantity    REAL,
    cost        REAL
);

INSERT INTO estlist (id, estname, description, unit, price, quantity, cost) VALUES (113, 'test100', 'TYPE A INLET', 'EA', 1207.5, 5.0, 6037.5);
INSERT INTO estlist (id, estname, description, unit, price, quantity, cost) VALUES (114, 'test200', 'TYPE A INLET', 'EA', 1207.5, 4.0, 4830.0);
INSERT INTO estlist (id, estname, description, unit, price, quantity, cost) VALUES (115, 'test200', 'STORM SEWER OUTFALL STRAIGHT WINGWALL FOR 54" RCP', 'CY', 977.5, 200.0, 195500.0);
INSERT INTO estlist (id, estname, description, unit, price, quantity, cost) VALUES (116, 'test200', 'STORM SEWER OUTFALL STRAIGHT WINGWALL FOR 54" RCP', 'CY', 977.5, 100.0, 97750.0);
INSERT INTO estlist (id, estname, description, unit, price, quantity, cost) VALUES (117, 'test200', 'REMOVING OLD STRUCTURES – MANHOLES (ALL DEPTHS)', 'EA', 517.6, 1.0, 517.6);
INSERT INTO estlist (id, estname, description, unit, price, quantity, cost) VALUES (118, 'test300', 'STORM SEWER OUTFALL STRAIGHT WINGWALL FOR 54" RCP', 'CY', 977.5, 2000.0, 1955000.0);
INSERT INTO estlist (id, estname, description, unit, price, quantity, cost) VALUES (119, 'test300', 'REMOVING OLD STRUCTURES – MANHOLES (ALL DEPTHS)', 'EA', 517.6, 1.0, 517.6);
INSERT INTO estlist (id, estname, description, unit, price, quantity, cost) VALUES (125, 'test500', 'REMOVING OLD CONCRETE (PAVEMENT)', 'SY', 11.5, NULL, NULL);
INSERT INTO estlist (id, estname, description, unit, price, quantity, cost) VALUES (126, 'test500', 'REMOVING OLD CONCRETE (PAVEMENT)', 'SY', 11.5, NULL, NULL);
INSERT INTO estlist (id, estname, description, unit, price, quantity, cost) VALUES (127, 'test600', 'REMOVING OLD CONCRETE (PAVEMENT)', 'SY', 11.5, 10.0, 115.0);
INSERT INTO estlist (id, estname, description, unit, price, quantity, cost) VALUES (128, 'test600', 'REMOVING OLD CONCRETE (PAVEMENT)', 'SY', 11.5, 10.0, 115.0);
INSERT INTO estlist (id, estname, description, unit, price, quantity, cost) VALUES (129, 'test600', 'STORM SEWER OUTFALL STRAIGHT WINGWALL FOR 54" RCP', 'CY', 977.5, 10.0, 9775.0);
INSERT INTO estlist (id, estname, description, unit, price, quantity, cost) VALUES (130, 'test600', 'REMOVING OLD CONCRETE (PAVEMENT)', 'SY', 11.5, 10.0, 115.0);
INSERT INTO estlist (id, estname, description, unit, price, quantity, cost) VALUES (131, 'test600', '6" AWWA C900 PVC PIPE  INCL B&B', 'LF', 19.18, 10.0, 191.8);
INSERT INTO estlist (id, estname, description, unit, price, quantity, cost) VALUES (132, 'test1000', '6" AWWA C900 PVC FIRE HTYDRANT LEAD  ALL DEP', 'LF', 18.28, 1.0, 18.28);
INSERT INTO estlist (id, estname, description, unit, price, quantity, cost) VALUES (133, 'test1000', '8" AWWA C900 PVC PIPE INCL B&B', 'LF', 23.98, 10.0, 239.8);
INSERT INTO estlist (id, estname, description, unit, price, quantity, cost) VALUES (134, 'test1000', '8" AWWA C900 PVC PIPE W/R/J    ALL DEP THRUST BLOCKING, STD.', 'LF', 41.58, 10.0, 415.79999999999995);
INSERT INTO estlist (id, estname, description, unit, price, quantity, cost) VALUES (135, 'test1000', '6" AWWA C900 PVC PIPE  INCL B&B', 'LF', 19.18, 15.0, 287.7);

-- Table: estnamelist
DROP TABLE IF EXISTS estnamelist;

CREATE TABLE IF NOT EXISTS estnamelist (
    id      INTEGER PRIMARY KEY AUTO_INCREMENT
                    NOT NULL,
    estname TEXT,
    created DATE,
    updated DATE
);

INSERT INTO estnamelist (id, estname, created, updated) VALUES (88, 'test100', 'Tue Jun  4 00:00:00 2024', 'Sun Jun  9 00:00:00 2024');
INSERT INTO estnamelist (id, estname, created, updated) VALUES (89, 'test200', 'Fri Jun  7 00:00:00 2024', 'Sun Jun  9 00:00:00 2024');
INSERT INTO estnamelist (id, estname, created, updated) VALUES (94, 'test300', 'Fri Jun  7 00:00:00 2024', 'Fri Jun  7 00:00:00 2024');
INSERT INTO estnamelist (id, estname, created, updated) VALUES (100, 'test500', 'Tue Jun 11 00:00:00 2024', 'Tue Jun 11 00:00:00 2024');
INSERT INTO estnamelist (id, estname, created, updated) VALUES (101, 'test600', 'Tue Jun 11 00:00:00 2024', 'Tue Jun 11 00:00:00 2024');
INSERT INTO estnamelist (id, estname, created, updated) VALUES (102, 'test1000', 'Tue Jun 11 00:00:00 2024', 'Tue Jun 11 00:00:00 2024');

-- Table: items
DROP TABLE IF EXISTS items;

CREATE TABLE IF NOT EXISTS items (
    id          INTEGER PRIMARY KEY AUTO_INCREMENT
                        NOT NULL,
    category    TEXT,
    description TEXT,
    unit        TEXT,
    price       DECIMAL,
    location    TEXT
);

INSERT INTO items (id, category, description, unit, price, location) VALUES (287, 'SITE', 'PROJECT SIGN', 'EA', 825.7, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (288, 'SITE', 'CLEARING AND GRUBBING', 'LS', 158441.25, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (289, 'SITE', 'REMOVING OLD CONCRETE (PAVEMENT)', 'SY', 11.5, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (290, 'SITE', 'REMOVING OLD CONCRETE (SIDEWALK)', 'SY', 11.5, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (291, 'SITE', 'REMOVING OLD CONCRETE (CURB RAMP)', 'SY', 11.5, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (292, 'SITE', 'REMOVING OLD CONCRETE (STONE RIPRAP)', 'SY', 11.5, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (293, 'SITE', 'REMOVING OLD CONCRETE (SLOPE PAVING)', 'SY', 11.5, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (294, 'SITE', 'REMOVING OLD CONCRETE (CURB)', 'LF', 1.15, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (295, 'SITE', 'ROADWAY EXCAVATION INCLUDING 3" TOP SOIL', 'CY', 12.12, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (296, 'SITE', 'REMOVE AND DISPOSE OF EXISTING CONC RETE OR METAL PIPE (ALL', 'LF', 11.5, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (297, 'SITE', 'REMOVING OLD STRUCTURES - BOX CULVERTS', 'LF', 115, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (298, 'SITE', 'REMOVING OLD STRUCTURES – MANHOLES (ALL DEPTHS)', 'EA', 517.6, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (299, 'SITE', 'REMOVING OLD STRUCTURES - HEADWALL INCLUDING WINGWALLS', 'EA', 1725, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (300, 'SITE', 'REMOVE OLD STRUCTURES - DITCH INTERCEPTOR', 'EA', 1150, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (301, 'SITE', 'REMOVE FENCE (WOOD)', 'LF', 1.73, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (302, 'SITE', 'REMOVE CHAIN LINK FENCE', 'LF', 1.73, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (303, 'SITE', 'REMOVE BARBED WIRE FENCE', 'LF', 1.73, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (304, 'SITE', 'VIDEO RECORDING CONSTRUCTION', 'LS', 575, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (305, 'SITE', 'REMOVAL OF ALL STRIPING AND PAVEMENT MARKINGS', 'LF', 0.75, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (306, 'SITE', 'REMOVING PAVEMENT STRIPING AND MARKINGS', 'SF', 1.09, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (307, 'SITE', 'REMOVING PAVEMENT STRIPING AND MARKINGS (WORD)', 'EA', 40.25, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (308, 'SITE', 'REMOVING PAVEMENT STRIPING AND MARKINGS (ARROW)', 'EA', 40.25, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (309, 'ROAD', 'HYDRATED LIME (SLURRY) OR COMMERCIAL LIME SLURRY', 'TON', 201.25, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (310, 'ROAD', 'LIME-FLY ASH STABILIZED SUBGRADE (8" DEPTH)', 'SY', 2.53, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (311, 'ROAD', 'FLY ASH FOR STABILIZED SUBGRADE', 'TON', 98.9, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (312, 'ROAD', 'HMAC BASE COURSE (BLACK BASE)(5" THICK)', 'TON', 123.05, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (313, 'ROAD', 'HOT MIX - HOT LAID ASPHALTIC CONCRETE(2" THICK)', 'TON', 126.5, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (314, 'ROAD', 'CONCRETE PAVEMENT (10")', 'SY', 57.98, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (315, 'ROAD', 'CONCRETE PAVEMENT (10") (HIGH STRENGTH)', 'SY', 69.48, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (316, 'ROAD', 'CEMENT STABILIZED SAND, COMPLETE IN PLACE 8" THICK', 'SY', 12.17, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (317, 'ROAD', 'CONC PVMT (10" THICK DRVWY) (HES)', 'SY', 80.98, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (318, 'ROAD', 'REINFORCED CONCRETE CURB ( 6")', 'LF', 2.88, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (319, 'ROAD', '6" MONOLITHIC CURB & GUTTERS', 'LF', 8.63, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (320, 'ROAD', 'REINFORCED CONCRETE CURB (DOWELED)', 'LF', 5.75, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (321, 'ROAD', 'ADA RAMP - TYPE 9', 'EA', 1092.5, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (322, 'ROAD', 'ESPLANADES, MEDIANS AND DIRECTIONAL ISLANDS', 'SY', 69, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (323, 'ROAD', 'COLORING CONCRETE MEDIANS (BLACK)', 'SY', 5.75, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (324, 'STORM', 'STORM SEWER OUTFALL STRAIGHT WINGWALL FOR 54" RCP', 'CY', 977.5, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (325, 'STORM', 'TRENCH SAFETY SYSTEM (5'' TO 10'')', 'LF', 0.23, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (326, 'STORM', 'TRENCH SAFETY SYSTEM (10'' TO 15'')', 'LF', 0.58, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (327, 'STORM', 'JACKING AND BORING OR TUNNELING PIPE (42" RCP)', 'LF', 594.21, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (328, 'STORM', 'JACKING AND BORING OR TUNNELING PIPE (48" RCP)', 'LF', 680.8, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (329, 'STORM', 'JACKING AND BORING OR TUNNELING PIPE (54" RCP)', 'LF', 804.43, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (330, 'STORM', 'REINFORCED CONCRETE PIPE, C76, CLASS III, RUBBER GASKET (24")', 'LF', 81.25, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (331, 'STORM', 'REINFORCED CONCRETE PIPE, C76, CLASS III, RUBBER GASKET (30")', 'LF', 95.04, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (332, 'STORM', 'REINFORCED CONCRETE PIPE, C76, CLASS III, RUBBER GASKET (36")', 'LF', 118.58, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (333, 'STORM', 'REINFORCED CONCRETE PIPE, C76, CLASS III, RUBBER GASKET (42")', 'LF', 154.73, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (334, 'STORM', 'REINFORCED CONCRETE PIPE, C76, CLASS III, RUBBER GASKET (48")', 'LF', 175.56, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (335, 'STORM', 'REINFORCED CONCRETE PIPE, C76, CLASS III, RUBBER GASKET (54")', 'LF', 232.97, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (336, 'STORM', 'CONCRETE COLLAR (PER DETAILS IN PLANS)', 'EA', 287.5, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (337, 'STORM', 'CORRUGATED METAL PIPE (24")(PRE-COATED)(GALVANIZED)(16', 'LF', 51.75, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (338, 'STORM', 'SET (TYPE I) (S=3 FT) (HW=3 FT) (6:1) (P) W/ PIPE RUNNER', 'EA', 6325, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (339, 'STORM', 'SET (TYPE I) (S=4 FT) (HW=3 FT) (6:1) (P) W/ PIPE RUNNER', 'EA', 7820, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (340, 'STORM', 'SET (TYPE II) (30") (RCP) (3:1) (C)', 'EA', 1127, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (341, 'STORM', 'SET (TYPE II) (24") (RCP) (6:1) (P)', 'EA', 1052.25, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (342, 'STORM', 'SET (TYPE II) (36") (RCP) (6:1) (P) W/ PIPE RUNNER', 'EA', 3524.75, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (343, 'STORM', 'PRECAST MANHOLE ON RBC', 'EA', 1638.75, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (344, 'STORM', 'PRECAST CONCRETE STANDARD MANHOLE (5 FT ? DEPTH ? 10 FT)', 'EA', 3047.5, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (345, 'STORM', 'PRECAST CONCRETE EXTRA DEPTH MANHOLE (DEPTH>10 FT)', 'EA', 3484.5, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (346, 'STORM', 'TYPE A INLET', 'EA', 1207.5, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (347, 'STORM', 'TYPE C INLET', 'EA', 2449.5, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (348, 'STORM', 'MODIFIED TYPE B-B INLET', 'EA', 2938.25, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (349, 'STORM', 'TYPE C-1 INLET', 'EA', 3289, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (350, 'STORM', 'TYPE C-2 INLET', 'EA', 3335, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (351, 'STORM', 'ADJUSTING MANHOLE AND INLETS', 'EA', 402.5, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (352, 'STORM', 'PRECAST RCB (10'' X 10'')', 'LF', 870.52, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (353, 'STORM', 'PRECAST RCB (7'' X 7'')', 'LF', 523.61, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (354, 'STORM', 'PRECAST RCB (3'' X 2'')', 'LF', 204.25, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (355, 'STORM', 'PRECAST RCB (4'' X 2'')', 'LF', 214.3, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (356, 'STORM', 'RIPRAP GRADE NO. 1(18")', 'SY', 74.75, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (357, 'STORM', 'REINFORCED CONCRETE SLOPE PAVING (5")', 'SY', 97.75, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (358, 'STORM', 'HEADWALL (CH-FW-0)(36")', 'EA', 14375, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (359, 'STORM', 'WINGWALL(PW-1) (HW=16FT)', 'EA', 86250, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (360, 'STORM', 'BACKSLOPE INTERCEPTOR STRUCTURE', 'EA', 2300, 'HOUSTON');
INSERT INTO items (id, category, description, unit, price, location) VALUES (446, 'WATER', '6" AWWA C900 PVC PIPE  INCL B&B', 'LF', 19.18, 'BELLAIRE');
INSERT INTO items (id, category, description, unit, price, location) VALUES (447, 'WATER', '8" AWWA C900 PVC PIPE INCL B&B', 'LF', 23.98, 'BELLAIRE');
INSERT INTO items (id, category, description, unit, price, location) VALUES (448, 'WATER', '8" AWWA C900 PVC PIPE W/R/J    ALL DEP THRUST BLOCKING, STD.', 'LF', 41.58, 'BELLAIRE');
INSERT INTO items (id, category, description, unit, price, location) VALUES (449, 'WATER', '8" AWWA C-900 PVC PIPE R/J, SPACERS & END SEALS, THRUST BLOCKING, ACCESS PITS, DEWATERING, , ALL DEPTHS', 'LF', 44.48, 'BELLAIRE');
INSERT INTO items (id, category, description, unit, price, location) VALUES (450, 'WATER', '6" G V & BOX', 'EA', 688, 'BELLAIRE');
INSERT INTO items (id, category, description, unit, price, location) VALUES (451, 'WATER', '8" G V & BOX', 'EA', 1028, 'BELLAIRE');
INSERT INTO items (id, category, description, unit, price, location) VALUES (452, 'WATER', 'STD FIRE HYDRANT', 'EA', 2998, 'BELLAIRE');
INSERT INTO items (id, category, description, unit, price, location) VALUES (453, 'WATER', '6" AWWA C900 PVC FIRE HTYDRANT LEAD  ALL DEP', 'LF', 18.28, 'BELLAIRE');
INSERT INTO items (id, category, description, unit, price, location) VALUES (454, 'WATER', 'DUCTILE IRON FITTINGS', 'TON', 6398, 'BELLAIRE');

-- Table: loclist
DROP TABLE IF EXISTS loclist;

CREATE TABLE IF NOT EXISTS loclist (
    id       INTEGER PRIMARY KEY AUTO_INCREMENT
                     NOT NULL,
    location TEXT
);

INSERT INTO loclist (id, location) VALUES (1, 'HOUSTON');
INSERT INTO loclist (id, location) VALUES (2, 'GALVESTON');
INSERT INTO loclist (id, location) VALUES (3, 'CONROE');
INSERT INTO loclist (id, location) VALUES (4, 'KATY');
INSERT INTO loclist (id, location) VALUES (5, 'PEARLAND');
INSERT INTO loclist (id, location) VALUES (6, 'SUGAR LAND');
INSERT INTO loclist (id, location) VALUES (7, 'ROSENBERG');
INSERT INTO loclist (id, location) VALUES (8, 'HARRIS COUNTY PCT 1');
INSERT INTO loclist (id, location) VALUES (9, 'HARRIS COUNTY PCT 2');
INSERT INTO loclist (id, location) VALUES (10, 'HARRIS COUNTY PCT 3');
INSERT INTO loclist (id, location) VALUES (11, 'HARRIS COUNTY PCT 4');
INSERT INTO loclist (id, location) VALUES (20, 'HOUSTON');
INSERT INTO loclist (id, location) VALUES (21, 'BELLAIRE');

COMMIT;

