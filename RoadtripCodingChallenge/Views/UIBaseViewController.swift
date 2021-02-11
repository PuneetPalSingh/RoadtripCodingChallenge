//
//  UIBaseViewController.swift
//  RoadtripCodingChallenge
//
//  Created by Puneet Pal Singh on 11/24/20.
//

import UIKit

class UIBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    final class func controller() -> Self {
        let storyboard = UIStoryboard.init(name: String(describing: Self.self), bundle: Bundle.main)
        return storyboard.instantiateInitialViewController() as! Self
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
