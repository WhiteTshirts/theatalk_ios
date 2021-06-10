//
//  ImageFetcher.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/06/10.
//

import Foundation
import Combine
class ImageFetcher:Fetcher{
    override init(session: URLSession = .shared){

        super.init()
    }
    func GetImage(imageId:Int)->AnyPublisher<String,APIError>{
        do{
            return fetchData(with: makeComponents(Path: "/images/\(imageId)", Type: "GET", body: nil))
        }catch{
            let error = APIError.network(description: "could not encode")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }


}

