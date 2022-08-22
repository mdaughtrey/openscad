ViewScale = [0.0254, 0.0254, 0.0254];

models=1;
include <../models/apds9960.scad>
include <../models/pushbutton.scad>

include <sensorcarrier.scad>
include <scenclosure.scad>


module forViewing()
{
   scEnclosure();
   sensorCarrier();
}

module forPrinting()
{
    sensorCarrier();
    //scEnclosure();
}

scale(ViewScale)
{
    forViewing();
    //forPrinting();
}
