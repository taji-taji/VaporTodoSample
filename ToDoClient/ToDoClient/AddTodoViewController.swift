//
//  AddTodoViewController.swift
//  ToDoClient
//
//  Created by tajika on 2016/11/03.
//  Copyright © 2016年 Tajika. All rights reserved.
//

import UIKit
import Siesta
import SwiftyJSON

class AddTodoViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismissSelf()
    }
    
    @IBAction func AddTodo(_ sender: UIButton) {
        guard let title = titleTextField.text, !title.isEmpty else {
            return
        }
        let json = JSON(dictionaryLiteral: [("title", title)])
        TodoApi.todos
            .request(.post, json: json.object as! NSJSONConvertible)
            .onSuccess { (entity) in
                print(entity)
                self.dismissSelf()
            }
            .onFailure { (error) in
                print(error)
            }
    }
    
    fileprivate func dismissSelf() {
        guard
            let navigationController = self.presentingViewController as? UINavigationController,
            let listViewController = navigationController.viewControllers[0] as? ListViewController
        else {
            return
        }
        self.dismiss(animated: true, completion: nil)
        listViewController.todoResource?.load()
    }
    
}
