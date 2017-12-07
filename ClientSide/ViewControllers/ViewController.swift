import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setIP
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SecondUIView
        
        switch segue.identifier {
        case "Login"?:
            destination.state = 0
        case "Create"?:
            destination.state = 1
        default: break
        }
    }
    
    


}

