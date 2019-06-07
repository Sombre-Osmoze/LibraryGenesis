//
//  TestsData.swift
//  Library Genesis
//
//  Created by Marcus Florentin on 06/06/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import Foundation
import LibGenAPI
import SwiftUI

public func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
	let data: Data

	guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
		else {
			fatalError("Couldn't find \(filename) in main bundle.")
	}

	do {
		data = try Data(contentsOf: file)
	} catch {
		fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
	}

	do {
		let decoder = JSONDecoder()
		return try decoder.decode(T.self, from: data)
	} catch {
		fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
	}
}

extension LibGen: Identifiable {

	func image() -> Image {
		let url = URL(string: "http://booksdescr.org/covers/\(coverurl)")!
		guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return Image(systemName: "video.fill") }
		return Image(uiImage: image)
	}

}

//extension LibGen where Self: Identifiable { }

#if DEBUG
let libGensData : [LibGen] = load("manyLibGens.json")
#endif
