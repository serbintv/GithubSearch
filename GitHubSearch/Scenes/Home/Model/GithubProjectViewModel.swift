//
//  GithubProjectViewModel.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import Foundation

struct GithubProjectViewModel {
    var name: String? {
        return project.name
    }
    
    var language: String? {
        return project.language
    }
    
    var description: String? {
        return project.description
    }
    
    private let project: GithubProject
    
    init(project: GithubProject) {
        self.project = project
    }
}
