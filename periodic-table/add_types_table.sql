CREATE TABLE types (type_id SERIAL PRIMARY KEY, type VARCHAR(16) NOT NULL);
INSERT INTO types (type) VALUES ('metal'), ('metalloid'), ('nonmetal');