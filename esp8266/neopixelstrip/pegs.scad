ViewScale = [0.0254, 0.0254, 0.0254];

PegTx=896.25;
PegTy=347.75;

module peg()
{
//    linear_extrude(100)
//    circle(140/2, $fn=96);
//    translate([0, 0, 99])
    linear_extrude(200)
    circle(100/2, $fn=96);
}

//scale(ViewScale)
module pegs()
{
    translate([PegTx, PegTy, 0]) peg();
    translate([-PegTx, PegTy, 0]) peg();
    translate([PegTx, -PegTy, 0]) peg();
    translate([-PegTx, -PegTy, 0]) peg();
}