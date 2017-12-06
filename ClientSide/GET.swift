import Foundation

func GET(url:String, completionHandler: @escaping (_ response: Data) -> ())
{
    
    let request = URLRequest(url: URL(string: "http://10.46.22.145:8080/\(url)")!)
    
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        completionHandler(data!)
        
        
    }
    
    task.resume()
    
    
}


