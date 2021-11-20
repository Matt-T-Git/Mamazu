//
//  MamazuMultipartImage.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 18.11.2021.
//

import UIKit

public enum Method : String {
    case GET = "GET"
    case POST = "POST"
    
}

public enum MimeType:String {
    case jpeg = "image/jpeg"
    case png = "image/png"
    case gif = "image/gif"
}

public typealias Parameters = [String: Any]

open class MamazuMultipartImage: NSObject {
    
    public var request : URLRequest!
    
    public init(_ postUrl: String, paramters: Parameters, image: UIImage, imagekey: String, imageName: String, MimeType: MimeType? = .jpeg, method: Method = .POST) {
        super.init()
        guard let mamazuImage = MamazuMediaData(image, key: imagekey, imageName: imageName, mimeType: MimeType!) else { return }
        guard let url = URL(string: postUrl) else { return }
        request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let boundary = generateBoundary()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.returnUserToken(), forHTTPHeaderField: "Authorization")
        let dataBody = createDataBody(withParameters: paramters, media: [mamazuImage], boundary: boundary)
        request?.httpBody = dataBody
    }
    
    fileprivate func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    fileprivate func createDataBody(withParameters params: Parameters?, media: [MamazuMediaData]?, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                if let arr = value as? [Any]  {
                    for i in 0 ..< arr.count {
                        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                        body.append("Content-Disposition: form-data; name=\"\(key)[]\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                        body.append("\(arr[i])\r\n".data(using: String.Encoding.utf8)!)
                    }
                } else {
                    body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                    body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                    body.append("\(value)\r\n".data(using: String.Encoding.utf8)!)
                }
            }
        }
        
        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key ?? "DefaultValue")\"; filename=\"\(photo.filename ?? "DefaultValue.jpeg")\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType! + lineBreak + lineBreak)")
                body.append(photo.data!)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
}

fileprivate struct MamazuMediaData {
    let key: String?
    let filename: String?
    let data: Data?
    let mimeType: String?
    
    init?(_ image: UIImage, key: String, imageName: String, mimeType:MimeType) {
        self.key = key
        self.mimeType = mimeType.rawValue
        self.filename = imageName
        guard let data = image.jpegData(compressionQuality: 0.5) else { return nil }
        self.data = data
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
