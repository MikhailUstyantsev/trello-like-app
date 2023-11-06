//
//  TableHeaderView.swift
//  Trello-likeApp
//
//  Created by Mikhail Ustyantsev on 06.11.2023.
//

import UIKit

class TableHeaderView: UIView {

    static let headerId = "TableHeaderView"
    
    private let addButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle(R.Strings.TableHeaderView.addTitle, for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        view.titleLabel?.font = R.Fonts.montserratSemiBold(with: 16)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        constraintViews()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func  addViews() {
        addSubview(addButton)
    }
    
    
    private func  constraintViews() {
        NSLayoutConstraint.activate([
            addButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            addButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func  configureViews() {
        backgroundColor = R.Colors.white
    }
    
    
    
    //MARK: Public methods
    
    public func addTarget(target: Any?, selector: Selector) {
        addButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
}
