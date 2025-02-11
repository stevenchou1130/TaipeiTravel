//
//  LocalizationManager.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/9.
//

enum Language: String, CaseIterable {
    case zhTW = "zh-tw"
    case zhCN = "zh-cn"
    case en
    case ja
    case ko
    case es
    case id
    case th
    case vi

    var name: String {
        switch self {
        case .zhTW:
            return "繁體中文"
        case .zhCN:
            return "简体中文"
        case .en:
            return "English"
        case .ja:
            return "日本語"
        case .ko:
            return "한국어"
        case .es:
            return "Español"
        case .id:
            return "Bahasa Indonesia"
        case .th:
            return "ภาษาไทย"
        case .vi:
            return "Tiếng Việt"
        }
    }

    var title: String {
        switch self {
        case .zhTW:
            return "悠遊台北"
        case .zhCN:
            return "悠游台北"
        case .en:
            return "Explore Taipei"
        case .ja:
            return "台北を散策"
        case .ko:
            return "타이페이 여행"
        case .es:
            return "Explora Taipéi"
        case .id:
            return "Jelajahi Taipei"
        case .th:
            return "เที่ยวไทเป"
        case .vi:
            return "Khám phá Đài Bắc"
        }
    }

    var attraction: String {
        switch self {
        case .zhTW:
            return "遊憩景點"
        case .zhCN:
            return "观光景点"
        case .en:
            return "Sightseeing Spots"
        case .ja:
            return "観光スポット"
        case .ko:
            return "관광 명소"
        case .es:
            return "Lugares de interés"
        case .id:
            return "Tempat Wisata"
        case .th:
            return "สถานที่ท่องเที่ยว"
        case .vi:
            return "Điểm tham quan"
        }
    }

    var news: String {
        switch self {
        case .zhTW:
            return "最新消息"
        case .zhCN:
            return "最新动态"
        case .en:
            return "Latest News"
        case .ja:
            return "最新ニュース"
        case .ko:
            return "최신 소식"
        case .es:
            return "Últimas noticias"
        case .id:
            return "Berita Terbaru"
        case .th:
            return "ข่าวล่าสุด"
        case .vi:
            return "Tin tức mới nhất"
        }
    }

    var selectLanguage: String {
        switch self {
        case .zhTW:
            return "選擇語言"
        case .zhCN:
            return "选择语言"
        case .en:
            return "Select Language"
        case .ja:
            return "言語を選択"
        case .ko:
            return "언어를 선택하세요"
        case .es:
            return "Seleccionar idioma"
        case .id:
            return "Pilih Bahasa"
        case .th:
            return "เลือกภาษา"
        case .vi:
            return "Chọn Ngôn Ngữ"
        }
    }

    var cancel: String {
        switch self {
        case .zhTW:
            return "取消"
        case .zhCN:
            return "取消"
        case .en:
            return "Cancel"
        case .ja:
            return "キャンセル"
        case .ko:
            return "취소"
        case .es:
            return "Cancelar"
        case .id:
            return "Batal"
        case .th:
            return "ยกเลิก"
        case .vi:
            return "Hủy"
        }
    }

    var openTime: String {
        switch self {
        case .zhTW:
            return "營業時間"
        case .zhCN:
            return "营业时间"
        case .en:
            return "Business Hours"
        case .ja:
            return "営業時間"
        case .ko:
            return "영업 시간"
        case .es:
            return "Horario de atención"
        case .id:
            return "Jam Buka"
        case .th:
            return "เวลาทำการ"
        case .vi:
            return "Giờ mở cửa"
        }
    }

    var address: String {
        switch self {
        case .zhTW:
            return "地址"
        case .zhCN:
            return "地址"
        case .en:
            return "Address"
        case .ja:
            return "住所"
        case .ko:
            return "주소"
        case .es:
            return "Dirección"
        case .id:
            return "Alamat"
        case .th:
            return "ที่อยู่"
        case .vi:
            return "Địa chỉ"
        }
    }

    var tel: String {
        switch self {
        case .zhTW:
            return "聯絡電話"
        case .zhCN:
            return "联系电话"
        case .en:
            return "Contact Number"
        case .ja:
            return "電話番号"
        case .ko:
            return "전화번호"
        case .es:
            return "Número de teléfono"
        case .id:
            return "Nomor Telepon"
        case .th:
            return "เบอร์โทรศัพท์"
        case .vi:
            return "Số điện thoại"
        }
    }

    var url: String {
        switch self {
        case .zhTW:
            return "網址"
        case .zhCN:
            return "网址"
        case .en:
            return "Website"
        case .ja:
            return "ウェブサイト"
        case .ko:
            return "웹사이트"
        case .es:
            return "Sitio web"
        case .id:
            return "Situs Web"
        case .th:
            return "เว็บไซต์"
        case .vi:
            return "Trang web"
        }
    }
}
