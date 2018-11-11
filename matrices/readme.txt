readme.txt



scripts

	adjMat.r

		creates a bipartite adjacency matrix, a unipartite adjacency matrix 
		by joint participation in and event, and an example of a subset of 
		the adjacency matrix by event type.

	allianceMat.r

		creates a matrix based on alliances between countries for each year.

	sectorMar.r
	
		creates a matrix where ties are specified as shared sector. 
		
data

	Alliance_cow_def.csv

		used in allianceMat.r. This is data on pairs of countries that had 
		alliances each year. 

	events.csv

		used in adjMat.r to subset the network by event type. 

	hRU_v2017_07_12.RData
		
		Henry R Utilities (2017), provides functions for SNA.
		Updates can be found at https://sites.google.com/site/adamdouglashenry/code-software/hru

	orgs.csv

		used in adjMat.r to create full adjacency matrices (actor - event), and unipartite (actor-actor) 
		matrices.



