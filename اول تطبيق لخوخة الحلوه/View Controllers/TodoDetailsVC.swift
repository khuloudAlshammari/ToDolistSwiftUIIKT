//
//  TodoDetailsVC.swift
//  اول تطبيق لخوخة الحلوه
//
//  Created by khuloud alshammari on 26/04/1443 AH.
//

import UIKit

class TodoDetailsVC: UIViewController {
   
    var todo : Todo!
    @IBOutlet weak var todoTitleLebael: UILabel!
    var index : Int!
    @IBOutlet weak var todoImageView: UIImageView!
    
    @IBOutlet weak var detailsLabel: UILabel!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if todo.image != nil {
            todoImageView.image = todo.image
        }else{
            todoImageView.image = UIImage(named: "Image-6")
        }
          setupUI()
        // Do any additional setup after loading theview.
        
        NotificationCenter.default.addObserver(self, selector: #selector(currentTodoEited), name: NSNotification.Name(rawValue: "CurrentTodoEdited"), object: nil)

    }
    
    @objc func currentTodoEited(notification: Notification){
        if let todo = notification.userInfo?["editedTodo"] as? Todo {
            self.todo = todo
             setupUI()
            
            
        }
    }
    func setupUI(){
        detailsLabel.text = todo.details
        todoTitleLebael.text = todo.title
        todoImageView.image = todo.image

    }
  
     
    @IBAction func editTodoButtonClicked(_ sender: Any) {
        
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "NewTodoVC") as? NewTodoVC{
            
            viewController.isCretion = false
            viewController.editedTodo = todo
            viewController.editedTodoIndex = index
            
            
            navigationController?.pushViewController(viewController, animated: true)
            
        }
      
    }
//    @IBAction func deleteBttonClicked(_ sender: Any) {
//    }
    
    @IBAction func deleteBttonClicked(_ sender: Any) {
        print("222222222222222222")
        let confirmAlert = UIAlertController(title:"تنبية", message: "هل أنت متاكد من اتمام رغبتك بالحذف؟", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "تاكيد الحذف", style: .destructive) { alert in
            
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TodoDeleted"), object: nil, userInfo: ["deletdTodoIndx": self.index])
            let alert = UIAlertController(title: "تم", message: "تم حذف المهمة بنجاح", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "تم", style: .default) { alert in
                self.navigationController?.popViewController(animated: true)
            }
            
            alert.addAction(closeAction)
            self.present(alert, animated: true, completion: nil)
        }
        confirmAlert.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "الغاء", style: .default, handler: nil)
        confirmAlert.addAction(cancelAction)
        
        
        present(confirmAlert, animated: true, completion: nil)
    }
    

}
        
