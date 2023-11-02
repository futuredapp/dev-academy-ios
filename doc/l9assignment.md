# Lekce 9: Zadání

Lokační služby


## Úkol 1: User Location Service
Motivace: Potřebujeme vytvořit třídu, která bude zaobalovat komunikaci s API pro Polohové služby. Tato service musí mluvit s managerem pomocí patternu *delegate*, ale sama poskytuje API s closure.

 1. V adresáři `Services` vytvořme soubor `UserLocationService.swift` pro novou `UserLocationService`.
 2. Využijte template (viz níže)
 3. Tuto service přidejte na všechny nutná místa (viz předchozí lekce - přidání `PlaceService`)
 4. Tuto service přidejte do `PlacesObservableObjectu`.
 5. Implementujte jednotlivé funkce service: 
 	- Projděte si dokumentaci [CLLocationManager](https://developer.apple.com/documentation/corelocation/cllocationmanager) a implementujte následující funkce:
 	- Konstruktor vytvoří instanci CLLocationManager a uloží ji do proměnné `manager`. Nastavte delegáta na `self`.
 	- Funkce `requestAuthoriation` požádá manager o pravomoc získávat lokaci, pokud je aplikace **na popředí**.
 	- Funkce `listenDidUpdateLocation` nastaví novou closure pro naslouchání na změnu lokace
 	- Funkce `listenDidUpdateStatus` nastaví novou closure pro naslouchání na změnu stavu autorizace
 	- Funkce `stopUpdatingLocation` vypne získávání polohy
 	- Funkce `startUpdatingLocation` zapne získávání polohy
 	- Funkce v delegátu `locationManagerDidChangeAuthorization` do odpovídajícího handleru pošle nový stav autorizace
 	- Funkce v delegátu `locationManager(_:didUpdateLocations:)` do odpovídajícího handleru pošle aktuální polohu 

## Úkol 2: Příprava na nasazení:
Motivace: Před tím, než můžeme začít používat naše nové API si musíme ještě připravit nějaké věci.

1. V souboru `Point.swift` vytvořte `extension` nad typem `Point`. Tato `extension` bude obsahovat *computed property* `var cllocation: CLLocation`, která z `Point` vytvoří `CLLocation`. (Budete muset importovat `CoreLocation`).
2. iOS vyžaduje odůvodnění, proč chcete používat polohu. Toto odůvodnění **musí** být lokalizované a v Apple jej kontrolují! Otevřete soubor `Info.plist` a přidejte nový klíč `NSLocationWhenInUseUsageDescription` a odpovídající slovní popis.

## Úkol 3: Implementace řazení podle polohy
Motivace: Nyní můžeme implementovat ve třídě `PlacesObservableObject` řazení polohy.

1. Přidejte novou proměnnou `private var lastUpdatedLocation: CLLocation?` - zde budete ukládat poslední bod, podle kterého byla místa seřazena.
2. Do funkce `updatePlaces` přidejte novou funkcionalitu. Pokud je proměnná `lastUpdatedLocation ` ne-nil, seřaďte místa podle vzdálenosti. Použijte na pole `regularPlaces` funkci `sort`
3. Přidejte funkci `beginLocationUpdates`, která zapne aktualizaci polohy na service.
4. Přidejte funkci `func shouldUpdate(location: CLLocation) -> Bool`. Tato funkce vrátí `true`, pokud je **první prvek v poli** v argumentu `location` vzdálen od `lastUpdatedLocation` více, než je (vámi zvolená) vzdálenost. Pokud je `lastUpdatedLocation` nil, vrátí automaticky `true`.
5. V konstruktoru Observable Objectu nastavte pro `locationService` handler `listenDidUpdateLocation`. Pokud funkce `self.shouldUpdate(location:)` vrátí `true`, aktualizujte `lastUpdatedLocation` a zavolejte `updatePlaces()`.
6. V konstruktoru Observable Object nastavte pro `locationService` handler `listenDidUpdateStatus`. 
  - Pokud je status `notDetermined`, zavolejte na `locationService` funkci `requestAuthorization()`
  - Pokud je status `authorizedWhenInUse` nebo `authorizedAlways`, započněte získávání polohy
  - Jinak nedělejte nic 

 
---
 
Template pro service

```swift
import Combine
import CoreLocation

protocol UserLocationService {    
    func startUpdatingLocation()
    func stopUpdatingLocation()
    func requestAuthorization()

    func listenDidUpdateLocation(handler: @escaping ([CLLocation]) -> Void)
    func listenDidUpdateStatus(handler: @escaping (CLAuthorizationStatus) -> Void)
}

final class ProductionUserLocationService: NSObject, UserLocationService {

    private let manager: CLLocationManager
    private var stateChangeHandler: ((CLAuthorizationStatus) -> Void)?
    private var locationChangeHandler: (([CLLocation]) -> Void)?
   
    override init() {
        // TODO
    }

    func requestAuthorization() {
        // TODO
    }

    func listenDidUpdateLocation(handler: @escaping ([CLLocation]) -> Void) {
        // TODO
    }


    func stopUpdatingLocation() {
        // TODO
    }

    func startUpdatingLocation() {
        // TODO
    }

    func listenDidUpdateStatus(handler: @escaping (CLAuthorizationStatus) -> Void) {
        // TODO
    }
}

extension ProductionUserLocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // TODO
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // TODO
    }
}

final class MockLocationService: UserLocationService {
    func startUpdatingLocation() { /* nop */ }
    func stopUpdatingLocation() { /* nop */ }
    func listenDidUpdateLocation(handler: @escaping ([CLLocation]) -> Void) { /* nop */ }
    func requestAuthorization() { /* nop */ }
    func listenDidUpdateStatus(handler: @escaping (CLAuthorizationStatus) -> Void) { /* nop */ }
}
```