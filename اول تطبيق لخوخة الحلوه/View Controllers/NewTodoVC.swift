//
//  NewTodoVC.swift
//  اول تطبيق لخوخة الحلوه
//
//  Created by khuloud alshammari on 27/04/1443 AH.
//

import UIKit

class NewTodoVC: UIViewController {
    
   var isCretion = true
    var editedTodo: Todo?
    var editedTodoIndex: Int?
    
    
    @IBOutlet weak var detailsTextView: UITextView!
   
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var mainButton: UIButton!
    
    @IBOutlet weak var todoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isCretion  {
            mainButton.setTitle("تعديل", for: .normal)
            navigationItem.title = "تعديل مهمة"
            
            if let todo = editedTodo{
                titleTextField.text =
                todo.title
                detailsTextView.text = todo.details
                todoImageView.image = todo.image
            }
                
        }

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func changeButtonClicked(_ sender: Any) {
        
     let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .savedPhotosAlbum
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func addBttonClicked(_ sender: Any) {
        if isCretion {
            let todo = Todo(title: titleTextField.text!, image: todoImageView.image, details: detailsTextView.text)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NewTodoAdded"), object: nil, userInfo: ["addedTodo":todo])
         
            let alert = UIAlertController(title:"تم الاضافه", message: "تم اضافة المهمة بنجاح", preferredStyle: UIAlertController.Style.actionSheet)
            let closeAction = UIAlertAction(title: "تم", style: UIAlertAction.Style.default) { _ in
                self.tabBarController?.selectedIndex = 0
                print(self.detailsTextView.text)
                self.titleTextField.text = ""
                self.detailsTextView.text = ""
                
                }
            alert.addAction(closeAction)
            
            present(alert, animated: true, completion: {
                
            })
            
           
            
            
        }else{
            //else, if the view controller is opend for edit (not for create)
            let todo = Todo(title: titleTextField.text!, image: todoImageView.image, details: detailsTextView.text)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CurrentTodoEdited"), object: nil, userInfo: ["editedTodo":todo, "editedTodoIndex": editedTodoIndex])
            
               let alert = UIAlertController(title:"تم التعديل", message: "تم تعديل المهمة بنجاح", preferredStyle: UIAlertController.Style.actionSheet)
            let closeAction = UIAlertAction(title: "تم", style: UIAlertAction.Style.default) { _ in
                   self.navigationController?.popViewController(animated: true)
                   self.titleTextField.text = ""
                   self.detailsTextView.text = ""
                   
                   }
               alert.addAction(closeAction)
               
               present(alert, animated: true, completion: {
                   
               })
               
              
            
            
        }
    

    }
    
}
extension NewTodoVC :
    UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info [UIImagePickerController.InfoKey .editedImage] as! UIImage
        dismiss(animated: true, completion: nil)
        todoImageView.image = image
    }
}
