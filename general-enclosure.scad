

// Try make this an integer multiple of the extruder diameter.
wall_thickness=1.0;

// Produces the basic shell, a box with the inner dimensions and a
// wall thickness added on.
module basic_box() {
  // By using center=true we avoid having to translate by the wall thickness.
  difference() {
    cube([10,20,30],center=true);
    cube([10 - wall_thickness,20 - wall_thickness,30 - wall_thickness],center=true);
  }
}

module access_hole() {
  cylinder(r=2,h=30,center=true, $fn=25);
}


// This displays the whole shell with all holes an ports, tabs, etc
module mainbox() {
  difference() {
    basic_box();
    access_hole();
  }
}

mainbox();