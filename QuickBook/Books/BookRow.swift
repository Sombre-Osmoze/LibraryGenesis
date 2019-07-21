//
//  BookRow.swift
//  Library Genesis
//
//  Created by Marcus Florentin on 06/06/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import SwiftUI
import LibGenAPI

struct BookRow : View, DynamicViewProperty {
	var book : Book

	@State var imageData : Data? = nil

    var body: some View {
        HStack {
			/// Thumbmail View
			VStack {

				if imageData == nil {
					Image("book cover")
						.resizable()
						.cornerRadius(10)
						.aspectRatio(contentMode: .fit)
						.frame(alignment: .leading)
						.frame(maxWidth: 100)
				} else {
					Image(uiImage: UIImage(data: imageData!)!)
						.resizable()
						.cornerRadius(10)
						.aspectRatio(contentMode: .fit)
						.frame(alignment: .leading)
						.frame(maxWidth: 100)
				}
				Text(book.extension.rawValue.uppercased())
					.fontWeight(.heavy)
					.foregroundColor(.secondary)
			}
			.frame(maxHeight: 200)


			/// Quick look view
			VStack(alignment: .leading) {
				Text(book.title)
					.allowsTightening(true)
					.font(.headline)
					.lineLimit(nil)
				Text(book.author)
					.font(.subheadline)
					.italic()
					.allowsTightening(true)
					.multilineTextAlignment(.leading)
			}
        }
		.onAppear {
			let url = URL(string: "http://booksdescr.org/covers/\(self.book.coverurl)")!

//			URLSession.shared.dataTaskPublisher(for: url)
//				.sink(receiveCompletion: { _ in }) { (arg0
//					) in
//
//					let (dataR, response) = arg0
//					DispatchQueue.main.async {
//						self.imageData = dataR
//					}
//			}
		}
		.frame(height: 200)
			.contextMenu {
				if book.isPaged() {
					Text(book.pages + " pages")
				}
				Text(book.formatedSize())
				Text(book.year)
		}
		
    }

}

#if DEBUG
struct BookRow_Previews : PreviewProvider {

	private static let data : [Book] = load("libGensData.json")

    static var previews: some View {
        Group {
            BookRow(book: data[0])
			
        }
//		.previewLayout(.sizeThatFits)
		.previewDisplayName("Book")
    }
}
#endif
