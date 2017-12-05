import Foundation
import UIKit

class DisplayNameView: UIViewController {
    
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var firstNameMessage: UILabel!
    
    @IBOutlet weak var lastNameMessage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let destination = segue.destination as! SecondUIView
        
        
    }
    
}
