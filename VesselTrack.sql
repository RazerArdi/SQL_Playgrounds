CREATE TABLE aerospace_company (
    id_enggine          VARCHAR2(30) NOT NULL,
    email               VARCHAR2(50) NOT NULL,
    origin              VARCHAR2(30),
    address             VARCHAR2(100),
    sparepart           VARCHAR2(1000),
    vessel_id           INTEGER NOT NULL,
    satellite_id_permit VARCHAR2(50) NOT NULL,
    vessel_id_company   VARCHAR2(20) NOT NULL,
    vessel_imo_id_imo   VARCHAR2(30) NOT NULL,
    vessel_mmsi_id_mmsi VARCHAR2(30) NOT NULL,
    id_imo              VARCHAR2(30) NOT NULL,
    PRIMARY KEY (id_enggine)
);

CREATE TABLE affiliate (
    id_member        VARCHAR2(15) NOT NULL,
    stakeholders     VARCHAR2(100) NOT NULL,
    background_track VARCHAR2(200),
    vessel_company_id_company VARCHAR2(20) NOT NULL,
    PRIMARY KEY (id_member)
);

CREATE TABLE affiliate_company (
    id_transfer_tech VARCHAR2(30) NOT NULL,
    name             VARCHAR2(30) NOT NULL,
    prog_coop        VARCHAR2(30) NOT NULL,
    aerospace_comp_id VARCHAR2(30) NOT NULL,
    doc              VARCHAR2(4000),
    PRIMARY KEY (id_transfer_tech)
);

CREATE TABLE category_of_stakeholders (
    id                  VARCHAR2(30) NOT NULL,
    pyramid_level       VARCHAR2(30) NOT NULL,
    affiliate_id_member VARCHAR2(15) NOT NULL,
    PRIMARY KEY (id)
);

CREATE UNIQUE INDEX category_stakeholders_idx ON category_of_stakeholders (affiliate_id_member);

