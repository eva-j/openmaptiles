-- ne_10m_land

-- etldoc:  ne_10m_land ->  ne_10m_land_gen_z5
DROP MATERIALIZED VIEW IF EXISTS ne_10m_land_gen_z5 CASCADE;
CREATE MATERIALIZED VIEW ne_10m_land_gen_z5 AS
(
SELECT fid,
       ST_MakeValid(ST_Simplify(geometry, ZRes(7))) AS geometry,
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
       ST_MakeValid(ST_Simplify(geometry, ZRes(6))) AS geometry,
       'land'::text AS class
FROM ne_50m_land
    ) /* DELAY_MATERIALIZED_VIEW_CREATION */ ;
CREATE INDEX IF NOT EXISTS ne_50m_land_gen_z4_idx ON ne_50m_land_gen_z4 USING gist (geometry);

-- etldoc:  ne_50m_land_gen_z4 ->  ne_50m_land_gen_z3
DROP MATERIALIZED VIEW IF EXISTS ne_50m_land_gen_z3 CASCADE;
CREATE MATERIALIZED VIEW ne_50m_land_gen_z3 AS
(
SELECT ogc_fid,
       ST_MakeValid(ST_Simplify(geometry, ZRes(5))) AS geometry,
       class
FROM ne_50m_land_gen_z4
    ) /* DELAY_MATERIALIZED_VIEW_CREATION */ ;
CREATE INDEX IF NOT EXISTS ne_50m_land_gen_z3_idx ON ne_50m_land_gen_z3 USING gist (geometry);

-- etldoc:  ne_50m_land_gen_z3 ->  ne_50m_land_gen_z2
DROP MATERIALIZED VIEW IF EXISTS ne_50m_land_gen_z2 CASCADE;
CREATE MATERIALIZED VIEW ne_50m_land_gen_z2 AS
(
SELECT ogc_fid,
       ST_MakeValid(ST_Simplify(geometry, ZRes(4))) AS geometry,
       class
FROM ne_50m_land_gen_z3
    ) /* DELAY_MATERIALIZED_VIEW_CREATION */ ;
CREATE INDEX IF NOT EXISTS ne_50m_land_gen_z2_idx ON ne_50m_land_gen_z2 USING gist (geometry);


-- ne_110m_land

-- etldoc:  ne_110m_land ->  ne_110m_land_gen_z1
DROP MATERIALIZED VIEW IF EXISTS ne_110m_land_gen_z1 CASCADE;
CREATE MATERIALIZED VIEW ne_110m_land_gen_z1 AS
--CREATE OR REPLACE TABLE ne_110m_land_gen_z1 AS
(
SELECT ogc_fid,
       ST_MakeValid(ST_Simplify(geometry, ZRes(3))) AS geometry,
       'land'::text AS class
FROM ne_110m_land
    ) /* DELAY_MATERIALIZED_VIEW_CREATION */ ;
CREATE INDEX IF NOT EXISTS ne_110m_land_gen_z1_idx ON ne_110m_land_gen_z1 USING gist (geometry);

-- etldoc:  ne_110m_land_gen_z1 ->  ne_110m_land_gen_z0
DROP MATERIALIZED VIEW IF EXISTS ne_110m_land_gen_z0 CASCADE;
CREATE MATERIALIZED VIEW ne_110m_land_gen_z0 AS
--CREATE OR REPLACE TABLE ne_110m_land_gen_z0 AS
(
SELECT ogc_fid,
       ST_MakeValid(ST_Simplify(geometry, ZRes(2))) AS geometry,
       class
FROM ne_110m_land_gen_z1
    ) /* DELAY_MATERIALIZED_VIEW_CREATION */ ;
CREATE INDEX IF NOT EXISTS ne_110m_land_gen_z0_idx ON ne_110m_land_gen_z0 USING gist (geometry);



-- etldoc:  ne_110m_land_gen_z0 ->  land_z0
-- etldoc:  ne_110m_lakes_gen_z0 ->  land_z0
CREATE OR REPLACE VIEW land_z0 AS
(
WITH temp AS
    (
    SELECT l.ogc_fid, ST_Union(w.geometry) AS geometry
    FROM ne_110m_land_gen_z0 l JOIN ne_110m_lakes_gen_z0 w ON ST_Intersects(w.geometry, l.geometry)
    GROUP BY l.ogc_fid
    )
SELECT ST_Difference(l.geometry, COALESCE(t.geometry, ST_SetSRID('GEOMETRYCOLLECTION EMPTY'::geometry, 3857))) AS geometry,
       l.class
FROM ne_110m_land_gen_z0 l LEFT JOIN temp t ON l.ogc_fid = t.ogc_fid
    );

