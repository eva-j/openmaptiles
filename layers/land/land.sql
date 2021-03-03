-- ne_10m_land
-- etldoc:  ne_10m_land ->  ne_10m_land_gen_z5
DROP MATERIALIZED VIEW IF EXISTS ne_10m_land_gen_z5 CASCADE;
CREATE MATERIALIZED VIEW ne_10m_land_gen_z5 AS
(
SELECT ST_Simplify(geometry, ZRes(7)) AS geometry,
       'land'::text AS class
FROM ne_10m_land
    ) /* DELAY_MATERIALIZED_VIEW_CREATION */ ;
CREATE INDEX IF NOT EXISTS ne_10m_land_gen_z5_idx ON ne_10m_land_gen_z5 USING gist (geometry);

-- ne_50m_land
-- etldoc:  ne_50m_land ->  ne_50m_land_gen_z4
DROP MATERIALIZED VIEW IF EXISTS ne_50m_land_gen_z4 CASCADE;
CREATE MATERIALIZED VIEW ne_50m_land_gen_z4 AS
(
SELECT ogc_fid,
       ST_Simplify(geometry, ZRes(6)) AS geometry,
       'land'::text AS class
FROM ne_50m_land
    ) /* DELAY_MATERIALIZED_VIEW_CREATION */ ;
CREATE INDEX IF NOT EXISTS ne_50m_land_gen_z4_idx ON ne_50m_land_gen_z4 USING gist (geometry);

-- etldoc:  ne_50m_land_gen_z4 ->  ne_50m_land_gen_z3
DROP MATERIALIZED VIEW IF EXISTS ne_50m_land_gen_z3 CASCADE;
CREATE MATERIALIZED VIEW ne_50m_land_gen_z3 AS
(
SELECT ogc_fid,
       ST_Simplify(geometry, ZRes(5)) AS geometry,
       class
FROM ne_50m_land_gen_z4
    ) /* DELAY_MATERIALIZED_VIEW_CREATION */ ;
CREATE INDEX IF NOT EXISTS ne_50m_land_gen_z3_idx ON ne_50m_land_gen_z3 USING gist (geometry);

-- etldoc:  ne_50m_land_gen_z3 ->  ne_50m_land_gen_z2
DROP MATERIALIZED VIEW IF EXISTS ne_50m_land_gen_z2 CASCADE;
CREATE MATERIALIZED VIEW ne_50m_land_gen_z2 AS
(
SELECT ogc_fid,
       ST_Simplify(geometry, ZRes(4)) AS geometry,
       class
FROM ne_50m_land_gen_z3
    ) /* DELAY_MATERIALIZED_VIEW_CREATION */ ;
CREATE INDEX IF NOT EXISTS ne_50m_land_gen_z2_idx ON ne_50m_land_gen_z2 USING gist (geometry);

-- ne_110m_land
-- etldoc:  ne_110m_land ->  ne_110m_land_gen_z1
DROP MATERIALIZED VIEW IF EXISTS ne_110m_land_gen_z1 CASCADE;
CREATE MATERIALIZED VIEW ne_110m_land_gen_z1 AS
(
SELECT ogc_fid,
       ST_Simplify(geometry, ZRes(3)) AS geometry,
       'land'::text AS class
FROM ne_110m_land
    ) /* DELAY_MATERIALIZED_VIEW_CREATION */ ;
CREATE INDEX IF NOT EXISTS ne_110m_land_gen_z1_idx ON ne_110m_land_gen_z1 USING gist (geometry);

-- etldoc:  ne_110m_land_gen_z1 ->  ne_110m_land_gen_z0
DROP MATERIALIZED VIEW IF EXISTS ne_110m_land_gen_z0 CASCADE;
CREATE MATERIALIZED VIEW ne_110m_land_gen_z0 AS
(
SELECT ogc_fid,
       ST_Simplify(geometry, ZRes(2)) AS geometry,
       class
FROM ne_110m_land_gen_z1
    ) /* DELAY_MATERIALIZED_VIEW_CREATION */ ;
CREATE INDEX IF NOT EXISTS ne_110m_land_gen_z0_idx ON ne_110m_land_gen_z0 USING gist (geometry);




CREATE OR REPLACE VIEW land_z0 AS
(
-- etldoc:  ne_110m_land_gen_z0 ->  land_z0
SELECT geometry,
       'land'::text AS class
FROM ne_110m_land_gen_z0
    );

CREATE OR REPLACE VIEW land_z1 AS
(
-- etldoc:  ne_110m_land_gen_z1 ->  land_z1
SELECT geometry,
       'land'::text AS class
FROM ne_110m_land_gen_z1
    );

