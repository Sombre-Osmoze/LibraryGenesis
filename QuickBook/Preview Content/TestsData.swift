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


#if DEBUG

//public func loadBook(_ filename: String) -> [Book] {
//	guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
//		else {
//			fatalError("Couldn't find \(filename) in main bundle.")
//	}
//	let data: Data
//	do {
//		data = try Data(contentsOf: file)
//	} catch {
//		fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
//	}
//
//	do {
//		let decoder = JSONDecoder()
//		return try decoder.decode([Book].self, from: data)
//	} catch {
//		fatalError("Couldn't parse \(filename) as \(Book.self):\n\(error)")
//	}
//}


var libGensData : [Book] = load("libGensData.json")

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

#endif
