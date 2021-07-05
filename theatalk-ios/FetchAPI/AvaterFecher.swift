//
//  AvaterFecher.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/06/12.
//


import Foundation
import Combine
class AvaterFetcher:Fetcher{
    @Published var avaters: [Avater]=[]
    override init(session: URLSession = .shared){

        super.init()
    }
  }

extension AvaterFetcher{
    
    func GETAvaterImages(
    ) -> AnyPublisher<Avater_Json,APIError>{
        return fetchData(with: makeComponents(Path: "/images", Type: "GET", body: nil))
    }
    func GETAvaterImage(
        avaterId:Int
    ) -> AnyPublisher<Avater_Json,APIError>{

        do{
            return fetchData(with: makeComponents(Path: "/images/\(avaterId)", Type: "GET", body: nil))
        }catch{
            let error = APIError.network(description: "could not encode")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func POSTAvater(
        avaterId: Int
    ) ->AnyPublisher<User_Json,APIError>{
        do{
            return fetchData(with: makeComponents(Path: "/images/\(avaterId)", Type: "POST", body: nil))
        }catch{
            let error = APIError.network(description: "could not encode")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }


}
