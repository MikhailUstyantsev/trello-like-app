//
//  ViewController.swift
//  Trello-likeApp
//
//  Created by Mikhail Ustyantsev on 06.11.2023.
//

import UIKit

class BoardViewController: UIViewController {

    var boards = [
            Board(title: "To Do", items: ["Database Migration", "Schema Design", "Storage Management", "Model Abstraction"]),
            Board(title: "In Progress", items: ["Push Notification", "Analytics", "Machine Learning"]),
            Board(title: "Done", items: ["System Architecture", "Alert & Debugging"])
        ]
    
    let gapBetweenSections = 100
    
    private let trelloCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 320, height: 480)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BoardCollectionViewCell.self, forCellWithReuseIdentifier: BoardCollectionViewCell.id)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addViews()
        constraintViews()
        configureViews()
        updateCollectionViewItem(with: view.bounds.size)
    }

    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateCollectionViewItem(with: size)
    }
    
    private func updateCollectionViewItem(with size: CGSize) {
        guard let layout = trelloCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        layout.itemSize = CGSize(width: 225, height: size.height * 0.8)
    }

    private func addViews() {
        view.addSubview(trelloCollectionView)
    }
    
    
    
    private func constraintViews() {
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            trelloCollectionView.topAnchor.constraint(equalTo: margins.topAnchor),
            trelloCollectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            trelloCollectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            trelloCollectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
        ])
    }
    
    
    
    private func configureViews() {
        title = R.Strings.BoardViewController.appTitle
        trelloCollectionView.backgroundColor = R.Colors.blue
        trelloCollectionView.dataSource = self
        view.backgroundColor = .systemBackground
        setupAddButtonItem()
    }
    
    @objc func addListTapped(_ sender: Any) {
        let alertController = UIAlertController(title: R.Strings.BoardViewController.addList, message: nil, preferredStyle: .alert)
           alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: R.Strings.TableHeaderView.addTitle, style: .default, handler: { (_) in
               guard let text = alertController.textFields?.first?.text, !text.isEmpty else {
                   return
               }
               
               self.boards.append(Board(title: text, items: []))
               
               let addedIndexPath = IndexPath(item: self.boards.count - 1, section: 0)
               
               self.trelloCollectionView.insertItems(at: [addedIndexPath])
               self.trelloCollectionView.scrollToItem(at: addedIndexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
           }))
           
        alertController.addAction(UIAlertAction(title: R.Strings.BoardCollectionViewCell.cancel, style: .cancel, handler: nil))
           present(alertController, animated: true)
       }
    
    func setupAddButtonItem() {
            let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addListTapped(_:)))
            navigationItem.rightBarButtonItem = addButtonItem
        }
    
}


extension BoardViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = trelloCollectionView.dequeueReusableCell(withReuseIdentifier: BoardCollectionViewCell.id, for: indexPath) as? BoardCollectionViewCell else { return UICollectionViewCell() }
        cell.parentVC = self
        cell.set(with: boards[indexPath.item])
        return cell
    }
    
    
    
    
}
