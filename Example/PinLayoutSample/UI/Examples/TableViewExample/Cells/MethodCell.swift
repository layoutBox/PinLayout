// Copyright (c) 2017, Mirego
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
// - Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
// - Neither the name of the Mirego nor the names of its contributors may
//   be used to endorse or promote products derived from this software without
//   specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

import UIKit
import PinLayout

class MethodCell: UITableViewCell {
    static let reuseIdentifier = "MethodCell"
    
    fileprivate let iconImageView = UIImageView(image: UIImage(named: "method"))
    fileprivate let nameLabel = UILabel()
    fileprivate let descriptionLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        separatorInset = .zero
        
        contentView.addSubview(iconImageView)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(nameLabel)
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.numberOfLines = 0
        contentView.addSubview(descriptionLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(method: Method) {
        nameLabel.text = method.name
        nameLabel.sizeToFit()
        
        descriptionLabel.text = method.description
        descriptionLabel.sizeToFit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    @discardableResult
    fileprivate func layout() -> CGSize {
        let margin: CGFloat = 10
        
        // 1) Layout controls
        iconImageView.pin.top().left().size(30).margin(margin)
        nameLabel.pin.right(of: iconImageView, aligned: .center).right().marginHorizontal(margin).fitSize()
        descriptionLabel.pin.below(of: [iconImageView, nameLabel]).left().right().margin(margin).fitSize()
        
        // 2) Returns a size that contains all controls
        return CGSize(width: contentView.frame.width, height: descriptionLabel.frame.maxY + margin)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        // 1) Set the contentView's width to the specified size parameter
        contentView.pin.width(size.width)

        // 2) Layout the contentView's controls
        return layout()
    }
}
