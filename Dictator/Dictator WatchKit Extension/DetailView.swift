//
//  DetailView.swift
//  Dictator WatchKit Extension
//
//  Created by Dan Smith on 23/03/2021.
//

import SwiftUI

struct DetailView: View {
	let index: Int
	let noteCount: Int
	let note: Note

  var body: some View {
		Text(note.text)
			.navigationTitle("Note \(index + 1)/\(noteCount)")
  }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
			DetailView(index: 1, noteCount: 5, note: Note(id: UUID(), text: "super.init"))
    }
}
