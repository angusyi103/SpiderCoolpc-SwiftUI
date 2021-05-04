//
//  SpiderPage.swift
//  SpiderCoolpc
//
//  Created by Angus Yi on 2021/4/25.
//

import SwiftUI

struct SpiderPage: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("getdata", action: {
                getCoolpcGPUData()
        })
    }
}

#if DEBUG
struct SpiderPage_Previews: PreviewProvider {
    static var previews: some View {
        SpiderPage()
    }
}
#endif
