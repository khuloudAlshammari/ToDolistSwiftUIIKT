//
//  TodosVC.swift
//  اول تطبيق لخوخة الحلوه
//
//  Created by khuloud alshammari on 24/04/1443 AH.
//

import UIKit
import CoreData

class TodosVC: UIViewController {
   
    
 
    var todsArry: [Todo] = [
     ]
    
    
@IBOutlet weak var todosTableView: UITableView!
         
        override func viewDidLoad() {
            self.todsArry = TodoStorage.getTodos()
            
        super.viewDidLoad()
 
        //  do {
    
                
       //  }catch{
            //   let alert = //UIAlertController(title: //"error", message: "can't divide by zero", preferredStyle: .alert)
     //  let action = UIAlertAction(title: "OK", style: //.default, handler: nil)
          //  alert.addAction(action)
             //  present(alert, animated: true, //completion: nil)
         // }
        
        
            
            
            // new Todo Notification
            NotificationCenter.default.addObserver(self, selector: #selector( newTodoAdedd), name: NSNotification.Name(rawValue: "NewTodoAdded"), object: nil)
      
            // Edit Todo Notificatioo
            NotificationCenter.default.addObserver(self, selector: #selector(currentTodoEited), name: NSNotification.Name(rawValue: "CurrentTodoEdited"), object: nil)
         // todosTableView.dataSource = self
         //   todosTableView.delegate = self
            
            
         // Delet Todo Notification
            
            NotificationCenter.default.addObserver(self, selector: #selector(todoDeletd), name: NSNotification.Name(rawValue: "TodoDeleted"), object: nil)
          todosTableView.dataSource = self
            todosTableView.delegate = self


        
    }

    @objc func newTodoAdedd(notification:Notification){
       
        
        if let myTodo = notification.userInfo?["addedTodo"] as? Todo
        {
            todsArry.append(myTodo)
           // print(todsArry.count)
            todosTableView.reloadData()
        
            TodoStorage.storeTodo(todo: myTodo)
          
            
        }
     
        
    }
    
    @objc func currentTodoEited(notification: Notification){
        if let todo = notification.userInfo?["editedTodo"] as? Todo {
            if let index = notification.userInfo?["editedTodoIndex"] as? Int{
                todsArry[index] = todo
                todosTableView.reloadData()
                TodoStorage.updateTodo(todo: todo, index: index)
            }
        }
    }
    
    
    
    
    @objc func todoDeletd(notification: Notification){
        if let index = notification.userInfo?["deletdTodoIndx"] as? Int{
            todsArry.remove(at: index)
            todosTableView.reloadData()
            TodoStorage.deleteTodo(index: index)
        }
    }
    }


extension TodosVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todsArry.count
    }
    
    func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as! TodosCell
        
        var current = todsArry[indexPath.row]
        
        cell.todoTitelLabel.text = todsArry[indexPath.row].title
        
    
        
        if current.image != nil{
            
        cell.todoImageView.image = current.image
        
        }else{
           // cell.todoImageView.image = UIImage(named: "Image-4")
            current.image = UIImage(named: "Image-4")
        }
        cell.todoImageView.layer.cornerRadius = cell.todoImageView.frame.width / 2
            
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let current = todsArry[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as?
        TodoDetailsVC
        
        
        if let viewController = vc {
            viewController.todo = current
            viewController.index = indexPath.row
            
            navigationController?.pushViewController(viewController, animated: true)
        }
     
    }
    
}

