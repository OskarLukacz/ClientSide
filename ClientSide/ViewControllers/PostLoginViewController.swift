import Foundation
import UIKit
import PubNub


class PostLoginView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setIdentity()
        appDelegate.setUUID()
        publish(payload: user.serverSideUUID)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let destination = segue.destination as! SecondUIView
        
        
    }
    
    func setIdentity()
    {
        GET(url: "users", completionHandler: { res in
            
            let json = try? JSONSerialization.jsonObject(with: res, options: [])
            
            let convertedString = jsonToString(json: json as AnyObject)
            
            let userDictionary = convertToDictionary(text: convertedString)
            
            for i in userDictionary!
            {
                if String(describing: i.value[0]) == user.serverSideUUID
                {
                    user.username = String(describing: i.key)
                    user.displayName = String(describing: i.value[1])
                }
                else
                {
                    var tempUser = UserClass()
                    tempUser.username = String(describing: i.key)
                    tempUser.serverSideUUID = String(describing: i.value[0])
                    tempUser.displayName = String(describing: i.value[1])
                    
                    allUsers.append(tempUser)
                }
            }
            
            //self.identityCheck()
            
        })
    }
    
    func identityCheck()
    {
        print("You are: ")
        print(user.username)
        print(user.displayName)
        print(user.serverSideUUID)
        
        print("All users:")
        
        for i in allUsers
        {
            print(i.username)
            print(i.displayName)
            print(i.serverSideUUID)
            print("\n")
        }
        
    }
    
}
