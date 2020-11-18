-- Recreate land layer by union regular squares into larger polygons
-- etldoc: osm_land_polygon -> osm_land_polygon_union
CREATE TABLE IF NOT EXISTS osm_land_polygon_union AS
    (
    SELECT (ST_Dump(ST_Union(ST_MakeValid(geom)))).geom::geometry(Polygon, 3857) AS geometry 
    FROM osm_land_polygon
    --for union select just full square (not big triangles)
    WHERE ST_Area(geom) > 100000000 AND 
          ST_NPoints(geom) = 5
    UNION ALL
    SELECT geom AS geometry 
    FROM osm_land_polygon
    WHERE ST_NPoints(geom) <> 5
    );

CREATE INDEX IF NOT EXISTS osm_land_polygon_union_geom_idx
  ON osm_land_polygon_union
  USING GIST (geometry);

--Drop data from original table but keep table as `CREATE TABLE IF NOT EXISTS` still test if query is valid
--TRUNCATE TABLE osm_land_polygon;

-- This statement can be deleted after the water importer image stops creating this object as a table
DO
$$
    BEGIN
        DROP TABLE IF EXISTS osm_land_polygon_gen1 CASCADE;
    EXCEPTION
        WHEN wrong_object_type THEN
    END;
$$ LANGUAGE plpgsql;

-- etldoc: osm_land_polygon_union -> osm_land_polygon_gen1
DROP MATERIALIZED VIEW IF EXISTS osm_land_polygon_gen1 CASCADE;
CREATE MATERIALIZED VIEW osm_land_polygon_gen1 AS
(
SELECT ST_Simplify(geometry, 20) AS geometry
FROM osm_land_polygon_union
    ) /* DELAY_MATERIALIZED_VIEW_CREATION */ ;
CREATE INDEX IF NOT EXISTS osm_land_polygon_gen1_idx ON osm_land_polygon_gen1 USING gist (geometry);


-- This statement can be deleted after the water importer image stops creating this object as a table
DO
$$
    BEGIN
        DROP TABLE IF EXISTS osm_land_polygon_gen2 CASCADE;
    EXCEPTION
        WHEN wrong_object_type THEN
    END;
$$ LANGUAGE plpgsql;

-- etldoc: osm_land_polygon_union -> osm_land_polygon_gen2
DROP MATERIALIZED VIEW IF EXISTS osm_land_polygon_gen2 CASCADE;
CREATE MATERIALIZED VIEW osm_land_polygon_gen2 AS
(
SELECT ST_Simplify(geometry, 40) AS geometry
FROM osm_land_polygon_union
    ) /* DELAY_MATERIALIZED_VIEW_CREATION */ ;
CREATE INDEX IF NOT EXISTS osm_land_polygon_gen2_idx ON osm_land_polygon_gen2 USING gist (geometry);


-- This statement can be deleted after the water importer image stops creating this object as a table
DO
$$
    BEGIN
        DROP TABLE IF EXISTS osm_land_polygon_gen3 CASCADE;
    EXCEPTION
        WHEN wrong_object_type THEN
    END;
$$ LANGUAGE plpgsql;

-- etldoc: osm_land_polygon_union -> osm_land_polygon_gen3
DROP MATERIALIZED VIEW IF EXISTS osm_land_polygon_gen3 CASCADE;
CREATE MATERIALIZED VIEW osm_land_polygon_gen3 AS
(
SELECT ST_Simplify(geometry, 80) AS geometry
FROM osm_land_polygon_union
    ) /* DELAY_MATERIALIZED_VIEW_CREATION */ ;
CREATE INDEX IF NOT EXISTS osm_land_polygon_gen3_idx ON osm_land_polygon_gen3 USING gist (geometry);


-- This statement can be deleted after the water importer image stops creating this object as a table
DO
$$
    BEGIN
        DROP TABLE IF EXISTS osm_land_polygon_gen4 CASCADE;
    EXCEPTION
        WHEN wrong_object_type THEN
    END;
$$ LANGUAGE plpgsql;

-- etldoc: osm_land_polygon_union -> osm_land_polygon_gen4
DROP MATERIALIZED VIEW IF EXISTS osm_land_polygon_gen4 CASCADE;
CREATE MATERIALIZED VIEW osm_land_polygon_gen4 AS
(
SELECT ST_Simplify(geometry, 160) AS geometry
FROM osm_land_polygon_union
    ) /* DELAY_MATERIALIZED_VIEW_CREATION */ ;
CREATE INDEX IF NOT EXISTS osm_land_polygon_gen4_idx ON osm_land_polygon_gen4 USING gist (geometry);
