//
//  PlanetName.swift
//  HolstThePlanets
//
//  Created by 윤범태 on 2023/06/08.
//

import Foundation

fileprivate let fileExtension = "mp3"

enum PlanetName: String {
    
    case Mars
    case Venus
    case Mercury
    case Jupiter
    case Saturn
    case Uranus
    case Neptune
    
    var url: URL! {
        Bundle.main.url(forResource: self.rawValue, withExtension: fileExtension)
    }
    
    var playerTitle: String {
        switch self {
        case .Mars:
            return "I. Mars, the Bringer of War"
        case .Venus:
            return "II. Venus, the Bringer of Peace"
        case .Mercury:
            return "III. Mercury, the Winged Messanger"
        case .Jupiter:
            return "IV. Jupiter, the Bringer of Jollity"
        case .Saturn:
            return "V. Saturn, the Bringer of Old Age"
        case .Uranus:
            return "VI. Uranus, the Magician"
        case .Neptune:
            return "VII. Neptune, the Mystic"
        }
    }
    
    var titleKorean: String {
        switch self {
        case .Mars:
            return "화성"
        case .Venus:
            return "금성"
        case .Mercury:
            return "수성"
        case .Jupiter:
            return "목성"
        case .Saturn:
            return "토성"
        case .Uranus:
            return "천왕성"
        case .Neptune:
            return "해왕성"
        }
    }
    
    var subtitleKorean: String {
        switch self {
        case .Mars:
            return "전쟁을 가져오는 자"
        case .Venus:
            return "평화를 가져오는 자"
        case .Mercury:
            return "날개달린 파발꾼"
        case .Jupiter:
            return "즐거움을 가져오는 자"
        case .Saturn:
            return "황혼기를 가져오는 자"
        case .Uranus:
            return "마술사"
        case .Neptune:
            return "신비로운 자"
        }
    }
    
    var astronomyDescription: String {
        switch self {
        case .Mars:
            return """
            "화성" 악장은 로마 신화에서 전쟁과 싸움의 신으로 알려진 "마르스"에 해당합니다. "화성"은 전쟁, 강함, 투지, 군사적인 요소를 상징합니다.
            """
        case .Venus:
            return """
            "금성" 악장은 사랑과 아름다움의 신으로 알려진 그리스 신화의 "아프로디테"에 해당합니다. "금성"은 아름다움, 사랑, 조화, 감성적인 요소를 상징합니다.
            """
        case .Mercury:
            return """
            "수성" 악장은 통신과 지식의 신으로 알려진 로마 신화의 "메르큐리우스"에 해당합니다. "수성"은 소통, 지식, 사고력, 미스테리 요소를 상징합니다.
            """
        case .Jupiter:
            return """
            "목성" 악장은 번영과 풍요의 신으로 알려진 로마 신화의 "유피테르"에 해당합니다. "목성"은 번영, 성장, 지혜, 긍정적인 영향을 상징합니다.
            """
        case .Saturn:
            return """
            "토성" 악장은 시간과 인내의 신으로 알려진 로마 신화의 "사투르누스"에 해당합니다. "토성"은 인내, 책임, 한계, 현실적인 요소를 상징합니다.
            """
        case .Uranus:
            return """
            "천왕성" 악장은 혁신과 독립의 신으로 알려진 그리스 신화의 "우라노스"에 해당합니다. "천왕성"은 독창성, 혁신, 진보, 미래지향적인 요소를 상징합니다.
            """
        case .Neptune:
            return """
            "해왕성" 악장은 바다와 물의 신으로 알려진 로마 신화의 "넵투누스"에 해당합니다. "해왕성"은 상상력, 직관, 영감, 심리적인 요소를 상징합니다.
            """
        }
    }
    
    var astrologyDescription: String {
        switch self {
        case .Mars:
            return """
            화성은 행동, 역량, 용기를 상징합니다. 점성술에서 화성은 에너지, 열정, 도전을 나타내며, 행동력과 의지를 강조합니다. 화성은 전투, 도전, 성취를 위한 힘과 결단력을 상징합니다.
            """
        case .Venus:
            return """
            금성은 사랑, 아름다움, 조화를 상징합니다. 점성술에서 금성은 사랑과 관계, 미적인 요소, 예술적인 표현을 나타내는데, 사랑의 탐구, 관계 형성, 예술적인 창조에 대한 관심을 강조합니다.
            """
        case .Mercury:
            return """
            수성은 소통, 지식, 사고력을 상징합니다. 점성술에서 수성은 커뮤니케이션, 학습, 아이디어를 나타내는데, 사고력과 지적 호기심을 강조합니다. 수성은 언어, 작문, 학문적인 분야에서 중요한 영향을 미칩니다.
            """
        case .Jupiter:
            return """
            목성은 번영, 성장, 지혜를 상징합니다. 점성술에서 목성은 행운과 기회, 자신감과 확신을 나타내며, 확장과 성장에 대한 욕망을 강조합니다. 목성은 풍부한 리소스와 지혜를 가져다주는 행성으로 알려져 있습니다.
            """
        case .Saturn:
            return """
            토성은 질서, 책임, 인내를 상징합니다. 점성술에서 토성은 현실적인 제약과 한계, 자기 통제, 책임감을 나타내는데, 어떤 분야에서도 지속적인 노력과 규율이 필요함을 강조합니다.
            """
        case .Uranus:
            return """
            천왕성은 창의성, 혁신, 독립을 상징합니다. 점성술에서 천왕성은 독창성과 진보적인 아이디어를 나타내며, 개인의 독립과 자유로움에 대한 욕망을 강조합니다. 천왕성은 예측불가능성과 미래지향적인 특성을 가지고 있습니다.
            """
        case .Neptune:
            return """
            해왕성은 상상력, 직관, 영감을 상징합니다. 점성술에서 해왕성은 꿈과 환상, 정신적인 세계를 나타내며, 직관력과 창조적인 잠재력을 강조합니다. 해왕성은 미스테리와 심리적인 영역에 대한 탐구를 나타냅니다.
            """
        }
    }
}
