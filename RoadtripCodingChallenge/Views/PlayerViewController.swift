//
//  PlayerViewController.swift
//  RoadtripCodingChallenge
//
//  Created by Puneet Pal Singh on 12/2/20.
//

import UIKit
import SDWebImage

protocol PlayerViewProtocol: class {
    
}

class PlayerViewController: UIBaseViewController {
    var viewModel: PlayerViewModelProtocol?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var playAndPauseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            viewModel = PlayerViewModel.init(view: self, track: nil)
        }
        if let imageUrlString = viewModel?.track?.largeImageUrltring {
            imageView.sd_setImage(with: URL.init(string: imageUrlString), placeholderImage: UIImage.init(named: "star-icon"), options: SDWebImageOptions.fromLoaderOnly)
        }
        nameLabel.text = viewModel?.track?.name
        // Do any additional setup after loading the view.
    }
    
    @IBAction func playAndPauseButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func bookmarkButtonPressed(_ sender: Any) {
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

extension PlayerViewController: PlayerViewProtocol {
    
}

extension PlayerViewController {
    
}