-- etldoc:  ne_110m_land_gen_z1 ->  land_z1
-- etldoc:  ne_110m_lakes_gen_z1 ->  land_z1
CREATE OR REPLACE VIEW land_z1 AS
(
WITH temp AS
    (
    SELECT l.ogc_fid, ST_Union(w.geometry) AS geometry
    FROM ne_110m_land_gen_z1 l JOIN ne_110m_lakes_gen_z1 w ON ST_Intersects(w.geometry, l.geometry)
    GROUP BY l.ogc_fid
    )
SELECT ST_Difference(l.geometry, COALESCE(t.geometry, ST_SetSRID('GEOMETRYCOLLECTION EMPTY'::geometry, 3857))) AS geometry,
       l.class
FROM ne_110m_land_gen_z1 l LEFT JOIN temp t ON l.ogc_fid = t.ogc_fid
    );

-- etldoc:  ne_50m_land_gen_z2 ->  land_z2
-- etldoc:  ne_50m_lakes_gen_z2 ->  land_z2
CREATE OR REPLACE VIEW land_z2 AS
(
WITH temp AS
    (
    SELECT l.ogc_fid, ST_Union(w.geometry) AS geometry
    FROM ne_50m_land_gen_z2 l JOIN ne_50m_lakes_gen_z2 w ON ST_Intersects(w.geometry, l.geometry)
    GROUP BY l.ogc_fid
    )
SELECT ST_Difference(l.geometry, COALESCE(t.geometry, ST_SetSRID('GEOMETRYCOLLECTION EMPTY'::geometry, 3857))) AS geometry,
       l.class
FROM ne_50m_land_gen_z2 l LEFT JOIN temp t ON l.ogc_fid = t.ogc_fid
    );

-- etldoc:  ne_50m_land_gen_z3 ->  land_z3
-- etldoc:  ne_50m_lakes_gen_z3 ->  land_z3
CREATE OR REPLACE VIEW land_z3 AS
(
WITH temp AS
    (
    SELECT l.ogc_fid, ST_Union(w.geometry) AS geometry
    FROM ne_50m_land_gen_z3 l JOIN ne_50m_lakes_gen_z3 w ON ST_Intersects(w.geometry, l.geometry)
    GROUP BY l.ogc_fid
    )
SELECT ST_Difference(l.geometry, COALESCE(t.geometry, ST_SetSRID('GEOMETRYCOLLECTION EMPTY'::geometry, 3857))) AS geometry,
       l.class
FROM ne_50m_land_gen_z3 l LEFT JOIN temp t ON l.ogc_fid = t.ogc_fid
    );

-- etldoc:  ne_50m_land_gen_z4 ->  land_z4
-- etldoc:  ne_10m_lakes_gen_z4 ->  land_z4
CREATE OR REPLACE VIEW land_z4 AS
(
WITH temp AS
    (
    SELECT l.ogc_fid, ST_Union(w.geometry) AS geometry
    FROM ne_50m_land_gen_z4 l JOIN ne_10m_lakes_gen_z4 w ON ST_Intersects(w.geometry, l.geometry)
    WHERE ST_GeometryType(w.geometry) IN ('ST_MultiPolygon','ST_Polygon')
    GROUP BY l.ogc_fid
    )
SELECT ST_Difference(l.geometry, COALESCE(t.geometry, ST_SetSRID('GEOMETRYCOLLECTION EMPTY'::geometry, 3857))) AS geometry,
       l.class
FROM ne_50m_land_gen_z4 l LEFT JOIN temp t ON l.ogc_fid = t.ogc_fid
    );

-- etldoc:  ne_10m_land_gen_z5 ->  land_z5
-- etldoc:  ne_10m_lakes_gen_z5 ->  land_z5
CREATE OR REPLACE VIEW land_z5 AS
(
WITH temp AS
    (
    SELECT l.fid, ST_Union(w.geometry) AS geometry
    FROM ne_10m_land_gen_z5 l JOIN ne_10m_lakes_gen_z5 w ON ST_Intersects(w.geometry, l.geometry)
    WHERE ST_GeometryType(w.geometry) IN ('ST_MultiPolygon','ST_Polygon')
    GROUP BY l.fid
    )
SELECT ST_Difference(l.geometry, COALESCE(t.geometry, ST_SetSRID('GEOMETRYCOLLECTION EMPTY'::geometry, 3857))) AS geometry,
       l.class
FROM ne_10m_land_gen_z5 l LEFT JOIN temp t ON l.fid = t.fid
    );

-- etldoc:  osm_land_polygon_gen_z6 ->  land_z6
-- etldoc:  osm_water_polygon_gen_z6 ->  land_z6
CREATE OR REPLACE VIEW land_z6 AS
(
WITH temp AS
    (
    SELECT l.fid, ST_Union(w.geometry) AS geometry
    FROM osm_land_polygon_gen_z6 l JOIN osm_water_polygon_gen_z6 w ON ST_Intersects(w.geometry, l.geometry)
    GROUP BY l.fid
    )
SELECT ST_Difference(l.geometry, COALESCE(t.geometry, ST_SetSRID('GEOMETRYCOLLECTION EMPTY'::geometry, 3857))) AS geometry,
       'land'::text AS class
FROM osm_land_polygon_gen_z6 l LEFT JOIN temp t ON l.fid = t.fid
    );

