//
//  SearchViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/12/19.
//

import UIKit
import DropDown
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
    private let eventStatusDropDown = DropDown()
    private let categoryDropDown = DropDown()

    // MARK: - LifeCycle
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        configureDropdowns()
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
        
        [searchView.eventStatusButton, searchView.categoryButton]
            .forEach { $0.changeCornerRadius() }
        
        searchView.eventStatusButton.addTarget(
            self,
            action: #selector(didTapEventStatusButton),
            for: .touchUpInside)
        searchView.categoryButton.addTarget(
            self,
            action: #selector(didTapCategoryButtons),
            for: .touchUpInside)
    }
    
    func configureDropdowns() {
        eventStatusDropDown.dataSource = viewModel.eventStatusList
        eventStatusDropDown.anchorView = searchView.eventStatusButton
        eventStatusDropDown.selectRow(1)
        eventStatusDropDown.selectionAction = { index, item in
            self.searchView.eventStatusButton.changeState(item)
            self.viewModel.eventStatus = index == 1
            self.scrollToTop()
        }
        
        categoryDropDown.dataSource = viewModel.categoryList
        categoryDropDown.anchorView = searchView.categoryButton
        categoryDropDown.selectRow(at: 0)
        categoryDropDown.selectionAction = { index, item in
            self.searchView.categoryButton.changeState(item)
            self.viewModel.categoty = index
            self.scrollToTop()
        }
        
        [eventStatusDropDown, categoryDropDown]
            .forEach {
                $0.configureDropDownAppearance()
                $0.cornerRadius = ($0.anchorView?.plainView.frame.height)! / 2
                $0.bottomOffset = CGPoint(x: 0, y: 40)
            }
    }
    
    func configureNavigationBar() {
        setNavigationBackButton()

        self.navigationItem.titleView = searchBar
        self.navigationItem.rightBarButtonItem = cancleButtonItem
    }
    
    func fetchEvent() {
        viewModel.fetchEvent {
            DispatchQueue.main.async {
                self.searchView.collectionView.reloadData()
            }
        }
    }
    
    private func scrollToTop() {
        searchView.collectionView.scrollToItem(
            at: IndexPath(item: -1, section: 0),
            at: .init(rawValue: 0),
            animated: true)
    }
}

// MARK: - Actions

extension SearchViewController {
    
    @objc private func didTapEventStatusButton() {
        eventStatusDropDown.show()
    }
    
    @objc private func didTapCategoryButtons() {
        categoryDropDown.show()
    }
    
}

// MARK: - UICollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: []
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let index = indexPath.row
        
        if index == viewModel.numOfEvents - 1 && !viewModel.isLast {
            fetchEvent()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        
        if translation.y > 0 {  // Up
            searchView.showTopView()
        } else {                // Down
            searchView.hideTopView()
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
        viewModel.searchContent = searchBar.text!
        dismissKeyborad()
        fetchEvent()
    }
}
