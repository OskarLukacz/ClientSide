import Foundation

func GET(url:String)
{
    
    let request = URLRequest(url: URL(string: "http://10.46.22.145:8080/\(url)")!)
    
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        
        let json = try? JSONSerialization.jsonObject(with: data!, options: [])
        
        jsonToString(json: json as AnyObject)
        
        //self.jsonToString(json: data as AnyObject)
        
    }
    
    task.resume()
    
    
}

func jsonToString(json: AnyObject){
    do {
        let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
        let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
        print(convertedString!)
        
        
    } catch let myJSONError {
        print(myJSONError)
    }
    
}

func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}
