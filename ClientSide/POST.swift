import Foundation
import UIKit

func POST(input:String, url:String, completionHandler: @escaping (_ response: String) -> ())
{
    var request = URLRequest(url: URL(string: "http://10.46.22.145:8080/\(url)")!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let postString = input
    request.httpBody = postString.data(using: .utf8)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {                                                 // check for fundamental networking error
            print("error=\(String(describing:error))")
            return
        }
        
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(String(describing:response!))")
        }
        
        let responseString = String(data: data, encoding: .utf8)
        //print("responseString = \(String(describing:responseString!))")
        completionHandler(String(describing:responseString!))
    }
    task.resume()
}
