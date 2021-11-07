//
//  Alamofire.swift
//  RakuBookAPILessonApp
//
//  Created by UrataHiroki on 2021/11/07.
//

import Alamofire
import SwiftyJSON

class Alamofire{
    
    private var privateMediumImageUrl:String?
    private var privateBookTitle:String?
    private var privateAuthor:String?
    private var privateItemPrice:Int?
    
    private var bookDetailDataArray = [BookDetailDatas]()

}

extension Alamofire{
    
    public func getBookDetailDatas(searchKeyWord:String?,completion: @escaping ([BookDetailDatas]?,Error?) -> Void){
        
        guard let keyword = searchKeyWord else { return }
        
        let apiKey = ""
        
        AF.request(apiKey, method: .get, parameters: nil, encoding: JSONEncoding.default).response { [self] respnse in
            
            switch respnse.result{
                
            case .success:
                let data = JSON(respnse.data as Any)
                
                print(data)
                for itemCount in 0..<data["Items"].count{
                    
                    getDataNilCheck(imageurl: data["Items"][itemCount]["Item"]["mediumImageUrl"].string,
                                        title: data["Items"][itemCount]["Item"]["title"].string,
                                        author: data["Items"][itemCount]["Item"]["author"].string,
                                    itemPrice: data["Items"][itemCount]["Item"]["itemPrice"].int)
                    
                    bookDetailDataArray.append(BookDetailDatas(mediumImageUrl: privateMediumImageUrl,
                                                               bookTitle: privateBookTitle,
                                                               author: privateAuthor,
                                                               itemPrice: privateItemPrice))
                    
                }
                print(bookDetailDataArray)
           completion(bookDetailDataArray, nil)
                
            case .failure(let error):
                
                completion(nil, error)
            }
        }
    }
}


extension Alamofire{
    
    private func getDataNilCheck(imageurl:String?,title:String?,author:String?,itemPrice:Int?){
        
        if imageurl != nil{
            
            privateMediumImageUrl = imageurl
            
        }else{
            
            privateMediumImageUrl = ""
        }
        
        if title != nil{
            
            privateBookTitle = title
        }else{
            
            privateBookTitle = "読み込みエラー"
        }
        
        if author != nil{
            
            privateAuthor = author
        }else{
            
            privateAuthor = "読み込みエラー"
        }
        
        if itemPrice != nil{
            
            privateItemPrice = itemPrice
        }else{
            
            privateItemPrice = 0000
        }
        
    }
}


extension String{
    
    var urlEncoded:String{
        
        let charset = CharacterSet.alphanumerics.union(.init(charactersIn: "/?-._~"))
        let remove = removingPercentEncoding ?? self
        
        return remove.addingPercentEncoding(withAllowedCharacters: charset) ?? remove
    }
}
