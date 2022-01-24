/* [Basics] */

// Welcher Teil soll ausgegeben werden
Ausgabe="beides"; //[beides,nur Deckel,nur Sockel]

// Platine anzeigen (bitte nicht mitdrucken)
Platine_anzeigen="ja"; // [ja,nein]

// mm Spiel zwischen Unterteil und Oberteil
Spiel=0.25; //[0:0.05:3]

//Zusaetzlicher Raum unter der Platine in mm
Raum_Unten=0; // [0:1:20]

//Raum oberhalb der Steckerleiste auf der Hauptplatine in mm (nur Zwischenplatine: 18mm, mit BME280: 21mm, mit SCD41: 26mm
Raum_Oben=26; // [0:0.5:100]

//Raum seitlich von der Zwischenplatine
Raum_Daneben=2; // [0:0.5:50]

/* [Wandbefestigung] */
// Durchmesser der Wandbefestigungsloecher in mm
Wandbefestigungsloch=4; // [0:0.1:10]




/* [USB-Stecker] */
// Soll ein Loch fuer den USB-Stecker gelassen werden?
Stecker="ja"; //[ja,nein]
USB_Steckerbreite=12; // [0:0.1:20]
USB_Steckerhoehe=7;   // [0:0.1:20]

/* [KNX-Kabel] */
// Loch fuer Kabel oder KNX-Stecker
Kabeltyp="Kabel"; // [Kabel,Stecker]


// Position
Kabelposition="Boden hinten"; //[keins,Rueckseite,Boden vorne,Boden hinten,Links,Rechts,Vorderseite]

// Ausrichtung
Kabelausrichtung="Links"; //[Links,Rechts,Mitte]

// Durchmesser des Kabelloches in mm
Kabeldicke=6.5; // [0:0.1:20]

// Abmessungen KNX-Stecker
KNX_Stecker_Breite=13; // [0:0.1:20]
KNX_Stecker_Hoehe=11;  // [0:0.1:20]

/* [Deckelverschraubung] */
// Durchmesser des Loches der Deckelverschraubung im festen Teil
Bohrloch=3; // [0:0.1:10]

// Durchmesser des Loches im Deckel
Deckelloch=4; // [0:0.1:10]

/* [Lueftungsschlitze] */
Anzahl_Schlitze=6; // [0:1:20]


/* [Hidden] */

PlatineBreite=40.5;
PlatineTiefe=40;
PlatineHoehe=1.5;

wandstaerke=3;
gesamtHoehe=28+Raum_Unten+Raum_Oben;

rilleHoehe=PlatineHoehe;
rilleTiefe=1;

AusschnittHoeheOben=4;
AusschnittHoeheUnten=5;

untereHoehe = 14+Raum_Unten;
ueberhang = Raum_Daneben + rilleTiefe +4;

gesamtTiefe=PlatineTiefe+2*wandstaerke;
gesamtBreite = 2*(wandstaerke+ueberhang-rilleTiefe) + PlatineBreite;


USB_Rechts=wandstaerke+ueberhang-rilleTiefe+32;
USB_Oben=wandstaerke+untereHoehe-PlatineHoehe;


difference(){
    union(){
    if (Ausgabe == "nur Deckel") {
		Deckel();
	} else if (Ausgabe == "nur Sockel") {
		Sockel();
	} else {
		Sockel();
        Deckel();
	}}

    Kabelauslass();
}

if(Platine_anzeigen=="ja") Platine();
    

module Platine()
{
        translate([wandstaerke+ueberhang-rilleTiefe,0,untereHoehe+wandstaerke])
    {
        color("green")
            cube([PlatineBreite,PlatineTiefe,PlatineHoehe]);
        color("grey")
            translate([7.2,7.2,-10.5])
            cylinder(10.5 , d=10.2, center=false,$fn=20);
        color("grey")
            translate([32-7.5/2,0,-3])
            cube([7.5,5,3]);
        
        translate([19,12,PlatineHoehe]){
            color("black")
            cube([5,10.5,12.5]);
            translate([-22,-6,12.5]){
                color("green")
                cube([45.5,22.4,PlatineHoehe]);
               
                
                color("black")
                translate([40,3,6])
                rotate([-90,0,0])
                cylinder(21.5,d=8.2,center=false);
                
                color("black")
                translate([24.5,3,7])
                rotate([-90,0,0])
                cylinder(13,d=10,center=false);

                color("black")
                translate([7,19,PlatineHoehe])
                cylinder(10,d=12,center=false);

                
                translate([2,2,PlatineHoehe])
                {
                    color("black")
                    cube([2.4,10.5,11.5]);

                    translate([12.5,0,0])
                    color("black")
                    cube([2.4,10.5,11.5]);
                    
                    translate([28,2,0])
                    color("black")
                    cube([2.4,13.6,11.5]);
                    
                    translate([0,0,11.5]){
                    color("green")
                    cube([15,11.6,PlatineHoehe]);
                    
                    translate([28,4.5,0])
                    color("green")
                    cube([13.2,10.5,PlatineHoehe]);
    
                    translate([3.5,1.8,PlatineHoehe]) 
                    color("gray")
                    cube([8,8,6.5]);
                        
                    }
                }
                
                }
                
            
            
        }
}}

