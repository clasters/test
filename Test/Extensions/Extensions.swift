import UIKit

func MessageAlert(messageText: String, controller: UIViewController) {
    let alert = UIAlertController(title: "Вы нажали на элемент:", message: messageText, preferredStyle: UIAlertController.Style.alert)
    
    alert.addAction(UIAlertAction(title: "Продолжить", style: UIAlertAction.Style.default, handler: nil))
    
    controller.present(alert, animated: true, completion: nil)
}



