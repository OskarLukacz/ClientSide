import Foundation
import UIKit

class DisplayNameView: UIViewController {
    
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var firstNameMessage: UILabel!
    
    @IBOutlet weak var lastNameMessage: UILabel!
    
    @IBAction func Enter(_ sender: Any) {
        
        clearError()
        
        let payload = "{\n\t" + "\"id\":" + "\"\(String(describing:user.serverSideUUID))\"," + "\n\t\"first\":" + "\"\(firstNameTextField.text!)\"," + "\n\t\"last\":" + "\"\(lastNameTextField.text!)\"" + "\n}"
        
        POST(input: payload, url: "displayName", completionHandler: { res in
            self.requestDone(response: res)
            
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func requestDone(response:String)
    {
        switch response.first! {
            
        case "t":
            
            print("Success! Display Name set")
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "displayNameSuccesful", sender: nil)
            }
            
        case "f":
            
            var index = response.index(of: ":");index = response.index(index!, offsetBy: 1)
            let error = String(describing: response[index!...])
            print("Error! ID = \(error)")
            
            if error.first == "F"
            {
                DispatchQueue.main.async {
                    self.firstNameMessage.text = error
                }
            }
            else
            {
                DispatchQueue.main.async {
                    self.lastNameMessage.text = error
                }
                
            }
            
        default:break
            
        }
    }
    
    func clearError()
    {
        firstNameMessage.text = ""
        lastNameMessage.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let destination = segue.destination as! SecondUIView
        
        
    }
    
}
