CREATE TABLE IF NOT EXISTS items (
  id SERIAL PRIMARY KEY,
  label TEXT NOT NULL
);

INSERT INTO items (label)
VALUES
  ('Première tâche'),
  ('Deuxième tâche')
ON CONFLICT DO NOTHING;
