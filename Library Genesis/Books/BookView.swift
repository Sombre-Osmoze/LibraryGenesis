//
//  BookView.swift
//  Library Genesis
//
//  Created by Marcus Florentin on 05/06/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import SwiftUI
import LibGenAPI

struct BookView : View {
	
	var book : LibGen

    var body: some View {

		VStack(alignment: .center) {

				book.image()
					.cornerRadius(20)
					.aspectRatio(contentMode: .fit)
				//			Text(book.title)
				//				.lineLimit(3)
				//				.font(.title)
				//				.multilineTextAlignment(.center)
				//				.padding(.horizontal)

				HStack {
					Text(book.author)
						.font(.subheadline)
					Text(book.year)
						.font(.subheadline)
						.fontWeight(.semibold)
				}

				Spacer()

				Text(book.descr ?? "No descrition")
					.multilineTextAlignment(.center)
					.lineLimit(100)
					.font(.body)
		}
		.navigationBarTitle(Text(book.title))
    }
}

#if DEBUG
struct BookView_Previews : PreviewProvider {
    static var previews: some View {
		BookView(book: libGensData[0])
			.previewDisplayName("Book look")
    }
}
#endif
