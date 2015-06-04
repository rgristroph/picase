//based on http://www.thingiverse.com/thing:47270
//adapted for model B+

width = 60.5;
length = 90.0;
//thickness = 2;
thickness = 1.2;

total_height = 28;

// Raspberry PI
*translate([43.4+thickness,28.5+thickness,6.5]) {
	import("../RaspberryPi_B.stl");
}

// ----- Modules -----//

// Base box
module basebox() {
	difference() {
		//cube([length+(thickness*2),(width+(thickness*2))-2.5,14]);
		cube([length+(thickness*2),(width+(thickness*2)-2.5), total_height / 2 ]);
		translate ([thickness, thickness, thickness]) {
			cube([length,width-2.5, total_height]);
		}
	}
}
//basebox();

// Top box
module topbox() {
	translate([0,0,14]) {
		difference() {
			cube([length+(thickness*2),(width+(thickness*2))-2.5, total_height/2]);
			
			translate ([thickness, thickness, -thickness]) {
				cube([length,width-2.5,14]);
			}
		}
	}
}


// Hole - Digital
module digital() { //<-- moved for B+
  translate ([57,-0.1,10]) { //pos=70
    union() {
      rotate([-90,90,0]) cylinder(h=3,r=4.5, $fn=25);
      translate([-4.5,0,0]) cube([9,9,9]);
    }
  }
}


// Hole - HDMI
module hdmi() {
  translate ([27,-1,10.5]) {
    hull(){
      cube([16,4,4]);
      translate([3,0,-3]) cube([10,4,1]);
    }
  }
}

// Hole - Ethernet
module ethernet() {
  union() {
    translate ([length,5,11.0]) cube([5,14,9.5]);
    translate ([length,8.0,9.7]) cube([5,7,2]);
    translate ([length,9.0,8.5]) cube([5,5,2]);
  }
}


// Hole - USB
module usb() {
//	translate ([length,26.6,17.5]) cube([5,1.25 * 25.4, 0.6 * 25.4]);
//	translate ([length,26.6,8.8]) cube([5,13.1,5.5]);
//	translate ([length,44,17.5]) cube([5,13.1,5.5]); //<-- added for B+
//	translate ([length,44,8.8]) cube([5,13.1,5.5]); //<-- added for B+

   translate ([length,24.1,8.8]) cube([5,1.35 * 25.4, 0.6 * 25.4]);
}


// Hole - Power
module power() { //<-- rotated and repositioned for B+
	rotate([0,0,90]){ 
		hull() {
			translate ([-1,-17,9]) cube([4,7.9,2]);
			translate ([-1,-16,8]) cube([4,5.9,.2]);
		}
	}	
}
//power();
// Hole - SD Card
module sdcard() {
	translate ([-1,24,3]) cube([8,14,3.5]); //<-- changed for B+ sd -> microsd (28->14)
}



// Ventilation
module vents() {
  cube([2,10,10]);
  translate([6,0,0]) cube([2,10,10]);
  translate([12,0,0]) cube([2,10,10]);
  translate([18,0,0]) cube([2,10,10]);
}

// Hole - GPIO
module gpio() {
  translate([0.3*25.4,width - thickness - 0.3*25.4,21])cube([2.0*25.4, 0.2 * 25.4, 0.3 * 25.4]);
}

// Hole - Camera cable exit
module camera() {
  translate( [2.0*25.4, 0.1*25.4, 21]) cube([0.05* 25.4, 0.65 * 25.4 , 0.3 * 25.4]);
}

// Camera mounting tab
module camtab() {
  difference() {
    cube( [(0.15 * 25.4) + (thickness * 2), (25.4 * 1.1) + (thickness*2), 25.4 * 1 ]); // outer 
    translate([thickness,thickness,thickness]) cube( [ 0.15 * 25.4, 25.4 * 1.1, 25.4 * 1 ]); // inner pocket
    translate( [0 , (0.38*25.4) + thickness, (0.4 * 25.4) + thickness]) cube( [thickness*2, .35 * 25.4, .6 * 25.4] );
  } 
}


// Mounting tabs
// Two 1/8 in holes 2 inches apart (matches holes on the side of the Prusa I3v)
// Attaches to the bottom on the GPIO pin side
module mounttab() {
  difference() {
    cube([2.5 * 25.4, 0.5 * 25.4, thickness]);
    translate([0.25*25.4, 0.25*25.4, 0]) cylinder(h=thickness, r=(0.0625 * 25.4), $fn=25);
    translate([2.25*25.4, 0.25*25.4, 0]) cylinder(h=thickness, r=(0.0625 * 25.4), $fn=25);
  }
}

// Elements //

difference() {
  union() {
    difference() {
			basebox();
			ethernet();
			
     }
    // These are the standoffs that hold up the circuit board
    translate ([thickness, width - thickness - 2, thickness]) cube([20,2,4]);
    translate ([thickness,thickness,thickness]) cube([20,2,4]);
    translate ([66, width - thickness - 2, 2]) cube([20,2,4]);
    translate ([59,thickness,2]) cube([20,2,4]);

    translate ([ 0.5 * 25.4, width - thickness, 0 ]) mounttab();
    translate ([ -((0.15*25.4)+(2*thickness)), -7.5, 0]) camtab(); 
  }

	digital();
	hdmi();
	usb();
	power();
	sdcard();

}

difference() {
	union() {
		difference() {
			topbox();
			ethernet();
		}
	translate ([63,thickness, total_height - thickness - 17 ]) cube([20,2,17]);
	//translate ([18,2,9]) cube([20,2,17]);
	translate ([64,width - thickness - 2,11]) cube([20,2,17]);
	translate ([18,width - thickness - 2,11]) cube([20,2,15]);
	translate ([thickness,20,9]) cube([2,20,17]);
	}

	//digital();
	//hdmi();
	usb();
   gpio();
   camera();
	translate([5,-1,19]) vents();
	translate([67,53,19]) vents();
}
