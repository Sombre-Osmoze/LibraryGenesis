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

	let books : [LibGen]

    var body: some View {

		NavigationView {
			List(books) { book in
				NavigationButton(destination: BookView(book: book)) {
					BookRow(book: book)
				}
			}
		}
		.navigationBarTitle(Text("Books"))

    }
}

#if DEBUG

struct LibGenList_Previews : PreviewProvider {
    static var previews: some View {
		BooksList(books: libGensData)
			.previewDisplayName("\(libGensData.count) book\(libGensData.count > 1 ? "s" : "")")
    }
}
#endif

