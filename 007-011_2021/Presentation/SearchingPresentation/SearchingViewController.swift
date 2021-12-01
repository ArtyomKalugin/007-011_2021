//
//  SearchingViewController.swift
//  007-011_2021
//
//  Created by Artem Kalugin on 24.11.2021.
//

import UIKit

class SearchingViewController: UIViewController {
    
    @IBOutlet weak var searchingTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private let networkService: NetworkService = NetworkService()
    private var searchingWords: [Word] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func findButtonAction(_ sender: Any) {
        guard let searchingText: String = searchingTextField.text else { return }
        
        networkService.getWord(word: searchingText, completion: { result in
            switch result {
            case .success(let words):
                self.searchingWords = words
            
            case .failure(let error):
                self.searchingWords = [Word(word: "No such word!", phonetics: nil, meanings: nil)]

                print(error)
            }
            
            DispatchQueue.main.async { [self] in
                self.tableView.reloadData()
            }
        })
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier:  "SavedWordsViewController") as? SavedWordsViewController else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SearchingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchingWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchingTableViewCell", for: indexPath) as? SearchingTableViewCell else { return UITableViewCell() }
        
        cell.setWord(word: searchingWords[indexPath.row])
//        cell.setPost(post: posts[indexPath.row])

        return cell as UITableViewCell
    }    
}
