SELECT
  clinicaltrials.studies.study_id,
  clinicaltrials.mesh_terms.mesh_term_id,
  clinicaltrials.mesh_terms.term,
  clinicaltrials.facilities.facility_id
FROM clinicaltrials.studies
  LEFT JOIN clinicaltrials.study_mesh_terms USING (study_id)
  LEFT JOIN clinicaltrials.mesh_terms USING (mesh_term_id)
  LEFT JOIN clinicaltrials.study_locations USING (study_id)
  LEFT JOIN clinicaltrials.locations USING (location_id)
  LEFT JOIN clinicaltrials.facilities USING (facility_id)
WHERE clinicaltrials.study_mesh_terms.type = 'INTERVENTION'
ORDER BY
  clinicaltrials.facilities.facility_id,
  clinicaltrials.mesh_terms.mesh_term_id,
  clinicaltrials.studies.study_id
LIMIT 50;


SELECT
  clinicaltrials.facilities.facility_id,
  clinicaltrials.facilities.name,
  clinicaltrials.mesh_terms.mesh_term_id,
  clinicaltrials.mesh_terms.term,
  COUNT(DISTINCT(clinicaltrials.studies.study_id)) AS num_studies
FROM clinicaltrials.studies
  LEFT JOIN clinicaltrials.study_mesh_terms USING (study_id)
  LEFT JOIN clinicaltrials.mesh_terms USING (mesh_term_id)
  LEFT JOIN clinicaltrials.study_locations USING (study_id)
  LEFT JOIN clinicaltrials.locations USING (location_id)
  LEFT JOIN clinicaltrials.facilities USING (facility_id)
WHERE clinicaltrials.study_mesh_terms.type = 'INTERVENTION'
GROUP BY
  clinicaltrials.facilities.facility_id,
  clinicaltrials.mesh_terms.mesh_term_id
ORDER BY
  clinicaltrials.facilities.facility_id,
  num_studies DESC;


SELECT *
FROM clinicaltrials.studies
  LEFT JOIN clinicaltrials.study_mesh_terms USING (study_id)
  LEFT JOIN clinicaltrials.mesh_terms USING (mesh_term_id)
  LEFT JOIN clinicaltrials.study_locations USING (study_id)
  LEFT JOIN clinicaltrials.locations USING (location_id)
  LEFT JOIN clinicaltrials.facilities USING (facility_id)
-- WHERE clinicaltrials.study_mesh_terms.type = 'INTERVENTION'
--   AND clinicaltrials.facilities.facility_id = 9;
where clinicaltrials.facilities.facility_id = 9;


SELECT
  MAX(clinicaltrials.facilities.facility_id)        AS facility_id,
  MAX(clinicaltrials.facilities.name)               AS facility_name,
  MAX(clinicaltrials.mesh_terms.mesh_term_id)       AS mesh_term_id,
  MAX(clinicaltrials.mesh_terms.term)               AS term,
  COUNT(DISTINCT (clinicaltrials.studies.study_id)) AS num_studies
FROM clinicaltrials.studies
  JOIN clinicaltrials.study_mesh_terms USING (study_id)
  JOIN clinicaltrials.mesh_terms USING (mesh_term_id)
  JOIN clinicaltrials.study_locations USING (study_id)
  JOIN clinicaltrials.locations USING (location_id)
  JOIN clinicaltrials.facilities USING (facility_id)
WHERE clinicaltrials.study_mesh_terms.type = 'INTERVENTION'
GROUP BY
  clinicaltrials.facilities.facility_id,
  clinicaltrials.mesh_terms.mesh_term_id
ORDER BY num_studies DESC
LIMIT 100;