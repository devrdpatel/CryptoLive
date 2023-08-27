//
//  LaunchView.swift
//  CryptoLive
//
//  Created by Dev Patel on 8/20/23.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var loadingText: [String] = "Loading your Portfolio...".map { String($0) }
    @State private var showLoadingText: Bool = false
    @State private var counter: Int = 0
    @Binding var showLaunchView: Bool
    
    private let loops = 2
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var steps: Int {
        loops * loadingText.count
    }
    
    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
            ZStack {
                if showLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(.launch.accent)
                                .offset(y: counter % loadingText.count == index ? -5 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                guard showLaunchView else { return } // only for preview purpose
                
                counter += 1
                
                if counter >= steps {
                    showLaunchView = false
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
