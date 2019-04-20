echo(version=version());
echo("2019 version required.");

// faucet_spout 
//  supposed to fit this faucet: 
//  https://www.amazon.com/gp/product/B07CT4GLX1/

outer_diameter = 17.3;
inner_diameter = 15.3;
strat_length = 50;
curve_size = 120;
smoothness=300;
// have to adjust the position of the angled-opening manually


difference() {
    union() {
        // Draw the exterior tube
        rotate_extrude(angle=90, convexity=10, $fn=smoothness)
           translate([curve_size, 0]) circle(outer_diameter);
        translate([curve_size,0,0]) 
           rotate([90,0,0]) cylinder(r=outer_diameter, h=strat_length, $fn=smoothness);
    }
    color("cyan")
    union() {
        // Cut out the interior
        rotate_extrude(angle=90, convexity=10, $fn=smoothness)
            translate([curve_size, 0]) circle(inner_diameter);
        translate([curve_size,0,0]) 
            rotate([90,0,0]) cylinder(r=inner_diameter,h=strat_length+1, $fn=smoothness);
        
        // Chop the angled-opening
        translate([-2, curve_size, outer_diameter])
            rotate([0, 45, 0])
            cube(outer_diameter* 3, center=true);
    }
    
}