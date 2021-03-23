//
//  Note.swift
//  Dictator WatchKit Extension
//
//  Created by Dan Smith on 23/03/2021.
//

import Foundation

struct Note: Identifiable, Codable {
	let id: UUID
	let text: String
}
