
// Parsing Dictionary

import Foundation

let json = """
{
 "results": [
   {
     "firstName": "John",
     "lastName": "Appleseed"
   },
  {
    "firstName": "Alex",
    "lastName": "Paul"
  }
 ]
}
""".data(using: .utf8)! // convery to data using .utf8 format


// Create Model(s)

// Codable: Alias for Decodable & Encodable
// Decodable: converts json to data
// Encodable: converts data to json e.g to POST to Web API


// top level json is a dictionary
struct ResultsWrapper: Decodable {
    let results: [Contact]
}

struct Contact: Decodable {
    let firstName: String
    let lastName: String
}


//=================
// decode the JSON data to our Swift model
//==================


// always use the top level object to decode data
do {
    let dictionary = try JSONDecoder().decode(ResultsWrapper.self, from: json)
    let contacts = dictionary.results 
    dump(contacts)
} catch {
    print("decoding error: \(error)")
}
