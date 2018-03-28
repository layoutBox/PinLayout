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
//
// Created by Luc Dion on 2017-10-31.

import UIKit
import PinLayout

class HouseCell: UICollectionViewCell {
    static let reuseIdentifier = "HouseCell"
    
    fileprivate let headerView = UIView()
    fileprivate let nameLabel = UILabel()
    fileprivate let mainImage = UIImageView()
    
    fileprivate let footerView = UIView()
    fileprivate let priceLabel = UILabel()
    fileprivate let distanceLabel = UILabel()
    
    fileprivate let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
    
        // HEADER
        headerView.backgroundColor = .pinLayoutColor
        contentView.addSubview(headerView)
        
        nameLabel.font = UIFont.systemFont(ofSize: 24)
        nameLabel.textColor = .white
        headerView.addSubview(nameLabel)

        /// IMAGE
        mainImage.backgroundColor = .black
        mainImage.contentMode = .scaleAspectFill
        mainImage.clipsToBounds = true
        contentView.addSubview(mainImage)
        
        // FOOTER
        footerView.backgroundColor = UIColor.pinLayoutColor.withAlphaComponent(0.2)
        contentView.addSubview(footerView)
        
        footerView.addSubview(priceLabel)

        distanceLabel.textAlignment = .right
        footerView.addSubview(distanceLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(house: House) {
        nameLabel.text = house.name
        priceLabel.text = house.price
        distanceLabel.text = "\(house.distance) KM"
        distanceLabel.textAlignment = .right

        mainImage.download(url: house.mainImageURL)
        mainImage.contentMode = .scaleAspectFill
        
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        headerView.pin.top().horizontally(pin.safeArea).height(100)
        nameLabel.pin.top().horizontally().margin(padding).sizeToFit(.width)
        
        mainImage.pin.below(of: nameLabel).horizontally(pin.safeArea).height(300).marginTop(padding)
        
        footerView.pin.below(of: mainImage).horizontally(pin.safeArea)
        priceLabel.pin.top().horizontally().margin(6, padding).sizeToFit(.width)
        distanceLabel.pin.top().after(of: priceLabel).right().margin(6, padding).sizeToFit(.width)
        footerView.pin.height(max(priceLabel.frame.maxY, distanceLabel.frame.maxY) + 6)
        
        contentView.pin.height(footerView.frame.maxY)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        layout()
        return contentView.frame.size
    }
}
