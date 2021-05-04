//
//  HomePage.swift
//  SpiderCoolpc
//
//  Created by Angus Yi on 2021/4/22.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationView {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.orange)
                HStack {
                    NavigationLink(
                        destination: ContentView(),
                        label: {
                            Text("Tutors")
                                .padding()
                                .background(Color.purple)
                                .foregroundColor(Color.white)
                                .font(.title)
                                .cornerRadius(10)
                        }
                    )
                    
                    Spacer()
                    NavigationLink(
                        destination: SpiderPage(),
                        label: {
                            Text("Spider")
                                .background(Color.init("Tiffany"))
                                .cornerRadius(10)
                                .padding()
                                .foregroundColor(Color.white)
                                .font(.title)
                                .cornerRadius(40)
                                .padding(5)
                                .overlay(RoundedRectangle(cornerRadius: 40)
                                            .stroke(Color.init("Tiffany"), lineWidth: 5))
                        }
                    )
                }
                .padding(.horizontal, 20.0)
                Spacer()
            }
            .navigationBarTitle(Text("Home"), displayMode: .inline)
            .navigationBarColor(backgroundColor: .red, titleColor: .white)
        }
    }
}

#if DEBUG
struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
#endif

struct NavigationBarModifier: ViewModifier {

    var backgroundColor: UIColor?
    var titleColor: UIColor?

    init(backgroundColor: UIColor?, titleColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {
    func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }
}
