//
//  FetchAPI.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/05.
//

import Foundation
enum APIError: Error{
    case network(description: String)
    case parsing(description: String)
}


class Fetcher{
    
    private var urllink="/api/v1/"
    private var host = "http://localhost:5000"
    let dateFormater = DateFormatter()

    init(){
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        dateFormater.locale = Locale(identifier: "en_US_POSIX")
        dateFormater.timeZone = TimeZone(identifier: "Asia/Tokyo")
    }
    func fetchData(method:String,path:String,body:Data!,completion: @escaping (AnyObject?)->Void){
        
        urllink = host + path
        
        var  request = URLRequest(url: URL(string: urllink)!)
        var JsonObject: AnyObject?
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.httpMethod = method
        request.setValue("Bearer \(g_user_token)", forHTTPHeaderField: "Authorization")
        if (body != nil) {
            request.httpBody = body
        }
        
        let task: URLSessionTask = URLSession.shared.dataTask(with: request,completionHandler: {(data,response,error)in
            do{
                JsonObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! AnyObject
                completion(JsonObject!)

            }catch{
                //completion(AnyObject)
                completion(JsonObject)
            }
        })
        
        task.resume()
    }

}
