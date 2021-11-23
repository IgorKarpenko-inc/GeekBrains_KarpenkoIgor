// 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.

// 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).

// 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.

// 4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.

// 5. Создать несколько объектов каждого класса. Применить к ним различные действия.

// 6. Вывести сами объекты в консоль.



import Foundation


enum Windows {
    case open
    case close
}

enum Engine {
    case start
    case stop
}

protocol Car: AnyObject {
    var model: String { get }
    var releaseYear: Int { get }
    var windowsStatus: Windows { get set }
    var engineStatus: Engine { get set }
}

extension Car {
    func switchWindows (status: Windows) {
        switch status {
        case .open:
            print("У автомобиля \(model) окна открыты")
            self.windowsStatus = .open
        case .close:
            print("У автомобиля \(model) окна закрыт")
            self.windowsStatus = .close
        }
    }
    
    func switchEngine (status: Engine) {
        switch status {
        case .start:
            print("Двигателья атомобиля \(model) запущен")
            self.engineStatus = .start
        case .stop:
            print("Двигателья атомобиля \(model) заглушен")
            self.engineStatus = .stop
        }
    }
}

protocol TrunkCar: Car {
    var trunkVolume: Int { get }
    var trunkSpace: Int { get }
    var cargoVolume: Int { get set }
}

extension TrunkCar {
    func receiptOfCargo(volume: Int) {
        if trunkSpace >= volume {
            print("Объём полученого груза \(model) = \(volume) кг")
            self.cargoVolume += 1
        } else {
            print("В автомобиле \(model) недостаточно месят для \(volume) кг груза")
        }
    }
    
    func removeCargo(volume: Int) {
        if self.trunkVolume >= volume {
            print("Из автомобиля \(model) удалено \(volume) кг груза")
            self.cargoVolume -= volume
        } else {
            print("Неверная команда!")
        }
    }
}

protocol SportCar: Car {
    var maxSpeed: Int { get }
    var actualSpeed: Int { get set }
}

extension SportCar {
   
        func increaseSpeed (speed: Int) {
            if speed + actualSpeed <= maxSpeed {
            print("текщая скорость \(model) = \(speed)")
            self.actualSpeed += speed
            } else {
            print("\(model) достигнута максимальная скорость \(maxSpeed)" )
            }
        
        func reduceCar (speed: Int) {
            if self.actualSpeed >= speed {
                print("Автомобиль \(model) замедляетс]")
                self.actualSpeed -= speed
            } else {
                print("\(model) остаовился ")
                self.actualSpeed = 0
            }
        }
    }
}
    
    class TrunkCarClass: TrunkCar {
        var model: String
        var releaseYear: Int
        var windowsStatus: Windows
        var engineStatus: Engine
        var trunkVolume: Int
        var cargoVolume: Int
        var trunkSpace: Int {
            get {
                return trunkVolume - cargoVolume
            }
        }
        init(model: String, releaseYear: Int, trunkVolume: Int) {
            self.trunkVolume = trunkVolume
            self.cargoVolume = 0
            self.model = model
            self.releaseYear = releaseYear
            self.windowsStatus = .close
            self.engineStatus = .stop
        }
    }

class SportCarClass: SportCar {
    let maxSpeed: Int
    var actualSpeed: Int
    var model: String
    var releaseYear: Int
    var windowsStatus: Windows
    var engineStatus: Engine
    
    init(model: String, releaseYear: Int, maxSpeed: Int) {
        self.maxSpeed = maxSpeed
        self.actualSpeed = 0
        self.model = model
        self.releaseYear = releaseYear
        self.windowsStatus = .open
        self.engineStatus = .start
    }
}

extension TrunkCarClass: CustomStringConvertible {
    var description: String {
         return """
                Автомобиль: \(model)
                Год выпуска: \(releaseYear)
                Статус окон: \(windowsStatus)
                Статус двигателя: \(engineStatus)
                Грузоподъёмность: \(trunkVolume)
                Загружен: \(cargoVolume)
        """
    }
}

extension SportCarClass: CustomStringConvertible {
    var description: String {
        return """
               Автомобиль: \(model)
               Год выпуска: \(releaseYear)
               Статус окон: \(windowsStatus)
               Статус двигателя: \(engineStatus)
               Максимальная скорость: \(maxSpeed)
               Текущая скорость: \(actualSpeed)
        """
    }
}

var sportCarOne = SportCarClass(model: "Tesla 3", releaseYear: 2019, maxSpeed: 320)
var trunkCarOne = TrunkCarClass(model: "Ford Transit", releaseYear: 2015, trunkVolume: 240)
var trunkCarTwo = TrunkCarClass(model: "Sprinter", releaseYear: 2011, trunkVolume: 210)

sportCarOne.engineStatus = .start

print(sportCarOne)
print(trunkCarOne)
print(trunkCarTwo)
