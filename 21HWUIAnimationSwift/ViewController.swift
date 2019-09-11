//
//  ViewController.swift
//  21HWUIAnimationSwift
//
//  Created by Сергей on 29/08/2019.
//  Copyright © 2019 Sergei. All rights reserved.
//

//Вот и добрались до интересного! Надо немного поиграться чтобы усвоить материал :)
//
//✅Ученик.
//
//1. Создайте 4 вьюхи у левого края ипада.
//2. Ваша задача всех передвинуть горизонтально по прямой за одно и тоже время
//3. Для каждой вьюхи используйте свою интерполяцию (EasyInOut, EasyIn и т.д.). Это для того, чтобы вы увидели разницу своими собственными глазами :)
//4. Добавте реверсивную анимацию и бесконечные повторения
//5. добавьте смену цвета на рандомный
//
//✅Студент
//
//5. Добавьте еще четыре квадратные вьюхи по углам - красную, желтую, зеленую и синюю
//6. За одинаковое время и при одинаковой интерполяции двигайте их всех случайно, либо по, либо против часовой стрелки в другой угол.
//7. Когда анимация закончиться повторите все опять: выберите направление и передвиньте всех :)
//8. Вьюха должна принимать в новом углу цвет той вьюхи, что была здесь до него ;)
//
//Мастер
//
//8. Нарисуйте несколько анимационных картинок человечка, который ходит.
//9. Добавьте несколько человечков на эту композицию и заставьте их ходить
//
//Супермена на этот раз нет, ничего сверхъестественного не смог придумать :(

import UIKit

let fTwo: CGFloat = 2.0

class ViewController: UIViewController {

