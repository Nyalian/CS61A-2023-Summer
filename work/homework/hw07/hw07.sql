CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT p.child FROM parents AS p, dogs AS d WHERE p.parent = d.name ORDER BY d.height DESC;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT d.name AS name, s.size AS size FROM dogs AS d, sizes AS s WHERE s.min < d.height AND d.height <= s.max;


-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT d.name AS name, p.parent AS parent, s.size AS size
    FROM dogs AS d, parents as p, size_of_dogs AS s
      WHERE d.name = p.child AND d.name = s.name;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT ("The two siblings, " || sib1.name || " plus " || sib2.name || " have the same size: " || sib1.size) AS result 
    FROM siblings as sib1, siblings as sib2
      WHERE sib1.parent = sib2.parent AND sib1.size = sib2.size AND sib1.name < sib2.name;


-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT fur, max(height) - min(height) AS range
    FROM dogs
      GROUP BY fur HAVING min(height) >= avg(height) * 0.7 AND max(height) <= avg(height) * 1.3;

