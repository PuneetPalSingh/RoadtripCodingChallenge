//
//  BookmarkViewController.swift
//  RoadtripCodingChallenge
//
//  Created by Puneet Pal Singh on 11/24/20.
//

import UIKit

protocol BookmarkViewProtocol: class {
    func showBookmark()
}

class BookmarkViewController: UIBaseViewController {
    var viewModel: BookmarkViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = BookmarkViewModel(view: self)
        // Do any additional setup after loading the view.
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

extension BookmarkViewController: BookmarkViewProtocol {
    func showBookmark() {
        
    }
    
    
}