    //MARK: Propertys
    @IBOutlet weak var buttonCounterclockwise: UIButton!
    @IBOutlet weak var buttonClockWise: UIButton!
    @IBOutlet var views: [UIView]!
    private var viewFrames = [CGRect]()
    private var imageViewCenterPoints = [CGPoint]()
    private var colors = [UIColor]()
    private var imageViewHumWalk = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 150.0, height: 150.0))
    private var imagesHumWalk = [UIImage]()
    private var rotate: CGFloat = .pi / 2.0
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        self.buttonClockWise.layer.cornerRadius = 20.0
        self.buttonCounterclockwise.layer.cornerRadius = 20.0
        
        //self.imageViewCenterPoints = self.calculateCenterPointsByAngles(fromRect: self.view.bounds, forRect: imageViewHumWalk1.frame)
        self.imageViewCenterPoints = self.calculateCenterPointsByAngles(fromRect: self.view.bounds, forRect: imageViewHumWalk.frame)
        
        imageViewHumWalk.transform = CGAffineTransform(rotationAngle: CGFloat.pi / fTwo)
      
        self.imagesHumWalk.append(UIImage(named: "imagesHumanWalk/1humanWalk.png")!)
        self.imagesHumWalk.append(UIImage(named: "imagesHumanWalk/2humanWalk.png")!)
        self.imagesHumWalk.append(UIImage(named: "imagesHumanWalk/3humanWalk.png")!)
        self.imagesHumWalk.append(UIImage(named: "imagesHumanWalk/4humanWalk.png")!)
        self.imagesHumWalk.append(UIImage(named: "imagesHumanWalk/5humanWalk.png")!)
        self.imagesHumWalk.append(UIImage(named: "imagesHumanWalk/6humanWalk.png")!)
        self.imagesHumWalk.append(UIImage(named: "imagesHumanWalk/7humanWalk.png")!)
        
        self.imageViewHumWalk.animationImages = self.imagesHumWalk
        self.imageViewHumWalk.animationDuration = 1.5
        
        self.view.addSubview(self.imageViewHumWalk)
    
        //from each view get frame and color and append in array
        for v in self.views {
            
            self.viewFrames.append(v.frame)
            self.colors.append(v.backgroundColor ?? .red)
            
        }
        
    }
    
    //in this method move views clockwise and change their color
    @IBAction func moveViewsClockwise(_ sender: UIButton) {
        
        //first element became last
        self.viewFrames = self.firstElementBecameLast(for: self.viewFrames) as! [CGRect]
        self.colors = self.firstElementBecameLast(for: self.colors) as! [UIColor]
        //self.imageViewCenterPoints = self.firstElementBecameLast(for: self.imageViewCenterPoints) as! [CGPoint]
        
        //each element assign value following  clockwise
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseInOut, animations: {
            
            for i in 0..<self.views.count {
                
                self.views[i].frame = self.viewFrames[i]
                self.views[i].backgroundColor = self.colors[i]
                self.views[i].transform = CGAffineTransform(rotationAngle: self.rotate) //rotate
                
            }
            
        }) { (finished) in
            ///
        }
        
        self.rotate += CGFloat.pi
        
    }
   
    //in this method move views counter clockwise and change their color
    @IBAction func moveViewsCounterClockwise(_ sender: UIButton) {
        
        self.imageViewHumWalk.startAnimating()
        
        self.rotate += -(CGFloat.pi / 2.0)
    
        //last element became first
        self.viewFrames = self.lastElementBecameFirst(for: self.viewFrames) as! [CGRect]
        self.colors = self.lastElementBecameFirst(for: self.colors) as! [UIColor]
        self.imageViewCenterPoints = self.lastElementBecameFirst(for: self.imageViewCenterPoints) as! [CGPoint]
        
        //each element assign value following  clockwise
        UIView.animate(withDuration: 1.5, delay: 0.0, options: .curveEaseInOut, animations: {
            
            for i in 0..<self.views.count {
                self.views[i].frame = self.viewFrames[i]
                self.views[i].backgroundColor = self.colors[i]
                self.views[i].transform = CGAffineTransform(rotationAngle: self.rotate /*-(self.rotate * 0.999)*/)
            }
            
            let deadLine = DispatchTime.now() + .seconds(10)
            DispatchQueue.main.asyncAfter(deadline: deadLine) {
                //self.imageViewHumWalk1.transform = CGAffineTransform(rotationAngle: self.rotate /*CGFloat.pi * 0.0*/)
                self.imageViewHumWalk.transform = CGAffineTransform(rotationAngle: self.rotate /*CGFloat.pi * 0.0*/)
                self.imageViewHumWalk.stopAnimating()
            }
            
        }) { (finished) in
            ///
        }
        
        UIView.animate(withDuration: 10.0, delay: 0, options: .beginFromCurrentState, animations: {
            
            //self.imageViewHumWalk1.center = self.imageViewCenterPoints[0]
            self.imageViewHumWalk.center = self.imageViewCenterPoints[0]
            
        }) { (finished) in
            ///
        }
        
        
    }
    
    //MARK: Help function
   /*
    //in function create four views and add animate for their
    func createViewAndAnimate(frame: CGRect) {
        
        
        let transformAll = CGAffineTransform(translationX: self.view.bounds.width - frame.width, y: 24.0)
        let animationOptions = [UIView.AnimationOptions.curveEaseInOut, .curveEaseIn, .curveEaseOut, .curveLinear]
        
        for i in 0...3 {
            let view = UIView(frame: frame)
            view.backgroundColor = self.randomColor()
            self.view.addSubview(view)
            
            UIView.animate(withDuration: 3.0, delay: 0.0, options: [animationOptions[i], .repeat, .autoreverse],
                           animations: {
                            view.transform = transformAll
                            
            }) { (finished) in
                ///
            }
        }
    }
 */
    
    private func moveView(view: UIView) {
    
    //here installed random values for animation view
        let rect = self.view.bounds;
    rect.insetBy(dx: view.frame.width, dy: view.frame.height)
    let x = CGFloat(Int(arc4random()) % Int(rect.width));
    let y = CGFloat(Int(arc4random()) % Int(rect.height));
    //let s = CGFloat((arc4random() % 151)) / 100 + 0.5;
    //let s1 = CGFloat(arc4random() % 2) - 1;
    
    //let r = CGFloat(Int(arc4random()) % Int((CGFloat.pi * 2 * 10000))) / 10000 - CGFloat.pi;
    
    let d = CGFloat((arc4random() % 20001)) / 10000 + 2;
    
    //CGFloat cornerR = (float)(arc4random() % 50);
    
        UIView.animate(withDuration: TimeInterval(d), delay: 0, options: .curveEaseIn, animations: {
            view.center = CGPoint(x: x, y: y)
            let scale = CGAffineTransform(scaleX: 1, y: 1) //CGAffineTransformMakeScale(1, 1);
            //let rotate = CGAffineTransform(rotationAngle: r)
            view.transform = scale
        }) { (finished) in
            print("finished flag = \(finished)")
            print("\nview frame = \(NSCoder.string(for: view.frame)), \nview bounds = \(NSCoder.string(for: view.bounds))")
            weak var v = view
            self.moveView(view: v ?? view)
        }
        
      
        
        
    //this is function create random color
    
    }
    
    func randomColor() -> UIColor {
        
        let r = randomNumberFromZeroToOne()
        let g = randomNumberFromZeroToOne()
        let b = randomNumberFromZeroToOne()
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
        
    }
    
    func randomNumberFromZeroToOne() -> CGFloat {
        
        let randNumber = CGFloat.random(in: 0...1)
        return randNumber
        
    }
    
    //calculate center points by angles
    private func calculateCenterPointsByAngles(fromRect: CGRect, forRect: CGRect) -> [CGPoint] {
        
        let leftTopAngleCenter     = CGPoint(x: forRect.maxX / fTwo,
                                             y: forRect.maxY / fTwo)
        let leftBottomAngleCenter  = CGPoint(x: forRect.maxX / fTwo,
                                             y: fromRect.maxY - (forRect.height / fTwo))
        let rightBottomAngleCenter = CGPoint(x: fromRect.maxX - (forRect.width / fTwo),
                                             y: fromRect.maxY - (forRect.height / fTwo))
        let rightTopAngleCenter    = CGPoint(x: fromRect.maxX - (forRect.width / fTwo),
                                             y: forRect.height / fTwo)
        
        return [leftTopAngleCenter, rightTopAngleCenter, rightBottomAngleCenter, leftBottomAngleCenter]
    }
    
    //first element became last
    private func firstElementBecameLast(for array: [Any]) -> [Any] {
        
        var resultArray = array
        
        let firstElement = resultArray.removeFirst()
        resultArray.append(firstElement)
        
        return resultArray
        
    }
    
    //last element became first
    private func lastElementBecameFirst(for array: [Any]) -> [Any] {
        
        var resultArray = array
        
        let lastElement = resultArray.removeLast()
        resultArray.insert(lastElement, at: 0)
        
        return resultArray
        
    }
    
    private func movesAroundThePerimeter(into superView: UIView, subView: UIView) {
        
        let centerCornerPoints = calculateCenterPointsByAngles(fromRect: superView.bounds, forRect: subView.frame)
        var secondIncrement = 0
        
        for i in 0...centerCornerPoints.count - 1 {
            
            let deadLine = DispatchTime.now() + .seconds(secondIncrement)
           
            DispatchQueue.main.asyncAfter(deadline: deadLine) {
                UIView.animateKeyframes(withDuration: 2, delay: 0, options: .beginFromCurrentState , animations: {
                    subView.center = centerCornerPoints[i]
                }, completion: { (finished) in
                    ///
                })
            }
            secondIncrement += 2
        }
        
    }

}
