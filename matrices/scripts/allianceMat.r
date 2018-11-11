# 		allianceMat.r
# =========================================================================================
#		Emily V. Bell (2018) emonken1985@gmail.com
#
#		This script reads in raw data of mutual defense alliances
#		between pairs of countries from 1945 - 2015, and generates 
#		adjacency matrices of alliances for each year. All matrices
#		are printed as .csv files. 
#
# =========================================================================================

#		Read in the data. 

dta = read.csv("Alliance_cow_def.csv", header = TRUE)

#		Next, this takes the list of countries in dta and 
#		create a unique, sorted list of the country names.
#		We then assign an index number that will be used 
#		for the dimensions of the matrix. This allows us
#		to link country names in dta to index numbers that 
#		make up the dimensions of the matrix. 

countries = (dta$country_a)
countries = unique(countries)
countries = sort(countries)
cm = data.frame(name = countries, index = 1:length(countries))

#		Just to have the list of countries and their unique 
#		index numbers on hand, we print a .csv.

write.csv(cm, "countryList.csv", na = "NA", row.names = FALSE)

#		Next, we want to subset the matrices by year. We first
#		find the unique years and sort these.

yrs = dta$year
yrs = unique(yrs)
yrs = sort(yrs)

#		Here, we're specifying the length of the dimension for the matrix.
#		I wait to create the matrix until after I start the for loop so 
#		that it creates a matrix for each year. 

num_nodes = length(countries)

#		After this, we want to select the rows of dta that have
#		the year of interest for each loop (e.g., 2016 for Loop 1, 
#		2017 for Loop 2, etc.), and for where defense_cow = 1.

for(year in yrs) {

#		(Just gonna pop the dimensions of the matrix in here real quick.)

adjMat = matrix(0, num_nodes, num_nodes)

#		Below takes a subset of the data for each year given defense_cow = 1
	
	subset = dta[dta$year == year & dta$defense_cow == 1,]

#		Here, you are specifying new variable names 'cn1' for
#		country_a and 'cn2' for country_b that are the country 
#		names that exist within the subsets by year (i.e., all
#		country names that exist in the data frame for 2016, 2017 etc.).

	for (i in 1:nrow(subset)) {
		cn1 = subset$country_a[i]
		cn2 = subset$country_b[i]

		cidx1 = cm$index[cm$name == cn1][1]
		cidx2 = cm$index[cm$name == cn2][1]

#		This takes all observations in the matrix that 
#		have defense_cow = 1 for the year of interest 
#		and populates a binary adjacency matrix. Assuming
#		this is undirected, I've made sure to populate 1s
#		for x and y, and y and x in case there is some
#		unique pair that is not specified in both directions.

		adjMat[cidx1, cidx2] = 1
		adjMat[cidx2, cidx1] = 1
	}

#		This writes a matrix in .csv format for each year. The 
#		past function allows us to print the matrices in the loop
#		without having to specify the year each time.	

	mat_loc = paste(year, ".csv", sep="")
	write.csv(adjMat, mat_loc, na = "NA", row.names = FALSE)
}
	
		


