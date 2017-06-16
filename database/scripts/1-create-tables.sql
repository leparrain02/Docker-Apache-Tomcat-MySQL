CREATE TABLE customers(
    username CHAR (8) NOT NULL,
    PRIMARY KEY(username),
    prenom VARCHAR(64),
    nom VARCHAR(64),
    tel VARCHAR(64)
  );

  INSERT INTO customers ( username, prenom, nom, tel ) VALUES ( 'sjane01', 'Jane', 'Smith', '418-123-4567' );
  INSERT INTO customers ( username, prenom, nom, tel ) VALUES ( 'rdave01', 'Dave', 'Richards', '514-333-4444' );
