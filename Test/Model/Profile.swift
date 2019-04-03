struct Root: Decodable {
    let data: [Datum]
    let view: [String]
}

struct Datum: Decodable {
    let name: String
    let data: DataClass
}

struct DataClass: Decodable {
    let text: String?
    let url: String?
    let selectedID: Int?
    let variants: [Variant]?
    
    enum CodingKeys: String, CodingKey {
        case text, url
        case selectedID = "selectedId"
        case variants
    }
}

struct Variant: Decodable {
    let id: Int
    let text: String
}




