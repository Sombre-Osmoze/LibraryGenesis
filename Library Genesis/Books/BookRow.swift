//
//  BookRow.swift
//  Library Genesis
//
//  Created by Marcus Florentin on 06/06/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import SwiftUI
import LibGenAPI

struct BookRow : View {

	var book : LibGen

    var body: some View {
        HStack {
			book.image()
				.resizable()
				.aspectRatio(.init(width: 32.5, height: 50.0), contentMode: .fit)
				.frame(minWidth: 100, maxWidth: .infinity)
			VStack {
				Text(book.title)
					.font(.headline)
					.multilineTextAlignment(.leading)
					.truncationMode(.tail)
				Text(book.author)
					.font(.subheadline)
					.multilineTextAlignment(.leading)
			}
			Spacer()
			Text(book.extension.uppercased())
				.fontWeight(.heavy)
				.padding(.trailing)

        }
    }
}

#if DEBUG
struct BookRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            BookRow(book: libGensData[0])
			
        }
		.previewLayout(.sizeThatFits)
		.previewDisplayName("Book")
    }
}
#endif
