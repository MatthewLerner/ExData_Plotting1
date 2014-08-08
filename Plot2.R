HouseholdPower <- read.table("./household_power_consumption.txt", sep=";")

#Reads the Table, breaks up the columns by semicolon

HouseholdPower<-HouseholdPower[-1,]

#Removes the first line of data which are the column names

colnames(HouseholdPower)<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
                            "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3" )

#Puts the column names back intot the dataframe

HouseholdPower$Date_Time <- as.POSIXct(paste(HouseholdPower$Date,HouseholdPower$Time),format= "%d/%m/%Y %H:%M:%S")

#Creates a new column of data with the merged date and time reformatted into a single date format

HouseholdPower1 <- subset(HouseholdPower, Date_Time > as.POSIXct("2007-01-31 24:00:00") & Date_Time < 
                                  as.POSIXct("2007-02-03 00:00:00"))

#Creates a new dataframe subsetting the data betweent the points in time mentioned in the prompt

png(filename = "./RGraphs/Plot2.png")

#open png graphics device, with file to send plot to.

plot(HouseholdPower1$Date_Time, as.numeric(as.character(HouseholdPower1$Global_active_power)), 
     type= "l", ylab = "Global Active Power (kilowatts)",xlab = "")

#Creates a Line Graph based on Global_active_power and Date_time.  Since the Global_active_power is a factor column 
#we need to convert to a character vector, than to a numeric vector (changing it to a numeric directly
#produces incorrect data)

dev.off()

#Turns the graphics device off
