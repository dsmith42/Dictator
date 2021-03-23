//
//  ContentView.swift
//  Dictator WatchKit Extension
//
//  Created by Dan Smith on 23/03/2021.
//

import SwiftUI

struct ContentView: View {
	@State private var notes = [Note]()
	@State private var text = ""

	var body: some View {
		VStack {
			HStack {
				TextField("Add new note", text: $text)

				Button {
					guard !text.isEmpty else { return }

					let note = Note(id: UUID(), text: text)
					notes.append(note)

					text = ""
					save()
				} label: {
					Image(systemName: "plus")
						.padding()
				}
				.fixedSize()
				.buttonStyle(BorderedButtonStyle(tint: .blue))
			}

			List {
				ForEach(0..<notes.count, id: \.self) { i in
					NavigationLink(destination: DetailView(index: i, noteCount: notes.count, note: notes[i])) {
						Text(notes[i].text)
							.lineLimit(1)
					}
				}
				.onDelete(perform: delete)
			}
		}
		.navigationTitle("Dictator")
		.onAppear(perform: load)
	}

	// MARK: - Helper functions

	private func delete(offsets: IndexSet) {
		withAnimation {
			notes.remove(atOffsets: offsets)
			save()
		}
	}

	private func save() {
		do {
			let data = try JSONEncoder().encode(notes)
			let url = getDocumentsDirectory().appendingPathComponent("notes")
			try data.write(to: url)
		} catch {
			print("Save failed")
		}
	}

	private func load() {
		DispatchQueue.main.async {
			do {
				let url = getDocumentsDirectory().appendingPathComponent("notes")
				let data = try Data(contentsOf: url)
				notes = try JSONDecoder().decode([Note].self, from: data)
			} catch {
				// no save file so must be fresh install
			}
		}
	}

	private func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
