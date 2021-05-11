//
//  GPUInfo.swift
//  SpiderCoolpc
//
//  Created by Angus Yi on 2021/4/23.
//

import SwiftUI
import Kanna
import Alamofire

struct GPUInfo: Identifiable {
    var id = UUID()
    var model:String?
    var available: Bool?
    var brand: String?
    var MHz: String?
    var length: String?
    var warranty: String?
    var price: String?
}

class GPUDataHandler: ObservableObject {
    @Published var gpuInfoAry: [GPUInfo] = []
    
    let html = "http://www.coolpc.com.tw/evaluate.php"
    
    func getCoolpcGPUDatas() {
        AF.request(html).responseData { response in
            print(response)
            if let htmlResult = response.value {
                self.parseHtml(htmlResult: htmlResult)
            }
        }
    }
    
    private func parseHtml(htmlResult: Data) {
        let big5 = CFStringConvertEncodingToNSStringEncoding(2566)
        let dataString = NSString(data: htmlResult, encoding: big5)
        if let doc = try? HTML(html: dataString! as String, encoding: .utf8) {
            gpuInfoAry.removeAll()
            // Search for nodes by XPath
            for node in doc.xpath("//*[@id=\"tbdy\"]/tr[12]/td[3]/select") {
                let viewSource = node.innerHTML
                let gpuListAry = viewSource?.split(separator: "\n").filter({ $0.contains("3070") })
                gpuListAry?.forEach({
                    let gpuDetail = String($0)
                    if gpuDetail.contains("$") {
                        let available = !gpuDetail.contains("disabled")
                        let info = gpuDetail.slice(from: "❤", to: "$")?.trimmingCharacters(in: .whitespaces)
                        var brand = ""
                        if let range = info?.range(of: " ") {
                            brand = String(info?[..<range.lowerBound] ?? "")
                        }
                        let strWithoutBrand = info?.replacingOccurrences(of: brand, with: "")
                        var model = ""
                        if let range = strWithoutBrand?.range(of: "(") {
                            model = String(strWithoutBrand?[..<range.lowerBound] ?? "")
                        }
                        let specification = info?.slice(from: "(", to: ")")?.split(separator: "/")
                        let MHz = String(specification?.first(where: { $0.contains("MHz") }) ?? "MHz")
                        let length = String(specification?.first(where: { $0.contains("cm") }) ?? "cm")
                        let warranty = String(specification?.first(where: { $0.contains("年") }) ?? "年")
                        let price = String(gpuDetail.slice(from: "$", to: "◆")?.trimmingCharacters(in: .whitespaces) ?? "0")
                        gpuInfoAry.append(GPUInfo(model: model, available: available, brand: brand, MHz: MHz, length: length, warranty: warranty, price: price))
                    }
                })
                
                print(gpuInfoAry)
            }
        }
    }
}

extension String {
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}