CREATE OR REPLACE VIEW land_z2 AS
(
-- etldoc:  ne_50m_land ->  land_z2
SELECT geometry,
       'land'::text AS class
FROM ne_50m_land
    );

CREATE OR REPLACE VIEW land_z3 AS
(
-- etldoc:  ne_50m_land ->  land_z3
SELECT geometry,
       'land'::text AS class
FROM ne_50m_land
    );

CREATE OR REPLACE VIEW land_z4 AS
(
-- etldoc:  ne_50m_land ->  land_z4
SELECT geometry,
       'land'::text AS class
FROM ne_50m_land
    );

CREATE OR REPLACE VIEW land_z5 AS
(
-- etldoc:  ne_10m_land ->  land_z5
SELECT geometry,
       'land'::text AS class
FROM ne_10m_land
    );

CREATE OR REPLACE VIEW land_z6 AS
(
-- etldoc:  osm_land_polygon_gen_z6 ->  land_z6
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_gen_z6
    );

CREATE OR REPLACE VIEW land_z7 AS
(
-- etldoc:  osm_land_polygon_gen_z7 ->  land_z7
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_gen_z7
    );

CREATE OR REPLACE VIEW land_z8 AS
(
-- etldoc:  osm_land_polygon_gen_z8 ->  land_z8
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_gen_z8
    );

CREATE OR REPLACE VIEW land_z9 AS
(
-- etldoc:  osm_land_polygon_gen_z9 ->  land_z9
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_gen_z9
    );

CREATE OR REPLACE VIEW land_z10 AS
(
-- etldoc:  osm_land_polygon_gen_z10 ->  land_z10
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_gen_z10
    );

CREATE OR REPLACE VIEW land_z11 AS
(
-- etldoc:  osm_land_polygon_gen_z11 ->  land_z11
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_gen_z11
    );

CREATE OR REPLACE VIEW land_z12 AS
(
-- etldoc:  osm_land_polygon ->  land_z12
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon
    );

-- etldoc: layer_land [shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="layer_land |<z0> z0|<z1>z1|<z2>z2|<z3>z3 |<z4> z4|<z5>z5|<z6>z6|<z7>z7| <z8> z8 |<z9> z9 |<z10> z10 |<z11> z11 |<z12> z12+" ] ;

CREATE OR REPLACE FUNCTION layer_land(bbox geometry, zoom_level int)
    RETURNS TABLE
            (
                geometry     geometry,
                class        text
            )
AS
$$
SELECT geometry,
       class::text
FROM (
         -- etldoc: land_z0 ->  layer_land:z0
         SELECT *
         FROM land_z0
         WHERE zoom_level = 0
         UNION ALL
         -- etldoc: land_z1 ->  layer_land:z1
         SELECT *
         FROM land_z1
         WHERE zoom_level = 1
         UNION ALL
         -- etldoc: land_z2 ->  layer_land:z2
         SELECT *
         FROM land_z2
         WHERE zoom_level = 2
         UNION ALL
         -- etldoc: land_z3 ->  layer_land:z3
         SELECT *
         FROM land_z3
         WHERE zoom_level = 3
         UNION ALL
         -- etldoc: land_z4 ->  layer_land:z4
         SELECT *
         FROM land_z4
         WHERE zoom_level = 4
         UNION ALL
         -- etldoc: land_z5 ->  layer_land:z5
         SELECT *
         FROM land_z5
         WHERE zoom_level = 5
         UNION ALL
         -- etldoc: land_z6 ->  layer_land:z6
         SELECT *
         FROM land_z6
         WHERE zoom_level = 6
         UNION ALL
         -- etldoc: land_z7 ->  layer_land:z7
         SELECT *
         FROM land_z7
         WHERE zoom_level = 7
         UNION ALL
         -- etldoc: land_z8 ->  layer_land:z8
         SELECT *
         FROM land_z8
         WHERE zoom_level = 8
         UNION ALL
         -- etldoc: land_z9 ->  layer_land:z9
         SELECT *
         FROM land_z9
         WHERE zoom_level = 9
         UNION ALL
         -- etldoc: land_z10 ->  layer_land:z10
         SELECT *
         FROM land_z10
         WHERE zoom_level = 10
         UNION ALL
         -- etldoc: land_z11 ->  layer_land:z11
         SELECT *
         FROM land_z11
         WHERE zoom_level = 11
         UNION ALL
         -- etldoc: land_z12 ->  layer_land:z12
         SELECT *
         FROM land_z12
         WHERE zoom_level >= 12
     ) AS zoom_levels
WHERE geometry && bbox;
$$ LANGUAGE SQL STABLE
                -- STRICT
                PARALLEL SAFE;
