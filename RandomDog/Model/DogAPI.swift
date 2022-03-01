//
//  DogAPI.swift
//  RandomDog
//
//  Created by Nathalie Cesarino on 22/02/22.
//

import Foundation
import UIKit

class DogAPI {
    enum Endpoint {
        case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        // 1
        case listAllBreeds
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        // Computed Property
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            // 1
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }
    
    // 2
    class func requestBreedsList(completionHandler: @escaping ([String], Error?) -> Void) {
        // Make the request:
        let task = URLSession.shared.dataTask(with: Endpoint.listAllBreeds.url) {
            (data, response, error) in
            // Check we are getting data back:
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            let breedsResponse = try! decoder.decode(BreedsListResponse.self, from: data)
            // Convert the keys property to an array of strings:
            let breeds = breedsResponse.message.keys.map({$0})
            completionHandler(breeds, nil)
        }
        // Ensure request is executed:
        task.resume()
    }
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
        let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage, nil)
        })
        task.resume()
    }
    
    class func requestRandomImage(breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void) {
        let randomImageEndpoint =
        DogAPI.Endpoint.randomImageForBreed(breed).url
        
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) {
            (data, response, error) in
            guard let data = data else {
                // se der erro:
                completionHandler(nil, error)
                return }
        
        let decoder = JSONDecoder()
        let imageData = try!
            decoder.decode(DogImage.self, from: data)
        print(imageData)
            // se for sucesso:
            completionHandler(imageData, nil)
            
        }
        task.resume()
    }

}
