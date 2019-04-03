import UIKit
class NameData{
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Picture: NameData {
    var picture: UIImage
    var text: String
    
    init(name: String, picture: UIImage, text: String) {
        self.picture = picture
        self.text = text
        super.init(name: name)
    }
}

class TextData: NameData {
    var text : String = ""
    
    init() {
        super.init(name: "default")
    }

}

class SelVariants: NameData {
    var selectedId: Int
    var variants: [Variant]
    
    init(name: String, selectedId: Int, variants: [Variant]) {
        self.selectedId = selectedId 
        self.variants = variants
        super.init(name: name)
    }
}
