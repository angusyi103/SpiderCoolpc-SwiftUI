//
//  ContentView.swift
//  SpiderCoolpc
//
//  Created by Angus Yi on 2021/4/17.
//

import SwiftUI
import Kanna

struct ContentView: View {
    
    var tutors: [Tutor] = testData
    
    var body: some View {
        NavigationView {
            List(tutors) { tutor in
                NavigationLink(
                    destination: TutorDetail(name: tutor.name, headline: tutor.headline, bio: tutor.bio),
                    label: {
                        TutorCell(tutor: tutor)
                    })
            }
            .navigationBarTitle(Text("Tutors"))
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

struct TutorCell: View {
    let tutor: Tutor
    var body: some View {
        Image(tutor.imageName)
            .cornerRadius(40)
        VStack(alignment: .leading) {
            Text(tutor.name)
            Text(tutor.headline)
                .font(.subheadline)
                .foregroundColor(Color.gray)
        }
    }
}
