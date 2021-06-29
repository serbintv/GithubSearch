//
//  HomeViewModel.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import Foundation

class GithubProjectsViewModel {
    
   
    
    //MARK: - Outputs

    var errorHandler: ((_ error: Error) -> Void)?
    var searchResultHandler: (() -> Void)?
    
    //MARK: - Private
    private (set) var repositories: [GithubProject] = [GithubProject]()
    private var currentPage = 0
    private var perPage = 30
    private var searchString: String = ""
    private var isAllLoaded: Bool = false
    private var isLoading: Bool = false
    private let networkService: GithubProjectSearchNetworkService
    
    init() {
        networkService = GithubProjectSearchNetworkService()
    }
    
    
    //MARK: - Inputs
    func performSearch(with string: String) {
        resetSearch()
        searchString = string
        if !searchString.isEmpty {
            searchRepositories()
        } else {
            searchResultHandler?()
        }
        
    }
    
    func openRepository(at index: Int) {
        guard let url = URL(string: repositories[index].html_url ?? "")
        else {
            return
        }
        
        SceneCoordinator.shared.transition(to: Scene.openUrl(url))
    }
    
    func repositoryModel(at index: Int) -> GithubProjectViewModel {
        return GithubProjectViewModel(project: repositories[index])
    }
    
    func loadMore() {
        
        if !isLoading {
            isLoading = true
            searchRepositories()
        }
    }
    
    //Reset pagination parameters
    private func resetSearch() {
        currentPage = 0
        repositories.removeAll()
        isAllLoaded = false
        isLoading = false
    }
    
    //MARK: - NetworkRequest
    private func searchRepositories() {
        if !isAllLoaded {
            currentPage += 1
            let parameters = GithubProjectSearchParameters(name: searchString,
                                                        page: currentPage,
                                                        perPage: perPage)
            networkService.searchRepositories(parameters: parameters) { [weak self] (result) in
                switch result {
                case .success(let response):
                    if let repositories = response.repositories {
                        self?.repositories.append(contentsOf: repositories)
                        self?.isAllLoaded = repositories.count < (self?.perPage ?? 0)
                    }
                    self?.searchResultHandler?()
                case .failure (let error):
                    self?.errorHandler?(error)
                }
                self?.isLoading = false
            }
        }
    }
}
