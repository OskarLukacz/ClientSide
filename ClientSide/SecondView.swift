import Foundation
import UIKit

class SecondUIView: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    
    @IBOutlet weak var usernameMessage: UILabel!
    
    @IBOutlet weak var passwordMessage: UILabel!
    
    @IBOutlet weak var passwordCheckMessage: UILabel!
    
    var username = String()
    
    var password = String()
    
    @IBAction func enter(_ sender: Any) {
        
        clearError()
        
        if state == 0{
            Login()
        }
        else{
            Create()
        }
        
    }
    
    
    var state = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(state)
        
        if state == 0{
            confirmPassword.alpha = 0.0
            confirmPassword.isEnabled = false
            confirmPasswordLabel.alpha = 0.0
        }

    }
    
    func Login()
    {
        
        password = passwordTextField.text!
        username = usernameTextField.text!
        
        
        let payload = "{\n\t" + "\"username\":" + "\"\(username)\"," + "\n\t\"password\":" + "\"\(password)\"" + "\n}"
            
        POST(input: payload, url: "login", completionHandler: { res in
            self.loginRequestDone(response: res)
                
        })
        
        
    }
    
    func loginRequestDone(response:String)
    {
        switch response.first! {
            
        case "t":
            
            var index = response.index(of: ":");index = response.index(index!, offsetBy: 1)
            let uuid = String(describing: response[index!...])
            print("Success! UUID = \(uuid)")
            user.serverSideUUID = uuid
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "loginSuccesful", sender: nil)
            }
            
        case "f":
            
                DispatchQueue.main.async {
                    self.usernameMessage.text = "Invalid username or password"
                }
            
        default:break
            
        }
    }
    
    func Create()
    {
        var chk = true
        
        password = passwordTextField.text!
        username = usernameTextField.text!
        
        if password != confirmPassword.text!
        {
            chk = false
            passwordCheckMessage.text = "Passwords do not match"
        }
        else
        {
            passwordCheckMessage.text = ""
        }
        
        if chk
        {
            let payload = "{\n\t" + "\"username\":" + "\"\(username)\"," + "\n\t\"password\":" + "\"\(password)\"" + "\n}"
            
            POST(input: payload, url: "create", completionHandler: { res in
                self.createRequestDone(response: res)

            })
        }
        
    }
    
    func createRequestDone(response:String)
    {
        switch response.first! {
            
        case "t":
            
            var index = response.index(of: ":");index = response.index(index!, offsetBy: 1)
            let uuid = String(describing: response[index!...])
            print("Success! UUID = \(uuid)")
            user.serverSideUUID = uuid
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "displayName", sender: nil)
            }
            
        case "f":
            
            var index = response.index(of: ":");index = response.index(index!, offsetBy: 1)
            let error = String(describing: response[index!...])
            print("Error! ID = \(error)")
            
            if error.first == "U" || error.first == "R"
            {
                DispatchQueue.main.async {
                    self.usernameMessage.text = error
                }
            }
            else
            {
                DispatchQueue.main.async {
                    self.passwordMessage.text = error
                }

            }
            
        default:break
            
        }
    }
    
    func clearError()
    {
        usernameMessage.text = ""
        passwordMessage.text = ""
        usernameMessage.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /*switch segue.identifier {
        case "Login"?:
            destination.state = 0
        case "Create"?:
            destination.state = 1
        default: break
        }*/
    }
    
    
    
    
}
