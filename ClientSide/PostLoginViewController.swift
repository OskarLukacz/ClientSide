import Foundation
import UIKit

class PostLoginView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GET(url: "users")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let destination = segue.destination as! SecondUIView
        
        
    }
    
}
