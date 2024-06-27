

import UIKit
class ViewController: UIViewController{

   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    @IBAction func GoToBtnAction(_ sender: Any){
        let mainStoryBorad = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryBorad.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    
}

