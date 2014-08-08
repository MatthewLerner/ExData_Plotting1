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

png(filename = "./RGraphs/Plot4.png")
#open png graphics device, with file to send plot to.

par(mfrow = c(2, 2))
#Creates a 2x2 Plot Parameter

with(HouseholdPower1, {
        #Taking data from the dataframe: "HouseholdPower1"
        
        plot(Date_Time, as.numeric(as.character(Global_active_power)), 
             type= "l", ylab = "Global Active Power",xlab = "")
        #Plots Global_active_power over time
        
        plot(Date_Time, as.numeric(as.character(Voltage)), 
             type= "l", ylab = "Voltage",xlab = "datetime")
        #Plots Voltage over time
        
        
        plot(Date_Time, as.numeric(as.character(Sub_metering_1)), type= "l", 
             ylab = "Energy sub metering",xlab = "")
        #Plots Sub_metering_1 over time
        
                lines(HouseholdPower1$Date_Time, 
                      as.numeric(as.character(HouseholdPower1$Sub_metering_2)), type= "l", col = "red")
                #Adds a line for Sub_metering_2 to the Sub_metering_1 Plot
        
                lines(HouseholdPower1$Date_Time, 
                      as.numeric(as.character(HouseholdPower1$Sub_metering_3)), type= "l", col = "blue")
                #Adds a line for Sub_metering_3 to the Sub_metering Plot
        
                legend("topright", col = c("black","blue", "red"), 
                       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),lty=c(1,1,1), bty = "n")
                #Adds legend to the Sub_metering Plot
        
        plot(Date_Time, as.numeric(as.character(Global_reactive_power)), 
             type= "l", ylab = "Global_reactive_power",xlab = "datetime")
        #Plots Global_reactive_power over time
})

dev.off()

#Turns the graphics device off