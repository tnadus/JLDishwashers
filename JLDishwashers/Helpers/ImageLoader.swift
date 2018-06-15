//
//  ImageLoader.swift
//  JLDishwashers
//
//  Created by Murat Sudan on 15.06.2018.
//  Copyright © 2018 Tarum Nadus. All rights reserved.
//

import Foundation

/// Image provider from an url address
class ImageLoader {
    
    /// Load image from url addrees
    ///
    /// - Parameters:
    ///   - urlString: url address in String type
    ///   - completion: callback method called when fetch is completed
    static func load(urlString: String, completion: @escaping (Data?)->Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: url) { (data, res, err) in
            
            if err != nil || (res as! HTTPURLResponse).statusCode != 200 || data == nil {
                return
            }
            
            DispatchQueue.main.async {
                completion(data)
            }
        }
        task.resume()
    }
}