module Kabelauslass() {
    Kabeldrehung=(Kabelposition=="Rueckseite" || Kabelposition=="Vorderseite" ) ? [90,0,0] : (Kabelposition=="Rechts" || Kabelposition=="Links" )? [90,0,90] : [0,0,0];    
        

    if (Kabelposition=="Rueckseite"){
        translate([(Kabelausrichtung=="Links")? wandstaerke+ueberhang+Kabeldicke/2:(Kabelausrichtung=="Rechts")?gesamtBreite-wandstaerke-ueberhang-Kabeldicke/2:gesamtBreite/2,gesamtTiefe-wandstaerke+1,0])
        rotate([90,0,0])
        Kabel();
    }
    
    if (Kabelposition=="Vorderseite"){
        translate([(Kabelausrichtung=="Links")? wandstaerke+ueberhang+Kabeldicke/2:(Kabelausrichtung=="Rechts")?gesamtBreite-wandstaerke-ueberhang-Kabeldicke/2:gesamtBreite/2,0,0])
        rotate([90,0,0])
        Kabel();
    }
    
    if (Kabelposition=="Rechts"){
        translate([gesamtBreite-wandstaerke-ueberhang-1,(Kabelausrichtung=="Links")? wandstaerke+Kabeldicke/2:(Kabelausrichtung=="Rechts")?gesamtTiefe-2*wandstaerke-Kabeldicke/2:(gesamtTiefe-wandstaerke)/2,0])
        rotate([90,0,90])
        Kabel();
    }
    
    if (Kabelposition=="Links"){
        translate([-1,(Kabelausrichtung=="Links")? wandstaerke+Kabeldicke/2:(Kabelausrichtung=="Rechts")?gesamtTiefe-2*wandstaerke-Kabeldicke/2:(gesamtTiefe-wandstaerke)/2,0])
        rotate([90,0,90])
        Kabel();
    }
    
    if (Kabelposition=="Boden vorne"){
        translate([(Kabelausrichtung=="Links")? wandstaerke+ueberhang+Kabeldicke/2:(Kabelausrichtung=="Rechts")?gesamtBreite-wandstaerke-ueberhang-Kabeldicke/2:gesamtBreite/2,0,-1])
        Kabel();
    }
    
    if (Kabelposition=="Boden hinten"){
        translate([(Kabelausrichtung=="Links")? wandstaerke+ueberhang+Kabeldicke/2:(Kabelausrichtung=="Rechts")?gesamtBreite-wandstaerke-ueberhang-Kabeldicke/2:gesamtBreite/2,gesamtTiefe-3*wandstaerke-((Kabeltyp=="Stecker")?KNX_Stecker_Hoehe:Kabeldicke),-1])
        Kabel();
    }
} 

module Kabel() {
    
    if (Kabeltyp=="Stecker")
    {
        translate([-KNX_Stecker_Breite/2,wandstaerke,0])    
        cube([KNX_Stecker_Breite,KNX_Stecker_Hoehe,ueberhang+wandstaerke+2]);
    }
        
    else {
        translate([0,Kabeldicke/2+wandstaerke,0])
        cylinder( ueberhang+wandstaerke+2 , d=Kabeldicke, center=false,$fn=20);
        if (Kabelposition=="Vorderseite"){
            translate([-Kabeldicke/2,0,0])
            cube([Kabeldicke,Kabeldicke/2+wandstaerke,wandstaerke+2]);   
        }
    }
}

