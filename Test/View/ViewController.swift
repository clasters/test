import UIKit
import Alamofire
import Foundation
class ViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView?
    @IBOutlet var viewModel: ViewModel!
    
    var textData: TextData?
    var pictureData: Picture?
    var selector: SelVariants?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchProfile { [weak self] in
            DispatchQueue.main.async {
                for view in (self?.viewModel.showView())!{
                    switch view{
                    case "hz":
                        self!.textData = self?.viewModel.getData(name: view) as? TextData
                        let textLabel = UILabel()
                        textLabel.text = self!.textData?.text
                        textLabel.numberOfLines = 0;
                        let tap = UITapGestureRecognizer(target: self, action: #selector(self!.tapText))
                        textLabel.isUserInteractionEnabled = true
                        textLabel.addGestureRecognizer(tap)
                        self?.stackView?.addArrangedSubview(textLabel)
                        
                    case "picture":
                        self!.pictureData = self?.viewModel.getData(name: view) as? Picture
                        let picture = UIImageView()
                        picture.image = self!.pictureData?.picture
                        picture.contentMode = .scaleAspectFit
                        
                        let tap = UITapGestureRecognizer(target: self, action: #selector(self!.tapPicture))
                        picture.isUserInteractionEnabled = true
                        picture.addGestureRecognizer(tap)
                        self!.stackView?.addArrangedSubview(picture)
                        
                    case "selector":
                        self!.selector = self?.viewModel.getData(name: view) as? SelVariants
                        let pickerView = UIPickerView()
                        pickerView.delegate = self
                        
                        self?.stackView?.addArrangedSubview(pickerView)
                        pickerView.selectRow(self!.selector!.selectedId, inComponent: 0, animated: true)
                    default:
                        print("Error")
                    }
                }
            }
        }
        
    }
}


extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selector!.variants.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selector?.variants[row].text
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        MessageAlert(messageText: "\(selector!.variants[row].id)", controller: self)
    }
    
    @objc func tapText(sender:UITapGestureRecognizer) {
        MessageAlert(messageText: "\((textData?.name)!)", controller: self)
    }
    
    @objc func tapPicture(sender:UITapGestureRecognizer) {
        MessageAlert(messageText: "\(pictureData!.text)", controller: self)
        
    }
}

