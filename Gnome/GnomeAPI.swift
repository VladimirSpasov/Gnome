//
//  GnomeAPI.swift
//  Gnome
//
//  Created by Vladimir Spasov on 10/11/17.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper



class GnomeAPI: NSObject {

    private let apiUrlString = "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json"

    func fetchGnomes(completion: @escaping (Result<[Gnome]>) -> Void){
        //        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        guard let url = URL(string: apiUrlString) else { return completion(.Error("Invalid URL, we can't update your feed")) }

        Alamofire.request(url).validate().responseArray(keyPath: "Brastlewark") { (response: DataResponse<[Gnome]>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result {
            case .success:
                let result = response.result.value ?? []
                DispatchQueue.main.async {
                    completion(.Success(result))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.Error(error.localizedDescription))
                }
                return completion(.Error(error.localizedDescription))
            }
        }
    }
}



enum Result<T> {
    case Success(T)
    case Error(String)
}
