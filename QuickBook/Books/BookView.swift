//
//  BookView.swift
//  Library Genesis
//
//  Created by Marcus Florentin on 05/06/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import SwiftUI
import LibGenAPI

#if os(iOS)
// Only to present file to user
import UIKit
#endif

struct BookView : View, DynamicViewProperty {

	// MARK: - Book View

	var book : Book

	@State private var zommed : Bool = false
	@State private var isDownloading = false
	@State private var progressBar = ProgressBar(alignement: .leading, progress: 50 / 100)


	func download() -> Void {
		guard !isDownloading else { return }

		isDownloading = true
		interation.download(book, progress: { _  in }) { (result) in
			switch result {
			case .success(let data):

				do {
					// Check book data
					try self.book.isValid(data: data)

					// Temporay store the file
					let tmpUrl = FileManager.default.temporaryDirectory.appendingPathComponent(self.book.locator)

					try data.write(to: tmpUrl)

					// Presente file to user
					DispatchQueue.main.async {
						#if os(iOS)
						let document = UIDocumentInteractionController(url: tmpUrl)
						document.uti = self.book.extension.rawValue
						document.name = self.book.locator
						document.presentPreview(animated: true)
						#endif
					}
				} catch {
					print("Bad thing")
				}

			case .failure(let error):
				print(error)
			}
			self.isDownloading = false
		}
	}

	// MARK: - User Interface

    var body: some View {

		ScrollView {
			VStack {
				book.image()
					.cornerRadius(20)
					.aspectRatio(contentMode: zommed ? .fill : .fit)
					.padding(zommed ? [] : .all)
					.tapAction {
						self.zommed.toggle()
					}

				Spacer()

				Text(book.title)
					.font(.title)
					.multilineTextAlignment(.center)
					.allowsTightening(true)
					.padding([.top, .leading, .trailing])
					.lineLimit(nil)

				HStack {
					Text(book.author)
						.font(.subheadline)
						.italic()
					Text(book.year)
						.font(.subheadline)
						.fontWeight(.semibold)
				}
				if book.isPaged() {
					Text("\(book.pages) page\(Int(book.pages) ?? 0 > 1 ? "s" : "")")
						.font(.caption)
						.fontWeight(.medium)
				}

				Spacer()

				VStack {
					Text(book.extension.rawValue.uppercased())
						.bold()

					if isDownloading {
						progressBar
							.padding(.horizontal)
							.frame(minWidth: 350, minHeight: 20)
						Text(book.formatedSize())
							.font(.footnote)
							.fontWeight(.light)
					} else {
						Button(action: download) {
							Image(systemName: "icloud.and.arrow.down.fill")
						}
						.frame(minWidth: 100)
					}
				}

				Spacer()
				if book.descr != nil {
					/// Show the book descrition
					Text(book.descr!)
						.font(.body)
						.frame(minHeight: 200, alignment: .center)
						.lineLimit(nil)
						.padding(.all)
						.multilineTextAlignment(.center)

				}
				if !isDownloading {
					Text(book.formatedSize())
						.font(.footnote)
						.fontWeight(.light)
				}

			}
		}

    }


	// MARK: - UIKit Integration

	var controllers: [UIViewController] = []


}

#if DEBUG
struct BookView_Previews : PreviewProvider {

	static let data : [Book] = load("libGenData.json")

    static var previews: some View {
		BookView(book: data[0])
			.previewDisplayName("Book look")
			
    }
}
#endif
