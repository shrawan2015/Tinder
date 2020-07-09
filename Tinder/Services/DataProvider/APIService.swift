//
//  APIService.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 27/06/20..
//  Copyright © 2020 Shrawan. All rights reserved.
//
//="randomapi"
import Alamofire

protocol NetworkCall {
    func fetchData(using request: String,completion: @escaping (Data?, Error?) -> Void)
}


class AFWrapper: NetworkCall {
     static let sharedInstance = AFWrapper()
     let baseURLString = "https://randomuser.me/api"
     let version = "0.4"
    
    func fetchData(using request: String,completion: @escaping (Data?, Error?) -> Void){
        let urlStr = "\(baseURLString)/\(version)/?\(request)"
        AF.request(urlStr).response { (response) in
            completion(response.data, response.error)
        }
    }

    func getData(_ strURL: String , success:@escaping (Any) -> Void, failure:@escaping (Error) -> Void)
    {
        let urlStr = "\(baseURLString)/\(version)/?\(strURL)"
        AF.request(urlStr).response { (response) in
            debugPrint("response",response)
            if let error = response.error {
                failure(error)
            } else if let data = response.data {
                success(data)
            }
        }
    }
}