-- etldoc:  osm_land_polygon_gen_z7 ->  land_z7
-- etldoc:  osm_water_polygon_gen_z7 ->  land_z7
CREATE OR REPLACE VIEW land_z7 AS
(
WITH temp AS
    (
    SELECT l.fid, ST_Union(w.geometry) AS geometry
    FROM osm_land_polygon_gen_z7 l JOIN osm_water_polygon_gen_z7 w ON ST_Intersects(w.geometry, l.geometry)
    GROUP BY l.fid
    )
SELECT ST_Difference(l.geometry, COALESCE(t.geometry, ST_SetSRID('GEOMETRYCOLLECTION EMPTY'::geometry, 3857))) AS geometry,
       'land'::text AS class
FROM osm_land_polygon_gen_z7 l LEFT JOIN temp t ON l.fid = t.fid
    );

-- etldoc:  osm_land_polygon_gen_z8 ->  land_z8
-- etldoc:  osm_water_polygon_gen_z8 ->  land_z8
CREATE OR REPLACE VIEW land_z8 AS
(
WITH temp AS
    (
    SELECT l.fid, ST_Union(w.geometry) AS geometry
    FROM osm_land_polygon_gen_z8 l JOIN osm_water_polygon_gen_z8 w ON ST_Intersects(w.geometry, l.geometry)
    GROUP BY l.fid
    )
SELECT ST_Difference(l.geometry, COALESCE(t.geometry, ST_SetSRID('GEOMETRYCOLLECTION EMPTY'::geometry, 3857))) AS geometry,
       'land'::text AS class
FROM osm_land_polygon_gen_z8 l LEFT JOIN temp t ON l.fid = t.fid
    );

-- etldoc:  osm_land_polygon_gen_z9 ->  land_z9
-- etldoc:  osm_water_polygon_gen_z9 ->  land_z9
CREATE OR REPLACE VIEW land_z9 AS
(
WITH temp AS
    (
    SELECT l.fid, ST_Union(w.geometry) AS geometry
    FROM osm_land_polygon_gen_z9 l JOIN osm_water_polygon_gen_z9 w ON ST_Intersects(w.geometry, l.geometry)
    GROUP BY l.fid
    )
SELECT ST_Difference(l.geometry, COALESCE(t.geometry, ST_SetSRID('GEOMETRYCOLLECTION EMPTY'::geometry, 3857))) AS geometry,
       'land'::text AS class
FROM osm_land_polygon_gen_z9 l LEFT JOIN temp t ON l.fid = t.fid
    );

-- etldoc:  osm_land_polygon_gen_z10 ->  land_z10
-- etldoc:  osm_water_polygon_gen_z10 ->  land_z10
CREATE OR REPLACE VIEW land_z10 AS
(
WITH temp AS
    (
    SELECT l.fid, ST_Union(w.geometry) AS geometry
    FROM osm_land_polygon_gen_z10 l JOIN osm_water_polygon_gen_z10 w ON ST_Intersects(w.geometry, l.geometry)
    GROUP BY l.fid
    )
SELECT ST_Difference(l.geometry, COALESCE(t.geometry, ST_SetSRID('GEOMETRYCOLLECTION EMPTY'::geometry, 3857))) AS geometry,
       'land'::text AS class
FROM osm_land_polygon_gen_z10 l LEFT JOIN temp t ON l.fid = t.fid
    );

-- etldoc:  osm_land_polygon_gen_z11 ->  land_z11
-- etldoc:  osm_water_polygon_gen_z11 ->  land_z11
CREATE OR REPLACE VIEW land_z11 AS
(
WITH temp AS
    (
    SELECT l.fid, ST_Union(w.geometry) AS geometry
    FROM osm_land_polygon_gen_z11 l JOIN osm_water_polygon_gen_z11 w ON ST_Intersects(w.geometry, l.geometry)
    GROUP BY l.fid
    )
SELECT ST_Difference(l.geometry, COALESCE(t.geometry, ST_SetSRID('GEOMETRYCOLLECTION EMPTY'::geometry, 3857))) AS geometry,
       'land'::text AS class
FROM osm_land_polygon_gen_z11 l LEFT JOIN temp t ON l.fid = t.fid
    );

-- etldoc:  osm_land_polygon ->  land_z12
-- etldoc:  osm_water_polygon ->  land_z12
CREATE OR REPLACE VIEW land_z12 AS
(
WITH temp AS
    (
    SELECT l.fid, ST_Union(w.geometry) AS geometry
    FROM osm_land_polygon l JOIN osm_water_polygon w ON ST_Intersects(w.geometry, l.geometry)
    GROUP BY l.fid
    )
SELECT ST_Difference(l.geometry, COALESCE(t.geometry, ST_SetSRID('GEOMETRYCOLLECTION EMPTY'::geometry, 3857))) AS geometry,
       'land'::text AS class
FROM osm_land_polygon l LEFT JOIN temp t ON l.fid = t.fid
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
