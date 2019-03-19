import UIKit
import Alamofire

class ViewController: UIViewController {
     @IBOutlet weak var stackView: UIStackView?
    var textData: [String: String]?
    var pictureData: [String: Foundation.Data]?
    var pickerData: [Int: String]? = [:]
    var selectIdPicker: Int?
    
    func getProfile() {
     AF.request("https://prnk.blob.core.windows.net/tmp/JSONSample.json").responseJSON { (response) in
        switch response.result {
            case .success:
                if((response.result) != nil) {
                    let jsonData = response.data
                    do{
                       let root = try JSONDecoder().decode(Root.self, from: jsonData!)
                        
                        for viewData in root.data{
                            switch viewData.name{
                            case "hz": 
                                self.textData = [(viewData.name)!:(viewData.data!.text)!]
                                
                            case "picture":
                                let pictureURL = try? Foundation.Data(contentsOf: URL(string:(viewData.data?.url)!)!)
                                self.pictureData = ([(viewData.data?.text)! : pictureURL] as! [String : Foundation.Data])
                                
                            case "selector":
                                self.selectIdPicker = (viewData.data?.selectedId)!
                                for pickerData in (viewData.data?.variants)!{
                                    self.pickerData![pickerData.id!] = pickerData.text
                                }
                            default:
                                print("Error")
                            }
                        }
                        
                        for view in root.view{
                            switch view{
                            case "hz":
                                let textLabel = UILabel()
                                for (key, _) in self.textData! {
                                    textLabel.text = self.textData![key]
                                }
                                let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapText))
                                textLabel.isUserInteractionEnabled = true
                                textLabel.addGestureRecognizer(tap)
                                self.stackView?.addArrangedSubview(textLabel)
                               
                            case "picture":
                                let picture = UIImageView()
                                for (key, _) in self.pictureData! {
                                    picture.image = UIImage(data: self.pictureData![key]!)
                                }
                                picture.contentMode = .scaleAspectFit
                                let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapPicture))
                                picture.isUserInteractionEnabled = true
                                picture.addGestureRecognizer(tap)
                                self.stackView?.addArrangedSubview(picture)
                                
                            case "selector":
                                let pickerView = UIPickerView()
                                pickerView.delegate = self
                               
                                self.stackView?.addArrangedSubview(pickerView)
                                pickerView.selectRow(self.selectIdPicker!, inComponent: 0, animated: true)
                            default:
                                print("Error")
                            }
                        }
                    }catch {
                        print("Error: \(error)")
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getProfile()
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selected = Array((pickerData?.keys)!)
        MessageAlert(messageText: "\(selected[row])", controller: self)
    }
    
    @objc func tapText(sender:UITapGestureRecognizer) {
        for (key, _) in textData! {
            MessageAlert(messageText: "\(key)", controller: self)
        }
    }
    
    @objc func tapPicture(sender:UITapGestureRecognizer) {
        for (key, _) in pictureData! {
            MessageAlert(messageText: "\(key)", controller: self)
        }
    }
}

