//
//  MovieDetail.swift
//  UIKit SwiftUI
//
//  Created by Mateus Kamoei on 22/07/20.
//  Copyright © 2020 Kobe. All rights reserved.
//

import SwiftUI

struct MovieDetail: View {
    @EnvironmentObject var movie: Movie
    let delegate: TableViewControllerDelegate?
    let indexPath: IndexPath
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Text(movie.title)
                        .font(.largeTitle)
                    Text("\(movie.year)")
                }
                Spacer()
                Button(action: {
                    self.movie.isFavorite.toggle()
                    self.delegate?.didSetFavorite(indexPath: self.indexPath)
                }) {
                    if movie.isFavorite {
                        Image(systemName: "suit.heart.fill")
                    } else {
                        Image(systemName: "suit.heart")
                    }
                }.padding()
            }
            VStack {
                if !movie.genres.isEmpty {
                    Divider()
                    Text(movie.genres.joined(separator: ", "))
                        .font(.caption)
                }
                Divider()
                if movie.cast.isEmpty {
                    Text("No cast data")
                    Spacer()
                } else {
                    List(movie.cast, id: \.self) { actor in
                        Text(actor)
                    }
                }
            }
        }
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        let movie = Movie(title: "Titanic", year: 2001, cast: ["Leonardo DiCaprio", "Kate Winslet"], genres: ["Drama", "Family", "Horror", "Comedy", "Documentary", "Romance"])
        return MovieDetail(delegate: nil, indexPath: IndexPath(row: 0, section: 0)).environmentObject(movie)
    }
}
