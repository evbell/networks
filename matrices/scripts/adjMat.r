# 		adjMat1.r
# =========================================================================================
#		Emily V. Bell (2018) emonken1985@gmail.com
#
#		This script creates two types of adjacency matrices. Ties are generated based on
#		joint participation in an event.
#
#		The two types of matrices this generates are:
#
#		1.a) the whole network full adjacency matrix (FAM) 
#		1.b) the whole network actor-actor matrix
#		
#		In addition to the whole network matrices, the script generates a matrix that is
#		based on a subset of events by type. For this example, we choose regulatory events.
#
# =========================================================================================
#		1.a) Whole Network Full Adjacency Matrix
# =========================================================================================

#		We start by loading in Henry R Utilities (2017) for a function used later in the script.
#		You will need to specify the pathname here. 

#hRU = load()

#		'orgs' is the matrix of which actors participated in which water-related events 
#		(actors x events).

orgs = read.csv("orgs.csv", header = TRUE)

#		Here we select actors and their respective attributes.

actors = orgs[,1:4]

#		This selects the events.

orgs = orgs[,5:dim(orgs)[2]]

#		Here, we create the dimensions of the full adjacency matrix (FAM) by adding the 
#		dimensions of the actor vector to the event vector. 

num_actors = dim(orgs)[1]
num_events = dim(orgs)[2]
dimFAM = (num_actors + num_events)
FAM = matrix (0, dimFAM, dimFAM)
		
# 		The while loop creates a bipartite matrix, assigning 1s between actors and the events 
#		in which they have partaken. Here we populate the top right and bottom left quadrants
#		of the matrix with this tie information. 

i = 1
while(i <= dim(orgs)[1]) {
	j = 1
	while(j <= dim(orgs)[2]) {
		FAM[i, j + num_actors] = orgs[i,j]
		FAM[j + num_actors, i] = orgs[i,j]
		j = j + 1
	}
i = i + 1
}

#		To write a .csv file of the FAM:

#write.csv(FAM, "fam.csv", na="NA", row.names = FALSE)	

# =========================================================================================
#		1.b) Whole Network Actor-Actor Matrix
# =========================================================================================

#		Next, we want to create an actor-actor matrix from the FAM. We change the name of 
#		the FAM from 'FAM' to 'F'. We then square the FAM. This generates ties between the 
#		actors if they have jointly participated in at least one policy, which will appear 
#		in the top left and bottom right quadrants. If actors have not jointly participated 
#		in a policy, their tie remains 0. 

F = FAM

Fsquared = F %*% F

#		Here, we extract the top left quadrant. This provides us with an actor-actor 
#		(unipartite) graph. This graph represents actors who are connected by having jointly 
#		participated in at least one shared water policy. Ties between these actors are 
#		weighted, as they may have participated in 1 + k shared policies. 

A = Fsquared[1:num_actors, 1:num_actors]

#		Now that we have a matrix of actor-actor ties, we want to remove the values along 
#		the diagonals because we don't count ties actors have with themselves. Here, we 
#		use one of the hRU functions:

A = Delete_Self_Links(A)

#		To write a .csv file of the actor-actor matrix:

#write.csv(A, "uniMat1.csv", na="NA", row.names = FALSE)	

# =========================================================================================
#		2.a) Regulation Full Adjacency Matrix (FAM)
# =========================================================================================

#		Here, we generate an actor-actor matrix for those who have partaken in at least one 
#		shared regulatory event.

#		First, we have to read in the orgs data again and index this specifically for 
#		regulatory events.

orgs = read.csv("orgs.csv", header = TRUE)
orgs = orgs[,5:dim(orgs)[2]]

#		To identify policy networks by participation in policy type, we read in the following: 

events = read.csv("events.csv", header = TRUE)

#		Here, we index the policies that are water related and regulation-specific.

reg = orgs[, events$isWater_q ==1 & events$reg == 1]

#		Here, we create the dimensions of the full adjacency matrix by adding the dimensions
#		of the actor vector to the event vector. 

num_actors = dim(reg)[1]
num_events = dim(reg)[2]
actEvent = (num_actors + num_events)

#		This creates an adjacency matrix that has dimensions equal to the length of unique 
# 		stakeholder names. 

regNet = matrix (0, actEvent, actEvent)
		
# 		The while loop creates a bipartite matrix, assigning 1s between actors and the 
#		policies in which they have partaken. Here we populate the top right and bottom 
#		left quadrants of the matrix with this tie information. 

i = 1
while(i <= dim(reg)[1]) {
	j = 1
	while(j <= dim(reg)[2]) {
		regNet[i, j + num_actors] = reg[i,j]
		regNet[j + num_actors, i] = reg[i,j]
		j = j + 1
	}
	i = i + 1
}

#		To write a .csv file of the regulation full adjacency matrix:

#write.csv(regNet, "regNet1.csv", na="NA", row.names = FALSE)	

# =========================================================================================
#		2.b) Regulation Actor-Actor Matrix
# =========================================================================================

#		Here, we create an actor-actor matrix from regNet. This generates weighted ties 
#		between the actors if they have jointly participated in at least one regulation 
#		policy, which will appear in the top left and bottom right quadrants. If actors have 
#		not jointly participated in a policy, their tie remains 0. 

R = regNet

Rsquared = R %*% R

#		Here, we extract the top left quadrant. This provides us with an actor-actor unipartite 
#		graph. This graph represents actors who are connected by having jointly participated 
#		in at least one shared policy. Ties between these actors are weighted, as they may 
#		have participated in 1 + k shared events. 

rAct = Rsquared[1:num_actors, 1:num_actors]

#		Now that we have a matrix of actor-actor ties, we want to remove the values along 
#		the diagonals because  we don't count ties actors have with themselves. Here, we 
#		use one of the hRU functions:

rAct = Delete_Self_Links(rAct)

#		To write a .csv file of the actor-actor matrix:

write.csv(rAct, "regUniMat1.csv", na="NA", row.names = FALSE)