import Kitura
import Cocoa

let router = Router()
let dbObj = Database.getInstance()

/*
router.all("/post", middleware: BodyParser())

router.get("/get") {request, response, next in
//    print("Getting HTTP GET request /get ")
//    process the query parameters
    let count = request.queryParameters.count
    response.send("The HTTP GET request /get has been received")
    print("Getting HTTP GET request /get \(count)")
    next()
}

router.post("/post") {request, response, next in
    print("Getting HTTP POST request /post ")
//    Processing the request message body
    let body = request.body
    let data: String? = body?.asText
    response.send("The HTTP POST request /post has been received\nThe request message body: \(data!)")

}
*/

router.get("/"){
    request, response, next in
    response.send("Hello! Welcome to the service. ")
    next()
}

/* PERSONSERVICE */
router.all("/PersonService/add", middleware: BodyParser())

//  http://localhost:8020/PersonService/getAll
router.get("/PersonService/getAll") {
    request, response, next in
    let pList = PersonDAO().getAll()
//    JSON Serialization
    let jsonData: Data = try JSONEncoder ().encode(pList)
//    JSONArray
    let jsonStr = String(data: jsonData, encoding: .utf8)
    response.status(.OK)
    response.headers["Content-Type"] = "application/json"
    response.send(jsonStr)
//    response.send("getAll service response data: \(pList.description)")    next()
}

//  http://localhost:8020/PersonService/add
//  Postman POST Body: {"firstName":"George","ssn":"098765432","lastName":"Sampson"}
router.post("/PersonService/add") {
//    JSON Deserialization
    request, response, next in
    let body = request.body
    let jObj = body?.asJSON         // JSON Object
    if let jDict = jObj as? [String:String] {
        if let fn = jDict["firstName"],
           let ln = jDict["lastName"],
           let n = jDict["ssn"] {
            let pObj = Person(fn: fn, ln: ln, n: n)
            PersonDAO().addPerson(pObj: pObj)
        }
    }
    response.send("The Person record was successfully inserted (via POST Method)")
    next()
}

// http://localhost:8020/PersonService/add?FirstName=James&LastName=Shen&SSN=123456789
router.get("/PersonService/add") {
    request, response, next in
    let fn = request.queryParameters["FirstName"]
    let ln = request.queryParameters["LastName"]
    if let n = request.queryParameters["SSN"] {
        let pObj = Person(fn: fn, ln: ln, n: n)
        PersonDAO().addPerson(pObj: pObj)
        response.send("The Person record was successfully inserted")
    }
    
    next()
}

/* CLAIMSERVICE */
router.all("/ClaimService/add", middleware: BodyParser())

// http://localhost:8020/ClaimService/getAll
router.get("/ClaimService/getAll") {
    request, response, next in
    let cList = ClaimDAO().getAll()
//    JSON Serialization
    let jsonData: Data = try JSONEncoder().encode(cList)
//    JSONArray
    let jsonStr = String(data: jsonData, encoding: .utf8)
//    Set Content-Type
    response.status(.OK)
    response.headers["Content-Type"] = "application/json"
    response.send(jsonStr)
    next()
}

// http://localhost:8020/ClaimService/add
// Postman POST Body: {"title":"Fraud","date":"2020 10-25","is_solved":0}
router.post("/ClaimService/add") {
//    JSON Deserialization
    request, response, next in
    let body = request.body
    let jObj = body?.asJSON         // JSON Object
    if let jDict = jObj as? [String:String] {
        if let title = jDict["title"],
           let date = jDict["date"] {
            let cObj = Claim(this_title: title, this_date: date)
            ClaimDAO().addClaim(cObj: cObj)
        }
    }
    response.send("The Claim record was successfully inserted (via POST Method)")
    next()
}

// Note, change port # on repetitive runs
// or
// Kill the process on the port, run in terminal
// Lsof -i tcp:8020
// Kill -9 <PID>
Kitura.addHTTPServer(onPort: 8020, with: router)
Kitura.run()
