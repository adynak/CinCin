CREATE AGGREGATE draanks.textcat_all
(
	basetype = text,
 	sfunc1 = textcat,
 	stype1 = text
);