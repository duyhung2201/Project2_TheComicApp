
import UIKit

class ListVC: UIViewController {

    override func viewDidLoad() {
        
        view.addSubview(HomeViewController().view)
        
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        view.addSubview(blurredEffectView)

        let lb = UILabel(frame: CGRect(x: SCREEN_WIDTH/3, y: SCREEN_HEIGHT/3, width: 50, height: 20))
        lb.backgroundColor = .red
        
        view.addSubview(lb)
    }


}
