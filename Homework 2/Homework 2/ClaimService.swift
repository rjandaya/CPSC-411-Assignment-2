//
//  ClaimService.swift
//  Homework 2
//
//  Created by RJ Andaya on 11/20/20.
//

import Foundation

struct Claim: Codable {
    var id: UUID?
    var title: String
    var date: String
    var isSolved: Bool?
    
    init(this_title: String, this_date: String) {
        title = this_title
        date = this_date
    }
}

class ClaimService {
    
    var claimList: [Claim] = [Claim]()
    var addComplete: Bool?
    var viewController : ViewController

//    Initialize
    init(vc: ViewController) {
       viewController = vc
    }
    
    func addClaim(cObj: Claim) {
//        Implement logic using Async HTTP Client API (POST Method)
        let requestUrl = "http://localhost:8020/ClaimService/add"
        var request = URLRequest(url: NSURL(string: requestUrl)! as URL)
        let jsonData: Data! = try! JSONEncoder().encode(cObj)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, from: jsonData) {
            (data, response, error) in
            if let resp = data {
//                Type of resp is Data
                let respStr = String(bytes: resp, encoding: .utf8)
                print("The response data sent from the server: \(respStr!)")
                OperationQueue.main.addOperation {
                    self.viewController.setStatusField(status: "Claim \(cObj.title) was created")
                    self.viewController.refreshForm(title: "", date: "")
                }
                
            } else if let respError = error {
                print("Server Error: \(respError)")
                OperationQueue.main.addOperation {
                    self.viewController.setStatusField(status: "Claim \(cObj.title) failed to be created")
                }

            }
        }
        task.resume()
    }
    
    func getAll() {
        let requestURL = "http://localhost:8020/ClaimService/getAll"
        let request = URLRequest(url: NSURL(string: requestURL)! as URL)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let respData = data {
                self.claimList = try! JSONDecoder().decode([Claim].self, from: respData)
                print("The Claim List: \(self.claimList)")
            }
        }
        task.resume()
    }
}
