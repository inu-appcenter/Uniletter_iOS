//
//  SearchViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/12/19.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    // MARK: - ProPerties
    
    lazy var searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        
        searchBar.frame = CGRect(x: 0, y: 0, width: 250, height: 0)
        searchBar.placeholder = "검색어를 입력해주세요."
        searchBar.searchTextField.font = .systemFont(ofSize: 14)
        searchBar.setImage(
            UIImage(),
            for: UISearchBar.Icon.search,
            state: .normal)
        return searchBar
    }()
    
    lazy var cancleButtonItem: UIBarButtonItem = {
        var buttonItem = UIBarButtonItem(title: "취소")
        
        buttonItem.setTitleTextAttributes(
            [.font: UIFont.systemFont(ofSize: 14),
             .foregroundColor: UIColor.customColor(.darkGray)],
            for: .normal)

        buttonItem.setTitleTextAttributes(
            [.font: UIFont.systemFont(ofSize: 14),
             .foregroundColor: UIColor.customColor(.darkGray)],
            for: .highlighted)
        
        return buttonItem
    }()
    
    let searchView = SearchView()
    let viewModel = SearchViewModel()

    // MARK: - LifeCycle
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        fetchEvent()
    }
    
    // MARK: - Objc Functions
    
    @objc func cancleButtonClick() {
        // TODO: - 취소버튼 눌렀을 때 기능 추가
    }
}

// MARK: - Functions
extension SearchViewController {
    func configureUI() {
        view.backgroundColor = .white
        
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
        searchBar.delegate = self
    }
    
    func configureNavigationBar() {
        setNavigationBackButton()

        self.navigationItem.titleView = searchBar
        self.navigationItem.rightBarButtonItem = cancleButtonItem
    }
    
    func fetchEvent() {
        viewModel.searchEvent {
            DispatchQueue.main.async {
                self.searchView.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: []
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let index = indexPath.row
        
        print(index)
        if index == viewModel.numOfEvents - 1 && !viewModel.isLast {
            fetchEvent()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfEvents
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaveListCell.identifier, for: indexPath) as? SaveListCell else { return UICollectionViewCell() }

        
        cell.setUI(event: viewModel.eventAtIndex(index: indexPath.item))
        
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    private func dismissKeyborad() {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyborad()
        
        print(searchBar.text!)
    }
}
