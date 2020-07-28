
import Foundation

// JSON data
let json = """
[
    {
        "title": "New York",
        "location_type": "City",
        "woeid": 2459115,
        "latt_long": "40.71455,-74.007118"
    }
]
""".data(using: .utf8)!

// Create Model(s)

struct City: Decodable {
    let title: String
    let locationType: String
    let woeid: Int
    let coordinate: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case locationType = "location_type"
        case woeid
        case coordinate = "latt_long"
    }
}

//=========================================
// decode the JSON data to our Swift model
//=========================================


do {
    let cities = try JSONDecoder().decode([City].self, from: json)
    dump(cities)
    
} catch {
    print("error decoding json: \(error)")
}
