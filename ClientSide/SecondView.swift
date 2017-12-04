//
//  SecondView.swift
//  ClientSide
//
//  Created by Oskar Lukacz on 11/28/17.
//  Copyright © 2017 Oskar Lukacz. All rights reserved.
//

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
        
        /*if state == 0{
            Login()
        }
        else{
            Create()
        }*/
    }
    
    func Login()
    {
        
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
                self.requestDone(response: res)

            })
        }
        
    }
    
    func requestDone(response:String)
    {
        switch response.first! {
            
        case "t":
            
            var index = response.index(of: ":");index = response.index(index!, offsetBy: 1)
            let uuid = String(describing: response[index!...])
            print("Success! UUID = \(uuid)")
            
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
    
    
    
    
}
