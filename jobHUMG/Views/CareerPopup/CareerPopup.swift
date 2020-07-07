//
//  CareerPopup.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 7/5/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class CareerPopup: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var tapOnCareer: ((_ career: String) -> Void)?
    var career: String?
    let listCareer = ["An toàn lao động", "Bán hàng kỹ thuật", "Bán lẻ/ bán sỉ", "Báo chí / Truyền hình", "Bảo hiểm", "Bảo trì / sửa chữa", "Bất động sản", "Biên / Phiên dịch", "Bưu chính - Viễn thông", "Chứng khoán / Vàng / Ngoại tệ", "Cơ khí / Chế tạo / Tự động hoá", "Công nghệ cao", "Công nghệ Ô tô", "Công nghệ thông tin", "Dầu khí / Hoá chất", "Dệt may / Da giày", "Địa chất / Khoáng sản", "Dịch vụ khách hàng", "Điện / Điện tử / Điện lạnh", "Điện tử viễn thông", "Du lịch", "Dược phẩm / Công nghệ sinh học", "Giáo dục / Đào tạo", "Hàng cao cấp", "Hàng gia dụng", "Hàng hải", "Hàng không", "Hàng tiêu dùng", "Hành chính / Văn phòng", "Hoá học / Sinh học", "Hoạch định / Dự án", "In ấn / Xuất bản", "IT phần cứng", "IT phần mềm",  "Kế toán / Kiểm toán", "Khách sạn / Nhà hàng", "Kiến trúc", "Kinh doanh / Bán hàng", "Logistics", "Luật / Pháp lý", "Marketing / Truyền thông / Quảng cáo", "Môi trường / Xử lý chất thải", "Mỹ phẩm / Trang sức", "Mỹ thuật / Nghệ thuật / Điện ảnh", "Ngân hàng / Tài chính", "NGO / Phi chính phủ / Phi lợi nhuận", "Nhân sự", "Nông / Lâm / Ngư nghiệp", "Phi chính phủ / Phi lợi nhuận", "Quản lý chất lượng (QA/QC)", "Quản lý điều hành", "Sản phẩm công nghiệp", "Sản xuất", "Spa/ Làm đẹp", "Tài chính / Đầu tư", "Thiết kế đồ hoạ", "Thiết kế nội thất", "Thời trang", "Thư ký / Trợ lý", "Thực phẩm / Đồ uống", "Tổ chức sự kiện / Quà tặng", "Tư vấn", "Vận tải / Kho vận", "Xây dựng", "Xuất nhập khẩu", "Y tế / Dược", "Ngành nghề khác"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 1000
        tableView.registerNibCellFor(type: CareerTableViewCell.self)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopup))
        self.topView.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissPopup() {
        self.dismiss(animated: false, completion: nil)
    }
}

extension CareerPopup: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCareer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CareerTableViewCell", for: indexPath) as! CareerTableViewCell
        cell.fillData(career: listCareer[indexPath.row])
        if cell.titleLabel.text == career {
            cell.markImage.isHidden = false
        } else {
            cell.markImage.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tapOnCareer?(listCareer[indexPath.row])
        self.dismiss(animated: false, completion: nil)
    }
    
}
