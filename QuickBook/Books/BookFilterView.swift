//
//  BookFilterView.swift
//  Library Genesis
//
//  Created by Marcus Florentin on 21/07/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import SwiftUI
import LibGenAPI

fileprivate struct FilterView: View {

	let type : Book.Format
	@State var isSelected : Bool = false

	var body: some View {
		Text("\(type.rawValue)")
			.font(isSelected ? .headline : .callout)
			.padding(.horizontal)
			.tapAction {
				print("taped: \(self.type.rawValue)")
				self.isSelected.toggle()
		}

	}
}

struct BookFilterView: View {

	@State var filters : Book.Format.AllCases = Book.Format.allCases

	var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {

			HStack(alignment: .top, spacing: 8) {

				ForEach(Book.Format.allCases) { (type) in
					Text(String("\(type)"))
						.font(self.filters.contains(type) ? .headline : .callout)
						.padding(.horizontal)
						.tapAction {
							if self.filters.contains(type) {
								self.filters.removeAll(where: { $0 == type })
							} else {
								self.filters.append(type)
							}
					}
				}
			}
		}

    }
}

#if DEBUG
struct BookFilterView_Previews: PreviewProvider {
    static var previews: some View {
        BookFilterView()
    }
}
#endif