CREATE TABLE dept_hs (
    ministry_id_case VARCHAR2(30) NOT NULL,
    id               VARCHAR2(30) NOT NULL,
    issue            VARCHAR2(100) NOT NULL,
    email            VARCHAR2(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE UNIQUE INDEX dept_hs_idx ON dept_hs (ministry_id_case);

CREATE TABLE dept_trans (
    ministry_id_case VARCHAR2(30) NOT NULL,
    id               VARCHAR2(30) NOT NULL,
    issue            VARCHAR2(100) NOT NULL,
    email            VARCHAR2(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE UNIQUE INDEX dept_trans_idx ON dept_trans (ministry_id_case);

CREATE TABLE deptenergy (
    ministry_id_case VARCHAR2(30) NOT NULL,
    id               VARCHAR2(30) NOT NULL,
    issue            VARCHAR2(100) NOT NULL,
    email            VARCHAR2(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE UNIQUE INDEX dept_energy_idx ON deptenergy (ministry_id_case);

CREATE TABLE dod (
    ministry_id_case VARCHAR2(30) NOT NULL,
    id               VARCHAR2(30) NOT NULL,
    issue            VARCHAR2(100) NOT NULL,
    email            VARCHAR2(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE UNIQUE INDEX dod_idx ON dod (ministry_id_case);

CREATE TABLE govt (
    id_permit              INTEGER NOT NULL,
    flag                   VARCHAR2(30) NOT NULL,
    national_documentation VARCHAR2(10) NOT NULL,
    satellite_id_permit    VARCHAR2(50) NOT NULL,
    PRIMARY KEY (id_permit)
);

CREATE TABLE govt_company (
    company_id                  VARCHAR2(20) NOT NULL,
    category_of_stakeholders_id VARCHAR2(30) NOT NULL,
    address                     VARCHAR2(30) NOT NULL,
    email                       VARCHAR2(30) NOT NULL,
    project_program             VARCHAR2(30),
    id                          VARCHAR2(30) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (company_id)
);

CREATE TABLE imo (
    call_sign             VARCHAR2(20) NOT NULL,
    name                  VARCHAR2(30) NOT NULL,
    ais_transponder_class VARCHAR2(20) NOT NULL,
    general_vessel_type   VARCHAR2(20),
    detailed_vessel_type  VARCHAR2(20),
    id_imo                VARCHAR2(30) NOT NULL,
    PRIMARY KEY (id_imo)
);

CREATE TABLE ministry (
    id_case          VARCHAR2(30) NOT NULL,
    chairperson_name CHAR(100) NOT NULL,
    supervisor       CHAR(100) NOT NULL,
    obs_report       VARCHAR2(50),
    govt_id_permit   INTEGER NOT NULL,
    id_permit        INTEGER NOT NULL,
    id_permit1       INTEGER NOT NULL,
    PRIMARY KEY (id_case)
);

CREATE UNIQUE INDEX ministry_idx ON ministry (govt_id_permit);

CREATE TABLE mmsi (
    departure_from VARCHAR2(20) NOT NULL,
    arrival_at     VARCHAR2(20) NOT NULL,
    start_date     DATE NOT NULL,
    end_date       DATE NOT NULL,
    satellite_imo1 INTEGER NOT NULL,
    id_mmsi        VARCHAR2(30) NOT NULL,
    PRIMARY KEY (id_mmsi)
);

CREATE TABLE private_company (
    company_id                  VARCHAR2(20) NOT NULL,
    address                     VARCHAR2(100) NOT NULL,
    email                       VARCHAR2(30) NOT NULL,
    project_program             VARCHAR2(30),
    category_of_stakeholders_id VARCHAR2(30) NOT NULL,
    id                          VARCHAR2(30) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (company_id)
);

CREATE TABLE private_investor (
    id                          VARCHAR2(30) NOT NULL,
    full_name                   VARCHAR2(40) NOT NULL,
    origin                      CHAR(50) NOT NULL,
    phone_number                INTEGER NOT NULL,
    total_investment            VARCHAR2(30),
    category_of_stakeholders_id VARCHAR2(30) NOT NULL,
    id1                         VARCHAR2(30) NOT NULL,
    PRIMARY KEY (id1),
    UNIQUE (id)
);

CREATE TABLE satellite (
    id_permit                     VARCHAR2(50) NOT NULL,
    real_time_coordinates         VARCHAR2(20) NOT NULL,
    imo_id_imo                    VARCHAR2(30) NOT NULL,
    mmsi_id_mmsi                  VARCHAR2(30) NOT NULL,
    weather_and_marine_conditions VARCHAR2(100) NOT NULL,
    id_imo                        VARCHAR2(30) NOT NULL,
    PRIMARY KEY (id_permit)
);

CREATE UNIQUE INDEX satellite_idx ON satellite (mmsi_id_mmsi);

CREATE TABLE vessel (
    id                   INTEGER NOT NULL,
    general_vessel_type  VARCHAR2(20) NOT NULL,
    detailed_vessel_type VARCHAR2(20),
    company_id_company   VARCHAR2(20) NOT NULL,
    id_company           VARCHAR2(20) NOT NULL,
    imo_id_imo           VARCHAR2(30) NOT NULL,
    mmsi_id_mmsi         VARCHAR2(30) NOT NULL,
    id_imo               VARCHAR2(30) NOT NULL,
    PRIMARY KEY (id, id_company, imo_id_imo, mmsi_id_mmsi)
);

CREATE UNIQUE INDEX vessel_idx ON vessel (company_id_company);

CREATE TABLE vessel_company (
    company_name VARCHAR2(20) NOT NULL,
    id_company   VARCHAR2(20) NOT NULL,
    cost         NUMBER,
    id_permit    INTEGER NOT NULL,
    id_permit2   INTEGER NOT NULL,
    PRIMARY KEY (id_company)
);

ALTER TABLE aerospace_company
    ADD CONSTRAINT ac_sat_fk FOREIGN KEY (satellite_id_permit)
    REFERENCES satellite (id_permit);

ALTER TABLE aerospace_company
    ADD CONSTRAINT ac_vessel_fk FOREIGN KEY (vessel_id, vessel_id_company, vessel_imo_id_imo, vessel_mmsi_id_mmsi)
    REFERENCES vessel (id, id_company, imo_id_imo, mmsi_id_mmsi);

ALTER TABLE affiliate_company
    ADD CONSTRAINT affcomp_ac_fk FOREIGN KEY (aerospace_comp_id)
    REFERENCES aerospace_company (id_enggine);

ALTER TABLE affiliate
    ADD CONSTRAINT aff_vc_fk FOREIGN KEY (vessel_company_id_company)
    REFERENCES vessel_company (id_company);

ALTER TABLE category_of_stakeholders
    ADD CONSTRAINT catst_aff_fk FOREIGN KEY (affiliate_id_member)
    REFERENCES affiliate (id_member);

ALTER TABLE dept_hs
    ADD CONSTRAINT hs_min_fk FOREIGN KEY (ministry_id_case)
    REFERENCES ministry (id_case);

ALTER TABLE dept_trans
    ADD CONSTRAINT trans_min_fk FOREIGN KEY (ministry_id_case)
    REFERENCES ministry (id_case);

ALTER TABLE deptenergy
    ADD CONSTRAINT energy_min_fk FOREIGN KEY (ministry_id_case)
    REFERENCES ministry (id_case);

ALTER TABLE dod
    ADD CONSTRAINT dod_min_fk FOREIGN KEY (ministry_id_case)
    REFERENCES ministry (id_case);

ALTER TABLE govt_company
    ADD CONSTRAINT govtcomp_catst_fk FOREIGN KEY (category_of_stakeholders_id)
    REFERENCES category_of_stakeholders (id);

ALTER TABLE govt
    ADD CONSTRAINT govt_sat_fk FOREIGN KEY (satellite_id_permit)
    REFERENCES satellite (id_permit);

ALTER TABLE ministry
    ADD CONSTRAINT min_govt_fk FOREIGN KEY (govt_id_permit)
    REFERENCES govt (id_permit);

ALTER TABLE private_company
    ADD CONSTRAINT pcomp_catst_fk FOREIGN KEY (category_of_stakeholders_id)
    REFERENCES category_of_stakeholders (id);

ALTER TABLE private_investor
    ADD CONSTRAINT pinv_catst_fk FOREIGN KEY (category_of_stakeholders_id)
    REFERENCES category_of_stakeholders (id);

ALTER TABLE satellite
    ADD CONSTRAINT sat_imo_fk FOREIGN KEY (imo_id_imo)
    REFERENCES imo (id_imo);

ALTER TABLE satellite
    ADD CONSTRAINT sat_mmsi_fk FOREIGN KEY (mmsi_id_mmsi)
    REFERENCES mmsi (id_mmsi);

ALTER TABLE vessel
    ADD CONSTRAINT ves_imo_fk FOREIGN KEY (imo_id_imo)
    REFERENCES imo (id_imo);

ALTER TABLE vessel
    ADD CONSTRAINT ves_mmsi_fk FOREIGN KEY (mmsi_id_mmsi)
    REFERENCES mmsi (id_mmsi);

ALTER TABLE vessel
    ADD CONSTRAINT ves_vcomp_fk FOREIGN KEY (company_id_company)
    REFERENCES vessel_company (id_company);
