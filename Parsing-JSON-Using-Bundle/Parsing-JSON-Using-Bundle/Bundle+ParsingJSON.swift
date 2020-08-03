//
//  Bundle+ParsingJSON.swift
//  Parsing-JSON-Using-Bundle
//
//  Created by Amy Alsaydi on 8/3/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation

//enum BundleError: Error {
//    case invalidResource(String)
//    case noContents(String)
//    case decodingError(Error)
//}
//
//extension Bundle {
//    // 1. Get the path od the file to be read using the bundle class => String (the path)
//    // 2. Using the path read its data contents => Data?
//
//
//    // Bundle.main is a singleton
//
//    //parseJSON will be a throwing function
//    // to use throwing functions you have to use try or do {} catch {} or try!
//
//    func parseJSON(with name: String) throws -> [President] { // convert to a generic to return any type
//
//        guard let path = Bundle.main.path(forResource: name, ofType: ".json") else {
//            throw BundleError.invalidResource(name)
//        }
//
//        guard let data = FileManager.default.contents(atPath: path) else {
//            throw BundleError.noContents(path)
//        }
//
//        var presidents: [President]
//
//        do {
//            presidents = try JSONDecoder().decode([President].self, from: data)
//
//        } catch {
//            throw BundleError.decodingError(error)
//        }
//
//        return presidents
//    }
//}


enum BundleError: Error {
 case invalidResource(String)
 case noContents(String)
 case decodingError(Error)
}
extension Bundle {
 // 1. Get the (path) of the file to be read using the Bundle class => String?
 // 2. Using the path read it's data contents => Data?
 // Bundle.main is a singleton
 // FileManager.default is a singleton
 // parseJSON will be a throwing function
 // to use throwing function you have to use try? or do {} catch{} or try!
 func parseJSON(with name: String) throws -> [President] {
  guard let path = Bundle.main.path(forResource: name, ofType: ".json") else {
   throw BundleError.invalidResource(name)
  }
  guard let data = FileManager.default.contents(atPath: path) else {
   throw BundleError.noContents(path)
  }
  var presidents: [President]
  do {
   presidents = try JSONDecoder().decode([President].self, from: data)
  } catch {
   throw BundleError.decodingError(error)
  }
  return presidents
 }
}
