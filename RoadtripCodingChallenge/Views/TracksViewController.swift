//
//  TracksViewController.swift
//  RoadtripCodingChallenge
//
//  Created by Puneet Pal Singh on 11/24/20.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "TracksCellIdentifier"

protocol TracksViewProtocol: class {
    func reloadData()
    func showErrorLoadingTracks(errorMessage: String)
}

class TracksViewController: UIBaseViewController {
    var viewModel: TracksViewModelProtocol?
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect.zero)
    let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    @IBOutlet weak var tracksCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = TracksViewModel(view: self)
        viewModel?.viewDidLoad()
        
        tracksCollectionView.delegate = self
        tracksCollectionView.dataSource = self
        
        // Register cell classes
        tracksCollectionView!.register(UINib(nibName: "TracksCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        // Set CollectionView Cell Insets
        let collectionViewLayout = tracksCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        collectionViewLayout?.sectionInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 10, right: 0)
        collectionViewLayout?.invalidateLayout()
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Tracks"
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Track Name"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        //        searchController.searchBar.scopeButtonTitles = ["Name", "Author"]
        //        searchController.searchBar.delegate = self
    }
    
}

extension TracksViewController: TracksViewProtocol {
    func reloadData() {
        tracksCollectionView.reloadData()
    }
    
    func showErrorLoadingTracks(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { (action) in
            AuthManager.sharedManager.removeSessionFromKeychain()
            self.dismiss(animated: false, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension TracksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return viewModel?.filteredTracks?.count ?? 0
        }
        else {
            return viewModel?.tracks?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TracksCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TracksCollectionViewCell
        cell.backgroundColor = UIColor.red
        if isFiltering {
            cell.nameLabel.text = viewModel?.filteredTracks?[indexPath.row].name
            if let imageUrlString = viewModel?.filteredTracks?[indexPath.row].images?.first?.url  {
                DispatchQueue.global(qos: .background).async {
                    cell.imageView.sd_setImage(with: URL.init(string: imageUrlString), placeholderImage: UIImage.init(named: "star-icon"), options: SDWebImageOptions.fromLoaderOnly)
                }
                
            }
            cell.releaseDateLabel.text = viewModel?.filteredTracks?[indexPath.row].releaseDate
        }
        else {
            cell.nameLabel.text = viewModel?.tracks?[indexPath.row].name
            if let imageUrlString = viewModel?.tracks?[indexPath.row].images?.first?.url  {
                DispatchQueue.global(qos: .background).async {
                    cell.imageView.sd_setImage(with: URL.init(string: imageUrlString), placeholderImage: UIImage.init(named: "star-icon"), options: SDWebImageOptions.fromLoaderOnly)
                }
            }
            cell.releaseDateLabel.text = viewModel?.tracks?[indexPath.row].releaseDate
        }
        return cell
    }
}

extension TracksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let track = viewModel?.tracks?[indexPath.row] {
            let playerVC = PlayerViewController.controller()
            let playerViewModel = PlayerViewModel.init(view: playerVC, track: track)
            playerVC.viewModel = playerViewModel
            self.navigationController?.pushViewController(playerVC, animated: true)
        }
        print("Selected Row: \(indexPath.row)")
    }
}

extension TracksViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layoutcollectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
}

extension TracksViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        viewModel?.filterContentForSearchText(searchBar.text!)
    }
}

//extension TracksViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar,
//          selectedScopeButtonIndexDidChange selectedScope: Int) {
////        let category = Track.Category(rawValue:
////          searchBar.scopeButtonTitles![selectedScope])
////        filterContentForSearchText(searchBar.text!, category: category)
//      }
//}
