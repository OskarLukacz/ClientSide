import Foundation

public var serverIP = String()

struct UserClass {
    
    public var username = String()
    
    public var displayName = String()
    
    public var serverSideUUID = String()
    
    public var pubNubUUID = String()
    
}


var user = UserClass()

var allUsers = [UserClass()]

func jsonToString(json: AnyObject) -> String
{
    do {
        let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
        let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
        print(convertedString!)
        return convertedString!
        
        
    } catch let myJSONError {
        print(myJSONError)
    }
    return ""
}

func convertToDictionary(text: String) -> [String: Array<Any>]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Array]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}


