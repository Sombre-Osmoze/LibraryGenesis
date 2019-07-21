//
//  BooksList.swift
//  Library Genesis
//
//  Created by Marcus Florentin on 06/06/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import SwiftUI
import LibGenAPI

struct BooksList : View {

	@State var books : [Book] = []
	@State var search : String = ""
	@State var filters : Book.Format.AllCases = Book.Format.allCases

    var body: some View {

		NavigationView {
			List {
				TextField("Search a book", text: $search)
					.multilineTextAlignment(.center)
				BookFilterView(filters: filters)
				.frame(minHeight: 15)
				ForEach(books.filter({ filters.contains($0.extension) })) { book in
					NavigationLink(book.title, destination: BookView(book: book))
				}

			}
			.navigationBarTitle("\(books.count) book\(books.count > 1 ? "s" : "")")
		}
		.onAppear() {
			self.loadDataBooks()

		}

    }

	func loadDataBooks() -> Void {

		interation.libGens(from: Date(timeIntervalSinceNow: -86400.0 * 3.0)) { (result) in
			if let books = try? result.get() {
				self.books.append(contentsOf: books)
			}
		}
	}

}

#if DEBUG

struct LibGenList_Previews : PreviewProvider {

	private static let data : [Book] = load("libGensData.json")

    static var previews: some View {
		BooksList(books: libGensData)
			.previewDisplayName("\(libGensData.count) book\(libGensData.count > 1 ? "s" : "")")
    }
}
#endif