////// Teil 1
module Sockel() {
difference(){
cube([gesamtBreite,gesamtTiefe-wandstaerke,gesamtHoehe]);
    // unterer Kasten
translate([ueberhang+wandstaerke,-1,wandstaerke]) 
    cube([gesamtBreite-2*(wandstaerke+ueberhang),gesamtTiefe-2*wandstaerke+1,gesamtHoehe-wandstaerke+1]);
    
    // oberer Kasten
    translate([wandstaerke,-1,wandstaerke+untereHoehe+2*PlatineHoehe]) 
        cube([gesamtBreite-2*wandstaerke,gesamtTiefe-2*wandstaerke+1,gesamtHoehe-wandstaerke-untereHoehe-2*PlatineHoehe+1]);
    
    
    
    // Ausschnitt Platine
translate([wandstaerke+ueberhang-rilleTiefe,-1,untereHoehe+wandstaerke]) 
    cube([PlatineBreite,gesamtTiefe-2*wandstaerke+1,PlatineHoehe]);

   
    // Wand-Befestigungsloecher
    translate([3*wandstaerke+ueberhang,gesamtTiefe/4,-1])
    cylinder( wandstaerke+2 , d=Wandbefestigungsloch, center=false,$fn=10);

    translate([gesamtBreite-(wandstaerke+ueberhang+2.5*Wandbefestigungsloch),(gesamtTiefe-wandstaerke)*3/4,-1])
    cylinder( wandstaerke+2 , d=Wandbefestigungsloch, center=false,$fn=10);

    // Deckel
    
    translate([wandstaerke/2,-wandstaerke/2,gesamtHoehe-wandstaerke/2])
    cube([gesamtBreite-wandstaerke,gesamtTiefe-wandstaerke,wandstaerke/2+1]);
    
    // Deckelloch
    translate([(wandstaerke+ueberhang)/2,-1,wandstaerke+untereHoehe/2])
    rotate([-90,0,0])
    cylinder( 20 , d=Bohrloch, center=false,$fn=10);
    
    translate([(gesamtBreite-(wandstaerke+ueberhang)/2),-1,wandstaerke+untereHoehe/2])
    rotate([-90,0,0])
    cylinder( 20 , d=Bohrloch, center=false,$fn=10);
    
}
}


module Deckel () {

// Lueftungsschlitze
Schlitzbreite = (gesamtBreite-2*wandstaerke)/(2*Anzahl_Schlitze+1);

// Deckel
translate([0,-1,0])
difference(){
union(){
translate([0,-wandstaerke,Spiel])
cube([gesamtBreite,wandstaerke,gesamtHoehe-Spiel]);


    translate([wandstaerke/2+Spiel,-wandstaerke/2,gesamtHoehe-wandstaerke/2+Spiel])
    cube([gesamtBreite-wandstaerke-2*Spiel,gesamtTiefe-wandstaerke,wandstaerke/2-Spiel]);

    translate([wandstaerke+Spiel,-wandstaerke/2,gesamtHoehe-wandstaerke])
    cube([gesamtBreite-2*wandstaerke-2*Spiel,gesamtTiefe-2*wandstaerke,wandstaerke/2+Spiel]);
    
    translate([wandstaerke+Spiel,0,gesamtHoehe-wandstaerke-gesamtTiefe/3])
    cube([Schlitzbreite,gesamtTiefe/3,gesamtTiefe/3]);
    
    translate([gesamtBreite-(wandstaerke+Spiel+Schlitzbreite),0,gesamtHoehe-wandstaerke-gesamtTiefe/3])
    cube([Schlitzbreite,gesamtTiefe/3,gesamtTiefe/3]);
}


// Bohrloecher
translate([(wandstaerke+ueberhang)/2,1,wandstaerke+untereHoehe/2])
    rotate([90,0,0])
    cylinder( 20 , d=Deckelloch, center=false,$fn=10);
    
    translate([(gesamtBreite-(wandstaerke+ueberhang)/2),1,wandstaerke+untereHoehe/2])
    rotate([90,0,0])
    cylinder( 20 , d=Deckelloch, center=false,$fn=10);


// Stecker
    translate([USB_Rechts-USB_Steckerbreite/2,wandstaerke*-1-1,USB_Oben-USB_Steckerhoehe/2])
    cube([USB_Steckerbreite,wandstaerke+2,USB_Steckerhoehe]);


// Schlitze
for (n =[0:Anzahl_Schlitze-1])
{
    translate([wandstaerke+(n*2+1)*Schlitzbreite,1,gesamtHoehe-wandstaerke-1])
    cube([Schlitzbreite,gesamtTiefe-4*wandstaerke,wandstaerke+2]);}


// Abrundung
translate([-1,gesamtTiefe/3,gesamtHoehe-wandstaerke-gesamtTiefe/3])
rotate([0,90,0])
cylinder(gesamtBreite+2, r=gesamtTiefe/3,$fn=10);
}}