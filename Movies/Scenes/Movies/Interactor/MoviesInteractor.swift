//
//  MoviesInteractor.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/3/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//

import Foundation
import UIKit

class MoviesInteractor {
    
    private let imagesCahe = NSCache<AnyObject, AnyObject>()
    
    func getMovies(forPageNumber number: Int, callBack:@escaping ([Movie]) -> Void, failureHandler:@escaping (Error) -> Void) {
                
        let urlString = Constant.baseURL + Constant.discoverMovies + "?api_key=\(Constant.apiKey)&page=\(number)"
        
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        guard let url = URL(string: urlString) else { return }
        let task = session.dataTask(with: url) { (data, response, error) in

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                failureHandler(error!)
                
                return
            }
            do {
                let decoder = JSONDecoder()
                let res = try decoder.decode(DiscoverMovieJSON.self, from: data)
                
                let queue = OperationQueue.main
                queue.addOperation {
                    callBack(res.results)
                }
            } catch {
                let queue = OperationQueue.main
                queue.addOperation {
                    failureHandler(error)
                }
            }
        }
        task.resume()
    }
    
    func getImageFromURL(urlString: String, completion: @escaping (UIImage?)->Void) {
        
        if let imageFromCache = imagesCahe.object(forKey: urlString as AnyObject) as? UIImage {
            completion(imageFromCache)
        }
        OperationQueue().addOperation {
            if let url = URL(string: Constant.imagesURL + urlString),
                let imageData = try? Data(contentsOf: url),
                let image = UIImage(data: imageData) {
                OperationQueue.main.addOperation {
                    self.imagesCahe.setObject(image, forKey: urlString as AnyObject)
                    completion(image)
                }
            }
        }
    }
}
