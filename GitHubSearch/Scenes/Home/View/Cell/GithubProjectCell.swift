//
//  RepositoryCell.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import UIKit

class GithubProjectCell: UITableViewCell, ConfigurableCell {
    typealias DataSourceType = GithubProjectViewModel
    
    //MARK: - Outlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ item: GithubProjectViewModel, at indexPath: IndexPath) {
        nameLabel.text = item.name
        descriptionLabel.text = item.description
        languageLabel.text = item.language
    }
}
