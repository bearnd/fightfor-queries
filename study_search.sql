-- Find all MeSH tree numbers of a given MeSH descriptor.
SELECT mesh.tree_numbers.tree_number
FROM mesh.descriptors
  LEFT JOIN mesh.descriptor_tree_numbers USING (descriptor_id)
  LEFT JOIN mesh.tree_numbers USING (tree_number_id)
-- The MeSH descriptor ID for `Brain Neoplasms` is `3372`.
WHERE mesh.descriptors.descriptor_id = 3372;
-- The found tree-numbers are 'C04.588.614.250.195', 'C10.228.140.211',
-- 'C10.551.240.250'.

-- Find all MeSH descriptor children of a single descriptor by prefix-matching the parent descriptor's tree numbers.
-- EXPLAIN ANALYZE
SELECT
  mesh.descriptors.descriptor_id,
  mesh.descriptors.ui,
  mesh.descriptors.name
FROM mesh.descriptors
  LEFT JOIN mesh.descriptor_tree_numbers USING (descriptor_id)
  LEFT JOIN mesh.tree_numbers USING (tree_number_id)
-- The MeSH descriptor ID for `Brain Neoplasms` with ID `3372` has tree-numbers `C04.588.614.250.195`,
-- `C10.228.140.211`, and `C10.551.240.250`.
WHERE mesh.tree_numbers.tree_number LIKE ANY (
  ARRAY [
  'C04.588.614.250.195%',
  'C10.228.140.211%',
  'C10.551.240.250%'
  ]
);

-- Find all MeSH descriptor children of a single descriptor by prefix-matching the parent descriptor's tree numbers.
SELECT
  MAX(mesh.descriptors.descriptor_id) AS descriptor_id,
  MAX(mesh.descriptors.ui)            AS ui,
  MAX(mesh.descriptors.name)          AS name
FROM mesh.descriptors
  LEFT JOIN mesh.descriptor_tree_numbers USING (descriptor_id)
  LEFT JOIN mesh.tree_numbers USING (tree_number_id)
-- The MeSH descriptor ID for `Brain Neoplasms` with ID `3372` has tree-numbers `C04.588.614.250.195`,
-- `C10.228.140.211`, and `C10.551.240.250`.
WHERE mesh.tree_numbers.tree_number LIKE ANY (
  ARRAY [
  'C04.588.614.250.195%',
  'C10.228.140.211%',
  'C10.551.240.250%'
  ]
)
GROUP BY mesh.descriptors.descriptor_id;
-- The found descriptor IDs are 'Supratentorial Neoplasms', 'Pituitary Neoplasms', 'Pinealoma',
-- 'Papilloma, Choroid Plexus', 'Pallister-Hall Syndrome', 'Neurocytoma',
-- 'Infratentorial Neoplasms', 'Hypothalamic Neoplasms',
-- 'Choroid Plexus Neoplasms', 'Cerebral Ventricle Neoplasms',
-- 'Cerebellar Neoplasms', 'Brain Stem Neoplasms', 'Brain Neoplasms'

-- EXPLAIN ANALYZE
SELECT studies.study_id
FROM clinicaltrials.studies AS studies
  JOIN clinicaltrials.study_mesh_terms USING (study_id)
  JOIN clinicaltrials.mesh_terms USING (mesh_term_id)
WHERE clinicaltrials.mesh_terms.term IN (
  'Supratentorial Neoplasms',
  'Pituitary Neoplasms',
  'Pinealoma',
  'Papilloma, Choroid Plexus',
  'Pallister-Hall Syndrome',
  'Neurocytoma',
  'Infratentorial Neoplasms',
  'Hypothalamic Neoplasms',
  'Choroid Plexus Neoplasms',
  'Cerebral Ventricle Neoplasms',
  'Cerebellar Neoplasms',
  'Brain Stem Neoplasms',
  'Brain Neoplasms'
);

SELECT md5 FROM clinicaltrials.mesh_terms LIMIT 10;


SELECT MD5('Supratentorial Neoplasms');

SELECT md5('<typed_user_password>')::bytes;

-- EXPLAIN ANALYZE
SELECT studies.study_id
FROM clinicaltrials.studies AS studies
  JOIN clinicaltrials.study_mesh_terms USING (study_id)
  JOIN clinicaltrials.mesh_terms USING (mesh_term_id)
WHERE clinicaltrials.mesh_terms.md5 IN (
  MD5('Supratentorial Neoplasms'),
  MD5('Pituitary Neoplasms'),
  MD5('Pinealoma'),
  MD5('Papilloma, Choroid Plexus'),
  MD5('Pallister-Hall Syndrome'),
  MD5('Neurocytoma'),
  MD5('Infratentorial Neoplasms'),
  MD5('Hypothalamic Neoplasms'),
  MD5('Choroid Plexus Neoplasms'),
  MD5('Cerebral Ventricle Neoplasms'),
  MD5('Cerebellar Neoplasms'),
  MD5('Brain Stem Neoplasms'),
  MD5('Brain Neoplasms')
);