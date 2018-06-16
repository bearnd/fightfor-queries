-- Search for MeSH descriptors by fuzzy matching against the descriptor synonyms.
SELECT
  descriptors.descriptor_id,
  descriptors.ui,
  descriptors.name,
  descriptor_synonyms.synonym,
  similarity(descriptor_synonyms.synonym, 'brain cancer') AS synonym_similarity
FROM mesh.descriptor_synonyms
  JOIN mesh.descriptors USING (descriptor_id)
WHERE descriptor_synonyms.synonym % 'brain cancer'
ORDER BY synonym_similarity DESC;


-- Search for distinct MeSH descriptors by fuzzy matching against the descriptor synonyms.
SELECT
  MAX(descriptors.descriptor_id)                               AS descriptor_id,
  MAX(descriptors.ui)                                          AS ui,
  MAX(descriptors.name)                                        AS name,
  MAX(similarity(descriptor_synonyms.synonym, 'brain cancer')) AS synonym_similarity
FROM mesh.descriptor_synonyms
  JOIN mesh.descriptors USING (descriptor_id)
WHERE descriptor_synonyms.synonym % 'brain cancer'
GROUP BY descriptors.descriptor_id
ORDER BY synonym_similarity DESC;