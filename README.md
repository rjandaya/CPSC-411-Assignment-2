# Author
RJ Andaya (rjandaya98@csu.fullerton.edu)

## 1 Background
For this project we are implementing an iOS client that connects to a RestServer for a Claim Service. The client will add a user-defined Claim record into the SQLite3 database. 

## 2 Installation
Inside <br/>
`/RestfulServer/Sources/RestfulServer/Database.swift` <br/>
Modify <br/>
`let dbName = "/Users/rjandaya/Documents/CPSC 411/RestfulServer/ClaimDB.sqlite"` <br/>
to <br/>
`let dbName = "/<path>/ClaimDB.sqlite"` <br/>

## 3 Run Program
1. Open and Run /RestfulServer/RestfulServer.xcodeproj in Xcode
2. Open and Run /Homework 2/RestfulServer.xcodeproj in Xcode <br/>
a. OR Open and Run /Homework 2 - Storyboard/RestfulServer.xcodeproj in Xcode

## 4 Add Claim
1. Enter Claim Title
2. Enter date in the format (YYYY MM-DD)
3. Press the Add button <br/>

NOTE: 
1. Status Message will display `Claim title or date missing` if either field is left empty
2. Status Message will display `Incorrect Date` if date was not entered in the correct format <br/>
3. Status Message will display `Claim <Claim Title>  was created` if the Claim was successfully added to the database
4. Status Message will display `Claim <Claim Title>  was not created` if the Claim was not added to the database. This means that the iOS client was unable to connect to the Restserver
5. Textfields will be cleared if the entry is valid
