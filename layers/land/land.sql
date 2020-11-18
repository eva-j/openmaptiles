CREATE OR REPLACE VIEW land_z0 AS
(
-- etldoc:  osm_land_polygon_gen4 ->  land_z0
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_gen4
    );

CREATE OR REPLACE VIEW land_z1 AS
(
-- etldoc:  osm_land_polygon_gen4 ->  land_z1
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_gen4
    );

CREATE OR REPLACE VIEW land_z2 AS
(
-- etldoc:  osm_land_polygon_gen4 ->  land_z2
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_gen4
    );

CREATE OR REPLACE VIEW land_z4 AS
(
-- etldoc:  osm_land_polygon_gen4 ->  land_z4
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_gen4
    );

CREATE OR REPLACE VIEW land_z5 AS
(
-- etldoc:  osm_land_polygon_gen4 ->  land_z5
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_gen4
    );

CREATE OR REPLACE VIEW land_z6 AS
(
-- etldoc:  osm_land_polygon_gen4 ->  land_z6
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_gen4
    );

CREATE OR REPLACE VIEW land_z7 AS
(
-- etldoc:  osm_land_polygon_gen4 ->  land_z7
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_gen4
    );

CREATE OR REPLACE VIEW land_z8 AS
(
-- etldoc:  osm_land_polygon_gen4 ->  land_z8
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_gen4
    );

CREATE OR REPLACE VIEW land_z9 AS
(
-- etldoc:  osm_land_polygon_gen3 ->  land_z9
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_gen3
    );

CREATE OR REPLACE VIEW land_z10 AS
(
-- etldoc:  osm_land_polygon_gen2 ->  land_z10
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_gen2
    );

CREATE OR REPLACE VIEW land_z11 AS
(
-- etldoc:  osm_land_polygon_gen1 ->  land_z11
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_gen1
    );

CREATE OR REPLACE VIEW land_z12 AS
(
-- etldoc:  osm_land_polygon_union ->  land_z12
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_union
    );

CREATE OR REPLACE VIEW land_z13 AS
(
-- etldoc:  osm_land_polygon_union ->  land_z13
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_union
    );

CREATE OR REPLACE VIEW land_z14 AS
(
-- etldoc:  osm_land_polygon_union ->  land_z14
SELECT geometry,
       'land'::text AS class
FROM osm_land_polygon_union
    );

-- etldoc: layer_land [shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="layer_land |<z0> z0|<z1>z1|<z2>z2|<z3>z3 |<z4> z4|<z5>z5|<z6>z6|<z7>z7| <z8> z8 |<z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13|<z14_> z14+" ] ;

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
         -- etldoc: land_z2 ->  layer_land:z3
         SELECT *
         FROM land_z2
         WHERE zoom_level BETWEEN 2 AND 3
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
         WHERE zoom_level = 12
         UNION ALL
         -- etldoc: land_z13 ->  layer_land:z13
         SELECT *
         FROM land_z13
         WHERE zoom_level = 13
         UNION ALL
         -- etldoc: land_z14 ->  layer_land:z14_
         SELECT *
         FROM land_z14
         WHERE zoom_level >= 14
     ) AS zoom_levels
WHERE geometry && bbox;
$$ LANGUAGE SQL STABLE
                -- STRICT
                PARALLEL SAFE;
