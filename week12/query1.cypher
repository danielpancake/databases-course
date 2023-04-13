CREATE
  (khb:Fighter{name:"Khabib Nurmagomedov", weight:155}),
  (rda:Fighter{name:"Rafael Dos Anjos", weight:155}),
  (nem:Fighter{name:"Neil Magny", weight:170}),
  (jon:Fighter{name:"Jon Jones", weight:205}),
  (dan:Fighter{name:"Daniel Cormier", weight:205}),
  (mic:Fighter{name:"Michael Bisping", weight:185}),
  (mat:Fighter{name:"Matt Hamill", weight:185}),
  (brd:Fighter{name:"Brandon Vera", weight:205}),
  (frk:Fighter{name:"Frank Mir", weight:230}),
  (brl:Fighter{name:"Brock Lesnar", weight:230}),
  (kel:Fighter{name:"Kelvin Gastelum", weight:185}),
  
  (khb)-[:beats]->(rda),
  (rda)-[:beats]->(nem),
  (jon)-[:beats]->(dan),
  (mic)-[:beats]->(mat),
  (jon)-[:beats]->(brd),
  (brd)-[:beats]->(frk),
  (frk)-[:beats]->(brl),
  (nem)-[:beats]->(kel),
  (kel)-[:beats]->(mic),
  (mic)-[:beats]->(kel),
  (mic)-[:beats]->(mat),
  (mat)-[:beats]->(jon);
