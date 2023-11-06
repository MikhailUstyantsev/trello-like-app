//
//  SectionHeaderView.swift
//  Trello-likeApp
//
//  Created by Mikhail Ustyantsev on 06.11.2023.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {

    static let sectionHeaderId = "UITableViewHeaderFooterView"

    private let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = R.Fonts.montserratLight(with: 16)
        return view
    }()
        
    override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            configure()
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func configure() {
            contentView.addSubview(label)
            let backgroundView = UIView(frame: .zero)
            backgroundView.backgroundColor = R.Colors.purple
            self.backgroundView = backgroundView
            
            NSLayoutConstraint.activate([
                label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
            ])
        }
    
    
    public func set(with title: String) {
        label.text = title
    }
    
}
