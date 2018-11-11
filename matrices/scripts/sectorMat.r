# 		sectorMat.r
# =========================================================================================
#		Emily V. Bell (emonken1985@gmail.com)
#
#		This script reads in raw data of organizations
#		and their sectors and creates an adjacency matrix
#		with ties between all organizations that share the
#		same sector. This is just a different way of formatting
#		data to resemble some relationship. For example, the 
#		vector that specifies the sector could instead be 
#		populated with information about the events in which
#		the actors partook. 
#
# =========================================================================================
#		Undirected matrices for organizations with the same sector
# =========================================================================================
#		Read in the data. orgs.csv is raw data that shows us all the different
#		types of sectors of organizations. In one case, there is a sector for 
#		'individual'. This was designated to actors to whom we could not assign
#		an organization. 

dta = read.csv("orgs.csv", header = TRUE)
org = dta$orgCode
orgm = data.frame(name = org, index = 1:length(org))

#		Here, we're specifying the length of the dimension for the matrix.
#		I wait to create the matrix until after I start the for loop so 
#		that it creates a matrix for each type. 

num_nodes = nrow(dta)

#		This is creates an empty matrix that shows whether organizations
#		share a sector. 

adjMat = matrix(0, num_nodes, num_nodes)

#		Here, I specify new variable names 'sector' for
#		sector and 'org1' for org that are the organization 
#		names that exist. 

for (i in 1:(num_nodes - 1)) {
	for (j in (i+1):num_nodes) {
		if (dta$sector[i] == dta$sector[j]) {
			adjMat[i,j] = 1
			adjMat[j,i] = 1
		}
	}
}

#		This writes a matrix in .csv format for shared sector. 
#		The paste function allows us to print the matrices in the loop
#		without having to specify the type each time.	

write.csv(adjMat, "sectorMat.csv", na = "NA", row.names = FALSE)
