//
//  ProgressBar.swift
//  Library Genesis
//
//  Created by Marcus Florentin on 14/07/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import SwiftUI


struct ProgressBar : View {

	let alignement : Edge
	let thickness : CGFloat = 25

	@State var progress : CGFloat = 0

	var body : some View {
		ZStack {
			/// First path to construct the bar edge
			BarEdge(alignement: alignement)
				.foregroundColor(.secondary)

			/// Seconde path to construct the bar progress
			BarProgress(alignement: alignement, progress: progress)
			.foregroundColor(.accentColor)
		}
		.drawingGroup()
	}

	var animatableData: CGFloat {
		get {  return progress }
		set { progress = newValue }
	}

	static func == (lhs: ProgressBar, rhs: ProgressBar) -> Bool {
		// Compare the bars alignement
		guard lhs.alignement == rhs.alignement else { return false }

		// Compare the bars thickness
		guard lhs.thickness == rhs.thickness else { return false }

		// Comparare the progress
		guard lhs.progress == rhs.progress else { return false }

		return true
	}
}

#if DEBUG
struct ProgressBar_Previews : PreviewProvider {
    static var previews: some View {
        ProgressBar(alignement: .leading, progress: 0.5)
		.previewLayout(.sizeThatFits)
    }
}
#endif

// TODO:  Documentation

fileprivate struct BarProgress: Shape {

	let alignement : Edge
	let thickness : CGFloat = 10

	@State var progress : CGFloat = 0

	func path(in rect: CGRect) -> Path {
		let horizontal = Edge.Set.horizontal.contains(.init(self.alignement))
		var path = Path()
		path.addRoundedRect(in: .init(x: alignement == .trailing ? rect.maxX - rect.width * self.progress : rect.minX,
									  y: alignement == .bottom ? rect.maxY - rect.height * self.progress : rect.minY,
									  width: horizontal ? rect.width * self.progress : self.thickness,
									  height: horizontal ? self.thickness : rect.height * self.progress),
							cornerSize: .init(width: (horizontal ? self.thickness : rect.width * self.progress) / 2,
											  height: (horizontal ? rect.height * self.progress : self.thickness) / 2))
		return path
	}

	var animatableData: CGFloat {

		get {  return progress }

		set {
			for i in stride(from: progress, to: newValue, by: 0.01) {
				progress = i
			}
		}
	}
}



fileprivate struct BarEdge: Shape {

	let alignement : Edge
	let thickness : CGFloat = 10

	func path(in rect: CGRect) -> Path {

		var path = Path()
		let horizontal = Edge.Set.horizontal.contains(.init(self.alignement))
		path.addRoundedRect(in: .init(x: rect.minX, y: rect.minY,
									  width: horizontal ? rect.width : self.thickness,
									  height: horizontal ? self.thickness : rect.height),
							cornerSize: .init(width: (horizontal ? self.thickness : rect.width) / 2,
											  height: (horizontal ? rect.height : self.thickness) / 2))
		return path
	}

}
