import Foundation
import UIKit
class ViewModel: NSObject{
    
    @IBOutlet weak var networkManager: NetworkManager!
    
    private var profile: Root?
    
    func fetchProfile(completion: @escaping() -> ()) {
        networkManager.fetchProfile { [weak self] profile in
            self?.profile = profile
            completion()
        }
    }
    
    func showView() -> [String] {
        return profile!.view
    }
    
    func getData(name: String) -> NameData {
        var returnValue = NameData(name: "String")
        
        let text = TextData()
        let picture: Picture
        let selector: SelVariants
        
        
        for data in profile!.data{
            if data.name == "hz" && data.name == name{
                text.name = data.name
                text.text +=  "\n\(data.data.text ?? " Default " )" 
                
                returnValue = text
            }
            else if data.name == "picture" && data.name == name{
                let image: UIImage
                if let imageURL = URL(string: data.data.url!), let imageData = try? Data(contentsOf: imageURL) {
                    image = UIImage(data: imageData)!
                } else {
                    image = UIImage(named: "default")!
                }
                picture = Picture(name: data.name, picture: image, text: data.data.text ?? " Default ")
                
                return picture
            }
            else if data.name == "selector" && data.name == name{
                selector = SelVariants(name: data.name,
                                       selectedId: data.data.selectedID ?? 0,
                                       variants: data.data.variants ?? [Variant(id: 0, text: " Default ")])
                
                return selector
            }
        }
        
        
        return returnValue
    }
}
