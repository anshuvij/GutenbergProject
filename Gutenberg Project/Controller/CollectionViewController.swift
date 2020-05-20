//
//  CollectionViewController.swift
//  Gutenberg Project
//
//  Created by Anshu Vij on 5/19/20.
//  Copyright © 2020 Anshu Vij. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
     var vSpinner : UIView?
    var category: String?
    var apiUrl : URL?
    var articles: Array<Dictionary<String,Any>> = [];
    var pageNumber = 1
    var isDataLoading = false
   var booksManager = BookManager()
    var booksData = [Books]()
    var nextLink : String?
    var fetchMore = false
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 248/255, green: 247/255, blue: 254/255, alpha: 1.0)
        searchBar.delegate = self
        
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        booksManager.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
       
         self.showSpinner(onView: self.view)
        booksManager.fetchBookByCategory(category: category!)
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        booksData.removeAll()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchMore
            {
            beginBatchFetch()
            }
        }
    }
    
    func beginBatchFetch ()
    {
        fetchMore = true
        print("beginfetch")
          self.showSpinner(onView: self.view)
        booksManager.nextBooks(urlString: nextLink!)
    }
    

}
extension CollectionViewController : BookMangerDelegate {
    
    
    func didFailWithError(error: Error) {
        
    }
    
    func didUpdateBook(_ bookManager: BookManager, _ books: [Books], _ nextUrl: BookModel){
        
        
        fetchMore = false
        booksData.append(contentsOf: books)
        nextLink = nextUrl.next
        
        removeSpinner()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension CollectionViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
      }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          
          return booksData.count
          
      }
      
      
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
           var stringURL : String?
        let book = booksData[indexPath.row]
          
        if book.format != "NA"
        {
         // for key in formats
            stringURL = book.format
          if let url = URL(string: stringURL!) {
              UIApplication.shared.open(url)
          }
        }
        else
        {
            //TBD
        }

      }
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let arrays = booksData[indexPath.row]
        cell.titleLabel.text = arrays.title
        cell.authorLabel.text = arrays.authorname
        
        
        DispatchQueue.global().async{
            let data = try? Data(contentsOf: URL(string: arrays.imageLink)! )
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.imageView.image = image
                    cell.imageView.contentMode = .scaleAspectFit
                    
                    
                }
            }
        }
        
        return cell
        
    }
      func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
            
          let itemWidth = (self.view.frame.size.width - 45) / 3
          return CGSize(width: itemWidth, height: 200);
        }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//         if (indexPath.row == booksData.count - 1 ) { //it's your last cell
//           //Load more data & reload your collection view
//         //   booksData.removeAll()
//            booksManager.nextBooks(urlString: nextLink!)
//         }
//    }
      
}

extension CollectionViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text
        {
            booksManager.SearchBookByCategory(category: category!, search: searchText)
        }
        
        searchBar.text = ""
        fetchMore = true
        booksData.removeAll()
        self.searchBar.endEditing(true)
        self.searchBar.layer.borderColor = UIColor.clear.cgColor
        self.showSpinner(onView: self.view)
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.layer.borderColor = UIColor(red: 95/255, green: 90/255, blue: 222/255, alpha: 1.0).cgColor
        self.searchBar.layer.borderWidth = 6
        
    }
    
}
extension CollectionViewController
{
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
}

