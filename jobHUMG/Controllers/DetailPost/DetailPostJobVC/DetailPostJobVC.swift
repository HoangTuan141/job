//
//  DetailPostJobVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/8/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class DetailPostJobVC: UIViewController {
    
    // MARK: - OUTLET
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightCommentTextView: NSLayoutConstraint!
    @IBOutlet weak var heightCommentView: NSLayoutConstraint!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var commentTextView: PlaceholderTextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var bottomConstraintViewComment: NSLayoutConstraint!
    
    // MARK: - Variable
    var id: Int?
    var detailPost: DataDetailRecruitmentPost?
    var listComment = [CommentDetailRecruitmentPost]()
    var refreshControl = UIRefreshControl()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()
        getDetailPost()
        setupView()
        setupTableView()
    }
    
    // MARK: - Function
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1000
        tableView.registerNibCellFor(type: RecruitmentCell.self)
        tableView.registerNibCellFor(type: CommentTableViewCell.self)
        refreshControl.addTarget(self, action: #selector(refreshListPost), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupView() {
        navigationView.setGradientBackground(startColor: .greenMainColor, endColor: .rightGradientColor, gradientDirection: .leftToRight)
        enableSendCommentButton(false)
        commentTextView.placeholder = "Viết comment..."
        commentTextView.colorBackground = .lineGray
        commentTextView.heightDidChange = { [weak self] height in
            self?.heightCommentTextView.constant = height > 38 ? height : 38
            if height > 114 {
                self?.heightCommentTextView.constant = 114
            }
            self?.heightCommentView.constant = (self?.heightCommentTextView.constant)! + 20
            if (self?.commentTextView.textView.text.isEmpty)! {
                self?.enableSendCommentButton(false)
            } else {
                self?.enableSendCommentButton(true)
            }
        }
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification,object: nil)
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification,object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            if #available(iOS 11.0, *) {
                let window = UIApplication.shared.keyWindow
                let bottomPadding = window?.safeAreaInsets.bottom
                bottomConstraintViewComment.constant = keyboardHeight - bottomPadding! - 40
            } else {
                bottomConstraintViewComment.constant = keyboardHeight - 40
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide (_ notification: Notification){
        self.bottomConstraintViewComment.constant = 0
        self.view.layoutIfNeeded()
        
    }
    
    func enableSendCommentButton( _ isUserInteractionEnabled: Bool) {
        if isUserInteractionEnabled {
            sendButton.isUserInteractionEnabled = true
            sendButton.setImage(#imageLiteral(resourceName: "ic_send"), for: .normal)
        } else {
            sendButton.isUserInteractionEnabled = false
            sendButton.setImage(#imageLiteral(resourceName: "ic_send_gray"), for: .normal)
        }
    }
    
    private func getDetailPost() {
        DetailRecruitmentPostAPI(id: self.id ?? 0).excute(target: self, success: { [weak self] response in
            self?.hideLoading()
            guard let data = response?.data else { return }
            self?.detailPost = data
            self?.listComment = data.comment
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
            self?.tableView.scrollToBottom()
        }, error: { [weak self] error in
            self?.hideLoading()
            self?.refreshControl.endRefreshing()
        })
    }
    
    private func commentPost(content: String) {
        CommentPostAPI(content: content, postId: self.id ?? 0, type: "comment_post").excute(target: self, success: { [weak self] response in
            self?.getDetailPost()
        }, error: { error in
            self.getDetailPost()
        })
        self.commentTextView.textView.resignFirstResponder()
    }
    
    private func likePost(id: Int) {
        LikePostAPI(id: id).excute(target: self, success: { [weak self] response in
            self?.getDetailPost()
            }, error: { error in
                self.getDetailPost()
        })
    }
    
    @objc func refreshListPost() {
        self.getDetailPost()
    }
   
    // MARK: - ACTION
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func commentPressed(_ sender: Any) {
        commentPost(content: commentTextView.textView.text!)
        self.enableSendCommentButton(false)
        self.commentTextView.textView.text = ""
        self.commentTextView.placeholderLabel.isHidden = false
        self.commentTextView.textView.resignFirstResponder()
    }
}

extension DetailPostJobVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return listComment.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecruitmentCell", for: indexPath) as! RecruitmentCell
            cell.isHiddenSeparator = true
            cell.selectionStyle = .none
            
            if let data = self.detailPost {
                cell.fillDataDetail(data: data)
            }
            
            cell.tapLikeButton = { [weak self] in
                guard let strongSelf = self else { return }
                guard let detailPost = self?.detailPost else { return }
                cell.setupLikeButton(isLike: !detailPost.isLike)
                let like = detailPost.likeCount
                cell.likeLabel.text = detailPost.isLike ? "\(like - 1)" : "\(like + 1)"
                strongSelf.likePost(id: detailPost.id)
            }
            
            cell.tapGoToUserInfo = {
                let vc = UserInfoVC()
                vc.userId = self.detailPost?.userId ?? 0
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
            cell.selectionStyle = .none
            cell.fillData(data: listComment[indexPath.row])
            
            cell.tapGoToUserInfo = { [weak self] in
                let vc = UserInfoVC()
                vc.userId = self?.listComment[indexPath.row].userId ?? 0
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.commentTextView.textView.resignFirstResponder()
    }
}
