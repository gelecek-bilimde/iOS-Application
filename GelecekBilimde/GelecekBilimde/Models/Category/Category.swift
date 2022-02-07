//
//  Category.swift
//  GelecekBilimde
//
//  Created by BARIS UYAR on 3.02.2021.
//  Copyright © 2021 Burak Furkan Asilturk. All rights reserved.
//

import Foundation

enum Category: Int, Codable, CustomStringConvertible, CaseIterable {
    case med = 40
    case biology = 11
    case physic = 18
    case astronomy = 4
    case tech = 39
    case engineering = 32
    case unique = 1800
    case environment = 13
    case chemistry = 24
    case renewable_energy = 45
    case psychology = 34
    case earth_science = 46
    case science_history = 7
    case computer = 48
    case anthropology = 2
    case global_warming = 26
    case history = 37
    case archaeology = 3
    case bio_otobio = 9
    case other_science = 1693
    case science_env = 1692
    case philosophy = 17
    case math = 30
    case question_answer = 36
    case infographic = 22
    case podcast = 33
    case video = 41
    case replays = 1652
    case unknown
    
    var description: String {
        switch self {
        case .med:
            return "Tıp"
        case .biology:
            return "Biyoloji"
        case .physic:
            return "Fizik"
        case .astronomy:
            return "Astronomi"
        case .tech:
            return "Teknoloji"
        case .engineering:
            return "Mühendislik"
        case .unique:
            return "Özgün İçerik"
        case .environment:
            return "Çevre"
        case .chemistry:
            return "Kimya"
        case .renewable_energy:
            return "Yenilebilir Enerji"
        case .psychology:
            return "Psikoloji"
        case .earth_science:
            return "Yer Bilimi"
        case .science_history:
            return "Bilim Tarihi"
        case .computer:
            return "Bilgisayar Bilimleri"
        case .anthropology:
            return "Antropoloji"
        case .global_warming:
            return "Küresel Isınma"
        case .history:
            return "Tarih"
        case .archaeology:
            return "Arkeoloji"
        case .bio_otobio:
            return "Biyografi/Otobiyografi"
        case .science_env:
            return "Çevre Bilim"
        case .philosophy:
            return "Felsefe"
        case .math:
            return "Matematik"
        case .other_science:
            return "Diğer Bilimler"
        case .question_answer:
            return "Soru-Cevap"
        case .infographic:
            return "İnforgrafikler"
        case .podcast:
            return "Podcast"
        case .video:
            return "Video"
        case .replays:
            return "Yayın Tekrarları"
        case .unknown:
            return ""
        }
    }

    init(from decoder: Decoder) throws {
        guard let rawValue = try? decoder.singleValueContainer().decode(Int.self) else {
            self = .unknown
            return
        }
        self = Category(rawValue: rawValue) ?? .unknown
    }
}

struct ArticleCategory {
    let category: Category
    var page: Int = 0
    var shouldRetrieve: Bool = true
}
