//
//  TrelloLikeCollectionViewCell.swift
//  Trello-likeApp
//
//  Created by Mikhail Ustyantsev on 06.11.2023.
//

import UIKit
import MobileCoreServices

class BoardCollectionViewCell: UICollectionViewCell {
    
    static let id = "BoardLikeCollectionViewCell"
    weak var parentVC: BoardViewController?
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        view.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: SectionHeaderView.sectionHeaderId)
        return view
    }()
    
    var board: Board?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        constraintViews()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(with board: Board) {
        self.board = board
        tableView.reloadData()
    }
    
    
    private func addViews() {
        contentView.addSubview(tableView)
    }
    
    
    
    private func constraintViews() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    @objc func addTapped(_ sender: Any) {
        
        let alertController = UIAlertController(title: R.Strings.BoardCollectionViewCell.addTask, message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: R.Strings.TableHeaderView.addTitle, style: .default, handler: { (_) in
            guard let text = alertController.textFields?.first?.text, !text.isEmpty else {
                return
            }
            
            guard let data = self.board else {
                return
            }
            
            data.items.append(text)
            let addedIndexPath = IndexPath(item: data.items.count - 1, section: 0)
            
            self.tableView.insertRows(at: [addedIndexPath], with: .automatic)
            self.tableView.scrollToRow(at: addedIndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        }))
        
        alertController.addAction(UIAlertAction(title: R.Strings.BoardCollectionViewCell.cancel, style: .cancel, handler: nil))
        parentVC?.present(alertController, animated: true, completion: nil)
    }
    
    
    private func configureViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 5
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        
        let header = TableHeaderView(frame: CGRect(
            x: 0,
            y: 0,
            width: tableView.frame.size.width,
            height: 44))
        
        header.addTarget(target: self, selector: #selector(addTapped(_:)))
        
        
        tableView.tableHeaderView = header
        tableView.tableFooterView = UIView()
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = CGFloat(0)
        }
        tableView.backgroundColor = R.Colors.blue
    }
    
    
}

extension BoardCollectionViewCell: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        guard let board = board, let stringData = board.items[indexPath.row].data(using: .utf8) else {
            return []
        }
        
        let itemProvider = NSItemProvider(item: stringData as NSData, typeIdentifier: kUTTypePlainText as String)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        session.localContext = (board, indexPath, tableView)
        
        return [dragItem]
    }
    
}

extension BoardCollectionViewCell: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        if coordinator.session.hasItemsConforming(toTypeIdentifiers: [kUTTypePlainText as String]) {
            coordinator.session.loadObjects(ofClass: NSString.self) { (items) in
                guard let string = items.first as? String else {
                    return
                }
                var updatedIndexPaths = [IndexPath]()
                
                switch (coordinator.items.first?.sourceIndexPath, coordinator.destinationIndexPath) {
                case (.some(let sourceIndexPath), .some(let destinationIndexPath)):
                    // Same Table View
                    if sourceIndexPath.row < destinationIndexPath.row {
                        updatedIndexPaths =  (sourceIndexPath.row...destinationIndexPath.row).map { IndexPath(row: $0, section: 0) }
                    } else if sourceIndexPath.row > destinationIndexPath.row {
                        updatedIndexPaths =  (destinationIndexPath.row...sourceIndexPath.row).map { IndexPath(row: $0, section: 0) }
                    }
                    self.tableView.beginUpdates()
                    self.board?.items.remove(at: sourceIndexPath.row)
                    self.board?.items.insert(string, at: destinationIndexPath.row)
                    self.tableView.reloadRows(at: updatedIndexPaths, with: .automatic)
                    self.tableView.endUpdates()
                    break
                    
                case (nil, .some(let destinationIndexPath)):
                    // Move data from a table to another table
                    self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
                    self.tableView.beginUpdates()
                    self.board?.items.insert(string, at: destinationIndexPath.row)
                    self.tableView.insertRows(at: [destinationIndexPath], with: .automatic)
                    self.tableView.endUpdates()
                    break
                    
                    
                case (nil, nil):
                    // Insert data from a table to another table
                    self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
                    self.tableView.beginUpdates()
                    self.board?.items.append(string)
                    self.tableView.insertRows(at: [IndexPath(row: self.board!.items.count - 1 , section: 0)], with: .automatic)
                    self.tableView.endUpdates()
                    break
                    
                default: break
                    
                }
            }
        }
    }
    
    func removeSourceTableData(localContext: Any?) {
        if let (dataSource, sourceIndexPath, tableView) = localContext as? (Board, IndexPath, UITableView) {
            tableView.beginUpdates()
            dataSource.items.remove(at: sourceIndexPath.row)
            tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    
}

extension BoardCollectionViewCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return board?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: SectionHeaderView.sectionHeaderId)
                as? SectionHeaderView
        else {
            return nil
        }
        if let title = board?.title {
            view.set(with: title)
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = "\(board!.items[indexPath.row])"
        cell.contentView.backgroundColor = .tertiaryLabel
        return cell
    }
    
}

extension BoardCollectionViewCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
