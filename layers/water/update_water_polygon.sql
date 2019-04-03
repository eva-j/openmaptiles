-- etldoc:  osm_water_polygon ->  osm_water_polygon
CREATE OR REPLACE FUNCTION update_osm_water_polygon() RETURNS VOID AS $$
BEGIN

  UPDATE osm_water_polygon w
  SET geometry=COALESCE(ST_Difference(w.geometry, (SELECT ST_Collect(i.geometry) 
                                         FROM osm_waterisland_polygon i
                                         WHERE ST_Intersects(w.geometry, i.geometry)
                                         )), w.geometry);
  ANALYZE osm_water_polygon;

  UPDATE osm_water_polygon_gen1 w
  SET geometry=COALESCE(ST_Difference(w.geometry, (SELECT ST_Collect(i.geometry) 
                                         FROM osm_waterisland_polygon i
                                         WHERE ST_Intersects(w.geometry, i.geometry)
                                         )), w.geometry);
  ANALYZE osm_water_polygon_gen1;

  UPDATE osm_water_polygon_gen2 w
  SET geometry=COALESCE(ST_Difference(w.geometry, (SELECT ST_Collect(i.geometry) 
                                         FROM osm_waterisland_polygon i
                                         WHERE ST_Intersects(w.geometry, i.geometry)
                                         )), w.geometry);
  ANALYZE osm_water_polygon_gen2;

  UPDATE osm_water_polygon_gen3 w
  SET geometry=COALESCE(ST_Difference(w.geometry, (SELECT ST_Collect(i.geometry) 
                                         FROM osm_waterisland_polygon i
                                         WHERE ST_Intersects(w.geometry, i.geometry)
                                         )), w.geometry);
  ANALYZE osm_water_polygon_gen3;

  UPDATE osm_water_polygon_gen4 w
  SET geometry=COALESCE(ST_Difference(w.geometry, (SELECT ST_Collect(i.geometry) 
                                         FROM osm_waterisland_polygon i
                                         WHERE ST_Intersects(w.geometry, i.geometry)
                                         )), w.geometry);
  ANALYZE osm_water_polygon_gen4;

  UPDATE osm_water_polygon_gen5 w
  SET geometry=COALESCE(ST_Difference(w.geometry, (SELECT ST_Collect(i.geometry) 
                                         FROM osm_waterisland_polygon i
                                         WHERE ST_Intersects(w.geometry, i.geometry)
                                         )), w.geometry);
  ANALYZE osm_water_polygon_gen5;

  UPDATE osm_water_polygon_gen6 w
  SET geometry=COALESCE(ST_Difference(w.geometry, (SELECT ST_Collect(i.geometry) 
                                         FROM osm_waterisland_polygon i
                                         WHERE ST_Intersects(w.geometry, i.geometry)
                                         )), w.geometry);
  ANALYZE osm_water_polygon_gen6;

END;
$$ LANGUAGE plpgsql;

SELECT update_osm_water_polygon();

