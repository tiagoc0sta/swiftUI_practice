//
//  SpotifyHomeView.swift
//  SwiftUinPractice
//
//  Created by Tiago de Freitas Costa on 2024-08-30.
//

import SwiftUI

struct SpotifyHomeView: View {
    
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            HStack(spacing: 0) {
                ZStack {
                    if let currentUser {
                        ImageLoaderView(urlString: currentUser.image)
                            .background(.spotifyWhite)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .onTapGesture {
                            }
                    }
                }
                .frame(width: 35, height: 35)

                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        ForEach(Category.allCases, id: \.self) { category in
                            SpotifyCategoryCell(
                                title: category.rawValue.capitalized,
                                isSelected: category == selectedCategory
                            )
                            .onTapGesture {
                                selectedCategory = category
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .scrollIndicators(.hidden)
            }
        }
        .task {
            await getData()
        }
    }
    
    private func getData() async {
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            //products = try await DatabaseHelper().getProducts()
        } catch {
            
        }
    }
}

#Preview {
    SpotifyHomeView()
}
