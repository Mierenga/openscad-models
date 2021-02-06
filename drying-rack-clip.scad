




center=false;
trunk_height=55;
trunk_thickness=10;
support_thickness=4;
base_span=36;
width=18;
pocket_offset=17;


difference() {
  union() {
      
      fillet(r=5,steps=5) {
          translate([0, 4.5, 0])
    cube([trunk_height, 1, width], center);
//    translate([trunk_height - support_thickness, 0, 0])
//      cube([support_thickness, base_span, width], center);
      }
          
//    translate([trunk_height, pocket_offset, 0])
//      cube([16, support_thickness, width], center);
//      
    
      
    translate([6, 6, width/2])
//      cylinder(width, 10, 10, false);
      sphere(12);
      
//    fillet(r=2,steps=1) {
    scale([1, 1.5, 1])  
    translate([trunk_height, 12, width/2])
      //cylinder(width, 10, 10, false);
      sphere(14);
//    }
  }
  
  difference() {
  translate([2, -1, -10])
      cube([8, 7+1, width+20], center);
      
      fillet(r=0.8, steps=5) {
      translate([1.1,-0.4,0])
      cube([0.5, 0.5, width], center);
      }
      
  }
  
  translate([-10, -10, -10])
      cube([40, 10, width+20], center);
  
  translate([trunk_height, pocket_offset + support_thickness, -10])
      cube([20, 20, width+20], center);
  
  
}


// Fillet function

module fillet(r=1.0,steps=3,include=true) {
  if(include) for (k=[0:$children-1]) {
	children(k);
  }
  for (i=[0:$children-2] ) {
    for(j=[i+1:$children-1] ) {
	fillet_two(r=r,steps=steps) {
	  children(i);
	  children(j);
	  intersection() {
		children(i);
		children(j);
	  }
	}
    }
  }
}

module fillet_two(r=1.0,steps=3) {
  for(step=[1:steps]) {
	hull() {
	  render() intersection() {
		children(0);
		offset_3d(r=r*step/steps) children(2);
	  }
	  render() intersection() {
		children(1);
		offset_3d(r=r*(steps-step+1)/steps) children(2);
	  }
	}
  }
}

module offset_3d(r=1.0) {
  for(k=[0:$children-1]) minkowski() {
	children(k);
	sphere(r=r,$fn=8);
  }
}

//fillet(r=2,steps=5) {
//	cylinder(r=5,h=10);
//	cube([10,10,2]);
//	rotate([30,30,30]) cylinder(r=1.0,h=50,center=true);
//}