
//
//  PopoverMenuVIew.swift
//  JSPopoverMenu
//
//  Created by 王俊硕 on 2017/11/4.
//  Copyright © 2017年 王俊硕. All rights reserved.
//

import UIKit

class PopoverMenuView: UIView {
    
    internal var removalResponder: UIControl! // 加载在父级视图上
    internal var menuCollection: UICollectionView!
    internal var headerView: UIView!
    internal var isOnScreen = false
    internal var animationOffset: CGFloat { get { return self.frame.height * 2 } }
    
    // Mark: 用于支持编辑的变量
    /// 内部编辑状态用的数据
    internal var dynamicData: [String]!
    internal var addButtonIndex: Int { get { return dynamicData.count - 1 - deletedCells.count } }
    internal var deleteButtonIndex: Int { get { return dynamicData.count - 2 - deletedCells.count } }
    /// 记录被删除的cell，在完成按钮点击的确认删除，dismiss时清空
    internal var deletedCells: [Int] = []
    /// 记录正在移动的Cell
    internal var selectedIndex: IndexPath?
    /// 被拖动cell的SnapView，用来实现拖动动画
    internal var animationCell: UIView?
    /// 在交换的时候赋值，记录上一次被交换的cell，用于手势结束居中animationView
    internal var panEndingIndex: IndexPath!
    /// 标明拖动事件是仅仅拖动还是要删除
    internal var needDelete: Bool?
    /// 作为特殊按钮的初始所索引值，用于重置编辑状态
    internal let maxIndex = 99
    /// 外部输入数据 内部只有在编辑完成时调用以更新 初始化不会掉用willSet
    public var data: [String]! { willSet(new) { dynamicData = new } }
    public var delegate: JSPopoverMenuViewDelegate! // PopoverMenuDelegate
    
    // UI 相关常量
    internal let screenWidth = UIScreen.main.bounds.width
    internal let screenHeight = UIScreen.main.bounds.height
    internal let baseColor = UIColor.from(hex: 0xf2f2f2)
    internal let selectedTextColor = UIColor.from(hex: 0xFD8B15)
    internal let defaultTextColor = UIColor.from(hex: 0x373636)

    // State Marker
    var isCollectionViewEditing = false
    // ======
    
    init(height: CGFloat, data: [String]) {
        super.init(frame: CGRect(x: 0, y: -height*2, width: screenWidth, height: height))
        backgroundColor = baseColor
        self.data = data
        dynamicData = data
        isUserInteractionEnabled = true
        
        setupCollectionView()
        setupHeaderView()
        setupResponder()
        
        addSubview(menuCollection)
        addSubview(headerView)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    init()
}