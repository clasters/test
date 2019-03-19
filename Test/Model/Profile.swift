
struct Root: Decodable {
    let data: [Data]
    let view: [String]
   }

struct Data: Decodable {
    let name: String?
    let data: ViewData?
}

struct Variants: Decodable {
    let id: Int?
    let text: String?
}

struct ViewData: Decodable {
    let url: String?
    let text: String?
    let selectedId: Int?
    let variants: [Variants]?
}





