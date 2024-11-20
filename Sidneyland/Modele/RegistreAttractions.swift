//
//  RegistreAttractions.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 15/09/2024.
//

import Foundation


class RegistreAttractions {
    static func attractions() -> [Attraction] {
        var attractions: [Attraction] = []
        
        
        // MARK: Main Street
        
        let gareMainstreet = Attraction(
            id: "P1MA01",
            nom: "Gare Main Street",
            image: "Main Street Station",
            parc: .disneyland,
            univers: .mainStreet
        )
        attractions.append(gareMainstreet)
        
        
        
        
        
        // MARK: Frontierland
        
        let btm = Attraction(
            id: "P1RA00",
            nom: "Big Thunder Mountain",
            image: "BTM",
            parc: .disneyland,
            univers: .frontierland
        )
        attractions.append(btm)
        
        let phantomManor = Attraction(
            id: "P1RA03",
            nom: "Phantom Manor",
            image: "Phantom Manor",
            parc: .disneyland,
            univers: .frontierland
        )
        attractions.append(phantomManor)
        
        let riverboatLanding = Attraction(
            id: "P1RA06",
            nom: "Thunder Mesa Riverboat Landing",
            nomCourt: "Riverboat Landing",
            image: "TMRL",
            parc: .disneyland,
            univers: .frontierland
        )
        attractions.append(riverboatLanding)
        
        let gareFrontierland = Attraction(
            id: "P1RA10",
            nom: "Disneyland Railroad Frontierland Depot",
            nomCourt: "Gare Frontierland",
            image: "Frontierland Depot",
            parc: .disneyland,
            univers: .frontierland
        )
        attractions.append(gareFrontierland)
        
        
        
        
        
        // MARK: Adventureland
        
        let adventureIsle = Attraction(
            id: "P1AA00",
            nom: "Adventure Isle",
            image: "Adventure Isle",
            parc: .disneyland,
            univers: .adventureland
        )
        attractions.append(adventureIsle)
        
        let cabaneDesRobinson = Attraction(
            id: "P1AA01",
            nom: "Cabane des Robinson",
            image: "Cabane Robinson",
            parc: .disneyland,
            univers: .adventureland
        )
        attractions.append(cabaneDesRobinson)
        
        let indianaJones = Attraction(
            id: "P1AA02",
            nom: "Indiana Jones",
            image: "Indiana Jones",
            parc: .disneyland,
            univers: .adventureland
        )
        attractions.append(indianaJones)
        
        let passageAladdin = Attraction(
            id: "P1AA03",
            nom: "Le Passage Enchanté d'Aladdin",
            nomCourt: "Passage d'Aladdin",
            image: "Passage Aladdin",
            parc: .disneyland,
            univers: .adventureland
        )
        attractions.append(passageAladdin)
        
        let pirateOfTheCaribbean = Attraction(
            id: "P1AA04",
            nom: "Pirate des Caraïbes",
            image: "Pirates des Caraibes",
            parc: .disneyland,
            univers: .adventureland
        )
        attractions.append(pirateOfTheCaribbean)
        
        
        
        
        
        // MARK: Fantasyland
        
        let labyrintheAlice = Attraction(
            id: "P1NA00",
            nom: "Alice's Curious Labyrinth",
            nomCourt: "Labyrinthe d'Alice",
            image: "Labyrinthe Alice",
            parc: .disneyland,
            univers: .fantasyland
        )
        attractions.append(labyrintheAlice)
        
        let blancheNeige = Attraction(
            id: "P1NA01",
            nom: "Blanche-Neige et les Sept Nains",
            nomCourt: "Blanche-Neige",
            image: "Blanche Neige",
            parc: .disneyland,
            univers: .fantasyland
        )
        attractions.append(blancheNeige)
        
        let lancelot = Attraction(
            id: "P1NA02",
            nom: "Le Carrousel de Lancelot",
            nomCourt: "Carrousel Lancelot",
            image: "Carrousel Lancelot",
            parc: .disneyland,
            univers: .fantasyland
        )
        attractions.append(lancelot)
        
        let caseyJR = Attraction(
            id: "P1NA03",
            nom: "Casey Jr. - Le Petit Train du Cirque",
            nomCourt: "Casey Jr.",
            image: "Casey JR",
            parc: .disneyland,
            univers: .fantasyland
        )
        attractions.append(caseyJR)
        
        let chateau = Attraction(
            id: "P1NA04",
            nom: "Le Château de la Belle au Bois Dormant",
            nomCourt: "Le Château",
            image: "Chateau",
            parc: .disneyland,
            univers: .fantasyland
        )
        attractions.append(chateau)
        
        let dumbo = Attraction(
            id: "P1NA05",
            nom: "Dumbo",
            image: "Dumbo",
            parc: .disneyland,
            univers: .fantasyland
        )
        attractions.append(dumbo)
        
        let itsASmallWorld = Attraction(
            id: "P1NA07",
            nom: "It's a Small World",
            image: "Maison Poupees",
            parc: .disneyland,
            univers: .fantasyland
        )
        attractions.append(itsASmallWorld)
        
        let lesTasses = Attraction(
            id: "P1NA08",
            nom: "Mad Hatter's Tea Cups",
            nomCourt: "Les Tasses",
            image: "Les Tasses",
            parc: .disneyland,
            univers: .fantasyland
        )
        attractions.append(lesTasses)
        
        let leContesDeFées = Attraction(
            id: "P1NA09",
            nom: "Le Pays des Contes de Fées",
            nomCourt: "Les Contes de Fées",
            image: "Contes de Fees",
            parc: .disneyland,
            univers: .fantasyland
        )
        attractions.append(leContesDeFées)
        
        let peterPan = Attraction(
            id: "P1NA10",
            nom: "Peter Pan's Flight",
            image: "Peter Pan",
            parc: .disneyland,
            univers: .fantasyland
        )
        attractions.append(peterPan)
        
        let dragon = Attraction(
            id: "P1NA12",
            nom: "La Tanière du Dragon",
            image: "Dragon",
            parc: .disneyland,
            univers: .fantasyland
        )
        attractions.append(dragon)
        
        let pinocchio = Attraction(
            id: "P1NA13",
            nom: "Les Voyages de Pinocchio",
            nomCourt: "Pinocchio",
            image: "Pinocchio",
            parc: .disneyland,
            univers: .fantasyland
        )
        attractions.append(pinocchio)
        
        let gareFantasyland = Attraction(
            id: "P1NA16",
            nom: "Disneyland Railroad Fantasyland Station",
            nomCourt: "Gare Fantasyland",
            image: "Gare Fantasyland",
            parc: .disneyland,
            univers: .fantasyland
        )
        attractions.append(gareFantasyland)
        
        
        
        
        
        // MARK: Discoveryland
        
        let autopia = Attraction(
            id: "P1DA03",
            nom: "Autopia",
            image: "Autopia",
            parc: .disneyland,
            univers: .discoveryland
        )
        attractions.append(autopia)
        
        let buzzEclair = Attraction(
            id: "P1DA04",
            nom: "Buzz l'Eclair",
            image: "Buzz Eclair",
            parc: .disneyland,
            univers: .discoveryland
        )
        attractions.append(buzzEclair)
        
        let nautilus = Attraction(
            id: "P1DA06",
            nom: "Les Mystères du Nautilus",
            nomCourt: "Le Nautilus",
            image: "Nautilus",
            parc: .disneyland,
            univers: .discoveryland
        )
        attractions.append(nautilus)
        
        let orbitron = Attraction(
            id: "P1DA07",
            nom: "Orbitron",
            image: "Orbitron",
            parc: .disneyland,
            univers: .discoveryland
        )
        attractions.append(orbitron)
        
        let spaceMountain = Attraction(
            id: "P1DA08",
            nom: "Space Mountain",
            image: "Space Mountain",
            parc: .disneyland,
            univers: .discoveryland
        )
        attractions.append(spaceMountain)
        
        let starTour = Attraction(
            id: "P1DA09",
            nom: "Star Tours",
            image: "Star Tours",
            parc: .disneyland,
            univers: .discoveryland
        )
        attractions.append(starTour)
        
        let gareDiscoveryland = Attraction(
            id: "P1DA10",
            nom: "Disneyland Railroad Discoveryland Station",
            nomCourt: "Gare Dicoveryland",
            image: "Gare Discoveryland",
            parc: .disneyland,
            univers: .discoveryland
        )
        attractions.append(gareDiscoveryland)
        
        
        
        
        
        // MARK: Disney Studio
        
        let hth = Attraction(
            id: "P2ZA02",
            nom: "Hollywood Tower Hotel",
            image: "HTH",
            parc: .studio,
            univers: .productionCourtyard
        )
        attractions.append(hth)
        
        let flightForce = Attraction(
            id: "P2AC01",
            nom: "Flight Force",
            image: "Flight Force",
            parc: .studio,
            univers: .marvelAvengersCampus
        )
        attractions.append(flightForce)
        
        let spiderMan = Attraction(
            id: "P2AC02",
            nom: "Spider-Man WEB Adventure",
            nomCourt: "Spider-Man",
            image: "Spider Man",
            parc: .studio,
            univers: .marvelAvengersCampus
        )
        attractions.append(spiderMan)
        
        let crushCoaster = Attraction(
            id: "P2XA03",
            nom: "Crush's Coaster",
            image: "Crush Coaster",
            parc: .studio,
            univers: .worldsOfPixar
        )
        attractions.append(crushCoaster)
        
        let ratatouille = Attraction(
            id: "P2XA09",
            nom: "Ratatouille",
            image: "Ratatouille",
            parc: .studio,
            univers: .worldsOfPixar
        )
        attractions.append(ratatouille)
        
        let rcRacer = Attraction(
            id: "P2XA06",
            nom: "RC Racer",
            image: "RC Racer",
            parc: .studio,
            univers: .worldsOfPixar
        )
        attractions.append(rcRacer)
        
        let slinkyDog = Attraction(
            id: "P2XA08",
            nom: "Slinky Dog Zigzag Spin",
            nomCourt: "Slinky Dog",
            image: "Slinky Dog",
            parc: .studio,
            univers: .worldsOfPixar
        )
        attractions.append(slinkyDog)
        
        let soldiersParachute = Attraction(
            id: "P2XA07",
            nom: "Toy Soldiers Parachute Drop",
            nomCourt: "Soldiers Parachute",
            image: "Soldiers Parachute",
            parc: .studio,
            univers: .worldsOfPixar
        )
        attractions.append(soldiersParachute)
        
        let carsRoadTrip = Attraction(
            id: "P2XA00",
            nom: "Cars ROAD TRIP",
            image: "Cars Road Trip",
            parc: .studio,
            univers: .worldsOfPixar
        )
        attractions.append(carsRoadTrip)
        
        
        
        
        return attractions
    }
}  
        
        
