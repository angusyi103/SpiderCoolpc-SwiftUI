//
//  TutorDetail.swift
//  SpiderCoolpc
//
//  Created by Angus Yi on 2021/4/22.
//

import SwiftUI

struct TutorDetail: View {
    var name: String
    var headline: String
    var bio: String
    
    var body: some View {
        VStack {
            Image(name)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.orange, lineWidth: 4))
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            Text(name)
                .font(.title)
            Divider()
            Text(headline)
                .font(.subheadline)
            Text(bio)
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(50)
        }.padding()
    }
}

#if DEBUG
struct TutorDetail_Previews: PreviewProvider {
    let tutor: Tutor
    static var previews: some View {
        TutorDetail(name: "Simon Ng", headline: "Founder of AppCoda", bio: "Founder of AppCoda. Author of multiple iOS programming books including Beginning iOS 12 Programming with Swift and Intermediate iOS 12 Programming with Swift. iOS Developer and Blogger.")
    }
}
#endif
