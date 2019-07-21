//
//  Books.swift
//  Library Genesis
//
//  Created by Marcus Florentin on 14/07/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import SwiftUI
import Combine

import LibGenAPI


extension Book.Format: Identifiable {
	public var id: Int {
		self.hashValue
	}


}

extension Book: Identifiable {

	/// Cache for the cover
	private static var covers : [String: Data] = [:]

	@discardableResult func fetchCover() -> some Publisher {
		let url = URL(string: "http://booksdescr.org/covers/\(coverurl)")!

		return URLSession.shared.dataTaskPublisher(for: url)
	}

	func image() -> Image {

		fetchCover()

		guard let data = Book.covers[coverurl],
			let image = UIImage(data: data) else { return .init("book cover") }

		return .init(uiImage: image)
	}


	func isPaged() -> Bool {
		switch self.extension {
		case .EPUB:
			return false
		default:
			return true
		}
	}

	private static var formatter : ByteCountFormatter {
		let format = ByteCountFormatter()
		format.countStyle = .file
		format.formattingContext = .dynamic
		format.allowsNonnumericFormatting = true
		format.isAdaptive = true
		return format
	}

	func formatedSize() -> String {
		let bytes = Int64(self.filesize) ?? 0

		let result = Book.formatter.string(fromByteCount: bytes)

		return result.replacingOccurrences(of: "B", with: "o")
	}

	enum DataCheckError: Error {
		case size
		case hash
	}

	func isValid(data: Data) throws {

		// Chek if the data octet number is available
		if let size = Int(self.filesize) {
			// Verify that the data received correspond of the expected size
			guard data.count == size else { throw DataCheckError.size }
		}

		

	}

}
