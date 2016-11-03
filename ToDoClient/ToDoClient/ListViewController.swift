//
//  ViewController.swift
//  ToDoClient
//
//  Created by tajika on 2016/10/15.
//  Copyright © 2016年 Tajika. All rights reserved.
//

import UIKit
import Siesta
import SiestaUI
import SwiftyJSON

class ListViewController: UIViewController, ResourceObserver {
    
    @IBOutlet weak var tableView: UITableView!
    var todos: [JSON] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var statusOverlay = ResourceStatusOverlay()
    var todoResource: Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
            let _ = todoResource?
                .addObserver(self)
                .addObserver(statusOverlay, owner: self)
                .loadIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusOverlay.embedIn(self)
        todoResource = TodoApi.todos
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TodoListTableViewCell", bundle: nil), forCellReuseIdentifier: "todoCell")
    }
    
    override func viewDidLayoutSubviews() {
        statusOverlay.positionToCoverParent()
    }
    
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        todos = todoResource?.typedContent() ?? []
    }
    
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as? TodoListTableViewCell else {
            return UITableViewCell()
        }
        guard todos.count > indexPath.row else {
            fatalError()
        }
        guard let todo = try? Todo(json: todos[indexPath.row]) else {
            fatalError()
        }
        
        cell.titleLabel.text = todo.title
        
        return cell
    }
    
}
