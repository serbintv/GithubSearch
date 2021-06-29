//
//  HomeViewController.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import UIKit

final class GithubProjectsViewController: UIViewController, BindableType,
                          KeyboardObservable {
    
    //MARK: - KeyboardObservable
    var showObserver: NSObjectProtocol?
    var hideObserver: NSObjectProtocol?
    var showBlock: ((Notification) -> Void)?
    var hideBlock: ((Notification) -> Void)?
    
    //MARK: - Outlets
    @IBOutlet private weak var searchBarView: UISearchBar!
    @IBOutlet private weak var projectListTableView: UITableView!
    
    //MARK: - BindableType
    var viewModel: GithubProjectsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBarView
        setupHideKeyboardOnTap()
        setupKeyboardObserver()
        configureKeyboardListener()
        setupSearchBar()
    }
    
    //Setup search bar
    private func setupSearchBar() {
        searchBarView.delegate = self
    }
}

//MARK: - BindableType
extension GithubProjectsViewController {
    func bindViewModel() {
        setupTableView()
        viewModel.errorHandler = { [weak self] (error) in
            self?.showAlert(withError: error)
        }
        
        viewModel.searchResultHandler = {[weak self] in
            guard let `self` = self
            else {
                return
            }
            self.projectListTableView.reloadData()
        }
    }
}

extension GithubProjectsViewController {
    func setupKeyboardObserver() {
        showBlock = {[weak self] notification in
            let keyboardHeight = notification.getKeyboardHeight()
            self?.projectListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }

        hideBlock = { [weak self] _ in
            self?.projectListTableView.contentInset = .zero
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension GithubProjectsViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        projectListTableView.register(GithubProjectCell.self)
        projectListTableView.delegate = self
        projectListTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GithubProjectCell.defaultReuseIdentifier, for: indexPath) as? GithubProjectCell
        else {
            return UITableViewCell()
        }
        
        cell.configure(viewModel.repositoryModel(at: indexPath.row), at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.openRepository(at: indexPath.row)
    }
    
}

//MARK: - UISearchBarDelegate
extension GithubProjectsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.performSearch(with: searchBar.text ?? "")
    }
}

//MARK: - UIScrollViewDelegate
extension GithubProjectsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (offsetY > contentHeight - scrollView.frame.height)
            && !(searchBarView.text ?? "").isEmpty {
            viewModel.loadMore()
        }
    }
    
}
